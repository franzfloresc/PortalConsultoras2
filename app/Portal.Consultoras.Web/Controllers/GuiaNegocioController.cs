using Portal.Consultoras.Web.Providers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class GuiaNegocioController : BaseGuiaNegocioController
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
                    return ViewLanding();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "GuiaNegocioController.Index");
            }

            return RedirectToAction("Index", "Bienvenida");
        }

    }
}