using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using System.Configuration;
using System.Text;
using System.IO;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using System.Data;

namespace Portal.Consultoras.Web.Controllers
{
    public class SuperateController : BaseController
    {
        public ActionResult Index(string Url)
        {
            /*Inicio Cambios_Landing_Comunidad*/
            //if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Superate/Index"))
            //    return RedirectToAction("Index", "Bienvenida");
            /*Fin Cambios_Landing_Comunidad*/

            // 2379 - INICIO
            string CampaniaVenta = GetCampaniaLider(UserData().PaisID, UserData().ConsultoraID, UserData().CodigoISO);
            string NivelProyectado = ""; // ProyectaNivel(UserData().PaisID, UserData().ConsultoraID);
            string SeccionGestionLider = ""; // UserData().SeccionGestionLider.Length == 0 ? "" : (UserData().SeccionGestionLider).Substring(6);
            // 2379 - FIN
            if (CampaniaVenta != "")
            {
                DataSet parametros = null;
                using (ContenidoServiceClient csv = new ContenidoServiceClient())
                {
                    parametros = csv.ObtenerParametrosSuperateLider(UserData().PaisID, UserData().ConsultoraID, UserData().CampaniaID);
                }

                if (parametros != null && parametros.Tables.Count > 0)
                {
                    SeccionGestionLider = parametros.Tables[0].Rows[0][0].ToString();
                    NivelProyectado = parametros.Tables[0].Rows[0][1].ToString();
                    SeccionGestionLider = SeccionGestionLider.Length == 0 ? "" : SeccionGestionLider.Substring(6);
                }
            }
            if (Url == null)
            {
                string XmlPath = Server.MapPath("~/Key");
                string KeyPath = Path.Combine(XmlPath, "KeyPublicaSuperate.xml");
                //string PathData = "/pais/" + UserData().CodigoISO + "/codConsultora/" + UserData().CodigoConsultora + "/campania/" + UserData().CampaniaID + "/region/" + UserData().CodigorRegion + "/zona/" + UserData().CodigoZona + "/nombre/" + UserData().NombreConsultora + "/email/" + UserData().EMail;
                //string PathData = "pais=" + UserData().CodigoISO + "&codConsultora=" + UserData().CodigoConsultora + "&campania=" + UserData().CampaniaID + "&region=" + UserData().CodigorRegion + "&zona=" + UserData().CodigoZona + "&nombre=" + UserData().NombreConsultora + "&email=" + UserData().EMail + "&segmento=" + (UserData().Segmento.Trim() == "" ? "Nivel IV" : UserData().Segmento.Trim()) + "&perfil=Consultora" + "&seccion=" + "" + "&Lider="+ UserData().Lider.ToString()  + "&NivelLider=" +UserData().NivelLider.ToString();
                // 2319
                string PathData = "pais=" + UserData().CodigoISO + "&codConsultora=" + UserData().CodigoConsultora + "&campania=" + UserData().CampaniaID + "&region=" + UserData().CodigorRegion + "&zona=" + UserData().CodigoZona + "&nombre=" + UserData().NombreConsultora + "&email=" + UserData().EMail + "&segmento=" + (UserData().Segmento.Trim() == "" ? "Nivel IV" : UserData().Segmento.Trim()) + "&perfil=Consultora" + "&seccion=" + "" + "&Lider=" + UserData().Lider.ToString() + "&NL=" + UserData().NivelLider.ToString() + "&CL=" + CampaniaVenta + "&SL=" + SeccionGestionLider + "&PN=" + NivelProyectado;
                string texto = System.Web.HttpUtility.UrlEncode(Util.EncriptarSuperateBelcorp(KeyPath, PathData));
                byte[] bytesToEncode = Encoding.UTF8.GetBytes(texto);
                string Url_ = ConfigurationManager.AppSettings["URL_SUPERATE_NUEVO"].ToString() + Convert.ToBase64String(bytesToEncode) + "&seccion=";
                return Redirect(Url_);
            }
            else
            {
                int indice = Url.LastIndexOf('?');
                Url = Url.Substring(0, indice);
                Url = Url.Replace('*', '&');
                string XmlPath = Server.MapPath("~/Key");
                string KeyPath = Path.Combine(XmlPath, "KeyPublicaSuperate.xml");
                //string PathData = "/pais/" + UserData().CodigoISO + "/codConsultora/" + UserData().CodigoConsultora + "/campania/" + UserData().CampaniaID + "/region/" + UserData().CodigorRegion + "/zona/" + UserData().CodigoZona + "/nombre/" + UserData().NombreConsultora + "/email/" + UserData().EMail;
                //R2004
				//string PathData = "pais=" + UserData().CodigoISO + "&codConsultora=" + UserData().CodigoConsultora + "&campania=" + UserData().CampaniaID + "&region=" + UserData().CodigorRegion + "&zona=" + UserData().CodigoZona + "&nombre=" + UserData().NombreConsultora + "&email=" + UserData().EMail + "&segmento=" + (UserData().Segmento.Trim() == "" ? "Nivel IV" : UserData().Segmento.Trim()) + "&perfil=Consultora" + "&seccion=" + "" + "&Lider=" + UserData().Lider.ToString() + "&NivelLider=" + UserData().NivelLider.ToString();
                // 2379
                string PathData = "pais=" + UserData().CodigoISO + "&codConsultora=" + UserData().CodigoConsultora + "&campania=" + UserData().CampaniaID + "&region=" + UserData().CodigorRegion + "&zona=" + UserData().CodigoZona + "&nombre=" + UserData().NombreConsultora + "&email=" + UserData().EMail + "&segmento=" + (UserData().Segmento.Trim() == "" ? "Nivel IV" : UserData().Segmento.Trim()) + "&perfil=Consultora" + "&seccion=" + "" + "&Lider=" + UserData().Lider.ToString() + "&NL=" + UserData().NivelLider.ToString() + "&CL=" + CampaniaVenta + "&SL=" + SeccionGestionLider + "&PN=" + NivelProyectado;
                string texto = System.Web.HttpUtility.UrlEncode(Util.EncriptarSuperateBelcorp(KeyPath, PathData));
                string texto2 = System.Web.HttpUtility.UrlEncode(Util.EncriptarSuperateBelcorp(KeyPath, Url));
                byte[] bytesToEncode = Encoding.UTF8.GetBytes(texto);
                byte[] bytesToEncode2 = Encoding.UTF8.GetBytes(texto2);
                string Url_ = ConfigurationManager.AppSettings["URL_SUPERATE_NUEVO"].ToString() + Convert.ToBase64String(bytesToEncode) + "&seccion=" + Convert.ToBase64String(bytesToEncode2);
                return Redirect(Url_);
            }

        }

        //R2379
        private string GetCampaniaLider(int paisID, long ConsultoraID, string CodigoPais)
        {
            ContenidoServiceClient sv = new ContenidoServiceClient();
            return sv.GetLiderCampaniaActual(paisID, ConsultoraID, CodigoPais)[0].ToString();
        }

        //R2379
        private string ProyectaNivel(int paisID, long ConsultoraID)
        {
            ContenidoServiceClient sv = new ContenidoServiceClient();
            return sv.GetProyectaNivel(paisID, ConsultoraID)[0].ToString();
        }
    }
}
