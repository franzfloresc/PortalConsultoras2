using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LithiumSSOClient;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ConfirmacionRegistroComunidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Request.QueryString["data"] != null)
                    {
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
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "ConfirmacionRegistroComunidad - Page_Load");
            }
        }

        protected void btnIngreso_Click(object sender, EventArgs e)
        {
            int TipoUsuario = 0;
            BEUsuario oBEUsuario = null;

            if (Convert.ToInt32(hdfTipo.Value) != 0)
            {
                //Validacion Inicio

                TipoUsuario = 2;
                //2: Consultora
                //3: Colaborador
                //4: Lider
                //5: GZ

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    oBEUsuario = sv.GetSesionUsuario(Convert.ToInt32(hdfPaisId.Value), hdfUsuarioSB.Value);
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
                    UsuarioId = Convert.ToInt64(hdfUsuario.Value),
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

                if (Convert.ToInt32(hdfTipo.Value) == 0)
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