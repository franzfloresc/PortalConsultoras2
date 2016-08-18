using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using AutoMapper;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class UsuarioRolController : BaseController
    {
        //
        // GET: /UsuarioRol/

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "UsuarioRol/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            var model = new UsuarioRolModel();
            model.DropDownListRol = CargarRol();
            model.listaPaises = DropDowListPaises();
            return View(model);
        }
        public ActionResult ConsultarUsuarioRol(string sidx, string sord, int page, int rows, string vRolDescripcion, string vNombreUsuario)
        {
            if (ModelState.IsValid)
            {
                List<ServiceUsuario.BEUsuarioRol> lst;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    lst = sv.SelectUsuarioRol(UserData().PaisID, vRolDescripcion, vNombreUsuario).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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
                Mapper.CreateMap<UsuarioRolModel, ServiceSeguridad.BEUsuarioRol>()
                    .ForMember(t => t.RolID, f => f.MapFrom(c => c.RolID))
                    .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario));

                ServiceSeguridad.BEUsuarioRol entidad = Mapper.Map<UsuarioRolModel, ServiceSeguridad.BEUsuarioRol>(model);
                entidad.paisID = UserData().PaisID;

                List<BERol> lst = new List<BERol>();
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo asociar el Rol al Usuario, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                Mapper.CreateMap<UsuarioRolModel, ServiceUsuario.BEUsuarioRol>()
                    .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                    .ForMember(t => t.RolID, f => f.MapFrom(c => c.RolID));

                int retorno;

                ServiceUsuario.BEUsuarioRol entidad = Mapper.Map<UsuarioRolModel, ServiceUsuario.BEUsuarioRol>(model);
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    retorno = sv.DelUsuarioRol(UserData().PaisID, entidad.CodigoUsuario, entidad.RolID);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo eliminar el Rol del Usuario, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                Mapper.CreateMap<ConsultoraFicticiaModel, BEUsuario>()
                    .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

                BEUsuario entidad = Mapper.Map<ConsultoraFicticiaModel, BEUsuario>(model);
                BEPais bepais = new BEPais();

                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bepais = sv.SelectPais(Convert.ToInt32(entidad.PaisID));
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    bool result;
                    result = sv.IsUserExist(bepais.CodigoISO + entidad.CodigoUsuario);

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo validar el usuario, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
        private List<BERol> CargarRol()
        {
            var model = new UsuarioRolModel();

            using (SeguridadServiceClient sv = new SeguridadServiceClient())
            {
                BERol[] beRol = sv.GetRoles(UserData().PaisID);

                model.DropDownListRol = beRol.ToList();
                model.DropDownListRol.Insert(0, new BERol { RolID = 0, Descripcion = "-- Seleccionar --" });
                return model.DropDownListRol;
            }
        }
    }
}
