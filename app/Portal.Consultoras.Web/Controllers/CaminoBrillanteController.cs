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
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return RedirectToAction("Index", "Bienvenida");

            ViewBag.Niveles = _caminoBrillanteProvider.GetNivelesCaminoBrillante(true);
            ViewBag.NivelActual = (_caminoBrillanteProvider.GetNivelActualConsultora() ??
                                     new ServiceUsuario.BEConsultoraCaminoBrillante.BENivelConsultoraCaminoBrillante()).Nivel;
            ViewBag.ResumenLogros = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
            ViewBag.TieneOfertasEspeciales = _caminoBrillanteProvider.TieneOfertasEspeciales();
            ViewBag.SimboloMoneda = userData.Simbolo;

            return View();
        }

        public ActionResult Logros(string opcion)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return RedirectToAction("Index", "Bienvenida");

            if (!string.IsNullOrEmpty(opcion))
            {
                if (opcion.ToUpper() == Constantes.CaminoBrillante.Logros.CRECIMIENTO || opcion.ToUpper() == Constantes.CaminoBrillante.Logros.COMPROMISO)
                {
                    var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();
                    if (informacion.Logros != null)
                    {
                        ViewBag.Informacion = opcion.ToUpper() == Constantes.CaminoBrillante.Logros.CRECIMIENTO ? informacion.Logros[0] : informacion.Logros[1];
                        ViewBag.Vista = opcion.ToUpper() == Constantes.CaminoBrillante.Logros.CRECIMIENTO ? 
                            "Crecimiento" : 
                            "Compromiso"; 
                    }
                    else
                        return RedirectToAction("Index", "Bienvenida");
                }
                else
                    return RedirectToAction("Index", "Bienvenida");
            }
            else
                return RedirectToAction("Index", "Bienvenida");
            ViewBag.CaminoBrillante = true;
            return View();
        }

        public ActionResult Ofertas()
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return RedirectToAction("Index", "Bienvenida");
            if(!_caminoBrillanteProvider.TieneOfertasEspeciales()) return RedirectToAction("Index", "CaminoBrillante");

            var lstKit = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            var lstDemo = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante();            
            ViewBag.Moneda = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.urlSinImagenTiposyTonos);
            ViewBag.CaminoBrillante = true;
            ViewBag.EsMobile = EsDispositivoMovil() || IsMobile();

            if (lstKit != null || lstDemo != null)
            {
                int cantDemo = lstDemo.Count();
                var model = lstKit;
                ViewBag.Demostradores = lstDemo;             
                return View(model);
            }
            else
                return RedirectToAction("Index", "CaminoBrillante");
        }

        public ActionResult Crecimiento()
        {
            return RedirectToAction("Logros", "CaminoBrillante", new { opcion = "CRECIMIENTO" });
        }

        public ActionResult Compromiso()
        {
            return RedirectToAction("Logros", "CaminoBrillante", new { opcion = "COMPROMISO" });
        }

        public JsonResult GetKits(int offset, int cantidadRegistros)
        {
            var lstKits = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            int total = lstKits.Count();
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

        public JsonResult GetDemostradores(int offset, int cantidadRegistros)
        {
            var lstDemostrador = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante();
            int total = lstDemostrador.Count();
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
        public JsonResult ObtenerDemostradores(int offset, int cantidadRegistros)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                //No alowed
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }
            var lstDemostrador = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante();
            return Json(new {
                lista = lstDemostrador.Skip(offset).Take(cantidadRegistros).ToList(),
                verMas = lstDemostrador.Count > (offset + cantidadRegistros)
            }, JsonRequestBehavior.AllowGet);
        }

    }
}