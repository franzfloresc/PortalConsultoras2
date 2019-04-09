﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Globalization;
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

        private readonly ConsultoraOnlineProvider _consultoraOnlineProvider;
        private const int refrescoGetCantidadPedidos = 30;
        MisPedidosModel objMisPedidos;
        readonly bool isEsika = false;
        #endregion

        public ConsultoraOnlineController()
            : this(new ConsultoraOnlineProvider())
        {
            if (_configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO))
            {
                isEsika = true;
            }
        }

        public ConsultoraOnlineController(ConsultoraOnlineProvider consultoraOnlineProvider)
        {
            if (_configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO))
            {
                isEsika = true;
            }
            _consultoraOnlineProvider = consultoraOnlineProvider;
        }

        ~ConsultoraOnlineController()
        {
            SessionManager.SetobjMisPedidos(null);
            SessionManager.SetobjMisPedidosDetalle(null);
            SessionManager.SetobjMisPedidosDetalleVal(null);
        }

        public ActionResult Index(string data)
        {
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
                bool consultoraAfiliada;
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

            var strpaises = _configuracionManagerProvider.GetPaisesConConsultoraOnlineFromConfig();
            if (!strpaises.Contains(userData.CodigoISO))
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            var consultoraAfiliar = DatoUsuario();
            return View(consultoraAfiliar);
        }

        public ActionResult Inscripcion()
        {
            var consultoraAfiliar = DatoUsuario();

            var url = Util.GetUrlHost(this.HttpContext.Request);
            var rutaPdf = "/Content/FAQ/CCC_TC_Consultoras.pdf";
            ViewBag.PDFLink = String.Format("{0}WebPages/DownloadPDF.aspx?file={1}", url, rutaPdf);

            return View(consultoraAfiliar);
        }

        [HttpPost]
        public JsonResult Inscripcion(ClienteContactaConsultoraModel model)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Algun campo requerido no ha sido ingresado",
                        data = ""
                    });
                }

                model = InscripcionPrepararDatos(model);

                var mensaje = InscripcionValidarCorreo(model);
                if (mensaje != "")
                {
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        data = ""
                    });
                }

                using (var sv = new UsuarioServiceClient())
                {
                    var result = sv.UpdateDatosPrimeraVez(userData.PaisID, userData.CodigoUsuario, model.Email, model.Telefono, "", model.Celular, model.CorreoAnterior, model.AceptoContrato);

                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar datos, intentelo mas tarde.",
                            data = ""
                        });
                    }

                }

                string message = InscripcionActualizarClave(model);
                message = InscripcionAfiliaCliente(model, message);

                var sEmail = Util.Trim(model.Email);
                var sTelefono = Util.Trim(model.Telefono);
                var sCelular = Util.Trim(model.Celular);

                userData.CambioClave = 1;
                userData.EMail = sEmail;
                userData.Telefono = sTelefono;
                userData.Celular = sCelular;

                SessionManager.SetUserData(userData);

                return Json(new
                {
                    success = true,
                    message = message,
                    data = ""
                });
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

        private ClienteContactaConsultoraModel InscripcionPrepararDatos(ClienteContactaConsultoraModel model)
        {
            if (model.ActualizarClave == null) model.ActualizarClave = "";
            if (model.ConfirmarClave == null) model.ConfirmarClave = "";
            return model;
        }

        private string InscripcionValidarCorreo(ClienteContactaConsultoraModel model)
        {
            var respuesta = "";

            if (model.Email != string.Empty)
            {
                using (var svr = new UsuarioServiceClient())
                {
                    var cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);

                    if (cantidad > 0)
                    {
                        respuesta = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.";
                    }
                }
            }
            return respuesta;
        }

        private string InscripcionActualizarClave(ClienteContactaConsultoraModel model)
        {
            var message = "";

            if (model.ActualizarClave != "")
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    var cambio = sv.ChangePasswordUser(userData.PaisID, userData.CodigoUsuario,
                    userData.CodigoISO + userData.CodigoUsuario, model.ConfirmarClave.ToUpper(),
                    string.Empty, EAplicacionOrigen.BienvenidaConsultora);

                    message = cambio
                        ? "- Los datos han sido actualizados correctamente.\n "
                        : "- Los datos han sido actualizados correctamente.\n - La contraseña no ha sido modificada, intentelo mas tarde.\n ";
                }
            }
            else
            {
                message = "- Los datos han sido actualizados correctamente.\n ";
            }

            return message;
        }

        private string InscripcionAfiliaCliente(ClienteContactaConsultoraModel model, string message)
        {
            if (!string.IsNullOrEmpty(model.Email))
            {
                try
                {
                    var parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
                    var paramQuerystring = Util.EncriptarQueryString(parametros);
                    var request = this.HttpContext.Request;

                    var mensaje = mensajeConsultora(userData.PrimerNombre, String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}", Util.GetUrlHost(request), paramQuerystring));
                    Util.EnviarMailMobile("no-responder@somosbelcorp.com", model.Email, "Confirma tu mail y actívate como Consultora Online", mensaje, true, "Consultora Online Belcorp");

                    message += "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    message += ex.Message;
                }

            }

            return message;
        }
        public ActionResult InscripcionCompleta()
        {
            return View();
        }

        public ActionResult Afiliar()
        {

            try
            {
                SessionManager.SetkeyFechaGetCantidadPedidos(null);
                SessionManager.SetkeyCantidadGetCantidadPedidos(null);

                var consultoraAfiliar = new ClienteContactaConsultoraModel();
                using (var sc = new SACServiceClient())
                {
                    var beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(userData.PaisID, userData.CodigoConsultora);
                    consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;
                }

                if (consultoraAfiliar.Afiliado)
                    return RedirectToAction("Index", "ConsultoraOnline", new { area = "Mobile" });

                if (Request.QueryString["data"] != null)
                {
                    var query = Util.DesencriptarQueryString(Request.QueryString["data"].ToString()).Split(';');

                    using (var srv = new UsuarioServiceClient())
                    {
                        srv.ActiveEmail(Convert.ToInt32(query[1]), query[0], query[2], query[3]);
                    }
                }

                consultoraAfiliar = DatoUsuario();
                var hasSuccess = !(String.IsNullOrEmpty(consultoraAfiliar.Email.Trim()) || !consultoraAfiliar.EmailActivo);

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

            var strpaises = _configuracionManagerProvider.GetPaisesConConsultoraOnlineFromConfig();
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
                    string paramQuerystring = Util.EncriptarQueryString(parametros);
                    HttpRequestBase request = HttpContext.Request;

                    string mensaje = mensajeConsultora(userData.PrimerNombre, String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}", Util.GetUrlHost(request), paramQuerystring));
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
                SessionManager.SetkeyFechaGetCantidadPedidos(null);
                SessionManager.SetkeyCantidadGetCantidadPedidos(null);

                using (var sc = new SACServiceClient())
                {
                    sc.UpdDesafiliaClienteConsultora(userData.PaisID, consultoraID, false, opcionDesafiliacion);

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
            SessionManager.SetkeyFechaGetCantidadPedidos(null);
            SessionManager.SetkeyCantidadGetCantidadPedidos(null);

            var model = new MisPedidosModel();

            using (var sv = new UsuarioServiceClient())
            {
                var lstPedidos = sv.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                model.ListaPedidos = lstPedidos.OrderByDescending(x => x.FechaSolicitud).ToList();
            }

            SessionManager.SetobjMisPedidos(model);

            return View(model);
        }

        [HttpPost]
        public JsonResult MostrarMasPedidos(int cantidadOmitir)
        {
            try
            {
                var consultoraOnlineMisPedidos = SessionManager.GetobjMisPedidos();

                return Json(new
                {
                    success = true,
                    lista = consultoraOnlineMisPedidos.ListaPedidos.Skip(cantidadOmitir).Take(10).ToList(),
                    total = consultoraOnlineMisPedidos.ListaPedidos.Count
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
            if (SessionManager.GetobjMisPedidos() == null)
            {
                using (var sv = new UsuarioServiceClient())
                {
                    model.ListaPedidos = sv.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                }

                SessionManager.SetobjMisPedidos(model);
            }

            var consultoraOnlineMisPedidos = SessionManager.GetobjMisPedidos();

            var pedido = consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == pedidoId);
            ViewBag.NombreCompleto = userData.NombreConsultora;

            List<BEMisPedidosDetalle> olstMisPedidosDet;
            using (UsuarioServiceClient svc = new UsuarioServiceClient())
            {
                olstMisPedidosDet = svc.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, pedidoId).ToList();
                SessionManager.SetobjMisPedidosDetalle(olstMisPedidosDet);
            }

            if (pedido != null)
            {
                pedido.DetallePedido = olstMisPedidosDet.ToArray();
            }

            return View("DetallePedido", pedido);
        }

        [HttpPost]
        public JsonResult CancelarPedido(long SolicitudId, int OpcionCancelado, string RazonMotivoCancelado)
        {
            string message;
            var success = true;

            try
            {
                using (var sc = new SACServiceClient())
                {
                    var consultoraOnlineMisPedidos = SessionManager.GetobjMisPedidos();

                    sc.CancelarSolicitudCliente(userData.PaisID, SolicitudId, OpcionCancelado, RazonMotivoCancelado);

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

                    MisPedidosModel refreshMisPedidos = new MisPedidosModel { ListaPedidos = refresh };
                    SessionManager.SetobjMisPedidos(refreshMisPedidos);
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


                if (SessionManager.GetkeyFechaGetCantidadPedidos() != null && SessionManager.GetkeyCantidadGetCantidadPedidos() != null)
                {
                    var fecha = Convert.ToDateTime(SessionManager.GetkeyFechaGetCantidadPedidos());
                    var diferencia = DateTime.Now - fecha;
                    if (diferencia.TotalMinutes > refrescoGetCantidadPedidos)
                    {
                        using (var sv = new UsuarioServiceClient())
                        {
                            cantidadPedidos = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                        }

                        SessionManager.SetkeyFechaGetCantidadPedidos(DateTime.Now);
                        SessionManager.SetkeyCantidadGetCantidadPedidos(cantidadPedidos);
                    }
                    else
                    {
                        cantidadPedidos = Convert.ToInt32(SessionManager.GetkeyCantidadGetCantidadPedidos());
                    }
                }
                else
                {
                    using (var sv = new UsuarioServiceClient())
                    {
                        cantidadPedidos = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                    }

                    SessionManager.SetkeyFechaGetCantidadPedidos(DateTime.Now);
                    SessionManager.SetkeyCantidadGetCantidadPedidos(cantidadPedidos);
                }
            }
            catch (Exception ex)
            {
                mensaje = ex.Message;
            }
            return Json(new { mensaje, cantidadPedidos }, JsonRequestBehavior.AllowGet);
        }

        #endregion        

        #region Métodos

        private ClienteContactaConsultoraModel DatoUsuario()
        {


            var consultoraAfiliar = new ClienteContactaConsultoraModel { NombreConsultora = userData.PrimerNombre };

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

        private string mensajeConsultora(string consultora, string url)
        {
            string tlfBelcorpResponde = _configuracionManagerProvider.GetConfiguracionManager(String.Format(Constantes.ConfiguracionManager.BelcorpRespondeTEL, userData.CodigoISO));
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigCdn.GetUrlFileCdn(carpetaPais, "spacer.gif");
            string mailing03 = ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_03.png");
            string mailing05 = ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_05.png");
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">");
            mensaje.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_01.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", mailing03));
            mensaje.AppendLine("<td colspan=\"3\" style=\"text-align:left; padding-top:50px; padding-bottom:20px; font-size:18px;\">");
            mensaje.AppendLine(String.Format("¡Hola, {0}!<br/><br/>", consultora));
            mensaje.AppendLine("Pronto tus clientes podr&#225;n encontrarte en el App de Cat&#225;logos y en las p&#225;ginas web de las marcas");
            mensaje.AppendLine("¡No pierdas la oportunidad de conseguir nuevos pedidos y nuevos ");
            mensaje.AppendLine("clientes! Para finalizar la activación haz clic en el botón.");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td colspan=\"3\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", mailing05));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"text-align:center; padding-top:20px;\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}\" target=\"_blank\">", url));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"236\" height=\"35\" border=\"0\" alt=\"Activar consultora online\"></a></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "3-Mailing-de-confirmacion-de-correo_03.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", mailing03));
            mensaje.AppendLine("<td colspan=\"3\" style=\"text-align:left; padding-bottom:20px; font-size:15px;\">");
            mensaje.AppendLine("Si tienes alguna duda o necesitas mayor información ingresa a la sección ");
            mensaje.AppendLine("<span style=\"font-weight:bold;\">Consultora Online</span> en somosbelcorp.com o llama a Belcorp Responde ");
            mensaje.AppendLine(String.Format("al {0}.", tlfBelcorpResponde));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td colspan=\"3\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", mailing05));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_12.png")));
            mensaje.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", ConfigCdn.GetUrlFileCdn(carpetaPais, "Facebook.png")));
            mensaje.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", ConfigCdn.GetUrlFileCdn(carpetaPais, "Youtube.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");

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
            string spacerGif = ConfigCdn.GetUrlFileCdn(carpetaPais, "spacer.gif");
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif !important;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">	");
            mensaje.AppendLine("<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"105\" alt=\"\">", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_01.png")));
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
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"154\" alt=\"\">", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_02.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td style=\"color:#712788; text-align:left; background-color:#edf1f4; font-size:21px;\">  ");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"257\" height=\"1\" alt=\"\">          ", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_05.png")));
            mensaje.AppendLine("<span style=\"color:#768ea3; font-size:18px;\">");
            mensaje.AppendLine(String.Format("Felicitaciones, {0}", consultora));
            mensaje.AppendLine("</span><br/><br/>");
            mensaje.AppendLine("¡Te has activado<br/> como <span style=\"font-weight:bold;\">Consultora Online!</span>            ");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"378\" height=\"154\" alt=\"\">", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_04.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"161\" alt=\"Ahora tu nombre estar&#225; disponible en el App de Cat&#225;logos &#201;sika, L’bel y Cyzone y en las en la p&#225;gina web de nuestras marcas y nuevos clientes podr&#225;n contactarse.\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_11.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"778\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_06.png")));
            mensaje.AppendLine("<td colspan=\"4\"> ");
            mensaje.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=MiPerfil\" target=\"_blank\">", contextoBase));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"132\" border=\"0\" alt=\"Actualuza tu perfil\"></a></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_13.png")));
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"35\" height=\"778\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_08.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"65\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_09.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=MisPedidos\" target=\"_blank\"", contextoBase));
            mensaje.AppendLine("onmouseover=\"window.status='mantente conectada';  return true;\"");
            mensaje.AppendLine("onmouseout=\"window.status='';  return true;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"132\" border=\"0\" alt=\"\"></a></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_16.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"69\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_11-12.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine("<a href=\"#\" target=\"_blank\"");
            mensaje.AppendLine("onmouseover=\"window.status='Contáctalos al instante';  return true;\"");
            mensaje.AppendLine("onmouseout=\"window.status='';  return true;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"142\" border=\"0\" alt=\"\"></a></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_18.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"67\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_13-14.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td rowspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"176\" height=\"84\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_14.png")));
            mensaje.AppendLine("<td colspan=\"2\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=ConsultoraOnline\" target=\"_blank\">", contextoBase));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"221\" height=\"36\" border=\"0\" alt=\"Ir a consultora online\"></a></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_21.png")));
            mensaje.AppendLine("<td rowspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"203\" height=\"84\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_16-17.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"221\" height=\"48\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_17.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"87\" alt=\"Ingresa a Consultora Online para ver consejos sobre c&#243;mo aparecer primera en la lista de consultoras.\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_24.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_12.png")));
            mensaje.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>", ConfigCdn.GetUrlFileCdn(carpetaPais, "Facebook.png")));
            mensaje.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>", ConfigCdn.GetUrlFileCdn(carpetaPais, "Youtube.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");

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

        #endregion

        public ActionResult Historial()
        {
            var model = new ConsultoraOnlineHistorialMobileModel();

            try
            {
                model.CampaniasConsultoraOnline = new List<CampaniaModel>();
                for (int i = 0; i <= 2; i++)
                {
                    model.CampaniasConsultoraOnline.Add(new CampaniaModel { CampaniaID = Util.AddCampaniaAndNumero(userData.CampaniaID, -i, userData.NroCampanias) });
                }
                model.CampaniasConsultoraOnline.Update(campania =>
                {
                    campania.Anio = Convert.ToInt32(campania.CampaniaID.ToString().Substring(0, 4));
                    campania.NroCampania = Convert.ToInt32(campania.CampaniaID.ToString().Substring(4, 2));
                });
                model.CampaniaActualConsultoraOnline = userData.CampaniaID;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        public ActionResult DetallePedidoHistorial(long solicitudClienteID)
        {
            var model = new ClienteOnlineModel();

            try
            {
                BEMisPedidos clienteOnline;
                List<BEMisPedidosDetalle> listDetallesClienteOnline;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    clienteOnline = sv.GetPedidoClienteOnlineBySolicitudClienteId(userData.PaisID, solicitudClienteID);
                    listDetallesClienteOnline = sv.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, solicitudClienteID).ToList();
                }

                model = Mapper.Map<ClienteOnlineModel>(clienteOnline);
                model.Detalles = Mapper.Map<List<ClienteOnlineDetalleModel>>(listDetallesClienteOnline);
                model.Detalles.Update(modelDetalle =>
                {
                    modelDetalle.PrecioUnitarioString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(modelDetalle.PrecioUnitario.ToDecimal(), userData.CodigoISO));
                    modelDetalle.PrecioTotalString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(modelDetalle.PrecioTotal.ToDecimal(), userData.CodigoISO));
                    modelDetalle.TipoAtencionString = modelDetalle.TipoAtencion == (int)(Enumeradores.ConsultoraOnlineTipoAtencion.YaTengo) ? Constantes.COTipoAtencionMensaje.YaTengo :
                        (modelDetalle.TipoAtencion == (int)(Enumeradores.ConsultoraOnlineTipoAtencion.IngresadoPedido) ? Constantes.COTipoAtencionMensaje.IngresadoPedido :
                        (modelDetalle.TipoAtencion == (int)(Enumeradores.ConsultoraOnlineTipoAtencion.Agotado) ? Constantes.COTipoAtencionMensaje.Agotado : ""));
                });

                model.EstadoDesc = model.Estado == "A" ? "Aceptado" : "Cancelado";
                model.Cliente = Util.ReemplazarSaltoLinea(model.Cliente, " ");
                model.Direccion = Util.ReemplazarSaltoLinea(model.Direccion, " ");
                model.Telefono = Util.ReemplazarSaltoLinea(model.Telefono, " ");
                model.Email = Util.ReemplazarSaltoLinea(model.Email, " ");
                model.MensajeDelCliente = Util.ReemplazarSaltoLinea(model.MensajeDelCliente, " ");
                model.PuedeCancelar = (userData.CampaniaID.ToString() == model.Campania && model.Estado == "A");
                model.PrecioTotal = Convert.ToDecimal(model.Detalles.Sum(detalle => detalle.PrecioTotal));
                model.PrecioTotalString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(model.PrecioTotal, userData.CodigoISO));

                using (SACServiceClient sv = new SACServiceClient())
                {
                    List<BEMotivoSolicitud> motivoSolicitud = sv.GetMotivosRechazo(userData.PaisID).ToList();
                    model.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(motivoSolicitud);
                }
            }
            catch (FaultException ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }
            catch (Exception ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }

            return View(model);
        }

        public ActionResult Pendientes()
        {
            MisPedidosModel model = new MisPedidosModel();
            //var isCLiente = false;
            try
            {
                var lstMisPedidos = new List<BEMisPedidos>();
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    lstMisPedidos = svc.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                }

                lstMisPedidos.RemoveAll(x => x.Estado.Trim().Length > 0);
                if (lstMisPedidos.Count > 0)
                {
                    // Falta agrupar por correo

                    lstMisPedidos.ForEach(y => y.FormartoFechaSolicitud = y.FechaSolicitud.ToString("dd") + " de " + y.FechaSolicitud.ToString("MMMM", new CultureInfo("es-ES")));
                    lstMisPedidos.ForEach(y => y.FormatoPrecioTotal = Util.DecimalToStringFormat(y.PrecioTotal, userData.CodigoISO));

                    // obtener todo los detalles de los pedidos por campania,consultora
                    var lstMisPedidosDetalleAll = new List<BEMisPedidosDetalle>();
                    using (UsuarioServiceClient svc = new UsuarioServiceClient())
                    {
                        lstMisPedidosDetalleAll = svc.GetMisPedidosDetallePendientesAll(userData.PaisID, userData.CampaniaID, userData.ConsultoraID).ToList();
                    }

                    foreach (var cab in lstMisPedidos)
                    {
                        var detalles = lstMisPedidosDetalleAll.Where(x => x.PedidoId == cab.PedidoId);
                        if (detalles.Any()) cab.DetallePedido = detalles.ToArray();
                    }

                    model.ListaPedidos = lstMisPedidos;

                    var lstByProductos = new List<BEMisPedidosDetalle>();
                    var grpListCuv = lstMisPedidosDetalleAll.Select(x => x.CUV).Distinct().ToList();
                    foreach (var cuv in grpListCuv)
                    {
                        var lstCuv = lstMisPedidosDetalleAll.Where(x => x.CUV == cuv);
                        var det = lstMisPedidosDetalleAll.First(x => x.CUV == cuv);
                        var ids = lstCuv.Where(x => x.CUV == cuv).Select(x => x.PedidoId.ToString()).ToArray();
                        //item.Cantidad = lst1.Count();
                        det.CantidadTotal = lstCuv.Sum(x => x.Cantidad);
                        det.PrecioTotal = lstCuv.Sum(x => x.PrecioUnitario);
                        det.FormatoPrecioTotal = Util.DecimalToStringFormat(det.PrecioTotal.ToDecimal(), userData.CodigoISO);
                        det.ListaClientes = lstMisPedidos.Where(x => ids.Contains(x.PedidoId.ToString())).ToArray();
                        lstByProductos.Add(det);

                        //var data = olstMisPedidos.FirstOrDefault(x => x.CUV == cuv);
                        //data.Cantidad = olstMisPedidos.Count(x => x.CUV == cuv);
                        //var clientes = olstMisPedidos.Where(x => x.CUV == cuv);
                        //data.ListaClientes = clientes.ToArray();
                        //ListaPorProductos.Add(data);
                    }
                    model.ListaProductos = lstByProductos;

                    objMisPedidos = model;
                    SessionManager.SetobjMisPedidos(objMisPedidos);

                    //var lstClientesExistentes = olstMisPedidos.Where(x => x.FlagConsultora).ToList();

                    //if (lstClientesExistentes.Count == olstMisPedidos.Count)
                    //{
                    //    model.FechaPedidoReciente = "24:00:00";
                    //}
                    //else
                    //{
                    //    var pedidoReciente = olstMisPedidos.Where(x => !x.FlagConsultora).OrderBy(x => x.FechaSolicitud).First();

                    //    DateTime starDate = DateTime.Now;
                    //    DateTime endDate = pedidoReciente.FechaSolicitud.AddDays(1);

                    //    TimeSpan ts = endDate - starDate;
                    //    model.FechaPedidoReciente = ts.Hours.ToString().PadLeft(2, '0') + ":" + ts.Minutes.ToString().PadLeft(2, '0') + ":" + ts.Seconds.ToString().PadLeft(2, '0');
                    //}

                    model.RegistrosTotal = model.ListaPedidos.Count.ToString();
                }
                else
                {
                    model.RegistrosTotal = "0";
                    return RedirectToAction("Detalle", "Pedido", new { area = "Mobile" });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        //public ActionResult DetallePedidoPendiente(int pedidoId)
        public ActionResult DetallePedidoPendiente(string ids)
        {
            MisPedidosDetalleModel model = new MisPedidosDetalleModel();

            try
            {
                MisPedidosModel pedidos = SessionManager.GetobjMisPedidos();
                if (string.IsNullOrEmpty(ids))
                {
                    if (pedidos.ListaPedidos.Any())
                        return RedirectToAction("Pendientes", "ConsultoraOnline", new { area = "Mobile" });
                    else
                        return RedirectToAction("Home", "Bienvenida", new { area = "Mobile" });
                }

                //long _pedidoId = Convert.ToInt64(pedidoId);
                //BEMisPedidos pedido = consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == _pedidoId && p.Estado.Trim().Length == 0);
                var arrIds = ids.Split(',');
                var lstPedido = pedidos.ListaPedidos.Where(x => arrIds.Contains(x.PedidoId.ToString()));

                //if (pedido == null)
                if (!lstPedido.Any())
                {
                    //if (consultoraOnlineMisPedidos.ListaPedidos.Count > 0)
                    if (pedidos.ListaPedidos.Any())
                        return RedirectToAction("Pendientes", "ConsultoraOnline", new { area = "Mobile" });
                    else
                        return RedirectToAction("Home", "Bienvenida", new { area = "Mobile" });
                   
                }
                pedidos.ListaPedidos = lstPedido.ToList();
                var lstMisPedidosDet = new List<BEMisPedidosDetalle>();
                foreach (var cab in lstPedido)
                {
                    foreach (var det in cab.DetallePedido)
                    {
                        lstMisPedidosDet.Add(det);
                    }
                }
                //using (UsuarioServiceClient svc = new UsuarioServiceClient())
                //{
                //    olstMisPedidosDet = svc.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, pedidoId).ToList();
                //}

                model.ListaDetalle2 = new List<MisPedidosDetalleModel2>();
                if (lstMisPedidosDet.Any())
                {
                    var firstPedido = pedidos.ListaPedidos.FirstOrDefault();
                    model.MiPedido = firstPedido;

                  
                    lstMisPedidosDet = CargarMisPedidosDetalleDatos(firstPedido.MarcaID, lstMisPedidosDet);
                    SessionManager.SetobjMisPedidosDetalle(lstMisPedidosDet);
                    SessionManager.SetobjMisPedidos(pedidos);
                    var detallePedidos = Mapper.Map<List<BEMisPedidosDetalle>, List<MisPedidosDetalleModel2>>(lstMisPedidosDet);
                    detallePedidos.Update(p => p.CodigoIso = userData.CodigoISO);
                    model.ListaDetalle2 = detallePedidos;
                }

                model.RegistrosTotal = model.ListaDetalle2.Count.ToString();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            using (SACServiceClient sv = new SACServiceClient())
            {
                var lsMotivos = sv.GetMotivosRechazo(userData.PaisID).ToList();
                ViewBag.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(lsMotivos);
            }

            return View(model);
        }

        private List<BEMisPedidosDetalle> CargarMisPedidosDetalleDatos(int marcaId, List<BEMisPedidosDetalle> lstMisPedidosDet)
        {
            // 0=App Catalogos, > 0=Portal Marca
            if (marcaId != 0) return lstMisPedidosDet;

            int? revistaGana = null;
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                revistaGana = svc.ValidarDesactivaRevistaGana(userData.PaisID, userData.CampaniaID, userData.CodigoZona);
            }

            var lstMisProductos = GetValidarCuvMisPedidos(lstMisPedidosDet);

            foreach (var item in lstMisPedidosDet)
            {
                var pedidoVal = lstMisProductos.FirstOrDefault(x => x.CUV == item.CUV);
                if (pedidoVal == null)
                {
                    item.TieneStock = 0;
                    item.MensajeValidacion = "El producto solicitado no existe";
                    continue;
                }

                item.TieneStock = pedidoVal.TieneStock.ToInt();
                item.EstaEnRevista = pedidoVal.EstaEnRevista.ToInt();

                if (!pedidoVal.TieneStock)
                {
                    item.MensajeValidacion = "Este producto está agotado";
                }
                else if (pedidoVal.CUVRevista.Length != 0 && revistaGana == 0)
                {
                    item.EstaEnRevista = 1;
                    item.MensajeValidacion = isEsika
                        ? Constantes.MensajeEstaEnRevista.EsikaMobile
                        : Constantes.MensajeEstaEnRevista.LbelMobile;
                }
            }

            return lstMisPedidosDet;
        }

        private List<ServiceODS.BEProducto> GetValidarCuvMisPedidos(List<BEMisPedidosDetalle> lstMisPedidosDet)
        {
            //var txtBuil = new StringBuilder();
            //foreach (var item in lstMisPedidosDet)
            //{
            //    txtBuil.Append(item.CUV + ",");
            //}

            //var inputCuv = txtBuil.ToString();
            var inputCuv = string.Join(",", lstMisPedidosDet.Select(x => x.CUV).ToList());
            //inputCuv = inputCuv.Substring(0, inputCuv.Length - 1);
            var lstMisProductos = new List<ServiceODS.BEProducto>();

            using (ODSServiceClient svc = new ODSServiceClient())
            {
                lstMisProductos = svc.GetValidarCUVMisPedidos(userData.PaisID, userData.CampaniaID, inputCuv, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona).ToList();
            }

            SessionManager.SetobjMisPedidosDetalleVal(lstMisProductos);
            return lstMisProductos;
        }

        public ActionResult PendientesMedioDeCompra()
        {
            var model = new PedidosPendientesMedioPagoModel();
            var parametrosRecomendado = new RecomendadoRequest();
            List<BEMisPedidos> pedidosSesion;
            var oListaCatalogo = new List<MisPedidosDetalleModel2>();
            var productosSolicitados = new List<ProductoSolicitado>();
          
            pedidosSesion = SessionManager.GetobjMisPedidos().ListaPedidos;

            ///////////////////////////////
            pedidosSesion.ForEach(x=> { x.DetallePedido.FirstOrDefault().Elegido = true; });
            //////////////////////////////////

            pedidosSesion.ForEach(pedido =>
            {
                if (pedido.DetallePedido.Any(i => i.Elegido == true))
                {
                    var odetalleTemporal = CargarMisPedidosDetalleDatos(pedido.MarcaID, pedido.DetallePedido.Where(i => i.Elegido == true).ToList());
                    var detallePedidos = Mapper.Map<List<BEMisPedidosDetalle>, List<MisPedidosDetalleModel2>>(odetalleTemporal);
                    detallePedidos.Update(p => p.CodigoIso = userData.CodigoISO);
                    oListaCatalogo.AddRange(detallePedidos);
                }
            });

            model.ListaCatalogo = new List<MisPedidosDetalleModel2>();

            parametrosRecomendado.codigoPais = userData.CodigoISO;
            parametrosRecomendado.codigocampania = userData.CampaniaID.ToString();
            parametrosRecomendado.codigoZona = userData.CodigoZona;
            parametrosRecomendado.origen = "sb-desktop";
            parametrosRecomendado.codigoConsultora = userData.CodigoConsultora;
            parametrosRecomendado.cuv = string.Empty;
            parametrosRecomendado.personalizaciones = string.Empty;
            parametrosRecomendado.configuracion = new Configuracion()
            {
                sociaEmpresaria = userData.Lider.ToString(),
                suscripcionActiva = (revistaDigital.EsSuscrita && revistaDigital.EsActiva).ToString(),
                mdo = revistaDigital.ActivoMdo.ToString(),
                rd = revistaDigital.TieneRDC.ToString(),
                rdi = revistaDigital.TieneRDI.ToString(),
                rdr = revistaDigital.TieneRDCR.ToString(),
                diaFacturacion = userData.DiaFacturacion,
                mostrarProductoConsultado = IsMobile().ToString()

            };
            oListaCatalogo.ForEach(x=> {

                if (productosSolicitados.Any(i => i.CodigoSap == x.CodigoSap))
                {
                    productosSolicitados.FirstOrDefault(i => i.CodigoSap == x.CodigoSap).Cantidad = productosSolicitados.FirstOrDefault(i => i.CodigoSap == x.CodigoSap).Cantidad + x.Cantidad;
                }
                else
                {
                    productosSolicitados.Add(new ProductoSolicitado() {
                        Cantidad = x.Cantidad,
                        CodigoSap = x.CodigoSap
                    });
                }
            });
            parametrosRecomendado.productosSolicitados = productosSolicitados.ToArray();
            parametrosRecomendado.codigoProducto = productosSolicitados.Select(x=>x.CodigoSap).ToArray();


            var oListaGana = _consultoraOnlineProvider.GetRecomendados(parametrosRecomendado);
            model.ListaCatalogo = oListaCatalogo;
            model.TotalCatalogo = oListaCatalogo.Sum(x => x.Cantidad*x.PrecioTotal);
            model.ListaGana = oListaGana;
            model.TotalGana = oListaGana.Sum(x =>x.Cantidad* x.Precio2);
            model.GananciaGana = oListaGana.Sum(x => x.Ganancia);

            return View(model);
        }

        /////////Lista por clientes ///////

        public ActionResult DetallePedidoPendienteClientes(string cuv)
        {
            MisPedidosModel model = new MisPedidosModel();

            try
            {
                MisPedidosModel pedidos = SessionManager.GetobjMisPedidos();
                if (string.IsNullOrEmpty(cuv))
                {
                    if (pedidos.ListaPedidos.Any())
                        return RedirectToAction("Pendientes", "ConsultoraOnline", new { area = "Mobile" });
                    else
                        return RedirectToAction("Home", "Bienvenida", new { area = "Mobile" });
                }

                //string _cuv = Convert.ToString(cuv);      
                var arrIds = new List<string>();
                var Listadetalle = new List<BEMisPedidosDetalle>();
                foreach (var cab in pedidos.ListaPedidos)
                {
                    var detalles = cab.DetallePedido.Where(x => x.CUV == cuv);
                    if (detalles.Any())
                    {
                        arrIds.Add(cab.PedidoId.ToString());
                        foreach(var item in detalles)
                        {
                            Listadetalle.Add(item);
                        }                      
                    }
              
                }

                if (!arrIds.Any())
                {
                    //if (consultoraOnlineMisPedidos.ListaPedidos.Count > 0)
                    if (pedidos.ListaPedidos.Any())
                        return RedirectToAction("Pendientes", "ConsultoraOnline", new { area = "Mobile" });
                    else
                        return RedirectToAction("Home", "Bienvenida", new { area = "Mobile" });
                }

                var lstPedidos = pedidos.ListaPedidos.Where(x => arrIds.Contains(x.PedidoId.ToString()));
                foreach (var cab in lstPedidos)
                {
                    cab.CantidadTotal = cab.DetallePedido.Where(x => x.CUV == cuv).Sum(x => x.Cantidad);
                }
                model.ListaPedidos = lstPedidos.ToList();
                model.ListaPedidos[0].DetallePedido = Listadetalle.ToArray();
                model.RegistrosTotal = model.ListaPedidos.Count.ToString();
                SessionManager.SetobjMisPedidos(model);
                SessionManager.SetobjMisPedidosDetalle(Listadetalle);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            using (SACServiceClient svc = new SACServiceClient())
            {
                var motivoSolicitud = svc.GetMotivosRechazo(userData.PaisID).ToList();
                ViewBag.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(motivoSolicitud);
            }

            return View(model);
        }

        //private List<BEMisPedidos> CargarMisPedidosDatosClientes(int marcaId,List<BEMisPedidos> olstMisPedidos)
        //{
        //    // 0=App Catalogos, >0=Portal Marca
        //    if (marcaId != 0)
        //    {
        //        return olstMisPedidos;
        //    }

        //    int? revistaGana = null;
        //    using (PedidoServiceClient sv = new PedidoServiceClient())
        //    {
        //        revistaGana = sv.ValidarDesactivaRevistaGana(userData.PaisID, userData.CampaniaID, userData.CodigoZona);
        //    }

        //    List<ServiceODS.BEProducto> olstMisProductos = GetValidarCuvMisPedidosCliente(olstMisPedidos);

        //    foreach (var item in olstMisPedidos)
        //    {
        //        var pedidoVal = olstMisProductos.FirstOrDefault(x => x.CUV == item.DetallePedido[0].CUV);
        //        if (pedidoVal == null)
        //        {
        //            item.DetallePedido[0].TieneStock = 0;
        //            item.DetallePedido[0].MensajeValidacion = "El producto solicitado no existe";
        //            continue;
        //        }

        //        item.DetallePedido[0].TieneStock = pedidoVal.TieneStock.ToInt();
        //        item.DetallePedido[0].EstaEnRevista = pedidoVal.EstaEnRevista.ToInt();

        //        if (!pedidoVal.TieneStock)
        //        {
        //            item.DetallePedido[0].MensajeValidacion = "Este producto está agotado";
        //        }
        //        else if (pedidoVal.CUVRevista.Length != 0 && revistaGana == 0)
        //        {
        //            item.DetallePedido[0].EstaEnRevista = 1;
        //            item.DetallePedido[0].MensajeValidacion = isEsika
        //                ? Constantes.MensajeEstaEnRevista.EsikaMobile
        //                : Constantes.MensajeEstaEnRevista.LbelMobile;
        //        }


        //    }

        //    return olstMisPedidos;
        //}

        //private List<ServiceODS.BEProducto> GetValidarCuvMisPedidosCliente(List<BEMisPedidos> olstMisPedidos)
        //{

        //    var txtBuil = new StringBuilder();
        //    foreach (var item in olstMisPedidos)
        //    {
        //        txtBuil.Append(item.DetallePedido[0].CUV + ",");
        //    }

        //    var inputCuv = txtBuil.ToString();
        //    inputCuv = inputCuv.Substring(0, inputCuv.Length - 1);

        //    List<ServiceODS.BEProducto> olstMisProductos;

        //    using (ODSServiceClient svc = new ODSServiceClient())
        //    {
        //        olstMisProductos = svc.GetValidarCUVMisPedidos(userData.PaisID, userData.CampaniaID, inputCuv, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona).ToList();
        //    }

        //    SessionManager.SetobjMisPedidosDetalleVal(olstMisProductos);
        //    return olstMisProductos;
        //}

    }
}
