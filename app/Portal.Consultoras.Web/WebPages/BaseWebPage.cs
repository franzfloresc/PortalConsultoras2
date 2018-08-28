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
            UsuarioModel userData = SessionManager.SessionManager.Instance.GetUserData();

            if (userData == null)
            {
                CerrarSesion();

                //Uri urlPortal = Util.GetUrlHost(Request);

                //string urlSesionExpirada = string.Format("{0}/Login/SesionExpirada", urlPortal.AbsolutePath);

                //Response.Redirect(urlSesionExpirada);
                Response.Redirect("/Login/SesionExpirada");
            }
        }

        private void CerrarSesion()
        {
            SessionManager.SessionManager.Instance.SetUserData(null);
            Context.Session.Clear();
            Context.Session.Abandon();
        }
    }
}