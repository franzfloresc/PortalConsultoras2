using System.Web.Mvc;
using Portal.Consultoras.Web.Areas.Chatbot.Models;
using Portal.Consultoras.Web.Controllers;

namespace Portal.Consultoras.Web.Areas.Chatbot.Controllers
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

            return View("~/Areas/Chatbot/Views/Compartir/CompartirEnChatBot.cshtml", model);
        }
    }
}
