using System.Linq;
using System.Web.Mvc;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CaminoBrillanteController : BaseMobileController
    {
        #region CaminoBrillante
        // GET: CaminoBrillante
        public ActionResult Index()
        {
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


            informacion.Niveles.ToList().ForEach(
                   e =>
                   {
                       e.Beneficios.ToList().ForEach(
                              x =>
                              {
                                  x.Icono = Constantes.CaminoBrillante.Beneficios.Iconos.Keys.Contains(x.Icono) ? Constantes.CaminoBrillante.Beneficios.Iconos[x.Icono] : "";
                              });
                   });

            return Json(new { informacion.Niveles }, JsonRequestBehavior.AllowGet);
        }

        //[Route("CaminoBrillante/{Ofertas}"]
        public ActionResult Ofertas()
        {
            return View();
        }

        #endregion

        //#region CaminoBrillante
        //// GET: CaminoBrillante
        //public ActionResult Index()
        //{
        //    var informacion = SessionManager.GetConsultoraCaminoBrillante();
        //    ViewBag.ResumenLogros = informacion.ResumenLogros;
        //    ViewBag.TieneOfertasEspeciales = informacion.Niveles[0].TieneOfertasEspeciales;
        //    return View();
        //}

        //public ActionResult Compromiso()
        //{
        //    return View();
        //}

        //public ActionResult Crecimiento()
        //{
        //    return View();
        //}

        //[HttpGet]
        //public JsonResult GetNiveles()
        //{
        //    var informacion = SessionManager.GetConsultoraCaminoBrillante();
        //    var _NivealActual = Convert.ToInt32(informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault());

        //    for (int i = 0; i <= informacion.Niveles.Count() - 1; i++)
        //    {
        //        informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{DIMEN}", "MDPI");

        //        if (i <= _NivealActual - 1)
        //            informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{STATE}", "A");
        //        else
        //            informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{STATE}", "I");
        //    }
        //    return Json(new { list = informacion, informacion.NivelConsultora[0].Nivel }, JsonRequestBehavior.AllowGet);
        //}
        //#endregion
    }
}