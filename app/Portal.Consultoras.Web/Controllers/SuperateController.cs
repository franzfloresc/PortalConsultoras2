using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class SuperateController : BaseController
    {
        public ActionResult Index(string Url)
        {
            string campaniaVenta = GetCampaniaLider(userData.PaisID, userData.ConsultoraID, userData.CodigoISO);
            string nivelProyectado = "";
            string seccionGestionLider = "";
            if (campaniaVenta != "")
            {
                DataSet parametros;
                using (ContenidoServiceClient csv = new ContenidoServiceClient())
                {
                    parametros = csv.ObtenerParametrosSuperateLider(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                }

                if (parametros != null && parametros.Tables.Count > 0)
                {
                    seccionGestionLider = parametros.Tables[0].Rows[0][0].ToString();
                    nivelProyectado = parametros.Tables[0].Rows[0][1].ToString();
                    seccionGestionLider = seccionGestionLider.Length == 0 ? "" : seccionGestionLider.Substring(6);
                }
            }
            if (Url == null)
            {
                string xmlPath = Server.MapPath("~/Key");
                string keyPath = Path.Combine(xmlPath, "KeyPublicaSuperate.xml");
                string pathData = "pais=" + userData.CodigoISO + "&codConsultora=" + userData.CodigoConsultora + "&campania=" + userData.CampaniaID + "&region=" + userData.CodigorRegion + "&zona=" + userData.CodigoZona + "&nombre=" + userData.NombreConsultora + "&email=" + userData.EMail + "&segmento=" + (userData.Segmento.Trim() == "" ? "Nivel IV" : userData.Segmento.Trim()) + "&perfil=Consultora" + "&seccion=" + "" + "&Lider=" + userData.Lider.ToString() + "&NL=" + userData.NivelLider.ToString() + "&CL=" + campaniaVenta + "&SL=" + seccionGestionLider + "&PN=" + nivelProyectado;
                string texto = System.Web.HttpUtility.UrlEncode(Util.EncriptarSuperateBelcorp(keyPath, pathData)) ?? "";
                byte[] bytesToEncode = Encoding.UTF8.GetBytes(texto);
                string url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_SUPERATE_NUEVO) + Convert.ToBase64String(bytesToEncode) + "&seccion=";
                return Redirect(url);
            }
            else
            {
                int indice = Url.LastIndexOf('?');
                Url = Url.Substring(0, indice);
                Url = Url.Replace('*', '&');
                string xmlPath = Server.MapPath("~/Key");
                string keyPath = Path.Combine(xmlPath, "KeyPublicaSuperate.xml");
                string pathData = "pais=" + userData.CodigoISO + "&codConsultora=" + userData.CodigoConsultora + "&campania=" + userData.CampaniaID + "&region=" + userData.CodigorRegion + "&zona=" + userData.CodigoZona + "&nombre=" + userData.NombreConsultora + "&email=" + userData.EMail + "&segmento=" + (userData.Segmento.Trim() == "" ? "Nivel IV" : userData.Segmento.Trim()) + "&perfil=Consultora" + "&seccion=" + "" + "&Lider=" + userData.Lider.ToString() + "&NL=" + userData.NivelLider.ToString() + "&CL=" + campaniaVenta + "&SL=" + seccionGestionLider + "&PN=" + nivelProyectado;
                string texto = System.Web.HttpUtility.UrlEncode(Util.EncriptarSuperateBelcorp(keyPath, pathData)) ?? "";
                string texto2 = System.Web.HttpUtility.UrlEncode(Util.EncriptarSuperateBelcorp(keyPath, Url)) ?? "";
                byte[] bytesToEncode = Encoding.UTF8.GetBytes(texto);
                byte[] bytesToEncode2 = Encoding.UTF8.GetBytes(texto2);
                string url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_SUPERATE_NUEVO) + Convert.ToBase64String(bytesToEncode) + "&seccion=" + Convert.ToBase64String(bytesToEncode2);
                return Redirect(url);
            }

        }

        private string GetCampaniaLider(int paisId, long consultoraId, string codigoPais)
        {
            ContenidoServiceClient sv = new ContenidoServiceClient();
            return sv.GetLiderCampaniaActual(paisId, consultoraId, codigoPais)[0];
        }

    }
}
