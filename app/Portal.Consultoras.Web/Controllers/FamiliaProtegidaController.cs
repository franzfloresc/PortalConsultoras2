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
                nroDocumento = sv.GetNroDocumentoConsultora(UserData().PaisID, UserData().CodigoConsultora);
            }

            string url = DevolverUrl(UserData().CodigoISO);
            string[] parametros = new string[] { UserData().CodigoISO, UserData().CodigoConsultora, "", nroDocumento, UserData().NombreConsultora, "", UserData().EMail, UserData().Celular, UserData().Telefono, UserData().CodigoZona };

            url = url + "?data=" + Util.EncriptarQueryString(parametros);

            return Redirect(url);
        }

        private string DevolverUrl(string isoPais)
        {
            return _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_FAMILIAPROTEGIDA_ + isoPais);
        }

    }
}