using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class DescargarAppController : BaseMobileController
    {
        public ActionResult Index()
        {
            ViewBag.EsPaisEsika = System.Configuration.ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO) ? "1" : "0";
            return View();
        }

    }
}