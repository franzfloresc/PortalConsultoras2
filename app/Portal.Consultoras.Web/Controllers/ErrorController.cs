using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ErrorController : BaseController
    {
        public ActionResult Index()
        {
            UsuarioModel usuario = UserData();
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, usuario.CodigoConsultora, usuario.CodigoISO);
            return View();
        }

        public ActionResult NotFound()
        {
            UsuarioModel usuario = UserData();
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, usuario.CodigoConsultora, usuario.CodigoISO);
            return View();
        }
    }
}
