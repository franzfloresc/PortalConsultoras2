using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ErrorController : BaseController
    {
        public ActionResult Index()
        {
            // se loggea el error
            UsuarioModel usuario = UserData();
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, usuario.CodigoConsultora, usuario.CodigoISO);
            return View();
        }

        public ActionResult NotFound()
        {
            // se loggea el error
            UsuarioModel usuario = UserData();
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, usuario.CodigoConsultora, usuario.CodigoISO);
            return View();
        }
    }
}
