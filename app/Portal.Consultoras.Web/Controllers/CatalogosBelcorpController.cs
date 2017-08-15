using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class CatalogosBelcorpController : BaseController
    {
        MisCatalogosRevistasModel CatalogosRevistas = new MisCatalogosRevistasModel();

        public ActionResult Index()
        {

            return View();
        }

        /// <summary>
        /// Devuelve los catálogos de la campaña actual, anterior y siguiente.
        /// </summary>
        /// <returns></returns>
        public JsonResult GetDetalleCatalogos()
        {
            int nroCampanias = -1;
            String CampaniaActiva = String.Empty;

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                nroCampanias = sv.GetPaisNumeroCampaniasByPaisID(userData.PaisID);
            }
            if (nroCampanias == -1) return Json(new { success = false, message = "Ocurrió un error al intentar cargar las imágenes del CUV" }, JsonRequestBehavior.AllowGet);

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                CampaniaActiva = sv.GetCampaniaActivaPais(userData.PaisID, DateTime.Now).AnoCampana;
            }
            userData.NroCampanias = nroCampanias;

            CatalogosRevistas.PaisNombre = getPaisNombreByISO(userData.CodigoISO);
            CatalogosRevistas.CampaniaActual = CampaniaActiva;
            CatalogosRevistas.CampaniaAnterior = AddCampaniaAndNumero(Convert.ToInt32(CampaniaActiva), -1).ToString();
            CatalogosRevistas.CampaniaSiguiente = AddCampaniaAndNumero(Convert.ToInt32(CampaniaActiva), 1).ToString();

            CatalogosRevistas.CodigoRevistaActual = GetRevistaCodigoIssuu(CatalogosRevistas.CampaniaActual);
            CatalogosRevistas.CodigoRevistaAnterior = GetRevistaCodigoIssuu(CatalogosRevistas.CampaniaAnterior);
            CatalogosRevistas.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(CatalogosRevistas.CampaniaSiguiente);

            List<Catalogo> CatalogosAnteriores = this.GetCatalogosPublicados(userData.CodigoISO, CatalogosRevistas.CampaniaAnterior);
            List<Catalogo> CatalogosActuales = this.GetCatalogosPublicados(userData.CodigoISO, CatalogosRevistas.CampaniaActual);
            List<Catalogo> CatalogosSiguientes = this.GetCatalogosPublicados(userData.CodigoISO, CatalogosRevistas.CampaniaSiguiente);

            var data = new
            {
                campaniaActual = CatalogosRevistas.CampaniaActual,
                campaniaAnterior = CatalogosRevistas.CampaniaAnterior,
                campaniaSiguiente = CatalogosRevistas.CampaniaSiguiente,
                catalogosAnteriores = CatalogosAnteriores,
                catalogosActuales = CatalogosActuales,
                catalogosSiguientes = CatalogosSiguientes
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Obtener los catalogos por campaña odernados por: LBel, Esika y Cyzone
        /// </summary>
        /// <param name="paisISO"></param>
        /// <param name="campaniaId"></param>
        /// <returns></returns>
        public List<Catalogo> GetCatalogosPublicados(string paisISO, string campaniaId)
        {
            List<Catalogo> catalogos = new List<Catalogo>();
            string urlISSUUSearch = "http://search.issuu.com/api/2_0/document?username=somosbelcorp&q=";
            string urlISSUUVisor = ConfigurationManager.AppSettings["UrlIssuu"];
            List<String> preferences = new List<String> { "LBel", "Esika", "Cyzone" };

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

                    if (docName == catalogoLbel) catalogos.Add(new Catalogo { AnoCampana = campaniaId.Substring(4, 2), IdMarcaCatalogo = Constantes.Marca.LBel, marcaCatalogo = "LBel", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoEsika) catalogos.Add(new Catalogo { AnoCampana = campaniaId.Substring(4, 2), IdMarcaCatalogo = Constantes.Marca.Esika, marcaCatalogo = "Esika", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoCyzone) catalogos.Add(new Catalogo { AnoCampana = campaniaId.Substring(4, 2), IdMarcaCatalogo = Constantes.Marca.Cyzone, marcaCatalogo = "Cyzone", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoFinart) catalogos.Add(new Catalogo { AnoCampana = campaniaId.Substring(4, 2), IdMarcaCatalogo = Constantes.Marca.Finart, marcaCatalogo = "Finart", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                }
            }
            catch (Exception) { catalogos = new List<Catalogo>(); }            
            return catalogos.OrderBy(i => preferences.IndexOf(i.marcaCatalogo)).ToList();
        }
              
    }
}
