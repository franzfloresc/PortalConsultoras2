using System.Web.Mvc;
using System.Linq;
using Portal.Consultoras.Common;
using System;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers
{
    //[RoutePrefix("CaminoBrillante")]
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

            

            ViewBag.ResumenLogros = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
            ViewBag.Niveles = _caminoBrillanteProvider.GetNivelesCaminoBrillante(true);
            var nivelActual = _caminoBrillanteProvider.GetNivelConsultoraCaminoBrillante();
            var _nivelActual = 1;
            if (nivelActual != null) int.TryParse(nivelActual.Nivel, out _nivelActual);
            ViewBag.NivelActual = _nivelActual;
            ViewBag.TieneOfertasEspeciales = _caminoBrillanteProvider.TieneOfertasEspeciles(_nivelActual);
            ViewBag.CaminoBrillante = true;
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
            int cantKit = lstKit.Count();
            int cantDemo = lstDemo.Count();
            ViewBag.Moneda = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.urlSinImagenTiposyTonos);
            ViewBag.CaminoBrillante = true;

            if (lstKit != null || lstDemo != null)
            {
                var model = lstKit;
                ViewBag.Demostradores = lstDemo; //temporal
                ViewBag.CantidadKit = "Mostrando " + cantKit + " de " + cantKit;  //temporal
                ViewBag.CantidadDemostradores = "Mostrando " + cantDemo + " de " + cantDemo;  //temporal              
                return View(model);
            }
            else
                return RedirectToAction("Index", "CaminoBrillante");
        }

        public JsonResult GetKits(int offset, int cantidadRegistros)
        {
            var lstKits = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            lstKits = lstKits.Skip(offset).Take(cantidadRegistros).ToList();

            var estado = false;
            try
            {
                if (lstKits.Count > cantidadRegistros) estado = true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                lista = lstKits,
                verMas = true
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDemostradores(int offset, int cantidadRegistros)
        {
            var lstDemostrador = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante();
            lstDemostrador = lstDemostrador.Skip(offset).Take(cantidadRegistros).ToList();

            var estado = false;
            try
            {
                if (lstDemostrador.Count > cantidadRegistros) estado = true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                lista = lstDemostrador,
                verMas = true
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetNiveles(string nivel)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) {
                //No alowed
                return Json(new {}, JsonRequestBehavior.AllowGet);
            }
            string nivelSiguiente = null;
            return Json(new { Niveles = _caminoBrillanteProvider.GetNivelesCaminoBrillante(true).Where(e => e.CodigoNivel == nivel).ToList(), Moneda = userData.Simbolo, MontoFaltante = _caminoBrillanteProvider.MontoFaltanteSiguienteNivel(out nivelSiguiente), NivelSiguiente = nivelSiguiente }, JsonRequestBehavior.AllowGet);
        }

        //[HttpPost]
        public JsonResult GetLogros(string category)
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante())
            {
                //No alowed
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { data = _caminoBrillanteProvider.GetLogroCaminoBrillante(category) }, JsonRequestBehavior.AllowGet);
        }

    }
}