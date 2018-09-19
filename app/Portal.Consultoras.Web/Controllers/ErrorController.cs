using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ErrorController : BaseController
    {
        public ActionResult Index()
        {
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, userData.CodigoConsultora, userData.CodigoISO);
            return View();
        }

        public ActionResult NotFound()
        {
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, userData.CodigoConsultora, userData.CodigoISO);
            return View();
        }
    }
}
