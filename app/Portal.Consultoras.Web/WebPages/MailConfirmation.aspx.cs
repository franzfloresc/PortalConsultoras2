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
            try
            {
                if (!Page.IsPostBack)
                {
                    string result;

                    var esEsika = false;

                    string urlportal = ConfigurationManager.AppSettings["UrlSiteSE"];

                    if (Request.QueryString["data"] != null)
                    {
                        string parametros = Request.QueryString["data"];
                        var parametrosDesencriptados = Util.Decrypt(parametros);
                        string[] query = parametrosDesencriptados.Split(';');
                        string paisid = query[1];

                        if (paisid == "11" || paisid == "2" || paisid == "3" || paisid == "8" || paisid == "7" || paisid == "4")
                            esEsika = true;

                        txtmarca.Text = esEsika ? "esika" : "lbel";

                        bool hasSuccess;
                        using (UsuarioServiceClient srv = new UsuarioServiceClient())
                        {
                            hasSuccess = srv.ActiveEmail(Convert.ToInt32(query[1]), query[0], query[2], query[3]);
                        }
                        if (hasSuccess)
                            result = "Su dirección de correo electrónico ha sido activada correctamente.";
                        else
                            result = "Esta dirección de correo electrónico ya ha sido activada.";

                        var opcional = query.Length > 4 ? query[4].Trim() : "";
                        if (opcional != "")
                        {
                            var opcionalLista = opcional.Split(',');
                            if (opcionalLista.Length > 1)
                            {
                                if (opcionalLista[0].ToLower() == "urlreturn")
                                {
                                    urlportal = urlportal + "/" + "Bienvenida/MailConfirmacion?tipo=" + opcionalLista[1].ToLower();
                                }
                            }
                        }
                    }
                    else
                        result = "Ha ocurrido un error con la activación de su correo electrónico.";
                    lblConfirmacion.Text = result;
                    linkregresarasomosbelcorp.NavigateUrl = urlportal;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "MailConfirmation Page_Load", "", "Encrypt Data=" + (Request.QueryString["data"] != null ? Request.QueryString["data"] : ""));
                lblConfirmacion.Text = "Ha ocurrido un error con la activación de su correo electrónico.";
            }
        }

    }
}