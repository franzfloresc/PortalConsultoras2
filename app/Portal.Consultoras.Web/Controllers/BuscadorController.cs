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
        private readonly BuscadorYFiltrosProvider BuscadorYFiltrosProvider = new BuscadorYFiltrosProvider();
        // GET: Buscador
        public ActionResult Index()
        {
            return View();
        }

        public async Task<JsonResult> BusquedaProductos(BuscadorModel model)
        {
            List<BuscadorYFiltrosModel> ListaProductosModel;
            try
            {
                var buscadorModel = new BuscadorModel
                {
                    TextoBusqueda = model.TextoBusqueda,
                    CantidadProductos = 20
                };

                var resultBuscador = await BuscadorYFiltrosProvider.GetBuscador(buscadorModel);

                ListaProductosModel = await BuscadorYFiltrosProvider.ValidacionProductoAgregado(resultBuscador, SessionManager.GetDetallesPedido(), userData, revistaDigital, false);
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