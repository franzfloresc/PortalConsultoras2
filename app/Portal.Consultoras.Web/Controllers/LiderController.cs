using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Configuration;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class LiderController : BaseController
    {
        public ActionResult Index()
        {
            string strCodigoUsuario;

            if (!string.IsNullOrEmpty(userData.ConsultoraAsociada) && userData.ConsultoraAsociada.Trim().Length > 0)
            {
                using (var sv = new UsuarioServiceClient())
                {
                    strCodigoUsuario = sv.GetUsuarioAsociado(userData.PaisID, userData.ConsultoraAsociada);
                }
            }
            else
            {
                strCodigoUsuario = userData.CodigoUsuario;
            }

            string[] parametros = new string[] { userData.PaisID.ToString() + "|" + strCodigoUsuario };
            string str = Util.EncriptarQueryString(parametros);
            string url = ConfigurationManager.AppSettings.Get("URL_LIDER") + "?p=" + str;

            if (Session[Constantes.ConstSession.IngresoPortalLideres] == null)
            {
                RegistrarLogDynamoDB("PORTALLIDERES", "SE", "SOCIAEMPRESARIA-INGRESAR", "MENÚ PRINCIPAL SB");
                Session[Constantes.ConstSession.IngresoPortalLideres] = true;
            }

            return Redirect(url);
        }

    }
}
