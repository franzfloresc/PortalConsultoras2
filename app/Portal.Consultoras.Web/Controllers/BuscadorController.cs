using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
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

       
        public async Task<JsonResult> BusquedaProductos(string busqueda)
        {
            var ListaProductosModel = new List<BuscadorYFiltrosModel>();
            try
            {
                var buscadorModel = new BuscadorModel();
                var configuracionPais = sessionManager.GetBuscadorYFiltros();
                var valores = configuracionPais.ConfiguracionPaisDatos.Where(x => x.Codigo == Constantes.TipoConfiguracionBuscador.TotalResultadosBuscador).ToList();
                var TotalResultadosBuscador = 20;

                if (valores.Any())
                {
                    TotalResultadosBuscador = valores[0].Valor1.ToInt();
                }

                buscadorModel.TextoBusqueda = busqueda;
                buscadorModel.CantidadProductos = TotalResultadosBuscador;

                ListaProductosModel = await BuscadorYFiltrosProvider.GetBuscador(userData, buscadorModel);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ListaProductosModel = new List<BuscadorYFiltrosModel>();
            }
            return Json(ListaProductosModel, JsonRequestBehavior.AllowGet);
        }

        private List<BuscadorYFiltrosModel> Data()
        {
            return new List<BuscadorYFiltrosModel>();
        }
    }
}