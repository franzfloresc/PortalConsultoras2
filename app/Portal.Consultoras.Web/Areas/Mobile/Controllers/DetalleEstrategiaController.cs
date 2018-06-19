
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class DetalleEstrategiaController : BaseMobileController
    {

        public ActionResult Ficha()
        {
            return View("Ficha");
        }

    }
}