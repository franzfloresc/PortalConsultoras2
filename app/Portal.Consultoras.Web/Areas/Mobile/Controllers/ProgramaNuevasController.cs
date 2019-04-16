using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class ProgramaNuevasController : BaseViewController
    {
        // GET: ProgramaNuevas
        public ActionResult Index()
        {
            ViewBag.variableEstrategia = GetVariableEstrategia();
            ViewBag.CodPalanca = _programaNuevasProvider.TieneDuoPerfecto()
                ? Constantes.ConfiguracionPais.ElecMultiple
                : Constantes.ConfiguracionPais.ProgramaNuevas;
            var model = GetLandingModel(1);

            return View(model);
        }
    }
}