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

            var pagoVisaModel = new PagoVisaModel();

            #region Valores Configuracion Pago En Linea

            var listaConfiguracion = ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
            
            pagoVisaModel.MerchantId = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MerchantId);
            pagoVisaModel.AccessKeyId = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.AccessKeyId);
            pagoVisaModel.SecretAccessKey = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.SecretAccessKey);
            pagoVisaModel.UrlSessionBotonPagos = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlSessionBotonPago);
            pagoVisaModel.UrlGenerarNumeroPedido = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlGenerarNumeroPedido);
            pagoVisaModel.UrlLibreriaPagoVisa = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlLibreriaPagoVisa);
            pagoVisaModel.SessionToken = Guid.NewGuid().ToString().ToUpper();

            #endregion

            pagoVisaModel.Amount = model.MontoDeudaConGastos;

            #region Generar Sesión para el boton de pagos

            string urlCreateSessionTokenAPI = pagoVisaModel.UrlSessionBotonPagos + pagoVisaModel.MerchantId;

            string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(pagoVisaModel.AccessKeyId + ":" + pagoVisaModel.SecretAccessKey));

            DataToken datatoken = new DataToken();
            datatoken.amount = Convert.ToDouble(pagoVisaModel.Amount.ToString());

            string json = JsonHelper.JsonSerializer<DataToken>(datatoken);

            HttpWebRequest requestSesion;
            requestSesion = WebRequest.Create(urlCreateSessionTokenAPI) as HttpWebRequest;
            requestSesion.Method = "POST";
            requestSesion.ContentType = "application/json";
            requestSesion.Headers.Add("Authorization", "Basic " + credentials);
            requestSesion.Headers.Add("VisaNet-Session-Key", pagoVisaModel.SessionToken);

            StreamWriter postStreamWriterSesion = new StreamWriter(requestSesion.GetRequestStream());
            postStreamWriterSesion.Write(json);
            postStreamWriterSesion.Close();

            HttpWebResponse responseSesion;
            responseSesion = requestSesion.GetResponse() as HttpWebResponse;
            StreamReader postStreamReaderSesion = new StreamReader(responseSesion.GetResponseStream());
            //string respuestaSesion = postStreamReaderSesion.ReadToEnd();
            postStreamReaderSesion.ReadToEnd();
            postStreamReaderSesion.Close();

            #endregion

            #region Generar Número de Pedido

            string urlNextCounterAPI = pagoVisaModel.UrlGenerarNumeroPedido + pagoVisaModel.MerchantId + "/nextCounter";
            HttpWebRequest requestNumPedido;
            requestNumPedido = WebRequest.Create(urlNextCounterAPI) as HttpWebRequest;
            requestNumPedido.Method = "GET";
            requestNumPedido.ContentType = "application/json";
            requestNumPedido.Headers.Add("Authorization", "Basic " + credentials);

            HttpWebResponse responseNumPedido;
            responseNumPedido = requestNumPedido.GetResponse() as HttpWebResponse;
            StreamReader postStreamReaderNumPedido = new StreamReader(responseNumPedido.GetResponseStream());

            pagoVisaModel.PurchaseNumber = postStreamReaderNumPedido.ReadToEnd();
            postStreamReaderNumPedido.Close();

            #endregion

            #region Variables para el formulario de pago visa

            //buttonSize = "";
            //buttonColor = "";
            //merchantName = "";
            //showAmount = "";
            //cardholderName = "";
            //cardholderlastName = "";
            //cardholderEmail = "";
            //userToken = "";

            pagoVisaModel.MerchantLogo = "https://www.somosbelcorp.com/Content/Images/Esika/logo_esika_negro.png";
            pagoVisaModel.FormButtonColor = "#D80000";
            pagoVisaModel.Recurrence = "FALSE";
            pagoVisaModel.RecurrenceFrequency = "";
            pagoVisaModel.RecurrenceType = "";
            pagoVisaModel.RecurrenceAmount = "0.00";

            #endregion            

            model.PagoVisaModel = pagoVisaModel;

            sessionManager.SetDatosPagoVisa(model);

            return View(model);
        }

        public ActionResult ProcesarPagoVisa()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            string sessionToken = model.PagoVisaModel.SessionToken;
            string merchantId = model.PagoVisaModel.MerchantId;
            string transactionToken = Request.Form["transactionToken"];

            string accessKeyId = model.PagoVisaModel.AccessKeyId; /*Colocar aquí el accessKeyId*/
            string secretAccessKey = model.PagoVisaModel.SecretAccessKey; /*Colocar aquí el secretAccessKey*/

            #region Generar Autorizacion para el botón de pagos

            var listaConfiguracion = ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);

            string urlAutorizacionBotonPago = ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlAutorizacionBotonPago);

            string urlAuthorize = urlAutorizacionBotonPago + merchantId;
            string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(accessKeyId + ":" + secretAccessKey));

            Data data = new Data();
            //data.numreferencia = "12345678901234567890";
            //data.codasociado = "12345";
            //data.nombreasociado = "prueba";
            //data.mcc = "3030";

            DataRequestAut dataAutorizacionRQ = new DataRequestAut();
            dataAutorizacionRQ.transactionToken = transactionToken;
            dataAutorizacionRQ.sessionToken = sessionToken;
            dataAutorizacionRQ.data = data;

            string json = JsonHelper.JsonSerializer<DataRequestAut>(dataAutorizacionRQ);

            HttpWebRequest requestAutorizacion;
            requestAutorizacion = WebRequest.Create(urlAuthorize) as HttpWebRequest;
            requestAutorizacion.Method = "POST";
            requestAutorizacion.ContentType = "application/json";
            requestAutorizacion.Headers.Add("Authorization", "Basic " + credentials);
            StreamWriter postStreamWriterAutorizacion = new StreamWriter(requestAutorizacion.GetRequestStream());
            postStreamWriterAutorizacion.Write(json);
            postStreamWriterAutorizacion.Close();

            HttpWebResponse responseAutorizacion;
            StreamReader postStreamReaderAutorizacion;
            string respuestaAutorizacion;
            try
            {
                responseAutorizacion = requestAutorizacion.GetResponse() as HttpWebResponse;
                postStreamReaderAutorizacion = new StreamReader(responseAutorizacion.GetResponseStream());
                respuestaAutorizacion = postStreamReaderAutorizacion.ReadToEnd();
                postStreamReaderAutorizacion.Close();
            }
            catch (WebException ex)
            {
                postStreamReaderAutorizacion = new StreamReader(ex.Response.GetResponseStream(), true);
                respuestaAutorizacion = postStreamReaderAutorizacion.ReadToEnd();
                postStreamReaderAutorizacion.Close();
            }

            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(respuestaAutorizacion);
            Response.End();

            #endregion            

            var respuestaVisa = JsonHelper.JsonDeserialize<RespuestaAutorizacionVisa>(respuestaAutorizacion);
            


            return View("PagoResultado", model);
        }
    }
}