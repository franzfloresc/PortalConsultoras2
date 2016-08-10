using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MenuController : BaseMobileController
    {
        public ActionResult Ver(string url)
        {
            if (string.IsNullOrEmpty(url))
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var urlDomain = Util.GetUrlHost(Request);
            var model = new UrlModel { Nombre = string.Format("{0}{1}", urlDomain, url) };

            return View(model);
        }
    }
}
