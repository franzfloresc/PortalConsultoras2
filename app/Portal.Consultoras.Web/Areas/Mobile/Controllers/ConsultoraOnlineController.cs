using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
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

        private const string keyFechaGetCantidadPedidos = "fechaGetCantidadPedidos";
        private const string keyCantidadGetCantidadPedidos = "cantidadGetCantidadPedidos";
        private const int refrescoGetCantidadPedidos = 30;
        MisPedidosModel objMisPedidos;
        readonly bool isEsika = false;
        #endregion

        public ConsultoraOnlineController()
        {
            if (_configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO))
            {
                isEsika = true;
            }
        }

        ~ConsultoraOnlineController()
        {
            sessionManager.SetobjMisPedidos(null);
            sessionManager.SetobjMisPedidosDetalle(null);
            sessionManager.SetobjMisPedidosDetalleVal(null);
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
            var userData = UserData();
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
            var userData = UserData();

            if (ModelState.IsValid)
            {
                try
                {
                    if (model.ActualizarClave == null) model.ActualizarClave = "";
                    if (model.ConfirmarClave == null) model.ConfirmarClave = "";
                    var sEmail = Util.Trim(model.Email);
                    var sTelefono = Util.Trim(model.Telefono);
                    var sCelular = Util.Trim(model.Celular);

                    if (model.Email != string.Empty)
                    {
                        using (var svr = new UsuarioServiceClient())
                        {
                            var cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);

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
                        else
                        {
                            string message;

                            if (model.ActualizarClave != "")
                            {
                                var cambio = sv.ChangePasswordUser(userData.PaisID, userData.CodigoUsuario, userData.CodigoISO + userData.CodigoUsuario, model.ConfirmarClave.ToUpper(), string.Empty, EAplicacionOrigen.BienvenidaConsultora);

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
                sessionManager.SetkeyFechaGetCantidadPedidos(null);
                sessionManager.SetkeyCantidadGetCantidadPedidos(null);

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
            var userData = UserData();
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
                sessionManager.SetkeyFechaGetCantidadPedidos(null);
                sessionManager.SetkeyCantidadGetCantidadPedidos(null);

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
            sessionManager.SetkeyFechaGetCantidadPedidos(null);
            sessionManager.SetkeyCantidadGetCantidadPedidos(null);

            var userData = UserData();

            var model = new MisPedidosModel();

            using (var sv = new UsuarioServiceClient())
            {
                var lstPedidos = sv.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                model.ListaPedidos = lstPedidos.OrderByDescending(x => x.FechaSolicitud).ToList();
            }

            sessionManager.SetobjMisPedidos(model);

            return View(model);
        }

        [HttpPost]
        public JsonResult MostrarMasPedidos(int cantidadOmitir)
        {
            try
            {
                var consultoraOnlineMisPedidos = (MisPedidosModel)sessionManager.GetobjMisPedidos();

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
            if (sessionManager.GetobjMisPedidos() == null)
            {
                using (var sv = new UsuarioServiceClient())
                {
                    model.ListaPedidos = sv.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                }

                sessionManager.SetobjMisPedidos(model);
            }

            var consultoraOnlineMisPedidos = (MisPedidosModel)sessionManager.GetobjMisPedidos();

            var pedido = consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == pedidoId);
            ViewBag.NombreCompleto = userData.NombreConsultora;

            List<BEMisPedidosDetalle> olstMisPedidosDet;
            using (UsuarioServiceClient svc = new UsuarioServiceClient())
            {
                olstMisPedidosDet = svc.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, pedidoId).ToList();
                sessionManager.SetobjMisPedidosDetalle(olstMisPedidosDet);
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
            var userData = UserData();
            try
            {
                using (var sc = new SACServiceClient())
                {
                    var consultoraOnlineMisPedidos = (MisPedidosModel) sessionManager.GetobjMisPedidos();

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
                    sessionManager.SetobjMisPedidos(refreshMisPedidos);
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

                if (sessionManager.GetkeyFechaGetCantidadPedidos() != null && sessionManager.GetkeyCantidadGetCantidadPedidos() != null)
                {
                    var fecha = Convert.ToDateTime(sessionManager.GetkeyFechaGetCantidadPedidos());
                    var diferencia = DateTime.Now - fecha;
                    if (diferencia.TotalMinutes > refrescoGetCantidadPedidos)
                    {
                        using (var sv = new UsuarioServiceClient())
                        {
                            cantidadPedidos = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                        }

                        sessionManager.SetkeyFechaGetCantidadPedidos(DateTime.Now);
                        sessionManager.SetkeyCantidadGetCantidadPedidos(cantidadPedidos);
                    }
                    else
                    {
                        cantidadPedidos = Convert.ToInt32(sessionManager.GetkeyCantidadGetCantidadPedidos());
                    }
                }
                else
                {
                    using (var sv = new UsuarioServiceClient())
                    {
                        cantidadPedidos = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                    }

                    sessionManager.SetkeyFechaGetCantidadPedidos(DateTime.Now);
                    sessionManager.SetkeyCantidadGetCantidadPedidos(cantidadPedidos);
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
            var userData = UserData();

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
            string tlfBelcorpResponde = _configuracionManagerProvider.GetConfiguracionManager(String.Format(Constantes.ConfiguracionManager.BelcorpRespondeTEL, UserData().CodigoISO));
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

            try
            {
                List<BEMisPedidos> olstMisPedidos;
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    olstMisPedidos = svc.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                }

                if (olstMisPedidos.Count > 0)
                {
                    olstMisPedidos.RemoveAll(x => x.Estado.Trim().Length > 0);

                    if (olstMisPedidos.Count > 0)
                    {
                        olstMisPedidos.ToList().ForEach(y => y.FormartoFechaSolicitud = y.FechaSolicitud.ToString("dd") + " de " + y.FechaSolicitud.ToString("MMMM", new CultureInfo("es-ES")));
                        olstMisPedidos.ToList().ForEach(y => y.FormatoPrecioTotal = Util.DecimalToStringFormat(y.PrecioTotal, userData.CodigoISO));

                        model.ListaPedidos = olstMisPedidos;

                        objMisPedidos = model;
                        sessionManager.SetobjMisPedidos(objMisPedidos);

                        var lstClientesExistentes = olstMisPedidos.Where(x => x.FlagConsultora).ToList();

                        if (lstClientesExistentes.Count == olstMisPedidos.Count)
                        {
                            model.FechaPedidoReciente = "24:00:00";
                        }
                        else
                        {
                            var pedidoReciente = olstMisPedidos.Where(x => !x.FlagConsultora).OrderBy(x => x.FechaSolicitud).First();

                            DateTime starDate = DateTime.Now;
                            DateTime endDate = pedidoReciente.FechaSolicitud.AddDays(1);

                            TimeSpan ts = endDate - starDate;
                            model.FechaPedidoReciente = ts.Hours.ToString().PadLeft(2, '0') + ":" + ts.Minutes.ToString().PadLeft(2, '0') + ":" + ts.Seconds.ToString().PadLeft(2, '0');
                        }

                        model.RegistrosTotal = model.ListaPedidos.Count.ToString();
                    }
                    else
                    {
                        model.RegistrosTotal = "0";
                        return RedirectToAction("Detalle", "Pedido", new { area = "Mobile" });
                    }
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

        public ActionResult DetallePedidoPendiente(int pedidoId)
        {
            MisPedidosDetalleModel model = new MisPedidosDetalleModel();

            try
            {
                MisPedidosModel consultoraOnlineMisPedidos = (MisPedidosModel)sessionManager.GetobjMisPedidos();
                long _pedidoId = Convert.ToInt64(pedidoId);
                BEMisPedidos pedido = consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == _pedidoId && p.Estado.Trim().Length == 0);

                if (pedido == null)
                {
                    if (consultoraOnlineMisPedidos.ListaPedidos.Count > 0)
                    {
                        return RedirectToAction("Pendientes", "ConsultoraOnline", new { area = "Mobile" });
                    }
                    else
                    {
                        return RedirectToAction("Home", "Bienvenida", new { area = "Mobile" });
                    }
                }

                List<BEMisPedidosDetalle> olstMisPedidosDet;
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    olstMisPedidosDet = svc.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, pedidoId).ToList();
                }

                if (olstMisPedidosDet.Count > 0)
                {
                    model.MiPedido = pedido;

                    sessionManager.SetobjMisPedidosDetalle(olstMisPedidosDet);

                    // 0=App Catalogos, >0=Portal Marca
                    if (pedido.MarcaID == 0)
                    {
                        int? revistaGana = null;
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            revistaGana = sv.ValidarDesactivaRevistaGana(userData.PaisID, userData.CampaniaID, userData.CodigoZona);
                        }

                        var txtBuil = new StringBuilder();
                        foreach (var item in olstMisPedidosDet)
                        {
                            txtBuil.Append(item.CUV + ",");
                        }

                        var inputCuv = txtBuil.ToString();
                        inputCuv = inputCuv.Substring(0, inputCuv.Length - 1);

                        List<ServiceODS.BEProducto> olstMisProductos;

                        using (ODSServiceClient svc = new ODSServiceClient())
                        {
                            olstMisProductos = svc.GetValidarCUVMisPedidos(userData.PaisID, userData.CampaniaID, inputCuv, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona).ToList();
                        }

                        sessionManager.SetobjMisPedidosDetalleVal(olstMisProductos);

                        foreach (var item in olstMisPedidosDet)
                        {
                            var pedidoVal = olstMisProductos.FirstOrDefault(x => x.CUV == item.CUV);
                            if (pedidoVal != null)
                            {
                                item.TieneStock = (pedidoVal.TieneStock) ? 1 : 0;
                                item.EstaEnRevista = (pedidoVal.EstaEnRevista) ? 1 : 0;

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
                            else
                            {
                                item.TieneStock = 0;
                                item.MensajeValidacion = "El producto solicitado no existe";
                            }

                        }
                    }

                    var detallePedidos = Mapper.Map<List<BEMisPedidosDetalle>, List<MisPedidosDetalleModel2>>(olstMisPedidosDet);
                    detallePedidos.Update(p => p.CodigoIso = userData.CodigoISO);

                    model.ListaDetalle2 = detallePedidos;
                    model.RegistrosTotal = model.ListaDetalle2.Count.ToString();
                }
                else
                {
                    model.RegistrosTotal = "0";
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            using (SACServiceClient sv = new SACServiceClient())
            {
                List<BEMotivoSolicitud> motivoSolicitud = sv.GetMotivosRechazo(userData.PaisID).ToList();
                ViewBag.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(motivoSolicitud);
            }

            return View(model);
        }

    }
}
