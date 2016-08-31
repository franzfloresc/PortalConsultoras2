using System;
using System.Collections.Generic;
using System.Configuration;
using System.IdentityModel.Services;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using LithiumSSOClient;
using Portal.Consultoras.Web.ServiceComunidad;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ComunidadLogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string CodigoUsuario = Request.QueryString["C"];
            string Tipo = Request.QueryString["T"];

            BEUsuarioComunidad usuario = null;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = 0,
                    CodigoUsuario = CodigoUsuario,
                    Tipo = 2
                });
            }

            if (usuario != null)
            {
                String uniqueId = SSOClient.ANONYMOUS_UNIQUE_ID;
                SSOClient.writeLithiumCookie(uniqueId, usuario.CodigoUsuario, usuario.Correo, Request, Response);

                if (Tipo == "1")
                {
                    Session["UserData"] = null;
                    Session.Clear();
                    Session.Abandon();

                    FederatedAuthentication.WSFederationAuthenticationModule.SignOut(false);
                    FederatedAuthentication.SessionAuthenticationModule.SignOut();
                    FederatedAuthentication.SessionAuthenticationModule.CookieHandler.Delete();
                    FederatedAuthentication.SessionAuthenticationModule.DeleteSessionTokenCookie();

                    FormsAuthentication.SignOut();
                    Response.Redirect(ConfigurationManager.AppSettings.Get("URLSignOut"));
                }
                else
                {
                    Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
            }
        }
    }
}