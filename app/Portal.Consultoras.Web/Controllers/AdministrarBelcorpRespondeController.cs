﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarBelcorpRespondeController : BaseController
    {
        public ActionResult Index()
        {
            AdministrarBelcorpRespondeModel model = new AdministrarBelcorpRespondeModel();

            var paisID = UserData().PaisID;

            try
            {
                List<BEBelcorpResponde> lista = new List<BEBelcorpResponde>();
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    lista = svc.GetBelcorpRespondeAdministrador(Convert.ToInt32(paisID)).ToList();

                    var belcorpResponde = lista.FirstOrDefault();

                    if (belcorpResponde != null)
                    {
                        model.Chat = belcorpResponde.Chat ?? string.Empty;
                        model.ChatURL = belcorpResponde.ChatURL ?? string.Empty;
                        model.PaisID = belcorpResponde.PaisID;
                        model.Telefono1 = belcorpResponde.Telefono1 ?? string.Empty;
                        model.Telefono2 = belcorpResponde.Telefono2 ?? string.Empty;
                        model.Escribenos = belcorpResponde.Escribenos ?? string.Empty;
                        model.EscribenosURL = belcorpResponde.EscribenosURL ?? string.Empty;
                        model.Correo = belcorpResponde.Correo ?? string.Empty;
                        model.CorreoBcc = belcorpResponde.CorreoBcc ?? string.Empty;
                        model.ParametroPais = belcorpResponde.ParametroPais;
                        model.ParametroCodigoConsultora = belcorpResponde.ParametroCodigoConsultora;
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            model.lstPais = DropDowListPaises();
            return View(model);
        }

        [HttpPost]
        public JsonResult Consultar(string PaisID)
        {
            try
            {
                List<BEBelcorpResponde> lista = new List<BEBelcorpResponde>();
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    lista = svc.GetBelcorpRespondeAdministrador(Convert.ToInt32(PaisID)).ToList();
                }

                return Json(new
                {
                    success = true,
                    lista = lista,
                    cantidad = lista.Count
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente."
                });
            }
        }

        [HttpPost]
        public JsonResult Registrar(AdministrarBelcorpRespondeModel model)
        {
            try
            {
                BEBelcorpResponde entidad = Mapper.Map<AdministrarBelcorpRespondeModel, BEBelcorpResponde>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    sv.InsBelcorpResponde(entidad);
                }

                EliminarCacheBelcorpResponde(entidad.PaisID);

                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito los datos de Belcorp Responde.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrio un error inesperado al registrar datos de Belcorp Responde, Por favor intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrio un error inesperado al registrar datos de Belcorp Responde, Por favor intente nuevamente",
                    extra = ""
                });
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList();
            }
            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public void EliminarCacheBelcorpResponde(int PaisId)
        {
            try
            {
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.DeleteBelcorpRespondeCache(PaisId);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", Util.GetPaisISO(PaisId));
            }
        }
    }
}
