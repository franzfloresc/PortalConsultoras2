using System.Web.Mvc;
using System.Linq;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Common;
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

        public ActionResult Ofertas()
        {
            var model = GetOfertasCaminoBrillante();
            if (model == null || model.Count == 0) return RedirectToAction("Index", "CaminoBrillante");
            
            return View(model);
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