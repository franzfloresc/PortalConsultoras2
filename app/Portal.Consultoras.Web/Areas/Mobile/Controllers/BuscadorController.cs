using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BuscadorController : BaseMobileController
    {
        public ActionResult Index()
        {
            var suscripcion = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            ViewBag.boolSuscrita = suscripcion;

            return View();
        }
    }
}