using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class UserUnknownLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Uri urlPortal = Util.GetUrlHost(Request);
            Response.Redirect(urlPortal.AbsolutePath);
        }
    }
}