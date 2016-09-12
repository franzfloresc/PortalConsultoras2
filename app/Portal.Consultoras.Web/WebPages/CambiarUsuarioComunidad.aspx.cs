using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Web.ServiceComunidad;
using LithiumSSOClient;
using System.Configuration;
using EasyCallback;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Collections;
using Portal.Consultoras.Web.ServiceUsuario;
using System.IO;

namespace Portal.Consultoras.Web.WebPages
{

    public partial class CambiarUsuarioComunidad : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            CallbackManager.Register(CambiarApodoComunidad);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string CodigoUsuario = Request.QueryString["U"];
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(CodigoUsuario))
                {
                    txtUsuarioActual.Value = CodigoUsuario;
                    hdfCodigoUsuarioActual.Value = CodigoUsuario;

                    BEUsuarioComunidad usuario = null;
                    using (ComunidadServiceClient sv = new ComunidadServiceClient())
                    {
                        usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                        {
                            UsuarioId = 0,
                            CodigoUsuario = hdfCodigoUsuarioActual.Value,
                            Tipo = 2
                        });
                    }

                    if (usuario != null)
                    {
                        hdfUsuarioComunidadId.Value = usuario.UsuarioId.ToString();
                        hdfPaisId.Value = usuario.PaisId.ToString();
                        hdfEsConsultora.Value = usuario.EsConsultora ? "1" : "0";
                        hdfCodigoUsuarioSB.Value = usuario.CodigoUsuarioSB;

                        try
                        {
                            String uniqueId = SSOClient.ANONYMOUS_UNIQUE_ID;
                            SSOClient.writeLithiumCookie(uniqueId, usuario.CodigoUsuario, usuario.Correo, Request, Response);
                        }
                        catch { }
                    }
                    else Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
                }
                else Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
            }
        }

        public string CambiarApodoComunidad(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            try
            {
                Dictionary<string, object> datos = serializer.Deserialize<Dictionary<string, object>>(data);

                BEUsuarioComunidad Result = null;

                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    BEUsuarioComunidad oBEUsuarioComunidad = new BEUsuarioComunidad();
                    oBEUsuarioComunidad.UsuarioId = Convert.ToInt64(hdfUsuarioComunidadId.Value);
                    oBEUsuarioComunidad.CodigoUsuario = datos["CodigoUsuario"].ToString();
                    Result = sv.UpdCambiarUsuarioComunidad(oBEUsuarioComunidad);
                }

                return serializer.Serialize(new
                {
                    success = true
                });

            }
            catch (Exception ex)
            {
                return serializer.Serialize(new
                {
                    success = false,
                    message = "Ocurrió un error al intentar cambiar tu apodo en la comunidad. Por favor, volver a intentarlo. " + ex.InnerException
                });
            }
        }

        [WebMethod]
        public static string ValidarUsuarioIngresado(string usuario)
        {
            bool result = false;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                result = sv.GetUsuarioByCodigo(new BEUsuarioComunidad()
                {
                    CodigoUsuario = usuario,
                });
            }
            return result ? "1" : "0";
        }

        protected void btnIrComunidad_Click(object sender, EventArgs e)
        {
            AutenticarUsuario();
        }

        protected void lbtnRegresar_Click(object sender, EventArgs e)
        {
            AutenticarUsuario();
        }

        private void AutenticarUsuario()
        {
            int TipoUsuario = 0;
            BEUsuario oBEUsuario = null;

            if (Convert.ToInt32(hdfEsConsultora.Value) != 0)
            {
                //Validacion Inicio

                TipoUsuario = 2;
                //2: Consultora
                //3: Colaborador
                //4: Lider
                //5: GZ

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    oBEUsuario = sv.GetSesionUsuario(Convert.ToInt32(hdfPaisId.Value), hdfCodigoUsuarioSB.Value);
                }

                if (oBEUsuario.Lider == 1)
                {
                    TipoUsuario = 4;
                }
                else
                {
                    int EsColaborador = 0;
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        EsColaborador = sv.GetValidarColaboradorZona(oBEUsuario.PaisID, oBEUsuario.CodigoZona);
                    }

                    if (EsColaborador == 1)
                    {
                        TipoUsuario = 3;
                    }
                }

                //Validacion Final
            }

            BEUsuarioComunidad usuario = null;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = Convert.ToInt64(hdfUsuarioComunidadId.Value),
                    CodigoUsuario = string.Empty,
                    Tipo = 1,
                    TipoUsuario = TipoUsuario
                });
            }

            if (usuario != null)
            {
                string XmlPath = Server.MapPath("~/Key");
                string KeyPath = Path.Combine(XmlPath, ConfigurationManager.AppSettings["AMB_COM"] == "PRD" ? "sso.cookie.prod.key" : "sso.cookie.key");

                SSOClient.init(KeyPath, ConfigurationManager.AppSettings["COM_CLIENT_ID"], ConfigurationManager.AppSettings["COM_DOMAIN"]);
                Hashtable settingsMap = new Hashtable();

                if (Convert.ToInt32(hdfEsConsultora.Value) == 0)
                {
                    settingsMap.Add("profile.name_first", usuario.Nombre);
                    settingsMap.Add("profile.name_last", usuario.Apellido);
                }
                else
                {
                    if (oBEUsuario != null)
                    {
                        settingsMap.Add("profile.name_first", oBEUsuario.PrimerNombre);
                        settingsMap.Add("profile.name_last", oBEUsuario.PrimerApellido);
                        settingsMap.Add("profile.codigo_consultora", oBEUsuario.CodigoConsultora);
                        settingsMap.Add("profile.pais", oBEUsuario.CodigoISO);
                        settingsMap.Add("profile.zona", oBEUsuario.CodigoZona);
                        settingsMap.Add("profile.region", oBEUsuario.CodigorRegion);
                        settingsMap.Add("profile.seccion", string.Empty);
                        settingsMap.Add("profile.lider", oBEUsuario.Lider.ToString());
                        settingsMap.Add("profile.seccion_lider", oBEUsuario.SeccionGestionLider);
                        settingsMap.Add("profile.gz", string.Empty);
                        settingsMap.Add("profile.ubigeo", string.Empty);
                        settingsMap.Add("profile.campania_actual", oBEUsuario.CampaniaID.ToString());
                    }
                }

                if (!string.IsNullOrEmpty(usuario.Rol))
                {
                    if (usuario.Rol == usuario.RolAntiguo)
                    {
                        settingsMap.Add("roles.grant", usuario.Rol);
                    }
                    else
                    {
                        settingsMap.Add("roles.remove", usuario.RolAntiguo);
                        settingsMap.Add("roles.grant", usuario.Rol);
                    }
                }

                SSOClient.writeLithiumCookie(usuario.UsuarioId.ToString(), usuario.CodigoUsuario, usuario.Correo, settingsMap, Request, Response);
                Response.Redirect(ConfigurationManager.AppSettings["URL_COM"]);
            }
        }
    }
}
