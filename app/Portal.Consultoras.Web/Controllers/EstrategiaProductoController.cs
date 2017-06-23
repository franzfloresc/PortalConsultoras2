using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaProductoController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult DetalleProducto(EstrategiaPedidoModel item)
        {
            try
            {
                EstrategiaOutModel model = new EstrategiaOutModel { Item = item };
                return Json(new { success = true, data = model });
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }
    }
}