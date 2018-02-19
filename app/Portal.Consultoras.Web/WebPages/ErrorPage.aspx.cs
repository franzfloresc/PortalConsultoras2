using System;
using System.Configuration;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ConfigurationManager.AppSettings["URLSite"]);
        }
    }
}