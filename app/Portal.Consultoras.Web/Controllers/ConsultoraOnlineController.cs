using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Pedido;
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

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultoraOnlineController : BaseController
    {
        #region Configuracion de Paginado
        private readonly ConsultoraOnlineProvider _consultoraOnlineProvider;
        MisPedidosModel objMisPedidos;
        readonly int registrosPagina;
        int indiceActualPagina = 0;
        int indiceUltimaPagina;
        readonly bool isEsika = false;

        #endregion

        public ConsultoraOnlineController()
               : this(new ConsultoraOnlineProvider())
        {
            this.registrosPagina = 5;

            if (userData.CodigoISO != null && _configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO))
            {
                isEsika = true;
            }
        }

        ~ConsultoraOnlineController()
        {
            SessionManager.SetobjMisPedidos(null);
            SessionManager.SetobjMisPedidosDetalle(null);
            SessionManager.SetobjMisPedidosDetalleVal(null);
        }

        public ConsultoraOnlineController(ConsultoraOnlineProvider consultoraOnlineProvider)
        {
            if (_configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO))
            {
                isEsika = true;
            }
            _consultoraOnlineProvider = consultoraOnlineProvider;
        }

        public ActionResult Index(string activation)
        {
            var consultora = new ClienteContactaConsultoraModel();
            if (activation != null)
            {
                if (activation.Equals("successful"))
                {
                    ViewBag.EmailConfirmado = true;
                    ViewBag.EmailConsultora = userData.EMail;
                    ViewBag.ConsultoraID = userData.ConsultoraID;
                }
            }
            else
            {
                var consultoraAfiliar = new ClienteContactaConsultoraModel();
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    ServiceSAC.BEAfiliaClienteConsultora beAfiliaCliente =
                        sc.GetAfiliaClienteConsultoraByConsultora(userData.PaisID, userData.CodigoConsultora);
                    consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;
                    consultora.ConsultoraID = beAfiliaCliente.ConsultoraID;
                }

                if (!consultoraAfiliar.Afiliado)
                {
                    return RedirectToAction("Informacion", "ConsultoraOnline");
                }

                ViewBag.ConsultoraID = consultora.ConsultoraID;
            }

            return View(consultora);
        }

        #region Informacion

        public ActionResult Informacion()
        {
            string strpaises = _configuracionManagerProvider.GetPaisesConConsultoraOnlineFromConfig();
            if (!strpaises.Contains(userData.CodigoISO))
                return RedirectToAction("Index", "Bienvenida");

            var consultoraAfiliar = DatoUsuario();
            return View(consultoraAfiliar);
        }

        #endregion

        #region Miembros de Inscripcion

        public ActionResult Inscripcion()
        {
            var consultoraAfiliar = DatoUsuario();
            HttpRequestBase request = this.HttpContext.Request;
            const string rutaPdf = "/Content/FAQ/CCC_TC_Consultoras.pdf";
            ViewBag.PDFLink = String.Format("{0}WebPages/DownloadPDF.aspx?file={1}", Util.GetUrlHost(request), rutaPdf);

            return View(consultoraAfiliar);
        }

        [HttpPost]
        public ActionResult Inscripcion(ClienteContactaConsultoraModel model)
        {
            var consultoraAfiliar = new ClienteContactaConsultoraModel
            {
                Email = model.Email,
                Celular = model.Celular,
                Telefono = model.Telefono,
                NombreCompleto = model.Nombres
            };


            if (ModelState.IsValid)
            {
                try
                {
                    model = InscripcionPrepararDatos(model);

                    var mensaje = InscripcionValidarCorreo(model);
                    if (mensaje != "")
                    {
                        ViewBag.EmailConsultoraTomado = mensaje;
                        return View(consultoraAfiliar);
                    }

                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        var result = sv.UpdateDatosPrimeraVez(userData.PaisID, userData.CodigoUsuario, model.Email,
                            model.Telefono, "", model.Celular, model.CorreoAnterior, model.AceptoContrato);

                        if (result == 0)
                        {
                            ViewBag.AppErrorMessage = "Error al actualizar datos, intentelo mas tarde";

                            return View(consultoraAfiliar);
                        }
                    }

                    string message = InscripcionActualizarClave(model);
                    message = InscripcionAfiliaCliente(model, message);

                    if (message == "1")
                        return RedirectToAction("Index", "ConsultoraOnline");

                    string sEmail = model.Email ?? string.Empty;
                    string sTelefono = model.Telefono ?? string.Empty;
                    string sCelular = model.Celular ?? string.Empty;

                    userData.CambioClave = 1;
                    userData.EMail = sEmail;
                    userData.Telefono = sTelefono;
                    userData.Celular = sCelular;

                    ViewBag.AppErrorMessage = message;

                    return View("InscripcionCompleta");

                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                return View(consultoraAfiliar);
            }

            return View(consultoraAfiliar);

        }

        private ClienteContactaConsultoraModel InscripcionPrepararDatos(ClienteContactaConsultoraModel model)
        {
            if (model.ActualizarClave == null) model.ActualizarClave = "";
            if (model.ConfirmarClave == null) model.ConfirmarClave = "";
            model.CorreoAnterior = userData.EMail;
            return model;
        }

        private string InscripcionValidarCorreo(ClienteContactaConsultoraModel model)
        {
            var respuesta = "";
            if (model.Email != string.Empty)
            {
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    var cantidad =
                        svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);

                    if (cantidad > 0)
                    {
                        respuesta =
                            "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.";
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
            try
            {
                if (string.IsNullOrEmpty(model.Email))
                    return message;

                ClienteContactaConsultoraModel consultoraAfiliarUser = DatoUsuario();

                if (consultoraAfiliarUser.EmailActivo && model.CorreoAnterior == model.Email)
                {
                    if (consultoraAfiliarUser.EsPrimeraVez)
                    {
                        using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                        {
                            sc.InsAfiliaClienteConsultora(userData.PaisID,
                                consultoraAfiliarUser.ConsultoraID);
                        }
                    }
                    else
                    {
                        using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                        {
                            sc.UpdAfiliaClienteConsultora(userData.PaisID,
                                consultoraAfiliarUser.ConsultoraID, true);
                        }
                    }

                    message = "1";
                }
                else
                {
                    string[] parametros = new string[]
                    {
                                            userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO,
                                            model.Email
                    };
                    string paramQuerystring = Util.EncriptarQueryString(parametros);
                    HttpRequestBase request = this.HttpContext.Request;

                    string cadena = mensajeConsultora(userData.PrimerNombre,
                        String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}",
                            Util.GetUrlHost(request), paramQuerystring));
                    Util.EnviarMail("no-responder@somosbelcorp.com", model.Email,
                        "Confirma tu mail y actívate como Consultora Online", cadena, true,
                        "Consultora Online Belcorp");
                    message +=
                        "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                    userData.CodigoISO);
                message += ex.Message;
            }

            return message;
        }

        public ActionResult EnviaCorreo()
        {
            string strpaises = _configuracionManagerProvider.GetPaisesConConsultoraOnlineFromConfig();
            if (!strpaises.Contains(userData.CodigoISO))
                return RedirectToAction("Index", "Bienvenida");

            var consultoraAfiliar = DatoUsuario();

            try
            {
                if (!consultoraAfiliar.EmailActivo)
                {
                    string[] parametros = new string[]
                        {userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, userData.EMail};
                    string paramQuerystring = Util.EncriptarQueryString(parametros);
                    HttpRequestBase request = this.HttpContext.Request;

                    string cadena = mensajeConsultora(userData.PrimerNombre,
                        String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}",
                            Util.GetUrlHost(request), paramQuerystring));
                    Util.EnviarMail("no-responder@somosbelcorp.com", userData.EMail,
                        "Confirma tu mail y actívate como Consultora Online", cadena, true,
                        "Consultora Online Belcorp");

                    return View("InscripcionCompleta");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Index", "ConsultoraOnline");
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Afiliar(string data)
        {
            try
            {
                var consultoraAfiliar = new ClienteContactaConsultoraModel();
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    ServiceSAC.BEAfiliaClienteConsultora beAfiliaCliente =
                        sc.GetAfiliaClienteConsultoraByConsultora(userData.PaisID, userData.CodigoConsultora);
                    consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;
                }

                if (consultoraAfiliar.Afiliado)
                    return RedirectToAction("Index", "ConsultoraOnline");

                if (data != null)
                {
                    string[] query = Util.DesencriptarQueryString(data).Split(';');

                    using (UsuarioServiceClient srv = new UsuarioServiceClient())
                    {
                        srv.ActiveEmail(Convert.ToInt32(query[1]), query[0], query[2], query[3]);
                    }
                }

                ClienteContactaConsultoraModel consultoraAfiliarUser = DatoUsuario();

                if (consultoraAfiliarUser.EsPrimeraVez)
                {
                    using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                    {
                        sc.InsAfiliaClienteConsultora(userData.PaisID, consultoraAfiliarUser.ConsultoraID);
                    }

                }
                else
                {
                    using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                    {
                        sc.UpdAfiliaClienteConsultora(userData.PaisID, consultoraAfiliarUser.ConsultoraID, true);
                    }
                }

                try
                {
                    var hasSuccess = !(String.IsNullOrEmpty(consultoraAfiliarUser.Email.Trim()) ||
                                       !consultoraAfiliarUser.EmailActivo);
                    if (hasSuccess)
                    {
                        HttpRequestBase request = this.HttpContext.Request;
                        string cadena = mensajeAfiliacion(userData.PrimerNombre, Util.GetUrlHost(request).ToString());
                        Util.EnviarMail("no-responder@somosbelcorp.com", userData.EMail,
                            "¡Felicitaciones, ya eres una Consultora Online!", cadena, true,
                            "Consultora Online Belcorp");
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

            return RedirectToAction("Index", "ConsultoraOnline",
                new
                {
                    activation = "successful",
                    utm_source = "Transaccional",
                    utm_medium = "email",
                    utm_content = "Confirmacion_email",
                    utm_campaign = "ConsultoraOnline"
                });
        }

        [HttpPost]
        public JsonResult Desafiliar(long ConsultoraID, int OpcionDesafiliacion)
        {
            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
            {
                sc.UpdDesafiliaClienteConsultora(userData.PaisID, ConsultoraID, false, OpcionDesafiliacion);

                var data = new
                {
                    success = true
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public string mensajeConsultora(string consultora, string url)
        {
            string tlfBelcorpResponde =
                _configuracionManagerProvider.GetConfiguracionManager(String.Format(Constantes.ConfiguracionManager.BelcorpRespondeTEL,
                    userData.CodigoISO));
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigCdn.GetUrlFileCdn(carpetaPais, "spacer.gif");
            string mailing03 = ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_03.png");
            string mailing05 = ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_05.png");
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine(
                "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">");
            mensaje.AppendLine(
                "<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td>", ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_01.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", mailing03));
            mensaje.AppendLine(
                "<td colspan=\"3\" style=\"text-align:left; padding-top:50px; padding-bottom:20px; font-size:18px;\">");
            mensaje.AppendLine(String.Format("¡Hola, {0}!<br/><br/>", consultora));
            mensaje.AppendLine(
                "Sólo falta un paso para activarte como <span style=\"font-weight:bold;\">Consultora Online.</span>  ");
            mensaje.AppendLine(
                "Pronto tus clientes podrán encontrarte en el App de Catálogos y en las páginas web de las marcas");
            mensaje.AppendLine("¡No pierdas la oportunidad de conseguir nuevos pedidos y nuevos ");
            mensaje.AppendLine("clientes! Para finalizar la activación haz Click en el botón.");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td colspan=\"3\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", mailing05));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"text-align:center; padding-top:20px;\">");
            mensaje.AppendLine(String.Format("<a href=\"{0}\" target=\"_blank\">", url));
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"236\" height=\"35\" border=\"0\" alt=\"Activar consultora online\"></a></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "3-Mailing-de-confirmacion-de-correo_03.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>", mailing03));
            mensaje.AppendLine("<td colspan=\"3\" style=\"text-align:left; padding-bottom:20px; font-size:15px;\">");
            mensaje.AppendLine("Si tienes alguna duda o necesitas mayor información ingresa a la sección ");
            mensaje.AppendLine(
                "<span style=\"font-weight:bold;\">Consultora Online</span> en somosbelcorp.com o llama a Belcorp Responde ");
            mensaje.AppendLine(String.Format("al {0}.", tlfBelcorpResponde));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td colspan=\"3\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>", mailing05));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_12.png")));
            mensaje.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "Facebook.png")));
            mensaje.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "Youtube.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine(
                "<td colspan=\"7\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
            mensaje.AppendLine(
                "¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
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

        public string mensajeAfiliacion(string consultora, string contextoBase)
        {
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigCdn.GetUrlFileCdn(carpetaPais, "spacer.gif");
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine(
                "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif !important;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">	");
            mensaje.AppendLine(
                "<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"105\" alt=\"\">",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_01.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\" width=\"682\">");
            mensaje.AppendLine(
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" style=\"color:#768ea3; table-layout:fixed; width:682px;\">");
            mensaje.AppendLine("<colgroup>");
            mensaje.AppendLine("<col style=\"width:47px;\">");
            mensaje.AppendLine("<col style=\"width:257px;\">");
            mensaje.AppendLine("<col style=\"width:378px;\">");
            mensaje.AppendLine("</colgroup>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"154\" alt=\"\">",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_02.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine(
                "<td style=\"color:#712788; text-align:left; background-color:#edf1f4; font-size:21px;\">  ");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"257\" height=\"1\" alt=\"\">          ",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_05.png")));
            mensaje.AppendLine("<span style=\"color:#768ea3; font-size:18px;\">");
            mensaje.AppendLine(String.Format("Felicitaciones, {0}", consultora));
            mensaje.AppendLine("</span><br/><br/>");
            mensaje.AppendLine(
                "¡Te has activado<br/> como <span style=\"font-weight:bold;\">Consultora Online!</span>            ");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("<td>");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"378\" height=\"154\" alt=\"\">",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_04.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("</table>");
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"682\" height=\"161\" alt=\"Ahora tu nombre estar&#225; disponible en el App de Cat&#225;logos &#201;sika, L’bel y Cyzone y en las en la p&#225;gina web de nuestras marcas y nuevos clientes podr&#225;n contactarse.\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_11.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"778\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_06.png")));
            mensaje.AppendLine("<td colspan=\"4\"> <!-- INICIO DE BORRADO ");
            mensaje.AppendLine(String.Format(
                "<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=MiPerfil\" target=\"_blank\">", contextoBase));
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"600\" height=\"132\" border=\"0\" alt=\"Actualuza tu perfil\"></a> --> </td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_13.png")));
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"35\" height=\"778\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_08.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\"> <!-- INICIO DE BORRADO ");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"65\" alt=\"\"> --> </td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_09.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format(
                "<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=MisPedidos\" target=\"_blank\"", contextoBase));
            mensaje.AppendLine("onmouseover=\"window.status='mantente conectada';  return true;\"");
            mensaje.AppendLine("onmouseout=\"window.status='';  return true;\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"600\" height=\"132\" border=\"0\" alt=\"\"></a></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_16.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"69\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_11-12.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine("<a href=\"#\" target=\"_blank\"");
            mensaje.AppendLine("onmouseover=\"window.status='Contáctalos al instante';  return true;\"");
            mensaje.AppendLine("onmouseout=\"window.status='';  return true;\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"600\" height=\"142\" border=\"0\" alt=\"\"></a></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_18.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"67\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_13-14.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td rowspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"176\" height=\"84\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_14.png")));
            mensaje.AppendLine("<td colspan=\"2\">");
            mensaje.AppendLine(String.Format(
                "<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=ConsultoraOnline\" target=\"_blank\">",
                contextoBase));
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"221\" height=\"36\" border=\"0\" alt=\"Ir a consultora online\"></a></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_21.png")));
            mensaje.AppendLine("<td rowspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"203\" height=\"84\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_16-17.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"2\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"221\" height=\"48\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_17.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"600\" height=\"87\" alt=\"Ingresa a Consultora Online para ver consejos sobre c&#243;mo aparecer primera en la lista de consultoras.\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "4-Mailing_24.png")));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"6\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_12.png")));
            mensaje.AppendLine("<a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "Facebook.png")));
            mensaje.AppendLine("<a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format(
                "<img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "Youtube.png")));
            mensaje.AppendLine("</td>");
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine(
                "<td colspan=\"6\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
            mensaje.AppendLine(
                "¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>    ");
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

        #region Pedidos de Consultora

        public MisPedidosModel mostrarPagina()
        {
            List<BEMisPedidos> listPedidos = new List<BEMisPedidos>();
            ViewBag.IndiceActualPagina = indiceActualPagina;
            ViewBag.IndiceUltimaPagina = indiceUltimaPagina;
            int inicio = indiceActualPagina * registrosPagina;
            int fin = inicio + registrosPagina;
            for (int i = inicio; i < fin; i++)
            {
                if (i < objMisPedidos.ListaPedidos.Count) listPedidos.Add(objMisPedidos.ListaPedidos[i]);
                else break;
            }

            MisPedidosModel modelPaginado = new MisPedidosModel { ListaPedidos = listPedidos };
            return (modelPaginado);
        }

        public ActionResult MisPedidos(string Pagina)
        {
            ViewBag.ConsultoraID = userData.ConsultoraID;
            ViewBag.NombreConsultora = userData.PrimerNombre;

            var model = new MisPedidosModel();

            if (Pagina != null)
            {
                int pagAeux;
                if (int.TryParse(Pagina, out pagAeux))
                    Pagina = (pagAeux - 1).ToString();

            }

            if (Pagina == null)
            {
                List<BEMisPedidos> olstMisPedidos;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    olstMisPedidos =
                        sv.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID)
                            .ToList();
                }

                if (olstMisPedidos.Any())
                {
                    using (UsuarioServiceClient svc = new UsuarioServiceClient())
                    {
                        foreach (var miPedido in olstMisPedidos)
                        {
                            miPedido.DetallePedido =
                                svc.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, miPedido.PedidoId).ToArray();
                        }
                    }
                }

                model.ListaPedidos = olstMisPedidos;

                objMisPedidos = model;
                SessionManager.SetobjMisPedidos(objMisPedidos);
                indiceUltimaPagina = objMisPedidos.ListaPedidos.Count / registrosPagina;
                if (objMisPedidos.ListaPedidos.Count % registrosPagina == 0) indiceUltimaPagina--;
                TempData["indiceActualPagina"] = indiceActualPagina;
                TempData["indiceUltimaPagina"] = indiceUltimaPagina;
            }
            else
            {
                objMisPedidos = SessionManager.GetobjMisPedidos();
                indiceActualPagina = (int)TempData["indiceActualPagina"];
                indiceUltimaPagina = (int)TempData["indiceUltimaPagina"];

                indiceActualPagina = MisPedidosActualPagina(Pagina, indiceActualPagina, indiceUltimaPagina);

                TempData["indiceUltimaPagina"] = indiceUltimaPagina;
                TempData["indiceActualPagina"] = indiceActualPagina;
            }


            ViewBag.CantidadPedidos = objMisPedidos.ListaPedidos.Count(p => string.IsNullOrEmpty(p.Estado));

            return View(mostrarPagina());
        }


        private int MisPedidosActualPagina(string Pagina, int indiceActualPagina, int indiceUltimaPagina, int sumaPaginaStr = 0)
        {

            if (Pagina.Equals("<<"))
                return 0;

            if (Pagina.Equals("<"))
            {
                if (indiceActualPagina > 0)
                    indiceActualPagina--;

                return indiceActualPagina;
            }

            if (Pagina.Equals(">"))
            {
                if (indiceActualPagina < indiceUltimaPagina)
                    indiceActualPagina++;

                return indiceActualPagina;
            }

            if (Pagina.Equals(">>"))
                indiceActualPagina = indiceUltimaPagina;
            else
            {
                int pagAux;
                if (int.TryParse(Pagina, out pagAux))
                {
                    indiceActualPagina = pagAux + sumaPaginaStr;
                }
            }

            return indiceActualPagina;
        }

        private List<BEPedidoWebDetalle> AgregarDetallePedido(PedidoSb2Model model)
        {
            try
            {
                BEPedidoDetalle pedidoDetalle = new BEPedidoDetalle();
                pedidoDetalle.Producto = new ServicePedido.BEProducto();

                pedidoDetalle.Estrategia = new ServicePedido.BEEstrategia();
                pedidoDetalle.Estrategia.Cantidad = Convert.ToInt32(model.Cantidad);
                pedidoDetalle.Estrategia.LimiteVenta = 99;
                pedidoDetalle.Estrategia.DescripcionCUV2 = Util.Trim(model.DescripcionProd);
                pedidoDetalle.Estrategia.FlagNueva = 0;
                pedidoDetalle.Estrategia.Precio2 = model.PrecioUnidad;
                pedidoDetalle.Estrategia.TipoEstrategiaID = 0;
                pedidoDetalle.Estrategia.IndicadorMontoMinimo = string.IsNullOrEmpty(model.IndicadorMontoMinimo) ? 0 : Convert.ToInt32(model.IndicadorMontoMinimo);
                pedidoDetalle.Estrategia.CUV2 = model.CUV;
                pedidoDetalle.Estrategia.MarcaID = model.MarcaID;

                pedidoDetalle.Producto.TipoOfertaSisID = model.TipoOfertaSisID;
                pedidoDetalle.Producto.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
                pedidoDetalle.Producto.CUV = "";
                pedidoDetalle.Producto.IndicadorMontoMinimo = string.IsNullOrEmpty(model.IndicadorMontoMinimo) ? 0 : Convert.ToInt32(model.IndicadorMontoMinimo);
                pedidoDetalle.Producto.FlagNueva = "0";
                pedidoDetalle.Usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
                pedidoDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                pedidoDetalle.PaisID = userData.PaisID;
                pedidoDetalle.IPUsuario = GetIPCliente();
                pedidoDetalle.OrigenPedidoWeb = ProcesarOrigenPedido(model.OrigenPedidoWeb);
                pedidoDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);
                pedidoDetalle.Identifier = SessionManager.GetTokenPedidoAutentico() != null ? SessionManager.GetTokenPedidoAutentico().ToString() : string.Empty;
                pedidoDetalle.EsSugerido = model.EsSugerido;
                pedidoDetalle.EsKitNueva = model.EsKitNueva;
                pedidoDetalle.OfertaWeb = model.OfertaWeb;

                var pedidoDetalleResult = _pedidoWebProvider.InsertPedidoDetalle(pedidoDetalle);

                if (pedidoDetalleResult.CodigoRespuesta.Equals(Constantes.PedidoValidacion.Code.SUCCESS))
                {
                    SessionManager.SetPedidoWeb(null);
                    SessionManager.SetDetallesPedido(null);
                    SessionManager.SetDetallesPedidoSetAgrupado(null);

                    return ObtenerPedidoWebDetalle();
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new List<BEPedidoWebDetalle>();
            }
        }

        [HttpPost]
        public JsonResult CargarMisPedidos(string sidx, string sord, int page, int rows)
        {
            try
            {
                List<BEMisPedidos> olstMisPedidos;
                MisPedidosModel model = new MisPedidosModel();

                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    olstMisPedidos =
                        svc.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID)
                            .ToList();
                }

                if (olstMisPedidos.Count > 0)
                {
                    olstMisPedidos.RemoveAll(x => x.Estado.Trim().Length > 0);

                    if (olstMisPedidos.Count > 0)
                    {
                        olstMisPedidos.ToList().ForEach(y =>
                            y.FormartoFechaSolicitud = y.FechaSolicitud.ToString("dd") + " de " +
                                                       y.FechaSolicitud.ToString("MMMM", new CultureInfo("es-ES")));
                        olstMisPedidos.ToList().ForEach(y =>
                            y.FormatoPrecioTotal = Util.DecimalToStringFormat(y.PrecioTotal, userData.CodigoISO));

                        model.ListaPedidos = olstMisPedidos;

                        objMisPedidos = model;
                        SessionManager.SetobjMisPedidos(objMisPedidos);

                        var lstClientesExistentes = olstMisPedidos.Where(x => x.FlagConsultora).ToList();

                        if (lstClientesExistentes.Count == olstMisPedidos.Count)
                        {
                            model.FechaPedidoReciente = "24:00:00";
                        }
                        else
                        {
                            var pedidoReciente = olstMisPedidos.Where(x => !x.FlagConsultora)
                                .OrderBy(x => x.FechaSolicitud).First();

                            DateTime starDate = DateTime.Now;
                            DateTime endDate = pedidoReciente.FechaSolicitud.AddDays(1);

                            TimeSpan ts = endDate - starDate;
                            model.FechaPedidoReciente = ts.Hours.ToString().PadLeft(2, '0') + ":" +
                                                        ts.Minutes.ToString().PadLeft(2, '0') + ":" +
                                                        ts.Seconds.ToString().PadLeft(2, '0');

                        }

                        BEGrid grid = new BEGrid(sidx, sord, page, rows);
                        BEPager pag = Util.PaginadorGenerico(grid, model.ListaPedidos);

                        model.ListaPedidos = model.ListaPedidos.Skip((grid.CurrentPage - 1) * grid.PageSize)
                            .Take(grid.PageSize).ToList();

                        model.Registros = grid.PageSize.ToString();
                        model.RegistrosTotal = pag.RecordCount.ToString();
                        model.Pagina = pag.CurrentPage.ToString();
                        model.PaginaDe = pag.PageCount.ToString();
                    }
                    else
                    {
                        model.RegistrosTotal = "0";
                        model.Pagina = "0";
                        model.PaginaDe = "0";
                    }
                }
                else
                {
                    model.RegistrosTotal = "0";
                    model.Pagina = "0";
                    model.PaginaDe = "0";
                }

                model.TipoPaginador = Constantes.ClasificadorPedido.PedidoDetallePendiente;

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = model
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        [HttpPost]
        public JsonResult CargarMisPedidosDetalle(string sidx, string sord, int page, int rows, int pedidoId)
        {
            try
            {
                List<BEMisPedidosDetalle> olstMisPedidosDet;
                MisPedidosDetalleModel model = new MisPedidosDetalleModel();

                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    olstMisPedidosDet = svc.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, pedidoId).ToList();
                }

                if (olstMisPedidosDet.Count > 0)
                {
                    MisPedidosModel consultoraOnlineMisPedidos = SessionManager.GetobjMisPedidos();
                    long pedidoIdAux = Convert.ToInt64(pedidoId);
                    var pedido =
                        consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == pedidoIdAux) ??
                        new BEMisPedidos();

                    SessionManager.SetobjMisPedidosDetalle(olstMisPedidosDet);

                    olstMisPedidosDet = CargarMisPedidosDetalleDatos(pedido.MarcaID, olstMisPedidosDet);

                    model.ListaDetalle = olstMisPedidosDet;

                    BEGrid grid = new BEGrid(sidx, sord, page, rows);
                    BEPager pag = Util.PaginadorGenerico(grid, model.ListaDetalle);

                    model.Registros = grid.PageSize.ToString();
                    model.RegistrosTotal = pag.RecordCount.ToString();
                    model.Pagina = pag.CurrentPage.ToString();
                    model.PaginaDe = pag.PageCount.ToString();
                }
                else
                {
                    model.RegistrosTotal = "0";
                    model.Pagina = "0";
                    model.PaginaDe = "0";
                }
                model.TipoPaginador = Constantes.ClasificadorPedido.PedidoDetallePoputPendiente;

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = model
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        public ActionResult ObtenerPagina(string Pagina)
        {
            objMisPedidos = SessionManager.GetobjMisPedidos();
            ViewBag.CantidadPedidos = objMisPedidos.ListaPedidos.Count(p => string.IsNullOrEmpty(p.Estado));
            indiceActualPagina = (int)TempData["indiceActualPagina"];
            indiceUltimaPagina = (int)TempData["indiceUltimaPagina"];

            indiceActualPagina = MisPedidosActualPagina(Pagina, indiceActualPagina, indiceUltimaPagina, -1);

            TempData["indiceUltimaPagina"] = indiceUltimaPagina;
            TempData["indiceActualPagina"] = indiceActualPagina;


            return PartialView("_ListaPedidos", mostrarPagina());
        }

        [HttpPost]
        public JsonResult GetExisteClienteConsultora(ServiceCliente.BECliente model)
        {
            try
            {
                model.ConsultoraID = userData.ConsultoraID;
                int id;
                using (ServiceCliente.ClienteServiceClient svc = new ServiceCliente.ClienteServiceClient())
                {
                    id = svc.GetExisteClienteConsultora(userData.PaisID, model);
                }

                return Json(new
                {
                    success = true,
                    codigo = id
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult AceptarPedido(ConsultoraOnlinePedidoModel pedido)
        {
            string mensajeR;
            var noPasa = ReservadoEnHorarioRestringido(out mensajeR);
            if (noPasa)
            {
                return Json(new
                {
                    success = false,
                    message = mensajeR,
                    code = 2
                }, JsonRequestBehavior.AllowGet);
            }

            MisPedidosModel consultoraOnlineMisPedidos = SessionManager.GetobjMisPedidos();
            var pedidoAux =
                consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == pedido.PedidoId) ??
                new BEMisPedidos();

            List<BEMisPedidosDetalle> olstMisPedidosDet = SessionManager.GetobjMisPedidosDetalle();
            pedidoAux.DetallePedido = olstMisPedidosDet.Where(x => x.PedidoId == pedidoAux.PedidoId).ToArray();

            int tipo;
            string marcaPedido;

            // 0=App Catalogos, >0=Portal Marca
            if (pedidoAux.MarcaID == 0)
            {
                tipo = 1;
                marcaPedido = pedidoAux.MedioContacto;
            }
            else
            {
                tipo = 2;
                marcaPedido = pedidoAux.Marca;
            }

            #region AceptarPedido

            int paisId = userData.PaisID;
            string mensajeaCliente =
                string.Format(
                    "Gracias por haber escogido a {0} como tu Consultora. Pronto se pondrá en contacto contigo para coordinar la hora y lugar de entrega.",
                    userData.NombreConsultora);

            try
            {
                using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                {
                    var beSolicitudCliente = new ServiceSAC.BESolicitudCliente
                    {
                        SolicitudClienteID = pedidoAux.PedidoId,
                        CodigoConsultora = userData.ConsultoraID.ToString(),
                        MensajeaCliente = mensajeaCliente,
                        UsuarioModificacion = userData.CodigoUsuario,
                        Estado = "A"
                    };

                    svc.UpdSolicitudCliente(paisId, beSolicitudCliente);
                }

                List<BEMisPedidos> refresh = new List<BEMisPedidos>();
                foreach (BEMisPedidos item in consultoraOnlineMisPedidos.ListaPedidos)
                {
                    if (item.PedidoId == pedidoAux.PedidoId)
                    {
                        item.Estado = "A";
                        item.FechaModificacion = DateTime.Now;
                    }

                    refresh.Add(item);
                }

                MisPedidosModel refreshMisPedidos = new MisPedidosModel { ListaPedidos = refresh };
                SessionManager.SetobjMisPedidos(refreshMisPedidos);

                string clienteId;

                if (pedido.ClienteId == 0)
                {
                    using (ServiceCliente.ClienteServiceClient svc = new ServiceCliente.ClienteServiceClient())
                    {
                        var a = new ServiceCliente.BECliente
                        {
                            ConsultoraID = userData.ConsultoraID,
                            Nombre = pedidoAux.Cliente
                        };
                        int xclienteId = svc.GetExisteClienteConsultora(userData.PaisID, a);

                        if (xclienteId == 0)
                        {
                            var beCliente = new ServiceCliente.BECliente
                            {
                                ConsultoraID = userData.ConsultoraID,
                                eMail = pedidoAux.Email,
                                Nombre = pedidoAux.Cliente,
                                PaisID = userData.PaisID,
                                Activo = true
                            };
                            clienteId = svc.Insert(beCliente).ToString();
                        }
                        else
                        {
                            clienteId = xclienteId.ToString();
                        }
                    }
                }
                else
                {
                    clienteId = pedido.ClienteId.ToString();
                }

                if (tipo == 1) // solo para App Catalogos
                {
                    List<ServiceODS.BEProducto> olstMisProductos = SessionManager.GetobjMisPedidosDetalleVal();


                    foreach (var item in pedido.ListaDetalleModel)
                    {
                        if (item.OpcionAcepta == "ingrped")
                        {
                            BEMisPedidosDetalle pedidoDetalle =
                                olstMisPedidosDet.FirstOrDefault(x => x.PedidoDetalleId == item.PedidoDetalleId);

                            if (pedidoDetalle != null)
                            {
                                ServiceODS.BEProducto productoVal =
                                    olstMisProductos.FirstOrDefault(x => x.CUV == pedidoDetalle.CUV);

                                if (productoVal != null)
                                {
                                    var model = new PedidoSb2Model
                                    {
                                        TipoOfertaSisID = productoVal.TipoOfertaSisID,
                                        ConfiguracionOfertaID = productoVal.ConfiguracionOfertaID,
                                        ClienteID = clienteId,
                                        OfertaWeb = false,
                                        IndicadorMontoMinimo = productoVal.IndicadorMontoMinimo.ToString(),
                                        EsSugerido = false,
                                        EsKitNueva = false,
                                        MarcaID = pedidoDetalle.MarcaID,
                                        Cantidad = pedidoDetalle.Cantidad.ToString(),
                                        PrecioUnidad = Convert.ToDecimal(pedidoDetalle.PrecioUnitario),
                                        CUV = pedidoDetalle.CUV,
                                        DescripcionProd = pedidoDetalle.Producto,
                                        ClienteDescripcion = pedidoAux.Cliente,
                                        OrigenPedidoWeb = GetOrigenPedidoWeb(pedidoAux.FlagMedio, pedidoDetalle.MarcaID, pedido.Dispositivo, 1)
                                    };

                                    var olstPedidoWebDetalle = AgregarDetallePedido(model);

                                    if (olstPedidoWebDetalle != null)
                                    {
                                        using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                                        {
                                            var bePedidoWebDetalle = olstPedidoWebDetalle.FirstOrDefault(x =>
                                                x.CUV == pedidoDetalle.CUV && x.MarcaID == pedidoDetalle.MarcaID &&
                                                x.ClienteID == Convert.ToInt16(clienteId));

                                            if (bePedidoWebDetalle != null)
                                            {
                                                var beSolicitudDetalle = new ServiceSAC.BESolicitudClienteDetalle
                                                {
                                                    SolicitudClienteDetalleID = item.PedidoDetalleId,
                                                    TipoAtencion = 1,
                                                    PedidoWebID = bePedidoWebDetalle.PedidoID,
                                                    PedidoWebDetalleID = bePedidoWebDetalle.PedidoDetalleID
                                                };

                                                svc.UpdSolicitudClienteDetalle(userData.PaisID, beSolicitudDetalle);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                            {
                                var beSolicitudDetalle = new ServiceSAC.BESolicitudClienteDetalle
                                {
                                    SolicitudClienteDetalleID = item.PedidoDetalleId,
                                    TipoAtencion = (item.OpcionAcepta == "ingrten") ? 2 : 0,
                                    PedidoWebID = 0,
                                    PedidoWebDetalleID = 0
                                };

                                svc.UpdSolicitudClienteDetalle(userData.PaisID, beSolicitudDetalle);
                            }
                        }

                    }
                }

                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);
                string emailDe = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ConsultoraOnlineEmailDe);

                if (pedidoAux.FlagMedio == "01")
                {
                    double totalPedido = 0;

                    String titulocliente = "Tu pedido ha sido CONFIRMADO por " + userData.PrimerNombre + " " +
                                           userData.PrimerApellido + " - App de Catálogos Ésika, L'Bel y Cyzone";
                    StringBuilder mensajecliente = new StringBuilder();
                    mensajecliente.Append(
                        "<table width='100%' border='0' bgcolor='#ffffff' cellspacing='0' cellpadding='0' border-spacing='0' style='margin: 0; border: 0; border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append(
                        "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td valign='middle' style='width: 15%'>");
                    mensajecliente.Append(
                        "<img src='https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/mailing/cabecera_email.jpg' border='0' height='70' width='70' alt='Catálogos Esika, LBel y Cyzone'>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("<td valign='middle'>");
                    mensajecliente.Append(
                        "<span style='display: block; color: #7f7f7f; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>");
                    mensajecliente.Append("Catálogos Esika, LBel, Cyzone");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td>");
                    mensajecliente.Append(
                        "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append(
                        "<td align='center' valign='middle' style='border-top-width: 1px; border-top-color: #DDDDDD; border-top-style: solid; height: 10px;'></td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<br>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append(
                        "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody>");

                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append(
                        "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' style='border-collapse: collapse!important;' align='center'>");

                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td colspan='2'>");
                    mensajecliente.Append(
                        "<span style='display: block; color: #7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Hola " +
                        pedidoAux.Cliente.Split(' ').First() + "</span>");
                    mensajecliente.Append(
                        "<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Tu Consultora " +
                        userData.PrimerNombre + " " + userData.PrimerApellido + " ha confirmado tu pedido.</p>");
                    mensajecliente.Append(
                        "<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>En seguida se pondrá en contacto contigo para coordinar la hora y lugar de entrega.</p><br>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");

                    mensajecliente.Append("<tr>");
                    mensajecliente.Append(
                        "<td><span style='display: block; color: #7f7f7f; font-size: 17px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>RESUMEN DE TU PEDIDO</span></td>");
                    mensajecliente.Append("</tr>");

                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td style='width: 65%;' align='top' valign='middle'>");
                    mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0.6em;'>");
                    mensajecliente.Append(
                        "<span style='color: #7f7f7f; font-size: 15px; text-align: left; font-family: Arial, Helvetica, sans-serif;'>CLIENTE:");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("<br>");
                    mensajecliente.Append(
                        "<span style='color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif;'> " +
                        pedidoAux.Cliente + "<br>");
                    mensajecliente.Append(pedidoAux.Email + "<br>");
                    mensajecliente.Append(pedidoAux.Telefono);
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("<td style='width: 35%;' align='top' valign='middle'>");
                    mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0 0.6em;'>");
                    mensajecliente.Append(
                        "<span style='color: #7f7f7f; font-size: 11px; text-align: left; font-family: Arial, Helvetica, sans-serif; line-height: 1em'>FECHA: " +
                        String.Format("{0:dd/MM/yyyy}", pedidoAux.FechaSolicitud) + "<br>");
                    mensajecliente.Append("CAMPAÑA: " + pedidoAux.Campania + "<br>");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("</tbody></table>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    mensajecliente.Append("<tr>");
                    mensajecliente.Append("<td align='center' valign='middle'>");
                    mensajecliente.Append(
                        " <table width='600' border='0' cellspacing='0' cellpadding='10' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                    mensajecliente.Append("<tbody><tr>");
                    mensajecliente.Append("<td valign='middle' colspan='3'>");
                    mensajecliente.Append(
                        "<span style='display: block; color:#7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; margin: 0.6em 0 0em;'>");
                    mensajecliente.Append("Listado de Productos</span>");
                    mensajecliente.Append("</td>");
                    mensajecliente.Append("</tr>");
                    int cntfila = 0;

                    foreach (var item in pedidoAux.DetallePedido)
                    {
                        totalPedido += item.PrecioTotal;
                        cntfila = cntfila + 1;

                        if (cntfila % 2 == 0)
                        {
                            mensajecliente.Append("<tr>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                item.CUV + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                item.Marca + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                item.Producto + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " +
                                userData.Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " +
                                item.Cantidad + "</span></td>");
                            mensajecliente.Append("</tr>");
                        }
                        else
                        {
                            mensajecliente.Append("<tr style = 'background: #cccccc;'>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                item.CUV + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                item.Marca + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                item.Producto + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " +
                                userData.Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                            mensajecliente.Append(
                                "<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " +
                                item.Cantidad + "</span></td>");
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
                    mensajecliente.Append(
                        "<span style='display: inline-block; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; color: #7f7f7f; display: block; margin: 0.6em 0 0 0.6em;'>PRECIO TOTAL: " +
                        userData.Simbolo + " " + totalPedido.ToString("N2") + "");
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
                        //if (pedido.Accion == 1)
                        //{
                        //    Util.EnviarMail3(emailDe, pedidoAux.Email, titulocliente, mensajecliente.ToString(), true,
                        //        pedidoAux.Email);
                        //}
                        //else
                        //{
                        //    Util.EnviarMail3Mobile(emailDe, pedidoAux.Email, titulocliente, mensajecliente.ToString(),
                        //        true, pedidoAux.Email);
                        //}
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    }
                }
                else
                {
                    String titulo = "(" + userData.CodigoISO + ") Consultora que atenderá tu pedido de " +
                                    HttpUtility.HtmlDecode(marcaPedido);
                    StringBuilder mensaje = new StringBuilder();
                    mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(pedidoAux.Cliente));
                    mensaje.AppendFormat("{0}</p><br/>", mensajeaCliente);
                    mensaje.Append("<br/>Saludos,<br/><br />");
                    mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                    mensaje.AppendFormat(
                        "<td><p style='text-align: center;'><strong>{0}<br/>{1}<br/>Consultora</strong></p></td></tr></table>",
                        userData.NombreConsultora, userData.EMail);

                    try
                    {
                        //if (pedido.Accion == 1)
                        //{
                        //    Util.EnviarMail3(emailDe, pedidoAux.Email, titulo, mensaje.ToString(), true, string.Empty);
                        //}
                        //else
                        //{
                        //    Util.EnviarMail3Mobile(emailDe, pedidoAux.Email, titulo, mensaje.ToString(), true,
                        //        string.Empty);
                        //}
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    DataBarra = GetDataBarra(),
                    code = 1
                }, JsonRequestBehavior.AllowGet);

            }
            catch (FaultException e)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(e, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = e.Message,
                    code = 1
                }, JsonRequestBehavior.AllowGet);
            }

            #endregion
        }

        public JsonResult RechazarPedido(long SolicitudId, int NumIteracion, string CodigoUbigeo, string Campania,
            int MarcaId, int OpcionRechazo, string RazonMotivoRechazo, string typeAction = null)
        {
            int paisId = userData.PaisID;
            DateTime fechaActual = DateTime.Now;

            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                MisPedidosModel consultoraOnlineMisPedidos = SessionManager.GetobjMisPedidos();

                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatos = sv.GetTablaLogicaDatos(paisId, 56);
                var numIteracionMaximo =
                    Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5601).Codigo);

                if (NumIteracion == numIteracionMaximo)
                {
                    sv.RechazarSolicitudCliente(paisId, SolicitudId, true, OpcionRechazo, RazonMotivoRechazo);

                    BEMisPedidos pedido =
                        consultoraOnlineMisPedidos.ListaPedidos.FirstOrDefault(p => p.PedidoId == SolicitudId) ??
                        new BEMisPedidos();

                    if (pedido.FlagMedio == "01")
                    {
                        double totalPedido = 0;

                        String titulocliente = "Tu pedido ha sido CONFIRMADO por " + userData.PrimerNombre + " " +
                                               userData.PrimerApellido + " - App de Catálogos Ésika, L'Bel y Cyzone";
                        StringBuilder mensajecliente = new StringBuilder();
                        mensajecliente.Append(
                            "<table width='100%' border='0' bgcolor='#ffffff' cellspacing='0' cellpadding='0' border-spacing='0' style='margin: 0; border: 0; border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td align='center' valign='middle'>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td valign='middle' style='width: 15%'>");
                        mensajecliente.Append(
                            "<img src='https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/mailing/cabecera_email.jpg' border='0' height='70' width='70' alt='Catálogos Esika, LBel y Cyzone'>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("<td valign='middle'>");
                        mensajecliente.Append(
                            "<span style='display: block; color: #7f7f7f; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>");
                        mensajecliente.Append("Catálogos Esika, LBel, Cyzone");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("</tbody></table>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append(
                            "<td align='center' valign='middle' style='border-top-width: 1px; border-top-color: #DDDDDD; border-top-style: solid; height: 10px;'></td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("</tbody></table>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("<br>");
                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td align='center' valign='middle'>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody>");

                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td align='center' valign='middle'>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' style='border-collapse: collapse!important;' align='center'>");

                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td colspan='2'>");
                        mensajecliente.Append(
                            "<span style='display: block; color: #7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Hola " +
                            pedido.Cliente.Split(' ').First() + "</span>");
                        mensajecliente.Append(
                            "<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Tu Consultora " +
                            userData.PrimerNombre + " " + userData.PrimerApellido + " ha confirmado tu pedido.</p>");
                        mensajecliente.Append(
                            "<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>En seguida se pondrá en contacto contigo para coordinar la hora y lugar de entrega.</p><br>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");

                        mensajecliente.Append("<tr>");
                        mensajecliente.Append(
                            "<td><span style='display: block; color: #7f7f7f; font-size: 17px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>RESUMEN DE TU PEDIDO</span></td>");
                        mensajecliente.Append("</tr>");

                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td style='width: 65%;' align='top' valign='middle'>");
                        mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0.6em;'>");
                        mensajecliente.Append(
                            "<span style='color: #7f7f7f; font-size: 15px; text-align: left; font-family: Arial, Helvetica, sans-serif;'>CLIENTE:");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("<br>");
                        mensajecliente.Append(
                            "<span style='color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif;'> " +
                            pedido.Cliente + "<br>");
                        mensajecliente.Append(pedido.Email + "<br>");
                        mensajecliente.Append(pedido.Telefono);
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("<td style='width: 35%;' align='top' valign='middle'>");
                        mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0 0.6em;'>");
                        mensajecliente.Append(
                            "<span style='color: #7f7f7f; font-size: 11px; text-align: left; font-family: Arial, Helvetica, sans-serif; line-height: 1em'>FECHA: " +
                            String.Format("{0:dd/MM/yyyy}", pedido.FechaSolicitud) + "<br>");
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
                        mensajecliente.Append(
                            " <table width='600' border='0' cellspacing='0' cellpadding='10' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td valign='middle' colspan='3'>");
                        mensajecliente.Append(
                            "<span style='display: block; color:#7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; margin: 0.6em 0 0em;'>");
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
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.CUV + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Marca + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Producto + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " +
                                    userData.Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " +
                                    item.Cantidad + "</span></td>");
                                mensajecliente.Append("</tr>");
                            }
                            else
                            {
                                mensajecliente.Append("<tr style = 'background: #cccccc;'>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.CUV + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Marca + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Producto + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " +
                                    userData.Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " +
                                    item.Cantidad + "</span></td>");
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
                        mensajecliente.Append(
                            "<span style='display: inline-block; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; color: #7f7f7f; display: block; margin: 0.6em 0 0 0.6em;'>PRECIO TOTAL: " +
                            userData.Simbolo + " " + totalPedido.ToString("N2") + "");
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
                            string emailDe =
                                _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ConsultoraOnlineEmailDe);
                            if (typeAction == "1")
                            {
                                Util.EnviarMail3(emailDe, pedido.Email, titulocliente, mensajecliente.ToString(), true,
                                    pedido.Email);
                            }
                            else
                            {
                                Util.EnviarMail3Mobile(emailDe, pedido.Email, titulocliente, mensajecliente.ToString(),
                                    true, pedido.Email);
                            }
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                                userData.CodigoISO);
                        }
                    }
                }
                else
                {
                    try
                    {
                        ServiceSAC.BESolicitudNuevaConsultora nuevaConsultora = sv.ReasignarSolicitudCliente(paisId,
                            SolicitudId, CodigoUbigeo, Campania, MarcaId, OpcionRechazo, RazonMotivoRechazo);

                        if (nuevaConsultora != null)
                        {
                            ServiceSAC.BESolicitudCliente beSolicitudCliente =
                                sv.GetSolicitudCliente(paisId, SolicitudId);
                            fechaActual = beSolicitudCliente.FechaModificacion;
                            HttpRequestBase request = this.HttpContext.Request;

                            try
                            {
                                string mensaje = mensajeRechazoPedido(nuevaConsultora.Nombre,
                                    Util.GetUrlHost(request).ToString(), beSolicitudCliente);
                                Util.EnviarMail("no-responder@somosbelcorp.com", nuevaConsultora.Email,
                                    "Un nuevo cliente te eligió como Consultora Online", mensaje, true,
                                    "Consultora Online Belcorp");
                            }
                            catch (Exception ex)
                            {
                                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                                    userData.CodigoISO);
                            }
                        }
                    }
                    catch (FaultException ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora,
                            userData.CodigoISO);
                        var dataError = new
                        {
                            success = false,
                            message = "Ocurrio un Error al momento de rechazar el Pedido"
                        };

                        return Json(dataError, JsonRequestBehavior.AllowGet);
                    }
                }

                List<BEMisPedidos> refresh = new List<BEMisPedidos>();
                foreach (BEMisPedidos item in consultoraOnlineMisPedidos.ListaPedidos)
                {
                    if (item.PedidoId == SolicitudId)
                    {
                        item.Estado = "R";
                        item.FechaModificacion = DateTime.Now;
                    }

                    refresh.Add(item);
                }

                MisPedidosModel refreshMisPedidos = new MisPedidosModel { ListaPedidos = refresh };
                SessionManager.SetobjMisPedidos(refreshMisPedidos);
            }

            var data = new
            {
                success = true,
                message = String.Format("El día {0} a las {1}", fechaActual.ToString("dd/MM"),
                    fechaActual.ToString("hh:mm tt"))
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CancelarPedido(long SolicitudId, int OpcionCancelado, string RazonMotivoCancelado)
        {
            int paisId = userData.PaisID;
            DateTime fechaActual;
            try
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    MisPedidosModel consultoraOnlineMisPedidos = SessionManager.GetobjMisPedidos();

                    sc.CancelarSolicitudCliente(paisId, SolicitudId, OpcionCancelado, RazonMotivoCancelado);
                    ServiceSAC.BESolicitudCliente beSolicitudCliente = sc.GetSolicitudCliente(paisId, SolicitudId);
                    fechaActual = beSolicitudCliente.FechaModificacion;

                    List<BEMisPedidos> refresh = new List<BEMisPedidos>();
                    foreach (BEMisPedidos item in consultoraOnlineMisPedidos.ListaPedidos)
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
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                var dataError = new
                {
                    success = false,
                    message = "Ocurrio un error al momento de Cancelar la solicitud"
                };
                return Json(dataError, JsonRequestBehavior.AllowGet);
            }

            var data = new
            {
                success = true,
                message = String.Format("El día {0} a las {1}", fechaActual.ToString("dd/MM"),
                    fechaActual.ToString("hh:mm tt"))
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public string mensajeRechazoPedido(string consultora, string contextoBase,
            ServiceSAC.BESolicitudCliente solicitudCliente)
        {
            DateTime fechaMaxima = solicitudCliente.FechaModificacion.AddDays(1);
            var culture = new CultureInfo("es-PE");
            var dia = culture.DateTimeFormat.GetDayName(fechaMaxima.DayOfWeek);
            var mes = culture.DateTimeFormat.GetMonthName(fechaMaxima.Month);
            dia = ToUpperFirstLetter(dia);
            mes = ToUpperFirstLetter(mes);
            string fechaFormato = String.Format("{0} {1} de {2} - {3}", dia, fechaMaxima.ToString("dd"), mes,
                fechaMaxima.ToString("hh:mm tt"));
            string carpetaPais = "Correo/CCC";
            string spacerGif = ConfigCdn.GetUrlFileCdn(carpetaPais, "spacer.gif");
            StringBuilder mensaje = new StringBuilder();
            mensaje.AppendLine(
                "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" align=\"center\" bgcolor=\"#f6f7f9\" style=\"font-family:Arial, sans-serif;\">");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td style=\"text-align:center;\">");
            mensaje.AppendLine(
                "<table id=\"Table_01\" width=\"682\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"color:#768ea3;\">");
            mensaje.AppendLine(String.Format(
                "	<tr><td colspan=\"7\"><img src=\"{0}\" width=\"682\" height=\"117\" alt=\"\"></td><tr>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_01.png")));
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine(String.Format("		<td><img src=\"{0}\" width=\"54\" height=\"148\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_03.png")));
            mensaje.AppendLine(
                "		<td colspan=\"3\" style=\"text-align:left; padding-top:50px; padding-bottom:20px; font-size:18px;\">");
            mensaje.AppendLine(String.Format("        	Hola, {0}<br/><br/>", consultora));
            mensaje.AppendLine("            ¡Un nuevo cliente te ha elegido como su Consultora para");
            mensaje.AppendLine("			hacerte un pedido!<br/><br/>");
            mensaje.AppendLine("            Cliente:<br/>");
            mensaje.AppendLine(String.Format("            <span style=\"font-weight:bold;\">{0}</span>  <br/><br/>",
                solicitudCliente.NombreCompleto));
            mensaje.AppendLine("            Fecha límite para aceptar o rechazar el pedido:<br/>");
            mensaje.AppendLine(String.Format("            <span style=\"font-weight:bold;\">{0}</span><br/><br/>",
                fechaFormato));
            mensaje.AppendLine("            Atiende su pedido y conviértete en su Consultora, ¡crear");
            mensaje.AppendLine("			una excelente relación depende de ti!");
            mensaje.AppendLine("        </td>");
            mensaje.AppendLine(String.Format(
                "		<td colspan=\"3\"><img src=\"{0}\" width=\"71\" height=\"148\" alt=\"\"></td>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_05.png")));
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine(
                "		<td colspan=\"7\" style=\"text-align:center; padding-top:30px; padding-bottom:50px\">");

            mensaje.AppendLine(String.Format(
                "			<a href=\"{0}Pedido/Index?lanzarTabConsultoraOnline=true\" target=\"_blank\"><img src=\"{1}\" width=\"201\" height=\"38\" border=\"0\" alt=\"Ver pedido\"></a>",
                contextoBase, ConfigCdn.GetUrlFileCdn(carpetaPais, "7-Mailing_03.png")));
            mensaje.AppendLine("		</td>");
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine("		<td colspan=\"7\" style=\"background-color:#acbbc9;\">");
            mensaje.AppendLine(String.Format(
                "        <img src=\"{0}\" width=\"611\" height=\"30\" alt=\"\" align=\"left\">",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "1-Mailing_12.png")));
            mensaje.AppendLine("        <a href=\"http://www.facebook.com/SomosBelcorpOficial\" target=\"_blank\">");
            mensaje.AppendLine(String.Format(
                "            <img src=\"{0}\" width=\"26\" height=\"30\" border=\"0\" alt=\"Facebook\" align=\"left\"></a>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "Facebook.png")));
            mensaje.AppendLine("        <a href=\"https://www.youtube.com/user/somosbelcorp\" target=\"_blank\">");
            mensaje.AppendLine(String.Format(
                "            <img src=\"{0}\" width=\"27\" height=\"30\" border=\"0\" alt=\"Youtube\" align=\"left\"></a>",
                ConfigCdn.GetUrlFileCdn(carpetaPais, "Youtube.png")));
            mensaje.AppendLine("        </td>");
            mensaje.AppendLine("	</tr>");
            mensaje.AppendLine("	<tr>");
            mensaje.AppendLine(
                "        <td colspan=\"7\" style=\"font-size:11px; padding-top:15px; padding-bottom:15px; text-align:center;\">");
            mensaje.AppendLine(
                "                ¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
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

        private string ToUpperFirstLetter(string source)
        {
            if (string.IsNullOrEmpty(source))
                return string.Empty;
            char[] letters = source.ToCharArray();
            letters[0] = char.ToUpper(letters[0]);
            return new string(letters);
        }

        #endregion

        public ClienteContactaConsultoraModel DatoUsuario()
        {
            var consultoraAfiliar = new ClienteContactaConsultoraModel { NombreConsultora = userData.PrimerNombre };

            ServiceSAC.BEAfiliaClienteConsultora beAfiliaCliente;

            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
            {
                beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(userData.PaisID, userData.CodigoConsultora);
            }

            consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;
            consultoraAfiliar.EsPrimeraVez = beAfiliaCliente.EsAfiliado < 0;
            consultoraAfiliar.ConsultoraID = beAfiliaCliente.ConsultoraID;
            consultoraAfiliar.EmailActivo = beAfiliaCliente.EmailActivo;
            consultoraAfiliar.NombreCompleto = beAfiliaCliente.NombreCompleto;
            consultoraAfiliar.Email = beAfiliaCliente.Email;
            consultoraAfiliar.Celular = beAfiliaCliente.Celular;
            consultoraAfiliar.Telefono = beAfiliaCliente.Telefono;

            return consultoraAfiliar;
        }

        public ActionResult AtenderCorreo(string tipo, string data)
        {
            bool esMovil = Request.Browser.IsMobileDevice;

            switch (tipo.ToUpper())
            {
                case "AFILIAR":
                    if (esMovil)
                        return RedirectToAction("Afiliar", "ConsultoraOnline", new { area = "Mobile", data = data });
                    else
                        return RedirectToAction("Afiliar", "ConsultoraOnline", new { data = data });
                case "MIPERFIL":
                    if (esMovil)
                        return RedirectToAction("MiPerfil", "ConsultoraOnline",
                            new
                            {
                                area = "Mobile",
                                utm_source = "Transaccional",
                                utm_medium = "email",
                                utm_content = "Bienvenida_verPerfil",
                                utm_campaign = "ConsultoraOnline"
                            });
                    else
                        return RedirectToAction("MiPerfil", "ConsultoraOnline",
                            new
                            {
                                utm_source = "Transaccional",
                                utm_medium = "email",
                                utm_content = "Bienvenida_verPerfil",
                                utm_campaign = "ConsultoraOnline"
                            });
                case "MISPEDIDOS":
                    if (esMovil)
                        return RedirectToAction("MisPedidos", "ConsultoraOnline",
                            new
                            {
                                area = "Mobile",
                                utm_source = "Transaccional",
                                utm_medium = "email",
                                utm_content = "Bienvenida_verPedidos",
                                utm_campaign = "ConsultoraOnline"
                            });
                    else
                        return RedirectToAction("MisPedidos", "ConsultoraOnline",
                            new
                            {
                                utm_source = "Transaccional",
                                utm_medium = "email",
                                utm_content = "Bienvenida_verPedidos",
                                utm_campaign = "ConsultoraOnline"
                            });
                case "CONSULTORAONLINE":
                    if (esMovil)
                        return RedirectToAction("Index", "ConsultoraOnline",
                            new
                            {
                                area = "Mobile",
                                utm_source = "Transaccional",
                                utm_medium = "email",
                                utm_content = "Bienvenida_irConsultoraOnline",
                                utm_campaign = "ConsultoraOnline"
                            });
                    else
                        return RedirectToAction("Index", "ConsultoraOnline",
                            new
                            {
                                utm_source = "Transaccional",
                                utm_medium = "email",
                                utm_content = "Bienvenida_irConsultoraOnline",
                                utm_campaign = "ConsultoraOnline"
                            });
                case "SOLICITUDPEDIDO":
                    if (esMovil)
                        return RedirectToAction("MisPedidos", "ConsultoraOnline", new { area = "Mobile" });
                    else
                        return RedirectToAction("MisPedidos", "ConsultoraOnline");
                case "ACTUALIZARCORREO":
                    if (esMovil)
                        return RedirectToAction("MiPerfil", "ConsultoraOnline", new { area = "Mobile", data = data });
                    else
                        return RedirectToAction("MiPerfil", "ConsultoraOnline", new { data = data });
            }

            return new EmptyResult();
        }

        private int GetOrigenPedidoWeb(string flagMedio, int marcaID, int dispositivo, int tipoVista)
        {
            var origenPedidoWeb = 0;

            if (dispositivo == 1) //DESKTOP
            {
                if (flagMedio == Constantes.SolicitudCliente.FlagMedio.AppCatalogos)
                {
                    if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoLbelAppCatalogoPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoEsikaAppCatalogoPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoCyzoneAppCatalogoPendienteDeAprobar;
                }
                else if (flagMedio == Constantes.SolicitudCliente.FlagMedio.CatalogoDigital)
                {
                    if (tipoVista == 1) // por cliente
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoLbelCatalogoDigitalPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoEsikaCatalogoDigitalPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoCyzoneCatalogoDigitalPendienteDeAprobar;
                    }
                    else
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoLbelCatalogoDigitalPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoEsikaCatalogoDigitalPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoCyzoneCatalogoDigitalPendienteDeAprobarProducto;
                    }
                }
                else if (flagMedio == Constantes.SolicitudCliente.FlagMedio.MaquilladorVirtual)
                {
                    if (tipoVista == 1) // por cliente
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoLbelMaquilladorPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoEsikaMaquilladorPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoCyzoneMaquilladorPendienteDeAprobar;
                    }
                    else
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoLbelMaquilladorPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoEsikaMaquilladorPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopPedidoCatalogoCyzoneMaquilladorPendienteDeAprobarProducto;
                    }
                }
            }
            else if (dispositivo == 2) //MOBILE
            {
                if (flagMedio == Constantes.SolicitudCliente.FlagMedio.AppCatalogos)
                {
                    if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoLbelAppCatalogoPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoEsikaAppCatalogoPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoCyzoneAppCatalogoPendienteDeAprobar;
                }
                else if (flagMedio == Constantes.SolicitudCliente.FlagMedio.CatalogoDigital)
                {
                    if (tipoVista == 1) // por cliente
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoLbelCatalogoDigitalPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoEsikaCatalogoDigitalPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoCyzoneCatalogoDigitalPendienteDeAprobar;
                    }
                    else
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoLbelCatalogoDigitalPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoEsikaCatalogoDigitalPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoCyzoneCatalogoDigitalPendienteDeAprobarProducto;
                    }
                }
                else if (flagMedio == Constantes.SolicitudCliente.FlagMedio.MaquilladorVirtual)
                {
                    if (tipoVista == 1) // por cliente
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoLbelMaquilladorPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoEsikaMaquilladorPendienteDeAprobar;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoCyzoneMaquilladorPendienteDeAprobar;
                    }
                    else
                    {
                        if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoLbelMaquilladorPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoEsikaMaquilladorPendienteDeAprobarProducto;
                        else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.MobilePedidoCatalogoCyzoneMaquilladorPendienteDeAprobarProducto;
                    }
                }
            }
            else if (dispositivo == 3) //APP
            {
                if (flagMedio == Constantes.SolicitudCliente.FlagMedio.AppCatalogos)
                {
                    if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.AppConsultoraPedidoCatalogoLbelAppCatalogoPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.AppConsultoraPedidoCatalogoEsikaAppCataogoPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.AppConsultoraPedidoCatalogoCyzoneAppCatalogoPendienteDeAprobar;
                }
                else if (flagMedio == Constantes.SolicitudCliente.FlagMedio.CatalogoDigital)
                {
                    if (marcaID == Constantes.Marca.LBel) origenPedidoWeb = Constantes.OrigenPedidoWeb.AppConsultoraPedidoCatalogoLbelCatalogoDigitalPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Esika) origenPedidoWeb = Constantes.OrigenPedidoWeb.AppConsultoraPedidoCatalogoEsikaCatalogoDigitalPendienteDeAprobar;
                    else if (marcaID == Constantes.Marca.Cyzone) origenPedidoWeb = Constantes.OrigenPedidoWeb.AppConsultoraPedidoCatalogoCyzoneCatalogoDigitalPendienteDeAprobar;
                }
            }

            return origenPedidoWeb;
        }


        #region New Pedido Pendientes

        public ActionResult Pendientes()
        {
            MisPedidosModel model = new MisPedidosModel();
            ViewBag.PaisISOx = userData.CodigoISO;

            model = GetPendientes();

            if (model.ListaPedidos.Count == 0)
            {
                model.RegistrosTotal = "0";
                return RedirectToAction("Index", "Pedido", new { area = "" });
            }

            using (var sv = new SACServiceClient())
            {
                var motivoSolicitud = sv.GetMotivosRechazo(userData.PaisID).ToList();
                ViewBag.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(motivoSolicitud);
            }

            return View(model);
        }

        public MisPedidosModel GetPendientes()
        {
            MisPedidosModel model = new MisPedidosModel();

            try
            {
                var lstPedidos = new List<BEMisPedidos>();
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    lstPedidos = svc.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                }

                // quitar los que ya fueron atendidos
                lstPedidos.RemoveAll(x => x.Estado.Trim().Length > 0);

                lstPedidos.ForEach(x => x.FormartoFechaSolicitud = x.FechaSolicitud.ToString("dd") + " de " + x.FechaSolicitud.ToString("MMMM", new CultureInfo("es-ES")));
                lstPedidos.ForEach(x => x.FormatoPrecioTotal = Util.DecimalToStringFormat(x.PrecioTotal, userData.CodigoISO));

                // obtener todo los detalles de los pedidos hechos
                var lstPedidosDetalleAll = new List<BEMisPedidosDetalle>();
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    lstPedidosDetalleAll = svc.GetMisPedidosDetallePendientesAll(userData.PaisID, userData.CampaniaID, userData.ConsultoraID).ToList();
                }

                foreach (var cab in lstPedidos)
                {
                    var detalles = lstPedidosDetalleAll.Where(x => x.PedidoId == cab.PedidoId);
                    if (detalles.Any()) cab.DetallePedido = detalles.ToArray();
                }

                model.ListaPedidos = lstPedidos;
                var lstByProductos = new List<BEMisPedidosDetalle>();
                var grpListCuv = lstPedidosDetalleAll.Select(x => x.CUV).Distinct().ToList();

                foreach (var cuv in grpListCuv)
                {
                    var lstCuv = lstPedidosDetalleAll.Where(x => x.CUV == cuv);
                    var det = lstPedidosDetalleAll.First(x => x.CUV == cuv);
                    var ids = lstCuv.Where(x => x.CUV == cuv).Select(x => x.PedidoId.ToString()).ToArray();
                    //item.Cantidad = lst1.Count();
                    det.CantidadTotal = lstCuv.Sum(x => x.Cantidad);
                    //det.PrecioTotal = (lstCuv.Sum(x => x.PrecioUnitario) * lstCuv.Sum(x => x.Cantidad));
                    det.PrecioTotal = (det.CantidadTotal * det.PrecioUnitario);
                    det.FormatoPrecioTotal = Util.DecimalToStringFormat(det.PrecioTotal.ToDecimal(), userData.CodigoISO);
                    det.ListaClientes = lstPedidos.Where(x => ids.Contains(x.PedidoId.ToString())).ToArray();

                    if (det.ListaClientes == null || det.ListaClientes.Count() == 0)
                    {
                        continue;
                    }
                    lstByProductos.Add(det);
                }

                model.ListaProductos = lstByProductos;
                objMisPedidos = model;
                SessionManager.SetobjMisPedidos(objMisPedidos);
                //model.RegistrosTotal = model.ListaPedidos.Count.ToString();

                return model;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new MisPedidosModel();
            }
        }

        [HttpPost]
        public JsonResult DetallePedidoPendiente(string ids)
        {
            MisPedidosDetalleModel model = new MisPedidosDetalleModel();

            try
            {
                MisPedidosModel pedidos = SessionManager.GetobjMisPedidos();
                if (string.IsNullOrEmpty(ids))
                {
                    return Json(new
                    {
                        success = false
                    }, JsonRequestBehavior.AllowGet);
                }

                var arrIds = ids.Split(',');
                var lstPedidos = pedidos.ListaPedidos.Where(x => arrIds.Contains(x.PedidoId.ToString()));

                if (!lstPedidos.Any())
                {
                    return Json(new
                    {
                        success = false
                    }, JsonRequestBehavior.AllowGet);
                }

                pedidos.ListaPedidos = lstPedidos.ToList();
                var lstPedidosDetatalle = new List<BEMisPedidosDetalle>();

                foreach (var cab in lstPedidos)
                {
                    foreach (var det in cab.DetallePedido)
                    {
                        det.Elegido = false;
                        det.ListaClientes = null;
                        lstPedidosDetatalle.Add(det);
                    }
                }

                model.ListaDetalle2 = new List<MisPedidosDetalleModel2>();
                if (lstPedidosDetatalle.Any())
                {
                    var firstPedido = pedidos.ListaPedidos.FirstOrDefault();
                    model.MiPedido = firstPedido;

                    lstPedidosDetatalle = CargarMisPedidosDetalleDatos(firstPedido.MarcaID, lstPedidosDetatalle);
                    //SessionManager.SetobjMisPedidosDetalle(lstPedidosDetatalle);
                    SessionManager.SetobjMisPedidos(pedidos);
                    var detallePedidos = Mapper.Map<List<BEMisPedidosDetalle>, List<MisPedidosDetalleModel2>>(lstPedidosDetatalle);
                    detallePedidos.Update(p => p.CodigoIso = userData.CodigoISO);
                    model.ListaDetalle2 = detallePedidos;
                }

                //model.RegistrosTotal = model.ListaDetalle2.Count.ToString();

                return Json(new
                {
                    success = true,
                    data = model
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Error al procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult DetallePedidoPendienteClientes(string cuv)
        {
            MisPedidosModel model = new MisPedidosModel();
            string producton = "";

            try
            {
                MisPedidosModel pedidos = SessionManager.GetobjMisPedidos();
                if (string.IsNullOrEmpty(cuv))
                {
                    return Json(new
                    {
                        success = false,
                    }, JsonRequestBehavior.AllowGet);
                }

                var arrIds = new List<string>();
                //var lstdetalle = new List<BEMisPedidosDetalle>();

                foreach (var cab in pedidos.ListaPedidos)
                {
                    var detalles = cab.DetallePedido.Where(x => x.CUV == cuv);
                    if (detalles.Any())
                    {
                        producton = detalles.ToList()[0].Producto;
                        arrIds.Add(cab.PedidoId.ToString());
                    }
                }

                if (!arrIds.Any())
                {
                    return Json(new
                    {
                        success = false,
                    }, JsonRequestBehavior.AllowGet);
                }

                var lstPedidos = pedidos.ListaPedidos.Where(x => arrIds.Contains(x.PedidoId.ToString()));
                foreach (var cab in lstPedidos)
                {
                    cab.CantidadTotal = cab.DetallePedido.Where(x => x.CUV == cuv).Sum(x => x.Cantidad);
                    foreach (var det in cab.DetallePedido)
                    {
                        det.ListaClientes = null;
                    }
                }

                //var model1 = Mapper.Map<ClienteOnlineModel>(lstPedidos);
                model.ListaPedidos = lstPedidos.ToList();
                //model.ListaPedidos[0].DetallePedido = lstdetalle.ToArray();
                //model.RegistrosTotal = model.ListaPedidos.Count.ToString();
                SessionManager.SetobjMisPedidos(model);
                //SessionManager.SetobjMisPedidosDetalle(lstdetalle);
                //ViewBag.CUVx = cuv;

                return Json(new
                {
                    success = true,
                    data = model,
                    CUVx = cuv,
                    Productox = producton
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Error al procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private List<BEMisPedidosDetalle> CargarMisPedidosDetalleDatos(int marcaId, List<BEMisPedidosDetalle> lstPedidosDetalle)
        {
            // 0=App Catalogos, >0=Portal Marca
            if (marcaId != 0) return lstPedidosDetalle;

            int? revistaGana;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                revistaGana = sv.ValidarDesactivaRevistaGana(userData.PaisID, userData.CampaniaID,
                    userData.CodigoZona);
            }

            var olstMisProductos = GetValidarCuvMisPedidos(lstPedidosDetalle);

            foreach (var item in lstPedidosDetalle)
            {
                var pedidoVal = olstMisProductos.FirstOrDefault(x => x.CUV == item.CUV);
                if (pedidoVal == null)
                {
                    item.TieneStock = 0;
                    item.MensajeValidacion = "El producto solicitado no existe";
                    continue;
                }

                item.EstaEnRevista = pedidoVal.EstaEnRevista.ToInt();
                item.TieneStock = 1;

                if (!pedidoVal.TieneStock)
                {
                    item.TieneStock = 0;
                    item.MensajeValidacion = "Este producto está agotado";
                }
                else if (pedidoVal.CUVRevista.Length != 0 && revistaGana == 0)
                {
                    item.EstaEnRevista = 1;
                    item.MensajeValidacion = isEsika
                        ? Constantes.MensajeEstaEnRevista.EsikaWeb
                        : Constantes.MensajeEstaEnRevista.LbelWeb;
                }
            }

            return lstPedidosDetalle;
        }

        private List<ServiceODS.BEProducto> GetValidarCuvMisPedidos(List<BEMisPedidosDetalle> lstPedidosDetalle)
        {
            var inputCuv = string.Join(",", lstPedidosDetalle.Select(x => x.CUV).ToList());
            var olstMisProductos = new List<ServiceODS.BEProducto>();

            using (ODSServiceClient svc = new ODSServiceClient())
            {
                olstMisProductos = svc.GetValidarCUVMisPedidos(userData.PaisID, userData.CampaniaID,
                    inputCuv, userData.RegionID, userData.ZonaID, userData.CodigorRegion,
                    userData.CodigoZona).ToList();
            }

            SessionManager.SetobjMisPedidosDetalleVal(olstMisProductos);

            return olstMisProductos;
        }

        [HttpPost]
        public JsonResult ActualizarPendientes()
        {
            try
            {
                var model = GetPendientes();

                var PendientesJson = JsonConvert.SerializeObject(model, Formatting.Indented, new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                });

                return Json(new
                {
                    success = true,
                    Pendientes = PendientesJson,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        //public JsonResult RechazarSolicitudCliente(string pedidoId)
            public JsonResult RechazarSolicitudCliente(string pedidoId, int motivoRechazoId, string motivoRechazoTexto)
        {
            try
            {
                if (string.IsNullOrEmpty(pedidoId))
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud"
                    }, JsonRequestBehavior.AllowGet);
                }

                var pedidos = SessionManager.GetobjMisPedidos();
                var pedido = pedidos.ListaPedidos.Where(x => x.PedidoId.ToString() == pedidoId).FirstOrDefault();

                if (pedido == null)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud"
                    }, JsonRequestBehavior.AllowGet);
                }

                using (SACServiceClient svc = new SACServiceClient())
                {
                    svc.UpdSolicitudClienteRechazar(userData.PaisID, pedido.PedidoId, motivoRechazoId, motivoRechazoTexto);
                }

                MisPedidosModel model = new MisPedidosModel();
                model = GetPendientes();

                var PendientesJson = JsonConvert.SerializeObject(model, Formatting.Indented, new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                });

                return Json(new
                {
                    success = true,
                    Pendientes = PendientesJson,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult RechazarSolicitudClientePorCuv(string cuv)
        {
            try
            {
                if (string.IsNullOrEmpty(cuv))
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud"
                    }, JsonRequestBehavior.AllowGet);
                }

                var pedidos = SessionManager.GetobjMisPedidos();
                var arrIds = new List<string>();

                foreach (var cab in pedidos.ListaPedidos)
                {
                    var tmp = cab.DetallePedido.Where(x => x.CUV == cuv).FirstOrDefault();
                    if (tmp != null) arrIds.Add(cab.PedidoId.ToString());
                }

                if (!arrIds.Any())
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud"
                    }, JsonRequestBehavior.AllowGet);
                }

                var lstPedidos = pedidos.ListaPedidos.Where(x => arrIds.Contains(x.PedidoId.ToString()));

                using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                {
                    foreach (var ped in lstPedidos)
                    {
                        svc.UpdSolicitudClienteRechazarPorCuv(userData.PaisID, ped.PedidoId, cuv);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult EliminarSolicitudDetalle(int pedidoId, string cuv)
        {
            try
            {
                if (pedidoId == 0 || string.IsNullOrEmpty(cuv))
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud",
                    }, JsonRequestBehavior.AllowGet);
                }

                var pedidos = SessionManager.GetobjMisPedidos();
                bool found = false;

                var pedido = pedidos.ListaPedidos.Where(x => x.PedidoId == pedidoId).FirstOrDefault();
                if (pedido != null)
                {
                    var tmpDet = pedido.DetallePedido.Where(x => x.CUV == cuv);
                    if (tmpDet.Any()) found = true;
                }

                if (!found)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al procesar la solicitud"
                    }, JsonRequestBehavior.AllowGet);
                }

                using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                {
                    svc.UpdSolicitudClienteDetalleEstado(userData.PaisID, pedidoId, cuv, false);

                    foreach (var cab in pedidos.ListaPedidos.Where(x => x.PedidoId == pedidoId))
                    {
                        var tmp = cab.DetallePedido.ToList();
                        tmp.RemoveAll(x => x.CUV == cuv);
                        cab.DetallePedido = tmp.ToArray();
                    }

                    SessionManager.SetobjMisPedidos(pedidos);
                }

                MisPedidosModel model = new MisPedidosModel();
                model = GetPendientes();

                var PendientesJson = JsonConvert.SerializeObject(model, Formatting.Indented, new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                });

                return Json(new
                {
                    success = true,
                    Pendientes = PendientesJson,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }

        }

        [HttpPost]
        public JsonResult ContinuarPedidos(List<BEMisPedidosDetalle> lstDetalle, string tipoVista)
        {
            try
            {
                //List<BEMisPedidosDetalle> pedidosdetalle = SessionManager.GetobjMisPedidosDetalle();
                MisPedidosModel model = new MisPedidosModel();
                var pedidos = SessionManager.GetobjMisPedidos();

                // reset elegido
                foreach (var cab in pedidos.ListaPedidos)
                {
                    foreach (var det in cab.DetallePedido)
                    {
                        det.Elegido = false;
                    }
                }

                foreach (var det in lstDetalle)
                {
                    foreach (var cab in pedidos.ListaPedidos)
                    {
                        var tmpDet = cab.DetallePedido.Where(x => x.PedidoId == det.PedidoId && x.CUV == det.CUV).FirstOrDefault();
                        if (tmpDet != null)
                        {
                            tmpDet.Elegido = true;

                            // cambio la cantidad
                            if (det.Cantidad != tmpDet.Cantidad)
                            {
                                tmpDet.Cantidad = det.Cantidad;
                                using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                                {
                                    svc.UpdSolicitudClienteDetalleCantidad(userData.PaisID, cab.PedidoId, tmpDet.CUV, det.Cantidad);
                                }
                            }
                        }
                    }
                }

                model.ListaPedidos = pedidos.ListaPedidos;
                model.RegistrosTotal = model.ListaPedidos.Count.ToString();
                SessionManager.SetobjMisPedidos(model);
                //SessionManager.SetobjMisPedidosDetalle(Listadetalle);
                var modelList = PendientesMedioDeCompra();
                Session["OrigenTipoVista"] = tipoVista;

                return Json(new
                {
                    result = modelList,
                    success = true,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult AceptarPedidoPendiente(ConsultoraOnlinePedidoModel parametros)
        {
            string mensajeR;
            int paisId = userData.PaisID;
            string mensajeaCliente =
                string.Format(
                    "Gracias por haber escogido a {0} como tu Consultora. Pronto se pondrá en contacto contigo para coordinar la hora y lugar de entrega.",
                    userData.NombreConsultora);
            var noPasa = ReservadoEnHorarioRestringido(out mensajeR);
            if (noPasa)
            {
                return Json(new
                {
                    success = false,
                    message = mensajeR,
                    code = 2
                }, JsonRequestBehavior.AllowGet);
            }

            var pedidosSesion = SessionManager.GetobjMisPedidos().ListaPedidos;

            #region Logica Cliente existe

            using (ServiceCliente.ClienteServiceClient svc = new ServiceCliente.ClienteServiceClient())
            {
                pedidosSesion.ForEach(pedido =>
                {
                    if (pedido.DetallePedido.Any(i => i.Elegido == true))
                    {
                        var a = new ServiceCliente.BECliente
                        {
                            ConsultoraID = userData.ConsultoraID,
                            eMail = pedido.Email
                        };
                        int xclienteId = svc.GetExisteClienteConsultora(userData.PaisID, a);

                        if (xclienteId == 0)
                        {
                            var pedidoAux = pedidosSesion.FirstOrDefault(x => x.Email == pedido.Email);
                            var beCliente = new ServiceCliente.BECliente
                            {
                                ConsultoraID = userData.ConsultoraID,
                                eMail = pedidoAux.Email,
                                Nombre = pedidoAux.Cliente,
                                PaisID = userData.PaisID,
                                Activo = true
                            };
                            xclienteId = svc.Insert(beCliente);
                        }

                        pedido.ClienteId = xclienteId;
                    }
                });
            }

            #endregion

            #region Logica Grabado

            if (parametros.AccionTipo == Constantes.OpcionesIngresoPendientes.ingrgana)
            {
                int pedidoWebId = 0;
                if (parametros.ListaGana.Any())
                {
                    var listaClientesId = new List<short>();

                    using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                    {
                        pedidosSesion.ForEach(pedido =>
                        {
                            if (pedido.DetallePedido.Any(i => i.Elegido == true))
                            {
                                listaClientesId.Add(short.Parse(pedido.ClienteId.ToString()));

                                pedido.DetallePedido.Where(i => i.Elegido).Each(detalle =>
                                {
                                    var beSolicitudDetalle = new ServiceSAC.BESolicitudClienteDetalle
                                    {
                                        SolicitudClienteDetalleID = detalle.PedidoDetalleId,
                                        TipoAtencion = 3,
                                        PedidoWebID = pedidoWebId,
                                        PedidoWebDetalleID = 0
                                    };
                                    svc.UpdSolicitudClienteDetalle(userData.PaisID, beSolicitudDetalle);
                                    detalle.TipoAtencion = 3;
                                });
                            }
                        });
                    }

                    parametros.ListaGana.ForEach(model =>
                    {
                        BEPedidoDetalle pedidoDetalle = new BEPedidoDetalle();
                        pedidoDetalle.Producto = new ServicePedido.BEProducto();
                        pedidoDetalle.Producto.EstrategiaID = model.EstrategiaID;
                        pedidoDetalle.Producto.TipoEstrategiaID = model.TipoEstrategiaID.ToString();
                        pedidoDetalle.Producto.TipoOfertaSisID = model.TipoOfertaSisID;
                        pedidoDetalle.Producto.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
                        //pedidoDetalle.Producto.CUV = Util.Trim(model.CuvTonos);
                        pedidoDetalle.Producto.IndicadorMontoMinimo = string.IsNullOrEmpty(model.IndicadorMontoMinimo.ToString()) ? 0 : Convert.ToInt32(model.IndicadorMontoMinimo);
                        pedidoDetalle.Producto.FlagNueva = model.FlagNueva.ToString();
                        pedidoDetalle.Producto.Descripcion = model.DescripcionCUV2 ?? "";
                        pedidoDetalle.Usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
                        pedidoDetalle.Cantidad = model.Cantidad == 0 ? 1 : Convert.ToInt32(model.Cantidad);
                        pedidoDetalle.PaisID = userData.PaisID;
                        pedidoDetalle.IPUsuario = GetIPCliente();
                        //pedidoDetalle.OrigenPedidoWeb = GetOrigenPedidoWeb("", 0, 1);
                        pedidoDetalle.OrigenPedidoWeb = GetOrigenPedidoWeb(Constantes.SolicitudCliente.FlagMedio.MaquilladorVirtual, model.MarcaID, parametros.Dispositivo, parametros.OrigenTipoVista);
                        //pedidoDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);
                        pedidoDetalle.Identifier = SessionManager.GetTokenPedidoAutentico() != null ? SessionManager.GetTokenPedidoAutentico().ToString() : string.Empty;
                        //pedidoDetalle.EsCuponNuevas = model.EsCuponNuevas || model.FlagNueva == 1;
                        //pedidoDetalle.EsSugerido = model.EsSugerido;
                        //pedidoDetalle.EsKitNueva = model.EsKitNueva;
                        //pedidoDetalle.EsKitNuevaAuto = model.EsKitNuevaAuto;
                        //pedidoDetalle.OfertaWeb = model.OfertaWeb;
                        //pedidoDetalle.EsEditable = model.EsEditable;
                        //pedidoDetalle.SetID = model.SetId;
                        //var pedidoDetalleResult = _pedidoWebProvider.InsertPedidoDetalle(pedidoDetalle);

                        listaClientesId.ForEach(clienteId =>
                        {
                            pedidoDetalle.ClienteID = clienteId;
                            var pedidoDetalleResult = _pedidoWebProvider.InsertPedidoDetalle(pedidoDetalle);
                            pedidoWebId = (pedidoDetalleResult.PedidoWebDetalle != null ? pedidoDetalleResult.PedidoWebDetalle.PedidoID : pedidoWebId);
                        });

                    });

                    SessionManager.SetPedidoWeb(null);
                    SessionManager.SetDetallesPedido(null);
                    SessionManager.SetDetallesPedidoSetAgrupado(null);

                }
            }
            else if (parametros.AccionTipo == Constantes.OpcionesIngresoPendientes.ingrped)
            {
                using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                {
                    pedidosSesion.ForEach(pedido =>
                    {
                        if (pedido.DetallePedido.Any(i => i.Elegido == true))
                        {
                            var olstMisProductos = GetValidarCuvMisPedidos(pedido.DetallePedido.Where(i => i.Elegido == true).ToList());

                            pedido.DetallePedido.Where(i => i.Elegido == true).ToList().ForEach(detalle =>
                            {
                                ServiceODS.BEProducto productoVal =
                                        olstMisProductos.FirstOrDefault(j => j.CUV == detalle.CUV);

                                var model = new PedidoSb2Model
                                {
                                    TipoOfertaSisID = productoVal.TipoOfertaSisID,
                                    ConfiguracionOfertaID = productoVal.ConfiguracionOfertaID,
                                    ClienteID = pedido.ClienteId.ToString(),
                                    OfertaWeb = false,
                                    IndicadorMontoMinimo = productoVal.IndicadorMontoMinimo.ToString(),
                                    EsSugerido = false,
                                    EsKitNueva = false,
                                    MarcaID = detalle.MarcaID,
                                    Cantidad = detalle.Cantidad.ToString(),
                                    PrecioUnidad = Convert.ToDecimal(detalle.PrecioUnitario),
                                    CUV = detalle.CUV,
                                    DescripcionProd = detalle.Producto,
                                    ClienteDescripcion = pedido.Cliente,
                                    OrigenPedidoWeb = GetOrigenPedidoWeb(pedido.FlagMedio, detalle.MarcaID, parametros.Dispositivo, parametros.OrigenTipoVista)
                                };

                                var olstPedidoWebDetalle = AgregarDetallePedido(model);

                                if (olstPedidoWebDetalle != null)
                                {
                                    var bePedidoWebDetalle = olstPedidoWebDetalle.FirstOrDefault(x =>
                                       x.CUV == detalle.CUV && x.MarcaID == detalle.MarcaID &&
                                       x.ClienteID == Convert.ToInt16(pedido.ClienteId));

                                    var beSolicitudDetalle = new ServiceSAC.BESolicitudClienteDetalle
                                    {
                                        SolicitudClienteDetalleID = detalle.PedidoDetalleId,
                                        TipoAtencion = 1,
                                        PedidoWebID = bePedidoWebDetalle.PedidoID,
                                        PedidoWebDetalleID = bePedidoWebDetalle.PedidoDetalleID
                                    };
                                    svc.UpdSolicitudClienteDetalle(userData.PaisID, beSolicitudDetalle);
                                    detalle.TipoAtencion = 2;
                                }
                            });
                        }
                    });
                }
            }
            else if (parametros.AccionTipo == Constantes.OpcionesIngresoPendientes.ingrten)
            {
                using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                {
                    pedidosSesion.ForEach(x =>
                    {
                        if (x.DetallePedido.Any(i => i.Elegido == true))
                        {
                            x.DetallePedido.Where(i => i.Elegido == true).ToList().ForEach(detalle =>
                            {
                                var beSolicitudDetalle = new ServiceSAC.BESolicitudClienteDetalle
                                {
                                    SolicitudClienteDetalleID = detalle.PedidoDetalleId,
                                    TipoAtencion = 2,
                                    PedidoWebID = 0,
                                    PedidoWebDetalleID = 0
                                };

                                detalle.TipoAtencion = 2;
                                detalle.PedidoWebDetalleID = 0;
                                detalle.PedidoWebID = 0;
                                svc.UpdSolicitudClienteDetalle(userData.PaisID, beSolicitudDetalle);
                            });
                        }
                    });
                }
            }

            #endregion

            #region Revision cabecera

            using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
            {
                pedidosSesion.ForEach(pedido =>
                {
                    if (!pedido.DetallePedido.ToList().Where(k => k.Estado == 1).Any(i => i.TipoAtencion == 0))
                    {
                        var beSolicitudCliente = new ServiceSAC.BESolicitudCliente
                        {
                            SolicitudClienteID = pedido.PedidoId,
                            CodigoConsultora = userData.ConsultoraID.ToString(),
                            MensajeaCliente = mensajeaCliente,
                            UsuarioModificacion = userData.CodigoUsuario,
                            Estado = "A"
                        };

                        svc.UpdSolicitudCliente(userData.PaisID, beSolicitudCliente);
                    }
                });
            }

            #endregion

            #region Email

            //EnviarEmail(pedidosSesion, mensajeaCliente);

            #endregion

            var pedidos = GetPendientes();
            var ContinuarExpPendientes = true;
            if (pedidos.ListaPedidos == null || pedidos.ListaPedidos.Count == 0)
            {
                ContinuarExpPendientes = false;
            }

            try
            {
                return Json(new
                {
                    success = true,
                    message = "OK",
                    continuarExpPendientes = ContinuarExpPendientes,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException e)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(e, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = e.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [Obsolete("Revisar ya no se usa")]
        public void EnviarEmail(List<BEMisPedidos> pedidosSesion, string mensajeaCliente)
        {
            try
            {
                string emailDe = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ConsultoraOnlineEmailDe);

                pedidosSesion.ForEach(pedidoAux =>
                {
                    int tipo;
                    string marcaPedido;

                    // 0=App Catalogos, >0=Portal Marca
                    if (pedidoAux.MarcaID == 0)
                    {
                        tipo = 1;
                        marcaPedido = pedidoAux.MedioContacto;
                    }
                    else
                    {
                        tipo = 2;
                        marcaPedido = pedidoAux.Marca;
                    }

                    if (pedidoAux.DetallePedido.Any(i => i.Elegido == true) && pedidoAux.FlagMedio == "01")
                    {
                        double totalPedido = 0;

                        String titulocliente = "Tu pedido ha sido CONFIRMADO por " + userData.PrimerNombre + " " +
                                               userData.PrimerApellido + " - App de Catálogos Ésika, L'Bel y Cyzone";
                        StringBuilder mensajecliente = new StringBuilder();
                        mensajecliente.Append(
                            "<table width='100%' border='0' bgcolor='#ffffff' cellspacing='0' cellpadding='0' border-spacing='0' style='margin: 0; border: 0; border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td align='center' valign='middle'>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td valign='middle' style='width: 15%'>");
                        mensajecliente.Append(
                            "<img src='https://s3-sa-east-1.amazonaws.com/appcatalogo/CL/mailing/cabecera_email.jpg' border='0' height='70' width='70' alt='Catálogos Esika, LBel y Cyzone'>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("<td valign='middle'>");
                        mensajecliente.Append(
                            "<span style='display: block; color: #7f7f7f; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>");
                        mensajecliente.Append("Catálogos Esika, LBel, Cyzone");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("</tbody></table>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append(
                            "<td align='center' valign='middle' style='border-top-width: 1px; border-top-color: #DDDDDD; border-top-style: solid; height: 10px;'></td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("</tbody></table>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("<br>");
                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td align='center' valign='middle'>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody>");

                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td align='center' valign='middle'>");
                        mensajecliente.Append(
                            "<table width='600' border='0' cellspacing='0' cellpadding='0' border-spacing='0' style='border-collapse: collapse!important;' align='center'>");

                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td colspan='2'>");
                        mensajecliente.Append(
                            "<span style='display: block; color: #7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Hola " +
                            pedidoAux.Cliente.Split(' ').First() + "</span>");
                        mensajecliente.Append(
                            "<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>Tu Consultora " +
                            userData.PrimerNombre + " " + userData.PrimerApellido + " ha confirmado tu pedido.</p>");
                        mensajecliente.Append(
                            "<p style='display: block; color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>En seguida se pondrá en contacto contigo para coordinar la hora y lugar de entrega.</p><br>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");

                        mensajecliente.Append("<tr>");
                        mensajecliente.Append(
                            "<td><span style='display: block; color: #7f7f7f; font-size: 17px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em 0 0 0em;'>RESUMEN DE TU PEDIDO</span></td>");
                        mensajecliente.Append("</tr>");

                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td style='width: 65%;' align='top' valign='middle'>");
                        mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0.6em;'>");
                        mensajecliente.Append(
                            "<span style='color: #7f7f7f; font-size: 15px; text-align: left; font-family: Arial, Helvetica, sans-serif;'>CLIENTE:");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("<br>");
                        mensajecliente.Append(
                            "<span style='color: #7f7f7f; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif;'> " +
                            pedidoAux.Cliente + "<br>");
                        mensajecliente.Append(pedidoAux.Email + "<br>");
                        mensajecliente.Append(pedidoAux.Telefono);
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("<td style='width: 35%;' align='top' valign='middle'>");
                        mensajecliente.Append("<span style='display: block; margin: 0.6em 0 0 0.6em;'>");
                        mensajecliente.Append(
                            "<span style='color: #7f7f7f; font-size: 11px; text-align: left; font-family: Arial, Helvetica, sans-serif; line-height: 1em'>FECHA: " +
                            String.Format("{0:dd/MM/yyyy}", pedidoAux.FechaSolicitud) + "<br>");
                        mensajecliente.Append("CAMPAÑA: " + pedidoAux.Campania + "<br>");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</span>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("</tbody></table>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        mensajecliente.Append("<tr>");
                        mensajecliente.Append("<td align='center' valign='middle'>");
                        mensajecliente.Append(
                            " <table width='600' border='0' cellspacing='0' cellpadding='10' border-spacing='0' align='center' style='border-collapse: collapse!important;'>");
                        mensajecliente.Append("<tbody><tr>");
                        mensajecliente.Append("<td valign='middle' colspan='3'>");
                        mensajecliente.Append(
                            "<span style='display: block; color:#7f7f7f; font-size: 16px; text-align: left; font-family: Arial, Helvetica, sans-serif; text-decoration: underline; margin: 0.6em 0 0em;'>");
                        mensajecliente.Append("Listado de Productos</span>");
                        mensajecliente.Append("</td>");
                        mensajecliente.Append("</tr>");
                        int cntfila = 0;

                        foreach (var item in pedidoAux.DetallePedido.Where(x => x.Elegido))
                        {
                            totalPedido += item.PrecioTotal;
                            cntfila = cntfila + 1;

                            if (cntfila % 2 == 0)
                            {
                                mensajecliente.Append("<tr>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.CUV + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Marca + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Producto + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " +
                                    userData.Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " +
                                    item.Cantidad + "</span></td>");
                                mensajecliente.Append("</tr>");
                            }
                            else
                            {
                                mensajecliente.Append("<tr style = 'background: #cccccc;'>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.CUV + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Marca + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>" +
                                    item.Producto + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Precio: " +
                                    userData.Simbolo + " " + item.PrecioUnitario.ToString("N2") + "</span></td>");
                                mensajecliente.Append(
                                    "<td><span style='width:90px;display: block; color: #000000; font-size: 14px; text-align: left; font-family: Arial, Helvetica, sans-serif; margin: 0.4em;'>Cantidad: " +
                                    item.Cantidad + "</span></td>");
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
                        mensajecliente.Append(
                            "<span style='display: inline-block; font-size: 18px; text-align: left; font-family: Arial, Helvetica, sans-serif; color: #7f7f7f; display: block; margin: 0.6em 0 0 0.6em;'>PRECIO TOTAL: " +
                            userData.Simbolo + " " + totalPedido.ToString("N2") + "");
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

                        //try
                        //{
                        //    if (parametros.Accion == 1)
                        //    {
                        //        Util.EnviarMail3(emailDe, pedidoAux.Email, titulocliente, mensajecliente.ToString(), true,
                        //            pedidoAux.Email);
                        //    }
                        //    else
                        //    {
                        //        Util.EnviarMail3Mobile(emailDe, pedidoAux.Email, titulocliente, mensajecliente.ToString(),
                        //            true, pedidoAux.Email);
                        //    }
                        //}
                        //catch (Exception ex)
                        //{
                        //    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                        //}
                    }
                    else
                    {
                        String titulo = "(" + userData.CodigoISO + ") Consultora que atenderá tu pedido de " +
                                        HttpUtility.HtmlDecode(marcaPedido);
                        StringBuilder mensaje = new StringBuilder();
                        mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(pedidoAux.Cliente));
                        mensaje.AppendFormat("{0}</p><br/>", mensajeaCliente);
                        mensaje.Append("<br/>Saludos,<br/><br />");
                        mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                        mensaje.AppendFormat(
                            "<td><p style='text-align: center;'><strong>{0}<br/>{1}<br/>Consultora</strong></p></td></tr></table>",
                            userData.NombreConsultora, userData.EMail);

                        //try
                        //{
                        //    if (parametros.Accion == 1)
                        //    {
                        //        Util.EnviarMail3(emailDe, pedidoAux.Email, titulo, mensaje.ToString(), true, string.Empty);
                        //    }
                        //    else
                        //    {
                        //        Util.EnviarMail3Mobile(emailDe, pedidoAux.Email, titulo, mensaje.ToString(), true,
                        //            string.Empty);
                        //    }
                        //}
                        //catch (Exception ex)
                        //{
                        //    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                        //}
                    }

                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        public PedidosPendientesMedioPagoModel PendientesMedioDeCompra()
        {
            try
            {
                var model = new PedidosPendientesMedioPagoModel();
                var parametrosRecomendado = new RecomendadoRequest();
                var oListaCatalogo = new List<MisPedidosDetalleModel2>();
                var productosSolicitados = new List<ProductoSolicitado>();

                var pedidosSesion = SessionManager.GetobjMisPedidos().ListaPedidos;

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

                oListaCatalogo.ForEach(x =>
                {
                    if (productosSolicitados.Any(i => i.CodigoSap == x.CodigoSap))
                    {
                        productosSolicitados.FirstOrDefault(i => i.CodigoSap == x.CodigoSap).Cantidad = productosSolicitados.FirstOrDefault(i => i.CodigoSap == x.CodigoSap).Cantidad + x.Cantidad;
                    }
                    else
                    {
                        productosSolicitados.Add(new ProductoSolicitado()
                        {
                            Cantidad = x.Cantidad,
                            CodigoSap = x.CodigoSap
                        });
                    }
                });

                parametrosRecomendado.productosSolicitados = productosSolicitados.ToArray();
                parametrosRecomendado.codigoProducto = productosSolicitados.Select(x => x.CodigoSap).ToArray();

                var oListaGana = _consultoraOnlineProvider.GetRecomendados(parametrosRecomendado);
                model.ListaCatalogo = oListaCatalogo;
                model.TotalCatalogo = oListaCatalogo.Sum(x => x.Cantidad * x.PrecioUnitario);
                model.ListaGana = oListaGana;
                model.TotalGana = oListaGana.Sum(x => x.Cantidad * x.Precio2);
                model.GananciaGana = model.TotalCatalogo - model.TotalGana;
                // ViewBag.PaisISOx = userData.CodigoISO;

                return model;
            }
            catch (FaultException e)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(e, userData.CodigoConsultora, userData.CodigoISO);

                return new PedidosPendientesMedioPagoModel();
            }
        }

        #endregion

    }
}

