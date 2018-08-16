using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MiAcademiaController : BaseMobileController
    {
        public ActionResult Index()
        {
            return View();
        }                

    }
}