using System.Web.Mvc;
using System.Linq;
using Portal.Consultoras.Common;
using System;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteController : BaseController
    {
        private readonly CaminoBrillanteProvider _caminoBrillanteProvider;

        public CaminoBrillanteController()
        {
            _caminoBrillanteProvider = new CaminoBrillanteProvider();
        }

        public ActionResult Index()
        {
            try
            {
                if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return RedirectToAction("Index", "Bienvenida");

                ViewBag.Niveles = _caminoBrillanteProvider.GetNivelesCaminoBrillante(true);
                ViewBag.NivelActual = (_caminoBrillanteProvider.GetNivelActualConsultora() ??
                                         new ServiceUsuario.BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante()).Nivel;
                ViewBag.ResumenLogros = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
                ViewBag.TieneOfertasEspeciales = _caminoBrillanteProvider.TieneOfertasEspeciales();
                ViewBag.SimboloMoneda = userData.Simbolo;

                return View();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Index", "Bienvenida");
            }

        }

        public ActionResult Logros(string opcion)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return RedirectToAction("Index", "Bienvenida");
            if (string.IsNullOrEmpty(opcion)) return RedirectToAction("Index", "Bienvenida");

            var opcionUpper = opcion.ToUpper();
            if (opcionUpper != Constantes.CaminoBrillante.Logros.CRECIMIENTO && opcionUpper != Constantes.CaminoBrillante.Logros.COMPROMISO)
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();
            if (informacion.Logros == null) return RedirectToAction("Index", "Bienvenida");

            var esCrecimiento = opcionUpper == Constantes.CaminoBrillante.Logros.CRECIMIENTO;
            ViewBag.Informacion = esCrecimiento ? informacion.Logros[0] : informacion.Logros[1];
            ViewBag.Vista = esCrecimiento ? "Crecimiento" : "Compromiso";
            ViewBag.CaminoBrillante = true;
            return View();
        }

        public ActionResult Ofertas()
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return RedirectToAction("Index", "Bienvenida");
            if(!_caminoBrillanteProvider.TieneOfertasEspeciales()) return RedirectToAction("Index", "CaminoBrillante");

            var lstKit = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            var lstDemo = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante("");            
            ViewBag.Moneda = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.urlSinImagenTiposyTonos);
            ViewBag.CaminoBrillante = true;
            ViewBag.EsMobile = EsDispositivoMovil() || IsMobile();

            if (lstKit != null || lstDemo != null)
            {
                var model = lstKit;
                ViewBag.Demostradores = lstDemo;             
                return View(model);
            }
            else return RedirectToAction("Index", "CaminoBrillante");
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

        public JsonResult GetKits(int offset, int cantidadRegistros)
        {
            var lstKits = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            int total = lstKits.Count;
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
                total = total
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDemostradores(int offset, int cantidadRegistros, string codigoOrden)
        {
            var lstDemostrador = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante(codigoOrden);
            int total = lstDemostrador.Count;
            lstDemostrador = lstDemostrador.Skip(offset).Take(cantidadRegistros).ToList();

            var estado = true;
            try
            {
                if (lstDemostrador.Count < cantidadRegistros) estado = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                lista = lstDemostrador,
                verMas = estado,
                total = total
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetLogros(string category)
        {
            if ( string.IsNullOrEmpty(category) || !_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                //No alowed
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = _caminoBrillanteProvider.GetLogroCaminoBrillante(category.ToUpper()) }, JsonRequestBehavior.AllowGet);
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

        [HttpPost]
        public JsonResult ObtenerDemostradores(int offset, int cantidadRegistros, string codOrden)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                //No alowed
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }
            var lstDemostrador = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante(codOrden);
            return Json(new {
                lista = lstDemostrador.Skip(offset).Take(cantidadRegistros).ToList(),
                verMas = lstDemostrador.Count > (offset + cantidadRegistros)
            }, JsonRequestBehavior.AllowGet);
        }

    }
}