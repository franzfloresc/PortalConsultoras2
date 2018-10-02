using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BusquedaProductosController : BaseController
    {
        public ActionResult Index(string textoBusqueda = "")
        {
            return View();
        }
        
        
    }
    
}