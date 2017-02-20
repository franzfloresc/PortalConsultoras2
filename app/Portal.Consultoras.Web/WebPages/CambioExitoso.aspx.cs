using Portal.Consultoras.Common;
using System;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class CambioExitoso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string email = (string)(Session["email"]) != null ? ((string)(Session["email"])).Trim() : "";
                Uri urlPortal = Util.GetUrlHost(Request);

                idlinkingresamicuenta.NavigateUrl = urlPortal.AbsolutePath;

                if (email.Length == 0)
                {
                    Response.Redirect("about:blank");
                }

                Session["email"] = "";
            }
        }
    }
}