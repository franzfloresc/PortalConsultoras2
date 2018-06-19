using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Configuration;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class MailConfirmation : System.Web.UI.Page
    {
        private ISessionManager sessionManager;
        private readonly LogDynamoProvider logDynamoProvider;

        public MailConfirmation()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            logDynamoProvider = new LogDynamoProvider();
        }

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
                var paisISO = Util.GetPaisISO(paisId);

                SetStyle(paisISO, codigoUsuario);
                SetLinks(paisISO, codigoUsuario);

                BERespuestaActivarEmail respuesta;
                using (UsuarioServiceClient srv = new UsuarioServiceClient())
                {
                    respuesta = srv.ActivarEmail(paisId, codigoUsuario, email);
                }
                lblConfirmacion.Text = respuesta.Succcess ? Constantes.CambioCorreoResult.Valido : respuesta.Message;

                if (respuesta.Succcess) GuardarLogDynamo(respuesta.Usuario, email);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "MailConfirmation Page_Load", "", "Encrypt Data=" + (Request.QueryString["data"] != null ? Request.QueryString["data"] : ""));
                lblConfirmacion.Text = Constantes.MensajesError.ActivacionCorreo;
            }
        }

        private void SetLinks(string paisISO, string codigoUsuario)
        {
            var urlPortal = ConfigurationManager.AppSettings[AppSettingsKeys.UrlSiteSE];
            var area = EsDispositivoMovil() ? "/Mobile" : "";
            linkregresarasomosbelcorp.NavigateUrl = urlPortal + area + "/MiPerfil/Index";
        }

        private void SetStyle(string paisISO, string codigoUsuario)
        {
            var esEsika = WebConfig.PaisesEsika.Contains(paisISO);                
            txtmarca.Text = esEsika ? "esika" : "lbel";
        }

        private void GuardarLogDynamo(BEUsuario usuarioActual, string correoNuevo)
        {
            try
            {
                var model = Mapper.Map<UsuarioModel>(usuarioActual);
                logDynamoProvider.EjecutarLogDynamoDB(
                    model,
                    EsDispositivoMovil(),
                    "EMAIL",
                    correoNuevo,
                    usuarioActual.EMail,
                    "WEB PAGES/MAIL CONFIRMATION",
                    Constantes.LogDynamoDB.AplicacionPortalConsultoras,
                    "Modificacion",
                    ""
                );

                var userData = sessionManager.GetUserData();
                if (userData == null) return;

                userData.EMail = correoNuevo;
                sessionManager.SetUserData(userData);
            }
            catch (Exception ex) { LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioActual.CodigoUsuario, usuarioActual.CodigoISO); }
        }

        public bool EsDispositivoMovil()
        {
            return Request.Browser.IsMobileDevice;
        }
    }
}