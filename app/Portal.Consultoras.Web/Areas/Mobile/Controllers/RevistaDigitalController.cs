using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                return RedirectToAction("Index", "Bienvenida");

            var model = IndexModel();
            
            return View(model);
        }

        public ActionResult Detalle(int id)
        {
            try
            {
                var model = DetalleModel(id);
                return View(model);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Inscripcion()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigitalSuscripcion))
                return RedirectToAction("Index", "Bienvenida");

            return View();
        }
    }
}