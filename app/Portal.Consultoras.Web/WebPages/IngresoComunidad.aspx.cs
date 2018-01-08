using EasyCallback;
using LithiumSSOClient;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class IngresoComunidad : System.Web.UI.Page
    {
        private string refererDecode;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(ValidarUsuario);
            CallbackManager.Register(RegistrarUsuarioComunidad);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.refererDecode = this.ObtenerRefererDecode(Request);
            if (!IsPostBack) hdfSB.Value = ConfigurationManager.AppSettings["URL_SB"] + "/Comunidad/Index?Url=" + this.refererDecode;
        }

        public string ValidarUsuario(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            int RespuestaComunidad = 0;
            string message = string.Empty;
            string page = string.Empty;
            bool success = false;

            try
            {
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    BEUsuarioComunidad oBEUsuarioComunidad = new BEUsuarioComunidad();
                    oBEUsuarioComunidad.CodigoUsuario = datos["CodigoUsuario"].ToString();
                    oBEUsuarioComunidad.Contrasenia = datos["Contrasenia"].ToString();
                    oBEUsuarioComunidad.PaisId = Convert.ToInt32(datos["PaisId"].ToString());
                    RespuestaComunidad = sv.GetUsuarioValidado(oBEUsuarioComunidad);
                }

                switch (RespuestaComunidad)
                {
                    case 0:
                        message = "El usuario ingresado no existe.";
                        break;
                    case 1:
                        message = "La contraseña ingresada no es correcta.";
                        break;
                    case 2:
                        BEUsuarioComunidad usuario = null;
                        using (ComunidadServiceClient sv = new ComunidadServiceClient())
                        {
                            usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                            {
                                UsuarioId = 0,
                                CodigoUsuario = datos["CodigoUsuario"].ToString(),
                                Tipo = 2
                            });
                        }

                        if (usuario != null)
                        {
                            string XmlPath = Server.MapPath("~/Key");
                            string KeyPath = Path.Combine(XmlPath, ConfigurationManager.AppSettings["AMB_COM"] == "PRD" ? "sso.cookie.prod.key" : "sso.cookie.key");

                            SSOClient.init(KeyPath, ConfigurationManager.AppSettings["COM_CLIENT_ID"], ConfigurationManager.AppSettings["COM_DOMAIN"]);
                            Hashtable settingsMap = new Hashtable();
                            settingsMap.Add("profile.name_first", usuario.Nombre);
                            settingsMap.Add("profile.name_last", usuario.Apellido);

                            if (!string.IsNullOrEmpty(usuario.Rol))
                            {
                                settingsMap.Add("roles.grant", usuario.Rol);
                            }

                            SSOClient.writeLithiumCookie(usuario.UsuarioId.ToString(), usuario.CodigoUsuario, usuario.Correo, settingsMap, Request, Response);

                            success = true;
                            page = ConfigurationManager.AppSettings["URL_COM"] + (!string.IsNullOrEmpty(this.refererDecode) ? ("/" + this.refererDecode) : "");
                        }

                        break;
                    case 3:
                        message = "Ud. todavía no ha confirmado su correo.";
                        break;
                    case 4:
                        message = "Por favor, utilice su cuenta de consultora.";
                        break;
                    case 5:
                        message = "Por favor, utilice su cuenta de consultora.";
                        break;
                }

                return serializer.Serialize(new
                {
                    success = success,
                    message = message,
                    page = page
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "IngresoComunidad - ValidarUsuario");

                return serializer.Serialize(new
                {
                    success = false,
                    message = "Ocurrió un error, por favor volver a intentarlo."
                });
            }
        }

        public string RegistrarUsuarioComunidad(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            try
            {
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                long UniqueId = -1;
                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    UniqueId = sv.InsUsuarioRegistro(new BEUsuarioComunidad()
                    {
                        CodigoUsuario = datos["CodigoUsuario"].ToString(),
                        Nombre = datos["Nombre"].ToString(),
                        Apellido = datos["Apellido"].ToString(),
                        Contrasenia = datos["Contrasenia"].ToString(),
                        Correo = datos["Correo"].ToString(),
                        PaisId = Convert.ToInt32(datos["PaisId"].ToString())
                    });
                }

                if (UniqueId > 0)
                {
                    string[] parametros = new string[] { UniqueId.ToString(), "0", datos["PaisId"].ToString() };
                    string param_querystring = Util.EncriptarQueryString(parametros);

                    string pagina_confirmacion = GetUrlHost(Page.Request) + "WebPages/ConfirmacionRegistroComunidad.aspx?data=" + param_querystring;

                    StringBuilder sb = new StringBuilder();
                    sb.Append("<table width='720' border='0' align='center' cellpadding='0' cellspacing='0'><tr><td valign='top'>");
                    sb.Append("<table width='720' border='0' cellspacing='0' cellpadding='0'><tr><td width='598'>");
                    sb.Append("<table width='720' border='0' cellpadding='0' cellspacing='0'><tbody>");
                    sb.Append("<tr><td colspan='2'><img src='https://s3.amazonaws.com/somosbelcorp/Comunidad/logo.jpg' width='720' height='58' alt=''  border='0' style='display:block'/></td></tr>");
                    sb.Append("<tr><td height='38' colspan='2' bgcolor='#d3d7db'>&nbsp;</td></tr>");
                    sb.Append("<tr><td width='327' height='10' bgcolor='#d3d7db'>&nbsp;</td>");
                    sb.Append("<td width='393' rowspan='11'><img src='https://s3.amazonaws.com/somosbelcorp/Comunidad/chicas.jpg'  border='0' style='display:block' alt=''/></td></tr>");
                    sb.Append("<tr><td bgcolor='#d3d7db' align='center'><font style='FONT-SIZE:15px;' face='Tahoma, Geneva, sans-serif' color='#415261'><strong>Hola " + datos["Nombre"].ToString() + " " + datos["Apellido"].ToString() + ",</strong></font></td></tr>");
                    sb.Append("<tr><td height='10' bgcolor='#d3d7db'>&nbsp;</td></tr>");
                    sb.Append("<tr><td height='53' bgcolor='#d3d7db' align='center'><font style='font-size:16px;' face='Tahoma, Geneva, sans-serif' color='#722789'><strong>&iexcl;Bienvenida a la Comunidad de Consultoras de belleza!</strong></font></td></tr>");
                    sb.Append("<tr><td height='10' bgcolor='#d3d7db'>&nbsp;</td></tr>");
                    sb.Append("<tr><td height='35' align='center' bgcolor='#d3d7db'><font style='FONT-SIZE:14px;' face='Tahoma, Geneva, sans-serif' color='#415261'>");
                    sb.Append("Con&eacute;ctate y comparte con mujeres <br/>emprendedoras y expertos en negocio.</font></td></tr>");
                    sb.Append("<tr><td height='10' bgcolor='#d3d7db'>&nbsp;</td></tr>");
                    sb.Append("<tr><td bgcolor='#d3d7db' align='center'><font style='FONT-SIZE:14px;' face='Tahoma, Geneva, sans-serif' color='#415261'>&iexcl;Ven a conversar!</font></td></tr>");
                    sb.Append("<tr><td height='35' bgcolor='#d3d7db'>&nbsp;</td></tr>");
                    sb.Append("<tr><td bgcolor='#d3d7db' align='center'><a href='" + pagina_confirmacion + "'><img src='https://s3.amazonaws.com/somosbelcorp/Comunidad/boton-confirmar.jpg' width='240' height='37'  border='0' style='display:block' alt=''/></a></td></tr>");
                    sb.Append("<tr><td height='30' align='center' bgcolor='#d3d7db'>&nbsp;</td></tr>");
                    sb.Append("<tr><td height='38' colspan='2' bgcolor='#d3d7db'><table width='720' border='0' cellspacing='0' cellpadding='0'><tbody><tr>");
                    sb.Append("<td width='231'>&nbsp;</td>");
                    sb.Append("<td width='311'><font style='FONT-SIZE:11px;' face='Tahoma, Geneva, sans-serif' color='#415261'>&iexcl;Comparte con m&aacute;s Consultoras en nuestras redes sociales!</font></td>");
                    sb.Append("<td width='24'><a href='https://www.youtube.com/user/somosbelcorp'><img src='https://s3.amazonaws.com/somosbelcorp/Comunidad/icono-youtube.jpg' width='24' height='35'  border='0' style='display:block' alt=''/></a></td>");
                    sb.Append("<td width='20'><a href='https://www.facebook.com/SomosBelcorpOficial'><img src='https://s3.amazonaws.com/somosbelcorp/Comunidad/icono-facebook.jpg' width='20' height='35'  border='0' style='display:block' alt=''/></a></td>");
                    sb.Append("<td width='134'>&nbsp;</td>");
                    sb.Append("</tr></tbody></table></td></tr>");
                    sb.Append("</tbody></table></td></tr></table></td></tr></table>");

                    Util.EnviarMail("comunidadsomosbelcorp@somosbelcorp.com", datos["Correo"].ToString(), "Bienvenida a la Comunidad SomosBelcorp", sb.ToString(), true, "Comunidad SomosBelcorp");

                    using (ComunidadServiceClient sv = new ComunidadServiceClient())
                    {
                        sv.UpdUsuarioCorreoEnviado(new BEUsuarioComunidad()
                        {
                            UsuarioId = UniqueId,
                            Tipo = 0
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "IngresoComunidad - RegistrarUsuarioComunidad");

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

        [WebMethod]
        public static string ValidarUsuarioIngresado(string usuario)
        {
            bool result = false;
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
            bool result = false;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCorreo(new BEUsuarioComunidad()
                {
                    Correo = correo,
                });
            }
            return result ? "1" : "0";
        }

        #region Private Functions

        private string QuitarProtocoloAUrl(string url)
        {
            if (url.IndexOf(@"http://") == 0) return url.Remove(0, 7);
            if (url.IndexOf(@"https://") == 0) return url.Remove(0, 8);
            return url;
        }

        private string ObtenerRefererDecode(HttpRequest request)
        {
            string referer = request.QueryString["referer"];
            if (!string.IsNullOrEmpty(referer))
            {
                referer = HttpUtility.UrlDecode(referer);
                referer = this.QuitarProtocoloAUrl(referer);

                string baseComunidad = ConfigurationManager.AppSettings["URL_COM"];
                baseComunidad = HttpUtility.UrlDecode(baseComunidad);
                baseComunidad = this.QuitarProtocoloAUrl(baseComunidad);

                if (referer.IndexOf(baseComunidad) == 0)
                {
                    referer = referer.Remove(0, baseComunidad.Length);
                    if (referer[0] == '/') referer = referer.Remove(0, 1);
                    return referer;
                }
            }
            return "";
        }

        #endregion
    }
}