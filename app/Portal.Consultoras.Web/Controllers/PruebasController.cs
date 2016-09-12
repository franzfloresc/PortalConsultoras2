using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PruebasController : Controller
    {
        //
        // GET: /Pruebas/

        [AllowAnonymous]
        public ActionResult Index()
        {
            return View();
        }

    }
}
