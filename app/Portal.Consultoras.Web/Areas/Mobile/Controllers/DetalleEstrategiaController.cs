using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class DetalleEstrategiaController : BaseViewController
    {
        public DetalleEstrategiaController() : base()
        {

        }

        public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider, OfertaViewProvider ofertaViewProvider)
            : base(sesionManager, logManager, ofertaPersonalizadaProvider, ofertaViewProvider)
        {
        }

        public override ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            var fichaResponsiveEstaActivo = _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            userData.PaisID,
                            ConsTablaLogica.FlagFuncional.TablaLogicaId,
                            ConsTablaLogica.FlagFuncional.FichaResponsive,
                            true
                            );

            if (fichaResponsiveEstaActivo)
            {
                var urlFichaResponsive = string.Format("/Detalles/{0}/{1}/{2}/{3}", palanca, campaniaId, cuv, origen);
                return Redirect(urlFichaResponsive);
            }

            return base.Ficha(palanca, campaniaId, cuv, origen);
        }

    }
}