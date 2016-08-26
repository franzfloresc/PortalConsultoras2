using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertaLiquidacionController : BaseMobileController
    {
        public ActionResult Index()
        {
            var userData = UserData();
            ViewBag.Simbolo = userData.Simbolo;
            return View();
        }
    }
}
