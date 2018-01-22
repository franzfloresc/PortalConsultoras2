using LithiumSSOClient;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using System;
using System.Collections;
using System.Configuration;
using System.IO;
using System.Web.Services;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class Comunidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string UsuarioComunidad = Convert.ToString(Request.QueryString["UC"]);
            string Tipo = Convert.ToString(Request.QueryString["T"]);

            Uri urlPortal = Util.GetUrlHost(Request);
            string urlLogin = string.Format("{0}/Login", urlPortal.AbsolutePath);

            if (!string.IsNullOrEmpty(UsuarioComunidad))
            {
                BEUsuarioComunidad usuario = null;
                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                    { 
                        UsuarioId = 0,
                        CodigoUsuario = UsuarioComunidad,
                        Tipo = 2
                    });
                }

                if (Tipo == "0")
                {
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
                        Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
                    }
                }
                else
                {
                    if (usuario != null)
                    {
                        string Consultora = Convert.ToString(Request.QueryString["CO"]);

                        SessionManager.SessionManager.Instance.SetUserData(null);
                        Session.Clear();
                        Session.Abandon();

                        if (Consultora == "1")
                        {
                            Response.Redirect(urlLogin);
                        }
                        else
                        {
                            Response.Redirect(ConfigurationManager.AppSettings.Get("URL_COM"));
                        }
                    }
                }
            }
            else
            {
                Response.Redirect(urlLogin);
            }

        }

        [WebMethod]
        public static string ValidarUsuarioConsultora(string usuario)
        {
            bool result = false;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                result = sv.GetUsuarioByConsultora(new BEUsuarioComunidad()
                {
                    CodigoUsuario = usuario,
                });
            }
            return result ? "1" : "0";
        }
    }
}