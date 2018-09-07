using EasyCallback;
using LithiumSSOClient;
using Portal.Consultoras.Web.ServiceComunidad;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;

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
            string codigoUsuario = Request.QueryString["U"];
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(codigoUsuario))
                {
                    txtUsuarioActual.Value = codigoUsuario;
                    hdfCodigoUsuarioActual.Value = codigoUsuario;

                    BEUsuarioComunidad usuario;
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

                BEUsuarioComunidad obeUsuarioComunidad = new BEUsuarioComunidad
                {
                    UsuarioId = Convert.ToInt64(hdfUsuarioComunidadId.Value),
                    CodigoUsuario = datos["CodigoUsuario"].ToString()
                };
                
                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    sv.UpdCambiarUsuarioComunidad(obeUsuarioComunidad);
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
            bool result;
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
            int tipoUsuario = 0;
            BEUsuario obeUsuario = null;

            if (Convert.ToInt32(hdfEsConsultora.Value) != 0)
            {
                //Validacion Inicio

                tipoUsuario = 2;
                //2: Consultora
                //3: Colaborador
                //4: Lider
                //5: GZ

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    obeUsuario = sv.GetSesionUsuario(Convert.ToInt32(hdfPaisId.Value), hdfCodigoUsuarioSB.Value);
                }

                if (obeUsuario.Lider == 1)
                {
                    tipoUsuario = 4;
                }
                else
                {
                    int esColaborador;
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        esColaborador = sv.GetValidarColaboradorZona(obeUsuario.PaisID, obeUsuario.CodigoZona);
                    }

                    if (esColaborador == 1)
                    {
                        tipoUsuario = 3;
                    }
                }

                //Validacion Final
            }

            BEUsuarioComunidad usuario;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = Convert.ToInt64(hdfUsuarioComunidadId.Value),
                    CodigoUsuario = string.Empty,
                    Tipo = 1,
                    TipoUsuario = tipoUsuario
                });
            }

            if (usuario != null)
            {
                string xmlPath = Server.MapPath("~/Key");
                string keyPath = Path.Combine(xmlPath, ConfigurationManager.AppSettings["AMB_COM"] == "PRD" ? "sso.cookie.prod.key" : "sso.cookie.key");

                SSOClient.init(keyPath, ConfigurationManager.AppSettings["COM_CLIENT_ID"], ConfigurationManager.AppSettings["COM_DOMAIN"]);
                Hashtable settingsMap = new Hashtable();

                if (Convert.ToInt32(hdfEsConsultora.Value) == 0)
                {
                    settingsMap.Add("profile.name_first", usuario.Nombre);
                    settingsMap.Add("profile.name_last", usuario.Apellido);
                }
                else
                {
                    if (obeUsuario != null)
                    {
                        settingsMap.Add("profile.name_first", obeUsuario.PrimerNombre);
                        settingsMap.Add("profile.name_last", obeUsuario.PrimerApellido);
                        settingsMap.Add("profile.codigo_consultora", obeUsuario.CodigoConsultora);
                        settingsMap.Add("profile.pais", obeUsuario.CodigoISO);
                        settingsMap.Add("profile.zona", obeUsuario.CodigoZona);
                        settingsMap.Add("profile.region", obeUsuario.CodigorRegion);
                        settingsMap.Add("profile.seccion", string.Empty);
                        settingsMap.Add("profile.lider", obeUsuario.Lider.ToString());
                        settingsMap.Add("profile.seccion_lider", obeUsuario.SeccionGestionLider);
                        settingsMap.Add("profile.gz", string.Empty);
                        settingsMap.Add("profile.ubigeo", string.Empty);
                        settingsMap.Add("profile.campania_actual", obeUsuario.CampaniaID.ToString());
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
