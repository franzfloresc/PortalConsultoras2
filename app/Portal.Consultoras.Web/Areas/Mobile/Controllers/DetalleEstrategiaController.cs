using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class DetalleEstrategiaController : BaseViewController
    {
        //public DetalleEstrategiaController() : base()
        //{

        //}
        //public DetalleEstrategiaController(ISessionManager sesionManager)
        //    : base(sesionManager)
        //{

        //}

        //public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager)
        //    : base(sesionManager, logManager)
        //{

        //}

        public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider)
            : base(sesionManager, logManager, ofertaPersonalizadaProvider)
        {
        }

        public override ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            return base.Ficha(palanca, campaniaId, cuv, origen);
        }
    }
}