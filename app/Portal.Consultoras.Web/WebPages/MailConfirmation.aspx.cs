using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class MailConfirmation : System.Web.UI.Page
    {
        private ISessionManager sessionManager;
        private readonly LogDynamoProvider logDynamoProvider;
        private readonly List<string> listUrlCss;

        public MailConfirmation()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            logDynamoProvider = new LogDynamoProvider();
            listUrlCss = new List<string> {
                "../Content/Css/Site/{0}/reset.css",
                "../Content/Css/Site/{0}/style.css",
                "../Content/Css/Site/{0}/mi-perfil.css",
                "../Content/Css/Site/{0}/styleDefault.css",
                "../Content/Css/ui.jquery/{0}/jquery-ui.css"
            };
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;

            try
            {
                if (string.IsNullOrEmpty(Request.QueryString["data"]))
                {
                    SetRespuesta(new BERespuestaActivarEmail() { Message = Constantes.MensajesError.ActivacionCorreo, Code = Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION });
                    return;
                }

                var paramDesencriptados = Util.Decrypt(Request.QueryString["data"]);
                var arrayParam = paramDesencriptados.Split(';');
                var codigoUsuario = arrayParam[0];
                var paisId = Convert.ToInt32(arrayParam[1]);
                var email = arrayParam[2];
                var paisISO = Util.GetPaisISO(paisId);

                SetStyle(paisISO);
                SetLinks(paisISO);

                BERespuestaActivarEmail respuesta;
                using (UsuarioServiceClient srv = new UsuarioServiceClient())
                {
                    respuesta = srv.ActivarEmail(paisId, codigoUsuario, email);
                }
                SetRespuesta(respuesta);
                
                if (respuesta.Succcess) GuardarLogDynamo(respuesta.Usuario, email);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "MailConfirmation Page_Load", "", "Encrypt Data=" + (Request.QueryString["data"] != null ? Request.QueryString["data"] : ""));
                SetRespuesta(new BERespuestaActivarEmail() { Message = Constantes.MensajesError.ActivacionCorreo, Code = Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION });
            }
        }

        private void SetLinks(string paisISO)
        {
            var urlPortal = ConfigurationManager.AppSettings[AppSettingsKeys.UrlSiteSE];
            var area = EsDispositivoMovil() ? "/Mobile" : "";
            var marca = WebConfig.PaisesEsika.Contains(paisISO) ? Constantes.MarcaNombre.Esika : Constantes.MarcaNombre.LBel;
            linkMainPage.NavigateUrl = urlPortal + area + "/MiPerfil/Index";
            linkSomosBelcorp.NavigateUrl = linkMainPage.NavigateUrl;            
            linkAppEsikaConmigo.NavigateUrl = marca == Constantes.MarcaNombre.Esika ? Constantes.RedireccionAndroidApp.EsikaConmigo : Constantes.RedireccionAndroidApp.LbelConmigo;
            btnAppEsikaConmigo.NavigateUrl = linkAppEsikaConmigo.NavigateUrl;            
            linkAppEsikaConmigo.Text = string.Format(Constantes.RedireccionAndroidApp.AppRedirectFormatAlt, marca);
            btnAppEsikaConmigo.Text = string.Format(Constantes.RedireccionAndroidApp.AppRedirectFormat, marca.ToUpper());
        }

        private void SetStyle(string paisISO)
        {
            var marca = WebConfig.PaisesEsika.Contains(paisISO) ? "Esika" : "Lbel";
            foreach (var urlCss in listUrlCss)
            {
                var link = new HtmlLink();
                link.Href = string.Format(urlCss, marca);
                link.Attributes.Add("rel", "stylesheet");
                link.Attributes.Add("type", "text/css");
                Page.Header.Controls.Add(link);
            }
        }

        private void SetRespuesta(BERespuestaActivarEmail respuesta)
        {
            divHeadSuccess.Visible = respuesta.Succcess;
            divHeadError.Visible = !respuesta.Succcess;
            lblConfirmacion.Text = respuesta.Succcess ? Constantes.ActualizacionDatosValidacion.VerificacionEmail.VerificacionEmailValida : respuesta.Message;
            if (!respuesta.Succcess)
            {
                var emotionPath = "~/Content/Images/mobile/img-emoticons/{0}.png";
                var iconPath = "~/Content/Images/mobile/img-icon/{0}.png";
                switch (respuesta.Code) {                     
                    case Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION_YA_ACTIVADA:
                        lblTituloError.Text = Constantes.ActualizacionDatosValidacion.VerificacionEmail.TuCorreoYaFueValidado;
                        imgError.ImageUrl = string.Format(emotionPath, "1f605");
                        break;
                    case Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION_DUPLICADO:
                        lblTituloError.Text = Constantes.ActualizacionDatosValidacion.VerificacionEmail.UpsOcurrioUnProblema;
                        imgError.ImageUrl = string.Format(iconPath, "icon_bolsita_triste");
                        if(respuesta.BelcorpResponde != null)
                        {
                            divFootCall.Visible = !respuesta.Succcess;
                            if (string.IsNullOrEmpty(respuesta.BelcorpResponde.Telefono2))
                                lblComunicate.Text = string.Format(Constantes.ActualizacionDatosValidacion.VerificacionEmail.ComunicateConNosotrosAlt, BuildLinkPhone(respuesta.BelcorpResponde.Telefono1));
                            else
                                lblComunicate.Text = string.Format(Constantes.ActualizacionDatosValidacion.VerificacionEmail.ComunicateConNosotros, BuildLinkPhone(respuesta.BelcorpResponde.Telefono1), BuildLinkPhone(respuesta.BelcorpResponde.Telefono2));
                        }
                        divFootSuccess.Visible = respuesta.Succcess;
                        break;
                    default:
                        lblTituloError.Text = Constantes.ActualizacionDatosValidacion.VerificacionEmail.UpsOcurrioUnProblema;
                        imgError.ImageUrl = string.Format(iconPath, "icon_bolsita_triste");
                        break;
                }
            }
        }

        private string BuildLinkPhone(string phone) {
            string tel = Regex.Replace(phone.Split(' ')[0], "[^0-9]" , "");            
            return  string.Format("<a onclick=\"callToBelcorp('{0}');\" class=\"phoneLink\" >{1}</a>", tel, phone);
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