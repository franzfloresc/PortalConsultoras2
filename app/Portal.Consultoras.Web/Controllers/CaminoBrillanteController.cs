using System.Web.Mvc;
using System.Linq;
using System;

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
            ViewBag.TieneOfertasEspeciales = informacion.Niveles[0].TieneOfertasEspeciales;
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
            var informacion = SessionManager.GetConsultoraCaminoBrillante();
            var _NivealActual = Convert.ToInt32(informacion.NivelConsultora.Where(x => x.EsActual).Select(z => z.Nivel).FirstOrDefault());

            for (int i = 0; i <= informacion.Niveles.Count() - 1; i++)
            {
                informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{DIMEN}", "MDPI");

                if (i <= _NivealActual)
                    informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{STATE}", "A");
                else
                    informacion.Niveles[i].UrlImagenNivel = informacion.Niveles[i].UrlImagenNivel.Replace("{STATE}", "I");
            }
            return Json(new { list = informacion, informacion.NivelConsultora[0].Nivel }, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}