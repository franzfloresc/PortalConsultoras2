using System;
using System.Collections.Generic;
using System.Configuration;
//using System.IdentityModel.Services;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class UsuarioBloqueado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ISO = Request.QueryString["P"];
            if (ISO == "CO")
                DivMensajeCO.Visible = true;
            else
                DivMensajeGenerico.Visible = true;           
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ConfigurationManager.AppSettings.Get("URLSite"));
        }
    }
}