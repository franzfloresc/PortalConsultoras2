using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Globalization;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisCatalogosRevistasBrasilController : Controller
    {
        private const string paisISO = "MX";
        private const string paisNombre = "mexico";
        private const int nroCampanias = 18;

        public ActionResult Index()
        {
            int campaniaActual = 201704;

            var clienteModel = new MisCatalogosRevistasModel();
            clienteModel.PaisNombre = paisNombre;
            clienteModel.CampaniaActual = campaniaActual.ToString();
            clienteModel.CampaniaAnterior = AddCampaniaAndNumero(campaniaActual, -1, nroCampanias).ToString();
            clienteModel.CampaniaSiguiente = AddCampaniaAndNumero(campaniaActual, 1, nroCampanias).ToString();
            clienteModel.CodigoRevistaActual = GetRevistaCodigoIssuu(clienteModel.CampaniaActual);
            clienteModel.CodigoRevistaAnterior = GetRevistaCodigoIssuu(clienteModel.CampaniaAnterior);
            clienteModel.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(clienteModel.CampaniaSiguiente);
            
            ViewBag.EsConsultoraNueva = true;
            ViewBag.PaisAnalytics = paisISO;

            return View(clienteModel);
        }

        public JsonResult Detalle(int campania)
        {
            List<Catalogo> listCatalogo = this.GetCatalogosPublicados(paisISO, campania.ToString());
            
            string estadoLbel = "0";
            string estadoEsika = "1";
            string estadoCyzone = "1";
            string estadoFinart = "0";
            string catalogoUnificado = "0";

            if (EsCatalogoUnificado(campania))
            {
                estadoEsika = "1";
                catalogoUnificado = "1";
            }

            var data = new
            {
                estadoLbel = estadoLbel,
                estadoEsika = estadoEsika,
                estadoCyzone = estadoCyzone,
                estadoFinart = estadoFinart,
                catalogoUnificado = catalogoUnificado,
                listCatalogo
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        
        public List<Catalogo> GetCatalogosPublicados(string paisISO, string campaniaId)
        {
            List<Catalogo> catalogos = new List<Catalogo>();
            string urlISSUUSearch = "http://search.issuu.com/api/2_0/document?username=somosbelcorp&q=";
            string urlISSUUVisor = ConfigurationManager.AppSettings["UrlIssuu"];

            try
            {
                string catalogoLbel = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.LBel);
                string catalogoEsika = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Esika);
                string catalogoCyzone = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Cyzone);
                string catalogoFinart = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Finart);

                var url = urlISSUUSearch +
                    "docname:" + catalogoLbel + "+OR+" +
                    "docname:" + catalogoEsika + "+OR+" +
                    "docname:" + catalogoCyzone + "+OR+" +
                    "docname:" + catalogoFinart + "&jsonCallback=?";

                string response = "";
                using (var wc = new WebClient())
                {
                    using (Stream myStream = wc.OpenRead(new Uri(url)))
                    {
                        using (StreamReader streamReader = new StreamReader(myStream))
                        {
                            response = streamReader.ReadToEnd();
                        }
                    }
                }

                if (response.Substring(0, 2) == "?(") response = response.Substring(2, response.Length - 3);
                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                var jsonReponse = javaScriptSerializer.Deserialize<dynamic>(response);

                foreach (var doc in jsonReponse["response"]["docs"])
                {
                    string docName = doc["docname"], documentId = doc["documentId"];

                    if (docName == catalogoLbel) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.LBel, marcaCatalogo = "LBel", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoEsika) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Esika, marcaCatalogo = "Esika", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoCyzone) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Cyzone, marcaCatalogo = "Cyzone", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoFinart) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Finart, marcaCatalogo = "Finart", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                }
            }
            catch (Exception) { catalogos = new List<Catalogo>(); }
            return catalogos;
        }

        public ActionResult MiRevista(string campaniaRevista)
        {
            ViewBag.Campania = campaniaRevista;
            return View();
        }

        public JsonResult GetUrlRevistaIssuu(string campania)
        {
            try
            {
                if (string.IsNullOrEmpty(campania)) return Json(new { success = false }, JsonRequestBehavior.AllowGet);

                string codigo = GetRevistaCodigoIssuu(campania);
                if (string.IsNullOrEmpty(codigo)) return Json(new { success = false }, JsonRequestBehavior.AllowGet);

                string url = ConfigurationManager.AppSettings["UrlIssuu"].ToString();
                url = string.Format(url, codigo);
                return Json(new { success = true, urlRevista = url }, JsonRequestBehavior.AllowGet);
            }
            catch { }
            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }

        #region Funciones privadas

        private string GetRevistaCodigoIssuu(string campania)
        {
            string codigo = ConfigurationManager.AppSettings["RevistaPiloto_Codigo_" + paisISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = ConfigurationManager.AppSettings["CodigoRevistaIssuu"].ToString();
            return string.Format(codigo, paisISO.ToLower(), campania.Substring(4, 2), campania.Substring(0, 4));
        }

        private string GetCatalogoCodigoIssuu(string campania, int idMarcaCatalogo)
        {
            string nombreCatalogoIssuu = null, nombreCatalogoConfig = null;
            switch (idMarcaCatalogo)
            {
                case Constantes.Marca.LBel:
                    nombreCatalogoIssuu = "lbel";
                    nombreCatalogoConfig = "Lbel";
                    break;
                case Constantes.Marca.Esika:
                    nombreCatalogoIssuu = "esika";
                    nombreCatalogoConfig = "Esika";
                    break;
                case Constantes.Marca.Cyzone:
                    nombreCatalogoIssuu = "cyzone";
                    nombreCatalogoConfig = "Cyzone";
                    break;
                case Constantes.Marca.Finart:
                    nombreCatalogoIssuu = "finart";
                    break;
            }

            string codigo = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + paisISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = ConfigurationManager.AppSettings["CodigoCatalogoIssuu"].ToString();
            return string.Format(codigo, nombreCatalogoIssuu, paisNombre, campania.Substring(4, 2), campania.Substring(0, 4));
        }

        private int AddCampaniaAndNumero(int campania, int numero, int nroCampanias)
        {
            int anioCampania = campania / 100;
            int nroCampania = campania % 100;
            int sumNroCampania = (nroCampania + numero) - 1;
            int anioCampaniaResult = anioCampania + (sumNroCampania / nroCampanias);
            int nroCampaniaResult = (sumNroCampania % nroCampanias) + 1;

            if (nroCampaniaResult < 1)
            {
                anioCampaniaResult = anioCampaniaResult - 1;
                nroCampaniaResult = nroCampaniaResult + nroCampanias;
            }
            return (anioCampaniaResult * 100) + nroCampaniaResult;
        }

        private bool EsCatalogoUnificado(int campania)
        {
            string paisesCatalogoUnificado = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"] ?? "";
            if (!paisesCatalogoUnificado.Contains(paisISO)) return false;

            string paisUnificado = paisesCatalogoUnificado.Split(';').FirstOrDefault(pais => pais.Contains(paisISO));
            if (paisUnificado == null) return false;
            
            string[] paisCamp = paisUnificado.Split(',');
            if (paisCamp.Length < 2) return false;
                        
            int campaniaInicio = Convert.ToInt32(paisCamp[1]);
            return campania >= campaniaInicio;
        }

        #endregion
    }
}
