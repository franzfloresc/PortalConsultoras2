using Portal.Consultoras.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BuscadorController : BaseMobileController
    {
        // GET: Mobile/Buscador
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Buscador()
        {
            return PartialView("_BuscadorPartialView");
        }
    }
}