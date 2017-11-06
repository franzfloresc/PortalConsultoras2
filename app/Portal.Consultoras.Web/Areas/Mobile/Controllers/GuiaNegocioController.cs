using Portal.Consultoras.Web.Controllers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class GuiaNegocioController : BaseGuiaNegocioController
    {
        public ActionResult Index()
        {
            try
            {
                if (GNDValidarAcceso())
                {
                    return ViewLanding();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO,string.Empty);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }
    }
}