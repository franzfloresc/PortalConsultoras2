using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceZonificacion;

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
                // solo para consultora
                int rol = Constantes.Rol.Consultora;
                using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
                {
                    lst = sv.GetPermisosByRolConsulta(UserData().PaisID, rol, string.Empty).ToList();
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new AdministrarLinkModel());
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
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vpaisID, int vrolID)
        {
            if (ModelState.IsValid)
            {
                List<BEPermiso> lst;
                using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
                {
                    lst = sv.GetPermisosByRolConsulta(vpaisID, vrolID, string.Empty).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
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
                                   vpaisID.ToString(), //a.PaisID.ToString(),
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
                Mapper.CreateMap<AdministrarLinkModel, BEPermiso>()
                   .ForMember(t => t.PermisoID, f => f.MapFrom(c => c.PermisoID))
                   .ForMember(t => t.OrdenItem, f => f.MapFrom(c => c.OrdenItem))
                   .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                   .ForMember(t => t.UrlItem, f => f.MapFrom(c => c.UrlItem))
                   .ForMember(t => t.Posicion, f => f.MapFrom(c => c.Posicion))
                   .ForMember(t => t.PaginaNueva, f => f.MapFrom(c => c.PaginaNueva))
                   .ForMember(t => t.IdPadre, f => f.MapFrom(c => c.PermisoIDPadre));
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

                using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
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
        public JsonResult Actualizar(AdministrarLinkModel model)
        {
            try
            {
                Mapper.CreateMap<AdministrarLinkModel, BEPermiso>()
                   .ForMember(t => t.PermisoID, f => f.MapFrom(c => c.PermisoID))
                   .ForMember(t => t.OrdenItem, f => f.MapFrom(c => c.OrdenItem))
                   .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                   .ForMember(t => t.UrlItem, f => f.MapFrom(c => c.UrlItem))
                   .ForMember(t => t.Posicion, f => f.MapFrom(c => c.Posicion))
                   .ForMember(t => t.PaginaNueva, f => f.MapFrom(c => c.PaginaNueva))
                   .ForMember(t => t.IdPadre, f => f.MapFrom(c => c.PermisoIDPadre));
                BEPermiso entidad = Mapper.Map<AdministrarLinkModel, BEPermiso>(model);

                if (!string.IsNullOrEmpty(entidad.UrlItem) && !entidad.UrlItem.Contains("http"))
                {
                    entidad.UrlItem = "http://" + entidad.UrlItem;
                }

                entidad.RolId = Constantes.Rol.Consultora;

                using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
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

        public JsonResult Eliminar(int PermisoID)
        {
            try
            {
                using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
                {
                    sv.DeletePermiso(UserData().PaisID, PermisoID);
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

        //[ChildActionOnly]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult TraerHeader()
        {
            ViewBag.PermisosHeader = BuildMenuConsultoras();
            ViewBag.ServicioHeader = BuildMenuServiceConsultoras();
            return PartialView("_PreviaMenu");
        }

        //[ChildActionOnly]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult TraerFooter()
        {
            ViewBag.PermisosFooter = BuildMenuConsultoras();
            return PartialView("_PreviaFooter");
        }

        private List<PermisoModel> BuildMenuConsultoras()
        {
            //if (Session["UserData"] != null)
            //{
                int PaisID = UserData().PaisID;
                // se quiere ver el menú para la consultora
                int RolID = Constantes.Rol.Consultora; 
                if (RolID != 0)
                {
                    IList<ServiceSeguridad.BEPermiso> lst = new List<ServiceSeguridad.BEPermiso>();
                    using (ServiceSeguridad.SeguridadServiceClient sv = new ServiceSeguridad.SeguridadServiceClient())
                    {
                        lst = sv.GetPermisosByRolAdministrador(PaisID, RolID).ToList();
                    }
                    Mapper.CreateMap<ServiceSeguridad.BEPermiso, PermisoModel>()
                        .ForMember(x => x.PermisoID, t => t.MapFrom(c => c.PermisoID))
                        .ForMember(x => x.RolId, t => t.MapFrom(c => c.RolId))
                        .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                        .ForMember(x => x.IdPadre, t => t.MapFrom(c => c.IdPadre))
                        .ForMember(x => x.OrdenItem, t => t.MapFrom(c => c.OrdenItem))
                        .ForMember(x => x.UrlItem, t => t.MapFrom(c => c.UrlItem))
                        .ForMember(x => x.PaginaNueva, t => t.MapFrom(c => c.PaginaNueva))
                        .ForMember(x => x.RolId, t => t.MapFrom(c => c.RolId))
                        .ForMember(x => x.Mostrar, t => t.MapFrom(c => c.Mostrar))
                        .ForMember(x => x.Posicion, t => t.MapFrom(c => c.Posicion));

                    return Mapper.Map<IList<ServiceSeguridad.BEPermiso>, List<PermisoModel>>(lst);
                }
                else
                    return new List<PermisoModel>();
            //}
            //else
            //    return new List<PermisoModel>();
        }

        private List<ServicioCampaniaModel> BuildMenuServiceConsultoras()
        {
            // TODO: que campaña pasar?
            if (Session["UserData"] != null)
            {
                int Campaniaid = UserData().CampaniaID;
                IList<ServiceSAC.BEServicioCampania> lst = new List<ServiceSAC.BEServicioCampania>();

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.GetServicioByCampaniaPaisAdministrador(UserData().PaisID, UserData().CampaniaID).ToList();
                }

                Mapper.CreateMap<ServiceSAC.BEServicioCampania, ServicioCampaniaModel>()
                        .ForMember(x => x.ServicioId, t => t.MapFrom(c => c.ServicioId))
                        .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                        .ForMember(x => x.Url, t => t.MapFrom(c => c.Url));

                return Mapper.Map<IList<ServiceSAC.BEServicioCampania>, List<ServicioCampaniaModel>>(lst);
            }
            else
                return new List<ServicioCampaniaModel>();
        }
    }
}
