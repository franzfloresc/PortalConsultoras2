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

            string pathData = "Aplicacion=2&CodigoUsuario=" + UserData().NombreConsultora + "&Pais=4";
            string texto = System.Web.HttpUtility.UrlEncode(Util.EncriptarDuplaCyzone(keyPath, pathData));

            string url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE) + texto;

            if (UserData().CodigoISO == Constantes.CodigosISOPais.Peru
                || UserData().CodigoISO == Constantes.CodigosISOPais.Bolivia
                || UserData().CodigoISO == Constantes.CodigosISOPais.Colombia
                || UserData().CodigoISO == Constantes.CodigosISOPais.Mexico
                || UserData().CodigoISO == Constantes.CodigosISOPais.Venezuela
                || UserData().CodigoISO == Constantes.CodigosISOPais.Argentina
                || UserData().CodigoISO == Constantes.CodigosISOPais.Chile
                || UserData().CodigoISO == Constantes.CodigosISOPais.CostaRica
                || UserData().CodigoISO == Constantes.CodigosISOPais.Dominicana
                || UserData().CodigoISO == Constantes.CodigosISOPais.Ecuador
                || UserData().CodigoISO == Constantes.CodigosISOPais.Guatemala
                || UserData().CodigoISO == Constantes.CodigosISOPais.PuertoRico
                || UserData().CodigoISO == Constantes.CodigosISOPais.Salvador)
                url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE + UserData().CodigoISO);

            return Redirect(url);
        }
    }
}
