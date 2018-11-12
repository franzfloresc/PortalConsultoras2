using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
using System;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BuscadorController : BaseController
    {
        private readonly BuscadorYFiltrosProvider BuscadorYFiltrosProvider = new BuscadorYFiltrosProvider();
        
        public ActionResult Index()
        {
            return View();
        }

        public async Task<JsonResult> BusquedaProductos(BuscadorModel model)
        {
            BuscadorYFiltrosModel ProductosModel;
            try
            {
                var resultBuscador = await BuscadorYFiltrosProvider.GetBuscador(model);
                ProductosModel = await BuscadorYFiltrosProvider.ValidacionProductoAgregado(resultBuscador, SessionManager.GetDetallesPedido(), userData, revistaDigital, model.IsMobile);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ProductosModel = new BuscadorYFiltrosModel();
            }
            return Json(ProductosModel, JsonRequestBehavior.AllowGet);
        }
    }
}