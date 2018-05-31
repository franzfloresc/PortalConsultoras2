using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Configuration;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class RestableceTuContraseniaController : BaseController
    {
        public ActionResult Index()
        {
           return View();
        }
        public ActionResult VerificarAutenticidad()
        {
           return View();
        }
    }
}