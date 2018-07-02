using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertaDelDiaController : BaseController
    {

        public JsonResult GetOfertaDelDia()
        {
            try
            {
                var oddModel = _ofertaDelDiaProvider.GetOfertaDelDiaConfiguracion(userData);// GetOfertaDelDiaModel();

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

    }
}