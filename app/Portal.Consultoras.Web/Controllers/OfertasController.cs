using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Ofertas;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasController : BaseController
    {
        private readonly ConfiguracionOfertasHomeProvider _confiOfertasHomeProvider;
            
        public OfertasController() : this(new ConfiguracionOfertasHomeProvider())
        {
        }

        public OfertasController(ConfiguracionOfertasHomeProvider configuracionOfertasHomeProvider):base()
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
            if (EsDispositivoMovil()) return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });

            try
            {
                var indexViewModel = new IndexViewModel();
                indexViewModel.EstrategiaPersonalizada = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = _confiOfertasHomeProvider.ObtenerConfiguracionSeccion(revistaDigital, IsMobile()),
                    MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile())
                };
                indexViewModel.IconoLLuvia = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                indexViewModel.VariablesEstrategia = GetVariableEstrategia();

                return View(indexViewModel);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "OfertasController.Index");
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Revisar()
        {
            try
            {
                var indexViewModel = new IndexViewModel();
                bool esMobile = IsMobile();
                indexViewModel.EstrategiaPersonalizada = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = _confiOfertasHomeProvider.ObtenerConfiguracionSeccion(revistaDigital, esMobile),
                    MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(esMobile),
                    MensajeProductoBloqueado2 = _ofertasViewProvider.HVMensajeProductoBloqueado(herramientasVenta, esMobile)

                };

                indexViewModel.VariablesEstrategia = GetVariableEstrategia();

                return View("Index", indexViewModel);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "OfertasController.Revisar");
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult ActualizarSession(string codigo, int campaniaId)
        {
            try
            {
                if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.Lanzamiento))
                    SessionManager.SetTieneLan(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.Lanzamiento))
                    SessionManager.SetTieneLanX1(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.OfertasParaTi))
                    SessionManager.SetTieneOpt(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.RevistaDigital))
                    SessionManager.SetTieneOpm(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.RevistaDigital))
                    SessionManager.SetTieneOpmX1(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.HerramientasVenta))
                    SessionManager.SetTieneHv(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.HerramientasVenta))
                    SessionManager.SetTieneHvX1(false);

                return Json(new
                {
                    estado = "Ok"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "OfertasController.ActualizarSession");

                return Json(new
                {
                    estado = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}