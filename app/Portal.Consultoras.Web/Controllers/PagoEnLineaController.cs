using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Json;
using System.ServiceModel;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Mvc;
using System.Web.Script.Serialization;

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

        private string JsonSerializer<T>(T t)
        {
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
            MemoryStream ms = new MemoryStream();
            ser.WriteObject(ms, t);
            string jsonString = Encoding.UTF8.GetString(ms.ToArray());
            ms.Close();
            //Replace Json Date String
            string p = @"\\/Date\((\d+)\+\d+\)\\/";
            MatchEvaluator matchEvaluator = new MatchEvaluator(ConvertJsonDateToDateString);
            Regex reg = new Regex(p);
            jsonString = reg.Replace(jsonString, matchEvaluator);
            return jsonString;
        }
        private static string ConvertJsonDateToDateString(Match m)
        {
            string result = string.Empty;
            DateTime dt = new DateTime(1970, 1, 1);
            dt = dt.AddMilliseconds(long.Parse(m.Groups[1].Value));
            dt = dt.ToLocalTime();
            result = dt.ToString("yyyy-MM-dd HH:mm:ss");
            return result;
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
            string MerchantId = "148131802";
            string AccessKeyId = "AKIAJRWJQBFYLRVB22ZQ";
            string SecretAccessKey = "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";
            string Sessiontoken = Guid.NewGuid().ToString().ToUpper();
            string RespuestaNumPedido;
            string SessionToken = "";

            string Credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(AccessKeyId + ":" + SecretAccessKey));

            #region Generar session para el boton de pago

            string UrlSessionTokenAPI = "https://devapice.vnforapps.com/api.ecommerce/api/v1/ecommerce/token/" + MerchantId;
            SessionToken = Guid.NewGuid().ToString().ToUpper();

            DataToken DataToken = new DataToken();
            DataToken.monto = MontoSaldo;

            string json = JsonSerializer<DataToken>(DataToken);// new JavaScriptSerializer().Serialize(DataToken); 
            //JsonConvert.SerializeObject(DataToken, Formatting.None);

            HttpWebRequest RequestSession;
            RequestSession = (HttpWebRequest)WebRequest.Create(UrlSessionTokenAPI);
            RequestSession.Method = "POST";
            RequestSession.ContentType = "application/json";
            RequestSession.Headers.Add("Authorization", "Basic " + Credentials);
            RequestSession.Headers.Add("VisaNet-Session-Key", SessionToken);
            StreamWriter postStreamWriterSesion = new StreamWriter(RequestSession.GetRequestStream());
            postStreamWriterSesion.Write(json);
            postStreamWriterSesion.Close();

            HttpWebResponse responseSesion;
            responseSesion = RequestSession.GetResponse() as HttpWebResponse;

            StreamReader postStreamReaderSesion = new StreamReader(responseSesion.GetResponseStream());
            string respuestaSesion = postStreamReaderSesion.ReadToEnd();
            postStreamReaderSesion.Close();

            #endregion


            #region Generar Numero Pedido

            string UrlCounterAPI = "https://devapice.vnforapps.com/api.tokenization/api/v2/merchant/" + MerchantId + "/nextCounter";

            HttpWebRequest RequestNumeroPedido;
            RequestNumeroPedido = (HttpWebRequest)WebRequest.Create(UrlCounterAPI);
            RequestNumeroPedido.Method = "GET";
            RequestNumeroPedido.ContentType = "application/json";
            RequestNumeroPedido.Headers.Add("Authorization", "Basic " + Credentials);

            HttpWebResponse ResponseNumeroPedido;
            ResponseNumeroPedido = RequestNumeroPedido.GetResponse() as HttpWebResponse;

            StreamReader PostStreamReaderNumeroPedido = new StreamReader(ResponseNumeroPedido.GetResponseStream());
            RespuestaNumPedido = PostStreamReaderNumeroPedido.ReadToEnd();
            PostStreamReaderNumeroPedido.Close();
            #endregion

            return new PagoEnLineaConfiguracion
            {
                Amount = MontoSaldo,
                ButtonColor = "#D80000",
                RecurrenceFrequency = 0,
                MerchantId = MerchantId,
                MerchantLogo = "https://demo1.vnforapps.com/vs/images/logo.png",
                PurchaseNumber = RespuestaNumPedido,
                Recurrence = "FALSE",
                RecurrenceType = "",
                RecurrenceAmount = 0,

            };
        }
    }
}