using EasyCallback;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class RecuperarClaveComunidad : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(RecuperarClaveUsuarioComunidad);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string RecuperarClaveUsuarioComunidad(string data)
        { 
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            try
            {
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                BEUsuarioComunidad obeUsuarioComunidad;
                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    obeUsuarioComunidad = sv.GetUsuarioInformacionByCorreo(new BEUsuarioComunidad()
                    {
                        Correo = datos["Correo"].ToString(),
                    });
                }

                if (obeUsuarioComunidad != null)
                {
                    string[] parametros = new string[] { obeUsuarioComunidad.UsuarioId.ToString() };
                    string paramQuerystring = Util.EncriptarQueryString(parametros);

                    string paginaConfirmacion = GetUrlHost(Page.Request) + "WebPages/CambiarClaveComunidad.aspx?data=" + paramQuerystring;
                    string paginaConfirmacionMasc = GetUrlHost(Page.Request) + "WebPages/CambiarClaveComunidad.aspx";

                    StringBuilder sb = new StringBuilder();
                    sb.Append("<html><head><title>Cambia tu contraseña - Comunidad Somos Belcorp</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head>");
                    sb.Append("<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>");
                    sb.Append("<table width='630' align='center' cellpadding='0' cellspacing='0' id='Table_01' style='border-top: solid; border-bottom: solid; border-right: solid; border-left: solid; border-width: 1px; border-color: #425363;'>");
                    sb.Append("<tr>");
                    sb.Append("<td style='vertical-align: top; padding-top: 25px; padding-left: 20px;'>");
                    sb.Append("<img src='https://cdn1-prd.somosbelcorp.com/Comunidad/mail_menulat_02.gif' width='198' height='73' alt=''></td>");
                    sb.Append("<td style='vertical-align: top; text-align: right;'>");
                    sb.Append("<img src='https://cdn1-prd.somosbelcorp.com/Comunidad/mail_menulat_01.gif' height='100' alt=''></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td></tr>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append(string.Format("<td colspan='2' style='vertical-align: top; padding-left: 38px; padding-right: 60px;'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>Hola {0},</font></td>", obeUsuarioComunidad.Nombre));
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2' style='vertical-align: top; padding-left: 38px; padding-right: 60px;'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>Para cambiar tu contraseña de la Comunidad Somos Belcorp, haz click en este enlace:</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append(string.Format("<td colspan='2' style='vertical-align: top; padding-left: 38px; padding-right: 60px;'><a href='{0}' style='font-family: Arial,sans-serif; font-size: 14px; color: #AE66AF; line-height: 1.2; text-decoration:none;'>{1}</a></td>", paginaConfirmacion, paginaConfirmacionMasc));
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2' style='vertical-align: top; padding-left: 38px; padding-right: 60px;'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>Para tu seguridad, el enlace de arriba dejará de funcionar en 24 horas. Si no has solicitado cambiar tu contraseña, por favor ignora este correo.</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2' style='vertical-align: top; padding-left: 38px; padding-right: 60px;'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>Gracias,</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2' style='vertical-align: top; padding-left: 38px; padding-right: 60px;'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>El equipo de Somos Belcorp</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("<tr>");
                    sb.Append("<td colspan='2' ><font face='Arial,sans-serif' style='font-family: Arial,sans-serif; font-size: 14px; color: #425363; line-height: 1.2;'>&nbsp;</font></td>");
                    sb.Append("</tr>");
                    sb.Append("</table></body></html>");

                    Util.EnviarMail("comunidadsomosbelcorp@somosbelcorp.com", datos["Correo"].ToString(), "Cambia tu contraseña - Comunidad Somos Belcorp", sb.ToString(), true, "Comunidad SomosBelcorp");

                    using (ComunidadServiceClient sv = new ComunidadServiceClient())
                    {
                        sv.UpdCambioContrasenia(new BEUsuarioComunidad()
                        {
                            UsuarioId = obeUsuarioComunidad.UsuarioId,
                            Tipo = 1,
                            Contrasenia = string.Empty
                        });
                    }

                    return serializer.Serialize(new
                    {
                        success = true
                    });
                }
                else
                {
                    return serializer.Serialize(new
                    {
                        success = false
                    });
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "RecuperarClaveComunidad - RecuperarClaveUsuarioComunidad");

                return serializer.Serialize(new
                {
                    success = false
                });
            }
        }

        public Uri GetUrlHost(HttpRequest request)
        {
            string baseUrl = request.Url.Scheme + "://" + request.Url.Authority + (request.ApplicationPath.ToString().Equals("/") ? "/" : (request.ApplicationPath + "/"));
            return new Uri(baseUrl);
        }

    }
}