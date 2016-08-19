using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Web.Helpers;
using System.Web.Script.Serialization;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class RevistaController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            var userData = UserData();
            try
            {
                using (var service = new ZonificacionServiceClient())
                {
                    ViewBag.ListaCampania = service.SelectCampanias(userData.PaisID);
                }
                
                int currentCampania;
                Int32.TryParse(userData.NombreCorto ?? String.Empty, out currentCampania);

                ViewBag.UrlImageCurrentCampania = ObtenerRutaImagen(userData.NombreCorto);                
                ViewBag.UrlFlashpaper = (Globals.UrlFlashpapersRevista ?? String.Empty).TrimEnd('/') + "/" + Util.GetPaisISO(userData.PaisID);
                ViewBag.NamePageFlashpaper = (Globals.NamePageFlashpapers ?? String.Empty);
                ViewBag.CurrentCampania = currentCampania;
                ViewBag.NroCampanias = userData.NroCampanias;
                ViewBag.CodigoISO = userData.CodigoISO;
                ViewBag.PaisID = userData.PaisID; //EPD-826
                ViewBag.CodigoZona = userData.CodigoZona; //EPD-826
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View();
        }

        [HttpPost]
        public JsonResult GetImageCampania(string campania)
        {
            var urlImagen = ObtenerRutaImagen(campania);

            return Json(new
            {
                success = false,
                imagen = urlImagen
            });
        }

        #endregion

        [HttpPost]
        public JsonResult ObtenerPortadaRevista(string codigoRevista)
        {
            var url = string.Empty;
            var urlNotFound = Url.Content("~/Content/Images/revista_no_disponible.jpg");
            try
            {
                var request = WebRequest.CreateHttp(string.Format("https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/{0}", codigoRevista));
                request.Accept = "application/json";
                request.Headers.Add(HttpRequestHeader.AcceptEncoding, "gzip,deflate,sdch");

                var json = string.Empty;
                using (var response = request.GetResponse())
                {
                    using (var reader = new StreamReader(response.GetResponseStream()))
                    {
                        json = reader.ReadToEnd();
                    }
                }
                var jsonSerializer = new JavaScriptSerializer();
                var dictionary = jsonSerializer.DeserializeObject(json) as Dictionary<string, object>;

                if (dictionary.Count > 0 && dictionary.ContainsKey("thumbnail_url"))
                {
                    url = dictionary["thumbnail_url"].ToString();
                    url = url.Replace("medium", "large");
                }
                else
                    url = urlNotFound;
            }
            catch (Exception)
            {
                url = urlNotFound;
            }
            return Json(url);
        }

        #region Metodos

        private String ObtenerRutaImagen(string campania)
        {
            var userData = UserData();
            var urlImagen = "";

            using (var service = new ContenidoServiceClient())
            {
                var contenidoRevista = service.ObtenerContenidoRevistaCampania(userData.PaisID, campania);

                if (contenidoRevista != null)
                {
                    var carpetaPais = Globals.UrlRevistaGana + "/" + UserData().CodigoISO;
                    urlImagen = ConfigS3.GetUrlFileS3(carpetaPais, contenidoRevista.RutaImagenPortada, Globals.RutaImagenesRevista);
                }
            }
            return urlImagen;
        }

        #endregion
    }
}
