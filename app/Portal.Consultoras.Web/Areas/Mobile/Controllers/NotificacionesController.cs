using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class NotificacionesController : BaseMobileController
    {
        readonly CdrProvider _cdrProvider;
        readonly NotificacionProvider _notificacionProvider;

        public NotificacionesController()
        {
            _cdrProvider = new CdrProvider();
            _notificacionProvider = new NotificacionProvider();
        }

        #region Acciones

        public ActionResult Index()
        {
            Session["fechaGetNotificacionesSinLeer"] = null;
            Session["cantidadGetNotificacionesSinLeer"] = null;

            var model = new NotificacionesModel { ListaNotificaciones = ObtenerNotificaciones() };
            return View(model);
        }

        public ActionResult DetalleSolicitudCliente(long SolicitudId)
        {

            var notificaciones = ObtenerNotificaciones();
            var notificacion = notificaciones.FirstOrDefault(p => p.ProcesoId == SolicitudId);
            var model = new SolicitudClienteConsultoraModel();

            using (var service = new SACServiceClient())
            {
                var beSolicitudCliente = service.GetSolicitudCliente(userData.PaisID, SolicitudId);
                var tablalogicaDatos = service.GetTablaLogicaDatos(userData.PaisID, 56);

                int horasReasignacion = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo);
                string horaEjecucionDefault = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5602).Codigo;
                DateTime fechaEjecucion = beSolicitudCliente.FechaSolicitud.AddHours(horasReasignacion);
                var horaEjecucionDefecto = TimeSpan.ParseExact(horaEjecucionDefault, "g", null);

                if (fechaEjecucion.Hour > horaEjecucionDefecto.Hours)
                {
                    fechaEjecucion = fechaEjecucion.AddDays(1);
                    fechaEjecucion = fechaEjecucion.Date + horaEjecucionDefecto;
                }

                if (notificacion != null) model.Asunto = notificacion.Asunto;
                model.ConsultoraID = beSolicitudCliente.CodigoConsultora;
                model.Estado = beSolicitudCliente.Estado;
                model.SolicitudClienteId = SolicitudId;
                model.FechaEjecucion = fechaEjecucion;
                model.MarcaID = beSolicitudCliente.MarcaID;
                model.FechaDescripcion = fechaEjecucion.Day + " de " + Util.NombreMes(fechaEjecucion.Month);
                model.TelefonoCliente = beSolicitudCliente.Telefono;
                model.NombreCliente = beSolicitudCliente.NombreCompleto;
                model.EmailCliente = beSolicitudCliente.Email;
                model.NumIteracion = beSolicitudCliente.NumIteracion;
                model.Mensaje = beSolicitudCliente.Mensaje;
                model.MensajeaCliente = beSolicitudCliente.MensajeaCliente;
                model.MarcaNombre = beSolicitudCliente.MarcaNombre;
                model.Campania = beSolicitudCliente.Campania;
                model.CodigoUbigeo = beSolicitudCliente.CodigoUbigeo;
                model.lsProductosDetalle = service.GetSolicitudClienteDetalle(userData.PaisID, SolicitudId).ToList();
            }

            ViewBag.PaisID = userData.PaisID;
            ViewBag.NombreCompleto = userData.NombreConsultora;
            ViewBag.Marca = model.MarcaNombre;

            return View("DetalleSolicitudCliente", model);
        }

        public JsonResult AceptarSolicitud(long SolicitudId, long ConsultoraID, string Marca, string emailCliente, string NombreCliente, string MensajeaCliente)
        {

            try
            {
                using (var service = new SACServiceClient())
                {
                    var beSolicitudCliente = new ServiceSAC.BESolicitudCliente
                    {
                        SolicitudClienteID = SolicitudId,
                        CodigoConsultora = ConsultoraID.ToString(),
                        MensajeaCliente = MensajeaCliente,
                        UsuarioModificacion = userData.CodigoUsuario,
                        Estado = "A"
                    };
                    service.UpdSolicitudCliente(userData.PaisID, beSolicitudCliente);
                }

                using (var service = new ClienteServiceClient())
                {
                    var beCliente = new ServiceCliente.BECliente
                    {
                        ConsultoraID = ConsultoraID,
                        eMail = emailCliente,
                        Nombre = NombreCliente,
                        PaisID = userData.PaisID,
                        Activo = true
                    };
                    service.Insert(beCliente);

                }

                var titulo = "(" + userData.CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(Marca);
                var mensaje = new StringBuilder();
                mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(NombreCliente));
                mensaje.AppendFormat("{0}</p><br/>", MensajeaCliente);
                mensaje.Append("<br/>Saludos,<br/><br />");
                mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                mensaje.AppendFormat("<td><p style='text-align: center;'><strong>{0}<br/>Consultora</strong></p></td></tr></table>", userData.NombreConsultora);
                try
                {
                    Util.EnviarMail3(userData.EMail, emailCliente, titulo, mensaje.ToString(), true, string.Empty);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                var data = new
                {
                    success = true,
                    message = ""
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                var data = new
                {
                    success = false,
                    message = "Ocurrió un error inesperado " + ex.Message
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult RechazarSolicitud(long SolicitudId, int NumIteracion, string CodigoUbigeo, string Campania, int MarcaId)
        {
            
            using (var service = new SACServiceClient())
            {
                var tablalogicaDatos = service.GetTablaLogicaDatos(userData.PaisID, 56);

                var numIteracionMaximo = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5601).Codigo);

                if (NumIteracion == numIteracionMaximo)
                {
                    service.RechazarSolicitudCliente(userData.PaisID, SolicitudId, true, 6, "");
                }
                else
                {
                    var nuevaConsultora = service.ReasignarSolicitudCliente(userData.PaisID, SolicitudId, CodigoUbigeo, Campania, MarcaId, 6, "");
                    if (nuevaConsultora == null)
                    {
                        service.RechazarSolicitudCliente(userData.PaisID, SolicitudId, true, 6, "");
                    }
                    else
                    {
                        try
                        {
                            var horas = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo;
                            var asunto = "(" + userData.CodigoISO + ") Nuevo Pedido " + nuevaConsultora.MarcaNombre;
                            var mensaje = new StringBuilder();
                            mensaje.Append("<p>Estimada " + nuevaConsultora.Nombre + ",<br/><br/>");
                            mensaje.Append("<p>¡Un nuevo cliente eligió contactarse contigo para solicitarte un pedido!<br/>");
                            mensaje.Append("Para ver que productos fueron solicitados y los datos del cliente, entra a<br/>");
                            mensaje.Append("<a href=\"https://www.somosbelcorp.com/Notificaciones\">https://www.somosbelcorp.com/Notificaciones</a> y haz clic en el ícono de mensaje en la parte <br/>");
                            mensaje.Append("superior del menú.<br/><br/>");
                            mensaje.AppendFormat("Recuerda que sólo tienes {0} horas para leer la notificación y decidir si <br/>", horas);
                            mensaje.AppendFormat("aceptas o rechazas el pedido. Si te demoras más de {0} horas, el pedido <br/>", horas);
                            mensaje.Append("será asignado a otra consultora y ya no podrás ver los datos del cliente.<br/><br/>");
                            mensaje.Append("Gracias,<br/>Belcorp.</p>");

                            Util.EnviarMailMobile("no-responder@somosbelcorp.com", nuevaConsultora.Email, asunto, mensaje.ToString(), true);
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                        }
                    }
                }
            }

            var data = new
            {
                success = true,
                message = "Rechazado"
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ListarObservaciones(long ProcesoId, int TipoOrigen)
        {
            List<BENotificacionesDetalle> lstObservaciones;
            List<BENotificacionesDetallePedido> lstObservacionesPedido;
            _notificacionProvider.GetNotificacionesValAutoProl(ProcesoId, TipoOrigen, userData.PaisID, out lstObservaciones, out lstObservacionesPedido);

            var model = new NotificacionesMobileModel();
            model.ListaNotificacionesDetalle = lstObservaciones;
            model.ListaNotificacionesDetallePedido = lstObservacionesPedido;
            model.NombreConsultora = userData.NombreConsultora;
            model.Origen = TipoOrigen;
            model.TieneDescuentoCuv = userData.EstadoSimplificacionCUV && model.ListaNotificacionesDetallePedido != null &&
                model.ListaNotificacionesDetallePedido.Any(item => string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOferta == 1);
            
            var notificacion = ObtenerNotificaciones().FirstOrDefault(p => p.ProcesoId == ProcesoId);
            if (notificacion != null)
            {
                model.Asunto = notificacion.Asunto;
                model.Campania = notificacion.CampaniaId;
                model.estado = notificacion.Estado;
                model.Observaciones = notificacion.Observaciones;
                model.FechaFacturacion = notificacion.FechaFacturacion;
                model.FacturaHoy = notificacion.FacturaHoy;
            }

            if (model.TieneDescuentoCuv)
            {
                model.SubTotal = model.ListaNotificacionesDetallePedido.Sum(p => p.ImporteTotal);
                model.Descuento = -model.ListaNotificacionesDetallePedido[0].DescuentoProl;
                model.Total = model.SubTotal + model.Descuento;
            }
            else model.Total = model.ListaNotificacionesDetallePedido.Sum(p => p.ImporteTotal);
            model.DecimalToString = _notificacionProvider.CreateConverterDecimalToString(userData.PaisID);
            
            return View("ListadoObservaciones", model);
        }

        public ActionResult ListarObservacionesStock(long ProcesoId)
        {
            
            var notificaciones = ObtenerNotificaciones();
            var notificacion = notificaciones.FirstOrDefault(p => p.ProcesoId == ProcesoId);
            List<BENotificacionesDetallePedido> lstObservacionesPedido = new List<BENotificacionesDetallePedido>();
            var model = new NotificacionesMobileModel();

            if (notificacion != null)
            {
                long valStockId = Int64.Parse(notificacion.Observaciones);
                using (var service = new UsuarioServiceClient())
                {
                    lstObservacionesPedido = service.GetValidacionStockProductos(userData.PaisID, userData.ConsultoraID, valStockId).ToList();
                }
            }

            foreach (var item in lstObservacionesPedido)
            {
                if (item.StockDisponible == 0)
                    item.ObservacionPROL = string.Format("El producto {0} - {1} - cuenta nuevamente con stock. Si deseas agrégalo a tu pedido.", item.CUV, item.Descripcion);
                else
                {
                    var txtAdd = string.Format(" del producto {0} - {1}. Si deseas agrégalo a tu pedido.", item.CUV, item.Descripcion);
                    if (item.StockDisponible == 1)
                        item.ObservacionPROL = "Nos ingresó 1 unidad" + txtAdd;
                    else
                        item.ObservacionPROL = "Nos ingresaron " + item.StockDisponible + " unidades" + txtAdd;
                }
            }

            if (notificacion != null)
            {
                model.Asunto = notificacion.Asunto;
                model.FechaFacturacion = notificacion.FechaHoraValidación;
            }

            model.ListaNotificacionesDetalle = new List<BENotificacionesDetalle>();
            model.ListaNotificacionesDetallePedido = lstObservacionesPedido;
            model.NombreConsultora = userData.NombreConsultora;
            model.Origen = 3;

            return View("DetalleObservacionesStock", model);
        }

        public ActionResult DetalleSolicitudClienteCatalogo(long SolicitudId)
        {
            
            var model = new NotificacionesModel();

            var notificaciones = ObtenerNotificaciones();
            var notificacion = notificaciones.FirstOrDefault(p => p.Proceso.ToUpper() == "CATALOGO" && p.ProcesoId == SolicitudId);

            using (var sv = new UsuarioServiceClient())
            {
                model.NotificacionDetalleCatalogo = sv.ObtenerDetalleNotificacion(userData.PaisID, SolicitudId);
            }

            if (notificacion != null)
            {
                ViewBag.Asunto = notificacion.Asunto;
                ViewBag.Campania = notificacion.CampaniaId;
                ViewBag.FechaEjecucion = notificacion.FechaHoraValidación;
            }

            return View("DetalleSolicitudClienteCatalogo", model);
        }

        public ActionResult DetallePedidoRechazado(long ProcesoId)
        {
            NotificacionesModel model = new NotificacionesModel();
            List<BELogGPRValidacion> logsGprValidacion;

            using (PedidoRechazadoServiceClient sv = new PedidoRechazadoServiceClient())
            {
                logsGprValidacion = sv.GetBELogGPRValidacionByGetLogGPRValidacionId(userData.PaisID, ProcesoId, userData.ConsultoraID).ToList();
            }

            _notificacionProvider.CargarMensajesNotificacionesGPR(model, logsGprValidacion, userData.CodigoISO, userData.Simbolo, userData.MontoMinimo, userData.MontoMaximo);
            model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            model.CampaniaDescripcion = userData.CampaniaID.ToString();

            return View("ListadoPedidoRechazadoDetalle", model);
        }

        public ActionResult DetalleNotificacionesCDR(long solicitudId, string Proceso)
        {
            if (Proceso == "CDR" || Proceso == "CDR-CULM")
            {
                var cdrWeb = new BECDRWeb();
                var logCdrWeb = new BELogCDRWeb();
                var listaCdrWebDetalle = new List<BECDRWebDetalle>();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    if (Proceso == "CDR")
                    {
                        logCdrWeb = sv.GetLogCDRWebByLogCDRWebId(userData.PaisID, solicitudId);
                        listaCdrWebDetalle = sv.GetCDRWebDetalleLog(userData.PaisID, logCdrWeb).ToList();
                    }
                    else if (Proceso == "CDR-CULM")
                    {
                        cdrWeb = sv.GetCDRWebByLogCDRWebCulminadoId(userData.PaisID, solicitudId);
                        listaCdrWebDetalle = sv.GetCDRWebDetalleByLogCDRWebCulminadoId(userData.PaisID, solicitudId).ToList();
                    }
                }

                listaCdrWebDetalle.Update(p => p.Solicitud = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado, userData.PaisID).Descripcion);
                listaCdrWebDetalle.Update(p => p.SolucionSolicitada = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado, userData.PaisID).Descripcion);

                var model = Proceso == "CDR-CULM" ? Mapper.Map<CDRWebModel>(cdrWeb) : Mapper.Map<CDRWebModel>(logCdrWeb);
                model.CodigoIso = userData.CodigoISO;
                model.NombreConsultora = userData.NombreConsultora;
                model.Simbolo = userData.Simbolo;
                model.ListaDetalle = listaCdrWebDetalle;
                model.Proceso = Proceso;
                return View("DetalleNotificacionesCDR", model);
            }
            else
            {
                return RedirectToAction("Index", "Notificaciones", new { area = "Mobile" });
            }
        }

        public ActionResult DetallePagoEnLinea(int solicitudId)
        {
            BEPagoEnLineaResultadoLog pagoEnLinea;

            using (PedidoServiceClient ps = new PedidoServiceClient())
            {
                pagoEnLinea = ps.ObtenerPagoEnLineaById(userData.PaisID, solicitudId);
            }

            if (!pagoEnLinea.Visualizado)
            {
                using (UsuarioServiceClient us = new UsuarioServiceClient())
                {
                    us.UpdNotificacionPagoEnLineaVisualizacion(userData.PaisID, solicitudId);
                }
            }

            var pagoEnLineaModel = new PagoEnLineaModel
            {
                CodigoIso = userData.CodigoISO,
                NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre),
                PrimerApellido = userData.PrimerApellido,
                NumeroOperacion = pagoEnLinea.NumeroOrdenTienda,
                Simbolo = userData.Simbolo,
                MontoDeuda = pagoEnLinea.MontoPago,
                MontoGastosAdministrativosNot = pagoEnLinea.MontoGastosAdministrativos,
                MontoDeudaConGastosNot = pagoEnLinea.ImporteAutorizado,
                FechaCreacion = pagoEnLinea.FechaCreacion,
                FechaVencimiento = pagoEnLinea.FechaVencimiento,
                TarjetaEnmascarada = pagoEnLinea.NumeroTarjeta
            };
            ViewBag.EsLebel = userData.EsLebel;
            ViewBag.PagoEnLineaCargoLabel = userData.PaisID == Constantes.PaisID.Mexico ? Constantes.PagoEnLineaMensajes.CargoplataformaMx : Constantes.PagoEnLineaMensajes.CargoplataformaPe;

            return View("DetallePagoEnLinea", pagoEnLineaModel);
        }

        #endregion

        #region Metodos

        private List<BENotificaciones> ObtenerNotificaciones()
        {
            
            List<BENotificaciones> list;
            using (var sv = new UsuarioServiceClient())
            {
                list = sv.GetNotificacionesConsultora(userData.PaisID, userData.ConsultoraID, userData.IndicadorBloqueoCDR, userData.TienePagoEnLinea).ToList();
            }
            return list;
        }

        #endregion
    }
}
