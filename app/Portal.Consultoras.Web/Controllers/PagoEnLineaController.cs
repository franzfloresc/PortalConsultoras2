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
            PagoEnlineaInfoModel PagoLinea = GetPagoEnlineaInfo();
            PagoEnLineaConfiguracion PagoEnlineaConfiguracion = GetPagoEnlineaConfiguracion(PagoLinea.MontoSaldoActual);

            ViewBag.ButtonColor = PagoEnlineaConfiguracion.ButtonColor;
            ViewBag.FechaVencimiento = PagoLinea.FechaConferencia.ToShortDateString();
            ViewBag.MerchantId = PagoEnlineaConfiguracion.MerchantId;
            ViewBag.MerchatLogo = PagoEnlineaConfiguracion.MerchantLogo;
            ViewBag.NombreCompleto = PagoLinea.Nombre;
            ViewBag.PurchaseNumber = PagoEnlineaConfiguracion.PurchaseNumber;
            ViewBag.SaldoActual = PagoLinea.MontoSaldoActual;
            ViewBag.SessionToken = PagoEnlineaConfiguracion.SessionToken;

            return View();
        }

        public ActionResult PagoEnLinea()
        {
            return View();
        }

        private PagoEnlineaInfoModel GetPagoEnlineaInfo()
        {
            PagoEnlineaInfoModel PagoLineaModel = new PagoEnlineaInfoModel();
            try
            {
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    BEPagoEnLineaInfo PagoInfo = sv.GetPagoEnLineaInfo(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID, userData.ZonaID);
                    PagoLineaModel = Mapper.Map<BEPagoEnLineaInfo, PagoEnlineaInfoModel>(PagoInfo);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return PagoLineaModel;
        }

        private PagoEnLineaConfiguracion GetPagoEnlineaConfiguracion(decimal MontoSaldo)
        {
            List<BEVisaConfiguracion> VisaConfiguracion = GetVisaConfiguracion(userData.PaisID);
            string merchantId = VisaConfiguracion[0].Valor;
            string accessKeyId = VisaConfiguracion[1].Valor;
            string secretAccessKey = VisaConfiguracion[2].Valor;
            string sessionToken;
            string RespuestaNumPedido;

            #region Generar session para el boton de pago
            string urlCreateSessionTokenAPI = VisaConfiguracion[3].Valor + merchantId; //UrlSession
            sessionToken = Guid.NewGuid().ToString().ToUpper();
            double amount = 10.0;

            string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(accessKeyId + ":" + secretAccessKey));
            GenerarSession(sessionToken, urlCreateSessionTokenAPI, amount, credentials);
            #endregion

            #region Generar Numero Pedido
            string UrlCounterAPI = VisaConfiguracion[4].Valor + merchantId + "/nextCounter"; //UrlCounter";
            RespuestaNumPedido = GenerarNumeroPedido(credentials, UrlCounterAPI);
            #endregion

            return new PagoEnLineaConfiguracion
            {
                Amount = MontoSaldo,
                ButtonColor = "#D80000",
                RecurrenceFrequency = 0,
                MerchantId = merchantId,
                MerchantLogo = "https://demo1.vnforapps.com/vs/images/logo.png",
                PurchaseNumber = RespuestaNumPedido,
                Recurrence = "FALSE",
                RecurrenceType = "",
                RecurrenceAmount = 0
            };
        }

        private void GenerarSession(string sessionToken, string urlCreateSessionTokenAPI, double amount, string credentials)
        {
            DataToken dataToken = new DataToken();
            dataToken.amount = amount;

            string json = JsonConvert.SerializeObject(dataToken);
            //JsonSerializer<DataToken>(dataToken);

            HttpWebRequest requestSesion = WebRequest.Create(urlCreateSessionTokenAPI) as HttpWebRequest;
            requestSesion.Method = "POST";
            requestSesion.ContentType = "application/json";
            //requestSesion.Headers.Add("Authorization", "Basic " + credentials);
            requestSesion.Headers[HttpRequestHeader.Authorization] = "Basic " + credentials;
            requestSesion.Headers.Add("VisaNet-Session-Key", sessionToken);
            StreamWriter postStreamWriterSesion = new StreamWriter(requestSesion.GetRequestStream());
            postStreamWriterSesion.Write(json);
            postStreamWriterSesion.Close();

            HttpWebResponse responseSesion = (HttpWebResponse)requestSesion.GetResponse();
            StreamReader postStreamReaderSesion = new StreamReader(responseSesion.GetResponseStream());
            string respuestaSesion = postStreamReaderSesion.ReadToEnd();
            postStreamReaderSesion.Close();
        }

        private static string GenerarNumeroPedido(string credentials, string UrlCounterAPI)
        {
            string RespuestaNumPedido;
            HttpWebRequest RequestNumeroPedido;
            RequestNumeroPedido = (HttpWebRequest)WebRequest.Create(UrlCounterAPI);
            RequestNumeroPedido.Method = "GET";
            RequestNumeroPedido.ContentType = "application/json";
            RequestNumeroPedido.Headers.Add("Authorization", "Basic " + credentials);

            HttpWebResponse ResponseNumeroPedido;
            ResponseNumeroPedido = RequestNumeroPedido.GetResponse() as HttpWebResponse;

            StreamReader PostStreamReaderNumeroPedido = new StreamReader(ResponseNumeroPedido.GetResponseStream());
            RespuestaNumPedido = PostStreamReaderNumeroPedido.ReadToEnd();
            PostStreamReaderNumeroPedido.Close();
            return RespuestaNumPedido;
        }

        public List<BEVisaConfiguracion> GetVisaConfiguracion(int PaisId)
        {
            List<BEVisaConfiguracion> lst = new List<BEVisaConfiguracion>();
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    lst = sv.GetVisaConfiguracion(userData.PaisID).ToList();
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return lst;
        }
    }
}