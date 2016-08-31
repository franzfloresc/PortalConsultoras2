using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Controllers
{
    public class ErrorController : BaseController
    {
        public ActionResult Index()
        {
            // se loggea el error
            UsuarioModel usuario = UserData();
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, usuario.CodigoConsultora, usuario.CodigoISO);
            return View();
        }

        public ActionResult NotFound()
        {
            // se loggea el error
            UsuarioModel usuario = UserData();
            LogManager.LogManager.LogErrorWebServicesBus(((HandleErrorInfo)ViewData.Model).Exception, usuario.CodigoConsultora, usuario.CodigoISO);
            return View();
        }
    }
}
