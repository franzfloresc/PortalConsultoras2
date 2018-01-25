using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using System.ServiceModel;
using System.Text;
using Portal.Consultoras.Common.PagoEnLinea;
using System.Net;
using System.IO;
using System.Web;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PagoEnLineaController : BaseMobileController
    {

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

        //public ActionResult PagoExitoso()
        //{
        //    return View();
        //}

        public ActionResult PagoRechazado()
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
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            model.PagoVisaModel = ObtenerValoresPagoVisa(model);

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
                string sessionToken = model.PagoVisaModel.SessionToken;
                string merchantId = model.PagoVisaModel.MerchantId;
                string transactionToken = Request.Form["transactionToken"];

                string accessKeyId = model.PagoVisaModel.AccessKeyId; /*Colocar aquí el accessKeyId*/
                string secretAccessKey = model.PagoVisaModel.SecretAccessKey; /*Colocar aquí el secretAccessKey*/

                var respuestaAutorizacion = GenerarAutorizacionBotonPagos(sessionToken, merchantId, transactionToken, accessKeyId, secretAccessKey);                
                var respuestaVisa = JsonHelper.JsonDeserialize<RespuestaAutorizacionVisa>(respuestaAutorizacion);

                BEPagoEnLineaResultadoLog bePagoEnLinea = GenerarEntidadPagoEnLineaLog(respuestaVisa);
                bePagoEnLinea.MontoPago = model.MontoDeuda;
                bePagoEnLinea.MontoGastosAdministrativos = model.MontoGastosAdministrativos;

                sessionManager.SetDatosPagoVisa(null);

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    ps.InsertPagoEnLineaResultadoLog(userData.PaisID, bePagoEnLinea);
                }                

                if (bePagoEnLinea.CodigoError == "0" && bePagoEnLinea.CodigoAccion == "000")
                {                   
                    model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                    model.NumeroOperacion = bePagoEnLinea.NumeroOrdenTienda;
                    model.FechaVencimiento = userData.FechaLimPago;
                    model.SaldoPendiente = decimal.Round(userData.MontoDeuda - model.MontoDeuda, 2);

                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        ps.UpdateMontoDeudaConsultora(userData.PaisID, userData.CodigoConsultora, model.SaldoPendiente);
                    }

                    var listaConfiguracion = ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
                    var mensajeExitoso = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MensajeInformacionPagoExitoso);

                    model.MensajeInformacionPagoExitoso = mensajeExitoso;

                    userData.MontoDeuda = model.SaldoPendiente;
                    sessionManager.SetUserData(userData);

                    return View("PagoExitoso", model);
                }
                else
                {
                    return View("PagoRechazado", model);
                }                
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return View("PagoRechazado", model);
        }
    }
}