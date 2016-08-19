using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarFeErratasController : BaseController
    {
        public JsonResult EliminarSesion()
        {
            Session.Remove("entradas");
            Session.Remove("criterios");
            return Json(new { success = true }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarFeErratas/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                IEnumerable<CampaniaModel> lstCampania = DropDowListCampanias(UserData().PaisID);
                var administrarFeErratasModel = new AdministrarFeErratasModel()
                {
                    listaPaises = DropDowListPaises(),
                    listaCampania = lstCampania
                };

                Session.Remove("entradas");

                return View(administrarFeErratasModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new AdministrarFeErratasModel());
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

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            //PaisID = 11;
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenterDropDownPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lstcampania = DropDowListCampanias(PaisID);

            return Json(new
            {
                lstCampania = lstcampania
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vpaisID, int vCampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEFeErratas> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectFeErratas(vpaisID, vCampaniaID).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEFeErratas> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "PaisNombre":
                            items = lst.OrderBy(x => x.PaisNombre);
                            break;
                        case "NombreCorto":
                            items = lst.OrderBy(x => x.NombreCorto);
                            break;
                        case "Titulo":
                            items = lst.OrderBy(x => x.Titulo);
                            break;
                        case "Dice":
                            items = lst.OrderBy(x => x.Dice);
                            break;
                        case "DebeDecir":
                            items = lst.OrderBy(x => x.DebeDecir);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "PaisNombre":
                            items = lst.OrderByDescending(x => x.PaisNombre);
                            break;
                        case "NombreCorto":
                            items = lst.OrderByDescending(x => x.NombreCorto);
                            break;
                        case "Titulo":
                            items = lst.OrderByDescending(x => x.Titulo);
                            break;
                        case "Dice":
                            items = lst.OrderByDescending(x => x.Dice);
                            break;
                        case "DebeDecir":
                            items = lst.OrderByDescending(x => x.DebeDecir);
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
                    ISOPais = Util.GetPaisISO(vpaisID),
                    rows = from a in items
                           select new
                           {
                               id = a.FeErratasID.ToString(),
                               cell = new string[] 
                               {
                                   a.FeErratasID.ToString(),
                                   a.PaisID.ToString(),
                                   a.CampaniaID.ToString(),
                                   a.NombreCorto,
                                   a.Titulo,
                                   a.Dice,
                                   a.DebeDecir
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarFeErratas");
        }

        [HttpPost]
        public JsonResult Mantener(AdministrarFeErratasModel model)
        {
            // se lee la lista de Session
            var listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
            if (listaEntradas != null && listaEntradas.Count>0)
            {
                // se realiza el mapeo
                Mapper.CreateMap<AdministrarFeErratasModel, BEFeErratas>()
                   .ForMember(t => t.FeErratasID, f => f.MapFrom(c => c.FeErratasID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                   .ForMember(t => t.Titulo, f => f.MapFrom(c => c.Titulo))
                   .ForMember(t => t.Pagina, f => f.MapFrom(c => c.Pagina))
                   .ForMember(t => t.Dice, f => f.MapFrom(c => c.Dice))
                   .ForMember(t => t.DebeDecir, f => f.MapFrom(c => c.DebeDecir));
                var updateErratas = listaEntradas.Where(x => !x.Eliminar).Select(Mapper.Map<AdministrarFeErratasModel, BEFeErratas>).ToArray();
                foreach (var item in updateErratas)
                {
                    item.PaisID = model.PaisID;
                    item.CampaniaID = model.CampaniaID;
                    item.Titulo = Request.Form["Titulo"];
                }
                try
                {
                    // se itera en cada elemento para realizar o bien una inserción o una actualización, según corresponda
                    using (var sv = new SACServiceClient())
                    {
                        sv.SaveChangesFeErratas(model.PaisID, updateErratas, listaEntradas.Where(x => x.Eliminar).Select(Mapper.Map<AdministrarFeErratasModel, BEFeErratas>).ToArray());
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
            // se limpia la variable de Session
            Session.Remove("entradas");
            return Json(new
            {
                success = true,
                message = "El registro se realizó con éxito.",
                extra = ""
            });
        }

        [HttpPost]
        public JsonResult Eliminar(int FeErratasID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteFeErratas(UserData().PaisID, FeErratasID);
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

        // trae de sesión + bd las entradas que corresponden a determinado Pais+Campaña+Titulo
        public ActionResult ConsultarEntradas(string sidx, string sord, int page, int rows, int vpaisID, int vCampaniaID, string vTitulo)
        {
            if (ModelState.IsValid)
            {
                List<AdministrarFeErratasModel> listaEntradas = null;

                // se consulta si los criterios de búsqueda son diferentes, en cuyo caso se limpia el Session de entradas
                //if ((Session["criterios"] != null) && 
                //    Session["criterios"].ToString().Split(new char[] { ';' })[2] == "default")
                //{
                //    Session["criterios"] = string.Join(";", new Object[] { vpaisID, vCampaniaID, vTitulo });
                //}
                //string criterios = string.Join(";", new Object[] { vpaisID, vCampaniaID, vTitulo });
                //if ((Session["criterios"] == null) || 
                //    (Session["criterios"].ToString() != criterios))
                //{
                //    Session.Remove("entradas");
                //}

                // se valida si existe Session
                // si ya existe: se leen las entradas de alli, sin considerar las marcadas para eliminación
                if (Session["entradas"] != null)
                {
                    listaEntradas = (Session["entradas"] as List<AdministrarFeErratasModel>).Where(e => e.Eliminar == false).ToList();
                }
                // de lo contrario: se traen de la bd y se ponen en Session
                else
                {
                    List<BEFeErratas> lst;
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.SelectFeErratasEntradas(vpaisID, vCampaniaID, vTitulo).ToList();
                    }
                    // se hace el mapeo de la colección
                    Mapper.CreateMap<BEFeErratas, AdministrarFeErratasModel>()
                       .ForMember(t => t.FeErratasID, f => f.MapFrom(c => c.FeErratasID))
                       .ForMember(t => t.Pagina, f => f.MapFrom(c => c.Pagina))
                       .ForMember(t => t.Dice, f => f.MapFrom(c => c.Dice))
                       .ForMember(t => t.DebeDecir, f => f.MapFrom(c => c.DebeDecir));
                    List<AdministrarFeErratasModel> entidades = Mapper.Map<IEnumerable<BEFeErratas>, List<AdministrarFeErratasModel>>(lst);
                    listaEntradas = new List<AdministrarFeErratasModel>();
                    listaEntradas.AddRange(entidades);
                    Session["entradas"] = listaEntradas;
                }

                // se guardan los criterios de búsqueda
                //Session["criterios"] = string.Join(";", new Object[] { vpaisID, vCampaniaID, vTitulo });

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<AdministrarFeErratasModel> items = listaEntradas;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Página":
                            items = listaEntradas.OrderBy(x => x.Pagina);
                            break;
                        case "Dice":
                            items = listaEntradas.OrderBy(x => x.Dice);
                            break;
                        case "DebeDecir":
                            items = listaEntradas.OrderBy(x => x.DebeDecir);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Página":
                            items = listaEntradas.OrderByDescending(x => x.Pagina);
                            break;
                        case "Dice":
                            items = listaEntradas.OrderByDescending(x => x.Dice);
                            break;
                        case "DebeDecir":
                            items = listaEntradas.OrderByDescending(x => x.DebeDecir);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, listaEntradas);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.FeErratasID.ToString(),
                               cell = new string[] 
                               {
                                   a.FeErratasID.ToString(),
                                   a.Pagina.ToString(),
                                   a.Dice,
                                   a.DebeDecir
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarFeErratas");
        }

        [HttpPost]
        public JsonResult AgregarEntrada(AdministrarFeErratasModel model)
        {
            try
            {
                // se agrega la entrada a la lista de Session
                if (Session["entradas"] == null)
                {
                    Session["entradas"] = new List<AdministrarFeErratasModel>();
                }
                List<AdministrarFeErratasModel> listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
                // calcula el id para la nueva entrada
                int nuevoId = (listaEntradas.Count + 1) * -1;
                model.FeErratasID = nuevoId;
                listaEntradas.Add(model);
                Session["entradas"] = listaEntradas;

                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito tu Entrada de Fe de Erratas.",
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
        public JsonResult ActualizarEntrada(AdministrarFeErratasModel model)
        {
            try
            {
                // se obtiene la lista de Session
                List<AdministrarFeErratasModel> listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
                // se ubica la entrada en la lista y se actualiza
                AdministrarFeErratasModel entrada = listaEntradas.SingleOrDefault(e => e.FeErratasID == model.FeErratasID);
                entrada.Pagina = model.Pagina;
                entrada.Dice = model.Dice;
                entrada.DebeDecir = model.DebeDecir;
                Session["entradas"] = listaEntradas;

                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu Entrada de Fe de Erratas.",
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
        public JsonResult EliminarEntrada(int FeErratasID)
        {
            try
            {
                // se obtiene la lista de entradas de Session
                List<AdministrarFeErratasModel> listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
                // si la entrada es nueva (id negativo) se elimina de la lista en Session
                AdministrarFeErratasModel entrada = listaEntradas.SingleOrDefault(e => e.FeErratasID == FeErratasID);
                if (entrada.FeErratasID < 0)
                {
                    listaEntradas.RemoveAll(e => e.FeErratasID == FeErratasID);
                }
                // de lo contrario se marca para eliminación
                else
                {
                    entrada.Eliminar = true;
                }
                // se actualiza la lista en Session
                Session["entradas"] = listaEntradas;

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
    }
}
