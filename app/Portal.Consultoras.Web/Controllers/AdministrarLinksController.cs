using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarLinksController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarLinks/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                List<BEPermiso> lst;
                int rol = Constantes.Rol.Consultora;
                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    lst = sv.GetPermisosByRolConsulta(userData.PaisID, rol, string.Empty).ToList();
                }

                var administrarLinkModel = new AdministrarLinkModel()
                {
                    listaPaises = DropDowListPaises(),
                    listaLinks = lst.Where(p => p.IdPadre == 0)
                };
                return View(administrarLinkModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new AdministrarLinkModel());
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

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vpaisID, int vrolID)
        {
            if (ModelState.IsValid)
            {
                List<BEPermiso> lst;
                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    lst = sv.GetPermisosByRolConsulta(vpaisID, vrolID, string.Empty).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEPermiso> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Descripción":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "URL":
                            items = lst.OrderBy(x => x.UrlItem);
                            break;
                        case "Orden":
                            items = lst.OrderBy(x => x.OrdenItem);
                            break;
                        case "Posición":
                            items = lst.OrderBy(x => x.Posicion);
                            break;
                        case "Nueva Ventana":
                            items = lst.OrderBy(x => x.DescripcionPaginaNueva);
                            break;
                        case "Padre":
                            items = lst.OrderBy(x => x.DescripcionPadre);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Descripción":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "URL":
                            items = lst.OrderByDescending(x => x.UrlItem);
                            break;
                        case "Orden":
                            items = lst.OrderByDescending(x => x.OrdenItem);
                            break;
                        case "Posición":
                            items = lst.OrderByDescending(x => x.Posicion);
                            break;
                        case "Nueva Ventana":
                            items = lst.OrderByDescending(x => x.DescripcionPaginaNueva);
                            break;
                        case "Padre":
                            items = lst.OrderByDescending(x => x.DescripcionPadre);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.PermisoID.ToString(),
                               cell = new string[]
                               {
                                   a.PermisoID.ToString(),
                                   vpaisID.ToString(),
                                   a.Descripcion,
                                   a.UrlItem,
                                   a.OrdenItem.ToString(),
                                   a.Posicion,
                                   a.DescripcionPaginaNueva,
                                   a.DescripcionPadre,
                                   string.Empty,
                                   a.IdPadre.ToString(),
                                   a.PaginaNueva.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarLinks");
        }

        [HttpPost]
        public ActionResult Mantener(AdministrarLinkModel model)
        {
            var result = model.PermisoID == 0 ? Insertar(model) : Actualizar(model);
            if (Request.IsAjaxRequest())
            {
                return result;
            }
            return Content(JsonConvert.SerializeObject(result.Data), "text/html");
        }

        [HttpPost]
        public JsonResult Insertar(AdministrarLinkModel model)
        {
            try
            {
                BEPermiso entidad = Mapper.Map<AdministrarLinkModel, BEPermiso>(model);

                if (!string.IsNullOrEmpty(entidad.UrlItem) && !entidad.UrlItem.Contains("http"))
                {
                    entidad.UrlItem = "http://" + entidad.UrlItem;
                }

                if (model.PaisID == 0)
                {
                    entidad.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                    model.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                }

                entidad.RolId = Constantes.Rol.Consultora;

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    sv.InsPermiso(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito tu link.",
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
        public JsonResult Actualizar(AdministrarLinkModel model)
        {
            try
            {
                BEPermiso entidad = Mapper.Map<AdministrarLinkModel, BEPermiso>(model);

                if (!string.IsNullOrEmpty(entidad.UrlItem) && !entidad.UrlItem.Contains("http"))
                {
                    entidad.UrlItem = "http://" + entidad.UrlItem;
                }

                entidad.RolId = Constantes.Rol.Consultora;

                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    sv.UpdatePermiso(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu link.",
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

        public JsonResult Eliminar(int PermisoID)
        {
            try
            {
                using (SeguridadServiceClient sv = new SeguridadServiceClient())
                {
                    sv.DeletePermiso(userData.PaisID, PermisoID);
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

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult TraerHeader()
        {
            ViewBag.PermisosHeader = BuildMenuConsultoras();
            ViewBag.ServicioHeader = BuildMenuServiceConsultoras();
            return PartialView("_PreviaMenu");
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult TraerFooter()
        {
            ViewBag.PermisosFooter = BuildMenuConsultoras();
            return PartialView("_PreviaFooter");
        }

        private List<PermisoModel> BuildMenuConsultoras()
        {
            IList<BEPermiso> lst;
            using (SeguridadServiceClient sv = new SeguridadServiceClient())
            {
                lst = sv.GetPermisosByRolAdministrador(userData.PaisID, Constantes.Rol.Consultora).ToList();
            }

            return Mapper.Map<IList<BEPermiso>, List<PermisoModel>>(lst);

        }

        private List<ServicioCampaniaModel> BuildMenuServiceConsultoras()
        {
            if (sessionManager.GetUserData() != null)
            {
                IList<BEServicioCampania> lst;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.GetServicioByCampaniaPaisAdministrador(userData.PaisID, userData.CampaniaID).ToList();
                }

                return Mapper.Map<IList<BEServicioCampania>, List<ServicioCampaniaModel>>(lst);
            }
            else
                return new List<ServicioCampaniaModel>();
        }
    }
}
