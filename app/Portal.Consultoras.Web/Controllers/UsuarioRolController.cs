using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class UsuarioRolController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "UsuarioRol/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var model = new UsuarioRolModel
            {
                DropDownListRol = CargarRol(),
                listaPaises = DropDowListPaises()
            };
            return View(model);
        }

        public ActionResult ConsultarUsuarioRol(string sidx, string sord, int page, int rows, string vRolDescripcion, string vNombreUsuario)
        {
            if (ModelState.IsValid)
            {
                List<ServiceUsuario.BEUsuarioRol> lst;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    lst = sv.SelectUsuarioRol(userData.PaisID, vRolDescripcion, vNombreUsuario).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<ServiceUsuario.BEUsuarioRol> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoUsuario":
                            items = lst.OrderBy(x => x.CodigoUsuario);
                            break;
                        case "RolDescripcion":
                            items = lst.OrderBy(x => x.RolDescripcion);
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
                        case "RolDescripcion":
                            items = lst.OrderByDescending(x => x.RolDescripcion);
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
                                   a.CodigoUsuario,
                                   a.RolID.ToString(),
                                   a.UsuarioNombre,
                                   a.RolDescripcion
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult InsertarUsuarioRol(UsuarioRolModel model)
        {
            try
            {
                ServiceSeguridad.BEUsuarioRol entidad = Mapper.Map<UsuarioRolModel, ServiceSeguridad.BEUsuarioRol>(model);
                entidad.paisID = userData.PaisID;

                int result;

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    result = sv.InsUsuarioRol(entidad);
                }

                if (result == 1)
                {
                    return Json(new
                    {
                        success = true,
                        message = "rol asignado al usuario satisfactoriamente",
                        extra = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "el usuario ya tiene el rol asignado.",
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
                    message = "No se pudo asociar el Rol al Usuario, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo asociar el Rol al Usuario, intente nuevamente",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult EliminarUsuarioRol(UsuarioRolModel model)
        {
            try
            {
                int retorno;

                ServiceUsuario.BEUsuarioRol entidad = Mapper.Map<UsuarioRolModel, ServiceUsuario.BEUsuarioRol>(model);
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    retorno = sv.DelUsuarioRol(userData.PaisID, entidad.CodigoUsuario, entidad.RolID);
                }

                if (retorno == 1)
                {
                    return Json(new
                    {
                        success = true,
                        message = "Se elimino satisfactoriamente el registro",
                        extra = ""
                    });
                }
                else if (retorno == 2)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El registro no puede ser elminado, se encuentra restringido",
                        extra = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al elminar registro",
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
                    message = "No se pudo eliminar el Rol del Usuario, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo eliminar el Rol del Usuario, intente nuevamente",
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
                    var result = sv.IsUserExist(entidad.PaisID, entidad.CodigoUsuario);

                    if (result)
                    {
                        return Json(new
                        {
                            success = true
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "el codigo ingresado no es válido.",
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
                    message = "No se pudo validar el usuario, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo validar el usuario, intente nuevamente.",
                    extra = ""
                });
            }
        }

        public BEPager Paginador(BEGrid item, List<ServiceUsuario.BEUsuarioRol> lst)
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

        private List<BERol> CargarRol()
        {
            var model = new UsuarioRolModel();

            using (SeguridadServiceClient sv = new SeguridadServiceClient())
            {
                BERol[] beRol = sv.GetRoles(userData.PaisID);

                model.DropDownListRol = beRol.ToList();
                model.DropDownListRol.Insert(0, new BERol { RolID = 0, Descripcion = "-- Seleccionar --" });
                return model.DropDownListRol;
            }
        }
    }
}
