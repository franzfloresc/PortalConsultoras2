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

            ViewBag.TieneOfertasEspeciales = _caminoBrillanteProvider.TieneOfertasEspeciles();
            ViewBag.ResumenLogros = _caminoBrillanteProvider.GetLogroCaminoBrillante(Constantes.CaminoBrillante.Logros.RESUMEN);
            ViewBag.Niveles = _caminoBrillanteProvider.GetNivelesCaminoBrillante();
            var nivelActual = _caminoBrillanteProvider.GetNivelConsultoraCaminoBrillante();
            var _nivelActual = 1;
            if (nivelActual != null) int.TryParse(nivelActual.Nivel, out _nivelActual);
            ViewBag.NivelActual = _nivelActual;
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
                        ViewBag.Vista = opcion.ToUpper() == Constantes.CaminoBrillante.Logros.CRECIMIENTO ? Constantes.CaminoBrillante.Logros.CRECIMIENTO.ToLower() : Constantes.CaminoBrillante.Logros.COMPROMISO.ToLower(); 
                    }
                    else
                        return RedirectToAction("Index", "Bienvenida");
                }
                else
                    return RedirectToAction("Index", "Bienvenida");
            }
            else
                return RedirectToAction("Index", "Bienvenida");
            return View();
        }

        public ActionResult Ofertas()
        {
            if (!_caminoBrillanteProvider.ValidacionCaminoBrillante()) return RedirectToAction("Index", "Bienvenida");

            var lstKit = _caminoBrillanteProvider.GetKitsCaminoBrillante();
            var lstDemo = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante();
            int cantKit = lstKit.Count();
            int cantDemo = lstDemo.Count();
            ViewBag.Moneda = userData.Simbolo;
            ViewBag.RutaImagenNoDisponible = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.urlSinImagenTiposyTonos);

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

        public JsonResult GetKits(int cantidadRegistros)
        {
            var lstKits = _caminoBrillanteProvider.GetKitsCaminoBrillante();
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
                verMas = estado
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDemostradores(int cantidadRegistros)
        {
            var lstDemostrador = _caminoBrillanteProvider.GetDesmostradoresCaminoBrillante();
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
                verMas = estado
            }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult GetNiveles(string nivel)
        {
            var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();
            var Beneficios = informacion.Niveles.Where(
                e => e.CodigoNivel == nivel.ToString()).Select(z => new { z.Beneficios, z.DescripcionNivel, z.MontoMinimo, z.UrlImagenNivel });

            var MontoAcumuladoPedido = userData.MontoDeuda;
            var Moneda = userData.Simbolo;

            Beneficios.ToList().ForEach(
                e =>
                {
                    e.Beneficios.ToList().ForEach(x =>
                    {
                        x.Icono = Constantes.CaminoBrillante.Beneficios.Iconos.Keys.Contains(x.Icono) ? Constantes.CaminoBrillante.Beneficios.Iconos[x.Icono] : x.Icono;
                    });
                });

            return Json(new { Niveles = Beneficios, Moneda, MontoAcumuladoPedido }, JsonRequestBehavior.AllowGet);
        }

    }
}