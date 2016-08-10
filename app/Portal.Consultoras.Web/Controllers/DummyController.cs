using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class DummyController : Controller
    {
        public string Index()
        {
            return "dummy";
        }

        public ActionResult Demo()
        {
            string URLSignOut = "~/SesionExpirada.html";
            return new RedirectResult(URLSignOut);
        }
    }
}
