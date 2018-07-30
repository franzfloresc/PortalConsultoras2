using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;

namespace Portal.Consultoras.Web.Providers
{
    public class PagoPayuProvider
    {
        public string SessionId { get; set; }
        public string Agent { get; set; }
        public string IpClient { get; set; }
        public UsuarioModel User { get; set; }

        public async Task Pay(PaymentInfo info, PagoEnLineaModel pago)
        {
            var data = GetData(info, pago);

            var result = await MakeRequest(pago.PagoVisaModel.UrlPagoPayu, data);

        }

        private async Task<object> MakeRequest(string url, object data)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            ServicePointManager.ServerCertificateValidationCallback = (_, __, ___, ____) => true;
            
            const string contentType = "application/json";
            using (var client = new HttpClient())
            {
                var json = JsonConvert.SerializeObject(data);
                client.DefaultRequestHeaders.Add("Accept", contentType);
                
                var response = await client.PostAsync(url, new StringContent(json, Encoding.UTF8, contentType));
                response.EnsureSuccessStatusCode();

                json = await response.Content.ReadAsStringAsync();
                
                return JsonConvert.DeserializeObject(json);
            }
        }
        
        public string GetDeviceSessionId()
        {
            var id = SessionId + GetMicroSeconds();

            return Util.Security.ToMd5(id);
        }

        private long GetMicroSeconds()
        {
            return DateTime.Now.Ticks / 10;
        }

        private object GetData(PaymentInfo info, PagoEnLineaModel pago)
        {
            PagoVisaModel config = pago.PagoVisaModel;
            var total = pago.MontoDeudaConGastos;
            var referenceCode = Constantes.PagoEnLineaPayuGenerales.OrderCodePrefix + DateTime.Now.ToString("yyyyMMddHHmmss");

            var obj = new {
               language = Constantes.PagoEnLineaPayuGenerales.Language,
               command = Constantes.PagoEnLineaPayuGenerales.Command,
               merchant = new {
                  apiKey = config.AccessKeyId,
                  apiLogin = config.SecretAccessKey
               },
               transaction = new {
                  order = new {
                     accountId = config.AccountId,
                     referenceCode = referenceCode,
                     description = Constantes.PagoEnLineaPayuGenerales.OrderDescription,
                     language = Constantes.PagoEnLineaPayuGenerales.OrderLanguage,
                     signature =  Util.Security.ToMd5(string.Join("~", config.AccessKeyId, config.MerchantId, referenceCode, total, Constantes.PagoEnLineaPayuGenerales.Currency)),
                     additionalValues = new {
                        TX_VALUE = new {
                           value = total,
                           currency = Constantes.PagoEnLineaPayuGenerales.Currency
                        }
                     },
                     buyer = new {
                        merchantBuyerId = User.ConsultoraID.ToString(),
                        fullName = User.NombreConsultora,
                        emailAddress = info.Email,
                        contactPhone = info.Phone,
                        dniNumber = User.DocumentoIdentidad,
                        shippingAddress = new {
                           street1 = User.Direccion,
                           //street2 = "8 int 103",
                           city = "Guadalajara",
                           //state = "Jalisco", // obligatorio brasil
                           country = Constantes.PagoEnLineaPayuGenerales.Country,
                           //postalCode = "000000", // obligatorio brasil
                           //phone = "7563126" // obligatorio brasil
                        }
                     },
                     //shippingAddress = new {
                     //   street1 = "Calle Salvador Alvarado",
                     //   street2 = "8 int 103",
                     //   city = "Guadalajara",
                     //   state = "Jalisco",
                     //   country = "MX",
                     //   postalCode = "0000000",
                     //   phone = "7563126"
                     //}
                  },
                  payer = new {
                     //merchantPayerId = "1",
                     fullName = User.NombreConsultora,
                     emailAddress = info.Email,
                     birthdate = info.Birthdate.Value, //MX
                     contactPhone = info.Phone,
                     dniNumber = User.DocumentoIdentidad,
                     billingAddress = new {
                        street1 = User.Direccion,
                        //street2 = "calle 5 de Mayo",
                        city = "Monterrey",
                        //state = "Nuevo Leon",
                        country = Constantes.PagoEnLineaPayuGenerales.Country,
                        postalCode = "64000", //MX
                        //phone = "7563126"
                     }
                  },
                  creditCard = info.NumberCard,
                  //extraParameters = new {
                  //   INSTALLMENTS_NUMBER = 1 // cuotas
                  //},
                  type = Constantes.PagoEnLineaPayuGenerales.TransactionType,
                  paymentMethod = GetPaymentMethod(pago),
                  paymentCountry = Constantes.PagoEnLineaPayuGenerales.Currency,
                  deviceSessionId = pago.DeviceSessionId,
                  ipAddress = IpClient,
                  cookie = SessionId,
                  userAgent = Agent
               },
               test = config.IsTest
            };
 
            return obj;
        }

        private string GetPaymentMethod(PagoEnLineaModel model)
        {
            var idSelected = model.MetodoPagoSeleccionado.PagoEnLineaMedioPagoId;

            var method = model.ListaMedioPago.FirstOrDefault(item => item.PagoEnLineaMedioPagoId == idSelected);

            return method != null ? method.Descripcion : string.Empty;
        }
    }
}