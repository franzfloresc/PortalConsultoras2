using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ServiciosController : BaseController
    {
        public ActionResult AdministrarServicios()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Servicios/AdministrarServicios"))
                return RedirectToAction("Index", "Bienvenida");

            var model = new ServicioModel { listaParametros = DropDowListParametros() };
            return View(model);
        }

        public ActionResult MantenimientoServicios()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Servicios/MantenimientoServicios"))
                return RedirectToAction("Index", "Bienvenida");

            var model = new ServicioModel { DropDownListCampania = CargarCampania() };
            model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });

            return View(model);
        }

        public ActionResult MantenimientoServicio()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Servicios/MantenimientoServicio"))
                return RedirectToAction("Index", "Bienvenida");

            var model = new ServicioModel { DropDownListCampania = CargarCampania() };
            model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });

            return View(model);
        }

        public ActionResult RedireccionServicio(int ServicioId, string Url)
        {
            IList<BEServicioParametro> lstParam;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lstParam = sv.GetParametrosbyServicio(ServicioId).ToList();
            }

            if (lstParam.Count > 0)
            {
                var txtBuil = new StringBuilder();
                foreach (BEServicioParametro param in lstParam)
                {
                    txtBuil.Append(param.Abreviatura + "=" + DevolverValorParametro(param.ParametroId) + "&");
                }

                Url = Util.Trim(Url) + "?" + txtBuil.ToString();
                Url = Url.Substring(0, Url.Length - 1);
            }
            return Redirect(Url);
        }

        [HttpPost]
        public JsonResult Mantener(ServicioModel model)
        {
            if (model.ServicioId == 0)
                return Insert(model);
            else
                return Update(model);
        }

        [HttpPost]
        public JsonResult Update(ServicioModel model)
        {
            try
            {
                BEServicio entidad = Mapper.Map<ServicioModel, BEServicio>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var vValidation = sv.UpdServicio(entidad);

                    if (vValidation == 1)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El servicio se actualizó con éxito",
                            extra = ""
                        });
                    }

                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un error al actualizar registro, por favor inténtelo mas tarde.",
                        extra = ""
                    });
                }
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

        [HttpPost]
        public JsonResult Insert(ServicioModel model)
        {
            try
            {
                BEServicio entidad = Mapper.Map<ServicioModel, BEServicio>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var vValidation = sv.InsServicio(entidad);

                    if (vValidation == 1)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El servicio se registró con éxito",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Ocurrió un error al insertar registro, por favor inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                }
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

        [HttpPost]
        public JsonResult InsertParametro(int ServicioId, int ParametroId)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    var vValidation = sv.InsServicioParametro(ServicioId, ParametroId);

                    if (vValidation == 1)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El parámetro se registró con éxito",
                            extra = ""
                        });
                    }

                    if (vValidation == -1)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "El parámetro ya ha sido agregado, intente con otro.",
                            extra = ""
                        });
                    }

                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un error al insertar registro, por favor inténtelo mas tarde.",
                        extra = ""
                    });
                }
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

        [HttpPost]
        public JsonResult Delete(int ServicioID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    var vValidation = sv.DelServicio(ServicioID);

                    if (vValidation != 0)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El registro se eliminó con éxito",
                            extra = ""
                        });
                    }

                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un error al intentar eliminar registro, por favor inténtelo mas tarde.",
                        extra = ""
                    });
                }
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

        [HttpPost]
        public JsonResult DeleteServicioParametro(int ServicioID, int ParametroId)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    var vValidation = sv.DelServicioParametro(ServicioID, ParametroId);

                    if (vValidation != 0)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El registro se eliminó con éxito",
                            extra = ""
                        });
                    }

                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un error al intentar eliminar registro, por favor inténtelo mas tarde.",
                        extra = ""
                    });
                }
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

        [HttpPost]
        public JsonResult MantenerEstado(string ServicioId, string CampaniaInicialId, string CampaniaFinalId, string ISOPais, string Estado)
        {
            try
            {
                List<List<BEEstadoServicio>> lista;

                if (CampaniaFinalId == "0")
                    lista = sessionManager.GetListaIndividual();
                else
                    lista = sessionManager.GetListaRango();

                foreach (List<BEEstadoServicio> item in lista)
                {
                    if (item[0].ServicioId == Convert.ToInt32(ServicioId))
                    {
                        item[0].AR = (ISOPais == Constantes.CodigosISOPais.Argentina ? Estado : item[0].AR);
                        item[0].BO = (ISOPais == Constantes.CodigosISOPais.Bolivia ? Estado : item[0].BO);
                        item[0].CL = (ISOPais == Constantes.CodigosISOPais.Chile ? Estado : item[0].CL);
                        item[0].CO = (ISOPais == Constantes.CodigosISOPais.Colombia ? Estado : item[0].CO);
                        item[0].CR = (ISOPais == Constantes.CodigosISOPais.CostaRica ? Estado : item[0].CR);
                        item[0].DO = (ISOPais == Constantes.CodigosISOPais.Dominicana ? Estado : item[0].DO);
                        item[0].EC = (ISOPais == Constantes.CodigosISOPais.Ecuador ? Estado : item[0].EC);
                        item[0].GT = (ISOPais == Constantes.CodigosISOPais.Guatemala ? Estado : item[0].GT);
                        item[0].MX = (ISOPais == Constantes.CodigosISOPais.Mexico ? Estado : item[0].MX);
                        item[0].PA = (ISOPais == Constantes.CodigosISOPais.Panama ? Estado : item[0].PA);
                        item[0].PE = (ISOPais == Constantes.CodigosISOPais.Peru ? Estado : item[0].PE);
                        item[0].PR = (ISOPais == Constantes.CodigosISOPais.PuertoRico ? Estado : item[0].PR);
                        item[0].SV = (ISOPais == Constantes.CodigosISOPais.Salvador ? Estado : item[0].SV);
                        item[0].VE = (ISOPais == Constantes.CodigosISOPais.Venezuela ? Estado : item[0].VE);
                    }
                }

                if (CampaniaFinalId == "0")
                    sessionManager.SetListaIndividual(lista);
                else
                    sessionManager.SetListaRango(lista);

                return Json(new
                {
                    success = true,
                    message = "El servicio se actualizó con éxito",
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

        [HttpPost]
        public JsonResult DeleteEstado(int ServicioId, int CampaniaId, string ISOPais)
        {
            try
            {

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var vValidation = sv.DelServicioCampania(CampaniaId, ServicioId, ISOPais);

                    if (vValidation == 1)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El servicio se actualizó con éxito",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Ocurrió un error al actualizar registro, por favor inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                }
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

        [HttpPost]
        public JsonResult InsertEstado(string IDs, string CampaniaInicialId, string CampaniaFinalId)
        {
            try
            {
                string[] listId = IDs.Split(',');
                using (SACServiceClient sv = new SACServiceClient())
                {
                    foreach (string item in listId)
                    {
                        List<List<BEEstadoServicio>> lista;
                        if (CampaniaFinalId == "0")
                        {
                            lista = sessionManager.GetListaIndividual();

                            foreach (List<BEEstadoServicio> list in lista)
                            {
                                if (list[0].ServicioId == Convert.ToInt32(item))
                                {
                                    #region Establece Estados
                                    if (list[0].AR == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Argentina);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Argentina);

                                    if (list[0].BO == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Bolivia);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Bolivia);

                                    if (list[0].CL == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Chile);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Chile);

                                    if (list[0].CO == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Colombia);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Colombia);

                                    if (list[0].CR == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.CostaRica);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.CostaRica);

                                    if (list[0].DO == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Dominicana);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Dominicana);

                                    if (list[0].EC == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Ecuador);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Ecuador);

                                    if (list[0].GT == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Guatemala);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Guatemala);

                                    if (list[0].MX == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Mexico);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Mexico);

                                    if (list[0].PA == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Panama);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Panama);

                                    if (list[0].PE == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Peru);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Peru);

                                    if (list[0].PR == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.PuertoRico);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.PuertoRico);

                                    if (list[0].SV == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Salvador);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Salvador);

                                    if (list[0].VE == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Venezuela);
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, Constantes.CodigosISOPais.Venezuela);
                                    #endregion
                                }
                            }
                        }
                        else
                        {
                            lista = sessionManager.GetListaRango();

                            foreach (List<BEEstadoServicio> list in lista)
                            {
                                if (list[0].ServicioId == Convert.ToInt32(item))
                                {
                                    #region Establece Estados
                                    if (list[0].AR == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Argentina);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Argentina);

                                    if (list[0].BO == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Bolivia);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Bolivia);

                                    if (list[0].CL == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Chile);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Chile);

                                    if (list[0].CO == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Colombia);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Colombia);

                                    if (list[0].CR == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.CostaRica);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.CostaRica);

                                    if (list[0].DO == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Dominicana);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Dominicana);

                                    if (list[0].EC == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Ecuador);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Ecuador);

                                    if (list[0].GT == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Guatemala);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Guatemala);

                                    if (list[0].MX == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Mexico);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Mexico);

                                    if (list[0].PA == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Panama);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Panama);

                                    if (list[0].PE == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Peru);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Peru);

                                    if (list[0].PR == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.PuertoRico);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.PuertoRico);

                                    if (list[0].SV == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Salvador);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Salvador);

                                    if (list[0].VE == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Venezuela);
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, Constantes.CodigosISOPais.Venezuela);
                                    #endregion
                                }
                            }
                        }
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Los datos se actualizaron con éxito",
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

        public ActionResult ConsultarServicios(string sidx, string sord, int page, int rows, string vDescripcion, string vCampaniaInicial)
        {
            if (ModelState.IsValid)
            {
                List<BEServicio> lst = new List<BEServicio>();
                if (vCampaniaInicial != "0")
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.GetServicios(vDescripcion).ToList();
                    }
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEServicio> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "ServicioId":
                            items = lst.OrderBy(x => x.ServicioId);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "Url":
                            items = lst.OrderBy(x => x.Url);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "ServicioId":
                            items = lst.OrderByDescending(x => x.ServicioId);
                            break;
                        case "Desciprcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "Url":
                            items = lst.OrderByDescending(x => x.Url);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Paginador(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ServicioId.ToString(),
                               cell = new string[]
                               {
                                   a.ServicioId.ToString(),
                                   a.Descripcion,
                                   a.Url
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarServicio(string sidx, string sord, int page, int rows, string vDescripcion, string vCampaniaInicial)
        {
            if (ModelState.IsValid)
            {
                sessionManager.SetListaIndividual(null);
                sessionManager.SetListaRango(null);

                List<BEServicio> lst = new List<BEServicio>();
                if (vCampaniaInicial != "0")
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.GetServicios(vDescripcion).ToList();
                    }
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEServicio> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "ServicioId":
                            items = lst.OrderBy(x => x.ServicioId);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "Url":
                            items = lst.OrderBy(x => x.Url);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "ServicioId":
                            items = lst.OrderByDescending(x => x.ServicioId);
                            break;
                        case "Desciprcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "Url":
                            items = lst.OrderByDescending(x => x.Url);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Paginador(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ServicioId.ToString(),
                               cell = new string[]
                               {
                                   a.ServicioId.ToString(),
                                   a.Descripcion,
                                   a.Url
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarParametrosbyServicios(string sidx, string sord, int page, int rows, int ServicioId)
        {
            if (ModelState.IsValid)
            {
                List<BEServicioParametro> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.GetParametrosbyServicio(ServicioId).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEServicioParametro> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Desciprcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = PaginadorDetalle(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               cell = new string[]
                               {
                                   a.Correlativo,
                                   a.ServicioId.ToString(),
                                   a.ParametroId.ToString(),
                                   a.Descripcion
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarEstadoServiciobyPais(string sidx, string sord, int page, int rows, int ServicioId, int CampaniaId)
        {
            if (ModelState.IsValid)
            {
                List<BEEstadoServicio> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.GetEstadoServiciobyPais(ServicioId, CampaniaId).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEEstadoServicio> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case Constantes.CodigosISOPais.Argentina:
                            items = lst.OrderBy(x => x.AR);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case Constantes.CodigosISOPais.Argentina:
                            items = lst.OrderByDescending(x => x.AR);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = PaginadorEstado(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = ServicioId.ToString(),
                               cell = new string[]
                               {
                                   a.AR,
                                   a.BO,
                                   a.CL,
                                   a.CO,
                                   a.CR,
                                   a.EC,
                                   a.SV,
                                   a.GT,
                                   a.MX,
                                   a.PA,
                                   a.PE,
                                   a.PR,
                                   a.DO,
                                   a.VE,
                                   ServicioId.ToString(),
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarEstadoServiciobyPais2(string sidx, string sord, int page, int rows, int ServicioId, int CampaniaInicioID, int CampaniaFinalID)
        {
            if (ModelState.IsValid)
            {
                int contador = 0;
                List<BEEstadoServicio> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    if (CampaniaFinalID == 0)
                    {
                        lst = sv.GetEstadoServiciobyPais(ServicioId, CampaniaInicioID).ToList();
                        lst[0].CampaniaInicialId = CampaniaInicioID.ToString();
                        lst[0].ServicioId = ServicioId;
                        if (sessionManager.GetListaIndividual() == null)
                        {
                            List<List<BEEstadoServicio>> lista = new List<List<BEEstadoServicio>> { lst };
                            sessionManager.SetListaIndividual(lista);
                        }
                        else
                        {
                            List<List<BEEstadoServicio>> lista = sessionManager.GetListaIndividual();
                            foreach (List<BEEstadoServicio> item in lista)
                            {
                                if (item[0].ServicioId == ServicioId && item[0].CampaniaInicialId == CampaniaInicioID.ToString())
                                {
                                    lst = item;
                                    contador = contador + 1;
                                }
                            }
                            if (contador == 0)
                                lista.Add(lst);
                            sessionManager.SetListaIndividual(lista);
                        }
                    }
                    else
                    {
                        lst = sv.GetEstadoServiciobyPais(ServicioId, 0).ToList();
                        lst[0].CampaniaInicialId = CampaniaInicioID.ToString();
                        lst[0].CampaniaFinalId = CampaniaFinalID.ToString();
                        lst[0].ServicioId = ServicioId;
                        if (sessionManager.GetListaRango() == null)
                        {
                            List<List<BEEstadoServicio>> lista = new List<List<BEEstadoServicio>> { lst };
                            sessionManager.SetListaRango(lista);
                        }
                        else
                        {
                            List<List<BEEstadoServicio>> lista = sessionManager.GetListaRango();
                            foreach (List<BEEstadoServicio> item in lista)
                            {
                                if (item[0].ServicioId == ServicioId && item[0].CampaniaInicialId == CampaniaInicioID.ToString() && item[0].CampaniaFinalId == CampaniaFinalID.ToString())
                                {
                                    lst = item;
                                    contador = contador + 1;
                                }
                            }
                            if (contador == 0)
                                lista.Add(lst);
                            lista.Add(lst);
                            sessionManager.SetListaRango(lista);
                        }
                    }
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEEstadoServicio> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case Constantes.CodigosISOPais.Argentina:
                            items = lst.OrderBy(x => x.AR);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case Constantes.CodigosISOPais.Argentina:
                            items = lst.OrderByDescending(x => x.AR);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = PaginadorEstado(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = ServicioId.ToString(),
                               cell = new string[]
                               {
                                   a.AR,
                                   a.BO,
                                   a.CL,
                                   a.CO,
                                   a.CR,
                                   a.EC,
                                   a.SV,
                                   a.GT,
                                   a.MX,
                                   a.PA,
                                   a.PE,
                                   a.PR,
                                   a.DO,
                                   a.VE,
                                   ServicioId.ToString(),
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public BEPager Paginador(BEGrid item, List<BEServicio> lst)
        {

            BEPager pag = new BEPager();

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        public BEPager PaginadorDetalle(BEGrid item, List<BEServicioParametro> lst)
        {

            BEPager pag = new BEPager();

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        public BEPager PaginadorEstado(BEGrid item, List<BEEstadoServicio> lst)
        {

            BEPager pag = new BEPager();

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        private IEnumerable<ParametroModel> DropDowListParametros()
        {
            List<BEParametro> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.SelectParametros().ToList();
            }

            return Mapper.Map<IList<BEParametro>, IEnumerable<ParametroModel>>(lst);
        }

        private List<BECampania> CargarCampania()
        {
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                BECampania[] becampania = servicezona.SelectCampanias(11);
                return becampania.ToList();
            }
        }

        private string DevolverValorParametro(int parametroId)
        {
            switch (parametroId)
            {
                case 1:
                    return userData.CodigoISO;
                case 2:
                    return userData.CampaniaID.ToString();
                case 3:
                    return userData.CodigoConsultora;
                case 4:
                    return userData.NombreConsultora;
                case 5:
                    return userData.EMail;
                default:
                    return "";
            }
        }

        public JsonResult CargarArbolRegionesZonas(int? pais)
        {
            if (pais.GetValueOrDefault() == 0)
                return Json(null, JsonRequestBehavior.AllowGet);

            IList<BEZonificacionJerarquia> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.GetZonificacionJerarquia(pais.GetValueOrDefault());
            }
            JsTreeModel[] tree = lst.Distinct<BEZonificacionJerarquia>(new BEZonificacionJerarquiaComparer()).Select(
                                    r => new JsTreeModel
                                    {
                                        data = r.RegionNombre,
                                        attr = new JsTreeAttribute
                                        {
                                            id = r.RegionId * 1000,
                                            selected = false
                                        },
                                        children = lst.Where(i => i.RegionId == r.RegionId).Select(
                                                        z => new JsTreeModel
                                                        {
                                                            data = z.ZonaNombre,
                                                            attr = new JsTreeAttribute
                                                            {
                                                                id = z.ZonaId,
                                                                selected = false
                                                            }
                                                        }).ToArray()
                                    }).ToArray();
            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CargarServicioPaises(int ServicioId)
        {
            IEnumerable<PaisModel> lst = DropDowListPaisesByServicioId(ServicioId, 0, 1);
            return Json(new
            {
                listapaises = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CargarServicioCampanias(int ServicioId, int PaisId)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampaniasByServicioId(ServicioId, PaisId, 2);
            return Json(new
            {
                listacampanias = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CargarSegmentoPais(int PaisId)
        {
            IEnumerable<BESegmentoBanner> lst;

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = PaisId == 14
                    ? sv.GetSegmentoBanner(PaisId)
                    : sv.GetSegmentoInternoBanner(PaisId);
            }

            return Json(new
            {
                listasegmento = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerSegmentoZona(int ServicioId, int CampaniaId, int PaisId)
        {
            BEServicioSegmentoZona obeServicioSegmentoZona;

            using (SACServiceClient sv = new SACServiceClient())
            {
                obeServicioSegmentoZona = sv.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId);
            }

            if (obeServicioSegmentoZona == null)
            {
                obeServicioSegmentoZona = new BEServicioSegmentoZona()
                {
                    Segmento = -1,
                    ConfiguracionZona = string.Empty
                };
            }

            return Json(new
            {
                Segmento = obeServicioSegmentoZona.Segmento,
                ConfiguracionZona = obeServicioSegmentoZona.ConfiguracionZona
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<PaisModel> DropDowListPaisesByServicioId(int servicioId, int paisId, int tipo)
        {
            List<BEServicioSegmentoZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetServicioCampaniaSegmentoZonaAsignados(servicioId, paisId, tipo).ToList();
            }

            return Mapper.Map<IList<BEServicioSegmentoZona>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampaniasByServicioId(int servicioId, int paisId, int tipo)
        {
            List<BEServicioSegmentoZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetServicioCampaniaSegmentoZonaAsignados(servicioId, paisId, tipo).ToList();
            }

            return Mapper.Map<IList<BEServicioSegmentoZona>, IEnumerable<CampaniaModel>>(lst);

        }

        public JsonResult UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInternoId)
        {
            string mensaje;
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.UpdServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId, Segmento, ConfiguracionZona, SegmentoInternoId);
                }
                mensaje = "La información se guardó con éxito.";
            }
            catch (Exception ex)
            {
                mensaje = "Ocurrió un error: " + ex.Message;
            }
            EliminarCacheServicio(CampaniaId, PaisId);

            return Json(new
            {
                Mensaje = mensaje
            }, JsonRequestBehavior.AllowGet);
        }

        public void EliminarCacheServicio(int campaniaId, int paisId)
        {
            try
            {
                using (SACServiceClient svc = new SACServiceClient())
                {
                    svc.DeleteCacheServicio(Util.GetPaisISO(paisId), campaniaId);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", Util.GetPaisISO(paisId));
            }
        }

        public JsonResult ObtenerServicioCampaniaSegmentoZona(int CampaniaId, int ServicioId, int PaisId)
        {
            BEServicioSegmentoZona servicio;

            using (SACServiceClient sv = new SACServiceClient())
            {
                servicio = sv.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId);
            }

            return Json(new
            {
                Servicio = servicio
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
