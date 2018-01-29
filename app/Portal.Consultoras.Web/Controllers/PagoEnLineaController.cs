using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceODS;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Text;
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

        public ActionResult SeleccionTipoPago()
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

        public ActionResult PagoEnLinea()
        {
            return View();
        }        
    }
}