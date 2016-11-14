using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoPersonalizadoController : BaseMobileController
    {
        public ActionResult Index()
        {
            if (!userData.EsCatalogoPersonalizadoZonaValida)
            {
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }
            ViewBag.RutaImagenNoDisponible = ConfigurationManager.AppSettings.Get("rutaImagenNotFoundAppCatalogo");

            return View();
        }

    }
}
