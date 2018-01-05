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
            BEConfiguracionPortal configuracionPortal = new BEConfiguracionPortal();

            try
            {

                BEConfiguracionPortal configuracionPortalParametro = new BEConfiguracionPortal();
                configuracionPortalParametro.PaisID = UserData().PaisID;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    configuracionPortal = sv.ObtenerConfiguracionPortal(configuracionPortalParametro);

                }

                model.PaisID = UserData().PaisID;
                model.EstadoSimplificacionCUV = configuracionPortal.EstadoSimplificacionCUV;
                model.EsquemaDAConsultora = configuracionPortal.EsquemaDAConsultora;
                model.TipoProcesoCarga = (configuracionPortal.TipoProcesoCarga != null && configuracionPortal.TipoProcesoCarga.Value);
                model.lstPais = DropDowListPaises();


            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return View(model);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }


        [HttpPost]
        public JsonResult ActualizarConfiguracionPortal(int EstadoSimplificacionCUV, int EsquemaDAConsultora, int TipoProcesoCarga)
        {
            int resultado = 0;
            string operacion = "";

            try
            {
                BEConfiguracionPortal configuracionPortal = new BEConfiguracionPortal();
                configuracionPortal.EstadoSimplificacionCUV = Convert.ToBoolean(EstadoSimplificacionCUV);
                configuracionPortal.EsquemaDAConsultora = Convert.ToBoolean(EsquemaDAConsultora);
                configuracionPortal.TipoProcesoCarga = Convert.ToBoolean(TipoProcesoCarga);
                configuracionPortal.PaisID = UserData().PaisID;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    resultado = sv.ActualizarConfiguracionPortal(configuracionPortal);
                }

                if (resultado == 0)
                {
                    operacion = "No se actualizó la configuracion portal.";
                }
                else
                {
                    operacion = "Se actualizó la configuracion portal.";
                }

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
