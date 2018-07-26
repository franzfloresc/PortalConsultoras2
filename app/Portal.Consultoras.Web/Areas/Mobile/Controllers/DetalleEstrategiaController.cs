using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class DetalleEstrategiaController : BaseViewController //: BaseEstrategiaController
    {
        public override ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            return base.Ficha(palanca, campaniaId, cuv, origen);
        }
    }
}