using LithiumSSOClient;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using System;
using System.Configuration;
using System.Web.Security;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ComunidadLogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string codigoUsuario = Request.QueryString["C"];
            string tipo = Request.QueryString["T"];

            BEUsuarioComunidad usuario;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = 0,
                    CodigoUsuario = codigoUsuario,
                    Tipo = 2
                });
            }

            if (usuario != null)
            {
                String uniqueId = SSOClient.ANONYMOUS_UNIQUE_ID;
                SSOClient.writeLithiumCookie(uniqueId, usuario.CodigoUsuario, usuario.Correo, Request, Response);

                if (tipo == "1")
                {
                    SessionManager.SessionManager.Instance.SetUserData(null);
                    Session.Clear();
                    Session.Abandon();
                    FormsAuthentication.SignOut();

                    Uri urlPortal = Util.GetUrlHost(Request);
                    urlPortal = new Uri(urlPortal, "Login");
                    Response.Redirect(urlPortal.AbsoluteUri);
                }
                else Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
            }
            else Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
        }
    }
}