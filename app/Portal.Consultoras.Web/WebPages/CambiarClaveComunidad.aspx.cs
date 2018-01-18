using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using EasyCallback;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class CambiarClaveComunidad : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(CambiarClaveUsuarioComunidad);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Request.QueryString["data"] != null)
                    {
                        string[] query = Util.DesencriptarQueryString(Request.QueryString["data"].ToString()).Split(';');

                        hdfUsuarioId.Value = query[0];

                        int Codigo = 0;
                        using (ComunidadServiceClient sv = new ComunidadServiceClient())
                        {
                            Codigo = sv.GetValidacionCambioContrasenia(new BEUsuarioComunidad()
                            {
                                UsuarioId = Convert.ToInt64(query[0]),
                            });
                        }

                        switch (Codigo)
                        {
                            case 0:

                                pnlCambio.Visible = false;
                                pnlMensaje.Visible = true;
                                lblMensaje.Text = "Hubo un error al intentar validar la información.";
                                break;
                            case 1:
                                pnlCambio.Visible = false;
                                pnlMensaje.Visible = true;
                                lblMensaje.Text = "Su correo no tiene un usuario asociado.";
                                break;
                            case 2:
                                pnlCambio.Visible = false;
                                pnlMensaje.Visible = true;
                                lblMensaje.Text = "Los cambios de contraseña para los usuarios con perfil consultora se realiza a través de Somos Belcorp";
                                break;
                            case 3:
                                pnlCambio.Visible = false;
                                pnlMensaje.Visible = true;
                                lblMensaje.Text = "No es posible continuar con el proceso debido a que Ud. no ha activado su cuenta de la Comunidad";
                                break;
                            case 4:
                                pnlCambio.Visible = false;
                                pnlMensaje.Visible = true;
                                lblMensaje.Text = "La contraseña ya ha sido actualizada.";
                                break;
                            case 5:
                                pnlCambio.Visible = false;
                                pnlMensaje.Visible = true;
                                lblMensaje.Text = "Solo es posible actualizar su contraseña dentro de las 24 horas de iniciado el proceso. Por favor, vuelva a solicitar un cambio de contraseña.";
                                break;
                            case 100:
                                pnlCambio.Visible = true;
                                pnlMensaje.Visible = false;
                                lblMensaje.Text = string.Empty;
                                break;
                        }

                    }
                    else
                    {
                        pnlCambio.Visible = false;
                        pnlMensaje.Visible = true;
                        lblMensaje.Text = "Hubo un error al intentar cargar la información.";
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "CambiarClaveComunidad - Page_Load");

                pnlCambio.Visible = false;
                pnlMensaje.Visible = true;
                lblMensaje.Text = "Hubo un error al intentar cargar la página.";
            }
        }

        public string CambiarClaveUsuarioComunidad(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            try
            {
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    sv.UpdCambioContrasenia(new BEUsuarioComunidad()
                    {
                        Contrasenia = datos["Contrasenia"].ToString(),
                        UsuarioId = Convert.ToInt64(datos["UsuarioId"].ToString()),
                        Tipo = 2
                    });
                }

                return serializer.Serialize(new
                {
                    success = true,
                    message = "Su contraseña fue actualizada con éxito"
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "CambiarClaveComunidad - CambiarClaveUsuarioComunidad");
                return serializer.Serialize(new
                {
                    success = false,
                    message = "Hubo un error al intentar actualizar su contraseña. Por favor, vuelva a intentarlo."
                });
            }
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("IngresoComunidad.aspx");
        }
    }
}