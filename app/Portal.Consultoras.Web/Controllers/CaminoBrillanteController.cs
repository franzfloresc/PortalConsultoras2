﻿using System.Web.Mvc;
using System.Linq;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Controllers
{
    //[RoutePrefix("CaminoBrillante")]
    public class CaminoBrillanteController : BaseController
    {
        #region CaminoBrillante
        // GET: CaminoBrillante


        public ActionResult Index()
        {
            var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();

            if (informacion != null)
            {
                if (informacion.NivelConsultora != null)
                {
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
                }
                else
                    return RedirectToAction("Index", "Bienvenida");
            }
            return View();
        }

        public ActionResult Compromiso()
        {
            return View();
        }

        public ActionResult Crecimiento()
        {
            return View();
        }

        public ActionResult Ofertas()
        {
            var model = GetOfertasCaminoBrillante();
            if (model == null || model.Count == 0) return RedirectToAction("Index", "CaminoBrillante");
            return View(model);
        }

        [HttpPost]
        public JsonResult GetNiveles(string nivel)
        {
            var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();

            var Beneficios = informacion.Niveles.Where(
                e => e.CodigoNivel == nivel.ToString()).Select(z => new { z.Beneficios, z.DescripcionNivel, z.MontoMinimo, z.UrlImagenNivel });

            Beneficios.ToList().ForEach(
                e =>
                {
                    e.Beneficios.ToList().ForEach(x =>
                    {
                        x.Icono = Constantes.CaminoBrillante.Beneficios.Iconos.Keys.Contains(x.Icono) ? Constantes.CaminoBrillante.Beneficios.Iconos[x.Icono] : x.Icono;
                    });
                });

            return Json(new { Niveles = Beneficios }, JsonRequestBehavior.AllowGet);
        }

        private List<BEOfertaCaminoBrillante> GetOfertasCaminoBrillante()
        {
            try
            {
                var ofertas = SessionManager.GetOfertasCaminoBrillante();
                if (ofertas == null || ofertas.Count > 0)
                {
                    using (var svc = new UsuarioServiceClient())
                        ofertas = svc.GetOfertasCaminoBrillante(userData.PaisID, "201904").ToList();
                    if (ofertas != null)
                        SessionManager.SetOfertasCaminoBrillante(ofertas);
                }

                return ofertas;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return null;
            }
        }
        #endregion
    }
}