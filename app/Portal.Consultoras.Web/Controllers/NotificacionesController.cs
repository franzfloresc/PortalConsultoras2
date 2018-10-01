using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class NotificacionesController : BaseController
    {
        readonly CdrProvider _cdrProvider;
        readonly NotificacionProvider _notificacionProvider;

        public NotificacionesController()
        {
            _cdrProvider = new CdrProvider();
            _notificacionProvider = new NotificacionProvider();
        }

        public ActionResult Index()
        {
            if (EsDispositivoMovil())
            {
                return RedirectToAction("Index", "Notificaciones", new { area = "Mobile" });
            }

            SessionManager.SetfechaGetNotificacionesSinLeer(null);
            SessionManager.SetcantidadGetNotificacionesSinLeer(null);

            List<BENotificaciones> olstNotificaciones;
            NotificacionesModel model = new NotificacionesModel();
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstNotificaciones = sv.GetNotificacionesConsultora(userData.PaisID, userData.ConsultoraID, userData.IndicadorBloqueoCDR, userData.TienePagoEnLinea).ToList();
            }
            model.ListaNotificaciones = olstNotificaciones;
            return View(model);
        }

        public ActionResult ListarNotificaciones(long ProcesoId, int TipoOrigen)
        {
            NotificacionesModel model = new NotificacionesModel();
            List<BENotificaciones> olstNotificaciones;
            int paisId = userData.PaisID;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                switch (TipoOrigen)
                {
                    case 4:
                        sv.UpdNotificacionSolicitudClienteVisualizacion(paisId, ProcesoId);
                        break;
                    case 5:
                        sv.UpdNotificacionSolicitudClienteCatalogoVisualizacion(paisId, ProcesoId);
                        break;
                    default:
                        sv.UpdNotificacionesConsultoraVisualizacion(paisId, ProcesoId, TipoOrigen);
                        break;
                }

                olstNotificaciones = sv.GetNotificacionesConsultora(userData.PaisID, userData.ConsultoraID, userData.IndicadorBloqueoCDR, userData.TienePagoEnLinea).ToList();
            }

            model.ListaNotificaciones = olstNotificaciones;

            return PartialView("ListadoNotificaciones", model);
        }

        public JsonResult ActualizarEstadoNotificacion(long ProcesoId, int TipoOrigen)
        {
            try
            {
                var paisId = userData.PaisID;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    switch (TipoOrigen)
                    {
                        case 6:
                            sv.UpdNotificacionPedidoRechazadoVisualizacion(paisId, ProcesoId);
                            break;
                        case 5:
                            sv.UpdNotificacionSolicitudClienteCatalogoVisualizacion(paisId, ProcesoId);
                            break;
                        case 4:
                            sv.UpdNotificacionSolicitudClienteVisualizacion(paisId, ProcesoId);
                            break;
                        case 7:
                            sv.UpdNotificacionSolicitudCdrVisualizacion(paisId, ProcesoId);
                            break;
                        case 8:
                            sv.UpdNotificacionCdrCulminadoVisualizacion(paisId, ProcesoId);
                            break;
                        case 9:
                            sv.UpdNotificacionPagoEnLineaVisualizacion(paisId, Convert.ToInt32(ProcesoId));
                            break;
                        default:
                            sv.UpdNotificacionesConsultoraVisualizacion(paisId, ProcesoId, TipoOrigen);
                            break;
                    }
                }

                SessionManager.SetfechaGetNotificacionesSinLeer(null);
                SessionManager.SetcantidadGetNotificacionesSinLeer(null);

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                var usuarioModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ListarDetalleSolicitudCliente(long SolicitudId)
        {
            SolicitudClienteConsultoraModel model = new SolicitudClienteConsultoraModel();
            int paisId = userData.PaisID;
            ViewBag.PaisID = paisId;
            ViewBag.NombreCompleto = userData.NombreConsultora;

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                ServiceSAC.BESolicitudCliente beSolicitudCliente = sv.GetSolicitudCliente(paisId, SolicitudId);
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatos = sv.GetTablaLogicaDatos(paisId, 56);
                int horasReasignacion = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo);
                string horaEjecucionDefault = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5602).Codigo;
                DateTime fechaEjecucion = beSolicitudCliente.FechaSolicitud.AddHours(horasReasignacion);
                var horaEjecucionDefecto = TimeSpan.ParseExact(horaEjecucionDefault, "g", null);
                if (fechaEjecucion.Hour > horaEjecucionDefecto.Hours)
                {
                    fechaEjecucion = fechaEjecucion.AddDays(1);
                    fechaEjecucion = fechaEjecucion.Date + horaEjecucionDefecto;
                }

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
                model.lsProductosDetalle = sv.GetSolicitudClienteDetalle(paisId, SolicitudId).ToList();
            }
            ViewBag.Marca = model.MarcaNombre;

            return PartialView("ListadoDetalleSolicitud", model);
        }

        public ActionResult ListarDetalleSolicitudClienteCatalogo(long SolicitudId)
        {
            NotificacionesModel model = new NotificacionesModel();

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                model.NotificacionDetalleCatalogo = sv.ObtenerDetalleNotificacion(userData.PaisID, SolicitudId);
            }
            model.NombreConsultora = userData.NombreConsultora;
            return PartialView("ListadoDetalleCatalogo", model);
        }

        public JsonResult AceptarSolicitud(long SolicitudId, long ConsultoraID, string Marca, string emailCliente, string NombreCliente, string MensajeaCliente)
        {
            int paisId = userData.PaisID;
            try
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    var beSolicitudCliente = new ServiceSAC.BESolicitudCliente
                    {
                        SolicitudClienteID = SolicitudId,
                        CodigoConsultora = ConsultoraID.ToString(),
                        MensajeaCliente = MensajeaCliente,
                        UsuarioModificacion = userData.CodigoUsuario,
                        Estado = "A"
                    };
                    sc.UpdSolicitudCliente(paisId, beSolicitudCliente);
                }

                using (ServiceCliente.ClienteServiceClient sc = new ServiceCliente.ClienteServiceClient())
                {
                    var beCliente = new ServiceCliente.BECliente
                    {
                        ConsultoraID = ConsultoraID,
                        eMail = emailCliente,
                        Nombre = NombreCliente,
                        PaisID = userData.PaisID,
                        Activo = true
                    };
                    sc.Insert(beCliente);
                }

                String titulo = "(" + userData.CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(Marca);
                StringBuilder mensaje = new StringBuilder();
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
            int paisId = userData.PaisID;

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatosMail = sv.GetTablaLogicaDatos(paisId, 57);
                String emailOculto = tablalogicaDatosMail.First(x => x.TablaLogicaDatosID == 5701).Descripcion;
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatos = sv.GetTablaLogicaDatos(paisId, 56);
                var numIteracionMaximo = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5601).Codigo);
                String horas = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo;
                if (NumIteracion == numIteracionMaximo)
                {
                    sv.RechazarSolicitudCliente(paisId, SolicitudId, true, 0, "");
                }
                else
                {
                    ServiceSAC.BESolicitudNuevaConsultora nuevaConsultora = sv.ReasignarSolicitudCliente(paisId, SolicitudId, CodigoUbigeo, Campania, MarcaId, 0, "");
                    if (nuevaConsultora == null)
                    {
                        sv.RechazarSolicitudCliente(paisId, SolicitudId, true, 0, "");
                    }
                    else
                    {
                        try
                        {
                            string asunto = "(" + userData.CodigoISO + ") Nuevo Pedido " + nuevaConsultora.MarcaNombre;
                            StringBuilder mensaje = new StringBuilder();
                            mensaje.Append("<p>Estimada " + nuevaConsultora.Nombre + ",<br/><br/>");
                            mensaje.Append("<p>¡Un nuevo cliente eligió contactarse contigo para solicitarte un pedido!<br/>");
                            mensaje.Append("Para ver que productos fueron solicitados y los datos del cliente, entra a:<br/>");
                            mensaje.Append("<a href=\"https://www.somosbelcorp.com/Notificaciones\">https://www.somosbelcorp.com/Notificaciones</a><br/>");
                            mensaje.Append("<br/>");
                            mensaje.AppendFormat("Recuerda que sólo tienes {0} horas para leer la notificación y decidir si <br/>", horas);
                            mensaje.AppendFormat("aceptas o rechazas el pedido. Si te demoras más de {0} horas, el pedido <br/>", horas);
                            mensaje.Append("será asignado a otra consultora y ya no podrás ver los datos del cliente.<br/><br/>");
                            mensaje.Append("Gracias,<br/>Belcorp.</p>");
                            Util.EnviarMail("no-responder@somosbelcorp.com", nuevaConsultora.Email, emailOculto, asunto, mensaje.ToString(), true);
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

            NotificacionesModel model = new NotificacionesModel
            {
                ListaNotificacionesDetalle = lstObservaciones,
                ListaNotificacionesDetallePedido = Mapper.Map<List<NotificacionesModelDetallePedido>>(lstObservacionesPedido),
                NombreConsultora = userData.NombreConsultora,
                simbolo = userData.Simbolo,
                mGanancia = Util.DecimalToStringFormat(
                    lstObservacionesPedido[0].MontoAhorroCatalogo + lstObservacionesPedido[0].MontoAhorroRevista,
                    userData.CodigoISO),
                Origen = TipoOrigen
            };
            ViewBag.PaisIso = userData.CodigoISO;

            return PartialView("DetalleNotificacionesPedido", model);
        }

        public ActionResult ListarObservacionesStock(long ValStockId)
        {
            List<BENotificacionesDetallePedido> olstObservacionesPedido;
            int paisId = userData.PaisID;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstObservacionesPedido = sv.GetValidacionStockProductos(paisId, userData.ConsultoraID, ValStockId).ToList();
            }

            foreach (var item in olstObservacionesPedido)
            {
                if (item.StockDisponible == 0) item.ObservacionPROL = string.Format("El producto {0} - {1} - cuenta nuevamente con stock. Si deseas agrégalo a tu pedido.", item.CUV, item.Descripcion);
                else
                {
                    string unidades;
                    if (item.StockDisponible == 1) unidades = "1 unidad";
                    else unidades = item.StockDisponible + " unidades";

                    item.ObservacionPROL = string.Format("Ya contamos con stock de {0} del producto {1} - {2}, para que lo puedas agregar nuevamente a tu pedido.", unidades, item.CUV, item.Descripcion);
                }
            }

            var model = new NotificacionesModel
            {
                ListaNotificacionesDetalle = new List<BENotificacionesDetalle>(),
                ListaNotificacionesDetallePedido =
                        Mapper.Map<List<NotificacionesModelDetallePedido>>(olstObservacionesPedido),
                NombreConsultora = userData.NombreConsultora,
                Origen = 3
            };

            return PartialView("ListadoObservaciones", model);
        }

        public ActionResult ListarDetallePedidoRechazado(long ProcesoId)
        {
            NotificacionesModel model = new NotificacionesModel();
            List<BELogGPRValidacion> logsGprValidacion;

            using (PedidoRechazadoServiceClient sv = new PedidoRechazadoServiceClient())
            {
                logsGprValidacion = sv.GetBELogGPRValidacionByGetLogGPRValidacionId(userData.PaisID, ProcesoId, userData.ConsultoraID).ToList();
            }

            _notificacionProvider.CargarMensajesNotificacionesGPR(model, logsGprValidacion, userData.CodigoISO, userData.Simbolo, userData.MontoMinimo, userData.MontoMaximo);
            model.NombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre;
            model.Total = model.SubTotal + model.Descuento;
            model.SubTotalString = Util.DecimalToStringFormat(model.SubTotal, userData.CodigoISO);
            model.DescuentoString = Util.DecimalToStringFormat(model.Descuento, userData.CodigoISO);
            model.TotalString = Util.DecimalToStringFormat(model.Total, userData.CodigoISO);

            return PartialView("ListadoDetallePedidoRechazado", model);
        }

        public ActionResult ListarDetalleCdr(long solicitudId)
        {
            BELogCDRWeb logCdrWeb;
            List<BECDRWebDetalle> listaCdrWebDetalle;
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                logCdrWeb = sv.GetLogCDRWebByLogCDRWebId(userData.PaisID, solicitudId);
                listaCdrWebDetalle = sv.GetCDRWebDetalleLog(userData.PaisID, logCdrWeb).ToList();
            }

            listaCdrWebDetalle.Update(p => p.Solicitud = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado, userData.PaisID).Descripcion);
            listaCdrWebDetalle.Update(p => p.SolucionSolicitada = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado, userData.PaisID).Descripcion);

            var model = Mapper.Map<CDRWebModel>(logCdrWeb);
            model.NombreConsultora = userData.NombreConsultora;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;
            return PartialView("ListaDetalleCdr", model);
        }

        public ActionResult ListarDetalleCdrCulminado(long solicitudId)
        {
            BECDRWeb cdrWeb;
            List<BECDRWebDetalle> listaCdrWebDetalle;
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                cdrWeb = sv.GetCDRWebByLogCDRWebCulminadoId(userData.PaisID, solicitudId);
                listaCdrWebDetalle = sv.GetCDRWebDetalleByLogCDRWebCulminadoId(userData.PaisID, solicitudId).ToList();
            }

            listaCdrWebDetalle.Update(p => p.Solicitud = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado, userData.PaisID).Descripcion);
            listaCdrWebDetalle.Update(p => p.SolucionSolicitada = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado, userData.PaisID).Descripcion);

            var model = Mapper.Map<CDRWebModel>(cdrWeb);
            model.CodigoIso = userData.CodigoISO;
            model.NombreConsultora = userData.NombreConsultora;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;
            return PartialView("ListaDetalleCdrCulminado", model);
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
            ViewBag.PagoEnLineaCargoLabel = userData.PaisID == Constantes.PaisID.Mexico ? Constantes.PagoEnLineaMensajes.CargoplataformaMx : Constantes.PagoEnLineaMensajes.CargoplataformaPe;

            return PartialView("DetallePagoEnLinea", pagoEnLineaModel);
        }

        [HttpPost]
        public JsonResult GetNotificacionesSinLeer()
        {
            int cantidadNotificaciones = -1;
            var mensaje = string.Empty;
            try
            {
                if (CheckDataSessionCantidadNotificaciones())
                {
                    cantidadNotificaciones = Convert.ToInt32(SessionManager.GetcantidadGetNotificacionesSinLeer());
                }
                else
                {
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        cantidadNotificaciones = sv.GetNotificacionesSinLeer(userData.PaisID, userData.ConsultoraID, userData.IndicadorBloqueoCDR, userData.TienePagoEnLinea);
                    }

                    SessionManager.SetfechaGetNotificacionesSinLeer(DateTime.Now.Ticks);
                    SessionManager.SetcantidadGetNotificacionesSinLeer(cantidadNotificaciones);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                mensaje = ex.Message;
            }
            return Json(new { mensaje, cantidadNotificaciones }, JsonRequestBehavior.AllowGet);
        }

        public bool CheckDataSessionCantidadNotificaciones()
        {
            if (SessionManager.GetfechaGetNotificacionesSinLeer() != null &&
                SessionManager.GetcantidadGetNotificacionesSinLeer() != null)
            {
                var ticks = Convert.ToInt64(SessionManager.GetfechaGetNotificacionesSinLeer());
                var fecha = new DateTime(ticks);
                var diferencia = DateTime.Now - fecha;
                return (diferencia.TotalMinutes <= 30);
            }
            return false;
        }
    }
}
