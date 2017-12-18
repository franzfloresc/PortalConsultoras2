﻿using AutoMapper;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View();
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vDescripcion)
        {
            if (ModelState.IsValid)
            {
                int paisID = UserData().PaisID;
                List<BERol> lst;
                using (SeguridadServiceClient srv = new SeguridadServiceClient())
                {
                    lst = srv.GetRoles(paisID).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;

                BEPager pag = new BEPager();
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

                if (string.IsNullOrEmpty(vDescripcion))
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                else
                    items = items.Where(p => p.Descripcion.ToUpper().Contains(vDescripcion.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, items.ToList());

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
            int vValidation = 0;
            try
            {
                Mapper.CreateMap<RolModel, BERol>()
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.Sistema, f => f.MapFrom(c => c.Sistema))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

                BERol rol = Mapper.Map<RolModel, BERol>(model);

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    rol.PaisID = UserData().PaisID;
                    vValidation = sv.VerifyRolByDescripcion(rol);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
            int vValidation = 0;
            try
            {
                Mapper.CreateMap<RolModel, BERol>()
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.RolID, f => f.MapFrom(c => c.RolID))
                    .ForMember(t => t.Sistema, f => f.MapFrom(c => c.Sistema))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

                BERol rol = Mapper.Map<RolModel, BERol>(model);

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    rol.PaisID = UserData().PaisID;
                    vValidation = sv.VerifyRolByDescripcion(rol);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo actualizar el registro del Rol, intente nuevamente",
                    extra = ""
                });
            }

            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                int PaisID = UserData().PaisID;
                int result = 0;

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    result = sv.DelRol(PaisID, RolID);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
            JsTreeModel[] tree = null;

            List<BEPermiso> permisos;
            using (SeguridadServiceClient srv = new SeguridadServiceClient())
            {
                int paisID = UserData().PaisID;
                permisos = srv.GetAllPermisosCheckByRol(paisID, RolID).ToList();
            }
            int index = 0;
            List<BEPermiso> filtrados = permisos.FindAll(delegate (BEPermiso m) { return m.IdPadre == 0 && m.Mostrar; }).OrderBy(p => p.OrdenItem).ToList();
            tree = new JsTreeModel[filtrados.Count];
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
            int paisID = UserData().PaisID;
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
                    srv.InsPermisosByRolMasiv(paisID, RolID, result);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubó un problema al insertar el Permiso, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
