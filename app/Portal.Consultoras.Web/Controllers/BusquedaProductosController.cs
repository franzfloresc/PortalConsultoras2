using Portal.Consultoras.Web.Models.Buscador;
using System.Web.Mvc;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class BusquedaProductosController : BaseController
    {
        public ActionResult Index(string q = "")
        {
            var model = new BusquedaProductoOutModel
            {
                TextoBusqueda = q,
                ListaOrdenamiento = userData.ListaOrdenamientoFiltrosBuscador,
                TotalProductosPagina = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.TotalProductosPaginaResultado),
                TotalCaracteresDescripcion = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.TotalCaracteresDescPaginaResultado),
                MostrarOpcionesOrdenamiento = ObtenerConfiguracionBuscador(Constantes.TipoConfiguracionBuscador.MostrarOpcionesOrdenamiento).ToBool()
            };
            return View(model);
        }
        
        
    }
    
}