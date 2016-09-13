using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;
using System.Configuration; //R2161

namespace Portal.Consultoras.Web.Controllers
{
    public class ServiciosController : BaseController
    {
        //
        // GET: /Servicios/

        public ActionResult AdministrarServicios()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Servicios/AdministrarServicios"))
                return RedirectToAction("Index", "Bienvenida");

            var model = new ServicioModel();
            model.listaParametros = DropDowListParametros();
            return View(model);
        }
        public ActionResult MantenimientoServicios()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Servicios/MantenimientoServicios"))
                return RedirectToAction("Index", "Bienvenida");

            var model = new ServicioModel();
            model.DropDownListCampania = CargarCampania();
            model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });

            return View(model);
        }
        public ActionResult MantenimientoServicio()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Servicios/MantenimientoServicio"))
                return RedirectToAction("Index", "Bienvenida");

            var model = new ServicioModel();
            model.DropDownListCampania = CargarCampania();
            model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });

            return View(model);
        }
        public ActionResult RedireccionServicio(int ServicioId, string Url)
        {
            IList<ServiceSAC.BEServicioParametro> lst_param = new List<ServiceSAC.BEServicioParametro>();

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst_param = sv.GetParametrosbyServicio(ServicioId).ToList();
            }

            if (lst_param.Count > 0)
            {
                Url = Url + "?";

                foreach (BEServicioParametro param in lst_param)
                {
                    Url = Url + param.Abreviatura + "=" + DevolverValorParametro(param.ParametroId) + "&";
                }

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
            int vValidation = 0;
            try
            {
                Mapper.CreateMap<ServicioModel, BEServicio>()
                    .ForMember(t => t.ServicioId, f => f.MapFrom(c => c.ServicioId))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

                BEServicio entidad = Mapper.Map<ServicioModel, BEServicio>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    vValidation = sv.UpdServicio(entidad);

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
        [HttpPost]
        public JsonResult Insert(ServicioModel model)
        {
            int vValidation = 0;
            try
            {
                Mapper.CreateMap<ServicioModel, BEServicio>()
                    .ForMember(t => t.ServicioId, f => f.MapFrom(c => c.ServicioId))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

                BEServicio entidad = Mapper.Map<ServicioModel, BEServicio>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    vValidation = sv.InsServicio(entidad);

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
        [HttpPost]
        public JsonResult InsertParametro(int ServicioId, int ParametroId)
        {
            int vValidation = 0;
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    vValidation = sv.InsServicioParametro(ServicioId, ParametroId);

                    if (vValidation == 1)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El parámetro se registró con éxito",
                            extra = ""
                        });
                    }
                    else
                    {
                        if (vValidation == -1)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "El parámetro ya ha sido agregado, intente con otro.",
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
        [HttpPost]
        public JsonResult Delete(int ServicioID)
        {
            int vValidation = 0;
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    vValidation = sv.DelServicio(ServicioID);

                    if (vValidation != 0)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El registro se eliminó con éxito",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Ocurrió un error al intentar eliminar registro, por favor inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                }
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
        [HttpPost]
        public JsonResult DeleteServicioParametro(int ServicioID, int ParametroId)
        {
            int vValidation = 0;
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    vValidation = sv.DelServicioParametro(ServicioID, ParametroId);

                    if (vValidation != 0)
                    {
                        return Json(new
                        {
                            success = true,
                            message = "El registro se eliminó con éxito",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Ocurrió un error al intentar eliminar registro, por favor inténtelo mas tarde.",
                            extra = ""
                        });
                    }
                }
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
        [HttpPost]
        public JsonResult MantenerEstado(string ServicioId, string CampaniaInicialId, string CampaniaFinalId, string ISOPais, string Estado)
        {
            try
            {
                List<List<BEEstadoServicio>> lista;

                if (CampaniaFinalId == "0")
                    lista = (List<List<BEEstadoServicio>>)Session["ListaIndividual"];
                else
                    lista = (List<List<BEEstadoServicio>>)Session["ListaRango"];

                foreach (List<BEEstadoServicio> item in lista)
                {
                    if (item[0].ServicioId == Convert.ToInt32(ServicioId))
                    {
                        item[0].AR = (ISOPais == "AR" ? Estado : item[0].AR);
                        item[0].BO = (ISOPais == "BO" ? Estado : item[0].BO);
                        item[0].CL = (ISOPais == "CL" ? Estado : item[0].CL);
                        item[0].CO = (ISOPais == "CO" ? Estado : item[0].CO);
                        item[0].CR = (ISOPais == "CR" ? Estado : item[0].CR);
                        item[0].DO = (ISOPais == "DO" ? Estado : item[0].DO);
                        item[0].EC = (ISOPais == "EC" ? Estado : item[0].EC);
                        item[0].GT = (ISOPais == "GT" ? Estado : item[0].GT);
                        item[0].MX = (ISOPais == "MX" ? Estado : item[0].MX);
                        item[0].PA = (ISOPais == "PA" ? Estado : item[0].PA);
                        item[0].PE = (ISOPais == "PE" ? Estado : item[0].PE);
                        item[0].PR = (ISOPais == "PR" ? Estado : item[0].PR);
                        item[0].SV = (ISOPais == "SV" ? Estado : item[0].SV);
                        item[0].VE = (ISOPais == "VE" ? Estado : item[0].VE);
                    }
                }
                
                if (CampaniaFinalId == "0")
                    Session["ListaIndividual"] = lista;
                else
                    Session["ListaRango"] = lista;

                return Json(new
                {
                    success = true,
                    message = "El servicio se actualizó con éxito",
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
        [HttpPost]
        public JsonResult DeleteEstado(int ServicioId, int CampaniaId, string ISOPais)
        {
            int vValidation = 0;
            try
            {

                using (SACServiceClient sv = new SACServiceClient())
                {
                    vValidation = sv.DelServicioCampania(CampaniaId, ServicioId, ISOPais);

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
        [HttpPost]
        public JsonResult InsertEstado(string IDs, string CampaniaInicialId, string CampaniaFinalId)
        {
            try
            {
                string[] List_Id = IDs.Split(',');
                List<List<BEEstadoServicio>> lista;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    foreach (string item in List_Id)
                    {
                        if (CampaniaFinalId == "0")
                        {
                            lista = (List<List<BEEstadoServicio>>)Session["ListaIndividual"];

                            foreach (List<BEEstadoServicio> list in lista)
                            {
                                if (list[0].ServicioId == Convert.ToInt32(item))
                                {
                                    #region Establece Estados
                                    if (list[0].AR == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "AR");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "AR");

                                    if (list[0].BO == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "BO");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "BO");

                                    if (list[0].CL == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "CL");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "CL");

                                    if (list[0].CO == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "CO");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "CO");

                                    if (list[0].CR == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "CR");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "CR");

                                    if (list[0].DO == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "DO");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "DO");

                                    if (list[0].EC == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "EC");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "EC");

                                    if (list[0].GT == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "GT");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "GT");

                                    if (list[0].MX == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "MX");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "MX");

                                    if (list[0].PA == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "PA");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "PA");

                                    if (list[0].PE == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "PE");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "PE");

                                    if (list[0].PR == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "PR");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "PR");

                                    if (list[0].SV == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "SV");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "SV");

                                    if (list[0].VE == "1")
                                        sv.InsServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "VE");
                                    else
                                        sv.DelServicioCampania(Convert.ToInt32(list[0].CampaniaInicialId), list[0].ServicioId, "VE");
                                    #endregion
                                }
                            }
                        }
                        else
                        {
                            lista = (List<List<BEEstadoServicio>>)Session["ListaRango"];

                            foreach (List<BEEstadoServicio> list in lista)
                            {
                                if (list[0].ServicioId == Convert.ToInt32(item))
                                {
                                    #region Establece Estados
                                    if (list[0].AR == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "AR");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "AR");

                                    if (list[0].BO == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "BO");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "BO");

                                    if (list[0].CL == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "CL");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "CL");

                                    if (list[0].CO == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "CO");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "CO");

                                    if (list[0].CR == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "CR");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "CR");

                                    if (list[0].DO == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "DO");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "DO");

                                    if (list[0].EC == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "EC");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "EC");

                                    if (list[0].GT == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "GT");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "GT");

                                    if (list[0].MX == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "MX");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "MX");

                                    if (list[0].PA == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "PA");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "PA");

                                    if (list[0].PE == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "PE");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "PE");

                                    if (list[0].PR == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "PR");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "PR");

                                    if (list[0].SV == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "SV");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "SV");

                                    if (list[0].VE == "1")
                                        sv.InsServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "VE");
                                    else
                                        sv.DelServicioCampaniaRango(Convert.ToInt32(list[0].CampaniaInicialId), Convert.ToInt32(list[0].CampaniaFinalId), list[0].ServicioId, "VE");
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

        public ActionResult ConsultarServicios(string sidx, string sord, int page, int rows, string vDescripcion, string vCampaniaInicial)
        {
            if (ModelState.IsValid)
            {
                List<BEServicio> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    if (vCampaniaInicial == "0")
                        lst = new List<BEServicio>();
                    else
                        lst = sv.GetServicios(vDescripcion).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, lst);

                // Creamos la estructura
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
                List<BEServicio> lst;

                Session["ListaIndividual"] = null;
                Session["ListaRango"] = null;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    if (vCampaniaInicial == "0")
                        lst = new List<BEServicio>();
                    else
                        lst = sv.GetServicios(vDescripcion).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, lst);

                // Creamos la estructura
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

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = PaginadorDetalle(grid, lst);

                // Creamos la estructura
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
                                   a.Correlativo.ToString(),
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

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEEstadoServicio> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "AR":
                            items = lst.OrderBy(x => x.AR);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "AR":
                            items = lst.OrderByDescending(x => x.AR);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = PaginadorEstado(grid, lst);

                // Creamos la estructura
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
                                   a.AR.ToString(),
                                   a.BO.ToString(),
                                   a.CL.ToString(),
                                   a.CO.ToString(),
                                   a.CR.ToString(),
                                   a.EC.ToString(),
                                   a.SV.ToString(),
                                   a.GT.ToString(),
                                   a.MX.ToString(),
                                   a.PA.ToString(),
                                   a.PE.ToString(),
                                   a.PR.ToString(),
                                   a.DO.ToString(),
                                   a.VE.ToString(),
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
                        if (Session["ListaIndividual"] == null)
                        {
                            List<List<BEEstadoServicio>> lista = new List<List<BEEstadoServicio>>();
                            lista.Add(lst);
                            Session["ListaIndividual"] = lista;
                        }
                        else
                        {
                            List<List<BEEstadoServicio>> lista = (List<List<BEEstadoServicio>>)Session["ListaIndividual"];
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
                            Session["ListaIndividual"] = lista;
                        }
                    }
                    else
                    {
                        lst = sv.GetEstadoServiciobyPais(ServicioId, 0).ToList();
                        lst[0].CampaniaInicialId = CampaniaInicioID.ToString();
                        lst[0].CampaniaFinalId = CampaniaFinalID.ToString();
                        lst[0].ServicioId = ServicioId;
                        if (Session["ListaRango"] == null)
                        {
                            List<List<BEEstadoServicio>> lista = new List<List<BEEstadoServicio>>();
                            lista.Add(lst);
                            Session["ListaRango"] = lista;
                        }
                        else
                        {
                            List<List<BEEstadoServicio>> lista = (List<List<BEEstadoServicio>>)Session["ListaRango"];
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
                            Session["ListaRango"] = lista;
                        }
                    }
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEEstadoServicio> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "AR":
                            items = lst.OrderBy(x => x.AR);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "AR":
                            items = lst.OrderByDescending(x => x.AR);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = PaginadorEstado(grid, lst);

                // Creamos la estructura
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
                                   a.AR.ToString(),
                                   a.BO.ToString(),
                                   a.CL.ToString(),
                                   a.CO.ToString(),
                                   a.CR.ToString(),
                                   a.EC.ToString(),
                                   a.SV.ToString(),
                                   a.GT.ToString(),
                                   a.MX.ToString(),
                                   a.PA.ToString(),
                                   a.PE.ToString(),
                                   a.PR.ToString(),
                                   a.DO.ToString(),
                                   a.VE.ToString(),
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

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }
        public BEPager PaginadorDetalle(BEGrid item, List<BEServicioParametro> lst)
        {

            BEPager pag = new BEPager();

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }
        public BEPager PaginadorEstado(BEGrid item, List<BEEstadoServicio> lst)
        {

            BEPager pag = new BEPager();

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

        private IEnumerable<ParametroModel> DropDowListParametros()
        {
            List<BEParametro> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.SelectParametros().ToList();
            }
            Mapper.CreateMap<BEParametro, ParametroModel>()
                    .ForMember(t => t.ParametroId, f => f.MapFrom(c => c.ParametroId))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.Abreviatura, f => f.MapFrom(c => c.Abreviatura));

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

        private string DevolverValorParametro(int ParametroId)
        {
            switch (ParametroId)
            {
                case 1:
                    return UserData().CodigoISO;
                case 2:
                    return UserData().CampaniaID.ToString();
                case 3:
                    return UserData().CodigoConsultora;
                case 4:
                    return UserData().NombreConsultora;
                case 5:
                    return UserData().EMail;
                default:
                    return "";
            }
        }


        //RQ_BS - R2161
        public JsonResult CargarArbolRegionesZonas(int? pais)
        {
            if (pais.GetValueOrDefault() == 0)
                return Json(null, JsonRequestBehavior.AllowGet);

            // consultar las regiones y zonas
            IList<BEZonificacionJerarquia> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.GetZonificacionJerarquia(pais.GetValueOrDefault());
            }
            // se crea el arbol de nodos para el control de la vista
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

        //RQ_BS - R2161
        public JsonResult CargarServicioPaises(int ServicioId)
        {
            IEnumerable<PaisModel> lst = DropDowListPaisesByServicioId(ServicioId, 0, 1);
            return Json(new
            {
                listapaises = lst
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2161
        public JsonResult CargarServicioCampanias(int ServicioId, int PaisId)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampaniasByServicioId(ServicioId, PaisId, 2);
            return Json(new
            {
                listacampanias = lst
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2161
        public JsonResult CargarSegmentoPais(int PaisId)
        {
            IEnumerable<BESegmentoBanner> lst = null;

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                /*RE2544 - CS(CGI) - 13/05/2015 */
                if (PaisId == 14)
                {
                    lst = sv.GetSegmentoBanner(PaisId);
                }
                else
                {
                    /*RE2544 - CS(CGI) - 13/05/2015 */
                    lst = sv.GetSegmentoInternoBanner(PaisId);
                }
            }

            return Json(new
            {
                listasegmento = lst
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2161
        public JsonResult ObtenerSegmentoZona(int ServicioId, int CampaniaId, int PaisId)
        {
            BEServicioSegmentoZona oBEServicioSegmentoZona = null;

            using (SACServiceClient sv = new SACServiceClient())
            {
                oBEServicioSegmentoZona = sv.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId);
            }

            if (oBEServicioSegmentoZona == null)
            {
                oBEServicioSegmentoZona = new BEServicioSegmentoZona()
                {
                    Segmento = -1,
                    ConfiguracionZona = string.Empty
                };
            }

            return Json(new
            {
                Segmento = oBEServicioSegmentoZona.Segmento,
                ConfiguracionZona = oBEServicioSegmentoZona.ConfiguracionZona
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2161
        private IEnumerable<PaisModel> DropDowListPaisesByServicioId(int ServicioId, int PaisId, int Tipo)
        {
            List<BEServicioSegmentoZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetServicioCampaniaSegmentoZonaAsignados(ServicioId, PaisId, Tipo).ToList();
            }

            Mapper.CreateMap<BEServicioSegmentoZona, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisId))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.NombrePais))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombrePais));
            return Mapper.Map<IList<BEServicioSegmentoZona>, IEnumerable<PaisModel>>(lst);
        }

        //RQ_BS - R2161
        private IEnumerable<CampaniaModel> DropDowListCampaniasByServicioId(int ServicioId, int PaisId, int Tipo)
        {
            List<BEServicioSegmentoZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetServicioCampaniaSegmentoZonaAsignados(ServicioId, PaisId, Tipo).ToList();
            }

            Mapper.CreateMap<BEServicioSegmentoZona, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaId))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.DesCampania))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.DesCampania));
            return Mapper.Map<IList<BEServicioSegmentoZona>, IEnumerable<CampaniaModel>>(lst);

        }

        //RQ_BS - R2161
        /* RE2544 - CS - Agregando nuevo parametro SegmentoInterno */
        public JsonResult UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInternoId)
        {
            string Mensaje = string.Empty;
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.UpdServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId, Segmento, ConfiguracionZona, SegmentoInternoId);
                }
                Mensaje = "La información se guardó con éxito.";
            }
            catch (Exception ex)
            {
                Mensaje = "Ocurrió un error: " + ex.Message;
            }
            EliminarCacheServicio(CampaniaId, PaisId);

            return Json(new
            {
                Mensaje = Mensaje
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2161
        public void EliminarCacheServicio(int CampaniaId, int PaisId)
        {
            try
            {
                using (SACServiceClient svc = new SACServiceClient())
                {
                    svc.DeleteCacheServicio(Util.GetPaisISO(PaisId), CampaniaId);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", Util.GetPaisISO(PaisId));
            }
        }

        /*CGI(RSA) - REQ 2544 INICIO*/
        public JsonResult ObtenerServicioCampaniaSegmentoZona(int CampaniaId, int ServicioId, int PaisId)
        {
            BEServicioSegmentoZona servicio = null;

            using (SACServiceClient sv = new SACServiceClient())
            {
                servicio = sv.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId);
            }

            return Json(new
            {
                Servicio = servicio
            }, JsonRequestBehavior.AllowGet);
        }
        /*CGI(RSA) - REQ 2544 FIN*/
    }
}
