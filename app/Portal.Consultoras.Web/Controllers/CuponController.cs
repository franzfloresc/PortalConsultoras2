using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CuponController : BaseController
    {
        [HttpPost]
        public JsonResult ActualizarCupon(CuponModel cupon)
        {
            var success = true;
            return Json(new
            {
                success = success,
                message = "Ocurrió un error al ejecutar la operación."
            });
        }
    }
}