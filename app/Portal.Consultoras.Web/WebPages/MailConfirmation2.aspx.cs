using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class MailConfirmation2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    string result;
                    if (Request.QueryString["data"] != null)
                    {
                        //Formato que envia la url: CodigoUsuario;IdPais
                        string[] query = Util.Desencriptar(Request.QueryString["data"].ToString().Replace("\0","")).Split(',');

                        bool hasSuccess;
                        using (UsuarioServiceClient srv = new UsuarioServiceClient())
                        {
                            hasSuccess = srv.ActiveEmail(Convert.ToInt32(query[1]), query[0], query[2], query[3]);
                        }
                        if (hasSuccess)
                            result = "Su dirección de correo electrónico ha sido activada correctamente.";
                        else
                            result = "Esta dirección de correo electrónico ya ha sido activada.";
                    }
                    else
                        result = "Ha ocurrido un error con la activación de su correo electrónico.";
                    lblConfirmacion.Text = result;
                }
            }
            catch (Exception ex)
            {
                lblConfirmacion.Text = ex.Message;
            }
        }
    }
}