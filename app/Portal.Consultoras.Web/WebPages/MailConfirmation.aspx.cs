using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Configuration;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class MailConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;
            try
            {
                if (string.IsNullOrEmpty(Request.QueryString["data"]))
                {
                    lblConfirmacion.Text = Constantes.MensajesError.ActivacionCorreo;
                    return;
                }

                var paramDesencriptados = Util.Decrypt(Request.QueryString["data"]);
                var arrayParam = paramDesencriptados.Split(';');
                var codigoUsuario = arrayParam[0];
                var paisId = Convert.ToInt32(arrayParam[1]);
                var email = arrayParam[2];

                SetStyle(Util.GetPaisISO(paisId), codigoUsuario);

                BERespuestaServicio respuesta;
                using (UsuarioServiceClient srv = new UsuarioServiceClient())
                {
                    respuesta = srv.ActivarEmail(paisId, codigoUsuario, email);
                }
                lblConfirmacion.Text = respuesta.Succcess ? Constantes.CambioCorreoResult.Valido : respuesta.Message;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "MailConfirmation Page_Load", "", "Encrypt Data=" + (Request.QueryString["data"] != null ? Request.QueryString["data"] : ""));
                lblConfirmacion.Text = Constantes.MensajesError.ActivacionCorreo;
            }
        }

        private void SetStyle(string paisISO, string codigoUsuario)
        {
            var paisesEsika = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.PaisesEsika] ?? "";
            var esEsika = paisesEsika.Contains(paisISO);
                
            txtmarca.Text = esEsika ? "esika" : "lbel";
        }
    }
}