using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class DetalleEstrategiaController : BaseController
    {

        public ActionResult Ficha()
        {
            return View("Ficha");
        }

    }
}