using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PagoEnLineaController : BaseController
    {
        // GET: PagoEnLinea
        public ActionResult Index()
        {
            return View();
        }
    }
}