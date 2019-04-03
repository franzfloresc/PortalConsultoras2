using System.Web.Mvc;
using System.Linq;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    //[RoutePrefix("CaminoBrillante")]
    public class CaminoBrillanteController : BaseController
    {
        #region CaminoBrillante
        // GET: CaminoBrillante
        public ActionResult Index()
        {
            //var informacion = SessionManager.GetConsultoraCaminoBrillante();
            //var _NivealActual = informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();

            var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();

            if (informacion != null)
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

                //ViewBag.TieneOfertasEspeciales = informacion.Niveles.Where(e => e.CodigoNivel == _NivealActual).Select(e => e.TieneOfertasEspeciales).FirstOrDefault();
                ViewBag.TieneOfertasEspeciales = informacion.Niveles.Where(e => e.CodigoNivel == nivelActual.ToString()).Select(e => e.TieneOfertasEspeciales).FirstOrDefault();
                ViewBag.ResumenLogros = informacion.ResumenLogros;
                ViewBag.Niveles = informacion.Niveles;
                ViewBag.NivelActual = nivelActual;
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

        [HttpGet]
        public JsonResult GetNiveles()
        {
            var informacion = SessionManager.GetConsultoraCaminoBrillante() ?? new ServiceUsuario.BEConsultoraCaminoBrillante();
            return Json(new { informacion.Niveles }, JsonRequestBehavior.AllowGet);
        }

        //[Route("CaminoBrillante/{Ofertas}"]
        public ActionResult Ofertas()
        {
            return View();
        }

        #endregion
    }
}