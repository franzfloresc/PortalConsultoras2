using System;
using System.Collections.Generic;
using System.IdentityModel.Services;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace Portal.Consultoras.Web.WebPages
{
    // pagina base para otras web pages
    // se encarga del manejo de sesiones
    public partial class BaseWebPage : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Context.Session != null)
            {
                if (Context.Session.IsNewSession)
                {
                    var sessionCookie = Page.Request.Headers["Cookie"];
                    if ((sessionCookie != null) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0))
                    {
                        CerrarSesion();
                        // url de signout de qa
                        //string URLSignOut = "https://10.12.6.208/adfs/ls/?wa=wsignout1.0";
                        //string urlTimeout = "/Login/Timeout";
                        string urlTimeout = "portalqadev/SesionExpirada.html";
                        Response.Redirect(urlTimeout);
                    }
                }
            }
        }

        private void CerrarSesion()
        {
            Context.Session["UserData"] = null;
            Context.Session.Abandon();

            FederatedAuthentication.WSFederationAuthenticationModule.SignOut(false);
            FederatedAuthentication.SessionAuthenticationModule.SignOut();
            FederatedAuthentication.SessionAuthenticationModule.CookieHandler.Delete();
            FederatedAuthentication.SessionAuthenticationModule.DeleteSessionTokenCookie();

            FormsAuthentication.SignOut();
        }
    }
}