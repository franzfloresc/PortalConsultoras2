using LithiumSSOClient;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using System;
using System.Configuration;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ComunidadLogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string CodigoUsuario = Request.QueryString["C"];
            string Tipo = Request.QueryString["T"];

            BEUsuarioComunidad usuario = null;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = 0,
                    CodigoUsuario = CodigoUsuario,
                    Tipo = 2
                });
            }

            if (usuario != null)
            {
                String uniqueId = SSOClient.ANONYMOUS_UNIQUE_ID;
                SSOClient.writeLithiumCookie(uniqueId, usuario.CodigoUsuario, usuario.Correo, Request, Response);

                if (Tipo == "1")
                {
                    Session["UserData"] = null;
                    Session.Clear();
                    Session.Abandon();

                    Uri urlPortal = Util.GetUrlHost(Request);

                    string urlLogin = string.Format("{0}/Login", urlPortal.AbsolutePath);

                    Response.Redirect(urlLogin);
                }
                else
                {
                    Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
            }
        }
    }
}