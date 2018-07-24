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
                var listaZonas = _baseProvider.DropDownListZonas(PaisID).ToList();
                var listaZonasActivas = DropDowListZonasActivas(PaisID).ToList();
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
                listaZonas = listaZonas.Where(x => !filter.Contains(x.ZonaID)).ToList();

                var modelo = GetConfiguracionValidacionLista(PaisID);

                return Json(new
                {
                    listaZonas = listaZonas,
                    listaZonasActivas = lstActivos,
                    Modelo = modelo
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
                lst = UserData().RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(UserData().PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<ConfiguracionValidacionZonaModel> DropDowListZonasActivas(int paisId)
        {
            IList<BEConfiguracionValidacionZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetCampaniasActivas(paisId, CampaniaID);
            }
            return Mapper.Map<IList<BEConfiguracionValidacionZona>, IEnumerable<ConfiguracionValidacionZonaModel>>(lst);
        }

        private IEnumerable<ConfiguracionValidacionModel> GetConfiguracionValidacionLista(int paisId)
        {
            IList<BEConfiguracionValidacion> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionValidacion(paisId, CampaniaID);
            }

            return Mapper.Map<IList<BEConfiguracionValidacion>, IEnumerable<ConfiguracionValidacionModel>>(lst);
        }

        [HttpPost]
        public JsonResult Mantener(ConfiguracionValidacionModel model)
        {
            try
            {
                BEConfiguracionValidacion entidad = Mapper.Map<ConfiguracionValidacionModel, BEConfiguracionValidacion>(model);
                entidad.CampaniaID = CampaniaID;

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

        public List<BEConfiguracionValidacionZona> ConfigurarDiasCronograma(int paisId, int campaniaId, List<BEConfiguracionValidacionZona> lstZonasActivas)
        {
            IList<BEConfiguracionValidacionZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetCampaniasActivas(paisId, campaniaId);
            }

            if (lst != null)
            {
                foreach (var item in lstZonasActivas)
                {
                    BEConfiguracionValidacionZona[] temp = lst.Where(p => p.ZonaID == item.ZonaID).ToArray();
                    item.DiasDuracionCronograma = temp.Length != 0
                        ? temp[0].DiasDuracionCronograma
                        : (short)1;
                }
            }

            return lstZonasActivas;
        }

        #endregion
    }
}
