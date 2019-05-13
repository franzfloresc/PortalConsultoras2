using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers
{
    public class TuVozOnlineController : BaseController
    {
        // GET: TuVozOnline
        public async Task<ActionResult> Index()
        {
            var user = userData;
            var provider = new TuVozOnlineProvider();

            if (await provider.RequiereValidarCorreo(user))
            {
                var msg = ResultModel<string>.BuildBad(
                    "Necesitas tener un correo electrónico verificado para poder acceder.",
                    "Tu Voz Online");
                
                TempData[Constantes.TempDataKey.MsgValidation] = msg;

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