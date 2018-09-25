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
        BuscadorYFiltrosProvider BuscadorYFiltrosProvider = new BuscadorYFiltrosProvider();
        
        public ActionResult Index()
        {
            return View();
        }

        public async Task<JsonResult> BusquedaProductos(string busqueda, int totalResultados)
        {
            var ListaProductosModel = new List<BuscadorYFiltrosModel>();
            try
            {
                var resultBuscador = new List<BuscadorYFiltrosModel>();
                var buscadorModel = new BuscadorModel();

                buscadorModel.userData = userData;
                buscadorModel.revistaDigital = revistaDigital;
                buscadorModel.TextoBusqueda = busqueda;
                buscadorModel.CantidadProductos = totalResultados;

                resultBuscador = await BuscadorYFiltrosProvider.GetBuscador(buscadorModel);

                ListaProductosModel = await BuscadorYFiltrosProvider.ValidacionProductoAgregado(resultBuscador, SessionManager.GetDetallesPedido(), userData, revistaDigital,false);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ListaProductosModel = new List<BuscadorYFiltrosModel>();
            }
            return Json(ListaProductosModel, JsonRequestBehavior.AllowGet);
        }
    }
}