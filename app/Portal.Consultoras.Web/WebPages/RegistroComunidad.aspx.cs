using EasyCallback;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class RegistroComunidad : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(RegistrarUsuarioComunidad);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hdfSB.Value = ConfigurationManager.AppSettings["URL_SB"];
            }
        }

        public string RegistrarUsuarioComunidad(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            try
            {
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                long uniqueId;
                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    uniqueId = sv.InsUsuarioRegistro(new BEUsuarioComunidad()
                    {
                        CodigoUsuario = datos["CodigoUsuario"].ToString(),
                        Nombre = datos["Nombre"].ToString(),
                        Apellido = datos["Apellido"].ToString(),
                        Contrasenia = datos["Contrasenia"].ToString(),
                        Correo = datos["Correo"].ToString(),
                        PaisId = Convert.ToInt32(datos["PaisId"].ToString())
                    });
                }

                if (uniqueId > 0)
                {
                    string[] parametros = new string[] { uniqueId.ToString(), "0", datos["PaisId"].ToString() };
                    string paramQuerystring = Util.EncriptarQueryString(parametros);

                    string paginaConfirmacion = GetUrlHost(Page.Request) + "WebPages/ConfirmacionRegistroComunidad.aspx?data=" + paramQuerystring;

                    StringBuilder sb = new StringBuilder();
                    sb.Append("<html><head><title>mail_inscripcion</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head>");
                    sb.Append("<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>");
                    sb.Append("<table width='766' height='665' border='0' align='center' cellpadding='0' cellspacing='0' id='Table_01'>");
                    sb.Append("<tr><td><img src='" + Globals.RutaCdn + "/Comunidad/mail_verificacion_01.jpg' width='766' height='240' alt=''></td></tr>");
                    sb.Append("<tr><td><img src='" + Globals.RutaCdn + "/Comunidad/mail_verificacion_02.gif' width='766' height='142' alt=''></td></tr>");
                    sb.Append("<tr><td><img src='" + Globals.RutaCdn + "/Comunidad/mail_verificacion_03.jpg' width='766' height='153' alt=''></td></tr>");
                    sb.Append("<tr><td width='766' height='28'>&nbsp;</td></tr>");
                    sb.Append("<tr><td><table id='Table_' width='766' height='46' border='0' cellpadding='0' cellspacing='0'><tr><td width='259'>&nbsp;</td>");
                    sb.Append(string.Format("<td width='249'><a href='{0}'><img src='" + Globals.RutaCdn + "/Comunidad/bot_verifica.gif' width='249' height='46' alt=''></a></td>", paginaConfirmacion));
                    sb.Append("<td width='258'>&nbsp;</td></tr></table></td></tr>");
                    sb.Append("<tr><td width='766' height='56'>&nbsp;</td></tr></table></body></html>");

                    Util.EnviarMail("comunidadsomosbelcorp@somosbelcorp.com", datos["Correo"].ToString(), "Bienvenida a la Comunidad SomosBelcorp", sb.ToString(), true, "Comunidad SomosBelcorp");

                    using (ComunidadServiceClient sv = new ComunidadServiceClient())
                    {
                        sv.UpdUsuarioCorreoEnviado(new BEUsuarioComunidad()
                        {
                            UsuarioId = uniqueId,
                            Tipo = 0
                        });
                    }

                    return serializer.Serialize(new
                    {
                        success = true
                    });
                }

                return serializer.Serialize(new
                {
                    success = false
                });

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "RegistroComunidad - RegistrarUsuarioComunidad");

                return serializer.Serialize(new
                {
                    success = false
                });
            }
        }

        public Uri GetUrlHost(HttpRequest request)
        {
            string baseUrl = request.Url.Scheme + "://" + request.Url.Authority + (request.ApplicationPath != null && request.ApplicationPath.Equals("/") ? "/" : (request.ApplicationPath + "/"));
            return new Uri(baseUrl);
        }

        [WebMethod]
        public static string ValidarUsuarioIngresado(string usuario)
        {
            bool result;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCodigo(new BEUsuarioComunidad()
                {
                    CodigoUsuario = usuario,
                });
            }
            return result ? "1" : "0";
        }

        [WebMethod]
        public static string ValidarCorreoIngresado(string correo)
        {
            bool result;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCorreo(new BEUsuarioComunidad()
                {
                    Correo = correo,
                });
            }
            return result ? "1" : "0";
        }
    }
}