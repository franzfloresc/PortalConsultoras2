using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data.PagoEnLinea;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.PagoEnLinea;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.PagoEnlinea
{
    public class BLPagoEnLinea : IPagoEnLineaBusinessLogic
    {
        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;

        public BLPagoEnLinea() : this(new BLTablaLogicaDatos())
        {

        }

        public BLPagoEnLinea(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
        }

        public int InsertPagoEnLineaResultadoLog(int paisId, BEPagoEnLineaResultadoLog entidad)
        {
            var dataAccess = new DAPagoEnLinea(paisId);
            return dataAccess.InsertPagoEnLineaResultadoLog(entidad);
        }

        public string ObtenerTokenTarjetaGuardadaByConsultora(int paisId, string codigoConsultora)
        {
            var dataAccess = new DAPagoEnLinea(paisId);
            return dataAccess.ObtenerTokenTarjetaGuardadaByConsultora(codigoConsultora);
        }

        public void UpdateMontoDeudaConsultora(int paisId, string codigoConsultora, decimal montoDeuda)
        {
            var dataAccess = new DAPagoEnLinea(paisId);
            dataAccess.UpdateMontoDeudaConsultora(codigoConsultora, montoDeuda);
        }

        public BEPagoEnLineaResultadoLog ObtenerPagoEnLineaById(int paisId, int pagoEnLineaResultadoLogId)
        {
            BEPagoEnLineaResultadoLog entidad = null;
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (IDataReader reader = DAPagoEnLinea.ObtenerPagoEnLineaById(pagoEnLineaResultadoLogId))
                if (reader.Read())
                {
                    entidad = new BEPagoEnLineaResultadoLog(reader);
                }
            return entidad;

        }

        public void UpdateVisualizado(int paisId, int pagoEnLineaResultadoLogId)
        {
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);
            DAPagoEnLinea.UpdateVisualizado(pagoEnLineaResultadoLogId);
        }

        public BEPagoEnLineaResultadoLog ObtenerUltimoPagoEnLineaByConsultoraId(int paisId, long consultoraId)
        {
            BEPagoEnLineaResultadoLog entidad = null;
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (IDataReader reader = DAPagoEnLinea.ObtenerUltimoPagoEnLineaByConsultoraId(consultoraId))
                if (reader.Read())
                {
                    entidad = new BEPagoEnLineaResultadoLog(reader);
                }
            return entidad;
        }

        public List<BEPagoEnLineaResultadoLogReporte> ObtenerPagoEnLineaByFiltro(int paisId, BEPagoEnLineaFiltro filtro)
        {
            var lista = new List<BEPagoEnLineaResultadoLogReporte>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaByFiltro(filtro))
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaResultadoLogReporte(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaTipoPago> ObtenerPagoEnLineaTipoPago(int paisId)
        {
            var lista = new List<BEPagoEnLineaTipoPago>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaTipoPago())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaTipoPago(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaMedioPago> ObtenerPagoEnLineaMedioPago(int paisId)
        {
            var lista = new List<BEPagoEnLineaMedioPago>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaMedioPago())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaMedioPago(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaMedioPagoDetalle> ObtenerPagoEnLineaMedioPagoDetalle(int paisId)
        {
            var lista = new List<BEPagoEnLineaMedioPagoDetalle>();
            var daPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = daPagoEnLinea.ObtenerPagoEnLineaMedioPagoDetalle())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaMedioPagoDetalle(reader));
                }
            }

            CargarConfiguracion_MedioPagoDetalle(paisId, lista.Where(e => e.Estado).ToList());

            return lista;
        }

        private void CargarConfiguracion_MedioPagoDetalle(int paisId, List<BEPagoEnLineaMedioPagoDetalle> pagoEnLineaMedioPagoDetalles)
        {
            pagoEnLineaMedioPagoDetalles.ForEach(item => {
                switch (item.TipoPasarelaCodigoPlataforma) {
                    case Constantes.PagoEnLineaMetodoPago.PasarelaVisa:
                        if(item.TipoTarjeta == Constantes.PagoEnLineaTipoTarjeta.Credito) CargarConfiguracion_MedioPagoDetalle_Visa(paisId, item);
                        break;
                    case Constantes.PagoEnLineaMetodoPago.PasarelaBelcorpPayU:
                        CargarConfiguracion_MedioPagoDetalle_Payu(paisId, item);
                        break;
                }
            });
        }

        private void CargarConfiguracion_MedioPagoDetalle_Visa(int paisId, BEPagoEnLineaMedioPagoDetalle metodoPago)
        {
            var provider = new NumberFormatInfo() { NumberDecimalSeparator = "." };

            var listaConfiguracionPasarelaVisa = ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(paisId, Constantes.PagoEnLineaMetodoPago.PasarelaVisa);

            var porcentajeGastosAdministrativosString = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, Constantes.PagoEnLineaMetodoPago.PasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.PorcentajeGastosAdministrativos);
            decimal porcentajeGastosAdministrativos = 0;
            decimal.TryParse(porcentajeGastosAdministrativosString, NumberStyles.Any, provider, out porcentajeGastosAdministrativos);
            metodoPago.PorcentajeGastosAdministrativos = porcentajeGastosAdministrativos;
            metodoPago.PagoEnLineaGastosLabel = Constantes.PagoEnLineaMensajes.GastosLabel.ContainsKey(paisId) ? Constantes.PagoEnLineaMensajes.GastosLabel[paisId] : "";

            var montoMinimoPagoString = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, Constantes.PagoEnLineaMetodoPago.PasarelaVisa, Constantes.PagoEnLineaPasarelaVisa.MontoMinimoPago);
            decimal montoMinimoPago;
            if (decimal.TryParse(montoMinimoPagoString, NumberStyles.Any, provider, out montoMinimoPago)) metodoPago.MontoMinimoPago = montoMinimoPago;
        }

        private void CargarConfiguracion_MedioPagoDetalle_Payu(int paisId, BEPagoEnLineaMedioPagoDetalle metodoPago)
        {
            var provider = new NumberFormatInfo() { NumberDecimalSeparator = "." };

            var listaConfiguracionPasarelaPayu = ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(paisId, Constantes.PagoEnLineaMetodoPago.PasarelaBelcorpPayU);

            var montoMinimoPagoString = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaPayu, Constantes.PagoEnLineaMetodoPago.PasarelaBelcorpPayU, Constantes.PagoEnLineaPasarelaPayu.MontoMinimoPago);
            decimal montoMinimoPago;
            if (decimal.TryParse(montoMinimoPagoString, NumberStyles.Any, provider, out montoMinimoPago)) metodoPago.MontoMinimoPago = montoMinimoPago;
        }

        public List<BEPagoEnLineaTipoPasarela> ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(int paisId, string codigoPlataforma)
        {
            var lista = new List<BEPagoEnLineaTipoPasarela>();
            var DAPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = DAPagoEnLinea.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(codigoPlataforma))
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaTipoPasarela(reader));
                }
            }

            return lista;
        }

        public List<BEPagoEnLineaPasarelaCampos> ObtenerPagoEnLineaPasarelaCampos(int paisId)
        {
            var lista = new List<BEPagoEnLineaPasarelaCampos>();
            var daPagoEnLinea = new DAPagoEnLinea(paisId);

            using (var reader = daPagoEnLinea.ObtenerPagoEnLineaPasarelaCampos())
            {
                while (reader.Read())
                {
                    lista.Add(new BEPagoEnLineaPasarelaCampos(reader));
                }
            }

            return lista;
        }

        public int ObtenerNumeroOrden(int paisId)
        {
            return new DAPagoEnLinea(paisId).ObtenerNumeroOrden();
        }

        public string ObtenerPagoEnLineaURLPaginasBancos(int paisId)
        {
            return new DAPagoEnLinea(paisId).ObtenerPagoEnLineaURLPaginasBancos();
        }

        public List<BEPagoEnLineaBanco> ObtenerPagoEnLineaBancos(int paisId)
        {
            return (new DAPagoEnLinea(paisId).ObtenerPagoEnLineaBancos())
                .MapToCollection<BEPagoEnLineaBanco>();
        }

        private decimal ObtenerDeuda(int paisId, long consultoraId, string codigoUsuario)
        {
            return new BLResumenCampania().GetMontoDeuda(paisId, 0, (int)consultoraId, codigoUsuario, true);
        }

        public BEPagoEnLinea ObtenerPagoEnLineaConfiguracion(int paisId, long consultoraId, string codigoUsuario)
        {
            var result = new BEPagoEnLinea();
            List<BETablaLogicaDatos> listaConfiguracion = null;

            var listaMetodoPagoTask = Task.Run(() => result.ListaMetodoPago = ObtenerPagoEnLineaMedioPagoDetalle(paisId));
            var listaMedioPagoTask = Task.Run(() => result.ListaMedioPago = ObtenerPagoEnLineaMedioPago(paisId));
            var listaTipoPagoTask = Task.Run(() => result.ListaTipoPago = ObtenerPagoEnLineaTipoPago(paisId));
            var montoDeudaTask = Task.Run(() => result.MontoDeuda = ObtenerDeuda(paisId, consultoraId, codigoUsuario));
            var listaBancoTask = Task.Run(() => result.ListaBanco = ObtenerPagoEnLineaBancos(paisId) ?? new List<BEPagoEnLineaBanco>());
            var listaConfiguracionTask = Task.Run(() => listaConfiguracion = _tablaLogicaDatosBusinessLogic.GetListCache(paisId, Constantes.TablaLogica.ValoresPagoEnLinea));

            Task.WaitAll(listaMetodoPagoTask, listaMedioPagoTask, listaTipoPagoTask, montoDeudaTask, listaBancoTask, listaConfiguracionTask);

            if (listaConfiguracion != null)
            {
                var enableExternalApp_String = listaConfiguracion.Where(e => e.TablaLogicaDatosID == Constantes.TablaLogicaDato.PagoEnLinea.Habilitar_App_PBI_ExternalApp).Select(e => e.Valor).FirstOrDefault();
                if (enableExternalApp_String != "1") result.ListaBanco.ForEach(e => e.URIExternalApp = null);
            }
            if (!result.ListaBanco.Any(e => e.Estado))
            {
                var pagoBancaPorInternet = result.ListaMedioPago.FirstOrDefault(e => e.Codigo == Constantes.PagoEnLineaPasarela.PBI && e.Estado);
                if (pagoBancaPorInternet != null) pagoBancaPorInternet.Estado = false;
            }

            //result.ListaMedioPago.Where(e => e.Estado && e.Codigo != Constantes.PagoEnLineaPasarela.PBI)
            //    .All(e =>
            //    {
            //        e.Estado = result.ListaMetodoPago.Any(p => p.PagoEnLineaMedioPagoId == e.PagoEnLineaMedioPagoId);
            //        return true;
            //    });

            result.ListaMedioPago.ForEach(e =>
            {
                if (e.Estado && e.Codigo != Constantes.PagoEnLineaPasarela.PBI)
                {
                    e.Estado = result.ListaMetodoPago.Any(p => p.PagoEnLineaMedioPagoId == e.PagoEnLineaMedioPagoId);
                }
            });

            return result;
        }

        public BEPagoEnLineaVisa ObtenerPagoEnLineaVisaConfiguracion(int paisId, string codigoConsutora)
        {
            List<BEPagoEnLineaTipoPasarela> listaConfiguracionPasarelaVisa = null;
            var pasarela = Constantes.PagoEnLineaMetodoPago.PasarelaVisa;
            var result = new BEPagoEnLineaVisa();

            var listaConfiguracionVisaTask = Task.Run(() => listaConfiguracionPasarelaVisa = ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(paisId, pasarela));
            var obtenerTokenTarjetaGuardadaTask = Task.Run(() => result.TokenTarjetaGuardada = ObtenerTokenTarjetaGuardadaByConsultora(paisId, codigoConsutora));

            Task.WaitAll(listaConfiguracionVisaTask, obtenerTokenTarjetaGuardadaTask);

            result.SessionToken = Guid.NewGuid().ToString().ToUpper();
            if (listaConfiguracionPasarelaVisa != null)
            {
                result.EndPointURL = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, pasarela, Constantes.PagoEnLineaPasarelaVisa.UrlAutorizacionPagoApp);
                result.MerchantId = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, pasarela, Constantes.PagoEnLineaPasarelaVisa.MerchantId);
                result.AccessKeyId = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, pasarela, Constantes.PagoEnLineaPasarelaVisa.AccessKeyId);
                result.SecretAccessKey = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, pasarela, Constantes.PagoEnLineaPasarelaVisa.SecretAccessKey);
                result.NextCounterURL = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, pasarela, Constantes.PagoEnLineaPasarelaVisa.UrlGenerarNumeroPedido);
                result.TerminosUsoURL = ObtenerValoresTipoPasarela(listaConfiguracionPasarelaVisa, pasarela, Constantes.PagoEnLineaPasarelaVisa.UrlTerminosUsoApp);
                result.Recurrence = Constantes.PagoEnLineaPasarelaVisa.Recurrence;
                result.RecurrenceAmount = Constantes.PagoEnLineaPasarelaVisa.RecurrenceAmount;
                result.RecurrenceFrequency = string.Empty;
                result.RecurrenceType = string.Empty;
            }

            return result;
        }

        private string ObtenerValoresTipoPasarela(List<BEPagoEnLineaTipoPasarela> lista, string codigoPlataforma, string codigo)
        {
            return lista.Where(p => p.CodigoPlataforma == codigoPlataforma && p.Codigo == codigo)
                        .Select(p => p.Valor).FirstOrDefault() ?? string.Empty;
        }

        public BERespuestaServicio RegistrarPagoEnLineaVisa(BEUsuario usuario, BEPagoEnLineaVisa pagoEnLineaVisa)
        {

            //Guardar el Log de Pago en Linea
            var bePagoEnLinea = GenerarEntidadPagoEnLineaLog(usuario, pagoEnLineaVisa);
            var accionLog = InsertPagoEnLineaResultadoLog(usuario.PaisID, bePagoEnLinea);

            if (bePagoEnLinea.CodigoError == Constantes.PagoEnLineaPasarelaVisa.Code.CodigoError_Success && bePagoEnLinea.CodigoAccion == Constantes.PagoEnLineaPasarelaVisa.Code.CodigoAccion_Success && accionLog == Constantes.PagoEnLineaResultadoLog.Accion_Insert)
            {
                //Actualizar el Monto Deuda
                decimal MontoDeuda = ObtenerDeuda(usuario.PaisID, usuario.ConsultoraID, usuario.CodigoUsuario);
                var saldoPendiente = decimal.Round(MontoDeuda - pagoEnLineaVisa.MontoPago, 2);
                UpdateMontoDeudaConsultora(usuario.PaisID, usuario.CodigoConsultora, saldoPendiente);

                //Notificar Pago Via Email
                var listaConfiguracion = _tablaLogicaDatosBusinessLogic.GetListCache(usuario.PaisID, Constantes.TablaLogica.ValoresPagoEnLinea);
                var mensajeExitoso = listaConfiguracion.Where(p => p.TablaLogicaDatosID == Constantes.TablaLogicaDato.MensajeInformacionPagoExitoso).Select(p => p.Codigo)
                                                       .SingleOrDefault() ?? string.Empty;
                if (!string.IsNullOrEmpty(usuario.EMail) && pagoEnLineaVisa.Data != null)
                {
                    NotificarViaEmail(usuario, pagoEnLineaVisa, bePagoEnLinea, saldoPendiente, mensajeExitoso);
                }

                return PagoEnLineaRespuestaServicio(Constantes.PagoEnLineaRespuestaServicio.Code.SUCCESS, saldoPendiente: saldoPendiente, pagoEnLineaResultadoLogId: bePagoEnLinea.PagoEnLineaResultadoLogId);
            }

            return PagoEnLineaRespuestaServicio(Constantes.PagoEnLineaRespuestaServicio.Code.SUCCESS_YA_AGREGADO, pagoEnLineaResultadoLogId: bePagoEnLinea.PagoEnLineaResultadoLogId);
        }

        private void NotificarViaEmail(BEUsuario usuario, BEPagoEnLineaVisa pagoEnLineaVisa, BEPagoEnLineaResultadoLog bePagoEnLinea, decimal saldoPendiente, string mensajeExitoso)
        {
            try
            {
                var template = ObtenerTemplatePagoEnLinea(usuario, pagoEnLineaVisa, bePagoEnLinea, saldoPendiente, mensajeExitoso);
                Util.EnviarMail(Constantes.PagoEnLineaNotificacion.Email_Notifier, usuario.EMail, Constantes.PagoEnLineaNotificacion.Email_Titulo, template, true, usuario.Nombre);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
            }
        }

        private string ObtenerTemplatePagoEnLinea(BEUsuario usuario, BEPagoEnLineaVisa pagoEnLineaVisa, BEPagoEnLineaResultadoLog bePagoEnLinea, decimal saldoPendiente, string mensajeInformacionPagoExitoso)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + Constantes.PagoEnLineaNotificacion.Email_Template;
            string htmlTemplate = FileManager.GetContenido(templatePath);
            var esLbel = !WebConfig.PaisesEsika.Contains(Util.GetPaisISO(usuario.PaisID));

            htmlTemplate = htmlTemplate.Replace("#URL_IMAGEN_MARCA#", esLbel ? Constantes.ConfiguracionManager.UrlImagenLbel : Constantes.ConfiguracionManager.UrlImagenEsika);
            htmlTemplate = htmlTemplate.Replace("#COLOR_MARCA#", esLbel ? Constantes.ConfiguracionManager.ColorTemaLbel : Constantes.ConfiguracionManager.ColorTemaEsika);
            htmlTemplate = htmlTemplate.Replace("#LABEL_CARGO#", usuario.PaisID == Constantes.PaisID.Mexico ? Constantes.PagoEnLineaMensajes.CargoplataformaMx : Constantes.PagoEnLineaMensajes.CargoplataformaPe);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NOMBRECOMPLETO#", usuario.PrimerNombre + " " + usuario.PrimerApellido);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMEROOPERACION#", bePagoEnLinea.NumeroOrdenTienda);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAPAGO#", bePagoEnLinea.FechaTransaccion.ToString(Constantes.Formatos.Fecha) == "01/01/0001" ? "--/--" : bePagoEnLinea.FechaTransaccion.ToString(Constantes.Formatos.FechaHora));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTODEUDA#", Util.DecimalToStringFormat(pagoEnLineaVisa.MontoPago, usuario.CodigoISO));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOGASTOSADMINISTRATIVOS#", Util.DecimalToStringFormat(pagoEnLineaVisa.MontoGastosAdministrativos, usuario.CodigoISO));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MONTOTOTAL#", Util.DecimalToStringFormat(pagoEnLineaVisa.MontoDeudaConGastos, usuario.CodigoISO));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_SIMBOLO#", usuario.Simbolo);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_SALDOPENDIENTE#", Util.DecimalToStringFormat(saldoPendiente, usuario.CodigoISO));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_FECHAVENCIMIENTO#", usuario.FechaLimPago.ToString(Constantes.Formatos.Fecha));
            htmlTemplate = htmlTemplate.Replace("#FORMATO_MENSAJEINFORMACION#", mensajeInformacionPagoExitoso);
            htmlTemplate = htmlTemplate.Replace("#FORMATO_NUMTARJETA#", bePagoEnLinea.NumeroTarjeta);

            return htmlTemplate;
        }

        private BEPagoEnLineaResultadoLog GenerarEntidadPagoEnLineaLog(BEUsuario usuario, BEPagoEnLineaVisa respuestaVisa)
        {
            var bePagoEnLinea = new BEPagoEnLineaResultadoLog();
            var provider = new NumberFormatInfo() { NumberDecimalSeparator = "." };

            bePagoEnLinea.ConsultoraId = usuario.ConsultoraID;
            bePagoEnLinea.CodigoConsultora = usuario.CodigoConsultora;
            bePagoEnLinea.NumeroDocumento = usuario.DocumentoIdentidad;
            bePagoEnLinea.CampaniaId = usuario.CampaniaID;
            bePagoEnLinea.FechaVencimiento = usuario.FechaLimPago;
            bePagoEnLinea.TipoTarjeta = Constantes.PagoEnLineaPasarela.Visa;
            bePagoEnLinea.CodigoError = respuestaVisa.PaymentStatus ?? string.Empty;
            bePagoEnLinea.MensajeError = respuestaVisa.PaymentDescription ?? string.Empty;
            bePagoEnLinea.IdGuidTransaccion = respuestaVisa.TransactionUUID ?? string.Empty;
            bePagoEnLinea.IdGuidExternoTransaccion = respuestaVisa.ExternalTransactionId ?? string.Empty;
            bePagoEnLinea.IdTokenUsuario = respuestaVisa.UserTokenId ?? string.Empty;
            bePagoEnLinea.AliasNameTarjeta = respuestaVisa.AliasNameTarjeta ?? string.Empty;

            bePagoEnLinea.FechaTransaccion = Util.ParseDate(respuestaVisa.Data.FECHAYHORA_TX, "dd/MM/yyyy HH:mm") ?? DateTime.Now;
            bePagoEnLinea.ResultadoValidacionCVV2 = respuestaVisa.Data.RES_CVV2 ?? string.Empty;
            bePagoEnLinea.CsiMensaje = respuestaVisa.Data.CSIMENSAJE ?? string.Empty;
            bePagoEnLinea.IdUnicoTransaccion = respuestaVisa.Data.ID_UNICO ?? string.Empty;
            bePagoEnLinea.Etiqueta = respuestaVisa.Data.ETICKET ?? string.Empty;
            bePagoEnLinea.RespuestaSistemAntifraude = respuestaVisa.Data.DECISIONCS ?? string.Empty;
            bePagoEnLinea.CsiPorcentajeDescuento = Util.ParseDecimal(respuestaVisa.Data.CSIPORCENTAJEDESCUENTO, provider);
            bePagoEnLinea.NumeroCuota = respuestaVisa.Data.NROCUOTA ?? string.Empty;
            bePagoEnLinea.TokenTarjetaGuardada = respuestaVisa.Data.CARDTOKENUUID ?? string.Empty;
            bePagoEnLinea.CsiImporteComercio = Util.ParseDecimal(respuestaVisa.Data.CSIIMPORTECOMERCIO, provider);
            bePagoEnLinea.CsiCodigoPrograma = respuestaVisa.Data.CSICODIGOPROGRAMA ?? string.Empty;
            bePagoEnLinea.DescripcionIndicadorComercioElectronico = respuestaVisa.Data.DSC_ECI ?? string.Empty;
            bePagoEnLinea.IndicadorComercioElectronico = respuestaVisa.Data.ECI ?? string.Empty;
            bePagoEnLinea.DescripcionCodigoAccion = respuestaVisa.Data.DSC_COD_ACCION ?? string.Empty;
            bePagoEnLinea.NombreBancoEmisor = respuestaVisa.Data.NOM_EMISOR ?? string.Empty;
            bePagoEnLinea.ImporteCuota = Util.ParseDecimal(respuestaVisa.Data.IMPCUOTAAPROX, provider);
            bePagoEnLinea.CsiTipoCobro = respuestaVisa.Data.CSITIPOCOBRO ?? string.Empty;
            bePagoEnLinea.NumeroReferencia = respuestaVisa.Data.NUMREFERENCIA ?? string.Empty;
            bePagoEnLinea.Respuesta = respuestaVisa.Data.RESPUESTA ?? string.Empty;
            bePagoEnLinea.NumeroOrdenTienda = respuestaVisa.Data.NUMORDEN ?? string.Empty;
            bePagoEnLinea.CodigoAccion = respuestaVisa.Data.CODACCION ?? string.Empty;
            bePagoEnLinea.ImporteAutorizado = Util.ParseDecimal(respuestaVisa.Data.IMP_AUTORIZADO, provider);
            bePagoEnLinea.CodigoAutorizacion = respuestaVisa.Data.COD_AUTORIZA ?? string.Empty;
            bePagoEnLinea.CodigoTienda = respuestaVisa.Data.CODTIENDA ?? string.Empty;
            bePagoEnLinea.NumeroTarjeta = respuestaVisa.Data.PAN ?? string.Empty;
            bePagoEnLinea.OrigenTarjeta = respuestaVisa.Data.ORI_TARJETA ?? string.Empty;
            bePagoEnLinea.MontoPago = respuestaVisa.MontoPago;
            bePagoEnLinea.MontoGastosAdministrativos = respuestaVisa.MontoGastosAdministrativos;

            bePagoEnLinea.UsuarioCreacion = usuario.CodigoUsuario;
            bePagoEnLinea.Origen = respuestaVisa.Origen;

            if (bePagoEnLinea.CodigoError == Constantes.PagoEnLineaPasarelaVisa.Code.CodigoError_Success && bePagoEnLinea.CodigoAccion == Constantes.PagoEnLineaPasarelaVisa.Code.CodigoAccion_Success)
                bePagoEnLinea.MerchantId = respuestaVisa.MerchantId ?? string.Empty;
            else
                bePagoEnLinea.MerchantId = string.Empty;

            return bePagoEnLinea;
        }

        private BERespuestaServicio PagoEnLineaRespuestaServicio(string code, string message = null, int? pagoEnLineaResultadoLogId = null, decimal? saldoPendiente = null)
        {
            if (string.IsNullOrEmpty(message))
            {
                message = Constantes.PagoEnLineaRespuestaServicio.Message.ContainsKey(code) ?
                                    Constantes.PagoEnLineaRespuestaServicio.Message[code] : message;
            }

            return new BERespuestaServicio()
            {
                Code = code,
                Message = message,
                Data = JsonConvert.SerializeObject(new { PagoEnLineaResultadoLogId = pagoEnLineaResultadoLogId, SaldoPendiente = saldoPendiente })
            };
        }

    }
}