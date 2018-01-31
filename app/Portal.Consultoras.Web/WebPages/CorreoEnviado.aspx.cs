using System;
using System.Configuration;
using System.Web.UI;

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