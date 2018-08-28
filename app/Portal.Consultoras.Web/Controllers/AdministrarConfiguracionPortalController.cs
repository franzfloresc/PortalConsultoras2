using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarConfiguracionPortalController : BaseController
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
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
