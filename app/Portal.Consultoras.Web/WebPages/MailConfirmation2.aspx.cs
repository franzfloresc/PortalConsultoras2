using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;

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
                    string result = string.Empty;
                    bool HasSuccess = false;
                    if (Request.QueryString["data"] != null)
                    {
                        //Formato que envia la url: CodigoUsuario;IdPais
                        string[] query = Util.Desencriptar(Request.QueryString["data"].ToString().Replace("\0","")).Split(',');

                        using (UsuarioServiceClient srv = new UsuarioServiceClient())
                        {
                            HasSuccess = srv.ActiveEmail(Convert.ToInt32(query[1]), query[0], query[2], query[3]);
                        }
                        if (HasSuccess)
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