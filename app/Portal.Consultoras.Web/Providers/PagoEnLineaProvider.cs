using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.PagoEnLinea;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Text;

namespace Portal.Consultoras.Web.Providers
{
    public class PagoEnLineaProvider
    {
        private const int MaxYearCard = 20;
        protected ISessionManager sessionManager;
        protected TablaLogicaProvider _tablaLogica;

        public PagoEnLineaProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            _tablaLogica = new TablaLogicaProvider();
        }

        public void CargarDataMetodoPago(PagoEnLineaModel model)
        {
            var metodo = model.MetodoPagoSeleccionado;

            switch (metodo.TipoPasarelaCodigoPlataforma)
            {
                //case Constantes.PagoEnLineaMetodoPago.PasarelaVisa:
                //    model.PagoVisaModel = ObtenerValoresPagoVisa(model);
                //    break;
                case Constantes.PagoEnLineaMetodoPago.PasarelaBelcorpPayU:
                    model.PagoVisaModel = ObtenerValoresPagoPayu(model);
                    break;
                default:
                    model.PagoVisaModel = new PagoVisaModel();
                    break;
            }
        }

        public PagoEnLineaModel ObtenerValoresPagoEnLinea()
        {
            var model = new PagoEnLineaModel();

            return ObtenerValoresPagoEnLinea(model);
        }

        public PagoEnLineaModel ObtenerValoresPagoEnLinea(PagoEnLineaModel model)
        {
            var userData = sessionManager.GetUserData();

            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.MontoDeuda = userData.MontoDeuda;
            model.FechaVencimiento = userData.FechaLimPago;

            var listaConfiguracion = _tablaLogica.ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);

            var porcentajeGastosAdministrativosString = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.PorcentajeGastosAdministrativos);
            decimal porcentajeGastosAdministrativos;
            bool esNum = decimal.TryParse(porcentajeGastosAdministrativosString, out porcentajeGastosAdministrativos);

            model.PorcentajeGastosAdministrativos = esNum ? porcentajeGastosAdministrativos : 0;

            model.ListaTipoPago = ObtenerListaTipoPago();
            model.ListaMedioPago = ObtenerListaMedioPago();

            return model;
        }

        public PagoEnLineaModel ObtenerValoresMetodoPago(PagoEnLineaModel model)
        {
            model.ListaMetodoPago = ObtenerListaMetodoPago();
            model.PagoVisaModel = new PagoVisaModel();
            if (model.ListaMetodoPago.Count > 0)
            {
                var metodoPagoPasarelaVisa = model.ListaMetodoPago.FirstOrDefault(p => p.TipoPasarelaCodigoPlataforma == Constantes.PagoEnLineaMetodoPago.PasarelaVisa);

                if (metodoPagoPasarelaVisa != null)
                {
                    model.PagoVisaModel = ObtenerValoresPagoVisa(model);
                }
                else
                {
                    metodoPagoPasarelaVisa = model.ListaMetodoPago.FirstOrDefault(p => p.TipoPasarelaCodigoPlataforma == Constantes.PagoEnLineaMetodoPago.PasarelaBelcorpPayU);
                    if (metodoPagoPasarelaVisa != null)
                        model.PagoVisaModel = ObtenerValoresPagoPayu(model);
                    else
                        model.PagoVisaModel = new PagoVisaModel();
                }

            }

            return model;
        }

        public List<PagoEnLineaTipoPagoModel> ObtenerListaTipoPago()
        {
            List<PagoEnLineaTipoPagoModel> listaTipoPagoModel;
            var userData = sessionManager.GetUserData();

            try
            {
                List<BEPagoEnLineaTipoPago> listaTipoPago;
                using (var ps = new PedidoServiceClient())
                {
                    listaTipoPago = ps.ObtenerPagoEnLineaTipoPago(userData.PaisID).ToList();
                }

                listaTipoPagoModel = Mapper.Map<List<PagoEnLineaTipoPagoModel>>(listaTipoPago);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaTipoPagoModel = new List<PagoEnLineaTipoPagoModel>();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaTipoPagoModel = new List<PagoEnLineaTipoPagoModel>();
            }

            return listaTipoPagoModel;
        }

        public List<PagoEnLineaMedioPagoModel> ObtenerListaMedioPago()
        {
            List<PagoEnLineaMedioPagoModel> listaMedioPagoModel;
            var userData = sessionManager.GetUserData();

            try
            {
                List<BEPagoEnLineaMedioPago> listaMedioPago;
                using (var ps = new PedidoServiceClient())
                {
                    listaMedioPago = ps.ObtenerPagoEnLineaMedioPago(userData.PaisID).ToList();
                }

                listaMedioPagoModel = Mapper.Map<List<PagoEnLineaMedioPagoModel>>(listaMedioPago);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaMedioPagoModel = new List<PagoEnLineaMedioPagoModel>();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaMedioPagoModel = new List<PagoEnLineaMedioPagoModel>();
            }

            return listaMedioPagoModel;
        }

        public List<PagoEnLineaMedioPagoDetalleModel> ObtenerListaMetodoPago()
        {
            List<PagoEnLineaMedioPagoDetalleModel> listaMedioPagoDetalleModel;
            var userData = sessionManager.GetUserData();

            try
            {
                List<BEPagoEnLineaMedioPagoDetalle> listaMedioPagoDetalle;
                using (var ps = new PedidoServiceClient())
                {
                    listaMedioPagoDetalle = ps.ObtenerPagoEnLineaMedioPagoDetalle(userData.PaisID).ToList();
                }

                listaMedioPagoDetalleModel = Mapper.Map<List<PagoEnLineaMedioPagoDetalleModel>>(listaMedioPagoDetalle);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaMedioPagoDetalleModel = new List<PagoEnLineaMedioPagoDetalleModel>();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaMedioPagoDetalleModel = new List<PagoEnLineaMedioPagoDetalleModel>();
            }

            return listaMedioPagoDetalleModel;
        }

        public PagoVisaModel ObtenerValoresPagoVisa(PagoEnLineaModel model)
        {
            var pagoVisaModel = new PagoVisaModel();
            var userData = sessionManager.GetUserData();

            #region Valores Configuracion Pago En Linea

            //var listaConfiguracion = _tablaLogica.ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);

            //pagoVisaModel.MerchantId = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MerchantId);
            //pagoVisaModel.AccessKeyId = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.AccessKeyId);
            //pagoVisaModel.SecretAccessKey = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.SecretAccessKey);
            //pagoVisaModel.UrlSessionBotonPagos = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlSessionBotonPago);
            //pagoVisaModel.UrlGenerarNumeroPedido = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlGenerarNumeroPedido);
            //pagoVisaModel.UrlLibreriaPagoVisa = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlLibreriaPagoVisa);
            pagoVisaModel.SessionToken = Guid.NewGuid().ToString().ToUpper();

            var tipoPasarelaVisa = Constantes.PagoEnLineaMetodoPago.PasarelaVisa;
            var listaPasarelaVisa = ObtenerPagoEnLineaTipoPasarela(tipoPasarelaVisa);
            if (listaPasarelaVisa.Count > 0)
            {
                pagoVisaModel.MerchantId = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.MerchantId);
                pagoVisaModel.AccessKeyId = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.AccessKeyId);
                pagoVisaModel.SecretAccessKey = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.SecretAccessKey);
                pagoVisaModel.UrlSessionBotonPagos = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.UrlSessionBotonPago);
                pagoVisaModel.UrlGenerarNumeroPedido = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.UrlGenerarNumeroPedido);
                pagoVisaModel.UrlLibreriaPagoVisa = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.UrlLibreriaPagoVisa);
            }

            #endregion

            pagoVisaModel.Amount = model.MontoDeudaConGastos;

            #region Generar Sesion para el boton de pagos

            string urlCreateSessionTokenAPI = pagoVisaModel.UrlSessionBotonPagos + pagoVisaModel.MerchantId;

            string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(pagoVisaModel.AccessKeyId + ":" + pagoVisaModel.SecretAccessKey));

            DataToken datatoken = new DataToken();
            datatoken.amount = Convert.ToDouble(pagoVisaModel.Amount.ToString());

            string json = JsonHelper.JsonSerializer<DataToken>(datatoken);

            ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;
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

            postStreamReaderSesion.ReadToEnd();
            postStreamReaderSesion.Close();

            #endregion

            #region Generar Numero de Pedido

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

            //pagoVisaModel.MerchantLogo = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.UrlLogoPasarelaPago);
            //pagoVisaModel.FormButtonColor = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.ColorBotonPagarPasarelaPago);
            pagoVisaModel.MerchantLogo = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.UrlLogoPasarelaPago);
            pagoVisaModel.FormButtonColor = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.ColorBotonPagarPasarelaPago);
            pagoVisaModel.Recurrence = "FALSE";
            pagoVisaModel.RecurrenceFrequency = "";
            pagoVisaModel.RecurrenceType = "";
            pagoVisaModel.RecurrenceAmount = "0.00";

            #endregion

            #region Obtener Token de Tarjeta Guardada

            var tokenTarjetaGuardada = "";

            try
            {
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    tokenTarjetaGuardada = ps.ObtenerTokenTarjetaGuardadaByConsultora(userData.PaisID, userData.CodigoConsultora);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                tokenTarjetaGuardada = "";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                tokenTarjetaGuardada = "";
            }

            pagoVisaModel.TokenTarjetaGuardada = tokenTarjetaGuardada;

            #endregion

            return pagoVisaModel;
        }

        public PagoVisaModel ObtenerValoresPagoPayu(PagoEnLineaModel model)
        {
            var settings = ConfigurationManager.AppSettings;
            var pagoModel = new PagoVisaModel
            {
                MerchantId = settings[Constantes.PagoEnLineaPasarelaPayu.MerchantId],
                AccessKeyId = settings[Constantes.PagoEnLineaPasarelaPayu.ApiLogin],
                SecretAccessKey = settings[Constantes.PagoEnLineaPasarelaPayu.ApiKey],
                AccountId = settings[Constantes.PagoEnLineaPasarelaPayu.AccountId],
                UrlPagoPayu = settings[Constantes.PagoEnLineaPasarelaPayu.Endpoint],
                IsTest = settings[Constantes.PagoEnLineaPasarelaPayu.Test] == "1"
            };
            
            return pagoModel;
        }

        public bool ProcesarPagoVisa(ref PagoEnLineaModel model, string transactionToken)
        {
            var resultado = false;
            var userData = sessionManager.GetUserData();

            try
            {
                string sessionToken = model.PagoVisaModel.SessionToken;
                string merchantId = model.PagoVisaModel.MerchantId;
                string accessKeyId = model.PagoVisaModel.AccessKeyId;
                string secretAccessKey = model.PagoVisaModel.SecretAccessKey;

                var respuestaAutorizacion = GenerarAutorizacionBotonPagos(userData.PaisID, sessionToken, merchantId, transactionToken, accessKeyId, secretAccessKey);
                var respuestaVisa = JsonHelper.JsonDeserialize<RespuestaAutorizacionVisa>(respuestaAutorizacion);

                BEPagoEnLineaResultadoLog bePagoEnLinea = GenerarEntidadPagoEnLineaLog(respuestaVisa, userData);
                bePagoEnLinea.MontoPago = model.MontoDeuda;
                bePagoEnLinea.MontoGastosAdministrativos = model.MontoGastosAdministrativos;

                int pagoEnLineaResultadoLogId = 0;
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    pagoEnLineaResultadoLogId = ps.InsertPagoEnLineaResultadoLog(userData.PaisID, bePagoEnLinea);
                }

                // Requerido en pago rechazado.
                model.NumeroOperacion = bePagoEnLinea.NumeroOrdenTienda;
                model.FechaCreacion = bePagoEnLinea.FechaTransaccion;
                model.DescripcionCodigoAccion = bePagoEnLinea.DescripcionCodigoAccion;

                if (bePagoEnLinea.CodigoError == "0" && bePagoEnLinea.CodigoAccion == "000")
                {
                    model.PagoEnLineaResultadoLogId = pagoEnLineaResultadoLogId;
                    model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                    model.PrimerApellido = userData.PrimerApellido;
                    model.TarjetaEnmascarada = bePagoEnLinea.NumeroTarjeta;
                    model.FechaVencimiento = userData.FechaLimPago;
                    model.SaldoPendiente = decimal.Round(userData.MontoDeuda - model.MontoDeuda, 2);

                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        ps.UpdateMontoDeudaConsultora(userData.PaisID, userData.CodigoConsultora, model.SaldoPendiente);
                    }

                    var listaConfiguracion = _tablaLogica.ObtenerParametrosTablaLogica(userData.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea, true);
                    var mensajeExitoso = _tablaLogica.ObtenerValorTablaLogica(listaConfiguracion, Constantes.TablaLogicaDato.MensajeInformacionPagoExitoso);

                    model.MensajeInformacionPagoExitoso = mensajeExitoso;

                    userData.MontoDeuda = model.SaldoPendiente;
                    sessionManager.SetUserData(userData);

                    if (!string.IsNullOrEmpty(userData.EMail))
                    {
                        NotificarViaEmail(model, userData);
                    }

                    resultado = true;
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

            sessionManager.SetDatosPagoVisa(null);
            sessionManager.SetListadoEstadoCuenta(null);

            return resultado;
        }

        public void NotificarViaEmail(PagoEnLineaModel model, UsuarioModel userData)
        {
            try
            {
                string template = ObtenerTemplatePagoEnLinea(model, userData.EsLebel, userData.PaisID);
                Util.EnviarMail("no-responder@somosbelcorp.com",
                    userData.EMail,
                    "PAGO EN LINEA",
                    template, true,
                    userData.NombreConsultora);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        private string GenerarAutorizacionBotonPagos(int paisId, string sessionToken, string merchantId, string transactionToken, string accessKeyId, string secretAccessKey)
        {
            var tipoPasarelaVisa = Constantes.PagoEnLineaMetodoPago.PasarelaVisa;
            var listaPasarelaVisa = ObtenerPagoEnLineaTipoPasarela(tipoPasarelaVisa);
            string urlAutorizacionBotonPago = ObtenerValoresTipoPasarela(listaPasarelaVisa, tipoPasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.UrlAutorizacionBotonPago);

            string urlAuthorize = urlAutorizacionBotonPago + merchantId;
            string credentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(accessKeyId + ":" + secretAccessKey));

            Common.PagoEnLinea.Data data = new Common.PagoEnLinea.Data();

            DataRequestAut dataAutorizacionRQ = new DataRequestAut();
            dataAutorizacionRQ.transactionToken = transactionToken;
            dataAutorizacionRQ.sessionToken = sessionToken;
            dataAutorizacionRQ.data = data;

            string json = JsonHelper.JsonSerializer<DataRequestAut>(dataAutorizacionRQ);
            ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;
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

            return respuestaAutorizacion;
        }

        private BEPagoEnLineaResultadoLog GenerarEntidadPagoEnLineaLog(RespuestaAutorizacionVisa respuestaVisa, UsuarioModel usuario)
        {
            BEPagoEnLineaResultadoLog bePagoEnLinea = new BEPagoEnLineaResultadoLog();

            bePagoEnLinea.ConsultoraId = usuario.ConsultoraID;
            bePagoEnLinea.CodigoConsultora = usuario.CodigoConsultora;
            bePagoEnLinea.NumeroDocumento = usuario.DocumentoIdentidad;
            bePagoEnLinea.CampaniaId = usuario.CampaniaID;
            bePagoEnLinea.FechaVencimiento = usuario.FechaLimPago;
            bePagoEnLinea.TipoTarjeta = "VISA";
            bePagoEnLinea.CodigoError = respuestaVisa.errorCode ?? "";
            bePagoEnLinea.MensajeError = respuestaVisa.errorMessage ?? "";
            bePagoEnLinea.IdGuidTransaccion = respuestaVisa.transactionUUID ?? "";
            bePagoEnLinea.IdGuidExternoTransaccion = respuestaVisa.externalTransactionId ?? "";
            bePagoEnLinea.MerchantId = respuestaVisa.merchantId ?? "";
            bePagoEnLinea.IdTokenUsuario = respuestaVisa.userTokenId ?? "";
            bePagoEnLinea.AliasNameTarjeta = respuestaVisa.aliasName ?? "";

            var fechaTransaccion = string.IsNullOrEmpty(respuestaVisa.data.FECHAYHORA_TX) ? DateTime.MinValue.ToString() : respuestaVisa.data.FECHAYHORA_TX;
            bePagoEnLinea.FechaTransaccion = Convert.ToDateTime(fechaTransaccion);
            if (bePagoEnLinea.FechaTransaccion == DateTime.MinValue)
                bePagoEnLinea.FechaTransaccion = DateTime.Now;

            bePagoEnLinea.ResultadoValidacionCVV2 = respuestaVisa.data.RES_CVV2 ?? "";
            bePagoEnLinea.CsiMensaje = respuestaVisa.data.CSIMENSAJE ?? "";
            bePagoEnLinea.IdUnicoTransaccion = respuestaVisa.data.ID_UNICO ?? "";
            bePagoEnLinea.Etiqueta = respuestaVisa.data.ETICKET ?? "";
            bePagoEnLinea.RespuestaSistemAntifraude = respuestaVisa.data.DECISIONCS ?? "";
            bePagoEnLinea.CsiPorcentajeDescuento = Convert.ToDecimal(respuestaVisa.data.CSIPORCENTAJEDESCUENTO ?? "0");
            bePagoEnLinea.NumeroCuota = respuestaVisa.data.NROCUOTA ?? "";
            bePagoEnLinea.TokenTarjetaGuardada = respuestaVisa.data.cardTokenUUID ?? "";
            bePagoEnLinea.CsiImporteComercio = Convert.ToDecimal(respuestaVisa.data.CSIIMPORTECOMERCIO ?? "0");
            bePagoEnLinea.CsiCodigoPrograma = respuestaVisa.data.CSICODIGOPROGRAMA ?? "";
            bePagoEnLinea.DescripcionIndicadorComercioElectronico = respuestaVisa.data.DSC_ECI ?? "";
            bePagoEnLinea.IndicadorComercioElectronico = respuestaVisa.data.ECI ?? "";
            bePagoEnLinea.DescripcionCodigoAccion = respuestaVisa.data.DSC_COD_ACCION ?? "";
            bePagoEnLinea.NombreBancoEmisor = respuestaVisa.data.NOM_EMISOR ?? "";
            bePagoEnLinea.ImporteCuota = Convert.ToDecimal(respuestaVisa.data.IMPCUOTAAPROX ?? "0");
            bePagoEnLinea.CsiTipoCobro = respuestaVisa.data.CSITIPOCOBRO ?? "";
            bePagoEnLinea.NumeroReferencia = respuestaVisa.data.NUMREFERENCIA ?? "";
            bePagoEnLinea.Respuesta = respuestaVisa.data.RESPUESTA ?? "";
            bePagoEnLinea.NumeroOrdenTienda = respuestaVisa.data.NUMORDEN ?? "";
            bePagoEnLinea.CodigoAccion = respuestaVisa.data.CODACCION ?? "";
            bePagoEnLinea.ImporteAutorizado = Convert.ToDecimal(respuestaVisa.data.IMP_AUTORIZADO ?? "0");
            bePagoEnLinea.CodigoAutorizacion = respuestaVisa.data.COD_AUTORIZA ?? "";
            bePagoEnLinea.CodigoTienda = respuestaVisa.data.CODTIENDA ?? "";
            bePagoEnLinea.NumeroTarjeta = respuestaVisa.data.PAN ?? "";
            bePagoEnLinea.OrigenTarjeta = respuestaVisa.data.ORI_TARJETA ?? "";
            bePagoEnLinea.UsuarioCreacion = usuario.CodigoUsuario;

            return bePagoEnLinea;
        }

        private string ObtenerTemplatePagoEnLinea(PagoEnLineaModel model, bool esLbel, int paisId)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "Content\\Template\\mailing_pago_en_linea.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);


            htmlTemplate = htmlTemplate.Replace("#URL_IMAGEN_MARCA#", esLbel ? Constantes.ConfiguracionManager.UrlImagenLbel : Constantes.ConfiguracionManager.UrlImagenEsika);
            htmlTemplate = htmlTemplate.Replace("#COLOR_MARCA#", esLbel ? Constantes.ConfiguracionManager.ColorTemaLbel : Constantes.ConfiguracionManager.ColorTemaEsika);
            htmlTemplate = htmlTemplate.Replace("#LABEL_CARGO#", paisId == Constantes.PaisID.Mexico ? Constantes.PagoEnLineaMensajes.CargoplataformaMx : Constantes.PagoEnLineaMensajes.CargoplataformaPe);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NOMBRECOMPLETO#", model.NombreConsultora + " " + model.PrimerApellido);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMEROOPERACION#", model.NumeroOperacion);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAPAGO#", model.FechaCreacionString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTODEUDA#", model.MontoDeudaString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOGASTOSADMINISTRATIVOS#", model.MontoGastosAdministrativosString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOTOTAL#", model.MontoDeudaConGastosString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_SIMBOLO#", model.Simbolo);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_SALDOPENDIENTE#", model.SaldoPendienteString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAVENCIMIENTO#", model.FechaVencimientoString);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MENSAJEINFORMACION#", model.MensajeInformacionPagoExitoso);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMTARJETA#", model.TarjetaEnmascarada);

            return htmlTemplate;
        }

        public List<PagoEnLineaTipoPasarelaModel> ObtenerPagoEnLineaTipoPasarela(string codigoPlataforma)
        {
            List<PagoEnLineaTipoPasarelaModel> listaTipoPasarelaModel;
            var userData = sessionManager.GetUserData();

            try
            {
                List<BEPagoEnLineaTipoPasarela> listaTipoPasarela;
                using (var ps = new PedidoServiceClient())
                {
                    listaTipoPasarela = ps.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(userData.PaisID, codigoPlataforma).ToList();
                }

                listaTipoPasarelaModel = Mapper.Map<List<PagoEnLineaTipoPasarelaModel>>(listaTipoPasarela);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaTipoPasarelaModel = new List<PagoEnLineaTipoPasarelaModel>();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaTipoPasarelaModel = new List<PagoEnLineaTipoPasarelaModel>();
            }

            return listaTipoPasarelaModel;
        }

        public string ObtenerValoresTipoPasarela(List<PagoEnLineaTipoPasarelaModel> lista, string codigoPlataforma, string codigo)
        {
            string resultado = "";
            var tipoPasarela = lista.FirstOrDefault(p => p.CodigoPlataforma == codigoPlataforma && p.Codigo == codigo);

            if (tipoPasarela != null)
            {
                resultado = tipoPasarela.Valor;
            }

            return resultado;
        }

        public string[] ObtenerCamposRequeridos()
        {
            return ObtenerPagoEnLineaPasarelaCampos()
                .Select(p => p.Codigo)
                .ToArray();
        }

        public string GetUrlIconMedioPago(PagoEnLineaModel model)
        {
            var selected = model.MetodoPagoSeleccionado;
            if (selected == null)
            {
                return string.Empty;
            }

            var medioPagos = ObtenerListaMedioPago();

            var item = medioPagos.FirstOrDefault(m => m.PagoEnLineaMedioPagoId == selected.PagoEnLineaMedioPagoId);

            return item == null ? string.Empty : item.RutaIcono;
        }

        public List<PagoEnLineaPasarelaCamposModel> ObtenerPagoEnLineaPasarelaCampos()
        {
            List<PagoEnLineaPasarelaCamposModel> result;
            var userData = sessionManager.GetUserData();

            try
            {
                List<BEPagoEnLineaPasarelaCampos> list;
                using (var ps = new PedidoServiceClient())
                {
                    list = ps.ObtenerPagoEnLineaPasarelaCampos(userData.PaisID).ToList();
                }

                result = Mapper.Map<List<PagoEnLineaPasarelaCamposModel>>(list);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                result = new List<PagoEnLineaPasarelaCamposModel>();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                result = new List<PagoEnLineaPasarelaCamposModel>();
            }

            return result;
        }

        public PagoEnLineaMedioPagoDetalleModel ObtenerMetodoPagoSelecccionado(PagoEnLineaModel pago, string metodo, string card, int medio)
        {
            return pago.ListaMetodoPago
                .FirstOrDefault(m =>
                    m.TipoPasarelaCodigoPlataforma == metodo &&
                    m.PagoEnLineaMedioPagoId == medio &&
                    m.TipoTarjeta == card);
        }

        public bool CanPay(UsuarioModel userData, PagoEnLineaModel pago)
        {
            return userData.TienePagoEnLinea &&
                   pago.MontoDeuda > 0 &&
                   userData.MontoDeuda >= pago.MontoDeuda;
        }

        public bool IsLoadMetodoPago(PagoEnLineaModel pago)
        {
            return pago != null && pago.MetodoPagoSeleccionado != null && pago.PagoVisaModel != null;
        }

        public IEnumerable<string> ObtenerMeses()
        {
            return Enumerable.Range(1, 12).Select(i => i.ToString("00"));
        }

        public IEnumerable<string> ObtenerAnios()
        {
            return Enumerable.Range(DateTime.Now.Year, MaxYearCard).Select(i => i.ToString());
        }
    }
}