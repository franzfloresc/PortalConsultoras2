using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System.IO;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class DuplaSACController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "DuplaSAC/Index"))
                return RedirectToAction("Index", "Bienvenida");

            string xmlPath = Server.MapPath("~/Key");
            string keyPath = Path.Combine(xmlPath, "KeyPublicaEnvioCadena.xml");

            string pathData = "Aplicacion=2&CodigoUsuario=" + userData.NombreConsultora + "&Pais=4";
            string texto = System.Web.HttpUtility.UrlEncode(Util.EncriptarDuplaCyzone(keyPath, pathData));

            string url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE) + texto;

            if (userData.CodigoISO == Constantes.CodigosISOPais.Peru
                || userData.CodigoISO == Constantes.CodigosISOPais.Bolivia
                || userData.CodigoISO == Constantes.CodigosISOPais.Colombia
                || userData.CodigoISO == Constantes.CodigosISOPais.Mexico
                || userData.CodigoISO == Constantes.CodigosISOPais.Venezuela
                || userData.CodigoISO == Constantes.CodigosISOPais.Argentina
                || userData.CodigoISO == Constantes.CodigosISOPais.Chile
                || userData.CodigoISO == Constantes.CodigosISOPais.CostaRica
                || userData.CodigoISO == Constantes.CodigosISOPais.Dominicana
                || userData.CodigoISO == Constantes.CodigosISOPais.Ecuador
                || userData.CodigoISO == Constantes.CodigosISOPais.Guatemala
                || userData.CodigoISO == Constantes.CodigosISOPais.PuertoRico
                || userData.CodigoISO == Constantes.CodigosISOPais.Salvador)
                url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE + userData.CodigoISO);

            return Redirect(url);
        }
    }
}
