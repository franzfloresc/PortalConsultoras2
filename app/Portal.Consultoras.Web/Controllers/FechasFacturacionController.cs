using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Controllers
{
    public class FechasFacturacionController : BaseController
    {

        public ActionResult Index()
        {
            return View();
        }


        public JsonResult GetFechasFacturacion()
        {
            BEFechaFacturacion objBEFechaFacturacion;
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                   objBEFechaFacturacion = sv.GetFechasFacturacionConsultora(userData.PaisID, userData.CodigoConsultora,  userData.CampaniaID, Constantes.CantidadFechasFacturacion.CantidadAnterior, Constantes.CantidadFechasFacturacion.CantidadProxima);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }


            return Json(0, JsonRequestBehavior.AllowGet);
        }

    }
}