using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            var model = new ConsultoraFicticiaModel();
            model.listaPaises = DropDowListPaises();
            return View(model);
        }

        [HttpPost]
        public JsonResult ValidarConsultora(ConsultoraFicticiaModel model)
        {
            try
            {
                BEUsuario entidad = Mapper.Map<ConsultoraFicticiaModel, BEUsuario>(model);
                BEPais bepais = new BEPais();

                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bepais = sv.SelectPais(Convert.ToInt32(entidad.PaisID));
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    int result_portal;

                    result_portal = sv.ValidarUsuarioPrueba(entidad.CodigoConsultora, entidad.PaisID);

                    if (result_portal == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "el código ingresado no es válido.",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = true,
                            ConsultoraID = result_portal
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
        public JsonResult ValidarUsuario(ConsultoraFicticiaModel model)
        {
            try
            {
                BEUsuario entidad = Mapper.Map<ConsultoraFicticiaModel, BEUsuario>(model);
                BEPais bepais = new BEPais();

                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bepais = sv.SelectPais(Convert.ToInt32(entidad.PaisID));
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    int result_portal;

                    result_portal = sv.ValidarUsuarioPrueba(entidad.CodigoUsuario, entidad.PaisID);

                    if (result_portal > 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "el código ingresado ya existe",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = true
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

                BEPais bepais = new BEPais();

                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bepais = sv.SelectPais(Convert.ToInt32(entidad.PaisID));
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
                else if (result == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un problema al Insertar la Consultora, Intente nuevamente por favor.",
                        extra = ""
                    });
                }
                else
                {

                    return Json(new
                    {
                        success = true,
                        message = "Usuario de prueba ha sido creado correctamente.",
                        extra = ""
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Insertar la Consultora, Intente nuevamente por favor.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Actualizar el usuario de prueba, Intente nuevamente por favor",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al Eliminar la Consultora, Intente nuevamente por favor",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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

                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
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

                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
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

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
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

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }
    }
}
