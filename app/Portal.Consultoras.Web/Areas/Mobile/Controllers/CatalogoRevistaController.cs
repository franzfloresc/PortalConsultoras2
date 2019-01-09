using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoRevistaController : Controller
    {
        private const string CodigoISO = "BR";
        private const string paisNombre = "brasil";

        public ActionResult Index(string ID = "")
        {

            string scampaniaAnterior;
            string scampaniaActual;
            string scampaniaSiguiente;

            if (ID != "")
            {
                var vcampania = ID.Split('|');
                if (vcampania.Length != 3)
                    return RedirectToAction("Index", "Login", new { area = "" });

                scampaniaAnterior = vcampania[0];
                scampaniaActual = vcampania[1];
                scampaniaSiguiente = vcampania[2];
            }
            else
            {
                return RedirectToAction("Index", "Login", new { area = "" });
            }


            var clienteModel = new MisCatalogosRevistasModel
            {
                PaisNombre = CodigoISO,
                CampaniaActual = scampaniaActual,
                CampaniaAnterior = scampaniaAnterior,
                CampaniaSiguiente = scampaniaSiguiente
            };
            clienteModel.CodigoRevistaActual = GetRevistaCodigoIssuu(clienteModel.CampaniaActual);
            clienteModel.CodigoRevistaAnterior = GetRevistaCodigoIssuu(clienteModel.CampaniaAnterior);
            clienteModel.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(clienteModel.CampaniaSiguiente);
            var esMobile = Request.Browser.IsMobileDevice;
            if (esMobile)
            {
                clienteModel.NombreClasefb = "btnfbMobile";
                clienteModel.NombreClasews = "btnwspMobile";
            }
            else
            {
                clienteModel.NombreClasefb = "btnfbDesktop";
                clienteModel.NombreClasews = "btnwspDesktop";
            }

            ViewBag.CodigoISO = CodigoISO;
            ViewBag.EsConsultoraNueva = true;

            string paisesCatalogoWhatsUp = ConfigurationManager.AppSettings.Get("PaisesCatalogoWhatsUp") ?? string.Empty;
            ViewBag.ActivacionAppCatalogoWhastUp = paisesCatalogoWhatsUp.Contains(CodigoISO) ? 1 : 0;
            ViewBag.PaisAnalytics = CodigoISO;

            return View(clienteModel);
        }

        public ActionResult EnterateMas()
        {
            return View("EnterateMas");
        }

        public ActionResult MiRevista2()
        {
            return View();
        }

        public JsonResult Detalle(int campania)
        {
            List<Catalogo> listCatalogo = this.GetCatalogosPublicados(CodigoISO, campania.ToString());

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

        public List<Catalogo> GetCatalogosPublicados(string paisIso, string campaniaId)
        {
            List<Catalogo> catalogos = new List<Catalogo>();
            string urlIssuuSearch = "http:" + Constantes.CatalogoUrlIssu.Buscador;
            string urlIssuuVisor = ConfigurationManager.AppSettings["UrlIssuu"];

            try
            {
                string catalogoLbel = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.LBel);
                string catalogoEsika = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Esika);
                string catalogoCyzone = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Cyzone);
                string catalogoFinart = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Finart);

                var url = urlIssuuSearch +
                    "docname:" + catalogoLbel + "+OR+" +
                    "docname:" + catalogoEsika + "+OR+" +
                    "docname:" + catalogoCyzone + "+OR+" +
                    "docname:" + catalogoFinart + "&jsonCallback=?";

                string response = "";
                using (var wc = new WebClient())
                {
                    using (Stream myStream = wc.OpenRead(new Uri(url)))
                    {
                        if (myStream != null)
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

                    if (docName == catalogoLbel) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.LBel, marcaCatalogo = "LBel", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                    else if (docName == catalogoEsika) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Esika, marcaCatalogo = "Esika", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                    else if (docName == catalogoCyzone) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Cyzone, marcaCatalogo = "Cyzone", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                    else if (docName == catalogoFinart) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Finart, marcaCatalogo = "Finart", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", CodigoISO + " - " + "GetCatalogosPublicados");
                catalogos = new List<Catalogo>();
            }
            return catalogos;
        }

        private bool EsCatalogoUnificado(int campania)
        {
            string paisesCatalogoUnificado = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"] ?? "";
            if (!paisesCatalogoUnificado.Contains(CodigoISO)) return false;

            string paisUnificado = paisesCatalogoUnificado.Split(';').FirstOrDefault(pais => pais.Contains(CodigoISO));
            if (paisUnificado == null) return false;

            string[] paisCamp = paisUnificado.Split(',');
            if (paisCamp.Length < 2) return false;

            int campaniaInicio = Convert.ToInt32(paisCamp[1]);
            return campania >= campaniaInicio;
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

            string codigo = ConfigurationManager.AppSettings[nombreCatalogoConfig + "Piloto_Codigo_" + CodigoISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = ConfigurationManager.AppSettings["CodigoCatalogoIssuu"].ToString();
            return string.Format(codigo, nombreCatalogoIssuu, paisNombre, campania.Substring(4, 2), campania.Substring(0, 4));
        }

        [HttpPost]
        public JsonResult ObtenerPortadaRevista(string codigoRevista)
        {
            string url;
            var urlNotFound = Url.Content("~/Content/Images/revista_no_disponible.jpg");

            try
            {
                string stringIssuuRevista = GetStringIssuRevista(codigoRevista);
                dynamic item = new JavaScriptSerializer().Deserialize<object>(stringIssuuRevista);
                url = item["thumbnail_url"];
            }
            catch (FaultException faulException)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(faulException, "", CodigoISO + " - " + "ObtenerPortadaRevista");
                url = urlNotFound;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", CodigoISO + " - " + "ObtenerPortadaRevista");
                url = urlNotFound;
            }

            return Json(url);
        }

        private string GetStringIssuRevista(string codigoRevista)
        {
            string stringIssuuRevista;
            using (var client = new WebClient())
            {
                var urlIssuuRevista = string.Format("https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/{0}", codigoRevista);
                stringIssuuRevista = client.DownloadString(urlIssuuRevista);
            }

            return stringIssuuRevista;
        }

        public ActionResult MiRevista(string campaniaRevista)
        {
            ViewBag.Campania = campaniaRevista;
            return View();
        }

        private string GetRevistaCodigoIssuu(string campania)
        {
            string codigo = ConfigurationManager.AppSettings["RevistaPiloto_Codigo_" + CodigoISO + campania];
            if (!string.IsNullOrEmpty(codigo)) return codigo;

            codigo = ConfigurationManager.AppSettings["CodigoRevistaIssuu"].ToString();
            return string.Format(codigo, CodigoISO.ToLower(), campania.Substring(4, 2), campania.Substring(0, 4));
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
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", CodigoISO + " - " + "GetUrlRevistaIssuu");
            }

            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }
    }
}