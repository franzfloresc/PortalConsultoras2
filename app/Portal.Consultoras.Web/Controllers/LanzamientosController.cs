using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class LanzamientosController : BaseLanzamientosController
    {
        public override ActionResult Detalle(string cuv, int campaniaId)
        {
            try
            {
                return base.Detalle(cuv, campaniaId);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Ofertas");
        }
        
    }
}