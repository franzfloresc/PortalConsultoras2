using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceAsesoraOnline;
using System;
using System.Configuration;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MiPerfilController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CambiarContrasenia()
        {
            return View();
        }

        public ActionResult ActualizarCorreo()
        {
            return View();
        }

        public ActionResult ActualizarCelular()
        {
            return View();
        }
    }
}