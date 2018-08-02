using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasController : BaseMobileController
    {
        protected ConfiguracionOfertasHomeProvider _confiOfertasHomeProvider;

        public OfertasController()
        {
            _confiOfertasHomeProvider = new ConfiguracionOfertasHomeProvider();
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

                return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
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