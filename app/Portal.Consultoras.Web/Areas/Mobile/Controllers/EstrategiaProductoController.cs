using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class EstrategiaProductoController : BaseMobileController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult ObtenerDetalleProducto(EstrategiaPedidoModel item)
        {
            Web.Controllers.EstrategiaProductoController controllerDesktop = new Web.Controllers.EstrategiaProductoController();
            return controllerDesktop.ObtenerDetalleProducto(item);
        }

        public ActionResult DetalleProducto()
        {
            return View();
        }
    }
}