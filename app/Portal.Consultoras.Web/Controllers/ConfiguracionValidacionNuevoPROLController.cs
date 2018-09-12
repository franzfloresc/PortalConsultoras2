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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new CronogramaModel());
        }

        public JsonResult GetConfiguracionValidacionNuevoPROL(int PaisID)
        {
            try
            {
                var listaZonas = DropDowListZonasNoProl(PaisID);
                var listaZonasNuevoProl = DropDowListZonasPROL(PaisID);

                return Json(new
                {
                    listaZonas = listaZonas,
                    listaZonasNuevoPROL = listaZonasNuevoProl
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<ZonaModel> DropDowListZonasNoProl(int paisId)
        {
            IList<BEConfiguracionValidacionNuevoPROL> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionValidacionNuevoPROL(paisId, 1);
            }

            return Mapper.Map<IList<BEConfiguracionValidacionNuevoPROL>, IEnumerable<ZonaModel>>(lst);
        }

        private IEnumerable<ZonaModel> DropDowListZonasPROL(int paisId)
        {
            IList<BEConfiguracionValidacionNuevoPROL> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionValidacionNuevoPROL(paisId, 2);
            }

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
                    sv.InsConfiguracionValidacionNuevoPROL(model.PaisID, userData.CodigoUsuario, lista.ToArray());
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
