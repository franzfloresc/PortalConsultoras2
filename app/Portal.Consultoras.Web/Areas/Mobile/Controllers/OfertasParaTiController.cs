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
        public ActionResult Detalle(int id)
        {
            var modelo = EstrategiaGetDetalle(id);
            return View(modelo);
        }

    }
}