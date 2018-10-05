using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasController : BaseMobileController
    {
        protected ConfiguracionOfertasHomeProvider _confiOfertasHomeProvider;

        public OfertasController() : this(new ConfiguracionOfertasHomeProvider())
        {
        }

        public OfertasController(ConfiguracionOfertasHomeProvider configuracionOfertasHomeProvider) : base()
        {
            _confiOfertasHomeProvider = configuracionOfertasHomeProvider;
        }

        public OfertasController(
            ISessionManager sessionManager,
            ILogManager logManager,
            ConfiguracionOfertasHomeProvider configuracionOfertasHomeProvider,
            OfertaViewProvider ofertaViewProvider
            )
            : base(sessionManager, logManager)
        {
            _confiOfertasHomeProvider = configuracionOfertasHomeProvider;
            _ofertasViewProvider = ofertaViewProvider;
        }

        public ActionResult Index()
        {
            try
            {
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = _confiOfertasHomeProvider.ObtenerConfiguracionSeccion(revistaDigital, IsMobile()),
                    MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile())
                };
                ViewBag.variableEstrategia = GetVariableEstrategia();

                return View(modelo);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "Mobile.OfertasController.Index");
            }

            return RedirectToAction("Index", "Bienvenida",new { area = "Mobile"});
        }

        public ActionResult Revisar()
        {
            try
            {
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = _confiOfertasHomeProvider.ObtenerConfiguracionSeccion(revistaDigital, IsMobile()),
                    MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile())
                };

                ViewBag.variableEstrategia = GetVariableEstrategia();

                return View("Index", modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

    }
}