using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Providers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class GuiaNegocioController : BaseViewController
    {
        private readonly GuiaNegocioProvider _guiaNegocioProvider;

        public GuiaNegocioController()
        {
            _guiaNegocioProvider = new GuiaNegocioProvider();
        }

        public ActionResult Index()
        {
            try
            {
                if (_guiaNegocioProvider.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                {
                    return GNDViewLanding();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "GuiaNegocioController.Index");
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }
    }
}