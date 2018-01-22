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

            string url = GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE) + texto;
            
            if (UserData().CodigoISO == "PE"
                || UserData().CodigoISO == "BO"
                || UserData().CodigoISO == "CO"
                || UserData().CodigoISO == "MX"
                || UserData().CodigoISO == "VE"
                || UserData().CodigoISO == "AR"
                || UserData().CodigoISO == "CL"
                || UserData().CodigoISO == "CR"
                || UserData().CodigoISO == "DO"
                || UserData().CodigoISO == "EC"
                || UserData().CodigoISO == "GT"
                || UserData().CodigoISO == "PR"
                || UserData().CodigoISO == "SV")
                url = GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE + UserData().CodigoISO);

            return Redirect(url);
        }
    }
}
