using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConfiguracionValidacionController : BaseController
    {
        static int CampaniaID = 201301;

        #region Actions

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ConfiguracionValidacion/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var cronogramaModel = new ConfiguracionValidacionModel()
                {
                    listaPaises = DropDowListPaises(),
                    listaZonas = new List<ZonaModel>(),
                    listaZonasActivas = new List<ConfiguracionValidacionZonaModel>()
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

        public JsonResult ObtenerConfiguracionPedidosPorPais(int PaisID)
        {
            try
            {
                var listaZonas = DropDownListZonas(PaisID);
                var listaZonasActivas = DropDowListZonasActivas(PaisID);
                List<ConfiguracionValidacionZonaModel> lstActivos = new List<ConfiguracionValidacionZonaModel>();

                var filter = (from req in listaZonasActivas
                              where req.CampaniaID == CampaniaID
                              select req.ZonaID).ToArray();

                foreach (var item in listaZonas)
                {
                    var entidad = listaZonasActivas.ToList().Find(x => x.ZonaID == item.ZonaID);
                    if (entidad != null)
                    {
                        entidad.Codigo = item.Codigo;
                        lstActivos.Add(entidad);
                    }
                }
                listaZonas = listaZonas.Where(x => !filter.Contains(x.ZonaID));

                var Modelo = GetConfiguracionValidacionLista(PaisID);

                return Json(new
                {
                    listaZonas = listaZonas,
                    listaZonasActivas = lstActivos,
                    Modelo = Modelo
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    listaZonas = new List<ZonaModel>(),
                    listaZonasActivas = new List<ConfiguracionValidacionZonaModel>(),
                    Modelo = new ConfiguracionValidacionZonaModel()
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    listaZonas = new List<ZonaModel>(),
                    listaZonasActivas = new List<ConfiguracionValidacionZonaModel>(),
                    Modelo = new ConfiguracionValidacionZonaModel()
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

        private IEnumerable<ConfiguracionValidacionZonaModel> DropDowListZonasActivas(int PaisID)
        {
            //PaisID = 11;
            IList<BEConfiguracionValidacionZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetCampaniasActivas(PaisID, CampaniaID);
            }
            Mapper.CreateMap<BEConfiguracionValidacionZona, ConfiguracionValidacionZonaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID));

            return Mapper.Map<IList<BEConfiguracionValidacionZona>, IEnumerable<ConfiguracionValidacionZonaModel>>(lst);
        }

        private IEnumerable<ConfiguracionValidacionModel> GetConfiguracionValidacionLista(int PaisID)
        {
            //PaisID = 11;
            IList<BEConfiguracionValidacion> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionValidacion(PaisID, CampaniaID);
            }
            Mapper.CreateMap<BEConfiguracionValidacion, ConfiguracionValidacionModel>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.DiasAntes, f => f.MapFrom(c => c.DiasAntes))
                .ForMember(t => t.HoraInicio, f => f.MapFrom(c => c.HoraInicio))
                .ForMember(t => t.HoraFin, f => f.MapFrom(c => c.HoraFin))
                .ForMember(t => t.HoraInicioNoFacturable, f => f.MapFrom(c => c.HoraInicioNoFacturable))
                .ForMember(t => t.HoraCierreNoFacturable, f => f.MapFrom(c => c.HoraCierreNoFacturable))
                .ForMember(t => t.FlagNoValidados, f => f.MapFrom(c => c.FlagNoValidados))
                .ForMember(t => t.ProcesoRegular, f => f.MapFrom(c => c.ProcesoRegular))
                .ForMember(t => t.ProcesoDA, f => f.MapFrom(c => c.ProcesoDA))
                .ForMember(t => t.ProcesoDAPRD, f => f.MapFrom(c => c.ProcesoDAPRD))
                .ForMember(t => t.HabilitarRestriccionHoraria, f => f.MapFrom(c => c.HabilitarRestriccionHoraria));

            return Mapper.Map<IList<BEConfiguracionValidacion>, IEnumerable<ConfiguracionValidacionModel>>(lst);
        }

        [HttpPost]
        public JsonResult Mantener(ConfiguracionValidacionModel model)
        {
            try
            {
                Mapper.CreateMap<ConfiguracionValidacionModel, BEConfiguracionValidacion>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.DiasAntes, f => f.MapFrom(c => c.DiasAntes))
                    .ForMember(t => t.HoraInicio, f => f.MapFrom(c => c.HoraInicio))
                    .ForMember(t => t.HoraFin, f => f.MapFrom(c => c.HoraFin))
                    .ForMember(t => t.HoraInicioNoFacturable, f => f.MapFrom(c => c.HoraInicioNoFacturable))
                    .ForMember(t => t.HoraCierreNoFacturable, f => f.MapFrom(c => c.HoraCierreNoFacturable))
                    .ForMember(t => t.FlagNoValidados, f => f.MapFrom(c => c.FlagNoValidados))
                    .ForMember(t => t.ProcesoRegular, f => f.MapFrom(c => c.ProcesoRegular))
                    .ForMember(t => t.ProcesoDA, f => f.MapFrom(c => c.ProcesoDA))
                    .ForMember(t => t.ProcesoDAPRD, f => f.MapFrom(c => c.ProcesoDAPRD))
                    .ForMember(t => t.HabilitarRestriccionHoraria, f => f.MapFrom(c => c.HabilitarRestriccionHoraria));

                BEConfiguracionValidacion entidad = Mapper.Map<ConfiguracionValidacionModel, BEConfiguracionValidacion>(model);
                entidad.CampaniaID = CampaniaID;

                Mapper.CreateMap<ConfiguracionValidacionZonaModel, BEConfiguracionValidacionZona>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID));

                List<BEConfiguracionValidacionZona> lstZonasActivas = Mapper.Map<IEnumerable<ConfiguracionValidacionZonaModel>, List<BEConfiguracionValidacionZona>>(model.listaZonasActivas);

                entidad.CodigoUsuarioModificacion = UserData().CodigoUsuario;

                if (model.FlagRegistro == 1)
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        sv.UpdConfiguracionValidacionZona(entidad, (ConfigurarDiasCronograma(entidad.PaisID, entidad.CampaniaID, lstZonasActivas)).ToArray());
                    }
                }
                else
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        sv.InsConfiguracionValidacionZona(entidad, (ConfigurarDiasCronograma(entidad.PaisID, entidad.CampaniaID, lstZonasActivas)).ToArray());
                    }
                }

                return Json(new
                {
                    success = true,
                    message = model.FlagRegistro == 1 ? "La Configuración de Validación de Pedidos fue actualizada satisfactoriamente." : "La Configuración de Validación de Pedido fue registrada satisfactoriamente.",
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

        public List<BEConfiguracionValidacionZona> ConfigurarDiasCronograma(int PaisID, int CampaniaID, List<BEConfiguracionValidacionZona> lstZonasActivas)
        {
            IList<BEConfiguracionValidacionZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetCampaniasActivas(PaisID, CampaniaID);
            }

            if (lst != null)
            {
                foreach (var item in lstZonasActivas)
                {
                    BEConfiguracionValidacionZona[] temp = lst.Where(p => p.ZonaID == item.ZonaID).ToArray();
                    if (temp != null && temp.Length != 0)
                    {
                        item.DiasDuracionCronograma = temp[0].DiasDuracionCronograma;
                    }
                    else
                        item.DiasDuracionCronograma = 1;
                }
            }

            return lstZonasActivas;
        }

        #endregion
    }
}
