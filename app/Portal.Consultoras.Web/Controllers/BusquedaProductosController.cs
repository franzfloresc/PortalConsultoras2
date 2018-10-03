using Portal.Consultoras.Web.Models.Buscador;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BusquedaProductosController : BaseController
    {
        public ActionResult Index(string textoBusqueda = "")
        {
            var model = new BusquedaProductoOutModel
            {
                TextoBusqueda = textoBusqueda
            };
            return View(model);
        }
        
        
    }
    
}