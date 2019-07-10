﻿using System.Threading.Tasks;
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
            var beUsuario = await _miPerfilProvider.GetUsuario(user.PaisID, user.CodigoUsuario);

            if (RequireEmail(beUsuario))
            {
                ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(user.CodigoISO);

                return View();
            }

            user.EMail = beUsuario.EMail;
            var provider = new TuVozOnlineProvider
            {
                BasePath = _configuracionManagerProvider
                            .GetConfiguracionManager(Constantes.ConfiguracionManager.QuestionProUrl)
            };

            var config = provider.GetPanelConfig(_tablaLogicaProvider, user.PaisID);
            var url = provider.GetUrl(user, config.Value, config.Key);

            return Redirect(url);
        }

        [HttpPost]
        public async Task<ActionResult> RequiereNuevaPagina()
        {
            var user = userData;
            var beUsuario = await _miPerfilProvider.GetUsuario(user.PaisID, user.CodigoUsuario);
            var inSamePage = RequireEmail(beUsuario);

            return Json(new {
                NewPage = inSamePage ? 0 : 1
            });
        }

        private bool RequireEmail(ServiceUsuario.BEUsuario user)
        {
            return user == null || string.IsNullOrEmpty(user.EMail);
        }
    }
}