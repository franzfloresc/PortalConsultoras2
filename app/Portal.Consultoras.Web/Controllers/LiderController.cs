using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
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
            string url = GetConfiguracionManager(Constantes.ConfiguracionManager.URL_LIDER) + "?p=" + str;

            if (sessionManager.GetIngresoPortalLideres() == null)
            {
                RegistrarLogDynamoDB(Constantes.LogDynamoDB.AplicacionPortalLideres, Constantes.LogDynamoDB.RolSociaEmpresaria, "HOME", "INGRESAR");
                sessionManager.SetIngresoPortalLideres(true);
            }

            return Redirect(url);
        }

    }
}
