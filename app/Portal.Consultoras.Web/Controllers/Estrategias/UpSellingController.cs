using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Helpers;
using System.Web.Mvc;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
    public class UpSellingController : BaseController
    {
        private readonly ZonificacionProvider _zonificacionProvider;
        private readonly UpSellingProvider _upSellingProvider;

        public UpSellingController()
        {
            _upSellingProvider = new UpSellingProvider();
            _zonificacionProvider = new ZonificacionProvider();
        }

        public async Task<ActionResult> Index()
        {
            var campanas = await _zonificacionProvider.ObtenerCampanias(userData.PaisID);
            var model = new UpSellingAdminModel()
            {
                PaisIso = userData.CodigoISO,
                Campanas = campanas,
                PaisNombre = userData.NombrePais,
                EsPaisEsika = Settings.Instance.PaisesEsika.Contains(userData.CodigoISO)
            };

            return View(model);
        }

        [HttpGet]
        public async Task<JsonResult> Obtener(string codigoCampana)
        {
            if (string.IsNullOrEmpty(codigoCampana))
                codigoCampana = null;

            var upsellings = await _upSellingProvider.ObtenerAsync(userData.PaisID, codigoCampana);
            return Json(ResultModel<IEnumerable<UpSellingModel>>.BuildOk(upsellings), JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerRegalos(int upSellingId)
        {
            var upSelling = await _upSellingProvider.ObtenerRegalos(userData.PaisID, upSellingId);

            return Json(ResultModel<UpSellingModel>.BuildOk(upSelling), JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public async Task<JsonResult> ObtenerOfertaFinalMontoMeta(int upSellingId)
        {
            var upSelling = await _upSellingProvider.ObtenerOfertaFinalMontoMeta(userData.PaisID, upSellingId);

            return Json(ResultModel<IEnumerable<OfertaFinalMontoMetaModel>>.BuildOk(upSelling), JsonRequestBehavior.AllowGet);
        }


        public async Task<ActionResult> ExportarExcel(int upSellingId)
        {
            var upSelling = await _upSellingProvider.ObtenerOfertaFinalMontoMeta(userData.PaisID,   upSellingId);

            Dictionary<string, string> dic =
                new Dictionary<string, string> {
                    { "CampaniaId", "CampaniaId" },
                       { "ConsultoraId", "ConsultoraId" },
                          { "MontoPedido", "MontoPedido" },
                             { "GapMinimo", "GapMinimo" },
                                { "GapMaximo", "GapMaximo" },
                                   { "GapAgregar", "GapAgregar" },
                                      { "MontoMeta", "MontoMeta" },
                          { "Cuv", "Cuv" },
                          { "TipoRango", "TipoRango" },
                    { "FechaRegistro", "FechaRegistro" } };

             



        Util.ExportToExcel("ReporteNivelesRiesgo", upSelling.ToList(), dic);
            return View();
        }

    }
}
