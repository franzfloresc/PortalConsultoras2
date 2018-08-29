using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Properties;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Providers
{
    public class PagoPayuProvider
    {
        public string SessionId { get; set; }
        public string Agent { get; set; }
        public string IpClient { get; set; }
        public UsuarioModel User { get; set; }
        public PagoEnLineaProvider PagoProvider { get; set; }

        public async Task<bool> Pay(PaymentInfo info, PagoEnLineaModel pago)
        {
            try
            {
                pago.ListaMedioPago = PagoProvider.ObtenerListaMedioPago();
                pago.NumeroReferencia = (await GetNewOrderId()).ToString();
                pago.TipoPago = GetPaymentMethod(pago);

                var data = GetData(info, pago);

                var result = await MakeRequest(pago.PagoVisaModel.UrlPagoPayu, data);
            
                return await ProcessResponse(info, pago, result);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, User.CodigoConsultora, User.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, User.CodigoConsultora, User.CodigoISO);
            }

            return false;
        }

        private async Task<PayuApiResponse> MakeRequest(string url, object data)
        {
            ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;

            const string contentType = "application/json";
            var json = JsonConvert.SerializeObject(data);

            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Accept", contentType);

                var response = await client.PostAsync(url, new StringContent(json, Encoding.UTF8, contentType));
                response.EnsureSuccessStatusCode();

                json = await response.Content.ReadAsStringAsync();

                return JsonConvert.DeserializeObject<PayuApiResponse>(json);
            }
        }

        private object GetData(PaymentInfo info, PagoEnLineaModel pago)
        {
            if (!info.Birthdate.HasValue)
            {
                throw new Exception("Fecha de Nacimiento en Payu es requerido");
            }

            PagoVisaModel config = pago.PagoVisaModel;
            var total = pago.MontoDeudaConGastos;
            var referenceCode = Constantes.PagoEnLineaPayuGenerales.OrderCodePrefix + pago.NumeroReferencia;
            var fullName = User.NombreConsultora;
            var address = GetDireccionConsultora();

            var card = new
            {
                number = info.NumberCard,
                securityCode = info.Cvv,
                expirationDate = info.ExpireYear + "/" + info.ExpireMonth,
                name = info.Titular.ToUpper()
            };

            var obj = new
            {
                language = Constantes.PagoEnLineaPayuGenerales.Language,
                command = Constantes.PagoEnLineaPayuGenerales.Command,
                merchant = new
                {
                    apiKey = config.SecretAccessKey,
                    apiLogin = config.AccessKeyId
                },
                transaction = new
                {
                    order = new
                    {
                        accountId = config.AccountId,
                        referenceCode = referenceCode,
                        description = Constantes.PagoEnLineaPayuGenerales.OrderDescription,
                        language = Constantes.PagoEnLineaPayuGenerales.OrderLanguage,
                        signature = Util.Security.ToMd5(string.Join("~", config.SecretAccessKey, config.MerchantId,
                            referenceCode, total, Constantes.PagoEnLineaPayuGenerales.Currency)),
                        additionalValues = new
                        {
                            TX_VALUE = new
                            {
                                value = total,
                                currency = Constantes.PagoEnLineaPayuGenerales.Currency
                            }
                        },
                        buyer = new
                        {
                            merchantBuyerId = User.ConsultoraID.ToString(),
                            fullName = fullName,
                            emailAddress = info.Email,
                            contactPhone = info.Phone,
                            dniNumber = User.DocumentoIdentidad,
                            shippingAddress = new
                            {
                                street1 = address,
                                //-street2 = "8 int 103",
                                city = string.Empty,
                                //-state = "Jalisco", // obligatorio brasil
                                country = Constantes.PagoEnLineaPayuGenerales.Country,
                                //-postalCode = "000000", // obligatorio brasil
                                //-phone = "7563126" // obligatorio brasil
                            }
                        }
                    },
                    payer = new
                    {
                        merchantPayerId = User.CodigoConsultora,
                        fullName = fullName,
                        emailAddress = info.Email,
                        birthdate = info.Birthdate.Value.ToString("yyyy-MM-dd"), //MX
                        contactPhone = info.Phone,
                        dniNumber = User.DocumentoIdentidad,
                        billingAddress = new
                        {
                            street1 = string.Empty,
                            //-street2 = "calle 5 de Mayo",
                            city = string.Empty,
                            //-state = "Nuevo Leon",
                            country = Constantes.PagoEnLineaPayuGenerales.Country,
                            //-postalCode = "000000", //MX 
                            //-phone = "7563126"
                        }
                    },
                    creditCard = card,
                    //extraParameters = new {
                    //   INSTALLMENTS_NUMBER = 1 // cuotas
                    //},
                    type = Constantes.PagoEnLineaPayuGenerales.TransactionType,
                    paymentMethod = pago.TipoPago,
                    paymentCountry = Constantes.PagoEnLineaPayuGenerales.Country,
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

        private async Task<bool> ProcessResponse(PaymentInfo info, PagoEnLineaModel pago, PayuApiResponse result)
        {
            var success = result.code == "SUCCESS";
            
            if (!success || result.transactionResponse == null)
            {
                pago.DescripcionCodigoAccion = result.error;

                return false;
            }

            var transaction = result.transactionResponse;
            pago.NumeroOperacion = transaction.orderId;
            pago.DescripcionCodigoAccion = GetMessage(transaction);
            pago.FechaCreacion = GetDateCreation(transaction.operationDate);
            pago.TarjetaEnmascarada = Util.EnmascararTarjeta(info.NumberCard);

            var aproved = result.transactionResponse.IsApproved;

            await RegisterLog(pago, transaction, info);

            if (!aproved)
            {
                return false;
            }

            await CompleteTransaction(pago);

            if (!string.IsNullOrEmpty(User.EMail))
            {
                PagoProvider.NotificarViaEmail(pago, User);
            }

            return true;
        }

        private async Task CompleteTransaction(PagoEnLineaModel model)
        {
            //model.PagoEnLineaResultadoLogId = pagoEnLineaResultadoLogId;
            model.NombreConsultora = (string.IsNullOrEmpty(User.Sobrenombre) ? User.NombreConsultora : User.Sobrenombre);
            model.PrimerApellido = User.PrimerApellido;
            model.FechaVencimiento = User.FechaLimPago;
            model.SaldoPendiente = decimal.Round(User.MontoDeuda - model.MontoDeuda, 2);

            using (var ps = new PedidoServiceClient())
            {
                await ps.UpdateMontoDeudaConsultoraAsync(User.PaisID, User.CodigoConsultora, model.SaldoPendiente);
            }

            var tablaLogica = new TablaLogicaProvider();
            var listaConfiguracion = tablaLogica.ObtenerParametrosTablaLogica(User.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
            var mensajeExitoso = tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MensajeInformacionPagoExitoso);

            model.MensajeInformacionPagoExitoso = mensajeExitoso;

            User.MontoDeuda = model.SaldoPendiente;
            SessionManager.SessionManager.Instance.SetUserData(User);
        }

        private async Task RegisterLog(PagoEnLineaModel pago, PayuTransactionResponse transaction, PaymentInfo info)
        {
            BEPagoEnLineaResultadoLog bePagoEnLinea = GenerarEntidadPagoEnLineaLog(pago, transaction, User);
            bePagoEnLinea.FechaNacimiento = info.Birthdate ?? default(DateTime);
            bePagoEnLinea.Correo = info.Email;
            bePagoEnLinea.Celular = info.Phone;

            using (var ps = new PedidoServiceClient())
            {
                pago.PagoEnLineaResultadoLogId = await ps.InsertPagoEnLineaResultadoLogAsync(User.PaisID, bePagoEnLinea);
            }
        }

        private BEPagoEnLineaResultadoLog GenerarEntidadPagoEnLineaLog(PagoEnLineaModel pago, PayuTransactionResponse respuesta, UsuarioModel usuario)
        {
            PagoVisaModel config = pago.PagoVisaModel;

            var bePagoEnLinea = new BEPagoEnLineaResultadoLog();
            var isAproved = respuesta.IsApproved;

            bePagoEnLinea.ConsultoraId = usuario.ConsultoraID;
            bePagoEnLinea.CodigoConsultora = usuario.CodigoConsultora;
            bePagoEnLinea.NumeroDocumento = usuario.DocumentoIdentidad;
            bePagoEnLinea.CampaniaId = usuario.CampaniaID;
            bePagoEnLinea.FechaVencimiento = usuario.FechaLimPago;
            bePagoEnLinea.TipoTarjeta = pago.TipoPago;
            bePagoEnLinea.CodigoError = isAproved ? "0" : respuesta.errorCode;
            bePagoEnLinea.MensajeError = respuesta.paymentNetworkResponseErrorMessage;
            bePagoEnLinea.IdGuidTransaccion = respuesta.transactionId;
            //bePagoEnLinea.IdGuidExternoTransaccion = "";
            bePagoEnLinea.MerchantId = config.MerchantId;
            //bePagoEnLinea.IdTokenUsuario = "";
            //bePagoEnLinea.AliasNameTarjeta = "";

            bePagoEnLinea.FechaTransaccion = GetDateCreation(respuesta.operationDate);

            //bePagoEnLinea.ResultadoValidacionCVV2 = "";
            //bePagoEnLinea.CsiMensaje = "";
            bePagoEnLinea.IdUnicoTransaccion = Constantes.PagoEnLineaPayuGenerales.OrderCodePrefix + pago.NumeroReferencia;
            //bePagoEnLinea.Etiqueta = "";
            //bePagoEnLinea.RespuestaSistemAntifraude = "";
            //bePagoEnLinea.CsiPorcentajeDescuento = 0;
            //bePagoEnLinea.NumeroCuota = "";
            //bePagoEnLinea.TokenTarjetaGuardada = "";
            //bePagoEnLinea.CsiImporteComercio = 0;
            //bePagoEnLinea.CsiCodigoPrograma = "";
            //bePagoEnLinea.DescripcionIndicadorComercioElectronico = "";
            //bePagoEnLinea.IndicadorComercioElectronico = "";
            bePagoEnLinea.DescripcionCodigoAccion = pago.DescripcionCodigoAccion;
            //bePagoEnLinea.NombreBancoEmisor = "";
            //bePagoEnLinea.ImporteCuota = 0;
            //bePagoEnLinea.CsiTipoCobro = "";
            bePagoEnLinea.NumeroReferencia = pago.NumeroReferencia;
            bePagoEnLinea.Respuesta = respuesta.state;
            bePagoEnLinea.NumeroOrdenTienda = pago.NumeroOperacion;
            bePagoEnLinea.CodigoAccion = "000";
            bePagoEnLinea.ImporteAutorizado = isAproved ? pago.MontoDeudaConGastos : 0;
            bePagoEnLinea.CodigoAutorizacion = respuesta.authorizationCode ?? "";
            //bePagoEnLinea.CodigoTienda = "";
            bePagoEnLinea.NumeroTarjeta = pago.TarjetaEnmascarada;
            //bePagoEnLinea.OrigenTarjeta = "";
            bePagoEnLinea.UsuarioCreacion = usuario.CodigoUsuario;

            bePagoEnLinea.MontoPago = pago.MontoDeuda;
            bePagoEnLinea.MontoGastosAdministrativos = pago.MontoGastosAdministrativos;

            return bePagoEnLinea;
        }

        private string GetMessage(PayuTransactionResponse transaction)
        {
            if (!string.IsNullOrEmpty(transaction.responseMessage))
            {
                return transaction.responseMessage;
            }
            var code = transaction.responseCode;

            var message = PayuResponseCodes.ResourceManager.GetString(code);

            return message ?? code;
        }

        private async Task<int> GetNewOrderId()
        {
            using (var service = new PedidoServiceClient())
            {
                return await service.ObtenerPagoEnLineaNumeroOrdenAsync(User.PaisID);
            }
        }

        private DateTime GetDateCreation(long? unixTimeStamp)
        {
            if (unixTimeStamp == null)
            {
                return DateTime.Now;
            }

            unixTimeStamp = unixTimeStamp / 1000;
            var dtDateTime = new DateTime(1970,1,1,0,0,0,0, DateTimeKind.Utc);

            return dtDateTime.AddSeconds(unixTimeStamp.Value).ToLocalTime();
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

        private string GetDireccionConsultora()
        {
            try
            {
                using (var sv = new UsuarioServiceClient())
                {
                    return sv.GetDireccionConsultora(User.PaisID, User.CodigoUsuario);
                }
            }
            catch (Exception e)
            {
                return string.Empty;
            }
        }
    }
}