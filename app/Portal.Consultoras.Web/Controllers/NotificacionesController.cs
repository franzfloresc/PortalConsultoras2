using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
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
        //
        // GET: /Notificaciones/

        public ActionResult Index()
        {
            SessionKeys.ClearSessionCantidadNotificaciones();

            List<BENotificaciones> olstNotificaciones = new List<BENotificaciones>();
            NotificacionesModel model = new NotificacionesModel();
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                olstNotificaciones = sv.GetNotificacionesConsultora(UserData().PaisID, UserData().ConsultoraID).ToList();
            }
            model.ListaNotificaciones = olstNotificaciones;
            return View(model);
        }

        //R2073
        public ActionResult ListarNotificaciones(long ProcesoId, int TipoOrigen)
        {
            NotificacionesModel model = new NotificacionesModel();
            List<BENotificaciones> olstNotificaciones = new List<BENotificaciones>();
            int PaisId = UserData().PaisID;
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
                olstNotificaciones = sv.GetNotificacionesConsultora(UserData().PaisID, UserData().ConsultoraID).ToList();
            }

            model.ListaNotificaciones = olstNotificaciones;

            return PartialView("ListadoNotificaciones", model);
        }

        public JsonResult ActualizarEstadoNotificacion(long ProcesoId, int TipoOrigen)
        {
            try
            {
                var PaisId = userData.PaisID;
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
                }
                var data = new
                {
                    success = true,
                    message = "Se actualizo con exito la notificacion"
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch(Exception e)
            {
                var data = new
                {
                    success = true,
                    message = e.Message
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            
        }

        //R2319 - JLCS
        public ActionResult ListarDetalleSolicitudCliente(long SolicitudId)
        {
            SolicitudClienteConsultoraModel model = new SolicitudClienteConsultoraModel();
            int PaisId = UserData().PaisID;
            ViewBag.PaisID = PaisId;
            ViewBag.Simbolo = UserData().Simbolo;
            ViewBag.NombreCompleto = UserData().NombreConsultora;

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
            model.ListaNotificacionesDetallePedido = olstObservacionesPedido;
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
                item.ObservacionPROL = string.Format("El producto {0} - {1} - cuenta nuevamente con stock. Si deseas agrégalo a tu pedido.", item.CUV, item.Descripcion);
            }

            model.ListaNotificacionesDetalle = olstObservaciones;
            model.ListaNotificacionesDetallePedido = olstObservacionesPedido;
            model.NombreConsultora = UserData().NombreConsultora;
            model.Origen = 3;
            return PartialView("ListadoObservaciones", model);
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
                list = sv.GetNotificacionesConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }
            return list;
        }
    }
}
