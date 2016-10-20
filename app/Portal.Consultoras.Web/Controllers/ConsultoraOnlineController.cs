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
using System.Globalization;

using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultoraOnlineController : BaseController
    {
        #region Configuracion de Paginado
        MisPedidosModel objMisPedidos;
        int registrosPagina = 5;
        int indiceActualPagina = 0;
        int indiceUltimaPagina;
        bool isEsika = false;
        #endregion

        public ConsultoraOnlineController()
        {
            this.registrosPagina = 5;

            if (System.Configuration.ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO))
            {
                isEsika = true;
            }
        }
        ~ConsultoraOnlineController()
        {
            Session["objMisPedidos"] = null;
            Session["objMisPedidosDetalle"] = null;
            Session["objMisPedidosDetalleVal"] = null;
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

                        result = sv.UpdateDatosPrimeraVez(UserData().PaisID, UserData().CodigoUsuario, model.Email, model.Telefono, "", model.Celular, model.CorreoAnterior, model.AceptoContrato);

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
                    olstMisPedidos = sv.GetMisPedidosConsultoraOnline(UserData().PaisID, UserData().ConsultoraID, UserData().CampaniaID).ToList();
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


        [HttpPost]
        public JsonResult CargarMisPedidos(string sidx, string sord, int page, int rows)
        {
            try
            {
                List<BEMisPedidos> olstMisPedidos = new List<BEMisPedidos>();
                MisPedidosModel model = new MisPedidosModel();

                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    olstMisPedidos = svc.GetMisPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID, userData.CampaniaID).ToList();
                }

                if (olstMisPedidos.Count > 0)
                {
                    olstMisPedidos.RemoveAll(x => x.Estado.Trim().Length > 0);  // solo pendientes

                    if (olstMisPedidos.Count > 0)
                    {
                        olstMisPedidos.ToList().ForEach(y => y.FormartoFechaSolicitud = y.FechaSolicitud.ToString("dd") + " de " + y.FechaSolicitud.ToString("MMMM", new CultureInfo("es-ES")));
                        olstMisPedidos.ToList().ForEach(y => y.FormatoPrecioTotal = Util.DecimalToStringFormat(y.PrecioTotal, userData.CodigoISO));

                        model.ListaPedidos = olstMisPedidos;

                        objMisPedidos = model;
                        Session["objMisPedidos"] = objMisPedidos;

                        var lstClientesExistentes = olstMisPedidos.Where(x => x.FlagConsultora == true).ToList();

                        if (lstClientesExistentes.Count == olstMisPedidos.Count)
                        {
                            model.FechaPedidoReciente = "24:00:00";
                        }
                        else
                        {
                            var pedidoReciente = olstMisPedidos.Where(x => x.FlagConsultora == false).OrderBy(x => x.FechaSolicitud).First();
                            //TimeSpan ts = DateTime.Now - pedidoReciente.FechaSolicitud;
                            //model.FechaPedidoReciente = (24 - ts.Hours).ToString() + ":" + (60 - ts.Minutes).ToString() + ":" + "00";

                            DateTime starDate = DateTime.Now;
                            DateTime endDate = pedidoReciente.FechaSolicitud.AddDays(1);

                            // Difference in days, hours, and minutes.
                            TimeSpan ts = endDate - starDate;
                            model.FechaPedidoReciente = ts.Hours.ToString().PadLeft(2,'0') + ":" + ts.Minutes.ToString().PadLeft(2,'0') + ":" + ts.Seconds.ToString().PadLeft(2,'0');

                        }

                        BEGrid grid = SetGrid(sidx, sord, page, rows);
                        BEPager pag = Util.PaginadorGenerico(grid, model.ListaPedidos);

                        model.ListaPedidos = model.ListaPedidos.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();

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
                List<BEMisPedidosDetalle> olstMisPedidosDet = new List<BEMisPedidosDetalle>();
                MisPedidosDetalleModel model = new MisPedidosDetalleModel();
                
                using (UsuarioServiceClient svc = new UsuarioServiceClient())
                {
                    olstMisPedidosDet = svc.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, pedidoId).ToList();
                }

                if (olstMisPedidosDet.Count > 0)
                {
                    MisPedidosModel consultoraOnlineMisPedidos = new MisPedidosModel();
                    consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
                    BEMisPedidos pedido = new BEMisPedidos();
                    long _pedidoId = Convert.ToInt64(pedidoId);
                    pedido = consultoraOnlineMisPedidos.ListaPedidos.Where(p => p.PedidoId == _pedidoId).FirstOrDefault();

                    //olstMisPedidosDet.ToList().ForEach(x => x.TieneStock = 0);
                    //olstMisPedidosDet.ToList().ForEach(x => x.EstaEnRevista = 0);

                    Session["objMisPedidosDetalle"] = olstMisPedidosDet;

                    // 0=App Catalogos, >0=Portal Marca
                    if (pedido.MarcaID == 0)    
                    {
                        int? revistaGana = null;
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            revistaGana = sv.ValidarDesactivaRevistaGana(userData.PaisID, userData.CampaniaID, userData.CodigoZona);
                        }

                        string inputCUV = "";
                        foreach (var item in olstMisPedidosDet)
                        {
                            inputCUV += item.CUV + ",";
                        }

                        inputCUV = inputCUV.Substring(0, inputCUV.Length - 1);
                        List<BEProducto> olstMisProductos = new List<BEProducto>();

                        using (ODSServiceClient svc = new ODSServiceClient())
                        {
                            olstMisProductos = svc.GetValidarCUVMisPedidos(userData.PaisID, userData.CampaniaID, inputCUV, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona).ToList();
                        }

                        Session["objMisPedidosDetalleVal"] = olstMisProductos;

                        foreach (var item in olstMisPedidosDet)
                        {
                            var pedidoVal = olstMisProductos.Where(x => x.CUV == item.CUV).FirstOrDefault();
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
                                    if (isEsika)
                                    {
                                        item.MensajeValidacion = "Producto en la Guía de Negocio Ésika con oferta especial.";
                                    }
                                    else
                                    {
                                        item.MensajeValidacion = "Producto en la revista Somos Belcorp con oferta especial.";
                                    }
                                }
                            }
                            else
                            {
                                item.TieneStock = 0;
                                item.MensajeValidacion = "El producto solicitado no existe";
                            }
                            
                        }// foreach
                    }

                    model.ListaDetalle = olstMisPedidosDet;

                    BEGrid grid = SetGrid(sidx, sord, page, rows);
                    BEPager pag = Util.PaginadorGenerico(grid, model.ListaDetalle);

                    model.ListaDetalle = model.ListaDetalle.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();

                    model.Registros = grid.PageSize.ToString();
                    model.RegistrosTotal = pag.RecordCount.ToString();
                    model.Pagina = pag.CurrentPage.ToString();
                    model.PaginaDe = pag.PageCount.ToString();
                }
                else
                {
                    //PedidoModelo.Registros = "0";
                    //PedidoModelo.RegistrosDe = "0";
                    model.RegistrosTotal = "0";
                    model.Pagina = "0";
                    model.PaginaDe = "0";
                }

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

        //public ActionResult AceptarPedido(string id)
        //{
        //    MisPedidosModel consultoraOnlineMisPedidos = new MisPedidosModel();
        //    consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
        //    BEMisPedidos pedido = new BEMisPedidos();
        //    long pedidoId = long.Parse(id);
        //    pedido = consultoraOnlineMisPedidos.ListaPedidos.Where(p => p.PedidoId == pedidoId).FirstOrDefault();
        //    ViewBag.Simbolo = UserData().Simbolo;

        //    string marcaPedido = pedido.DetallePedido.Count() > 0 ? pedido.DetallePedido[0].Marca : "";

        //    #region AceptarPedido

        //    int paisId = UserData().PaisID;
        //    string MensajeaCliente = "Gracias por haberme escogido como tu Consultora. Me pondré en contacto contigo para coordinar la hora y lugar de entrega.";
        //    try
        //    {
        //        using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
        //        {
        //            ServiceSAC.BESolicitudCliente beSolicitudCliente = new ServiceSAC.BESolicitudCliente();
        //            beSolicitudCliente.SolicitudClienteID = pedidoId;
        //            beSolicitudCliente.CodigoConsultora = UserData().ConsultoraID.ToString();
        //            beSolicitudCliente.MensajeaCliente = MensajeaCliente;
        //            beSolicitudCliente.UsuarioModificacion = UserData().CodigoUsuario;
        //            beSolicitudCliente.Estado = "A";
        //            sc.UpdSolicitudCliente(paisId, beSolicitudCliente);
        //        }

        //        List<BEMisPedidos> refresh = new List<BEMisPedidos>();
        //        foreach (BEMisPedidos item in consultoraOnlineMisPedidos.ListaPedidos)
        //        {
        //            if (item.PedidoId == int.Parse(id))
        //            {
        //                item.Estado = "A";
        //                item.FechaModificacion = DateTime.Now;
        //            }
        //            refresh.Add(item);
        //        }
        //        MisPedidosModel refreshMisPedidos = new MisPedidosModel();
        //        refreshMisPedidos.ListaPedidos = refresh;
        //        Session["objMisPedidos"] = refreshMisPedidos;

        //        using (ServiceCliente.ClienteServiceClient sc = new ServiceCliente.ClienteServiceClient())
        //        {
        //            ServiceCliente.BECliente beCliente = new ServiceCliente.BECliente();
        //            beCliente.ConsultoraID = pedidoId;
        //            beCliente.eMail = pedido.Email;//emailCliente;
        //            beCliente.Nombre = pedido.Cliente;// NombreCliente;
        //            beCliente.PaisID = UserData().PaisID;
        //            beCliente.Activo = true;
        //            sc.Insert(beCliente);

        //        }

        //        //R2548 - CS
        //        String titulo = "(" + UserData().CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(marcaPedido); //Marca
        //        StringBuilder mensaje = new StringBuilder();
        //        mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(pedido.Cliente));
        //        mensaje.AppendFormat("{0}</p><br/>", MensajeaCliente);
        //        mensaje.Append("<br/>Saludos,<br/><br />");
        //        mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
        //        mensaje.AppendFormat("<td><p style='text-align: center;'><strong>{0}<br/>Consultora</strong></p></td></tr></table>", UserData().NombreConsultora);
        //        try
        //        {
        //            Common.Util.EnviarMail3(UserData().EMail, pedido.Email, titulo, mensaje.ToString(), true, string.Empty);
        //        }
        //        catch (Exception ex)
        //        {
        //            LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
        //        }
        //    }
        //    catch (FaultException e)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(e, UserData().CodigoConsultora, UserData().CodigoISO);
        //    }

        //    #endregion

        //    return PartialView("_PedidoCliente", pedido);
        //}

        [HttpPost]
        public JsonResult AceptarPedido(string pedidoId, MisPedidosModel pedidoModel, string typeAction = null)
        {
            MisPedidosModel consultoraOnlineMisPedidos = new MisPedidosModel();
            consultoraOnlineMisPedidos = (MisPedidosModel)Session["objMisPedidos"];
            BEMisPedidos pedido = new BEMisPedidos();
            long _pedidoId = long.Parse(pedidoId);
            pedido = consultoraOnlineMisPedidos.ListaPedidos.Where(p => p.PedidoId == _pedidoId).FirstOrDefault();

            // set detalles del pedido
            List<BEMisPedidosDetalle> olstMisPedidosDet = new List<BEMisPedidosDetalle>();
            olstMisPedidosDet = (List<BEMisPedidosDetalle>)Session["objMisPedidosDetalle"];
            pedido.DetallePedido = olstMisPedidosDet.Where(x => x.PedidoId == pedido.PedidoId).ToArray();

            //ViewBag.Simbolo = UserData().Simbolo;
            //string marcaPedido = pedido.DetallePedido.Count() > 0 ? pedido.DetallePedido[0].Marca : "";

            int tipo;
            string marcaPedido;

            // 0=App Catalogos, >0=Portal Marca
            if (pedido.MarcaID == 0)        
            {
                tipo = 1;
                marcaPedido = pedido.MedioContacto;
            }
            else
            {
                tipo = 2;
                marcaPedido = pedido.Marca;
            }
           
            #region AceptarPedido

            int paisId = userData.PaisID;
            string mensajeaCliente = string.Format("Gracias por haber escogido a {0} como tu Consultora. Pronto se pondrá en contacto contigo para coordinar la hora y lugar de entrega.", userData.NombreConsultora);

            try
            {
                using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                {
                    ServiceSAC.BESolicitudCliente beSolicitudCliente = new ServiceSAC.BESolicitudCliente();
                    beSolicitudCliente.SolicitudClienteID = _pedidoId;
                    beSolicitudCliente.CodigoConsultora = UserData().ConsultoraID.ToString();
                    beSolicitudCliente.MensajeaCliente = mensajeaCliente;
                    beSolicitudCliente.UsuarioModificacion = UserData().CodigoUsuario;
                    beSolicitudCliente.Estado = "A";
                    svc.UpdSolicitudCliente(paisId, beSolicitudCliente);
                }

                List<BEMisPedidos> refresh = new List<BEMisPedidos>();
                foreach (BEMisPedidos item in consultoraOnlineMisPedidos.ListaPedidos)
                {
                    if (item.PedidoId == _pedidoId)
                    {
                        item.Estado = "A";
                        item.FechaModificacion = DateTime.Now;
                    }
                    refresh.Add(item);
                }

                MisPedidosModel refreshMisPedidos = new MisPedidosModel();
                refreshMisPedidos.ListaPedidos = refresh;
                Session["objMisPedidos"] = refreshMisPedidos;

                string clienteId = string.Empty;

                using (ServiceCliente.ClienteServiceClient svc = new ServiceCliente.ClienteServiceClient())
                {
                    int vValidation = svc.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, pedido.Cliente);

                    if (vValidation == 0)
                    {
                        ServiceCliente.BECliente beCliente = new ServiceCliente.BECliente();
                        beCliente.ConsultoraID = UserData().ConsultoraID;
                        beCliente.eMail = pedido.Email;//emailCliente;
                        beCliente.Nombre = pedido.Cliente;// NombreCliente;
                        beCliente.PaisID = UserData().PaisID;
                        beCliente.Activo = true;
                        //clienteId = beCliente.ClienteID;
                        clienteId = svc.Insert(beCliente).ToString();
                    }
                    else
                    {
                        var _cliente = svc.SelectByNombre(userData.PaisID, userData.ConsultoraID, pedido.Cliente).First();
                        clienteId = _cliente.ClienteID.ToString();
                    }
                }

                if (tipo == 1)  // solo para App Catalogos
                {
                    List<BEProducto> olstMisProductos = new List<BEProducto>();
                    olstMisProductos = (List<BEProducto>)Session["objMisPedidosDetalleVal"];

                    List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
                    BEPedidoWebDetalle bePedidoWebDetalle;

                    int contOk = 0;

                    foreach (var item in pedidoModel.ListaDetalleModel)
                    {
                        if (item.OpcionAcepta == "ingrped") // ingresa al pedido
                        {
                            BEMisPedidosDetalle pedidoDetalle = olstMisPedidosDet.Where(x => x.PedidoDetalleId == item.PedidoDetalleId).FirstOrDefault();

                            if (pedidoDetalle != null)
                            {
                                BEProducto productoVal = olstMisProductos.Where(x => x.CUV == pedidoDetalle.CUV).FirstOrDefault();

                                if (productoVal != null)
                                {
                                    PedidoSb2Model model = new PedidoSb2Model();

                                    model.TipoOfertaSisID = productoVal.TipoOfertaSisID;
                                    model.ConfiguracionOfertaID = productoVal.ConfiguracionOfertaID;
                                    model.ClienteID = clienteId;
                                    model.OfertaWeb = false;
                                    model.IndicadorMontoMinimo = productoVal.IndicadorMontoMinimo.ToString();
                                    model.EsSugerido = false;
                                    model.EsKitNueva = false;
                                    //model.MarcaID = pedido.MarcaID;
                                    model.MarcaID = pedidoDetalle.MarcaID;
                                    model.Cantidad = pedidoDetalle.Cantidad.ToString();
                                    model.PrecioUnidad = Convert.ToDecimal(pedidoDetalle.PrecioUnitario);
                                    model.CUV = pedidoDetalle.CUV;
                                    model.DescripcionProd = pedidoDetalle.Producto;
                                    model.ClienteDescripcion = pedido.Cliente;
                                    //model.OrigenPedidoWeb = 1281;
                                    model.OrigenPedidoWeb = 0;

                                    // ADD / UPDATE Detalle de Pedido
                                    olstPedidoWebDetalle = AgregarDetallePedido(model);

                                    if (olstPedidoWebDetalle != null)
                                    {
                                        using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                                        {
                                            bePedidoWebDetalle = olstPedidoWebDetalle.Where( x => x.CUV == pedidoDetalle.CUV && x.MarcaID == pedidoDetalle.MarcaID && x.ClienteID == Convert.ToInt16(clienteId) ).FirstOrDefault();

                                            if (bePedidoWebDetalle != null)
                                            {
                                                ServiceSAC.BESolicitudClienteDetalle beSolicitudDetalle = new ServiceSAC.BESolicitudClienteDetalle();
                                                beSolicitudDetalle.SolicitudClienteDetalleID = item.PedidoDetalleId;
                                                beSolicitudDetalle.TipoAtencion = 1;
                                                beSolicitudDetalle.PedidoWebID = bePedidoWebDetalle.PedidoID;
                                                beSolicitudDetalle.PedidoWebDetalleID = bePedidoWebDetalle.PedidoDetalleID;

                                                // UPDATE Detalle Solicitud
                                                svc.UpdSolicitudClienteDetalle(UserData().PaisID, beSolicitudDetalle);
                                            }
                                        }
                                        contOk++;
                                    }
                                }
                            }
                        }// ingrped
                        else
                        {
                            using (ServiceSAC.SACServiceClient svc = new ServiceSAC.SACServiceClient())
                            {
                                ServiceSAC.BESolicitudClienteDetalle beSolicitudDetalle = new ServiceSAC.BESolicitudClienteDetalle();
                                beSolicitudDetalle.SolicitudClienteDetalleID = item.PedidoDetalleId;
                                beSolicitudDetalle.TipoAtencion = (item.OpcionAcepta == "ingrten") ? 2 : 0;     // ya lo tengo, agotado
                                beSolicitudDetalle.PedidoWebID = 0;
                                beSolicitudDetalle.PedidoWebDetalleID = 0;

                                // UPDATE Detalle Solicitud
                                svc.UpdSolicitudClienteDetalle(UserData().PaisID, beSolicitudDetalle);
                            }
                        }

                    }// foreach
                }

                Session["PedidoWebDetalle"] = null;
                string emailDe = ConfigurationManager.AppSettings["ConsultoraOnlineEmailDe"];

                //Inicio GR-1385
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
                        if (typeAction == "1")  // desktop
                        {
                            Common.Util.EnviarMail3(emailDe, pedido.Email, titulocliente, mensajecliente.ToString(), true, pedido.Email);
                        }
                        else
                        {
                            Common.Util.EnviarMail3Mobile(emailDe, pedido.Email, titulocliente, mensajecliente.ToString(), true, pedido.Email);
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                    }
                }
                else
                {
                    //R2548 - CS
                    String titulo = "(" + UserData().CodigoISO + ") Consultora que atenderá tu pedido de " + HttpUtility.HtmlDecode(marcaPedido); //Marca
                    StringBuilder mensaje = new StringBuilder();
                    mensaje.AppendFormat("<p>Hola {0},</br><br /><br />", HttpUtility.HtmlDecode(pedido.Cliente));
                    mensaje.AppendFormat("{0}</p><br/>", mensajeaCliente);
                    mensaje.Append("<br/>Saludos,<br/><br />");
                    mensaje.Append("<table><tr><td><img src=\"cid:{0}\" /></td>");
                    mensaje.AppendFormat("<td><p style='text-align: center;'><strong>{0}<br/>{1}<br/>Consultora</strong></p></td></tr></table>", userData.NombreConsultora, userData.EMail);

                    try
                    {
                        if (typeAction == "1")      // desktop
                        {
                            Common.Util.EnviarMail3(emailDe, pedido.Email, titulo, mensaje.ToString(), true, string.Empty);
                        }
                        else
                        {
                            Common.Util.EnviarMail3Mobile(emailDe, pedido.Email, titulo, mensaje.ToString(), true, string.Empty);
                        }
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
                    DataBarra = GetDataBarra()
                }, JsonRequestBehavior.AllowGet); 

                //Fín GR-1385
            }
            catch (FaultException e)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(e, UserData().CodigoConsultora, UserData().CodigoISO);

                return Json(new
                {
                    success = false,
                    message = e.Message
                }, JsonRequestBehavior.AllowGet); 
            }

            #endregion

            //return PartialView("_PedidoCliente", pedido);
        }

        private List<BEPedidoWebDetalle> AgregarDetallePedido(PedidoSb2Model model)
        {
            try
            {
                var userData = UserData();
                List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>(); 

                BEPedidoWebDetalle oBePedidoWebDetalle = new BEPedidoWebDetalle();
                oBePedidoWebDetalle.IPUsuario = userData.IPUsuario;
                oBePedidoWebDetalle.CampaniaID = userData.CampaniaID;
                oBePedidoWebDetalle.ConsultoraID = userData.ConsultoraID;
                oBePedidoWebDetalle.PaisID = userData.PaisID;
                oBePedidoWebDetalle.TipoOfertaSisID = model.TipoOfertaSisID;
                oBePedidoWebDetalle.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
                oBePedidoWebDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);
                oBePedidoWebDetalle.PedidoID = userData.PedidoID;
                oBePedidoWebDetalle.OfertaWeb = model.OfertaWeb;
                oBePedidoWebDetalle.IndicadorMontoMinimo = Convert.ToInt32(model.IndicadorMontoMinimo);
                oBePedidoWebDetalle.SubTipoOfertaSisID = 0;
                oBePedidoWebDetalle.EsSugerido = model.EsSugerido;
                oBePedidoWebDetalle.EsKitNueva = model.EsKitNueva;

                oBePedidoWebDetalle.MarcaID = Convert.ToByte(model.MarcaID);
                oBePedidoWebDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                oBePedidoWebDetalle.PrecioUnidad = model.PrecioUnidad;
                oBePedidoWebDetalle.CUV = model.CUV;
                oBePedidoWebDetalle.OrigenPedidoWeb = model.OrigenPedidoWeb;

                oBePedidoWebDetalle.DescripcionProd = model.DescripcionProd;
                oBePedidoWebDetalle.ImporteTotal = oBePedidoWebDetalle.Cantidad * oBePedidoWebDetalle.PrecioUnidad;
                oBePedidoWebDetalle.Nombre = oBePedidoWebDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;

                bool errorServer;
                string tipo;
                olstPedidoWebDetalle = AdministradorPedido(oBePedidoWebDetalle, "I", out errorServer, out tipo);

                return (!errorServer) ? olstPedidoWebDetalle : null;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        private List<BEPedidoWebDetalle> AdministradorPedido(BEPedidoWebDetalle oBEPedidoWebDetalle, string TipoAdm, out bool ErrorServer, out string tipo)
        {
            List<BEPedidoWebDetalle> olstTempListado = new List<BEPedidoWebDetalle>();

            try
            {
                var pedidoWebDetalleNula = Session["PedidoWebDetalle"] == null;

                olstTempListado = ObtenerPedidoWebDetalle();

                if (pedidoWebDetalleNula == false)
                {
                    if (oBEPedidoWebDetalle.PedidoDetalleID == 0)
                    {
                        if (olstTempListado.Any(p => p.CUV == oBEPedidoWebDetalle.CUV))
                            oBEPedidoWebDetalle.TipoPedido = "X";
                    }
                    else
                    {
                        if (olstTempListado.Any(p => p.PedidoDetalleID == oBEPedidoWebDetalle.PedidoDetalleID))
                            oBEPedidoWebDetalle.TipoPedido = "X";
                    }
                }

                if (TipoAdm == "I")
                {
                    int Cantidad;
                    short Result = ValidarInsercion(olstTempListado, oBEPedidoWebDetalle, out Cantidad);
                    if (Result != 0)
                    {
                        TipoAdm = "U";
                        oBEPedidoWebDetalle.Stock = oBEPedidoWebDetalle.Cantidad;
                        oBEPedidoWebDetalle.Cantidad += Cantidad;
                        oBEPedidoWebDetalle.ImporteTotal = oBEPedidoWebDetalle.Cantidad * oBEPedidoWebDetalle.PrecioUnidad;
                        oBEPedidoWebDetalle.PedidoDetalleID = Result;
                        oBEPedidoWebDetalle.Flag = 2;
                        oBEPedidoWebDetalle.OrdenPedidoWD = 1;
                    }
                }

                int TotalClientes = CalcularTotalCliente(olstTempListado, oBEPedidoWebDetalle, TipoAdm == "D" ? oBEPedidoWebDetalle.PedidoDetalleID : (short)0, TipoAdm);
                decimal TotalImporte = CalcularTotalImporte(olstTempListado, oBEPedidoWebDetalle, TipoAdm == "I" ? (short)0 : oBEPedidoWebDetalle.PedidoDetalleID, TipoAdm);

                oBEPedidoWebDetalle.ImporteTotalPedido = TotalImporte;
                oBEPedidoWebDetalle.Clientes = TotalClientes;

                oBEPedidoWebDetalle.CodigoUsuarioCreacion = userData.CodigoUsuario;
                oBEPedidoWebDetalle.CodigoUsuarioModificacion = userData.CodigoUsuario;

                switch (TipoAdm)
                {
                    case "I":
                        BEPedidoWebDetalle oBePedidoWebDetalleTemp = null;

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            oBePedidoWebDetalleTemp = sv.Insert(oBEPedidoWebDetalle);
                        }
                        oBePedidoWebDetalleTemp.ImporteTotal = oBEPedidoWebDetalle.ImporteTotal;
                        oBePedidoWebDetalleTemp.DescripcionProd = oBEPedidoWebDetalle.DescripcionProd;
                        oBePedidoWebDetalleTemp.Nombre = oBEPedidoWebDetalle.Nombre;

                        oBEPedidoWebDetalle.PedidoDetalleID = oBePedidoWebDetalleTemp.PedidoDetalleID;

                        if (userData.PedidoID == 0)
                        {
                            UsuarioModel usuario = userData;
                            usuario.PedidoID = oBePedidoWebDetalleTemp.PedidoID;
                            SetUserData(usuario);
                        }

                        olstTempListado.Add(oBePedidoWebDetalleTemp);

                        break;
                    case "U":

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoWebDetalle(oBEPedidoWebDetalle);
                        }

                        olstTempListado.Where(p => p.PedidoDetalleID == oBEPedidoWebDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = oBEPedidoWebDetalle.Cantidad;
                                p.ImporteTotal = oBEPedidoWebDetalle.ImporteTotal;
                                p.ClienteID = oBEPedidoWebDetalle.ClienteID;
                                p.DescripcionProd = oBEPedidoWebDetalle.DescripcionProd;
                                p.Nombre = oBEPedidoWebDetalle.Nombre;
                                p.TipoPedido = oBEPedidoWebDetalle.TipoPedido;
                            });

                        break;
                    //case "D":

                    //    using (PedidoServiceClient sv = new PedidoServiceClient())
                    //    {
                    //        sv.DelPedidoWebDetalle(oBEPedidoWebDetalle);
                    //    }

                    //    olstTempListado.RemoveAll(p => p.PedidoDetalleID == oBEPedidoWebDetalle.PedidoDetalleID);

                    //    break;
                }

                Session["PedidoWebDetalle"] = null;

                olstTempListado = ObtenerPedidoWebDetalle();
                ErrorServer = false;
                tipo = TipoAdm;

                UpdPedidoWebMontosPROL();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                olstTempListado = ObtenerPedidoWebDetalle();
                ErrorServer = true;
                tipo = "";
            }
            return olstTempListado;
        }

        private short ValidarInsercion(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, out int Cantidad)
        {
            List<BEPedidoWebDetalle> Temp = new List<BEPedidoWebDetalle>(Pedido);
            BEPedidoWebDetalle obe = Temp.FirstOrDefault(p => p.ClienteID == ItemPedido.ClienteID && p.CUV == ItemPedido.CUV);
            Cantidad = obe != null ? obe.Cantidad : 0;
            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        private int CalcularTotalCliente(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, short PedidoDetalleID, string Adm)
        {
            List<BEPedidoWebDetalle> Temp = new List<BEPedidoWebDetalle>(Pedido);
            if (PedidoDetalleID == 0)
            {
                if (Adm == "I")
                    Temp.Add(ItemPedido);
                else
                    Temp.Where(p => p.PedidoDetalleID == ItemPedido.PedidoDetalleID).Update(p => p.ClienteID = ItemPedido.ClienteID);

            }
            else
                Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();

            return Temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, short PedidoDetalleID, string Adm)
        {
            List<BEPedidoWebDetalle> Temp = new List<BEPedidoWebDetalle>(Pedido);
            if (PedidoDetalleID == 0)
                Temp.Add(ItemPedido);
            else
                Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();
            return Temp.Sum(p => p.ImporteTotal) + (Adm == "U" ? ItemPedido.ImporteTotal : 0);
        }

        public JsonResult RechazarPedido(long SolicitudId, int NumIteracion, string CodigoUbigeo, string Campania, int MarcaId, int OpcionRechazo, string RazonMotivoRechazo, string typeAction = null)
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

                    //Inicio GR-1385
                    BEMisPedidos pedido = new BEMisPedidos();
                    pedido = consultoraOnlineMisPedidos.ListaPedidos.Where(p => p.PedidoId == SolicitudId).FirstOrDefault();

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
                            string emailDe = ConfigurationManager.AppSettings["ConsultoraOnlineEmailDe"];
                            if (typeAction == "1")      // desktop
                            {
                                Common.Util.EnviarMail3(emailDe, pedido.Email, titulocliente, mensajecliente.ToString(), true, pedido.Email);
                            }
                            else
                            {
                                Common.Util.EnviarMail3Mobile(emailDe, pedido.Email, titulocliente, mensajecliente.ToString(), true, pedido.Email);
                            }
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                        }
                    }
                    //Fín GR-1385
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

                            //List<BEMisPedidos> refresh = new List<BEMisPedidos>();
                            //foreach (BEMisPedidos item in consultoraOnlineMisPedidos.ListaPedidos)
                            //{
                            //    if (item.PedidoId == SolicitudId)
                            //    {
                            //        item.Estado = "R";
                            //        item.FechaModificacion = DateTime.Now;
                            //    }
                            //    refresh.Add(item);
                            //}
                            //MisPedidosModel refreshMisPedidos = new MisPedidosModel();
                            //refreshMisPedidos.ListaPedidos = refresh;
                            //Session["objMisPedidos"] = refreshMisPedidos;
                            
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
