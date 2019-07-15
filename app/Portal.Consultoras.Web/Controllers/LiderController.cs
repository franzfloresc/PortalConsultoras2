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

            string urlAccesoExterno = string.Empty;
            string secretKey = ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? "";

            if (!string.IsNullOrEmpty(secretKey))
            {
                PayLoad payLoad = new PayLoad();

                payLoad.ConsultoraID = userData.ConsultoraID;
                payLoad.CodigoConsultora = strCodigoUsuario;
                payLoad.PaisID = userData.PaisID;
                payLoad.CodigoISO = userData.CodigoISO;
                payLoad.FuenteOrigen = "SomosBelcorp";              

                var cadenaEncriptada = JWT.JsonWebToken.Encode(payLoad, secretKey, JWT.JwtHashAlgorithm.HS256);
                urlAccesoExterno = ConfigurationManager.AppSettings["URL_LIDER"].ToString() + "/?token=" + cadenaEncriptada;
            }

            return Redirect(urlAccesoExterno);
        }

        public class PayLoad
        {
            public long ConsultoraID { get; set; }
            public string CodigoConsultora { get; set; }
            public int PaisID { get; set; }
            public string CodigoISO { get; set; }
            public string FuenteOrigen { get; set; }            
        }

    }
}
