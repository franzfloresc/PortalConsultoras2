using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System.Text;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultoraOnlineController : BaseController
    {
        #region Configuracion de Paginado
        MisPedidosModel objMisPedidos;
        int registrosPagina = 5;
        int indiceActualPagina = 0;
        int indiceUltimaPagina;
        #endregion

        public ConsultoraOnlineController()
        {
            this.registrosPagina = 5;
        }
        ~ConsultoraOnlineController()
        {
            Session["objMisPedidos"] = null;
        }

        public ActionResult Index(string activation)
        {
            ClienteContactaConsultoraModel consultora = new ClienteContactaConsultoraModel();
            if (activation != null)
            {
                if (activation.Equals("successful"))
                {
                    ViewBag.EmailConfirmado = true;
                    ViewBag.EmailConsultora = UserData().EMail;
                    ViewBag.ConsultoraID = UserData().ConsultoraID;
                }
            }
            else
            {
                var consultoraAfiliar = new ClienteContactaConsultoraModel();
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    ServiceSAC.BEAfiliaClienteConsultora beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(UserData().PaisID, UserData().CodigoConsultora);
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
            string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
            if (!strpaises.Contains(UserData().CodigoISO))
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
            string rutaPDF = "/Content/FAQ/CCC_TC_Consultoras.pdf";
            ViewBag.PDFLink = String.Format("{0}WebPages/DownloadPDF.aspx?file={1}", Util.GetUrlHost(request), rutaPDF);

            return View(consultoraAfiliar);
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Inscripcion(ClienteContactaConsultoraModel model)
        {
            var consultoraAfiliar = new ClienteContactaConsultoraModel();

            consultoraAfiliar.Email = model.Email;
            consultoraAfiliar.Celular = model.Celular;
            consultoraAfiliar.Telefono = model.Telefono;
            consultoraAfiliar.NombreCompleto = model.Nombres;

            if (ModelState.IsValid)
            {
                try
                {
                    string sEmail = string.Empty;
                    string sTelefono = string.Empty;
                    string sCelular = string.Empty;

                    if (model.ActualizarClave == null) model.ActualizarClave = "";
                    if (model.ConfirmarClave == null) model.ConfirmarClave = "";
                    if (model.Email != null)
                        sEmail = model.Email;
                    if (model.Telefono != null)
                        sTelefono = model.Telefono;
                    if (model.Celular != null)
                        sCelular = model.Celular;

                    int result;
                    bool cambio;
                    string resultado = string.Empty;


                    ClienteContactaConsultoraModel ConsultoraAfiliar = DatoUsuario();
                    model.CorreoAnterior = UserData().EMail;


                    if (model.Email != string.Empty)
                    {
                        int cantidad = 0;
                        using (UsuarioServiceClient svr = new UsuarioServiceClient())
                        {
                            cantidad = svr.ValidarEmailConsultora(UserData().PaisID, model.Email, UserData().CodigoUsuario);

                            if (cantidad > 0)
                            {
                                ViewBag.EmailConsultoraTomado = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.";
                                return View(consultoraAfiliar);
                            }
                        }
                    }
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {

                        result = sv.UpdateDatosPrimeraVez(UserData().PaisID, UserData().CodigoUsuario, model.Email, model.Telefono, model.Celular, model.CorreoAnterior, model.AceptoContrato);

                        if (result == 0)
                        {
                            ViewBag.AppErrorMessage = "Error al actualizar datos, intentelo mas tarde";

                            return View(consultoraAfiliar);
                        }
                        else
                        {
                            string message = string.Empty;

                            if (model.ActualizarClave != "")
                            {
                                cambio = sv.ChangePasswordUser(UserData().PaisID, UserData().CodigoUsuario, UserData().CodigoISO + UserData().CodigoUsuario, model.ConfirmarClave.ToUpper(), string.Empty, EAplicacionOrigen.BienvenidaConsultora);

                                if (cambio)
                                    message = "- Los datos han sido actualizados correctamente.\n ";
                                else
                                    message = "- Los datos han sido actualizados correctamente.\n - La contraseña no ha sido modificada, intentelo mas tarde.\n ";
                            }
                            else
                            {
                                message = "- Los datos han sido actualizados correctamente.\n ";
                            }
                            if (!string.IsNullOrEmpty(model.Email))
                            {

                                try
                                {


                                    if (ConsultoraAfiliar.EmailActivo && model.CorreoAnterior == model.Email)
                                    {
                                        if (ConsultoraAfiliar.EsPrimeraVez)
                                        {
                                            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                                            {
                                                sc.InsAfiliaClienteConsultora(UserData().PaisID, ConsultoraAfiliar.ConsultoraID);
                                            }
                                        }
                                        else
                                        {
                                            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                                            {
                                                sc.UpdAfiliaClienteConsultora(UserData().PaisID, ConsultoraAfiliar.ConsultoraID, true);
                                            }
                                        }

                                        return RedirectToAction("Index", "ConsultoraOnline");
                                    }
                                    else
                                    {
                                        string[] parametros = new string[] { UserData().CodigoUsuario, UserData().PaisID.ToString(), UserData().CodigoISO, model.Email };
                                        string param_querystring = Util.EncriptarQueryString(parametros);
                                        HttpRequestBase request = this.HttpContext.Request;

                                        //string cadena = mensajeConsultora(UserData().PrimerNombre, String.Format("{0}ClienteContactaConsultora/Afiliar?data={1}", Util.GetUrlHost(request), param_querystring));
                                        string cadena = mensajeConsultora(UserData().PrimerNombre, String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}", Util.GetUrlHost(request), param_querystring));
                                        Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "Confirma tu mail y actívate como Consultora Online", cadena, true, "Consultora Online Belcorp"); //R2442 Cambiando remitente
                                        message += "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
                                    }
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                                    message += ex.Message;//"- Ha ocurrido un error en el envío del correo de verificación.";
                                }

                            }
                            UserData().CambioClave = 1;
                            UserData().EMail = sEmail;
                            UserData().Telefono = sTelefono;
                            UserData().Celular = sCelular;

                            ViewBag.AppErrorMessage = message;

                            return View("InscripcionCompleta");
                        }
                    }


                }
                catch (Exception e)
                {

                }
                return View(consultoraAfiliar);
            }

            return View(consultoraAfiliar);

        }

        public ActionResult EnviaCorreo()
        {
            string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
            if (!strpaises.Contains(UserData().CodigoISO))
                return RedirectToAction("Index", "Bienvenida");

            var consultoraAfiliar = DatoUsuario();

            try
            {
                if (!consultoraAfiliar.EmailActivo)
                {
                    string[] parametros = new string[] { UserData().CodigoUsuario, UserData().PaisID.ToString(), UserData().CodigoISO, UserData().EMail };
                    string param_querystring = Util.EncriptarQueryString(parametros);
                    HttpRequestBase request = this.HttpContext.Request;

                    string cadena = mensajeConsultora(UserData().PrimerNombre, String.Format("{0}ConsultoraOnline/AtenderCorreo?tipo=Afiliar&data={1}", Util.GetUrlHost(request), param_querystring));
                    Util.EnviarMail("no-responder@somosbelcorp.com", UserData().EMail, "Confirma tu mail y actívate como Consultora Online", cadena, true, "Consultora Online Belcorp");

                    return View("InscripcionCompleta");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                    ServiceSAC.BEAfiliaClienteConsultora beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(UserData().PaisID, UserData().CodigoConsultora);
                    consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;
                }

                if (consultoraAfiliar.Afiliado)
                    return RedirectToAction("Index", "ConsultoraOnline");


                string result = string.Empty;
                bool HasSuccess = false;
                if (data != null)
                {
                    //Formato que envia la url: CodigoUsuario;IdPais
                    string[] query = Util.DesencriptarQueryString(data).Split(';');

                    using (UsuarioServiceClient srv = new UsuarioServiceClient())
                    {
                        HasSuccess = srv.ActiveEmail(Convert.ToInt32(query[1]), query[0], query[2], query[3]);
                    }
                    if (HasSuccess)
                        result = "|Su dirección de correo electrónico ha sido activada correctamente.\n";
                    else
                        result = "|Esta dirección de correo electrónico ya ha sido activada.\n";
                }
                else
                    result = "|El correo electrónico ya habia sido activado.\n";

                ClienteContactaConsultoraModel ConsultoraAfiliar = DatoUsuario();
                HasSuccess = true;

                string emailConsultora = UserData().EMail;
                if (String.IsNullOrEmpty(ConsultoraAfiliar.Email.Trim()) || ConsultoraAfiliar.EmailActivo == false)
                {
                    result += "|No tiene email activo.";
                    HasSuccess = false;
                }

                if (ConsultoraAfiliar.EsPrimeraVez)
                {
                    using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                    {
                        sc.InsAfiliaClienteConsultora(UserData().PaisID, ConsultoraAfiliar.ConsultoraID);
                    }

                }
                else
                {
                    using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                    {
                        sc.UpdAfiliaClienteConsultora(UserData().PaisID, ConsultoraAfiliar.ConsultoraID, true);
                    }
                }

                try
                {
                    if (HasSuccess)
                    {
                        UsuarioModel Consultora = UserData();
                        HttpRequestBase request = this.HttpContext.Request;
                        string cadena = mensajeAfiliacion(Consultora.PrimerNombre, Util.GetUrlHost(request).ToString());
                        Util.EnviarMail("no-responder@somosbelcorp.com", Consultora.EMail, "¡Felicitaciones, ya eres una Consultora Online!", cadena, true, "Consultora Online Belcorp");
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return RedirectToAction("Index", "ConsultoraOnline", new { activation = "successful", utm_source = "Transaccional", utm_medium = "email", utm_content = "Confirmacion_email", utm_campaign = "ConsultoraOnline" });
        }

        [HttpPost]
        public JsonResult Desafiliar(long ConsultoraID, int OpcionDesafiliacion)
        {
            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
            {
                sc.UpdDesafiliaClienteConsultora(UserData().PaisID, ConsultoraID, false, OpcionDesafiliacion);

                var data = new
                {
                    success = true
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public string mensajeConsultora(string consultora, string url)
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
            mensaje.AppendLine("Sólo falta un paso para activarte como <span style=\"font-weight:bold;\">Consultora Online.</span>  ");
            //gr-1250
            mensaje.AppendLine("Pronto tus clientes podrán encontrarte en el App de Catálogos y en las páginas web de las marcas");
            mensaje.AppendLine("¡No pierdas la oportunidad de conseguir nuevos pedidos y nuevos ");
            mensaje.AppendLine("clientes! Para finalizar la activación haz Click en el botón.");
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
            mensaje.AppendLine("¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
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
            //gr-1250
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"682\" height=\"161\" alt=\"Ahora tu nombre estar&#225; disponible en el App de Cat&#225;logos &#201;sika, L’bel y Cyzone y en las en la p&#225;gina web de nuestras marcas y nuevos clientes podr&#225;n contactarse.\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_11.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"47\" height=\"778\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_06.png", string.Empty)));
            mensaje.AppendLine("<td colspan=\"4\"> <!-- INICIO DE BORRADO ");
            mensaje.AppendLine(String.Format("<a href=\"{0}ConsultoraOnline/AtenderCorreo?tipo=MiPerfil\" target=\"_blank\">", contextoBase));
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"132\" border=\"0\" alt=\"Actualuza tu perfil\"></a> --> </td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_13.png", string.Empty)));
            mensaje.AppendLine("<td rowspan=\"9\">");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"35\" height=\"778\" alt=\"\"></td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_08.png", string.Empty)));
            mensaje.AppendLine("</tr>");
            mensaje.AppendLine("<tr>");
            mensaje.AppendLine("<td colspan=\"4\"> <!-- INICIO DE BORRADO ");
            mensaje.AppendLine(String.Format("<img src=\"{0}\" width=\"600\" height=\"65\" alt=\"\"> --> </td>", ConfigS3.GetUrlFileS3(carpetaPais, "4-Mailing_09.png", string.Empty)));
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
            mensaje.AppendLine("¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>    ");
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
            MisPedidosModel modelPaginado = new MisPedidosModel();
            modelPaginado.ListaPedidos = listPedidos;
            return (modelPaginado);
        }

        public ActionResult MisPedidos(string Pagina)
        {

            ViewBag.ConsultoraID = UserData().ConsultoraID;
            ViewBag.NombreConsultora = UserData().PrimerNombre;
            ViewBag.Simbolo = UserData().Simbolo;

            List<BEMisPedidos> olstMisPedidos = new List<BEMisPedidos>();
            MisPedidosModel model = new MisPedidosModel();

            int pagAeux;
            if (Pagina != null)
                if (int.TryParse(Pagina, out pagAeux))
                    Pagina = (int.Parse(Pagina) - 1).ToString();

            if (Pagina == null)
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    olstMisPedidos = sv.GetNotificacionesConsultoraOnline(UserData().PaisID, UserData().ConsultoraID).ToList();
                }
                model.ListaPedidos = olstMisPedidos;

                objMisPedidos = model;
                Session["objMisPedidos"] = objMisPedidos;
                indiceUltimaPagina = objMisPedidos.ListaPedidos.Count / registrosPagina;
                if (objMisPedidos.ListaPedidos.Count % registrosPagina == 0) indiceUltimaPagina--;
                TempData["indiceActualPagina"] = indiceActualPagina;
                TempData["indiceUltimaPagina"] = indiceUltimaPagina;
            }
            else
            {
                objMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
                indiceActualPagina = (int)TempData["indiceActualPagina"];
                indiceUltimaPagina = (int)TempData["indiceUltimaPagina"];
                if (Pagina.Equals("<<")) indiceActualPagina = 0;
                else
                {
                    if (Pagina.Equals("<"))
                    {
                        if (indiceActualPagina > 0) indiceActualPagina--;
                    }
                    else
                    {
                        if (Pagina.Equals(">"))
                        {
                            if (indiceActualPagina < indiceUltimaPagina) indiceActualPagina++;
                        }
                        else
                        {
                            if (Pagina.Equals(">>")) indiceActualPagina = indiceUltimaPagina;
                            else
                            {
                                indiceActualPagina = int.Parse(Pagina);
                            }
                        }
                    }
                }
                TempData["indiceUltimaPagina"] = indiceUltimaPagina;
                TempData["indiceActualPagina"] = indiceActualPagina;
            }


            ViewBag.CantidadPedidos = objMisPedidos.ListaPedidos.Where(p => String.IsNullOrEmpty(p.Estado)).Count();

            return View(mostrarPagina());
        }

        public ActionResult ObtenerPagina(string Pagina)
        {
            ViewBag.Simbolo = UserData().Simbolo;
            objMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
            ViewBag.CantidadPedidos = objMisPedidos.ListaPedidos.Where(p => string.IsNullOrEmpty(p.Estado)).Count();
            indiceActualPagina = (int)TempData["indiceActualPagina"];
            indiceUltimaPagina = (int)TempData["indiceUltimaPagina"];
            if (Pagina.Equals("<<")) indiceActualPagina = 0;
            else
            {
                if (Pagina.Equals("<"))
                {
                    if (indiceActualPagina > 0) indiceActualPagina--;
                }
                else
                {
                    if (Pagina.Equals(">"))
                    {
                        if (indiceActualPagina < indiceUltimaPagina) indiceActualPagina++;
                    }
                    else
                    {
                        if (Pagina.Equals(">>")) indiceActualPagina = indiceUltimaPagina;
                        else
                        {
                            int pagAeux;
                            if (Pagina != null)
                                if (int.TryParse(Pagina, out pagAeux))
                                    Pagina = (int.Parse(Pagina) - 1).ToString();
                            indiceActualPagina = int.Parse(Pagina);
                        }
                    }
                }
            }
            TempData["indiceUltimaPagina"] = indiceUltimaPagina;
            TempData["indiceActualPagina"] = indiceActualPagina;


            return PartialView("_ListaPedidos", mostrarPagina());
        }

        public ActionResult AceptarPedido(string id)
        {
            MisPedidosModel consultoraOnlineMisPedidos = new MisPedidosModel();
            consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
            BEMisPedidos pedido = new BEMisPedidos();
            long pedidoId = long.Parse(id);
            pedido = consultoraOnlineMisPedidos.ListaPedidos.Where(p => p.PedidoId == pedidoId).FirstOrDefault();
            ViewBag.Simbolo = UserData().Simbolo;

            string marcaPedido = pedido.DetallePedido.Count() > 0 ? pedido.DetallePedido[0].Marca : "";

            #region AceptarPedido

            int paisId = UserData().PaisID;
            string MensajeaCliente = "Gracias por haberme escogido como tu Consultora. Me pondré en contacto contigo para coordinar la hora y lugar de entrega.";
            try
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    ServiceSAC.BESolicitudCliente beSolicitudCliente = new ServiceSAC.BESolicitudCliente();
                    beSolicitudCliente.SolicitudClienteID = pedidoId;
                    beSolicitudCliente.CodigoConsultora = UserData().ConsultoraID.ToString();
                    beSolicitudCliente.MensajeaCliente = MensajeaCliente;
                    beSolicitudCliente.UsuarioModificacion = UserData().CodigoUsuario;
                    beSolicitudCliente.Estado = "A";
                    sc.UpdSolicitudCliente(paisId, beSolicitudCliente);
                }

                List<BEMisPedidos> refresh = new List<BEMisPedidos>();
                foreach (BEMisPedidos item in consultoraOnlineMisPedidos.ListaPedidos)
                {
                    if (item.PedidoId == int.Parse(id))
                    {
                        item.Estado = "A";
                        item.FechaModificacion = DateTime.Now;
                    }
                    refresh.Add(item);
                }
                MisPedidosModel refreshMisPedidos = new MisPedidosModel();
                refreshMisPedidos.ListaPedidos = refresh;
                Session["objMisPedidos"] = refreshMisPedidos;

                using (ServiceCliente.ClienteServiceClient sc = new ServiceCliente.ClienteServiceClient())
                {
                    ServiceCliente.BECliente beCliente = new ServiceCliente.BECliente();
                    beCliente.ConsultoraID = pedidoId;
                    beCliente.eMail = pedido.Email;//emailCliente;
                    beCliente.Nombre = pedido.Cliente;// NombreCliente;
                    beCliente.PaisID = UserData().PaisID;
                    beCliente.Activo = true;
                    sc.Insert(beCliente);

                }

                //R2548 - CS
                String titulo = "(" + UserData().CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(marcaPedido); //Marca
                StringBuilder mensaje = new StringBuilder();
                mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(pedido.Cliente));
                mensaje.AppendFormat("{0}</p><br/>", MensajeaCliente);
                mensaje.Append("<br/>Saludos,<br/><br />");
                mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                mensaje.AppendFormat("<td><p style='text-align: center;'><strong>{0}<br/>Consultora</strong></p></td></tr></table>", UserData().NombreConsultora);
                try
                {
                    Common.Util.EnviarMail3(UserData().EMail, pedido.Email, titulo, mensaje.ToString(), true, string.Empty);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                }
            }
            catch (FaultException e)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(e, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            #endregion

            return PartialView("_PedidoCliente", pedido);
        }

        public JsonResult RechazarPedido(long SolicitudId, int NumIteracion, string CodigoUbigeo, string Campania, int MarcaId, int OpcionRechazo, string RazonMotivoRechazo)
        {
            UsuarioModel Consultora = UserData();

            int PaisId = Consultora.PaisID;
            int numIteracionMaximo = 3;
            DateTime fechaActual = DateTime.Now;
            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                MisPedidosModel consultoraOnlineMisPedidos = new MisPedidosModel();
                consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatosMail = sv.GetTablaLogicaDatos(PaisId, 57);
                String emailOculto = tablalogicaDatosMail.First(x => x.TablaLogicaDatosID == 5701).Descripcion;
                ServiceSAC.BETablaLogicaDatos[] tablalogicaDatos = sv.GetTablaLogicaDatos(PaisId, 56);
                numIteracionMaximo = Convert.ToInt32(tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5601).Codigo);
                String horas = tablalogicaDatos.First(x => x.TablaLogicaDatosID == 5603).Codigo;//2442
                if (NumIteracion == numIteracionMaximo)
                {
                    sv.RechazarSolicitudCliente(PaisId, SolicitudId, true, OpcionRechazo, RazonMotivoRechazo);
                }
                else
                {
                    try
                    {
                        ServiceSAC.BESolicitudNuevaConsultora nuevaConsultora = sv.ReasignarSolicitudCliente(PaisId, SolicitudId, CodigoUbigeo, Campania, MarcaId, OpcionRechazo, RazonMotivoRechazo); //new ServiceSAC.BESolicitudNuevaConsultora();//
                        if (nuevaConsultora != null)
                        {
                            ServiceSAC.BESolicitudCliente beSolicitudCliente = sv.GetSolicitudCliente(PaisId, SolicitudId);
                            fechaActual = beSolicitudCliente.FechaModificacion;

                            HttpRequestBase request = this.HttpContext.Request;
                            try
                            {
                                string mensaje = mensajeRechazoPedido(nuevaConsultora.Nombre, Util.GetUrlHost(request).ToString(), beSolicitudCliente);
                                Common.Util.EnviarMail("no-responder@somosbelcorp.com", nuevaConsultora.Email, "Un nuevo cliente te eligió como Consultora Online", mensaje, true, "Consultora Online Belcorp"); //R2442 Cambiando remitente
                            }
                            catch (Exception ex)
                            {
                                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                            MisPedidosModel refreshMisPedidos = new MisPedidosModel();
                            refreshMisPedidos.ListaPedidos = refresh;
                            Session["objMisPedidos"] = refreshMisPedidos;
                        }
                    }
                    catch (FaultException ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                        var dataError = new
                        {
                            success = false,
                            message = "Ocurrio un Error al momento de rechazar el Pedido"
                        };

                        return Json(dataError, JsonRequestBehavior.AllowGet);
                    }
                }
            }

            var data = new
            {
                success = true,
                message = String.Format("El día {0} a las {1}", fechaActual.ToString("dd/MM"), fechaActual.ToString("hh:mm tt"))
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CancelarPedido(long SolicitudId, int OpcionCancelado, string RazonMotivoCancelado)
        {
            int PaisId = UserData().PaisID;
            DateTime fechaActual = DateTime.Now;
            try
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    MisPedidosModel consultoraOnlineMisPedidos = new MisPedidosModel();
                    consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];

                    sc.CancelarSolicitudCliente(PaisId, SolicitudId, OpcionCancelado, RazonMotivoCancelado);
                    ServiceSAC.BESolicitudCliente beSolicitudCliente = sc.GetSolicitudCliente(PaisId, SolicitudId);
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
                    MisPedidosModel refreshMisPedidos = new MisPedidosModel();
                    refreshMisPedidos.ListaPedidos = refresh;
                    Session["objMisPedidos"] = refreshMisPedidos;

                }
            }
            catch (Exception ex)
            {
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
                message = String.Format("El día {0} a las {1}", fechaActual.ToString("dd/MM"), fechaActual.ToString("hh:mm tt"))
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public string mensajeRechazoPedido(string consultora, string contextoBase, Portal.Consultoras.Web.ServiceSAC.BESolicitudCliente SolicitudCliente)
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
            mensaje.AppendLine("                ¿No deseas recibir correos electrónicos de Belcorp? <a href=\"#\" target=\"_blank\">Cancela tu suscripción aquí</a>");
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
            var consultoraAfiliar = new ClienteContactaConsultoraModel();
            consultoraAfiliar.NombreConsultora = UserData().PrimerNombre;

            string emailConsultora = UserData().EMail;

            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
            {
                ServiceSAC.BEAfiliaClienteConsultora beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(UserData().PaisID, UserData().CodigoConsultora);

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
                        return RedirectToAction("MiPerfil", "ConsultoraOnline", new { area = "Mobile", utm_source = "Transaccional", utm_medium = "email", utm_content = "Bienvenida_verPerfil", utm_campaign = "ConsultoraOnline" });
                    else
                        return RedirectToAction("MiPerfil", "ConsultoraOnline", new { utm_source = "Transaccional", utm_medium = "email", utm_content = "Bienvenida_verPerfil", utm_campaign = "ConsultoraOnline" });
                case "MISPEDIDOS":
                    if (esMovil)
                        return RedirectToAction("MisPedidos", "ConsultoraOnline", new { area = "Mobile", utm_source = "Transaccional", utm_medium = "email", utm_content = "Bienvenida_verPedidos", utm_campaign = "ConsultoraOnline" });
                    else
                        return RedirectToAction("MisPedidos", "ConsultoraOnline", new { utm_source = "Transaccional", utm_medium = "email", utm_content = "Bienvenida_verPedidos", utm_campaign = "ConsultoraOnline" });
                case "CONSULTORAONLINE":
                    if (esMovil)
                        return RedirectToAction("Index", "ConsultoraOnline", new { area = "Mobile", utm_source = "Transaccional", utm_medium = "email", utm_content = "Bienvenida_irConsultoraOnline", utm_campaign = "ConsultoraOnline" });
                    else
                        return RedirectToAction("Index", "ConsultoraOnline", new { utm_source = "Transaccional", utm_medium = "email", utm_content = "Bienvenida_irConsultoraOnline", utm_campaign = "ConsultoraOnline" });
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
    }
}
