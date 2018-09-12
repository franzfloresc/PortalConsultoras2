using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class FamiliaProtegidaController : BaseController
    {
        public ActionResult Index()
        {
            string nroDocumento;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                nroDocumento = sv.GetNroDocumentoConsultora(userData.PaisID, userData.CodigoConsultora);
            }

            string url = DevolverUrl(userData.CodigoISO);
            string[] parametros = new string[] { userData.CodigoISO, userData.CodigoConsultora, "", nroDocumento, userData.NombreConsultora, "", userData.EMail, userData.Celular, userData.Telefono, userData.CodigoZona };

            url = url + "?data=" + Util.EncriptarQueryString(parametros);

            return Redirect(url);
        }

        private string DevolverUrl(string isoPais)
        {
            return _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_FAMILIAPROTEGIDA_ + isoPais);
        }

    }
}