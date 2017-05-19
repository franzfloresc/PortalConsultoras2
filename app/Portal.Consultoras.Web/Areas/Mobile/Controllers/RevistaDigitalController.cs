using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            //if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
            //    return RedirectToAction("Index", "Bienvenida");
            
            var model = IndexModel();
            
            return View(model);
        }

        public ActionResult Inscripcion()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigitalSuscripcion))
                return RedirectToAction("Index", "Bienvenida");

            return View();
        }
        public ActionResult DetalleProducto()
        {
            return View();
        }

    }
}