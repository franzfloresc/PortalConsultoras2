using LithiumSSOClient;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections;
using System.Configuration;
using System.IO;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ConfirmacionRegistroComunidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsPostBack) return;
                if (Request.QueryString["data"] == null) return;

                //Formato que envia la url: CodigoUsuario;IdPais
                string[] query = Util.DesencriptarQueryString(Request.QueryString["data"].ToString()).Split(';');

                using (ComunidadServiceClient sv = new ComunidadServiceClient())
                {
                    if (Convert.ToInt32(query[1]) == 0)
                    {
                        sv.UpdUsuarioCorreoActivo(new BEUsuarioComunidad()
                        {
                            UsuarioId = Convert.ToInt64(query[0]),
                            Tipo = Convert.ToInt32(query[1]),
                            PaisId = Convert.ToInt32(query[2])
                        });
                    }
                    else
                    {
                        sv.UpdUsuarioCorreoActivo(new BEUsuarioComunidad()
                        {
                            UsuarioId = Convert.ToInt64(query[0]),
                            Tipo = Convert.ToInt32(query[1]),
                            PaisId = Convert.ToInt32(query[2]),
                            CodigoUsuarioSB = Convert.ToString(query[3]),
                            CodigoConsultoraSB = Convert.ToString(query[4])
                        });
                    }
                }
                hdfUsuario.Value = query[0];
                hdfTipo.Value = query[1];
                hdfPaisId.Value = query[2];
                hdfUsuarioSB.Value = query[3];
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "ConfirmacionRegistroComunidad - Page_Load");
            }
        }

        protected void btnIngreso_Click(object sender, EventArgs e)
        {
            int tipoUsuario = 0;
            BEUsuario obeUsuario = null;

            if (Convert.ToInt32(hdfTipo.Value) != 0)
            {
                //Validacion Inicio

                tipoUsuario = 2;
                //2: Consultora
                //3: Colaborador
                //4: Lider
                //5: GZ

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    obeUsuario = sv.GetSesionUsuario(Convert.ToInt32(hdfPaisId.Value), hdfUsuarioSB.Value);
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
            }

            BEUsuarioComunidad usuario;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = Convert.ToInt64(hdfUsuario.Value),
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

                if (Convert.ToInt32(hdfTipo.Value) == 0)
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