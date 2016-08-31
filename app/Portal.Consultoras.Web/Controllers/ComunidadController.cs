using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LithiumSSOClient;
using Portal.Consultoras.Web.ServiceComunidad;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Controllers
{
    public class ComunidadController : BaseController
    {
        //
        // GET: /Comunidad/

        public ActionResult Index(string Url)
        {
            //Validacion Inicio

            int TipoUsuario = 2;
            //2: Consultora
            //3: Colaborador
            //4: Lider
            //5: GZ

            if (UserData().Lider == 1)
            {
                TipoUsuario = 4;
            }
            else
            {
                int EsColaborador = 0;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    EsColaborador = sv.GetValidarColaboradorZona(UserData().PaisID, UserData().CodigoZona);
                }

                if (EsColaborador == 1)
                {
                    TipoUsuario = 3;
                }
            }

            //Validacion Final


            BEUsuarioComunidad usuario = null;
            using (ComunidadServiceClient sv = new ComunidadServiceClient())
            {
                usuario = sv.GetUsuarioInformacion(new BEUsuarioComunidad()
                {
                    UsuarioId = 0,
                    CodigoUsuario = UserData().CodigoUsuario,
                    Tipo = 3,
                    PaisId = UserData().PaisID,
                    TipoUsuario = TipoUsuario
                });
            }

            string Url_Com = string.Empty;

            if (usuario != null)
            {
                string XmlPath = Server.MapPath("~/Key");
                string KeyPath = Path.Combine(XmlPath, ConfigurationManager.AppSettings["AMB_COM"] == "PRD" ? "sso.cookie.prod.key" : "sso.cookie.key");

                SSOClient.init(KeyPath, ConfigurationManager.AppSettings["COM_CLIENT_ID"], ConfigurationManager.AppSettings["COM_DOMAIN"]);

                Models.UsuarioModel UsuarioSesion = UserData();

                Hashtable settingsMap = new Hashtable();
                settingsMap.Add("profile.name_first", UsuarioSesion.PrimerNombre);
                settingsMap.Add("profile.name_last", UsuarioSesion.PrimerApellido);
                //Datos Consultora
                settingsMap.Add("profile.codigo_consultora", UsuarioSesion.CodigoConsultora);
                settingsMap.Add("profile.pais", UsuarioSesion.CodigoISO);
                settingsMap.Add("profile.zona", UsuarioSesion.CodigoZona);
                settingsMap.Add("profile.region", UsuarioSesion.CodigorRegion);
                settingsMap.Add("profile.seccion", string.Empty);
                settingsMap.Add("profile.lider", UsuarioSesion.Lider.ToString());
                settingsMap.Add("profile.seccion_lider", UsuarioSesion.SeccionGestionLider);
                settingsMap.Add("profile.gz", string.Empty);
                settingsMap.Add("profile.ubigeo", string.Empty);
                settingsMap.Add("profile.campania_actual", UsuarioSesion.CampaniaID.ToString());

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
                    Url_Com = ConfigurationManager.AppSettings["URL_COM"];
                else
                    Url_Com = ConfigurationManager.AppSettings["URL_COM"] + '/' + Url;
            }

            return Redirect(string.IsNullOrEmpty(Url_Com) ? HttpContext.Request.UrlReferrer.AbsoluteUri : Url_Com);
        }

    }
}
