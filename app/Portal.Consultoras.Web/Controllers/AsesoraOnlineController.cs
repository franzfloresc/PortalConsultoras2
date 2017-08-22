using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AsesoraOnlineController : Controller
    {
        // GET: AsesoraOnline
        public ActionResult Index()
        {
            return View();
        }

        //public JsonResult RegistrarEstrategia(RegistrarEstrategiaModel model)

        [HttpPost]
        public JsonResult EnviarFormulario()
        {
            try
            {


                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito el formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, "UserData().CodigoConsultora", "UserData().CodigoISO");
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "UserData().CodigoConsultora", "UserData().CodigoISO");
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
    }
}