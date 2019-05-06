using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class MasGanadorasController : BaseViewController
    {
        public MasGanadorasController()
        {
        }

        public ActionResult Index()
        {
            try
            {
                var sessionMg = SessionManager.MasGanadoras.GetModel();
                if (sessionMg.TieneLanding && revistaDigital.EsActiva)
                    return MasGanadorasViewLanding();
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "Mobile.Controllers.MasGanadorasController.Index");
            }
            return RedirectToAction("Index", "Ofertas");
        }
    }
}