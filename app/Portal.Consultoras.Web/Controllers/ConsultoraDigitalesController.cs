using System;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultoraDigitalesController : BaseController
    {
        public ActionResult Index()
        {

            DateTime fecha = DateTime.Now;

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                ViewBag.CampaniaActiva = sv.GetCampaniaActivaPais(userData.PaisID, fecha).AnoCampana;
            }


            return View();
        }

        [HttpPost]
        public JsonResult RealizarDescarga()
        {
            try
            {
                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    DateTime theDate = DateTime.Now;
                    var fechaproceso = theDate.ToString("yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture);

                    sv.GetConsultoraDigitalesDescarga(userData.PaisID, userData.CodigoISO, fechaproceso, userData.CodigoUsuario);
                }

                return Json(new
                {
                    success = true,
                    mensaje = "El proceso de generación de consultoras digitales ha finalizado satisfactoriamente."
                });


            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
