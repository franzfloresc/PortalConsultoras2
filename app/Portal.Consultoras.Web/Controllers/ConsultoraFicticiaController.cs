using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultoraFicticiaController : BaseController
    {
        //
        // GET: /ConsultoraFicticia/

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
            //try
            //{
            //    Mapper.CreateMap<ConsultoraFicticiaModel, BEConsultora>()
            //        .ForMember(t => t.Codigo, f => f.MapFrom(c => c.CodigoConsultora))
            //        .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

            //    BEConsultora entidad = Mapper.Map<ConsultoraFicticiaModel, BEConsultora>(model);

            //    using (ODSServiceClient sv = new ODSServiceClient())
            //    {
            //        List<BEConsultoraCodigo> lst = new List<BEConsultoraCodigo>();
            //        lst = sv.SelectConsultoraByCodigo(entidad.PaisID, entidad.Codigo).ToList();

            //        if (lst.Count == 0)
            //        {
            //            return Json(new
            //            {
            //                success = false,
            //                message = "el código ingresado no es válido.",
            //                extra = ""
            //            });
            //        }
            //        else
            //        {
            //            return Json(new
            //            {
            //                success = true,
            //                ConsultoraID = lst[0].ConsultoraID
            //            });
            //        }
            //    }
            //}
            try
            {
                Mapper.CreateMap<ConsultoraFicticiaModel, BEUsuario>()
                    .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

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
                Mapper.CreateMap<ConsultoraFicticiaModel, BEConsultoraFicticia>()
                    .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                    .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.ActualizarClave, f => f.MapFrom(c => c.ActualizarClave));

                BEConsultoraFicticia entidad = Mapper.Map<ConsultoraFicticiaModel, BEConsultoraFicticia>(model);
                List<BEConsultora> lst = new List<BEConsultora>();
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

                bool result_ad;

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    result_ad = sv.IsUserExist(bepais.CodigoISO + entidad.CodigoUsuario);
                    //result_ad = true;
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
                    bool Result_User = false;
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        if (result_ad)
                        {
                            //Actualizar Clave en el AD
                            Result_User = sv.ChangePasswordUser(bepais.PaisID, UserData().CodigoUsuario, bepais.CodigoISO + entidad.CodigoUsuario, entidad.ActualizarClave, string.Empty, EAplicacionOrigen.ConsultoraFicticia);
                            //Result_User = true;
                        }
                        else
                        {
                            //Crear usuario en el AD
                            Result_User = sv.CreateActiveDirectoryUser(bepais.CodigoISO + entidad.CodigoUsuario, bepais.CodigoISO + entidad.CodigoUsuario, bepais.CodigoISO + entidad.CodigoUsuario, bepais.CodigoISO + entidad.CodigoUsuario, bepais.CodigoISO, entidad.ActualizarClave);
                            //Result_User = true;
                        }
                        return Json(new
                        {
                            success = true,
                            message = "Usuario de prueba ha sido creado correctamente.",
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
                Mapper.CreateMap<ConsultoraFicticiaModel, BEConsultoraFicticia>()
                    .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                    .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.ActualizarClave, f => f.MapFrom(c => c.ActualizarClave))
                    .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID));

                BEConsultoraFicticia entidad = Mapper.Map<ConsultoraFicticiaModel, BEConsultoraFicticia>(model);

                List<BEConsultora> lst = new List<BEConsultora>();

                using (SACServiceClient sv = new SACServiceClient())
                {

                    sv.UpdConsultoraFicticia(entidad.CodigoUsuario, entidad.CodigoConsultora, entidad.PaisID, entidad.ConsultoraID);
                }

                if (entidad.ActualizarClave != "")
                {
                    BEPais bepais = new BEPais();
                    bool Result_User = false;

                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        bepais = sv.SelectPais(Convert.ToInt32(entidad.PaisID));
                    }

                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        Result_User = sv.ChangePasswordUser(bepais.PaisID, UserData().CodigoUsuario, bepais.CodigoISO + entidad.CodigoUsuario, entidad.ActualizarClave, string.Empty, EAplicacionOrigen.ConsultoraFicticia);
                    }
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
                Mapper.CreateMap<ConsultoraFicticiaModel, BEConsultoraFicticia>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario));

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

                    // Usamos el modelo para obtener los datos
                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
                    //int buscar = int.Parse(txtBuscar);
                    BEPager pag = new BEPager();
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

                    // Usamos el modelo para obtener los datos
                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
                    //int buscar = int.Parse(txtBuscar);
                    BEPager pag = new BEPager();
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
    }
}
