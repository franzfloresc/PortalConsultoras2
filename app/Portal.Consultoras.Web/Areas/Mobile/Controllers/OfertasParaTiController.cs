using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasParaTiController : BaseEstrategiaController
    {
        
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Detalle()
        {
            var modelo = EstrategiaGetDetalle(4244);
            return View(modelo);
        }

    }
}