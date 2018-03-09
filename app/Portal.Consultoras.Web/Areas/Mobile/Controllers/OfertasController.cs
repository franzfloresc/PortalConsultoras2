using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasController : BaseMobileController
    {
        public ActionResult Index()
        {
            try
            {
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = ObtenerConfiguracionSeccion(revistaDigital)
                };

                return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Revisar()
        {
            try
            {
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = ObtenerConfiguracionSeccion(revistaDigital)
                };

                return View("Index", modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

    }
}