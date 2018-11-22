using System;
using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models.Recomendaciones;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers
{
    public class RecomendacionesController : BaseController
    {
        private readonly RecomendacionesProvider _recomendacionesProvider = new RecomendacionesProvider();

        // GET: Recomendaciones
        public ActionResult Index()
        {
            return View();
        }

        public async Task<JsonResult> ObtenerProductos(string cuv, string codigoProducto)
        {
            RecomendacionesModel recomendacionesModel;
            try
            {
                recomendacionesModel = await _recomendacionesProvider.ObtenerRecomendaciones(cuv, codigoProducto);
                recomendacionesModel.Productos = _recomendacionesProvider.ValidacionProductoAgregado(recomendacionesModel.Productos, SessionManager.GetDetallesPedido(), userData, revistaDigital, false, false);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                recomendacionesModel = new RecomendacionesModel();
            }
            return Json(recomendacionesModel, JsonRequestBehavior.AllowGet);
        }
        
    }
}