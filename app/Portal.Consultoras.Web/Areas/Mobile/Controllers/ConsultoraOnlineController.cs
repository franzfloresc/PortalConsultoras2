using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
//using Portal.Consultoras.Web.ServiceConsultoraOnline;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ConsultoraOnlineController : BaseMobileController
    {
        #region Variables

        private const string keyFechaGetCantidadPedidos = "fechaGetCantidadPedidos";
        private const string keyCantidadGetCantidadPedidos = "cantidadGetCantidadPedidos";
        private const int refrescoGetCantidadPedidos = 30; //Lapso de tiempo en Minutos

        #endregion

        ~ConsultoraOnlineController()
        {
            Session["objMisPedidos"] = null;
        }

        public ActionResult Index(string data)
        {
            var userData = UserData();
            var consultora = new ClienteContactaConsultoraModel();

            if (data != null)
            {
                if (data.Equals("successful"))
                {
                    ViewBag.EmailConfirmado = true;
                    ViewBag.EmailConsultora = userData.EMail;
                    ViewBag.ConsultoraID = userData.ConsultoraID;
                }
            }
            else
            {
                var consultoraAfiliada = false;
                using (var sc = new SACServiceClient())
                {
                    var beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(userData.PaisID, userData.CodigoConsultora);

                    consultoraAfiliada = beAfiliaCliente.EsAfiliado > 0;
                    consultora.ConsultoraID = beAfiliaCliente.ConsultoraID;
                }
                if (!consultoraAfiliada)
                {
                    return RedirectToAction("Informacion", "ConsultoraOnline", new { area = "Mobile" });
                }
                ViewBag.ConsultoraID = consultora.ConsultoraID;
            }

            return View(consultora);
        }

        #region Afiliar/Desafiliar

        public ActionResult Informacion()
        {
            var userData = UserData();
            var strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
            if (!strpaises.Contains(userData.CodigoISO))
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            var consultoraAfiliar = DatoUsuario();
            return View(consultoraAfiliar);
        }

        public ActionResult Inscripcion()
        {
            var consultoraAfiliar = DatoUsuario();

            var url = Util.GetUrlHost(this.HttpContext.Request);
            var rutaPDF = "/Content/FAQ/CCC_TC_Consultoras.pdf";
            ViewBag.PDFLink = String.Format("{0}WebPages/DownloadPDF.aspx?file={1}", url, rutaPDF);

            return View(consultoraAfiliar);
        }

        [HttpPost]
        public JsonResult Inscripcion(ClienteContactaConsultoraModel model)
        {
            var userData = UserData();
            var consultoraAfiliar = new ClienteContactaConsultoraModel();

            consultoraAfiliar.Email = model.Email;
            consultoraAfiliar.Celular = model.Celular;
            consultoraAfiliar.Telefono = model.Telefono;
            consultoraAfiliar.NombreCompleto = model.Nombres;

            if (ModelState.IsValid)
            {
                try
                {
                    var sEmail = string.Empty;
                    var sTelefono = string.Empty;
                    var sCelular = string.Empty;

                    if (model.ActualizarClave == null) model.ActualizarClave = "";
                    if (model.ConfirmarClave == null) model.ConfirmarClave = "";
                    if (model.Email != null)
                        sEmail = model.Email;
                    if (model.Telefono != null)
                        sTelefono = model.Telefono;
                    if (model.Celular != null)
                        sCelular = model.Celular;

                    var result = 0;
                    var cambio = false;
                    var resultado = string.Empty;

                    if (model.Email != string.Empty)
                    {
                        var cantidad = 0;
                        using (var svr = new UsuarioServiceClient())
                        {
                            cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);

                            if (cantidad > 0)
                            {
                                return Json(new
                                {
                                    success = false,
                                    message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                                    data = ""
                                });
                            }
                        }
                    }

                    using (var sv = new UsuarioServiceClient())
                    {
                        result = sv.UpdateDatosPrimeraVez(userData.PaisID, userData.CodigoUsuario, model.Email, model.Telefono, model.Celular, model.CorreoAnterior, model.AceptoContrato);

                        if (result == 0)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "Error al actualizar datos, intentelo mas tarde.",
                                data = ""
                            });
                        }
                        else
                        {
                            string message = string.Empty;

                            if (model.ActualizarClave != "")
                            {
                                cambio = sv.ChangePasswordUser(userData.PaisID, userData.CodigoUsuario, userData.CodigoISO + userData.CodigoUsuario, model.ConfirmarClave.ToUpper(), string.Empty, EAplicacionOrigen.BienvenidaConsultora);

                                message = cambio ? "- Los datos han sido actualizados correctamente.\n " : "- Los datos han sido actualizados correctamente.\n - La contraseña no ha sido modificada, intentelo mas tarde.\n ";
                            }
                            else
                            {
                                message = "- Los datos han sido actualizados correctamente.\n ";
                            }

                            if (!string.IsNullOrEmpty(model.Email))
                            {
                                try
                                {
                                    var parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
                                    var param_querystring = Util.EncriptarQueryString(parametros);
                                    var request = this.HttpContext.Request;

                                    var mensaje = mensajeConsultora(userData.PrimerNombre, String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}", Util.GetUrlHost(request), param_querystring));
                                    Util.EnviarMailMobile("no-responder@somosbelcorp.com", model.Email, "Confirma tu mail y actívate como Consultora Online", mensaje, true, "Consultora Online Belcorp");

                                    message += "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                                    message += ex.Message;//"- Ha ocurrido un error en el envío del correo de verificación.";
                                    return Json(new
                                    {
                                        success = false,
                                        message = message,
                                        data = ""
                                    });
                                }

                            }

                            UserData().CambioClave = 1;
                            UserData().EMail = sEmail;
                            UserData().Telefono = sTelefono;
                            UserData().Celular = sCelular;

                            return Json(new
                            {
                                success = true,
                                message = message,
                                data = ""
                            });
                        }
                    }
                }
                catch (Exception ex)
                {
                    return Json(new
                    {
                        success = false,
                        message = ex.Message,
                        data = ""
                    });
                }
            }

            return Json(new
            {
                success = false,
                message = "Algun campo requerido no ha sido ingresado",
                data = ""
            });
        }

        public ActionResult InscripcionCompleta()
        {
            return View();
        }

        public ActionResult Afiliar()
        {
            var userData = UserData();
            try
            {
                Session[keyFechaGetCantidadPedidos] = null;
                Session[keyCantidadGetCantidadPedidos] = null;

                var consultoraAfiliar = new ClienteContactaConsultoraModel();
                using (var sc = new SACServiceClient())
                {
                    var beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(userData.PaisID, userData.CodigoConsultora);
                    consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;
                }

                if (consultoraAfiliar.Afiliado)
                    return RedirectToAction("Index", "ConsultoraOnline", new { area = "Mobile" });


                var hasSuccess = false;
                if (Request.QueryString["data"] != null)
                {
                    //Formato que envia la url: CodigoUsuario;IdPais
                    var query = Util.DesencriptarQueryString(Request.QueryString["data"].ToString()).Split(';');

                    using (var srv = new UsuarioServiceClient())
                    {
                        hasSuccess = srv.ActiveEmail(Convert.ToInt32(query[1]), query[0], query[2], query[3]);
                    }
                }

                consultoraAfiliar = DatoUsuario();
                hasSuccess = true;

                if (String.IsNullOrEmpty(consultoraAfiliar.Email.Trim()) || consultoraAfiliar.EmailActivo == false)
                {
                    hasSuccess = false;
                }

                if (consultoraAfiliar.EsPrimeraVez)
                {
                    using (var sc = new SACServiceClient())
                    {
                        sc.InsAfiliaClienteConsultora(userData.PaisID, consultoraAfiliar.ConsultoraID);
                    }
                }
                else
                {
                    using (var sc = new SACServiceClient())
                    {
                        sc.UpdAfiliaClienteConsultora(userData.PaisID, consultoraAfiliar.ConsultoraID, true);
                    }
                }

                try
                {
                    if (hasSuccess)
                    {
                        var mensaje = mensajeAfiliacion(userData.PrimerNombre, Util.GetUrlHost(this.HttpContext.Request).ToString());
                        Util.EnviarMailMobile("no-responder@somosbelcorp.com", userData.EMail, "¡Felicitaciones, ya eres una Consultora Online!", mensaje, true, "Consultora Online Belcorp");
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "ConsultoraOnline", new { area = "Mobile", data = "successful", utm_source = "Transaccional", utm_medium = "email", utm_content = "Confirmacion_email", utm_campaign = "ConsultoraOnline" });
        }

        [HttpPost]
        public JsonResult EnviaCorreo()
        {
            var userData = UserData();

            var strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
            if (!strpaises.Contains(userData.CodigoISO))
                return Json(new
                {
                    success = false,
                    message = "Pais no permitido",
                    data = "BIENVENIDA"
                });

            try
            {
                var consultoraAfiliar = DatoUsuario();
                if (!consultoraAfiliar.EmailActivo)
                {
                    string[] parametros = { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, userData.EMail };
                    string param_querystring = Util.EncriptarQueryString(parametros);
                    HttpRequestBase request = HttpContext.Request;

                    string mensaje = mensajeConsultora(userData.PrimerNombre, String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}", Util.GetUrlHost(request), param_querystring));
                    Util.EnviarMailMobile("no-responder@somosbelcorp.com", userData.EMail, "Confirma tu mail y actívate como Consultora Online", mensaje, true, "Consultora Online Belcorp");

                    return Json(new
                    {
                        success = true,
                        message = "Mensaje Enviado",
                        data = "OK"
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = true,
                    message = ex.Message,
                    data = "ERROR"
                });
            }

            return Json(new
            {
                success = false,
                message = "NO ENVIADO",
                data = "BIENVENIDA"
            });
        }

        [HttpPost]
        public JsonResult Desafiliar(long consultoraID, int opcionDesafiliacion)
        {
            try
            {
                Session[keyFechaGetCantidadPedidos] = null;
                Session[keyCantidadGetCantidadPedidos] = null;

                using (var sc = new SACServiceClient())
                {
                    sc.UpdDesafiliaClienteConsultora(UserData().PaisID, consultoraID, false, opcionDesafiliacion);

                    var data = new
                    {
                        success = true
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        #endregion

        #region Mis Pedidos

        public ActionResult MisPedidos()
        {
            Session[keyFechaGetCantidadPedidos] = null;
            Session[keyCantidadGetCantidadPedidos] = null;

            var userData = UserData();
            var model = new MisPedidosModel();

            using (var sv = new UsuarioServiceClient())
            {
                model.ListaPedidos = sv.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
            }

            Session["objMisPedidos"] = model;

            return View(model);
        }

        [HttpPost]
        public JsonResult MostrarMasPedidos(int cantidadOmitir)
        {
            try
            {
                var consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];

                return Json(new
                {
                    success = true,
                    lista = consultoraOnlineMisPedidos.ListaPedidos.Skip(cantidadOmitir).Take(10).ToList(),
                    total = consultoraOnlineMisPedidos.ListaPedidos.Count
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    success = false,
                    lista = "",
                    total = 0
                });
            }
        }

        public ActionResult DetallePedido(int pedidoId)
        {
            var model = new MisPedidosModel();
            if (Session["objMisPedidos"] == null)
            {           
                using (var sv = new UsuarioServiceClient())
                {
                    //model.ListaPedidos = sv.GetNotificacionesConsultoraOnline(userData.PaisID, userData.ConsultoraID).ToList();
                    model.ListaPedidos = sv.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                }

                Session["objMisPedidos"] = model;
            }

            var consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];

            var pedido = consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == pedidoId);
            ViewBag.Simbolo = UserData().Simbolo;

            return View("DetallePedido", pedido);
        }

        [HttpPost]
        public JsonResult AceptarPedido(string id)
        {
            var message = string.Empty;
            var success = true;
            var userData = UserData();
            var consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];

            var pedidoId = long.Parse(id);
            var pedido = consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == pedidoId);

            var marcaPedido = pedido == null ? "" : pedido.DetallePedido.Any() ? pedido.DetallePedido[0].Marca : "";

            var mensajeaCliente = "Gracias por haberme escogido como tu Consultora. Me pondré en contacto contigo para coordinar la hora y lugar de entrega.";
            try
            {
                using (var sc = new SACServiceClient())
                {
                    var beSolicitudCliente = new BESolicitudCliente();
                    beSolicitudCliente.SolicitudClienteID = pedidoId;
                    beSolicitudCliente.CodigoConsultora = userData.ConsultoraID.ToString();
                    beSolicitudCliente.MensajeaCliente = mensajeaCliente;
                    beSolicitudCliente.UsuarioModificacion = userData.CodigoUsuario;
                    beSolicitudCliente.Estado = "A";
                    sc.UpdSolicitudCliente(userData.PaisID, beSolicitudCliente);
                }

                var refresh = new List<BEMisPedidos>();
                foreach (var item in consultoraOnlineMisPedidos.ListaPedidos)
                {
                    if (item.PedidoId == int.Parse(id))
                    {
                        item.Estado = "A";
                        item.FechaModificacion = DateTime.Now;
                    }
                    refresh.Add(item);
                }

                var refreshMisPedidos = new MisPedidosModel();
                refreshMisPedidos.ListaPedidos = refresh;
                Session["objMisPedidos"] = refreshMisPedidos;

                using (var sc = new ClienteServiceClient())
                {
                    var beCliente = new BECliente();
                    beCliente.ConsultoraID = pedidoId;
                    beCliente.eMail = pedido.Email;//emailCliente;
                    beCliente.Nombre = pedido.Cliente;// NombreCliente;
                    beCliente.PaisID = userData.PaisID;
                    beCliente.Activo = true;
                    sc.Insert(beCliente);
                }
                string emailDe = ConfigurationManager.AppSettings["ConsultoraOnlineEmailDe"];
                if (pedido.FlagMedio == "01")
                {
                    double totalPedido = 0;

                    String titulocliente = "Tu pedido ha sido CONFIRMADO por " + UserData().PrimerNombre + " " + UserData().PrimerApellido + " - App de Catálogos Ésika, L'Bel y Cyzone";
                    StringBuilder mensajecliente = new StringBuilder();
                    mensajecliente.Append("<table width='100%' border='0' bgcolor='#ffffff' cellspacing='0' cellpadding='0' border-spacing='0' style='margin: 0; border: 0; border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append("<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td valign='middle' style='width: 15%'>");
                    mensajecliente.Append("<img src='https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/mailing/cabecera_email.jpg' border='0' height='70' width='70' alt='Catálogos Esika, LBel y Cyzone'>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("<td valign='middle'>");
                    mensajecliente.Append("<span style='display: block; color: #7f7f7f; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>");
                    mensajecliente.Append("Catálogos Esika, LBel, Cyzone");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td>");
                    mensajecliente.Append("<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td align='center' valign='middle' style='border-top-width: 1px; border-top-color: #DDDDDD; border-top-style: solid; height: 10px;'></td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<br>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append("<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody>");

                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append("<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' style='border-collapse: collapse!important;' align='center'>");

                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td colspan='2'>");
                    mensajecliente.Append("<span style='display: block; color: #7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Hola " + pedido.Cliente.Split(' ').First() + "</span>");
                    mensajecliente.Append("<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Tu Consultora " + UserData().PrimerNombre + " " + UserData().PrimerApellido + " ha confirmado tu pedido.</p>");
                    mensajecliente.Append("<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>En seguida se pondrá en contacto contigo para coordinar la hora y lugar de entrega.</p><br>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");

                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td><span style='display: block; color: #7f7f7f; font-size: 17px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>RESUMEN DE TU PEDIDO</span></td>");
                    mensajecliente.Append("</tr>");

                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td style='width: 65%;' align='top' valign='middle'>");
                    mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0.6em;'>");
                    mensajecliente.Append("<span style='color: #7f7f7f; font-size: 15px; text-align: left; font-family: Arial, Helvetica, sans-serif;'>CLIENTE:");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("<br>");
                    mensajecliente.Append("<span style='color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif;'> " + pedido.Cliente + "<br>");
                    mensajecliente.Append(pedido.Email + "<br>");
                    mensajecliente.Append(pedido.Telefono);
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("<td style='width: 35%;' align='top' valign='middle'>");
                    mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0 0.6em;'>");
                    mensajecliente.Append("<span style='color: #7f7f7f; font-size: 11px; text-align: left; font-family: Arial, Helvetica, sans-serif; line-height: 1em'>FECHA: " + String.Format("{0:dd/MM/yyyy}", pedido.FechaSolicitud) + "<br>");
                    mensajecliente.Append("CAMPAÑA: " + pedido.Campania + "<br>");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append(" <table width='600' border='0' cellspacing='0' cellpadding='10' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td valign='middle' colspan='3'>");
                    mensajecliente.Append("<span style='display: block; color:#7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; margin: 0.6em 0 0em;'>");
                    mensajecliente.Append("Listado de Productos</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    int cntfila = 0;
                    foreach (var item in pedido.DetallePedido)
                    {
                        totalPedido += item.PrecioTotal;

                        cntfila = cntfila + 1;

                        if (cntfila % 2 == 0)
                        {
                            mensajecliente.Append("<tr>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" + item.CUV + "</span></td>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" + item.Marca + "</span></td>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" + item.Producto + "</span></td>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " + UserData().Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                            mensajecliente.Append("<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " + item.Cantidad + "</span></td>");
                            mensajecliente.Append("</tr>");
                        }
                        else
                        {
                            mensajecliente.Append("<tr style = 'background: #cccccc;'>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" + item.CUV + "</span></td>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" + item.Marca + "</span></td>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" + item.Producto + "</span></td>");
                            mensajecliente.Append("<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " + UserData().Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                            mensajecliente.Append("<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " + item.Cantidad + "</span></td>");
                            mensajecliente.Append("</tr>");
                        }
                    }

                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='center' valign='middle' style='height: 15px;'></td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='left' valign='top'>");
                    mensajecliente.Append("<span style='display: inline-block; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; color: #7f7f7f; display: block; margin: 0.6em 0 0 0.6em;'>PRECIO TOTAL: " + UserData().Simbolo + " " + totalPedido.ToString("N2") + "");
                    mensajecliente.Append(" </span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");

                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td style='height: 70px;'>&nbsp;</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");

                    try
                    {
                        Common.Util.EnviarMail3Mobile(emailDe, pedido.Email, titulocliente, mensajecliente.ToString(), true, pedido.Email);
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                    }
                }
                else
                {

                    var titulo = "(" + userData.CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(marcaPedido); //Marca
                    var mensaje = new StringBuilder();
                    mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(pedido.Cliente));
                    mensaje.AppendFormat("{0}</p><br/>", mensajeaCliente);
                    mensaje.Append("<br/>Saludos,<br/><br />");
                    mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                    mensaje.AppendFormat("<td><p style='text-align: center;'><strong>{0}<br/>Consultora</strong></p></td></tr></table>", userData.NombreConsultora);
                    try
                    {
                        Util.EnviarMail3Mobile(emailDe, pedido.Email, titulo, mensaje.ToString(), true, string.Empty);

                        message = "El pedido fue aceptado.";
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                        message = ex.Message;
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = ex.Message;
                success = false;
            }

            return Json(new { success, message });
        }

        [HttpPost]
        public JsonResult RechazarPedido(long SolicitudId, int NumIteracion, string CodigoUbigeo, string Campania, int MarcaId, int OpcionRechazo, string RazonMotivoRechazo)
        {
            var message = string.Empty;
            var success = true;
            var userData = UserData();
            var fechaActual = DateTime.Now;
            using (var sv = new SACServiceClient())
            {
                var consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
                var tablalogicaDatos = sv.GetTablaLogicaDatos(userData.PaisID, 56);
                var numIteracionMaximo = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5601).Codigo);
                if (NumIteracion == numIteracionMaximo)
                {
                    sv.RechazarSolicitudCliente(userData.PaisID, SolicitudId, true, OpcionRechazo, RazonMotivoRechazo);
                }
                else
                {
                    try
                    {
                        var nuevaConsultora = sv.ReasignarSolicitudCliente(userData.PaisID, SolicitudId, CodigoUbigeo, Campania, MarcaId, OpcionRechazo, RazonMotivoRechazo);
                        if (nuevaConsultora != null)
                        {
                            var beSolicitudCliente = sv.GetSolicitudCliente(userData.PaisID, SolicitudId);
                            fechaActual = beSolicitudCliente.FechaModificacion;

                            try
                            {
                                string mensaje = mensajeRechazoPedido(nuevaConsultora.Nombre, Util.GetUrlHost(this.HttpContext.Request).ToString(), beSolicitudCliente);
                                Util.EnviarMailMobile("no-responder@somosbelcorp.com", nuevaConsultora.Email, "Un nuevo cliente te eligió como Consultora Online", mensaje, true, "Consultora Online Belcorp");
                            }
                            catch (Exception ex)
                            {
                                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                            }

                            var refresh = new List<BEMisPedidos>();
                            foreach (var item in consultoraOnlineMisPedidos.ListaPedidos)
                            {
                                if (item.PedidoId == SolicitudId)
                                {
                                    item.Estado = "R";
                                    item.FechaModificacion = DateTime.Now;
                                }
                                refresh.Add(item);
                            }

                            var refreshMisPedidos = new MisPedidosModel();
                            refreshMisPedidos.ListaPedidos = refresh;
                            Session["objMisPedidos"] = refreshMisPedidos;
                        }

                        message = "El pedido fue rechazado.";
                    }
                    catch (FaultException ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                        message = ex.Message;
                        success = false;
                    }
                }
            }

            return Json(new { success, message }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult CancelarPedido(long SolicitudId, int OpcionCancelado, string RazonMotivoCancelado)
        {
            var message = string.Empty;
            var success = true;
            var userData = UserData();
            var fechaActual = DateTime.Now;
            try
            {
                using (var sc = new SACServiceClient())
                {
                    var consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];

                    sc.CancelarSolicitudCliente(userData.PaisID, SolicitudId, OpcionCancelado, RazonMotivoCancelado);

                    var beSolicitudCliente = sc.GetSolicitudCliente(userData.PaisID, SolicitudId);
                    fechaActual = beSolicitudCliente.FechaModificacion;

                    var refresh = new List<BEMisPedidos>();
                    foreach (var item in consultoraOnlineMisPedidos.ListaPedidos)
                    {
                        if (item.PedidoId == SolicitudId)
                        {
                            item.Estado = "C";
                            item.FechaModificacion = DateTime.Now;
                        }
                        refresh.Add(item);
                    }
                    MisPedidosModel refreshMisPedidos = new MisPedidosModel();
                    refreshMisPedidos.ListaPedidos = refresh;
                    Session["objMisPedidos"] = refreshMisPedidos;
                }

                message = "El pedido fue cancelado.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = ex.Message;
                success = false;
            }

            return Json(new { success, message }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetCantidadPedidos()
        {
            var cantidadPedidos = -1;
            var mensaje = string.Empty;
            try
            {
                var userData = UserData();

                if (Session[keyFechaGetCantidadPedidos] != null && Session[keyCantidadGetCantidadPedidos] != null)
                {
                    var fecha = Convert.ToDateTime(Session[keyFechaGetCantidadPedidos]);
                    var diferencia = DateTime.Now - fecha;
                    if (diferencia.TotalMinutes > refrescoGetCantidadPedidos)
                    {
                        using (var sv = new UsuarioServiceClient())
                        {
                            cantidadPedidos = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                        }

                        Session[keyFechaGetCantidadPedidos] = DateTime.Now;
                        Session[keyCantidadGetCantidadPedidos] = cantidadPedidos;
                    }
                    else
                    {
                        cantidadPedidos = Convert.ToInt32(Session[keyCantidadGetCantidadPedidos]);
                    }
                }
                else
                {
                    using (var sv = new UsuarioServiceClient())
                    {
                        cantidadPedidos = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                    }

                    Session[keyFechaGetCantidadPedidos] = DateTime.Now;
                    Session[keyCantidadGetCantidadPedidos] = cantidadPedidos;
                }
            }
            catch (Exception ex)
            {
                mensaje = ex.Message;
            }
            return Json(new { mensaje, cantidadPedidos }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Mi Perfil

        //public ActionResult MiPerfil(string data)
        //{
        //    var userData = UserData();
        //    var correoVerificado = string.Empty;

        //    if (data != null)
        //    {
        //        var query = Util.DesencriptarQueryString(data).Split(';');
        //        var cantidadAfectados = 0;
        //        using (var us = new UsuarioServiceClient())
        //        {
        //            cantidadAfectados = us.UpdUsuarioEMail(userData.PaisID, userData.CodigoUsuario, query[3]);
        //        }

        //        if (cantidadAfectados > 0)
        //            correoVerificado = "Su dirección de correo electrónico ha sido verificada correctamente.";
        //        else
        //            correoVerificado = "Esta dirección de correo electrónico ya ha sido verificada.";
        //    }

        //    ViewBag.MensajeValidacionCorreo = correoVerificado;

        //    var model = DatosPerfil();
        //    model.CorreoAnterior = model.Email;

        //    return View(model);
        //}

        //[HttpPost]
        //public ActionResult MiPerfil(HttpPostedFileBase SubirFoto)
        //{
        //    var mensaje = string.Empty;
        //    var rutaImagen = string.Empty;
        //    try
        //    {
        //        rutaImagen = GuardarFotoPerfil(SubirFoto);
        //    }
        //    catch (Exception ex)
        //    {
        //        mensaje = ex.Message;
        //    }

        //    return RedirectToAction("MiPerfil");
        //}

        //[HttpPost]
        //public JsonResult SubirFotoPerfil()
        //{
        //    var mensaje = string.Empty;
        //    var rutaImagen = string.Empty;
        //    try
        //    {
        //        var imagen = Request.Files[0];
        //        rutaImagen = GuardarFotoPerfil(imagen);
        //    }
        //    catch (Exception ex)
        //    {
        //        mensaje = ex.Message;
        //    }
        //    return Json(new { mensaje, rutaImagen }, JsonRequestBehavior.AllowGet);
        //}

        //[HttpPost]
        //public JsonResult ListarComentarios(int pagina)
        //{
        //    var userData = UserData();
        //    var totalPaginas = 0;
        //    var lstComentariosEntidad = new List<BEConsultoraOnlineCometario>();

        //    using (var sv = new ConsultoraOnlineServiceClient())
        //    {
        //        var records = 10;
        //        var totalRecords = 0;

        //        lstComentariosEntidad = sv.GetCOnlineComentarios(userData.PaisID, userData.CodigoUsuario, pagina, records, out totalRecords).ToList();

        //        var numPage = Convert.ToDouble(totalRecords) / Convert.ToDouble(records);

        //        var intPage = totalRecords / records;
        //        if (intPage < numPage)
        //            totalPaginas = (int)intPage + 1;
        //        else
        //            totalPaginas = (int)intPage;
        //    }

        //    Mapper.CreateMap<BEConsultoraOnlineCometario, ComentariosPerfilModel>()
        //        .ForMember(t => t.Comentario, f => f.MapFrom(c => c.Comentario))
        //        .ForMember(t => t.Valoracion, f => f.MapFrom(c => c.Valoracion))
        //        .ForMember(t => t.Cliente, f => f.MapFrom(c => c.Cliente))
        //        .ForMember(t => t.FechaCreacion, f => f.MapFrom(c => c.FechaCreacion));

        //    var lstComentarios = Mapper.Map<IList<BEConsultoraOnlineCometario>, IEnumerable<ComentariosPerfilModel>>(lstComentariosEntidad);

        //    return Json(new { lstComentarios, totalPaginas }, JsonRequestBehavior.AllowGet);
        //}

        //[HttpPost]
        //public JsonResult ActualizarDatosPerfil(ClienteContactaConsultoraModel model)
        //{
        //    var userData = UserData();
        //    var message = string.Empty;
        //    var success = true;
        //    try
        //    {
        //        var perfilDatos = new BEConsultoraOnline();
        //        perfilDatos.CodigoUsuario = userData.CodigoUsuario;
        //        perfilDatos.PaisID = userData.PaisID;
        //        perfilDatos.EnlacePagina = model.EnlacePagina;
        //        perfilDatos.OpcBeneficioID = model.BeneficiosId;

        //        if (model.Email != model.CorreoAnterior)
        //        {
        //            var cantidad = 0;
        //            using (var svr = new UsuarioServiceClient())
        //            {
        //                cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);
        //            }

        //            if (cantidad > 0)
        //            {
        //                message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.";
        //                success = false;
        //            }
        //            else
        //            {
        //                try
        //                {
        //                    var parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
        //                    var param_querystring = Util.EncriptarQueryString(parametros);

        //                    var mensajeCorreo = mensajeCambioCorreo(userData.PrimerNombre, String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=ActualizarCorreo&data={1}", Util.GetUrlHost(this.HttpContext.Request), param_querystring), model.Email, model.CorreoAnterior);
        //                    Util.EnviarMailMobile("no-responder@somosbelcorp.com", model.Email, "Has cambiado tu correo de Somos Belcorp", mensajeCorreo, true, "Somos Belcorp");

        //                    message = "Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
        //                }
        //                catch (Exception ex)
        //                {
        //                    message = ex.Message;
        //                }

        //                using (var sco = new ConsultoraOnlineServiceClient())
        //                {
        //                    var datos = sco.UpdConsultoraPerfil(perfilDatos);
        //                }
        //            }
        //        }
        //        else
        //        {
        //            using (var sco = new ConsultoraOnlineServiceClient())
        //            {
        //                var datos = sco.UpdConsultoraPerfil(perfilDatos);
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        message += ex.Message;
        //        success = false;
        //    }

        //    return Json(new { success, message, model }, JsonRequestBehavior.AllowGet);
        //}

        #endregion

        #region Métodos

        private ClienteContactaConsultoraModel DatoUsuario()
        {
            var userData = UserData();

            var consultoraAfiliar = new ClienteContactaConsultoraModel();

            consultoraAfiliar.NombreConsultora = userData.PrimerNombre;

            using (var sc = new ServiceSAC.SACServiceClient())
            {
                var beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(userData.PaisID, userData.CodigoConsultora);

                consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;

                consultoraAfiliar.EsPrimeraVez = beAfiliaCliente.EsAfiliado < 0;

                consultoraAfiliar.ConsultoraID = beAfiliaCliente.ConsultoraID;

                consultoraAfiliar.EmailActivo = beAfiliaCliente.EmailActivo;

                consultoraAfiliar.NombreCompleto = beAfiliaCliente.NombreCompleto;

                consultoraAfiliar.Email = beAfiliaCliente.Email;

                consultoraAfiliar.Celular = beAfiliaCliente.Celular;

                consultoraAfiliar.Telefono = beAfiliaCliente.Telefono;
            }


            return consultoraAfiliar;
        }

        //public ClienteContactaConsultoraModel DatosPerfil()
        //{
        //    var consultoraPerfil = new ClienteContactaConsultoraModel();
        //    using (var sco = new ConsultoraOnlineServiceClient())
        //    {
        //        var entidadConsultora = new BEConsultoraOnline();
        //        entidadConsultora.CodigoUsuario = UserData().CodigoUsuario;
        //        entidadConsultora.PaisID = UserData().PaisID;

        //        var entidadPerfil = sco.GetCOnlinePerfil(entidadConsultora);
        //        consultoraPerfil.NombreCompleto = UserData().NombreConsultora;
        //        consultoraPerfil.Email = entidadPerfil.EMail;
        //        consultoraPerfil.EnlacePagina = entidadPerfil.EnlacePagina;
        //        consultoraPerfil.UrlImagen = entidadPerfil.URLFoto;
        //        consultoraPerfil.Beneficio = entidadPerfil.OpcBeneficio;
        //        consultoraPerfil.BeneficiosId = entidadPerfil.OpcBeneficioID;
        //        consultoraPerfil.Valoracion = entidadPerfil.Valoracion;
        //        consultoraPerfil.iniciales = entidadPerfil.Iniciales;

        //    }
        //    return consultoraPerfil;
        //}

        private string mensajeConsultora(string consultora, string url)
        {
            string tlfBelcorpResponde = ConfigurationManager.AppSettings.Get(String.Format("BelcorpRespondeTEL_{0}", UserData().CodigoISO));
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigS3.GetUrlFileS3(carpetaPais, "spacer.gif", string.Empty);
            string mailing_03 = ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_03.png", string.Empty);
            string mailing_05 = ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_05.png", string.Empty);
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">");
            mensaje.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_01.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", mailing_03));
            mensaje.AppendLine("<td colspan=\"3\" style=\"text-align:left; padding-top:50px; padding-bottom:20px; font-size:18px;\">");
            mensaje.AppendLine(String.Format("¡Hola, {0}!<br/><br/>", consultora));
            //gr-1250 4.1
            mensaje.AppendLine("Pronto tus clientes podr&#225;n encontrarte en el App de Cat&#225;logos y en las p&#225;ginas web de las marcas");
            mensaje.AppendLine("¡No pierdas la oportunidad de conseguir nuevos pedidos y nuevos ");
            mensaje.AppendLine("clientes! Para finalizar la activación haz clic en el botón.");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td colspan=\"3\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", mailing_05));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"text-align:center; padding-top:20px;\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}\" target=\"_blank\">", url));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"236\" height=\"35\" border=\"0\" alt=\"Activar consultora online\"></a></td>", ConfigS3.GetUrlFileS3(carpetaPais, "3-Mailing-de-confirmacion-de-correo_03.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", mailing_03));
            mensaje.AppendLine("<td colspan=\"3\" style=\"text-align:left; padding-bottom:20px; font-size:15px;\">");
            mensaje.AppendLine("Si tienes alguna duda o necesitas mayor información ingresa a la sección ");
            mensaje.AppendLine("<span style=\"font-weight:bold;\">Consultora Online</span> en somosbelcorp.com o llama a Belcorp Responde ");
            mensaje.AppendLine(String.Format("al {0}.", tlfBelcorpResponde));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td colspan=\"3\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", mailing_05));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_12.png", string.Empty)));
            mensaje.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Facebook.png", string.Empty)));
            mensaje.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Youtube.png", string.Empty)));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
            //mensaje.AppendLine("¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"192\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"201\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"164\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"18\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            return mensaje.ToString();
        }

        private string mensajeAfiliacion(string consultora, string contextoBase)
        {
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigS3.GetUrlFileS3(carpetaPais, "spacer.gif", string.Empty);
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif !important;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">	");
            mensaje.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"105\" alt=\"\">", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_01.png", string.Empty)));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\" width=\"682\">");
            mensaje.AppendLine("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" style=\"color:#768ea3; table-layout:fixed; width:682px;\">");
            mensaje.AppendLine("<colgroup>");
            mensaje.AppendLine("<col style=\"width:47px;\">");
            mensaje.AppendLine("<col style=\"width:257px;\">");
            mensaje.AppendLine("<col style=\"width:378px;\">");
            mensaje.AppendLine("</colgroup>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"154\" alt=\"\">", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_02.png", string.Empty)));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td style=\"color:#712788; text-align:left; background-color:#edf1f4; font-size:21px;\">  ");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"257\" height=\"1\" alt=\"\">          ", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_05.png", string.Empty)));
            mensaje.AppendLine("<span style=\"color:#768ea3; font-size:18px;\">");
            mensaje.AppendLine(String.Format("Felicitaciones, {0}", consultora));
            mensaje.AppendLine("</span><br/><br/>");
            mensaje.AppendLine("¡Te has activado<br/> como <span style=\"font-weight:bold;\">Consultora Online!</span>            ");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"378\" height=\"154\" alt=\"\">", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_04.png", string.Empty)));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\">");
            //gr-1250 5-1
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"161\" alt=\"Ahora tu nombre estar&#225; disponible en el App de Cat&#225;logos &#201;sika, L’bel y Cyzone y en las en la p&#225;gina web de nuestras marcas y nuevos clientes podr&#225;n contactarse.\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_11.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"778\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_06.png", string.Empty)));
            mensaje.AppendLine("<td colspan=\"4\"> ");
            mensaje.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=MiPerfil\" target=\"_blank\">", contextoBase));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"132\" border=\"0\" alt=\"Actualuza tu perfil\"></a></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_13.png", string.Empty)));
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"35\" height=\"778\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_08.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"65\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_09.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=MisPedidos\" target=\"_blank\"", contextoBase));
            mensaje.AppendLine("onmouseover=\"window.status='mantente conectada';  return true;\"");
            mensaje.AppendLine("onmouseout=\"window.status='';  return true;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"132\" border=\"0\" alt=\"\"></a></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_16.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"69\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_11-12.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine("<a href=\"#\" target=\"_blank\"");
            mensaje.AppendLine("onmouseover=\"window.status='Contáctalos al instante';  return true;\"");
            mensaje.AppendLine("onmouseout=\"window.status='';  return true;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"142\" border=\"0\" alt=\"\"></a></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_18.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"67\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_13-14.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td rowspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"176\" height=\"84\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_14.png", string.Empty)));
            mensaje.AppendLine("<td colspan=\"2\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=ConsultoraOnline\" target=\"_blank\">", contextoBase));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"221\" height=\"36\" border=\"0\" alt=\"Ir a consultora online\"></a></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_21.png", string.Empty)));
            mensaje.AppendLine("<td rowspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"203\" height=\"84\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_16-17.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"221\" height=\"48\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_17.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"87\" alt=\"Ingresa a Consultora Online para ver consejos sobre c&#243;mo aparecer primera en la lista de consultoras.\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_24.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_12.png", string.Empty)));
            mensaje.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Facebook.png", string.Empty)));
            mensaje.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Youtube.png", string.Empty)));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
            //mensaje.AppendLine("¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>    ");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"176\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"81\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"140\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"203\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"35\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");


            return mensaje.ToString();
        }

        private string mensajeRechazoPedido(string consultora, string contextoBase, BESolicitudCliente SolicitudCliente)
        {
            DateTime fechaMaxima = SolicitudCliente.FechaModificacion.AddDays(1);
            var culture = new System.Globalization.CultureInfo("es-PE");
            var dia = culture.DateTimeFormat.GetDayName(fechaMaxima.DayOfWeek);
            var mes = culture.DateTimeFormat.GetMonthName(fechaMaxima.Month);
            dia = ToUpperFirstLetter(dia);
            mes = ToUpperFirstLetter(mes);
            string fechaFormato = String.Format("{0} {1} de {2} - {3}", dia, fechaMaxima.ToString("dd"), mes, fechaMaxima.ToString("hh:mm tt"));
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigS3.GetUrlFileS3(carpetaPais, "spacer.gif", string.Empty);
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">");
            mensaje.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine(String.Format("	<tr><td colspan=\"7\"><img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td><tr>", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_01.png", string.Empty)));
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine(String.Format("		<td><img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_03.png", string.Empty)));
            mensaje.AppendLine("		<td colspan=\"3\" style=\"text-align:left; padding-top:50px; padding-bottom:20px; font-size:18px;\">");
            mensaje.AppendLine(String.Format("        	Hola, {0}<br/><br/>", consultora));
            mensaje.AppendLine("            ¡Un nuevo cliente te ha elegido como su Consultora para");
            mensaje.AppendLine("			hacerte un pedido!<br/><br/>");
            mensaje.AppendLine("            Cliente:<br/>");
            mensaje.AppendLine(String.Format("            <span style=\"font-weight:bold;\">{0}</span>  <br/><br/>", SolicitudCliente.NombreCompleto));
            mensaje.AppendLine("            Fecha límite para aceptar o rechazar el pedido:<br/>");
            mensaje.AppendLine(String.Format("            <span style=\"font-weight:bold;\">{0}</span><br/><br/>", fechaFormato));
            mensaje.AppendLine("            Atiende su pedido y conviértete en su Consultora, ¡crear");
            mensaje.AppendLine("			una excelente relación depende de ti!");
            mensaje.AppendLine("        </td>");
            mensaje.AppendLine(String.Format("		<td colspan=\"3\"><img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_05.png", string.Empty)));
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine("		<td colspan=\"7\" style=\"text-align:center; padding-top:30px; padding-bottom:50px\">");
            mensaje.AppendLine(String.Format("			<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=SolicitudPedido\" target=\"_blank\"><img src=\"{1}\" width=\"201\" height=\"38\" border=\"0\" alt=\"Ver pedido\"></a>", contextoBase, ConfigS3.GetUrlFileS3(carpetaPais, "7-Mailing_03.png", string.Empty)));
            mensaje.AppendLine("		</td>");
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine("		<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("        <img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_12.png", string.Empty)));
            mensaje.AppendLine("        <a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("            <img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Facebook.png", string.Empty)));
            mensaje.AppendLine("        <a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("            <img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", ConfigS3.GetUrlFileS3(carpetaPais, "Youtube.png", string.Empty)));
            mensaje.AppendLine("        </td>");
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine("        <td colspan=\"7\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
            //mensaje.AppendLine("                ¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
            mensaje.AppendLine("        </td>");
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine("		<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("		<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"192\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("		<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"201\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("		<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"164\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("		<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("		<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("		<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"18\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("</table>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            return mensaje.ToString();
        }

        private string mensajeCambioCorreo(string consultora, string url, string correo, string correo_anterior)
        {
            string tlfBelcorpResponde = ConfigurationManager.AppSettings.Get(String.Format("BelcorpRespondeTEL_{0}", UserData().CodigoISO));
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigS3.GetUrlFileS3(carpetaPais, "spacer.gif", string.Empty);
            string mailing_01 = ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_01.png", string.Empty);
            string mailing_03 = ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_03.png", string.Empty);
            string mailing_05 = ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_05.png", string.Empty);
            string mailing_9 = ConfigS3.GetUrlFileS3(carpetaPais, "9-Mailing.png", string.Empty);
            string mailing_12 = ConfigS3.GetUrlFileS3(carpetaPais, "1-Mailing_12.png", string.Empty);
            string youtube = ConfigS3.GetUrlFileS3(carpetaPais, "Youtube.png", string.Empty);
            string facebook = ConfigS3.GetUrlFileS3(carpetaPais, "Facebook.png", string.Empty);
            StringBuilder mensaje = new StringBuilder();

            mensaje.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">");
            mensaje.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td>", mailing_01));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", mailing_03));
            mensaje.AppendLine("<td colspan=\"3\" style=\"text-align:left; padding-top:50px; padding-bottom:20px; font-size:18px;\">");
            mensaje.AppendLine(String.Format("Hola, {0}<br/><br/>", consultora));
            mensaje.AppendLine("Has cambiado tu correo principal de Somos Belcorp.");
            mensaje.AppendLine(String.Format("De <span style=\"font-weight:bold;\">{0}</span> a <span style=\"font-weight:bold;\">{1}</span><br/><br/>", correo_anterior, correo));
            mensaje.AppendLine("Por favor haz clic en el siguiente botón para verificar este nuevo correo.");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td colspan=\"3\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", mailing_05));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"text-align:center; padding-top:30px; padding-bottom:50px\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}\" target=\"_blank\">", url));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"201\" height=\"38\" border=\"0\" alt=\"Verificar correo\"></a></td>", ConfigS3.GetUrlFileS3(carpetaPais, "9-Mailing.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", mailing_12));
            mensaje.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", facebook));
            mensaje.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", youtube));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
            //mensaje.AppendLine("¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"192\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"201\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"164\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"18\" height=\"1\" alt=\"\"></td>", spacerGif));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");

            return mensaje.ToString();
        }

        private string ToUpperFirstLetter(string source)
        {
            if (string.IsNullOrEmpty(source))
                return string.Empty;
            char[] letters = source.ToCharArray();
            letters[0] = char.ToUpper(letters[0]);
            return new string(letters);
        }

        //private string GuardarFotoPerfil(HttpPostedFileBase foto)
        //{
        //    var userData = UserData();

        //    var fileName = userData.CodigoUsuario + "." + Path.GetFileName(foto.ContentType);
        //    var pathFisico = Path.Combine(Globals.RutaTemporalesConsultoraOnline, fileName);

        //    foto.SaveAs(pathFisico);

        //    pathFisico = Url.Content(Path.Combine(Globals.RutaTemporalesConsultoraOnline, fileName));
        //    var carpetaPais = Globals.RutaImagenesPerfilConsultoraOnline + "/" + userData.CodigoISO;

        //    ConfigS3.SetFileS3(pathFisico, carpetaPais, fileName);

        //    var rutaImagen = ConfigS3.GetUrlFileS3(carpetaPais, fileName, Globals.RutaTemporalesConsultoraOnline + "/" + userData.CodigoISO);

        //    var entidadConsultora = new BEConsultoraOnline();
        //    entidadConsultora.CodigoUsuario = userData.CodigoUsuario;
        //    entidadConsultora.URLFoto = rutaImagen;
        //    entidadConsultora.PaisID = userData.PaisID;

        //    using (var sco = new ConsultoraOnlineServiceClient())
        //    {
        //        sco.UpdConsultoraFoto(entidadConsultora);
        //    }

        //    return rutaImagen;
        //}

        #endregion
    }
}
