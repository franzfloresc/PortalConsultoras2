﻿using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConfiguracionTipoProcesoCargaPedidosController : BaseAdmController
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new CronogramaModel());
        }

        public JsonResult GetConfiguracionTipoProcesoCargaPedidos(int PaisID)
        {
            AdministrarConfiguracionPortalModel model = new AdministrarConfiguracionPortalModel();
            try
            {
                BEConfiguracionPortal configuracionPortal;
                BEConfiguracionPortal configuracionPortalParametro = new BEConfiguracionPortal { PaisID = PaisID };

                using (SACServiceClient sv = new SACServiceClient())
                {
                    configuracionPortal = sv.ObtenerConfiguracionPortal(configuracionPortalParametro);

                }

                model.TipoProcesoCarga = (configuracionPortal.TipoProcesoCarga != null && configuracionPortal.TipoProcesoCarga.Value);


                var listaZonas = DropDowListZonasNoProl(PaisID);
                var listaZonasNuevoProl = DropDowListZonasPROL(PaisID);

                if (!model.TipoProcesoCarga)
                {
                    return Json(new
                    {
                        listaZonas = new List<ZonaModel>(),
                        listaZonasNuevoPROL = new List<ZonaModel>()
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    listaZonas = listaZonas,
                    listaZonasNuevoPROL = listaZonasNuevoProl,
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

        private IEnumerable<ZonaModel> DropDowListZonasNoProl(int paisId)
        {
            IList<BEConfiguracionTipoProcesoCargaPedidos> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionTipoProcesoCargaPedidos(paisId, 1);
            }

            return Mapper.Map<IList<BEConfiguracionTipoProcesoCargaPedidos>, IEnumerable<ZonaModel>>(lst);
        }

        private IEnumerable<ZonaModel> DropDowListZonasPROL(int paisId)
        {
            IList<BEConfiguracionTipoProcesoCargaPedidos> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetConfiguracionTipoProcesoCargaPedidos(paisId, 2);
            }

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
                    sv.InsConfiguracionTipoProcesoCargaPedidos(model.PaisID, userData.CodigoUsuario, lista.ToArray());
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
