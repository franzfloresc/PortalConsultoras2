using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultoraFicticiaController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ConsultoraFicticia/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var model = new ConsultoraFicticiaModel { listaPaises = DropDowListPaises() };
            return View(model);
        }

        [HttpPost]
        public JsonResult ValidarConsultora(ConsultoraFicticiaModel model)
        {
            try
            {
                BEUsuario entidad = Mapper.Map<ConsultoraFicticiaModel, BEUsuario>(model);

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    var resultPortal = sv.ValidarUsuarioPrueba(entidad.CodigoConsultora, entidad.PaisID);

                    if (resultPortal == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "el código ingresado no es válido.",
                            extra = ""
                        });
                    }

                    return Json(new
                    {
                        success = true,
                        ConsultoraID = resultPortal
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
        public JsonResult ValidarUsuario(ConsultoraFicticiaModel model)
        {
            try
            {
                BEUsuario entidad = Mapper.Map<ConsultoraFicticiaModel, BEUsuario>(model);

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    var resultPortal = sv.ValidarUsuarioPrueba(entidad.CodigoUsuario, entidad.PaisID);

                    if (resultPortal > 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "el código ingresado ya existe",
                            extra = ""
                        });
                    }

                    return Json(new
                    {
                        success = true
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
        public JsonResult InsertarConsultoraFicticia(ConsultoraFicticiaModel model)
        {
            try
            {
                BEConsultoraFicticia entidad = Mapper.Map<ConsultoraFicticiaModel, BEConsultoraFicticia>(model);

                int result;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    result = sv.InsConsultoraFicticia(entidad);
                }

                if (result == 3)
                {
                    return Json(new
                    {
                        success = false,
                        message = "el código de usuario ya ha sido registrado.",
                        extra = ""
                    });
                }

                if (result == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un problema al Insertar la Consultora, Intente nuevamente por favor.",
                        extra = ""
                    });
                }

                return Json(new
                {
                    success = true,
                    message = "Usuario de prueba ha sido creado correctamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Insertar la Consultora, Intente nuevamente por favor.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Insertar la Consultora, Intente nuevamente por favor.",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult ActualizarConsultoraFicticia(ConsultoraFicticiaModel model)
        {
            try
            {
                BEConsultoraFicticia entidad = Mapper.Map<ConsultoraFicticiaModel, BEConsultoraFicticia>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.UpdConsultoraFicticia(entidad.CodigoUsuario, entidad.CodigoConsultora, entidad.PaisID, entidad.ConsultoraID, entidad.ActualizarClave);
                }

                return Json(new
                {
                    success = true,
                    message = "Usuario de prueba ha sido actualizado correctamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Actualizar el usuario de prueba, Intente nuevamente por favor",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Actualizar la Consultora, Intente nuevamente por favor",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult EliminarConsultoraFicticia(ConsultoraFicticiaModel model)
        {
            try
            {
                BEConsultoraFicticia entidad = Mapper.Map<ConsultoraFicticiaModel, BEConsultoraFicticia>(model);
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DelConsultoraFicticia(entidad.PaisID, entidad.CodigoUsuario);
                }
                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
                    extra = ""
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Eliminar la Consultora, Intente nuevamente por favor",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Eliminar la Consultora, Intente nuevamente por favor",
                    extra = ""
                });
            }
        }

        public ActionResult ConsultarConsultoraFicticia(string sidx, string sord, int page, int rows, string vPaisID, string vCodigoUsuario, string vNombreCompleto)
        {
            if (ModelState.IsValid)
            {
                if (vPaisID != "")
                {
                    List<BEConsultoraFicticia> lst;
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.SelectConsultoraFicticia(Convert.ToInt32(vPaisID), vCodigoUsuario, vNombreCompleto).ToList();
                    }

                    BEGrid grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<BEConsultoraFicticia> items = lst;

                    #region Sort Section
                    if (sord == "asc")
                    {
                        switch (sidx)
                        {
                            case "CodigoUsuario":
                                items = lst.OrderBy(x => x.CodigoUsuario);
                                break;
                            case "CodigoConsultora":
                                items = lst.OrderBy(x => x.CodigoConsultora);
                                break;
                            case "NombreCompleto":
                                items = lst.OrderBy(x => x.NombreCompleto);
                                break;
                            case "PaisNombre":
                                items = lst.OrderBy(x => x.PaisNombre);
                                break;
                            case "ZonaNombre":
                                items = lst.OrderBy(x => x.ZonaNombre);
                                break;
                        }
                    }
                    else
                    {
                        switch (sidx)
                        {
                            case "CodigoUsuario":
                                items = lst.OrderByDescending(x => x.CodigoUsuario);
                                break;
                            case "CodigoConsultora":
                                items = lst.OrderByDescending(x => x.CodigoConsultora);
                                break;
                            case "NombreCompleto":
                                items = lst.OrderByDescending(x => x.NombreCompleto);
                                break;
                            case "PaisNombre":
                                items = lst.OrderByDescending(x => x.PaisNombre);
                                break;
                            case "ZonaNombre":
                                items = lst.OrderByDescending(x => x.ZonaNombre);
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
                                   cell = new string[]
                                   {
                                a.ConsultoraID.ToString(),
                                vPaisID,
                                a.CodigoUsuario,
                                a.CodigoConsultora,
                                a.NombreCompleto,
                                a.PaisNombre,
                                a.ZonaNombre
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    List<BEConsultoraFicticia> lst = new List<BEConsultoraFicticia>();

                    BEGrid grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<BEConsultoraFicticia> items = lst;

                    #region Sort Section
                    if (sord == "asc")
                    {
                        switch (sidx)
                        {
                            case "CodigoUsuario":
                                items = lst.OrderBy(x => x.CodigoUsuario);
                                break;
                            case "CodigoConsultora":
                                items = lst.OrderBy(x => x.CodigoConsultora);
                                break;
                            case "NombreCompleto":
                                items = lst.OrderBy(x => x.NombreCompleto);
                                break;
                            case "PaisNombre":
                                items = lst.OrderBy(x => x.PaisNombre);
                                break;
                            case "ZonaNombre":
                                items = lst.OrderBy(x => x.ZonaNombre);
                                break;
                        }
                    }
                    else
                    {
                        switch (sidx)
                        {
                            case "CodigoUsuario":
                                items = lst.OrderByDescending(x => x.CodigoUsuario);
                                break;
                            case "CodigoConsultora":
                                items = lst.OrderByDescending(x => x.CodigoConsultora);
                                break;
                            case "NombreCompleto":
                                items = lst.OrderByDescending(x => x.NombreCompleto);
                                break;
                            case "PaisNombre":
                                items = lst.OrderByDescending(x => x.PaisNombre);
                                break;
                            case "ZonaNombre":
                                items = lst.OrderByDescending(x => x.ZonaNombre);
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
                                   cell = new string[]
                                   {
                                a.ConsultoraID.ToString(),
                                vPaisID,
                                a.CodigoUsuario,
                                a.CodigoConsultora,
                                a.NombreCompleto,
                                a.PaisNombre,
                                a.ZonaNombre
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public BEPager Paginador(BEGrid item, List<BEConsultoraFicticia> lst)
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
    }
}
