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

                payLoad.CodigoConsultora = userData.CodigoConsultora;
                payLoad.CodPais = userData.CodigoISO;
                payLoad.CodRegion = userData.CodigorRegion;
                payLoad.CodZona = userData.CodigoZona;
                payLoad.CodSeccion = userData.SeccionAnalytics;
                payLoad.SeccionGestionLider = userData.SeccionGestionLider;
                payLoad.EMail = userData.EMail;
                payLoad.NombrePais = userData.NombrePais;
                payLoad.NombreConsultora = userData.NombreConsultora;
                payLoad.Celular = userData.Celular;
                payLoad.Telefono = userData.Telefono;
                payLoad.DescripcionNivel = userData.DescripcionNivel;
                payLoad.PrimerNombre = userData.PrimerNombre;
                payLoad.PrimerApellido = userData.PrimerApellido;                
                payLoad.Origen = "SomosBelcorp";
                payLoad.DocumentoIdentidad = userData.DocumentoIdentidad;

                var cadenaEncriptada = JWT.JsonWebToken.Encode(payLoad, secretKey, JWT.JwtHashAlgorithm.HS256);
                urlAccesoExterno = ConfigurationManager.AppSettings["URL_LIDER"].ToString() + "/?token=" + cadenaEncriptada;
            }

            return Redirect(urlAccesoExterno);
        }

        public class PayLoad
        {
            public string CodigoConsultora { get; set; }
            public string CodRol { get; set; }
            public string CodPais { get; set; }
            public string CodRegion { get; set; }
            public string CodZona { get; set; }
            public string CodSeccion { get; set; }
            public string SeccionGestionLider { get; set; }
            public string EMail { get; set; }
            public string NombrePais { get; set; }
            public string NombreConsultora { get; set; }
            public string Celular { get; set; }
            public string Telefono { get; set; }
            public string DescripcionNivel { get; set; }
            public string PrimerNombre { get; set; }            
            public string PrimerApellido { get; set; }            
            public string DocumentoIdentidad { get; set; }
            public string Origen { get; set; }
        }

    }
}
