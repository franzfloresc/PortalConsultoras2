using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BuscadorController : BaseMobileController
    {
        private readonly BuscadorYFiltrosProvider BuscadorYFiltrosProvider = new BuscadorYFiltrosProvider();
        // GET: Mobile/Buscador
        public ActionResult Index()
        {
            return View();
        }

        public async Task<JsonResult> BusquedaProductos(string busqueda, int totalResultados)
        {
            List<BuscadorYFiltrosModel> ListaProductosModel;
            try
            {

                var buscadorModel = new BuscadorModel
                {
                    userData = userData,
                    revistaDigital = revistaDigital,
                    TextoBusqueda = busqueda,
                    CantidadProductos = totalResultados
                };

                var resultBuscador = await BuscadorYFiltrosProvider.GetBuscador(buscadorModel);

                ListaProductosModel = await BuscadorYFiltrosProvider.ValidacionProductoAgregado(resultBuscador, SessionManager.GetDetallesPedido(), userData, revistaDigital, true);

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