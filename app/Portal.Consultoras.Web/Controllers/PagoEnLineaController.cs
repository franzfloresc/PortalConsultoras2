using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.PagoEnLinea;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
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
            sessionManager.SetDatosPagoVisa(null);

            var model = ObtenerValoresPagoEnLinea();

            return View(model);
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

        public JsonResult GuardarDatosPago(PagoEnLineaModel model)
        {
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;

            sessionManager.SetDatosPagoVisa(model);

            return Json(new
            {
                success = true,
                message = "OK"
            });
        }

        public ActionResult PagoVisa()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea");

            model.PagoVisaModel = ObtenerValoresPagoVisa(model);

            sessionManager.SetDatosPagoVisa(model);

            return View(model);
        }

        public ActionResult PagoVisaResultado2()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea");

            try
            {
                string transactionToken = Request.Form["transactionToken"];

                bool pagoOk = ProcesarPagoVisa(ref model, transactionToken);

                if (pagoOk)
                {
                    return View("PagoExitoso", model);
                }
                else
                {
                    return View("PagoRechazado", model);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return View("PagoRechazado", model);
        }
    }
}