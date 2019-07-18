using Portal.Consultoras.Web.Models.Recomendaciones;
using Portal.Consultoras.Web.Providers;
using System;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ProductoRecomendadoController : BaseController
    {
        private readonly ProductoRecomendadoProvider _productoRecomendadoProvider = new ProductoRecomendadoProvider();

        public ActionResult Index()
        {
            if (IsMobile())
            {
                return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
            }
            return RedirectToAction("Index", "Ofertas");
        }

        public async Task<JsonResult> ObtenerProductos(string cuv, string codigoProducto)
        {
            if (!_productoRecomendadoProvider.ValidarRecomendacionActivo())
                return Json(new RecomendacionesModel(), JsonRequestBehavior.AllowGet);

            RecomendacionesModel recomendacionesModel;
            try
            {
                await _productoRecomendadoProvider.GetPersonalizacion(userData, true, true);
                recomendacionesModel = await _productoRecomendadoProvider.ObtenerRecomendaciones(cuv, codigoProducto, IsMobile());

                if (!_productoRecomendadoProvider.ValidarCantidadMinima(recomendacionesModel))
                    return Json(new RecomendacionesModel(), JsonRequestBehavior.AllowGet);

                recomendacionesModel.Productos = _productoRecomendadoProvider.ValidacionProductoAgregado(recomendacionesModel.Productos, SessionManager.GetDetallesPedido(), userData, revistaDigital, IsMobile(), false, true, SessionManager.GetRevistaDigital().EsSuscrita);
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