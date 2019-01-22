using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BuscadorController : BaseController
    {
        private readonly BuscadorYFiltrosProvider _buscadorYFiltrosProvider = new BuscadorYFiltrosProvider();

        public ActionResult Index()
        {
            return View();
        }

        public async Task<JsonResult> BusquedaProductos(BuscadorModel model)
        {
            BuscadorYFiltrosModel productosModel;
            try
            {
                await _buscadorYFiltrosProvider.GetPersonalizacion(userData, true, true);
                productosModel = await _buscadorYFiltrosProvider.GetBuscador(model);
                productosModel.productos = _buscadorYFiltrosProvider.ValidacionProductoAgregado(productosModel.productos, SessionManager.GetDetallesPedido(), userData, revistaDigital, model.IsMobile, model.IsHome, false);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel = new BuscadorYFiltrosModel();
            }
            return Json(productosModel, JsonRequestBehavior.AllowGet);
        }


        public async Task<JsonResult> ListarCategorias(BuscadorModel model)
        {
            List<BuscadorYFiltrosCategoriaModel> productosModel;
            try
            {
                await _buscadorYFiltrosProvider.GetPersonalizacion(userData, true, true);
                productosModel = await _buscadorYFiltrosProvider.GetCategorias(model);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel = new List<BuscadorYFiltrosCategoriaModel>();
            }
            return Json(productosModel, JsonRequestBehavior.AllowGet);
        }



    }
}