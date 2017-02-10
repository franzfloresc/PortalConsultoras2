using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceCDR;

namespace Portal.Consultoras.Web.Controllers
{
    public class NotificacionesController : BaseController
    {
        //
        // GET: /Notificaciones/

        public ActionResult Index()
        {
            SessionKeys.ClearSessionCantidadNotificaciones();

            List<BENotificaciones> olstNotificaciones = new List<BENotificaciones>();
            NotificacionesModel model = new NotificacionesModel();
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstNotificaciones = sv.GetNotificacionesConsultora(userData.PaisID, userData.ConsultoraID, userData.IndicadorBloqueoCDR).ToList();
            }
            model.ListaNotificaciones = olstNotificaciones;
            return View(model);
        }

        //R2073
        public ActionResult ListarNotificaciones(long ProcesoId, int TipoOrigen)
        {
            NotificacionesModel model = new NotificacionesModel();
            List<BENotificaciones> olstNotificaciones = new List<BENotificaciones>();
            int PaisId = userData.PaisID;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                //R2319 - JLCS
                if (TipoOrigen == 4)
                {
                    sv.UpdNotificacionSolicitudClienteVisualizacion(PaisId, ProcesoId);
                }//R20150802
                if (TipoOrigen == 5)
                {
                    sv.UpdNotificacionSolicitudClienteCatalogoVisualizacion(PaisId, ProcesoId);// Revisar  debería ir el CodigoConsultora.
                }
                else
                {
                    sv.UpdNotificacionesConsultoraVisualizacion(PaisId, ProcesoId, TipoOrigen); //R2073
                }
                olstNotificaciones = sv.GetNotificacionesConsultora(userData.PaisID, userData.ConsultoraID, userData.IndicadorBloqueoCDR).ToList();
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
                    if (TipoOrigen == 6) sv.UpdNotificacionPedidoRechazadoVisualizacion(paisId, ProcesoId);
                    else if (TipoOrigen == 5) sv.UpdNotificacionSolicitudClienteCatalogoVisualizacion(paisId, ProcesoId);
                    else if (TipoOrigen == 4) sv.UpdNotificacionSolicitudClienteVisualizacion(paisId, ProcesoId);
                    else if (TipoOrigen == 7) sv.UpdNotificacionSolicitudCdrVisualizacion(paisId, ProcesoId);
                    else if (TipoOrigen == 8) sv.UpdNotificacionCdrCulminadoVisualizacion(paisId, ProcesoId);
                    else sv.UpdNotificacionesConsultoraVisualizacion(paisId, ProcesoId, TipoOrigen);
                }
                SessionKeys.ClearSessionCantidadNotificaciones();
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                var usuarioModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
        }

        //R2319 - JLCS
        public ActionResult ListarDetalleSolicitudCliente(long SolicitudId)
        {
            SolicitudClienteConsultoraModel model = new SolicitudClienteConsultoraModel();
            int PaisId = UserData().PaisID;
            ViewBag.PaisID = PaisId;
            ViewBag.Simbolo = userData.Simbolo;
            ViewBag.NombreCompleto = userData.NombreConsultora;

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                ServiceSAC.BESolicitudCliente beSolicitudCliente = sv.GetSolicitudCliente(PaisId, SolicitudId);
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatos = sv.GetTablaLogicaDatos(PaisId, 56);
                int horasReasignacion = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo);
                string horaEjecucionDefault = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5602).Codigo;
                DateTime FechaEjecucion = beSolicitudCliente.FechaSolicitud.AddHours(horasReasignacion);
                var HoraEjecucionDefecto = TimeSpan.ParseExact(horaEjecucionDefault, "g", null);
                if (FechaEjecucion.Hour > HoraEjecucionDefecto.Hours)
                {
                    FechaEjecucion = FechaEjecucion.AddDays(1);
                    FechaEjecucion = FechaEjecucion.Date + HoraEjecucionDefecto;
                }

                model.ConsultoraID = beSolicitudCliente.CodigoConsultora;
                model.Estado = beSolicitudCliente.Estado;
                model.SolicitudClienteId = SolicitudId;
                model.FechaEjecucion = FechaEjecucion;
                model.MarcaID = beSolicitudCliente.MarcaID;
                model.FechaDescripcion = FechaEjecucion.Day + " de " + NombreMes(FechaEjecucion.Month);
                model.TelefonoCliente = beSolicitudCliente.Telefono;
                model.NombreCliente = beSolicitudCliente.NombreCompleto;
                model.EmailCliente = beSolicitudCliente.Email;
                model.NumIteracion = beSolicitudCliente.NumIteracion;
                model.Mensaje = beSolicitudCliente.Mensaje;
                model.MensajeaCliente = beSolicitudCliente.MensajeaCliente;
                model.MarcaNombre = beSolicitudCliente.MarcaNombre;
                model.Campania = beSolicitudCliente.Campania;
                model.CodigoUbigeo = beSolicitudCliente.CodigoUbigeo;
                model.lsProductosDetalle = sv.GetSolicitudClienteDetalle(PaisId, SolicitudId).ToList();
            }
            ViewBag.Marca = model.MarcaNombre;

            return PartialView("ListadoDetalleSolicitud", model);
        }

        /*20150802*/

        public ActionResult ListarDetalleSolicitudClienteCatalogo(long SolicitudId)
        {
            NotificacionesModel model = new NotificacionesModel();

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                model.NotificacionDetalleCatalogo = sv.ObtenerDetalleNotificacion(UserData().PaisID, SolicitudId);
            }
            model.NombreConsultora = UserData().NombreConsultora;
            return PartialView("ListadoDetalleCatalogo", model);
        }

        //R2319 - JLCS
        public JsonResult AceptarSolicitud(long SolicitudId, long ConsultoraID, string Marca, string emailCliente, string NombreCliente, string MensajeaCliente)
        {
            int paisId = UserData().PaisID;
            try
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    ServiceSAC.BESolicitudCliente beSolicitudCliente = new ServiceSAC.BESolicitudCliente();
                    beSolicitudCliente.SolicitudClienteID = SolicitudId;
                    beSolicitudCliente.CodigoConsultora = ConsultoraID.ToString();
                    beSolicitudCliente.MensajeaCliente = MensajeaCliente;
                    beSolicitudCliente.UsuarioModificacion = UserData().CodigoUsuario;
                    beSolicitudCliente.Estado = "A";
                    sc.UpdSolicitudCliente(paisId, beSolicitudCliente);
                }

                using (ServiceCliente.ClienteServiceClient sc = new ServiceCliente.ClienteServiceClient())
                {
                    ServiceCliente.BECliente beCliente = new ServiceCliente.BECliente();
                    beCliente.ConsultoraID = ConsultoraID;
                    beCliente.eMail = emailCliente;
                    beCliente.Nombre = NombreCliente;
                    beCliente.PaisID = UserData().PaisID;
                    beCliente.Activo = true;
                    sc.Insert(beCliente);
                }

                //R2548 - CS
                String titulo = "(" + UserData().CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(Marca);
                StringBuilder mensaje = new StringBuilder();
                mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(NombreCliente));
                mensaje.AppendFormat("{0}</p><br/>", MensajeaCliente); //R2442 - Corrección Salto de Linea
                mensaje.Append("<br/>Saludos,<br/><br />");
                mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                mensaje.AppendFormat("<td><p style='text-align: center;'><strong>{0}<br/>Consultora</strong></p></td></tr></table>", UserData().NombreConsultora);
                try
                {
                    Common.Util.EnviarMail3(UserData().EMail, emailCliente, titulo, mensaje.ToString(), true, string.Empty);
                }
                catch (Exception ex)
                {
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
                    message = "Ocurrió un error inesperado " + ex.Message//R2442
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult RechazarSolicitud(long SolicitudId, int NumIteracion, string CodigoUbigeo, string Campania, int MarcaId)
        {
            int PaisId = UserData().PaisID;
            int numIteracionMaximo = 3;

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                ServiceSAC.BESolicitudCliente beSolicitudCliente = sv.GetSolicitudCliente(PaisId, SolicitudId);
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatosMail = sv.GetTablaLogicaDatos(PaisId, 57);
                String emailOculto = tablalogicaDatosMail.First(x => x.TablaLogicaDatosID == 5701).Descripcion;
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatos = sv.GetTablaLogicaDatos(PaisId, 56);
                numIteracionMaximo = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5601).Codigo);
                String horas = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo;//2442
                if (NumIteracion == numIteracionMaximo)
                {
                    sv.RechazarSolicitudCliente(PaisId, SolicitudId, true, 0, "");// 0,"" Añadidos para atender el cambio del SP RechazarSolicitudCliente
                }
                else
                {
                    ServiceSAC.BESolicitudNuevaConsultora nuevaConsultora = sv.ReasignarSolicitudCliente(PaisId, SolicitudId, CodigoUbigeo, Campania, MarcaId, 0, ""); // 0,"" Añadidos para atender el cambio del SP ReasignarSolicitudCliente
                    if (nuevaConsultora == null)
                    {
                        sv.RechazarSolicitudCliente(PaisId, SolicitudId, true, 0, "");// 0,"" Añadidos para atender el cambio del SP RechazarSolicitudCliente
                    }
                    else
                    {
                        try
                        {
                            string asunto = "(" + UserData().CodigoISO + ") Nuevo Pedido " + nuevaConsultora.MarcaNombre;
                            StringBuilder mensaje = new StringBuilder();
                            mensaje.Append("<p>Estimada " + nuevaConsultora.Nombre + ",<br/><br/>");
                            //2442 -Mensaje
                            mensaje.Append("<p>¡Un nuevo cliente eligió contactarse contigo para solicitarte un pedido!<br/>");
                            mensaje.Append("Para ver que productos fueron solicitados y los datos del cliente, entra a:<br/>");
                            mensaje.Append("<a href=\"https://www.somosbelcorp.com/Notificaciones\">https://www.somosbelcorp.com/Notificaciones</a><br/>");
                            mensaje.Append("<br/>");
                            mensaje.AppendFormat("Recuerda que sólo tienes {0} horas para leer la notificación y decidir si <br/>", horas);
                            mensaje.AppendFormat("aceptas o rechazas el pedido. Si te demoras más de {0} horas, el pedido <br/>", horas);
                            mensaje.Append("será asignado a otra consultora y ya no podrás ver los datos del cliente.<br/><br/>");
                            mensaje.Append("Gracias,<br/>Belcorp.</p>");
                            Common.Util.EnviarMail("no-responder@somosbelcorp.com", nuevaConsultora.Email, emailOculto, asunto,
                               mensaje.ToString(), true);
                        }
                        catch (Exception ex)
                        {
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

        //R2073
        public ActionResult ListarObservaciones(long ProcesoId, int TipoOrigen)
        {
            List<BENotificacionesDetalle> olstObservaciones = new List<BENotificacionesDetalle>();
            List<BENotificacionesDetallePedido> olstObservacionesPedido = new List<BENotificacionesDetallePedido>();
            NotificacionesModel model = new NotificacionesModel();
            int PaisId = UserData().PaisID;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstObservaciones = sv.GetNotificacionesConsultoraDetalle(PaisId, ProcesoId, TipoOrigen).ToList(); //R2073
                olstObservacionesPedido = sv.GetNotificacionesConsultoraDetallePedido(PaisId, ProcesoId, TipoOrigen).ToList(); //R2073
            }

            model.ListaNotificacionesDetalle = olstObservaciones;
            model.ListaNotificacionesDetallePedido = Mapper.Map<List<NotificacionesModelDetallePedido>>(olstObservacionesPedido);
            model.NombreConsultora = UserData().NombreConsultora;
            model.Origen = TipoOrigen;//R2133
            return PartialView("ListadoObservaciones", model);//R2133
        }

        //RQ_NS - R2133
        public ActionResult ListarObservacionesStock(long ValStockId)
        {
            List<BENotificacionesDetalle> olstObservaciones = new List<BENotificacionesDetalle>();
            List<BENotificacionesDetallePedido> olstObservacionesPedido = new List<BENotificacionesDetallePedido>();
            NotificacionesModel model = new NotificacionesModel();
            int PaisId = UserData().PaisID;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstObservacionesPedido = sv.GetValidacionStockProductos(PaisId, UserData().ConsultoraID, ValStockId).ToList();
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

            model.ListaNotificacionesDetalle = olstObservaciones;
            model.ListaNotificacionesDetallePedido = Mapper.Map<List<NotificacionesModelDetallePedido>>(olstObservacionesPedido);
            model.NombreConsultora = UserData().NombreConsultora;
            model.Origen = 3;
            return PartialView("ListadoObservaciones", model);
        }
        public ActionResult ListarDetallePedidoRechazado(long ProcesoId)
        {
            NotificacionesModel model = new NotificacionesModel();
            List<BELogGPRValidacion> LogsGPRValidacion = new List<BELogGPRValidacion>();
            //List<BELogGPRValidacionDetalle> lstLogGPRValidacionDetalle = new List<BELogGPRValidacionDetalle>();

            using (PedidoRechazadoServiceClient sv = new PedidoRechazadoServiceClient())
            {
                LogsGPRValidacion = sv.GetBELogGPRValidacionByGetLogGPRValidacionId(userData.PaisID, ProcesoId, userData.ConsultoraID).ToList();
                // lstLogGPRValidacionDetalle = sv.GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(userData.PaisID, ProcesoId).ToList();
            }
            //model = Mapper.Map<NotificacionesModel>(logGPRValidacion);

            if (LogsGPRValidacion.Any())
            {
                // Monto mínimo - deuda
                var items = LogsGPRValidacion.Where(l => l.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.MontoMinino));
                var deuda = LogsGPRValidacion.Where(x => x.MotivoRechazo.Equals(Constantes.GPRMotivoRechazo.ActualizacionDeuda));
                if (items.Any() && deuda.Any())
                {
                    model.DescripcionRechazo = string.Format("Luego de haber revisado tu pedido, te informamos que éste no se ha podido facturar porque no cumple con el monto mínimo de {0}. {1} y adicionalmente por tener una deuda pendiente con nosotros de {0}. {2}. Te invitamos a añadir más productos, cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMinimo, deuda.FirstOrDefault().Valor);
                    model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                    goto jmp;
                }
                else if (items.Any()) // Monto mínimo
                {
                    model.DescripcionRechazo = string.Format("Luego de haber revisado tu pedido, te informamos que éste no se ha podido facturar porque no cumple con el monto mínimo de {0}. {1}. Te invitamos a añadir más productos y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMinimo);
                    model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMinino;
                    goto jmp;
                }
                //Monto máximo - deuda:
                items = LogsGPRValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.MontoMaximo));
                if (items.Any() && deuda.Any())
                {
                    model.DescripcionRechazo = string.Format("Luego de haber revisado tu pedido, te informamos que éste no se ha podido facturar por superar el monto máximo permitido de {0}. {1} y adicionalmente por tener una deuda pendiente con nosotros de {0}. {2}. Te invitamos a modificar tu pedido, cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMaximo, deuda.FirstOrDefault().Valor);
                    model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                    goto jmp;
                }
                else if (items.Any())//Monto máximo
                {
                    model.DescripcionRechazo = string.Format("Luego de haber revisado tu pedido, te informamos que éste no se ha podido facturar por superar el monto máximo permitido de {0}. {1}. Te invitamos a modificar y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, userData.MontoMaximo);
                    model.MotivoRechazo = Constantes.GPRMotivoRechazo.MontoMaximo;
                    goto jmp;
                }
                //Monto mínimo stock + deuda:
                items = LogsGPRValidacion.Where(l => l.MotivoRechazo.Contains(Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock));
                if (items.Any() && deuda.Any())
                {
                    model.DescripcionRechazo = string.Format("Luego de haber revisado tu pedido, te informamos que éste no se ha podido facturar porque no cumple con el monto mínimo debido a que no contamos con stock de algunos productos, y adicionalmente por tener una deuda pendiente con nosotros de {0}. {1}. Te invitamos a añadir más productos, cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", userData.Simbolo, deuda.FirstOrDefault().Valor);
                    model.MotivoRechazo = Constantes.GPRMotivoRechazo.Mostrar2OpcionesNotificacion;
                    goto jmp;
                }
                else if (items.Any())//Monto mínimo stock
                {
                    model.DescripcionRechazo = "Luego de haber revisado tu pedido, te informamos que éste no se ha podido facturar porque no cumple con el monto mínimo debido a que no contamos con stock de algunos productos. Te invitamos a añadir más productos y reservar tu pedido el día de hoy para que sea facturado exitosamente.";
                    model.MotivoRechazo = Constantes.GPRMotivoRechazo.ValidacionMontoMinimoStock;
                    goto jmp;
                }
                if (deuda.Any()) //Deuda
                {
                    model.DescripcionRechazo = string.Format("Lamentamos informarte que tu pedido no se ha podido facturar porque tener una deuda pendiente con nosotros de {0}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido el día de hoy para que sea facturado exitosamente.", deuda.FirstOrDefault().Valor);
                    model.MotivoRechazo = Constantes.GPRMotivoRechazo.ActualizacionDeuda;
                    goto jmp;
                }
            }
        jmp:

            model.NombreConsultora = userData.NombreConsultora;
            model.Total = model.SubTotal + model.Descuento;
            model.SubTotalString = Util.DecimalToStringFormat(model.SubTotal, userData.CodigoISO);
            model.DescuentoString = Util.DecimalToStringFormat(model.Descuento, userData.CodigoISO);
            model.TotalString = Util.DecimalToStringFormat(model.Total, userData.CodigoISO);


            return PartialView("ListadoDetallePedidoRechazado", model);
        }

        public ActionResult ListarDetalleCdr(long solicitudId)
        {
            var model = new CDRWebModel();

            var logCdrWeb = new BELogCDRWeb();
            var listaCdrWebDetalle = new List<BECDRWebDetalle>();
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                logCdrWeb = sv.GetLogCDRWebByLogCDRWebId(userData.PaisID, solicitudId);

                listaCdrWebDetalle = sv.GetCDRWebDetalleLog(userData.PaisID, logCdrWeb).ToList() ?? new List<BECDRWebDetalle>();
                listaCdrWebDetalle.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado).Descripcion);
                listaCdrWebDetalle.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado).Descripcion);
            }

            model.CDRWebID = logCdrWeb.CDRWebID;
            model.PedidoID = logCdrWeb.PedidoId;
            model.PedidoNumero = logCdrWeb.PedidoFacturadoId;
            model.CampaniaID = string.IsNullOrEmpty(logCdrWeb.CampaniaId) ? 0 : Convert.ToInt32(logCdrWeb.CampaniaId);
            model.FechaRegistro = logCdrWeb.FechaRegistro;
            model.Estado = logCdrWeb.EstadoCDR;
            model.FechaCulminado = logCdrWeb.FechaCulminado;
            model.FechaAtencion = logCdrWeb.FechaAtencion;
            model.Importe = logCdrWeb.ImporteCDR;
            model.NombreConsultora = userData.NombreConsultora;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;

            return PartialView("ListaDetalleCdr", model);
        }

        public ActionResult ListarDetalleCdrCulminado(long solicitudId)
        {
            var model = new CDRWebModel();

            var cdrWeb = new BECDRWeb();
            var listaCdrWebDetalle = new List<BECDRWebDetalle>();
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                cdrWeb = sv.GetCDRWebByLogCDRWebCulminadoId(userData.PaisID, solicitudId);

                listaCdrWebDetalle = sv.GetCDRWebDetalleByLogCDRWebCulminadoId(userData.PaisID, solicitudId).ToList() ?? new List<BECDRWebDetalle>();
                listaCdrWebDetalle.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado).Descripcion);
                listaCdrWebDetalle.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado).Descripcion);
            }

            model.CDRWebID = cdrWeb.CDRWebID;
            model.PedidoID = cdrWeb.PedidoID;
            model.PedidoNumero = cdrWeb.PedidoNumero;
            model.CampaniaID = cdrWeb.CampaniaID;
            model.FechaRegistro = cdrWeb.FechaRegistro;
            model.FechaCulminado = cdrWeb.FechaCulminado;
            model.NombreConsultora = userData.NombreConsultora;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;

            return PartialView("ListaDetalleCdrCulminado", model);
        }

        private BECDRWebDescripcion ObtenerDescripcion(string codigoSsic, string tipo)
        {
            codigoSsic = Util.SubStr(codigoSsic, 0);
            //codigoSsic = codigoSsic.ToLower();
            tipo = Util.SubStr(tipo, 0);
            //tipo = tipo.ToLower();
            var listaDescripcion = CargarDescripcion();
            var desc = listaDescripcion.FirstOrDefault(d => d.CodigoSSIC == codigoSsic && d.Tipo == tipo) ?? new BECDRWebDescripcion();

            desc.Descripcion = Util.SubStr(desc.Descripcion, 0);
            return desc;
        }

        private List<BECDRWebDescripcion> CargarDescripcion()
        {
            try
            {
                if (Session[Constantes.ConstSession.CDRDescripcion] != null)
                {
                    var listaDescripcion = (List<BECDRWebDescripcion>)Session[Constantes.ConstSession.CDRDescripcion];
                    if (listaDescripcion.Count > 0)
                        return listaDescripcion;
                }

                var lista = new List<BECDRWebDescripcion>();
                var entidad = new BECDRWebDescripcion();
                using (CDRServiceClient sv = new CDRServiceClient())
                {
                    lista = sv.GetCDRWebDescripcion(userData.PaisID, entidad).ToList();
                }

                lista = lista ?? new List<BECDRWebDescripcion>();
                //lista.Update(d => d.Tipo = d.Tipo.ToLower());
                Session[Constantes.ConstSession.CDRDescripcion] = lista;
                return lista;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Session[Constantes.ConstSession.CDRDescripcion] = null;
                return new List<BECDRWebDescripcion>();
            }
        }

        [HttpPost]
        public JsonResult GetNotificacionesSinLeer()
        {
            var cantidadNotificaciones = -1;
            var mensaje = string.Empty;
            try
            {
                if (SessionKeys.CheckDataSessionCantidadNotificaciones())
                {
                    cantidadNotificaciones = SessionKeys.GetDataSessionCantidadNotificaciones();
                }
                else
                {
                    var listaNotificaciones = ObtenerNotificaciones();

                    cantidadNotificaciones = listaNotificaciones.Count(p => p.Visualizado == false);

                    SessionKeys.SetDataSessionCantidadNotificaciones(cantidadNotificaciones);
                }
            }
            catch (Exception ex)
            {
                mensaje = ex.Message;
            }
            return Json(new { mensaje, cantidadNotificaciones }, JsonRequestBehavior.AllowGet);
        }

        private List<BENotificaciones> ObtenerNotificaciones()
        {
            var userData = UserData();
            var list = new List<BENotificaciones>();
            using (var sv = new UsuarioServiceClient())
            {
                list = sv.GetNotificacionesConsultora(userData.PaisID, userData.ConsultoraID, userData.IndicadorBloqueoCDR).ToList();
            }
            return list;
        }
    }
}
