using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceLMS;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteController : BaseController
    {
        private readonly CaminoBrillanteProvider _caminoBrillanteProvider;
        private readonly MiAcademiaProvider _miAcademiaProvider;
        private readonly ConfiguracionManagerProvider _configuracionManagerProvider;
        private readonly IssuuProvider _issuuProvider;

        public CaminoBrillanteController()
        {
            _caminoBrillanteProvider = new CaminoBrillanteProvider();
            _configuracionManagerProvider = new ConfiguracionManagerProvider();
            _miAcademiaProvider = new MiAcademiaProvider(_configuracionManagerProvider);
            _issuuProvider = new IssuuProvider();
        }

        public ActionResult Index()
        {
            try
            {
                if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return _RedirectToAction("Index", "Bienvenida");

                ViewBag.Niveles = _caminoBrillanteProvider.GetNivelesCaminoBrillante(true);
               
                var nivelActual = _caminoBrillanteProvider.GetNivelActual();
                ViewBag.NivelActual = nivelActual;
                if (nivelActual != null && nivelActual.CodigoNivel == Constantes.CaminoBrillante.CodigoNiveles.Brillante) {
                    ViewBag.GranBrillante = _caminoBrillanteProvider.GetNivelGranBrillante();
                }

                ViewBag.NivelSiguiente = _caminoBrillanteProvider.GetNivelSiguienteConsultora();
                ViewBag.ResumenLogros = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
                ViewBag.TieneOfertasEspeciales = _caminoBrillanteProvider.TieneOfertasEspeciales();
                ViewBag.SimboloMoneda = userData.Simbolo;
                ViewBag.EsMobile = EsDispositivoMovil() || IsMobile();

                #region Configuracion
                var lst = _caminoBrillanteProvider.GetCaminoBrillanteConfiguracion();
                ViewBag.TieneCarrusel = lst.Any(x => x.Codigo == Constantes.CaminoBrillante.Configuracion.sb_carrusel && x.Valor == "1") ? "1" : "0";
                ViewBag.TieneGanancias = lst.Any(x => x.Codigo == Constantes.CaminoBrillante.Configuracion.sb_ganancias && x.Valor == "1") ? "1" : "0";
                ViewBag.TieneMontoAcumulado = lst.Any(x => x.Codigo == Constantes.CaminoBrillante.Configuracion.sb_barraMontoAcumulado && x.Valor == "1") ? "1" : "0";
                ViewBag.TieneEnterateMas = lst.Any(x => x.Codigo == Constantes.CaminoBrillante.Configuracion.sb_enterateMas && x.Valor == "1") ? "1" : "0";
                ViewBag.TieneOnboardingAnim = _caminoBrillanteProvider.TieneOnboardingAnim();
                ViewBag.TieneGananciaAnim = _caminoBrillanteProvider.TieneGananciaAnim();
                #endregion

                if (ViewBag.TieneOfertasEspeciales)
                    ViewBag.Carrusel = _caminoBrillanteProvider.GetCarruselCaminoBrillante();

                return View();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return _RedirectToAction("Index", "Bienvenida");
            }
        }

        public ActionResult Logros(string opcion)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return _RedirectToAction("Index", "Bienvenida");
            if (string.IsNullOrEmpty(opcion)) opcion = Constantes.CaminoBrillante.Logros.CRECIMIENTO;

            var opcionUpper = opcion.ToUpper();
            if (opcionUpper != Constantes.CaminoBrillante.Logros.CRECIMIENTO && opcionUpper != Constantes.CaminoBrillante.Logros.COMPROMISO)
            {
                return _RedirectToAction("Index", "Bienvenida");
            }

            var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();
            if (informacion.Logros == null) return _RedirectToAction("Index", "Bienvenida");

            var esCrecimiento = opcionUpper == Constantes.CaminoBrillante.Logros.CRECIMIENTO;
            ViewBag.Informacion = esCrecimiento ? informacion.Logros[0] : informacion.Logros[1];
            ViewBag.Informacion = null;
            ViewBag.Vista = esCrecimiento ? "Crecimiento" : "Compromiso";

            /*
            ViewBag.LogrosResumen = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
            ViewBag.LogrosResumen = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
            ViewBag.LogrosResumen = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
            */

            return View();
        }

        public ActionResult Ofertas()
        {

            ViewBag.Moneda = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.urlSinImagenTiposyTonos);
            ViewBag.EsMobile = EsDispositivoMovil() || IsMobile();

            return View();
        }

       [Route("Indicadores/Crecimiento")]
        public ActionResult Crecimiento()
        {
            return RedirectToAction("Logros", "CaminoBrillante", new { opcion = "CRECIMIENTO" });
        }

        [Route("Indicadores/Compromiso")]
        public ActionResult Compromiso()
        {
            return RedirectToAction("Logros", "CaminoBrillante", new { opcion = "COMPROMISO" });
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult GetKits(int offset, int cantidadRegistros)
        {
            var lstKits = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            int _total = lstKits.Count;
            lstKits = lstKits.Skip(offset).Take(cantidadRegistros).ToList();           

            var estado = true;
            try
            {
                if (lstKits.Count < cantidadRegistros) estado = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                lista = lstKits,
                verMas = estado,
                total = _total
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDemostradores(int cantRegistros, int regMostrados, string codOrdenar, string codFiltro)
        {
            var oDemostrador = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante(cantRegistros, regMostrados, codOrdenar, codFiltro);
            var estado = true;
            try
            {
                if (oDemostrador.LstDemostradores.Count < cantRegistros) estado = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                lista = oDemostrador.LstDemostradores,
                verMas = estado,
                total = oDemostrador.Total
            }, JsonRequestBehavior.AllowGet);
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult GetLogros(string category)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }

            return Json(new { data = _caminoBrillanteProvider.GetLogroUnificadoCaminoBrillante() }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerNiveles()
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                //No alowed
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }
            return Json(_caminoBrillanteProvider.GetNivelesCaminoBrillante(true), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerLogros(string category)
        {            
            if (string.IsNullOrEmpty(category) || !_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                //No alowed
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }
            return Json(_caminoBrillanteProvider.GetLogroCaminoBrillante(category.ToUpper()), JsonRequestBehavior.AllowGet);
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        [HttpPost]
        public JsonResult ObtenerKits(int offset, int cantidadRegistros)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                //No alowed
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }
            var lstKits = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            return Json(new
            {
                lista = lstKits.Skip(offset).Take(cantidadRegistros).ToList(),
                verMas = lstKits.Count > (offset + cantidadRegistros)
            }, JsonRequestBehavior.AllowGet);
        }

        private RedirectToRouteResult _RedirectToAction(string actionName, string controllerName) {
            var area = (IsMobile() || EsDispositivoMovil()) ? "Mobile/" : ""; 
            return RedirectToAction(actionName, string.Format("{0}{1}", area, controllerName));
        }

        [HttpGet]
        public ActionResult EnterateMas(string nivel) {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return _RedirectToAction("Index", "Bienvenida");
            if (string.IsNullOrEmpty(nivel)) return _RedirectToAction("Index", "Bienvenida");

            var niveles = _caminoBrillanteProvider.GetNivelesCaminoBrillante();
            var nivelCB = niveles.FirstOrDefault(e => e.CodigoNivel == nivel);

            if(nivelCB == null) return _RedirectToAction("Index", "Bienvenida");
            switch (nivelCB.EnterateMas ) {
                case 1:

                    string key = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.secret_key);
                    string isoUsuario = userData.CodigoISO + '-' + userData.CodigoConsultora;
                    var svcLms = new ws_server();
                    var getUser = svcLms.ws_serverget_user(isoUsuario, userData.CampaniaID.ToString(), key);
                    var token = getUser.token;

                    var paramMiAcademia = new Models.MiAcademia.ParamUrlMiAcademiaModel()
                    {
                        Token = token,
                        IsoUsuario = isoUsuario
                    };
                    
                    if (!string.IsNullOrEmpty(nivelCB.EnterateMasParam))
                    {
                        paramMiAcademia.IdCurso = int.Parse(nivelCB.EnterateMasParam);
                    }
                                       
                    return Redirect(_miAcademiaProvider.GetUrl(Enumeradores.MiAcademiaUrl.Cursos, paramMiAcademia));
                case 2:
                    return Redirect(_issuuProvider.GetStringIssuRevista(nivelCB.EnterateMasParam, true));
            }

            return _RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult GetFiltrosCaminoBrillante()
        {
            var oFiltro = _caminoBrillanteProvider.GetDatosOrdenFiltros();
            return Json(new
            {
                lista = oFiltro
            }, JsonRequestBehavior.AllowGet);
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult GetCarruselCaminoBrillante()
        {
            return Json(_caminoBrillanteProvider.GetCarruselCaminoBrillante(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMisGanancias()
        {
            return Json(_caminoBrillanteProvider.GetMisGananciasCaminoBrillante(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult Anim(string key, string repeat)
        {
            switch (key) {
                case "Onbording":
                    _caminoBrillanteProvider.OnShowedOnbordingAnimation("1" == repeat);
                    break;
                case "Gesture":
                    _caminoBrillanteProvider.OnShowedGestureAnimation();
                    break;
                case "Level":
                    _caminoBrillanteProvider.OnShowedCambioNivelAnimation();
                    break;
            }

            return Json(new
            {
                value = true
            }, JsonRequestBehavior.AllowGet);
        }


    }
}