using Portal.Consultoras.Common;
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
                var listaSeccion = ObtenerConfiguracionSeccion();
                var modelo = new EstrategiaPersonalizadaModel { ListaSeccion = listaSeccion };

                return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }
        
    }
}