using System.Web.Mvc;
using System.Linq;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteController : BaseController
    {
        #region CaminoBrillante
        // GET: CaminoBrillante
        public ActionResult Index()
        {
            var informacion = SessionManager.GetConsultoraCaminoBrillante();
            ViewBag.ResumenLogros = informacion.ResumenLogros;

            int nivelActual = 0;
            int.TryParse(informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault(), out nivelActual);

            var _NivealActual = informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault();

            ViewBag.TieneOfertasEspeciales = informacion.Niveles.Where(e => e.CodigoNivel == _NivealActual).Select(e => e.TieneOfertasEspeciales).FirstOrDefault();
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
            
            int nivelActual = 0;
            int.TryParse(informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault(), out nivelActual);

            var _NivealActual = Convert.ToInt32(informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault());
           
            informacion.Niveles.ToList().ForEach(
                e => {
                    int nivel = 0;
                    int.TryParse(e.CodigoNivel, out nivel);
                    e.UrlImagenNivel = Constantes.CaminoBrillante.Niveles.Iconos.Keys.Contains(e.CodigoNivel) ? Constantes.CaminoBrillante.Niveles.Iconos[e.CodigoNivel][nivel <= nivelActual ? 1 : 0 ] : "";
                });



            return Json(new { list = informacion, informacion.NivelConsultora[0].Nivel }, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}