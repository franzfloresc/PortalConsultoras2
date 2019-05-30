using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers
{
    public class TuVozOnlineController : BaseController
    {
        // GET: TuVozOnline
        public ActionResult Index()
        {
            var user = userData;

            if (string.IsNullOrEmpty(user.EMail))
            {
                ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(user.CodigoISO);

                return View();
            }

            var provider = new TuVozOnlineProvider
            {
                BasePath = _configuracionManagerProvider
                            .GetConfiguracionManager(Constantes.ConfiguracionManager.QuestionProUrl)
            };

            var config = provider.GetPanelConfig(_tablaLogicaProvider, user.PaisID);
            var url = provider.GetUrl(user, config.Value, config.Key);

            return Redirect(url);
        }
    }
}