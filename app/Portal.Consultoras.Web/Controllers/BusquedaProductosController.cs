using Portal.Consultoras.Web.Models.Buscador;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BusquedaProductosController : BaseController
    {
        public ActionResult Index(string q = "")
        {
            var model = new BusquedaProductoOutModel
            {
                TextoBusqueda = q,
                ListaOrdenamiento = userData.ListaOrdenamientoFiltrosBuscador
            };
            return View(model);
        }
        
        
    }
    
}