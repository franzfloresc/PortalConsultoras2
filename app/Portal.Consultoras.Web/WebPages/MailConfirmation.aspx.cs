using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Security.Cryptography;
using System.IO;
using System.Configuration;

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
                    string result = string.Empty;
                    bool HasSuccess = false;

                    var esEsika = false;

                    string urlportal = ConfigurationManager.AppSettings["UrlSiteSE"];

                    if (Request.QueryString["data"] != null)
                    {
                        string parametros = Request.QueryString["data"];
                        var parametrosDesencriptados = Util.DesencriptarQueryString(parametros);
                        string[] query = parametrosDesencriptados.Split(';');
                        string paisid = query[1];
                        //032610099;11;PE;leonarddgl@gmail.com;31/12/9999 23:59:59

                        if (paisid == "11" || paisid == "2" || paisid == "3" || paisid == "8" || paisid == "7" || paisid == "4")
                            esEsika = true;

                        txtmarca.Text = esEsika ? "esika" : "lbel";
                        //Formato que envia la url: CodigoUsuario;IdPais
                        //string[] query1 = Util.DesencriptarQueryString(Request.QueryString["data"].ToString()).Split(';');

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
                    linkregresarasomosbelcorp.NavigateUrl = urlportal;
                    //if (Request.QueryString["tipo"] != null)
                    //{
                    //    if (!Request.QueryString["tipo"].Equals("ccc"))
                    //        lnkClienteCC.Visible = false;
                    //}
                    //else
                    //{
                    //    lnkClienteCC.Visible = false;
                    //}
                }
                //else
                //    lblConfirmacion.Text = "Para activar la dirección E-mail, debe hacer clic en el enlace enviado a su correo electrónico.";
            }
            catch (Exception ex)
            {
                //lblConfirmacion.Text = ex.Message;
                lblConfirmacion.Text = "Ha ocurrido un error con la activación de su correo electrónico.";
            }
        }
        
    }
}
