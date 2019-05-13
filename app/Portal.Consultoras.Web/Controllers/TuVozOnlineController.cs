using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers
{
    public class TuVozOnlineController : BaseController
    {
        // GET: TuVozOnline
        public async Task<ActionResult> Index()
        {
            var user = userData;
            var provider = new QuestionProProvider();

            if (await provider.RequiereValidarCorreo(user))
            {
                TempData["MSG_TITLE"] = "Tu Voz Online";
                TempData["MSG_BODY"] = "Necesitas tener un correo electrónico verificado para poder acceder.";

                var area = EsDispositivoMovil() ? "Mobile" : "";
                return RedirectToAction("Index", "MiPerfil", new { area });
            }

            provider.BasePath = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.QuestionProUrl);

            var config = provider.GetPanelConfig(_tablaLogicaProvider, user.PaisID);

            var url = provider.GetUrl(user, config.Value, config.Key);

            return Redirect(url);
        }
    }
}