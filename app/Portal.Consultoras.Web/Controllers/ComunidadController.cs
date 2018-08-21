using LithiumSSOClient;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceComunidad;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Collections;
using System.IO;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ComunidadController : BaseController
    {
        public ActionResult Index(string Url)
        {
            int tipoUsuario = 2;
            //2: Consultora
            //3: Colaborador
            //4: Lider
            //5: GZ
            
            if (userData.Lider == 1)
            {
                tipoUsuario = 4;
            }
            else
            {
                int esColaborador;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    esColaborador = sv.GetValidarColaboradorZona(userData.PaisID, userData.CodigoZona);
                }

                if (esColaborador == 1)
                {
                    tipoUsuario = 3;
                }
            }

            BEUsuarioComunidad usuario;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = 0,
                    CodigoUsuario = userData.CodigoUsuario,
                    Tipo = 3,
                    PaisId = userData.PaisID,
                    TipoUsuario = tipoUsuario
                });
            }

            string urlCom = string.Empty;

            if (usuario != null)
            {
                string xmlPath = Server.MapPath("~/Key");
                string keyPath = Path.Combine(xmlPath, _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.AMB_COM) == "PRD" ? "sso.cookie.prod.key" : "sso.cookie.key");

                SSOClient.init(keyPath, _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.COM_CLIENT_ID), _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.COM_DOMAIN));

                Models.UsuarioModel usuarioSesion = userData;

                Hashtable settingsMap = new Hashtable
                {
                    {"profile.name_first", usuarioSesion.PrimerNombre},
                    {"profile.name_last", usuarioSesion.PrimerApellido},
                    {"profile.codigo_consultora", usuarioSesion.CodigoConsultora},
                    {"profile.pais", usuarioSesion.CodigoISO},
                    {"profile.zona", usuarioSesion.CodigoZona},
                    {"profile.region", usuarioSesion.CodigorRegion},
                    {"profile.seccion", string.Empty},
                    {"profile.lider", usuarioSesion.Lider.ToString()},
                    {"profile.seccion_lider", usuarioSesion.SeccionGestionLider},
                    {"profile.gz", string.Empty},
                    {"profile.ubigeo", string.Empty},
                    {"profile.campania_actual", usuarioSesion.CampaniaID.ToString()}
                };

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

                SSOClient.writeLithiumCookie(usuario.UsuarioId.ToString(), usuario.CodigoUsuario, usuario.Correo, settingsMap, System.Web.HttpContext.Current.Request, System.Web.HttpContext.Current.Response);

                if (string.IsNullOrEmpty(Url))
                    urlCom = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_COM);
                else
                    urlCom = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_COM) + '/' + Url;
            }

            return Redirect(string.IsNullOrEmpty(urlCom) ? HttpContext.Request.UrlReferrer.AbsoluteUri : urlCom);
        }

    }
}
