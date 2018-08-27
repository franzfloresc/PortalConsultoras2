using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BuscadorController : BaseController
    {
        BuscadorYFiltrosProvider BuscadorYFiltrosProvider = new BuscadorYFiltrosProvider();
        // GET: Buscador
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

                var lista = userData.NuevasDescripcionesBuscador;
                var a = lista[Constantes.NuevaDescripcionBuscador.CLUBGANA];
                var b = lista[Constantes.NuevaDescripcionBuscador.SOLOHOY];
                var c = lista[Constantes.NuevaDescripcionBuscador.CATALOGOLBEL];

                buscadorModel.userData = userData;
                buscadorModel.revistaDigital = revistaDigital;
                buscadorModel.TextoBusqueda = busqueda;
                buscadorModel.CantidadProductos = totalResultados;

                resultBuscador = await BuscadorYFiltrosProvider.GetBuscador(buscadorModel);

                ListaProductosModel = BuscadorYFiltrosProvider.ValidacionProductoAgregado(resultBuscador, sessionManager.GetDetallesPedido(), userData);
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