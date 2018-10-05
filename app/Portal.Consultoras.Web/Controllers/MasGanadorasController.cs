using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class MasGanadorasController : BaseViewController
    {
        // GET: MasGanadoras
        public ActionResult Index()
        {
            return MasGanadorasViewLanding();
        }
    }
}