using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;

namespace Portal.Consultoras.Web.WebPages
{
    // pagina base para otras web pages
    // se encarga del manejo de sesiones
    public partial class BaseWebPage : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            UsuarioModel userData = (UsuarioModel)Context.Session["UserData"];

            if (userData == null)
            {
                CerrarSesion();

                Uri urlPortal = Util.GetUrlHost(Request);

                string urlSesionExpirada = string.Format("{0}/Login/SesionExpirada", urlPortal.AbsolutePath);

                Response.Redirect(urlSesionExpirada);
            }
        }

        private void CerrarSesion()
        {
            Context.Session["UserData"] = null;
            Context.Session.Clear();
            Context.Session.Abandon();
        }
    }
}