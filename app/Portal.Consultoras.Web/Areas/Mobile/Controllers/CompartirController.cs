using System.Web.Mvc;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Controllers;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CompartirController : BaseController
    {
        public ActionResult CompartirEnChatBot(string campania, string tipoCatalogo, string url)
        {
            var model = new CatalogoCompartirModel()
            {
                Campania = campania,
                TipoCatalogo = tipoCatalogo,
                UrlCatalogo = url
            };

            return View("~/Areas/Mobile/Views/Compartir/CompartirEnChatBot.cshtml", model);
        }
    }
}
