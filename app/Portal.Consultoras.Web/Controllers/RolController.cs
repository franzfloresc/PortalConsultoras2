using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSeguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class RolController : BaseController
    {
        public ActionResult Rol()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Rol/Rol"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View();
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vDescripcion)
        {
            if (ModelState.IsValid)
            {
                int paisId = userData.PaisID;
                List<BERol> lst;
                using (SeguridadServiceClient srv = new SeguridadServiceClient())
                {
                    lst = srv.GetRoles(paisId).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BERol> items = lst;

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
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                    }
                }
                #endregion

                items = string.IsNullOrEmpty(vDescripcion)
                    ? items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize)
                    : items.Where(p => p.Descripcion.ToUpper().Contains(vDescripcion.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, items.ToList());

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.RolID.ToString(),
                               cell = new string[]
                               {
                                   a.RolID.ToString(),
                                   a.Descripcion
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult Mantener(RolModel model)
        {
            if (model.RolID == 0)
                return Insertar(model);
            else
                return Actualizar(model);
        }

        public JsonResult Insertar(RolModel model)
        {
            try
            {
                BERol rol = Mapper.Map<RolModel, BERol>(model);

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    rol.PaisID = userData.PaisID;
                    var vValidation = sv.VerifyRolByDescripcion(rol);
                    if (vValidation == 0)
                    {
                        if (rol.Descripcion.ToLower().Equals("administrador") || model.Descripcion.ToLower().Equals("consultora"))
                            rol.Sistema = 1;
                        else
                            rol.Sistema = 0;
                        sv.InsRol(rol);
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Rol ya ha sido registrado, ingrese un nombre diferente.",
                            extra = ""
                        });
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Rol ha sido ingresado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult Actualizar(RolModel model)
        {
            try
            {
                BERol rol = Mapper.Map<RolModel, BERol>(model);

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    rol.PaisID = userData.PaisID;
                    var vValidation = sv.VerifyRolByDescripcion(rol);
                    if (vValidation == 0)
                    {
                        sv.UpdRol(rol);
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Rol ya ha sido registrado, ingrese un nombre diferente.",
                            extra = ""
                        });
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Rol ha sido actualizado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo actualizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult Eliminar(int RolID)
        {
            try
            {
                int paisId = userData.PaisID;
                int result;

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    result = sv.DelRol(paisId, RolID);
                }
                if (result == 0)
                {
                    return Json(new
                    {
                        success = true,
                        message = "Se elimino satisfactoriamente el registro.",
                        extra = ""
                    });
                }
                else if (result == 1)
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se puede eliminar Rol del sistema.",
                        extra = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se puede eliminar Rol porque está asignado a uno o más usuarios.",
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
        }

        public JsonResult CargarPermiso(int RolID)
        {
            List<BEPermiso> permisos;
            using (SeguridadServiceClient srv = new SeguridadServiceClient())
            {
                int paisId = userData.PaisID;
                permisos = srv.GetAllPermisosCheckByRol(paisId, RolID).ToList();
            }
            int index = 0;
            List<BEPermiso> filtrados = permisos.FindAll(delegate (BEPermiso m) { return m.IdPadre == 0 && m.Mostrar; }).OrderBy(p => p.OrdenItem).ToList();
            var tree = new JsTreeModel[filtrados.Count];
            foreach (BEPermiso perm in filtrados)
            {
                if (permisos.FindAll(delegate (BEPermiso m) { return m.IdPadre == perm.PermisoID && m.Mostrar; }).Count == 0)
                {
                    tree[index] = new JsTreeModel { data = perm.Descripcion, attr = new JsTreeAttribute { id = perm.PermisoID, @class = (perm.RolId > 0 ? "jstree-checked" : "jstree-unchecked") } };
                }
                else
                {
                    tree[index] = new JsTreeModel
                    {
                        data = perm.Descripcion,
                        attr = new JsTreeAttribute { id = perm.PermisoID },
                        children = CargarSubMenus(new JsTreeModel(), perm, permisos)
                    };
                }
                index++;
            }
            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        public JsTreeModel[] CargarSubMenus(JsTreeModel tree, BEPermiso padre, List<BEPermiso> permisos)
        {
            int index = 0;
            JsTreeModel[] nodo = null;
            List<BEPermiso> filtrados = permisos.FindAll(delegate (BEPermiso m) { return m.IdPadre == padre.PermisoID; }).OrderBy(p => p.OrdenItem).ToList();
            if (filtrados.Count > 0)
            {
                nodo = new JsTreeModel[filtrados.Count];
                foreach (BEPermiso perm in filtrados)
                {
                    nodo[index] = new JsTreeModel
                    {
                        data = perm.Descripcion,
                        attr = new JsTreeAttribute { id = perm.PermisoID, @class = (perm.RolId > 0 ? (filtrados.FindAll(x => x.IdPadre == perm.PermisoID).Count == 0 ? "jstree-checked" : "jstree-unchecked") : "jstree-unchecked") },
                        children = CargarSubMenus(new JsTreeModel(), perm, permisos)
                    };
                    index++;
                }
            }
            return nodo;
        }

        public JsonResult InsertarPermiso(int RolID, List<string> permisos)
        {
            int paisId = userData.PaisID;
            try
            {
                using (SeguridadServiceClient srv = new SeguridadServiceClient())
                {
                    string result;
                    if (permisos == null)
                        result = string.Empty;
                    else
                        result = (from c in permisos
                                  select c).Aggregate((a, p) => a + "," + p);
                    srv.InsPermisosByRolMasiv(paisId, RolID, result);
                }

                return Json(new
                {
                    success = true,
                    message = "Los permisos han sido ingresados satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubó un problema al insertar el Permiso, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubó un problema al insertar el Permiso, intente nuevamente",
                    extra = ""
                });
            }
        }
    }
}
