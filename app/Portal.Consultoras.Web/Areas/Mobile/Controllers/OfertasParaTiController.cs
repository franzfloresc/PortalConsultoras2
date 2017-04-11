using Portal.Consultoras.Web.Controllers;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasParaTiController : BaseEstrategiaController
    {
        
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Detalle(int id, int origen)
        {
            var modelo = EstrategiaGetDetalle(id);
            modelo.Origen = origen;
            return View(modelo);
        }

    }
}