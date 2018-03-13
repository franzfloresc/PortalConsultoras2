using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class UserUnknown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            SessionManager.SessionManager.Instance.SetUserData(null);
            Session.Clear();
            Session.Abandon();

            Uri urlPortal = Util.GetUrlHost(Request);

            string urlLogin = string.Format("{0}/Login", urlPortal.AbsolutePath);

            Response.Redirect(urlLogin);
        }
    }
}