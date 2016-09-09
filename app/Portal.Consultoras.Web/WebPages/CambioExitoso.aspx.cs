using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class CambioExitoso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string urlportal = ConfigurationManager.AppSettings["URLSite"];

            if (!Page.IsPostBack)
            {
                string email = (string)(Session["email"]) != null ? ((string)(Session["email"])).Trim() : "";

                idlinkingresamicuenta.NavigateUrl = urlportal;

                if (email.Length == 0)
                {
                    Response.Redirect("about:blank");
                }

                Session["email"] = "";
            }
        }
    }
}