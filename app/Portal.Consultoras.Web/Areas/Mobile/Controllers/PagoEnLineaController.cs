using Portal.Consultoras.Common;
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
                return RedirectToAction("Index", "Bienvenida");

            var model = sessionManager.GetDatosPagoVisa();
            if (!_pagoEnLineaProvider.IsLoadMetodoPago(model)) return RedirectToAction("MetodoPago");

            model = _pagoEnLineaProvider.ObtenerValoresPagoEnLinea(model);

            ViewBag.PagoEnLineaGastosLabel = userData.PaisID == Constantes.PaisID.Mexico ? Constantes.PagoEnLineaMensajes.GastosLabelMx : Constantes.PagoEnLineaMensajes.GastosLabelPe;

            return View(model);
        }
        
        public ActionResult MetodoPago()
        {
            if (!userData.TienePagoEnLinea)
                return RedirectToAction("Index", "Bienvenida");

            var model = new PagoEnLineaModel
            {
                ListaMetodoPago = _pagoEnLineaProvider.ObtenerListaMetodoPago()
            };
            sessionManager.SetDatosPagoVisa(model);

            return View(model);
        }

        [HttpGet]
        public ActionResult PasarelaPago()
        {
            var pago = sessionManager.GetDatosPagoVisa();
            if (!_pagoEnLineaProvider.IsLoadMetodoPago(pago)) return RedirectToAction("MetodoPago");
            if (!_pagoEnLineaProvider.CanPay(userData, pago)) return RedirectToAction("Index", "Bienvenida");

            pago.PagoVisaModel = _pagoEnLineaProvider.ObtenerValoresPagoPayu();
            LoadViewParameters(pago, _pagoEnLineaProvider.ObtenerCamposRequeridos());

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
            var pago = sessionManager.GetDatosPagoVisa();
            if (!_pagoEnLineaProvider.IsLoadMetodoPago(pago)) return RedirectToAction("MetodoPago");
            if (!_pagoEnLineaProvider.CanPay(userData, pago)) return RedirectToAction("Index", "Bienvenida");

            var requiredFields = _pagoEnLineaProvider.ObtenerCamposRequeridos();

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
                    return await GetPayResult(info, pago);
                }

                foreach (var error in validator.Errors)
                {
                    ModelState.AddModelError(error.Key, error.Value);
                }
            }

            LoadViewParameters(pago, requiredFields);

            return View(info);
        }

        public ActionResult PagoVisa()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (!_pagoEnLineaProvider.IsLoadMetodoPago(model)) return RedirectToAction("MetodoPago");
            if (!_pagoEnLineaProvider.CanPay(userData, model)) return RedirectToAction("Index", "Bienvenida");

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
                if (string.IsNullOrWhiteSpace(transactionToken)) return RedirectToAction("MetodoPago");

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

        private async Task<ActionResult> GetPayResult(PaymentInfo info, PagoEnLineaModel pago)
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
            sessionManager.SetDatosPagoVisa(null);
            sessionManager.SetListadoEstadoCuenta(null);

            if (!success)
                return View("PagoRechazado", pago);

            ViewBag.UrlCondiciones = _menuProvider.GetMenuLinkByDescription(Constantes.ConfiguracionManager.MenuCondicionesDescripcionMx);
            ViewBag.PaisId = userData.PaisID;

            var view = View("PagoExitoso", pago);

            return view;
        }

        private void LoadViewParameters(PagoEnLineaModel pago, string[] requiredFields)
        {
            pago.DeviceSessionId = GetDeviceSessionId();
            sessionManager.SetDatosPagoVisa(pago);

            ViewBag.DeviceSessionId = pago.DeviceSessionId;
            ViewBag.PagoLineaCampos = requiredFields;
            ViewBag.UrlIconMedioPago = _pagoEnLineaProvider.GetUrlIconMedioPago(pago);
            ViewBag.PagoMontoTotal = pago.Simbolo + " " + pago.MontoDeudaConGastosString;
            CargarListsPasarela();
        }

        private void CargarListsPasarela()
        {
            Func<string, SelectListItem> fnSelect = m => new SelectListItem { Value = m, Text = m };
            ViewBag.MonthList = _pagoEnLineaProvider.ObtenerMeses().Select(fnSelect);
            ViewBag.YearList = _pagoEnLineaProvider.ObtenerAnios().Select(fnSelect);
        }

        private string GetDeviceSessionId()
        {
            var provider = new PagoPayuProvider
            {
                SessionId = Session.SessionID
            };
            return provider.GetDeviceSessionId();
        }
    }
}