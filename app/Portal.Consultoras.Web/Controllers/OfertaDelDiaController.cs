using System;
using System.Web.Mvc;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertaDelDiaController : BaseController
    {

        public JsonResult GetOfertaDelDia()
        {
            try
            {
                bool persistenciaTd = false;

                if (this.IsMobile() && !EsControladorOrigen(Constantes.Controlador.Pedido))
                {
                    persistenciaTd = true;
                }

                var oddModel = _ofertaDelDiaProvider.GetOfertaDelDiaConfiguracion(userData, persistenciaTd);

                if (oddModel != null)
                {
                    oddModel.ListaOferta = _ofertaPersonalizadaProvider.RevisarCamposParaMostrar(oddModel.ListaOferta);
                }

                return Json(new
                {
                    success = oddModel != null,
                    data = oddModel
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private bool EsControladorOrigen(string controlador)
        {
            bool result = false;
            string[] segmentos = HttpContext.Request.UrlReferrer.Segments;
            foreach (string item in segmentos)
            {
                if (item.Contains(controlador + "/"))
                {
                    result = true;
                    break;
                }
            }
            return result;
        }

    }
}