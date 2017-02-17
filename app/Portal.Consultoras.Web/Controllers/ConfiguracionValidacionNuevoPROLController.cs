using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConfiguracionValidacionNuevoPROLController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ConfiguracionValidacionNuevoPROL/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var cronogramaModel = new ConfiguracionValidacionNuevoPROLModel()
                {
                    listaPaises = DropDowListPaises(),
                    listaZonasPROL = new List<ZonaModel>(),
                    listaZonasNuevoPROL = new List<ZonaModel>()
                };
                return View(cronogramaModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new CronogramaModel());
        }

        public JsonResult GetConfiguracionValidacionNuevoPROL(int PaisID)
        {
            try
            {
                var listaZonas = DropDowListZonas(PaisID);
                var listaZonasNuevoPROL = DropDowListZonasPROL(PaisID);

                return Json(new
                {
                    listaZonas = listaZonas,
                    listaZonasNuevoPROL = listaZonasNuevoPROL
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    listaZonas = new List<ZonaModel>(),
                    listaZonasNuevoPROL = new List<ZonaModel>()
                }, JsonRequestBehavior.AllowGet);
            }

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

        private IEnumerable<ZonaModel> DropDowListZonas(int PaisID)
        {
            IList<BEConfiguracionValidacionNuevoPROL> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionValidacionNuevoPROL(PaisID, 1);
            }
            Mapper.CreateMap<BEConfiguracionValidacionNuevoPROL, ZonaModel>()
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.CodigoZona));

            return Mapper.Map<IList<BEConfiguracionValidacionNuevoPROL>, IEnumerable<ZonaModel>>(lst);
        }

        private IEnumerable<ZonaModel> DropDowListZonasPROL(int PaisID)
        {
            IList<BEConfiguracionValidacionNuevoPROL> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionValidacionNuevoPROL(PaisID, 2);
            }
            Mapper.CreateMap<BEConfiguracionValidacionNuevoPROL, ZonaModel>()
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.CodigoZona));

            return Mapper.Map<IList<BEConfiguracionValidacionNuevoPROL>, IEnumerable<ZonaModel>>(lst);
        }

        [HttpPost]
        public JsonResult ConfigurarZonasNuevoPROL(ConfiguracionValidacionNuevoPROLModel model)
        {
            try
            {
                List<BEConfiguracionValidacionNuevoPROL> lista = new List<BEConfiguracionValidacionNuevoPROL>();
                if (model.listaZonasNuevoPROL != null)
                {
                    foreach (var item in model.listaZonasNuevoPROL)
                    {
                        lista.Add(new BEConfiguracionValidacionNuevoPROL()
                        {
                            ZonaID = item.ZonaID,
                            CodigoZona = item.Codigo,
                            DiasParametroCarga = item.DiasParametroCarga
                        });
                    }
                }

                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.InsConfiguracionValidacionNuevoPROL(model.PaisID, UserData().CodigoUsuario, lista.ToArray());
                }

                return Json(new
                {
                    success = true,
                    message = "La configuración de zonas fue realizada de manera satisfactoria.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
