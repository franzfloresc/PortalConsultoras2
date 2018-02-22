using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class UsuarioBloqueado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string iso = Request.QueryString["P"];
            if (iso == "CO")
                DivMensajeCO.Visible = true;
            else
                DivMensajeGenerico.Visible = true;           
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Uri urlPortal = Util.GetUrlHost(Request);
            Response.Redirect(urlPortal.AbsolutePath);
        }
    }
}