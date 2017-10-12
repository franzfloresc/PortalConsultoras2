﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
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
        #region Acciones

        public ActionResult Index()
        {
            Session["fechaGetNotificacionesSinLeer"] = null;
            Session["cantidadGetNotificacionesSinLeer"] = null;

            var model = new NotificacionesModel();
            model.ListaNotificaciones = ObtenerNotificaciones();
            return View(model);
        }

        public ActionResult DetalleSolicitudCliente(long SolicitudId)
        {
            var userData = UserData();
            var notificaciones = ObtenerNotificaciones();
            var notificacion = notificaciones.FirstOrDefault(p => p.ProcesoId == SolicitudId);
            var model = new SolicitudClienteConsultoraModel();

            using (var service = new SACServiceClient())
            {
                var beSolicitudCliente = service.GetSolicitudCliente(userData.PaisID, SolicitudId);
                var tablalogicaDatos = service.GetTablaLogicaDatos(userData.PaisID, 56);

                int horasReasignacion = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo);
                string horaEjecucionDefault = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5602).Codigo;
                DateTime FechaEjecucion = beSolicitudCliente.FechaSolicitud.AddHours(horasReasignacion);
                var HoraEjecucionDefecto = TimeSpan.ParseExact(horaEjecucionDefault, "g", null);

                if (FechaEjecucion.Hour > HoraEjecucionDefecto.Hours)
                {
                    FechaEjecucion = FechaEjecucion.AddDays(1);
                    FechaEjecucion = FechaEjecucion.Date + HoraEjecucionDefecto;
                }

                model.Asunto = notificacion.Asunto;
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
                model.lsProductosDetalle = service.GetSolicitudClienteDetalle(userData.PaisID, SolicitudId).ToList();
            }

            ViewBag.PaisID = userData.PaisID;
            ViewBag.Simbolo = userData.Simbolo;
            ViewBag.NombreCompleto = userData.NombreConsultora;
            ViewBag.Marca = model.MarcaNombre;

            return View("DetalleSolicitudCliente", model);
        }

        public JsonResult AceptarSolicitud(long SolicitudId, long ConsultoraID, string Marca, string emailCliente, string NombreCliente, string MensajeaCliente)
        {
            var userData = UserData();
            try
            {
                using (var service = new SACServiceClient())
                {
                    var beSolicitudCliente = new ServiceSAC.BESolicitudCliente();
                    beSolicitudCliente.SolicitudClienteID = SolicitudId;
                    beSolicitudCliente.CodigoConsultora = ConsultoraID.ToString();
                    beSolicitudCliente.MensajeaCliente = MensajeaCliente;
                    beSolicitudCliente.UsuarioModificacion = UserData().CodigoUsuario;
                    beSolicitudCliente.Estado = "A";
                    service.UpdSolicitudCliente(userData.PaisID, beSolicitudCliente);
                }

                using (var service = new ClienteServiceClient())
                {
                    var beCliente = new ServiceCliente.BECliente();
                    beCliente.ConsultoraID = ConsultoraID;
                    beCliente.eMail = emailCliente;
                    beCliente.Nombre = NombreCliente;
                    beCliente.PaisID = UserData().PaisID;
                    beCliente.Activo = true;
                    service.Insert(beCliente);

                }

                var titulo = "(" + userData.CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(Marca);
                var mensaje = new StringBuilder();
                mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(NombreCliente));
                mensaje.AppendFormat("{0}</p><br/>", MensajeaCliente);
                mensaje.Append("<br/>Saludos,<br/><br />");
                mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                mensaje.AppendFormat("<td><p style='text-align: center;'><strong>{0}<br/>Consultora</strong></p></td></tr></table>", UserData().NombreConsultora);
                try
                {
                    Util.EnviarMail3(UserData().EMail, emailCliente, titulo, mensaje.ToString(), true, string.Empty);
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
            var userData = UserData();
            var numIteracionMaximo = 3;

            using (var service = new SACServiceClient())
            {
                var beSolicitudCliente = service.GetSolicitudCliente(userData.PaisID, SolicitudId);
                var tablalogicaDatosMail = service.GetTablaLogicaDatos(userData.PaisID, 57);
                var emailOculto = tablalogicaDatosMail.First(x => x.TablaLogicaDatosID == 5701).Descripcion;
                var tablalogicaDatos = service.GetTablaLogicaDatos(userData.PaisID, 56);

                numIteracionMaximo = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5601).Codigo);

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
            var userData = UserData();
            var notificaciones = ObtenerNotificaciones();
            var notificacion = notificaciones.FirstOrDefault(p => p.ProcesoId == ProcesoId);
            var lstObservaciones = new List<BENotificacionesDetalle>();
            var lstObservacionesPedido = new List<BENotificacionesDetallePedido>();
            var model = new NotificacionesMobileModel();

            using (var service = new UsuarioServiceClient())
            {
                lstObservaciones = service.GetNotificacionesConsultoraDetalle(userData.PaisID, ProcesoId, TipoOrigen).ToList();
                lstObservacionesPedido = service.GetNotificacionesConsultoraDetallePedido(userData.PaisID, ProcesoId, TipoOrigen).ToList();
            }
            model.Asunto = notificacion.Asunto;
            model.Campania = notificacion.CampaniaId;
            model.estado = notificacion.Estado;
            model.Observaciones = notificacion.Observaciones;
            model.FechaFacturacion = notificacion.FechaFacturacion;
            model.FacturaHoy = notificacion.FacturaHoy;
            model.ListaNotificacionesDetalle = lstObservaciones;
            model.ListaNotificacionesDetallePedido = lstObservacionesPedido;
            model.NombreConsultora = userData.NombreConsultora;
            model.Origen = TipoOrigen;
            model.TieneDescuentoCuv = userData.EstadoSimplificacionCUV && model.ListaNotificacionesDetallePedido != null &&
                model.ListaNotificacionesDetallePedido.Any(item => string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOferta == 1);

            if (model.TieneDescuentoCuv)
            {
                model.SubTotal = model.ListaNotificacionesDetallePedido.Sum(p => p.ImporteTotal);
                model.Descuento = -model.ListaNotificacionesDetallePedido[0].DescuentoProl;
                model.Total = model.SubTotal + model.Descuento;
            }
            else model.Total = model.ListaNotificacionesDetallePedido.Sum(p => p.ImporteTotal);
            model.DecimalToString = this.CreateConverterDecimalToString(userData.PaisID);

            ViewBag.Simbolo = userData.Simbolo;

            return View("ListadoObservaciones", model);
        }

        public ActionResult ListarObservacionesStock(long ProcesoId)
        {
            var userData = UserData();
            var notificaciones = ObtenerNotificaciones();
            var notificacion = notificaciones.FirstOrDefault(p => p.ProcesoId == ProcesoId);
            var lstObservacionesPedido = new List<BENotificacionesDetallePedido>();
            var model = new NotificacionesMobileModel();

            long ValStockId = Int64.Parse(notificacion.Observaciones);
            using (var service = new UsuarioServiceClient())
            {
                lstObservacionesPedido = service.GetValidacionStockProductos(userData.PaisID, userData.ConsultoraID, ValStockId).ToList();
            }

            foreach (var item in lstObservacionesPedido)
            {
                if (item.StockDisponible == 0) item.ObservacionPROL = string.Format("El producto {0} - {1} - cuenta nuevamente con stock. Si deseas agrégalo a tu pedido.", item.CUV, item.Descripcion);
                else
                {
                    if (item.StockDisponible == 1) item.ObservacionPROL = "Nos ingresó 1 unidad";
                    else item.ObservacionPROL = "Nos ingresaron " + item.StockDisponible + " unidades";

                    item.ObservacionPROL += string.Format(" del producto {0} - {1}. Si deseas agrégalo a tu pedido.", item.CUV, item.Descripcion);
                }
            }

            model.Asunto = notificacion.Asunto;
            model.FechaFacturacion = notificacion.FechaHoraValidación;

            model.ListaNotificacionesDetalle = new List<BENotificacionesDetalle>();
            model.ListaNotificacionesDetallePedido = lstObservacionesPedido;
            model.NombreConsultora = userData.NombreConsultora;
            model.Origen = 3;
            ViewBag.Simbolo = userData.Simbolo;

            return View("DetalleObservacionesStock", model);
        }

        public ActionResult DetalleSolicitudClienteCatalogo(long SolicitudId)
        {
            var userData = UserData();
            var model = new NotificacionesModel();

            var notificaciones = ObtenerNotificaciones();
            var notificacion = notificaciones.FirstOrDefault(p => p.Proceso.ToUpper() == "CATALOGO" && p.ProcesoId == SolicitudId);

            using (var sv = new UsuarioServiceClient())
            {
                model.NotificacionDetalleCatalogo = sv.ObtenerDetalleNotificacion(userData.PaisID, SolicitudId);
            }

            ViewBag.Asunto = notificacion.Asunto;
            ViewBag.Campania = notificacion.CampaniaId;
            ViewBag.FechaEjecucion = notificacion.FechaHoraValidación;
            ViewBag.Simbolo = userData.Simbolo;

            return View("DetalleSolicitudClienteCatalogo", model);
        }

        public ActionResult DetallePedidoRechazado(long ProcesoId)
        {
            NotificacionesModel model = new NotificacionesModel();
            List<BELogGPRValidacion> LogsGPRValidacion = new List<BELogGPRValidacion>(); ;

            using (PedidoRechazadoServiceClient sv = new PedidoRechazadoServiceClient())
            {
                LogsGPRValidacion = sv.GetBELogGPRValidacionByGetLogGPRValidacionId(userData.PaisID, ProcesoId, userData.ConsultoraID).ToList();
            }

            CargarMensajesNotificacionesGPR(model, LogsGPRValidacion);
            model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            model.CampaniaDescripcion = userData.CampaniaID.ToString();// + " " + model.Campania.Substring(0, 4);
                                                                       //model.FechaValidacionString = model.CampaniaDescripcion.ToString("dd/MM/yyyy hh:mm tt");
                                                                       //model.Total = model.SubTotal + model.Descuento;
                                                                       //model.SubTotalString = userData.Simbolo + " " + Util.DecimalToStringFormat(model.SubTotal, userData.CodigoISO);
                                                                       //model.DescuentoString = userData.Simbolo + " " + Util.DecimalToStringFormat(model.Descuento, userData.CodigoISO);
                                                                       //model.TotalString = userData.Simbolo + " " + Util.DecimalToStringFormat(model.Total, userData.CodigoISO);

            return View("ListadoPedidoRechazadoDetalle", model);
        }

        public ActionResult DetalleNotificacionesCDR()
        {
            return View();
        }

        #endregion

        #region Metodos

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

        #endregion
    }
}
