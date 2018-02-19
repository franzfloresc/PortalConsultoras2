using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Helpers;
using System.Web.Mvc;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers.Estrategias
{
    public class UpSellingController : BaseController
    {
        private readonly ZonificacionProvider _zonificacionProvider;

        public UpSellingController()
        {
            _zonificacionProvider = new ZonificacionProvider();
        }

        public ActionResult Index()
        {
            var campanas = _zonificacionProvider.ObtenerCampanias(userData.PaisID);
            var model = new UpSellingAdminModel()
            {
                PaisIso = userData.CodigoISO,
                Campanas = campanas,
                PaisNombre = userData.NombrePais,
                EsPaisEsika = Settings.Instance.PaisesEsika.Contains(userData.CodigoISO)
            };

            return View(model);
        }

        public JsonResult Obtener(string codigoCampana)
        {
            return Json(new { a = 'b' });
        }
    }
}
