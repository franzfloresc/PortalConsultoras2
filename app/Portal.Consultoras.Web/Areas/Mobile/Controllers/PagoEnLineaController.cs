using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
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

            return View(model);
        }
        
        public ActionResult MetodoPago()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            model = _pagoEnLineaProvider.ObtenerValoresMetodoPago(model);
            
            //model.ListaMetodoPago = ObtenerListaMetodoPago();
            //model.PagoVisaModel = new PagoVisaModel();
            //if (model.ListaMetodoPago.Count > 0)
            //{
            //    var metodoPagoPasarelaVisa = model.ListaMetodoPago.FirstOrDefault(p => p.TipoPasarelaCodigoPlataforma == Constantes.PagoEnLineaMetodoPago.PasarelaVisa);

            //    if (metodoPagoPasarelaVisa != null)
            //        model.PagoVisaModel = ObtenerValoresPagoVisa(model);
            //    else
            //        model.PagoVisaModel = new PagoVisaModel();
            //}


            return View(model);
        }

        [HttpGet]
        public ActionResult PasarelaPago(string cardType, int medio)
        {
            var pago = sessionManager.GetDatosPagoVisa();
            if (!string.IsNullOrEmpty(cardType))
            {
                var selected = pago.ListaMetodoPago
                    .FirstOrDefault(m =>
                        m.TipoPasarelaCodigoPlataforma  == Constantes.PagoEnLineaMetodoPago.PasarelaBelcorpPayU &&
                        m.PagoEnLineaMedioPagoId == medio &&
                        m.TipoTarjeta == cardType);

                if (selected == null)
                {
                    return RedirectToAction("MetodoPago");
                }
                pago.MetodoPagoSeleccionado = selected;
                sessionManager.SetDatosPagoVisa(pago);
            }
            
            if (pago.MetodoPagoSeleccionado == null)
            {
                return RedirectToAction("MetodoPago");
            }

            SetDeviceSessionId(pago);
            //Logica para Obtener Valores de la PasarelaBelcorp
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
        public ActionResult PasarelaPago(PaymentInfo info)
        {
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
                    // Make Pay
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
                    ViewBag.UrlCondiciones = GetMenuLinkByDescription(Constantes.ConfiguracionManager.MenuCondicionesDescripcion);

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