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
    public class ConfiguracionTipoProcesoCargaPedidosController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ConfiguracionTipoProcesoCargaPedidos/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var cronogramaModel = new ConfiguracionTipoProcesoCargaPedidosModel()
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

        public JsonResult GetConfiguracionTipoProcesoCargaPedidos(int PaisID)
        {
            AdministrarConfiguracionPortalModel model = new AdministrarConfiguracionPortalModel();
            try
            {
                BEConfiguracionPortal configuracionPortal = new BEConfiguracionPortal();
                BEConfiguracionPortal configuracionPortalParametro = new BEConfiguracionPortal();
                configuracionPortalParametro.PaisID = PaisID;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    configuracionPortal = sv.ObtenerConfiguracionPortal(configuracionPortalParametro);

                }

                model.TipoProcesoCarga = (configuracionPortal.TipoProcesoCarga == null ? false : configuracionPortal.TipoProcesoCarga.Value);


                var listaZonas = DropDowListZonasNoProl(PaisID);
                var listaZonasNuevoPROL = DropDowListZonasPROL(PaisID);

                if (!model.TipoProcesoCarga)
                {
                    return Json(new
                    {
                        listaZonas = new List<ZonaModel>(),
                        listaZonasNuevoPROL = new List<ZonaModel>()
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        listaZonas = listaZonas,
                        listaZonasNuevoPROL = listaZonasNuevoPROL,
                    }, JsonRequestBehavior.AllowGet);
                }
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

        private IEnumerable<ZonaModel> DropDowListZonasNoProl(int PaisID)
        {
            IList<BEConfiguracionTipoProcesoCargaPedidos> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionTipoProcesoCargaPedidos(PaisID, 1);
            }
            Mapper.CreateMap<BEConfiguracionTipoProcesoCargaPedidos, ZonaModel>()
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.CodigoZona))
                    .ForMember(t => t.DiasParametroCarga, f => f.MapFrom(c => c.DiasParametroCarga));

            return Mapper.Map<IList<BEConfiguracionTipoProcesoCargaPedidos>, IEnumerable<ZonaModel>>(lst);
        }

        private IEnumerable<ZonaModel> DropDowListZonasPROL(int PaisID)
        {
            IList<BEConfiguracionTipoProcesoCargaPedidos> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionTipoProcesoCargaPedidos(PaisID, 2);
            }
            Mapper.CreateMap<BEConfiguracionTipoProcesoCargaPedidos, ZonaModel>()
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.CodigoZona))
                    .ForMember(t => t.DiasParametroCarga, f => f.MapFrom(c => c.DiasParametroCarga));

            return Mapper.Map<IList<BEConfiguracionTipoProcesoCargaPedidos>, IEnumerable<ZonaModel>>(lst);
        }

        [HttpPost]
        public JsonResult ConfiguracionTipoProcesoNuevoCargaPedidos(ConfiguracionTipoProcesoCargaPedidosModel model)
        {
            try
            {
                List<BEConfiguracionTipoProcesoCargaPedidos> lista = new List<BEConfiguracionTipoProcesoCargaPedidos>();
                if (model.listaZonasNuevoPROL != null)
                {
                    foreach (var item in model.listaZonasNuevoPROL)
                    {
                        lista.Add(new BEConfiguracionTipoProcesoCargaPedidos()
                        {
                            ZonaID = item.ZonaID,
                            CodigoZona = item.Codigo,
                            DiasParametroCarga = item.DiasParametroCarga
                        });
                    }
                }

                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.InsConfiguracionTipoProcesoCargaPedidos(model.PaisID, UserData().CodigoUsuario, lista.ToArray());
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
