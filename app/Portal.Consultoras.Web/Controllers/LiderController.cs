using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
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

            //string[] parametros = new string[] { userData.PaisID.ToString() + "|" + strCodigoUsuario };
            //string str = Util.EncriptarQueryString(parametros);
            //string url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_LIDER) + "?p=" + str;

            ////if (!SessionManager.GetIngresoPortalLideres())
            //{
            //    //RegistrarLogDynamoDB(Constantes.LogDynamoDB.AplicacionPortalLideres, Constantes.LogDynamoDB.RolSociaEmpresaria, "HOME", "INGRESAR");
            //    SessionManager.SetIngresoPortalLideres(true);
            //}

            string urlAccesoExterno = string.Empty;
            string secretKey = ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? "";

            if (!string.IsNullOrEmpty(secretKey))
            {
                IngresoExternoModel payLoad = new IngresoExternoModel();
                payLoad.Pais = userData.PaisID.ToString();
                payLoad.CodigoUsuario = strCodigoUsuario;

                var cadenaEncriptada = JWT.JsonWebToken.Encode(payLoad, secretKey, JWT.JwtHashAlgorithm.HS256);
                urlAccesoExterno = ConfigurationManager.AppSettings["URL_LIDER"].ToString() + "/?p=" + cadenaEncriptada;
            }

            return Redirect(urlAccesoExterno);
        }

    }
}
