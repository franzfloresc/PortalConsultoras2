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

        [HttpPost]
        public async Task<ActionResult> Guardar(UpSellingModel model)
        {
            model = SetAuditInfo(model);

            UpSellingModel result;
            if (model.UpSellingId > 0)
                result = await _upSellingProvider.Actualizar(userData.PaisID, model);
            else
                result = await _upSellingProvider.Guardar(userData.PaisID, model);

            return Json(ResultModel<UpSellingModel>.BuildOk(result), JsonRequestBehavior.AllowGet);
        }

        private UpSellingModel SetAuditInfo(UpSellingModel model)
        {
            model.UsuarioCreacion = userData.UsuarioNombre;
            model.FechaCreacion = DateTime.Now;
            if (model.UpSellingId > 0)
            {
                model.UsuarioModicacion = userData.UsuarioNombre;
                model.FechaModificacion = DateTime.Now;
            }

            if (model.Regalos == null)
                return model;

            model.Regalos.ForEach(regalo =>
            {
                regalo.UsuarioCreacion = userData.UsuarioNombre;
                regalo.FechaCreacion = DateTime.Now;
                if (regalo.UpSellingRegaloId > 0)
                {
                    regalo.UsuarioModicacion = userData.UsuarioNombre;
                    regalo.FechaModificacion = DateTime.Now;
                }
            });

            return model;
        }

        [HttpPost]
        public async Task<ActionResult> Eliminar(int upSellingId)
        {
            await _upSellingProvider.Eliminar(userData.PaisID, upSellingId);

            return Json(ResultModel<bool>.BuildOk(true));
        }

        [HttpPost]
        public async Task<ActionResult> Actualizar(UpSellingModel model)
        {
            model = SetAuditInfo(model);
            var result = await _upSellingProvider.Actualizar(userData.PaisID, model, true);

            return Json(ResultModel<UpSellingModel>.BuildOk(result), JsonRequestBehavior.AllowGet);
        }
    }
}
