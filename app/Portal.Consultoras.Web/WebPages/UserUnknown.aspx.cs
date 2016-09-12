using System;
using System.Collections.Generic;
using System.Configuration;
using System.IdentityModel.Services;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class UserUnknown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Session["UserData"] = null;
            Session.Abandon();

            FederatedAuthentication.SessionAuthenticationModule.CookieHandler.Delete();
            FederatedAuthentication.SessionAuthenticationModule.DeleteSessionTokenCookie();
            FederatedAuthentication.WSFederationAuthenticationModule.SignOut(false);
            FormsAuthentication.SignOut();

            Response.Redirect(ConfigurationManager.AppSettings.Get("URLSignOut"));
        }
    }
}