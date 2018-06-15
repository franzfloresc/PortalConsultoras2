using Portal.Consultoras.Common;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertaLiquidacionController : BaseMobileController
    {
        public ActionResult Index()
        {
            var userData = UserData();
            if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                return RedirectToAction("Index", "Bienvenida");
            
            return View();
        }
    }
}
