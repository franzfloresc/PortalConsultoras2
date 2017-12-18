﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

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

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
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

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
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
            var listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
            if (listaEntradas != null && listaEntradas.Count > 0)
            {
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

        public ActionResult ConsultarEntradas(string sidx, string sord, int page, int rows, int vpaisID, int vCampaniaID, string vTitulo)
        {
            if (ModelState.IsValid)
            {
                List<AdministrarFeErratasModel> listaEntradas = null;
                
                if (Session["entradas"] != null)
                {
                    listaEntradas = (Session["entradas"] as List<AdministrarFeErratasModel>).Where(e => !e.Eliminar).ToList();
                }
                else
                {
                    List<BEFeErratas> lst;
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.SelectFeErratasEntradas(vpaisID, vCampaniaID, vTitulo).ToList();
                    }
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

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
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
                if (Session["entradas"] == null)
                {
                    Session["entradas"] = new List<AdministrarFeErratasModel>();
                }
                List<AdministrarFeErratasModel> listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
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
                List<AdministrarFeErratasModel> listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
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
                List<AdministrarFeErratasModel> listaEntradas = Session["entradas"] as List<AdministrarFeErratasModel>;
                AdministrarFeErratasModel entrada = listaEntradas.SingleOrDefault(e => e.FeErratasID == FeErratasID);
                if (entrada.FeErratasID < 0)
                {
                    listaEntradas.RemoveAll(e => e.FeErratasID == FeErratasID);
                }
                else
                {
                    entrada.Eliminar = true;
                }
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
