﻿
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
        #region CaminoBrillante
        private readonly CaminoBrillanteProvider _caminoBrillanteProvider;
        public CaminoBrillanteController()
        {
            _caminoBrillanteProvider = new CaminoBrillanteProvider();
        }

        public ActionResult Index()
        {
            var informacion = _caminoBrillanteProvider.ResumenConsultoraCaminoBrillante();
            if (informacion == null || informacion.NivelConsultora == null || informacion.NivelConsultora.Count() == 0) return RedirectToAction("Index", "Bienvenida");

            int nivelActual = 0;
            int.TryParse(informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault(), out nivelActual);

            informacion.Niveles.ToList().ForEach(
                e =>
                {
                    int nivel = 0;
                    int.TryParse(e.CodigoNivel, out nivel);
                    e.UrlImagenNivel = Constantes.CaminoBrillante.Niveles.Iconos.Keys.Contains(e.CodigoNivel) ? Constantes.CaminoBrillante.Niveles.Iconos[e.CodigoNivel][nivel <= nivelActual ? 1 : 0] : "";
                });

            ViewBag.TieneOfertasEspeciales = informacion.Niveles.Where(e => e.CodigoNivel == nivelActual.ToString()).Select(e => e.TieneOfertasEspeciales).FirstOrDefault();
            ViewBag.ResumenLogros = informacion.ResumenLogros;
            ViewBag.Niveles = informacion.Niveles;
            ViewBag.NivelActual = nivelActual;
            

            return View();
        }

        public ActionResult Logros(string opcion)
        {
            if (!string.IsNullOrEmpty(opcion))
            {
                var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();
                if (informacion.Logros != null)
                {
                    ViewBag.Informacion = opcion == "Crecimiento" ? informacion.Logros[0] : informacion.Logros[1];
                    ViewBag.Vista = opcion == "Crecimiento" ? "Crecimiento" : "Compromiso";
                }
                
                else
                    return RedirectToAction("Index", "Bienvenida");
            }
            return View();
        }

        public ActionResult Ofertas()
        {
            var lstKit = _caminoBrillanteProvider.GetKitCaminoBrillante();
            var lstDemo = _caminoBrillanteProvider.GetDemostradoresCaminoBrillante();
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
            var lstKits = _caminoBrillanteProvider.GetKitCaminoBrillante();
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
            var lstDemostrador = _caminoBrillanteProvider.GetDemostradoresCaminoBrillante();
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
        #endregion
    }
}