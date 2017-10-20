using Portal.Consultoras.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class GuiaNegocioController : BaseEstrategiaController
    {
        // GET: Mobile/GuiaNegocio
        public ActionResult Index()
        {
            try
            {
                return RenderIndex();
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO,string.Empty);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public virtual ActionResult RenderIndex()
        {
            return null;
        }
    }
}