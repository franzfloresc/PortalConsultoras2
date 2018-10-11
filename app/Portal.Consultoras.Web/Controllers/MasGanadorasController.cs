using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.SessionManager;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class MasGanadorasController : BaseViewController
    {
        ISessionManager sessionManager;
        public MasGanadorasController()
        {
            sessionManager = new SessionManager.SessionManager();
        }                                       
        // GET: MasGanadoras
        public ActionResult Index()
        {
            var sessionMg = sessionManager.MasGanadoras.GetModel();
            if (sessionMg.TieneLanding)
                return MasGanadorasViewLanding();
            else
                return RedirectToAction("Index", "Ofertas");
        }
    }
}