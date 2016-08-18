using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.Configuration;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceSAC;

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
                model.TipoProcesoCarga = (configuracionPortal.TipoProcesoCarga == null ? false : configuracionPortal.TipoProcesoCarga.Value);
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
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

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

                if (resultado == 0) { 
                    operacion = "No se actualizó la configuracion portal."; 
                }else{
                    operacion = "Se actualizó la configuracion portal.";
                }

                return Json(new
                {
                    success = resultado == 1 ? true : false,
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
