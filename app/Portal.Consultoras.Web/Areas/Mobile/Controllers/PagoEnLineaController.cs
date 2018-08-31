﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Web.Infraestructure.Validator.PagoEnLinea;
using Portal.Consultoras.Web.Models.PagoEnLinea;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PagoEnLineaController : BaseMobileController
    {
        protected PagoEnLineaProvider _pagoEnLineaProvider;

        public PagoEnLineaController()
        {
            _pagoEnLineaProvider = new PagoEnLineaProvider();
        }

        public ActionResult Index()
        {
            if (!userData.TienePagoEnLinea)
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            sessionManager.SetDatosPagoVisa(null);

            var model = _pagoEnLineaProvider.ObtenerValoresPagoEnLinea();
            ViewBag.PagoEnLineaGastosLabel = userData.PaisID == Constantes.PaisID.Mexico ? Constantes.PagoEnLineaMensajes.GastosLabelMx : Constantes.PagoEnLineaMensajes.GastosLabelPe;

            return View(model);
        }
        
        public ActionResult MetodoPago()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            model = _pagoEnLineaProvider.ObtenerValoresMetodoPago(model);

            return View(model);
        }

        [HttpGet]
        public ActionResult PasarelaPago(string cardType, int medio = 0)
        {
            if (!userData.TienePagoEnLinea || userData.MontoDeuda <= 0)
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            var pago = sessionManager.GetDatosPagoVisa();
            if (pago.ListaMetodoPago == null)
            {
                return RedirectToAction("Index");
            }
            if (!string.IsNullOrEmpty(cardType))
            {
                var selected = _pagoEnLineaProvider.ObtenerMetodoPagoSelecccionado(pago, cardType, medio);

                if (selected == null)
                {
                    return RedirectToAction("Index");
                }
                pago.MetodoPagoSeleccionado = selected;
                sessionManager.SetDatosPagoVisa(pago);
            }
            
            if (pago.MetodoPagoSeleccionado == null)
            {
                return RedirectToAction("Index");
            }

            SetDeviceSessionId(pago);
            ViewBag.PagoLineaCampos = _pagoEnLineaProvider.ObtenerCamposRequeridos();
            ViewBag.UrlIconMedioPago = _pagoEnLineaProvider.GetUrlIconMedioPago(pago);
            CargarListsPasarela();
            var model = new PaymentInfo
            {
                Phone = userData.Celular,
                Email = userData.EMail
            };

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> PasarelaPago(PaymentInfo info)
        {
            if (!userData.TienePagoEnLinea || userData.MontoDeuda <= 0)
                return RedirectToAction("Index", "Bienvenida");

            var requiredFields = _pagoEnLineaProvider.ObtenerCamposRequeridos();
            var pago = sessionManager.GetDatosPagoVisa();

            if (ModelState.IsValid)
            {
                var expRegular = pago.MetodoPagoSeleccionado.ExpresionRegularTarjeta;
                var validator = new PasarelaValidator
                {
                    RequiredFields = requiredFields,
                    PatternCard = expRegular
                };

                if (validator.IsValid(info))
                {
                    var provider = new PagoPayuProvider
                    {
                        User = userData,
                        SessionId = Session.SessionID,
                        IpClient = GetIPCliente(),
                        Agent = Request.UserAgent,
                        PagoProvider = _pagoEnLineaProvider
                    };

                    var success = await provider.Pay(info, pago);
                    if (!success) 
                        return View("PagoRechazado", pago);

                    ViewBag.UrlCondiciones = _menuProvider.GetMenuLinkByDescription(Constantes.ConfiguracionManager.MenuCondicionesDescripcionMx);
                    ViewBag.PaisId = userData.PaisID;

                    return View("PagoExitoso", pago);

                }

                foreach (var error in validator.Errors)
                {
                    ModelState.AddModelError(error.Key, error.Value);
                }
            }

            SetDeviceSessionId(pago);
            ViewBag.PagoLineaCampos = requiredFields;
            ViewBag.UrlIconMedioPago = _pagoEnLineaProvider.GetUrlIconMedioPago(pago);
            CargarListsPasarela();

            return View(info);
        }

        public ActionResult PagoVisa()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            model.PagoVisaModel = _pagoEnLineaProvider.ObtenerValoresPagoVisa(model);

            sessionManager.SetDatosPagoVisa(model);

            return View(model);
        }

        public ActionResult PagoVisaResultado()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            try
            {
                string transactionToken = Request.Form["transactionToken"];
                bool pagoOk = _pagoEnLineaProvider.ProcesarPagoVisa(ref model, transactionToken);

                if (pagoOk)
                {
                    ViewBag.UrlCondiciones = _menuProvider.GetMenuLinkByDescription(Constantes.ConfiguracionManager.MenuCondicionesDescripcion);
                    ViewBag.PaisId = userData.PaisID;

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

        private void CargarListsPasarela()
        {
            Func<string, SelectListItem> fnSelect = m => new SelectListItem {Value = m, Text = m};
            ViewBag.MonthList = _pagoEnLineaProvider.ObtenerMeses().Select(fnSelect);
            ViewBag.YearList = _pagoEnLineaProvider.ObtenerAnios().Select(fnSelect);
        }

        private void SetDeviceSessionId(PagoEnLineaModel pago)
        {
            var provider = new PagoPayuProvider
            {
                SessionId = Session.SessionID
            };
            pago.DeviceSessionId = provider.GetDeviceSessionId();
            sessionManager.SetDatosPagoVisa(pago);
            ViewBag.DeviceSessionId = pago.DeviceSessionId;
        }
    }
}