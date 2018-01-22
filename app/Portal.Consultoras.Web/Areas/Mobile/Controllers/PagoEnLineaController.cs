using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PagoEnLineaController : BaseMobileController
    {

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ConfirmacionPago()
        {
            return View();
        }

        public ActionResult PagoExitoso()
        {
            return View();
        }

        public ActionResult PagoRechazado()
        {
            return View();
        }

    }
}