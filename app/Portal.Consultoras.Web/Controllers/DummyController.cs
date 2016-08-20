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

        /* PCABRERA EPD-180 - INICIO */
        public JsonResult CheckUserSession()
        {
            int res = 0;

            // If session exists
            if (HttpContext.Session != null)
            {
                //if cookie exists and sessionid index is greater than zero
                var sessionCookie = HttpContext.Request.Headers["Cookie"];
                if ((sessionCookie != null) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0))
                {
                    // if exists UserData in Session
                    if (HttpContext.Session["UserData"] != null)
                    {
                        res = 1;
                    }
                }
            }

            return Json(new
            {
                Exists = res

            }, JsonRequestBehavior.AllowGet);
        }
        /* PCABRERA EPD-180 - FIN */
    }
}
