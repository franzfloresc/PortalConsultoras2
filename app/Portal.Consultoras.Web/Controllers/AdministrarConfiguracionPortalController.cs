using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarConfiguracionPortalController : BaseAdmController
    {
        public ActionResult Index()
        {
            AdministrarConfiguracionPortalModel model = new AdministrarConfiguracionPortalModel();

            try
            {
                BEConfiguracionPortal configuracionPortalParametro =
                    new BEConfiguracionPortal { PaisID = userData.PaisID };

                BEConfiguracionPortal configuracionPortal;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    configuracionPortal = sv.ObtenerConfiguracionPortal(configuracionPortalParametro);
                }

                model.PaisID = userData.PaisID;
                model.EstadoSimplificacionCUV = configuracionPortal.EstadoSimplificacionCUV;
                model.EsquemaDAConsultora = configuracionPortal.EsquemaDAConsultora;
                model.TipoProcesoCarga = (configuracionPortal.TipoProcesoCarga != null && configuracionPortal.TipoProcesoCarga.Value);
                model.lstPais = DropDowListPaises();

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        [HttpPost]
        public JsonResult ActualizarConfiguracionPortal(int EstadoSimplificacionCUV, int EsquemaDAConsultora, int TipoProcesoCarga)
        {
            try
            {
                BEConfiguracionPortal configuracionPortal = new BEConfiguracionPortal
                {
                    EstadoSimplificacionCUV = Convert.ToBoolean(EstadoSimplificacionCUV),
                    EsquemaDAConsultora = Convert.ToBoolean(EsquemaDAConsultora),
                    TipoProcesoCarga = Convert.ToBoolean(TipoProcesoCarga),
                    PaisID = userData.PaisID
                };

                int resultado;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    resultado = sv.ActualizarConfiguracionPortal(configuracionPortal);
                }

                var operacion = resultado == 0
                    ? "No se actualizó la configuracion portal."
                    : "Se actualizó la configuracion portal.";

                return Json(new
                {
                    success = resultado == 1,
                    message = operacion
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

    }
}
