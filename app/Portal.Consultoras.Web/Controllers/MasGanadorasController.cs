using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class MasGanadorasController : BaseViewController
    {
        public MasGanadorasController()
        {
        }                                       
        // GET: MasGanadoras
        public ActionResult Index()
        {
            var sessionMg = SessionManager.MasGanadoras.GetModel();
            if (sessionMg.TieneLanding)
                return MasGanadorasViewLanding();
            else
                return RedirectToAction("Index", "Ofertas");
        }
    }
}