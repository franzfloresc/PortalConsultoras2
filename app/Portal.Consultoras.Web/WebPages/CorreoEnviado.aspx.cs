using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class CorreoEnviado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string urlportal = ConfigurationManager.AppSettings["URLSite"];

            if (!Page.IsPostBack) 
            {
                string email = (string)(Session["email"]) != null ? ((string)(Session["email"])).Trim() : "";

                idlinkingresanuevamente.NavigateUrl = urlportal + "/WebPages/RecuperarClave.aspx";

                if (email.Length == 0)
                {
                    Response.Redirect("about:blank");
                }
                else
                {
                    lblemail.Text = email;

                }

                Session["email"] = "";
            }
        }
    }
}