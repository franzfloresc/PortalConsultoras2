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
                    RedirectToAction("Index", "Bienvenida");
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
            //var model = GetOfertasCaminoBrillante();
            //if (model == null || model.Count == 0) return RedirectToAction("Index", "CaminoBrillante");

            //return View(model);
            return null;
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