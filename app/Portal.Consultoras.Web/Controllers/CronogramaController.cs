using AutoMapper;
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
    public class CronogramaController : BaseController
    {

        #region Actions

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Cronograma/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            int PaisId = UserData().PaisID;

            bool CroAuto = false;
            int CampaniaIDActual = 0;
            using (SACServiceClient sv = new SACServiceClient())
            {
                CroAuto = sv.GetCronogramaAutomaticoActivacion(PaisId);
                CampaniaIDActual = sv.GetCampaniaFacturacionPais(PaisId);
            }

            var cronogramaModel = new CronogramaModel()
            {
                listaPaises = DropDowListPaises(),
                listaCampania = DropDowListCampanias(PaisId),
                listaZonas = DropDownListZonas(PaisId),
                PaisID = PaisId,
                CampaniaID = CampaniaIDActual
            };

            ViewBag.TieneCronogramaExtendido = CroAuto ? 1 : 0;
            return View(cronogramaModel);
        }

        public ActionResult CronogramaDemandaAnticipada()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Cronograma/CronogramaDemandaAnticipada"))
                return RedirectToAction("Index", "Bienvenida");

            var cronogramaModel = new CronogramaModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaZonas = new List<ZonaModel>(),
                listaPaises = DropDowListPaises()
            };
            return View(cronogramaModel);
        }

        public ActionResult ActualizacionMasiva()
        {
            return View();
        }
        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ZonaModel> lstZonas = DropDownListZonas(PaisID);

            return Json(new
            {
                lista = lst,
                listaZonas = lstZonas
            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ObtenterCampanias(int PaisID)
        {
            PaisID = UserData().PaisID;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ActualizarLog(string CampaniaCodigo, string codigos, string Tipo, string FechaFacturacion, string FechaReFacturacion)
        {
            try
            {
                List<BELogActualizacionFacturacion> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    UsuarioModel usuarioModel = sessionManager.GetUserData();

                    BEConfiguracionValidacion configuracionValidacion = sv.GetConfiguracionValidacion(UserData().PaisID, Convert.ToInt32("201301"))[0];
                    DateTime fechaFinFacturacion = Convert.ToDateTime(FechaFacturacion).AddDays(usuarioModel.DiasDuracionCronograma - 1);

                    lst = sv.UpdLogActualizacionFacturacion(UserData().PaisID, CampaniaCodigo, codigos, Convert.ToInt32(Tipo), Convert.ToDateTime(FechaFacturacion), Convert.ToDateTime(FechaReFacturacion), UserData().CodigoUsuario).ToList();
                    sv.UpdateCronogramaDD(UserData().PaisID, CampaniaCodigo, codigos, Convert.ToInt32(Tipo), Convert.ToDateTime(FechaFacturacion), fechaFinFacturacion, Convert.ToDateTime(FechaReFacturacion), UserData().CodigoUsuario);
                }
                if (lst.Count == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Ha ocurrido un error al realizar proceso",
                        extra = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        message = lst[0].Mensaje,
                        extra = ""
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ha ocurrido un error al realizar proceso",
                    extra = ""
                });
            }


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
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public ActionResult ConsultarCronograma(string sidx, string sord, int page, int rows, string CampaniaID, string TipoCronogramaID, string PaisID, string ZonaID, string Consulta)
        {
            if (ModelState.IsValid)
            {
                List<BECronograma> lst;

                if (Consulta == "1")
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lst = sv.GetCronogramaByCampania(PaisID == string.Empty ? 11 : int.Parse(PaisID), CampaniaID == "" ? 0 : int.Parse(CampaniaID), ZonaID.Equals(string.Empty) ? -1 : int.Parse(ZonaID), Int16.Parse(TipoCronogramaID)).ToList();
                    }
                }
                else
                {
                    lst = new List<BECronograma>();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                IEnumerable<BECronograma> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Zona":
                            items = lst.OrderBy(x => x.CodigoZona);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderBy(x => x.FechaInicioWeb);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderBy(x => x.FechaFinWeb);
                            break;
                        case "FechaInicioDD":
                            items = lst.OrderBy(x => x.FechaInicioDD);
                            break;
                        case "FechaFinDD":
                            items = lst.OrderBy(x => x.FechaFinDD);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Zona":
                            items = lst.OrderByDescending(x => x.CodigoZona);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderByDescending(x => x.FechaInicioWeb);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderByDescending(x => x.FechaFinWeb);
                            break;
                        case "FechaInicioDD":
                            items = lst.OrderByDescending(x => x.FechaInicioDD);
                            break;
                        case "FechaFinDD":
                            items = lst.OrderByDescending(x => x.FechaFinDD);
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
                               id = a.ZonaID,
                               cell = new string[]
                               {
                                   a.CampaniaID.ToString(),
                                   a.ZonaID.ToString(),
                                   a.CodigoZona.ToString(),
                                   Convert.ToDateTime(a.FechaInicioWeb.ToString()).ToShortDateString(),
                                   Convert.ToDateTime(a.FechaFinWeb.ToString()).ToShortDateString(),
                                   Convert.ToDateTime(a.FechaInicioDD.ToString()).ToShortDateString(),
                                   a.ZonaID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarLog(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            if (ModelState.IsValid)
            {
                List<BELogActualizacionFacturacion> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.LogActualizacionFacturacion(UserData().PaisID).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                IEnumerable<BELogActualizacionFacturacion> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoUsuario":
                            items = lst.OrderBy(x => x.CodigoUsuario);
                            break;
                        case "Fecha":
                            items = lst.OrderBy(x => x.Fecha);
                            break;
                        case "CampaniaCodigo":
                            items = lst.OrderBy(x => x.CampaniaCodigo);
                            break;
                        case "CodigosZonaRegionIncompleto":
                            items = lst.OrderBy(x => x.CodigosZonaRegionIncompleto);
                            break;
                        case "FechaFacturacion":
                            items = lst.OrderBy(x => x.FechaFacturacion);
                            break;
                        case "FechaFinFacturacion":
                            items = lst.OrderBy(x => x.FechaFinFacturacion);
                            break;
                        case "FechaRefacturacion":
                            items = lst.OrderBy(x => x.FechaRefacturacion);
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
                        case "Fecha":
                            items = lst.OrderByDescending(x => x.Fecha);
                            break;
                        case "CampaniaCodigo":
                            items = lst.OrderByDescending(x => x.CampaniaCodigo);
                            break;
                        case "CodigosZonaRegionIncompleto":
                            items = lst.OrderByDescending(x => x.CodigosZonaRegionIncompleto);
                            break;
                        case "FechaFacturacion":
                            items = lst.OrderByDescending(x => x.FechaFacturacion);
                            break;
                        case "FechaFinFacturacion":
                            items = lst.OrderByDescending(x => x.FechaFinFacturacion);
                            break;
                        case "FechaRefacturacion":
                            items = lst.OrderByDescending(x => x.FechaRefacturacion);
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
                               cell = new string[]
                               {
                                   a.CodigosZonaRegion,
                                   a.CodigoUsuario,
                                   a.Fecha,
                                   a.CampaniaCodigo,
                                   a.CodigosZonaRegionIncompleto,
                                   a.FechaFacturacion,
                                   a.FechaFinFacturacion,
                                   a.FechaRefacturacion
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index");
        }

        public ActionResult ConsultarCronogramaAnticipado(string sidx, string sord, int page, int rows, string CampaniaID, string TipoCronogramaID, string PaisID, string ZonaID)
        {
            if (ModelState.IsValid)
            {
                List<BECronograma> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.GetCronogramaByCampaniaAnticipado(PaisID == string.Empty ? 11 : int.Parse(PaisID), CampaniaID == "" ? -1 : int.Parse(CampaniaID), ZonaID.Equals(string.Empty) ? -1 : int.Parse(ZonaID), Int16.Parse(TipoCronogramaID)).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                IEnumerable<BECronograma> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "ZonaNombre":
                            items = lst.OrderBy(x => x.ZonaNombre);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderBy(x => x.FechaInicioWeb);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderBy(x => x.FechaFinWeb);
                            break;
                        case "FechaInicioDD":
                            items = lst.OrderBy(x => x.FechaInicioDD);
                            break;
                        case "FechaFinDD":
                            items = lst.OrderBy(x => x.FechaFinDD);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "ZonaNombre":
                            items = lst.OrderByDescending(x => x.ZonaNombre);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderByDescending(x => x.FechaInicioWeb);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderByDescending(x => x.FechaFinWeb);
                            break;
                        case "FechaInicioDD":
                            items = lst.OrderByDescending(x => x.FechaInicioDD);
                            break;
                        case "FechaFinDD":
                            items = lst.OrderByDescending(x => x.FechaFinDD);
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
                               id = a.ZonaID,
                               cell = new string[]
                               {
                                   a.CampaniaID.ToString(),
                                   a.CodigoZona.ToString(),
                                   Convert.ToDateTime(a.FechaInicioWeb.ToString()).ToShortDateString(),
                                   Convert.ToDateTime(a.FechaInicioDD.ToString()).ToShortDateString(),
                                   a.ZonaID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public JsonResult Insert(CronogramaModel model)
        {
            #region Validar Fechas

            string mensaje = string.Empty;

            if (model.FechaInicioWeb.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";
            if (model.FechaInicioDD.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Refacturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

            if (!mensaje.Equals(string.Empty))
            {
                return Json(new
                {
                    success = false,
                    message = mensaje,
                    extra = ""
                });
            }

            #endregion

            try
            {
                Mapper.CreateMap<CronogramaModel, BECronograma>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.TipoCronogramaID, f => f.MapFrom(c => c.TipoCronogramaID))
                    .ForMember(t => t.FechaInicioWeb, f => f.MapFrom(c => c.FechaInicioWeb))
                    .ForMember(t => t.FechaFinWeb, f => f.MapFrom(c => c.FechaFinWeb))
                    .ForMember(t => t.FechaInicioDD, f => f.MapFrom(c => c.FechaInicioDD))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.FechaFinDD, f => f.MapFrom(c => c.FechaFinDD))
                    .ForMember(t => t.CodigoZona, f => f.MapFrom(c => c.CodigoZona))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania));

                BECronograma entidad = Mapper.Map<CronogramaModel, BECronograma>(model);

                entidad.CodigoUsuarioModificacion = UserData().CodigoUsuario;

                int validar = 0;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    validar = sv.InsertCronogramaAnticipado(entidad);
                }

                if (validar == 0)
                    return Json(new
                    {
                        success = true,
                        message = "La zona se registro satisfactoriamente en el Cronograma.",
                        extra = ""
                    });
                else
                    return Json(new
                    {
                        success = false,
                        message = "La zona ingresada ya existe en el Cronograma.",
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
        public JsonResult Update(CronogramaModel model)
        {
            #region Validar Fechas

            string mensaje = string.Empty;

            if (model.FechaInicioWeb.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";
            if (model.FechaInicioDD.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Refacturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

            if (!mensaje.Equals(string.Empty))
            {
                return Json(new
                {
                    success = false,
                    message = mensaje,
                    extra = ""
                });
            }

            #endregion

            try
            {
                Mapper.CreateMap<CronogramaModel, BECronograma>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.TipoCronogramaID, f => f.MapFrom(c => c.TipoCronogramaID))
                    .ForMember(t => t.FechaInicioWeb, f => f.MapFrom(c => c.FechaInicioWeb))
                    .ForMember(t => t.FechaFinWeb, f => f.MapFrom(c => c.FechaFinWeb))
                    .ForMember(t => t.FechaInicioDD, f => f.MapFrom(c => c.FechaInicioDD))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.FechaFinDD, f => f.MapFrom(c => c.FechaFinDD))
                    .ForMember(t => t.CodigoZona, f => f.MapFrom(c => c.CodigoZona))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania));

                BECronograma entidad = Mapper.Map<CronogramaModel, BECronograma>(model);

                entidad.CodigoUsuarioModificacion = UserData().CodigoUsuario;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.UpdateCronogramaAnticipado(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Cronograma actualizado satisfactoriamente.",
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
        public JsonResult Delete(CronogramaModel model)
        {

            try
            {
                Mapper.CreateMap<CronogramaModel, BECronograma>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.TipoCronogramaID, f => f.MapFrom(c => c.TipoCronogramaID))
                    .ForMember(t => t.FechaInicioWeb, f => f.MapFrom(c => c.FechaInicioWeb))
                    .ForMember(t => t.FechaFinWeb, f => f.MapFrom(c => c.FechaFinWeb))
                    .ForMember(t => t.FechaInicioDD, f => f.MapFrom(c => c.FechaInicioDD))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.FechaFinDD, f => f.MapFrom(c => c.FechaFinDD))
                    .ForMember(t => t.CodigoZona, f => f.MapFrom(c => c.CodigoZona))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania));

                BECronograma entidad = Mapper.Map<CronogramaModel, BECronograma>(model);

                entidad.CodigoUsuarioModificacion = UserData().CodigoUsuario;


                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteCronogramaAnticipado(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "La zona fue eliminada satisfactoriamente del Cronograma.",
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
        public JsonResult MigrarAnticipado(string CampaniaID, string ZonaID)
        {
            try
            {
                int rslt = 0;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    rslt = sv.MigrarCronogramaAnticipado(UserData().PaisID, int.Parse(CampaniaID), int.Parse(ZonaID));
                }
                return Json(new
                {
                    success = true,
                    message = rslt == 0 ? "Ya existe Cronograma Anticipado para la Zona seleccionada, verifique." : "Se registro satisfactoriamente el Cronograma Anticipado",
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

        public JsonResult GetCronogramaByCampaniayZona(int PaisID, int CampaniaID, int ZonaID)
        {
            try
            {
                BECronograma entidad = new BECronograma();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    entidad = sv.GetCronogramaByCampaniayZona(PaisID, CampaniaID, ZonaID);
                    entidad.ZonaNombre = Convert.ToDateTime(entidad.FechaInicioDD.ToString()).ToShortDateString();
                    entidad.CodigoZona = Convert.ToDateTime(entidad.FechaInicioWeb.ToString()).ToShortDateString();
                }
                return Json(new
                {
                    success = true,
                    json = entidad
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false
                });
            }
        }



        [HttpPost]
        public JsonResult InsConfiguracionConsultoraDA(int tipoConfiguracion)
        {

            BEConfiguracionConsultoraDA configuracionConsultoraDA = new BEConfiguracionConsultoraDA();
            configuracionConsultoraDA.ZonaID = UserData().ZonaID;
            configuracionConsultoraDA.ConsultoraID = Convert.ToInt32(UserData().ConsultoraID);
            configuracionConsultoraDA.TipoConfiguracion = Convert.ToByte(tipoConfiguracion);
            configuracionConsultoraDA.CampaniaID = Convert.ToString(UserData().CampaniaID);
            configuracionConsultoraDA.CodigoUsuario = Convert.ToString(UserData().CodigoUsuario);

            int validar = 0;
            using (SACServiceClient sv = new SACServiceClient())
            {

                validar = sv.InsConfiguracionConsultoraDA(UserData().PaisID, configuracionConsultoraDA);

            }

            int paisID = UserData().PaisID;
            string codigoUsuario = UserData().CodigoUsuario;

            return Json(new
            {
                success = validar != 0,
                paisID = paisID,
                codigoUsuario = codigoUsuario
            });

        }


        [HttpPost]
        public JsonResult ValidacionConsultoraDA()
        {

            bool validar = false;
            string mensajeFechaDA = null;
            if (UserData().EsquemaDAConsultora)
            {
                if (UserData().EsZonaDemAnti == 1)
                {

                    int consultoraDA = 0;
                    using (SACServiceClient sv = new SACServiceClient())
                    {

                        BEConfiguracionConsultoraDA configuracionConsultoraDA = new BEConfiguracionConsultoraDA();
                        configuracionConsultoraDA.CampaniaID = Convert.ToString(UserData().CampaniaID);
                        configuracionConsultoraDA.ConsultoraID = Convert.ToInt32(UserData().ConsultoraID);
                        configuracionConsultoraDA.ZonaID = UserData().ZonaID;

                        consultoraDA = sv.GetConfiguracionConsultoraDA(UserData().PaisID, configuracionConsultoraDA);

                        if (consultoraDA == 0)
                        {
                            BECronograma cronograma;
                            cronograma = sv.GetCronogramaByCampaniaAnticipado(UserData().PaisID, UserData().CampaniaID, UserData().ZonaID, 2).FirstOrDefault();
                            DateTime fechaDA = (DateTime)cronograma.FechaInicioWeb;

                            TimeSpan sp = UserData().HoraCierreZonaDemAntiCierre;
                            var cierrezonademanti = new DateTime(sp.Ticks).ToString("HH:mm") + " hrs";
                            var diasemana = "";
                            var dia = fechaDA.DayOfWeek.ToString();

                            switch (dia)
                            {
                                case "Monday":
                                    diasemana = "Lunes";
                                    break;
                                case "Tuesday":
                                    diasemana = "Martes";
                                    break;
                                case "Wednesday":
                                    diasemana = "Miércoles";
                                    break;
                                case "Thursday":
                                    diasemana = "Jueves";
                                    break;
                                case "Friday":
                                    diasemana = "Viernes";
                                    break;
                                case "Saturday":
                                    diasemana = "Sábado";
                                    break;
                                case "Sunday":
                                    diasemana = "Domingo";
                                    break;
                            }

                            mensajeFechaDA = diasemana.ToString() + " " + fechaDA.Day.ToString() + " de " + NombreMes(fechaDA.Month) + " (" + cierrezonademanti + ")";

                            validar = true;
                        }

                    }
                }
            }


            return Json(new
            {
                success = validar,
                mensajeFechaDA = mensajeFechaDA
            });

        }

        [HttpPost]
        public JsonResult GetCronogramaDA(DateTime fechaFacturacion)
        {

            BEConfiguracionConsultoraDA configuracionConsultoraDA = new BEConfiguracionConsultoraDA();
            configuracionConsultoraDA.ConsultoraID = Convert.ToInt32(UserData().ConsultoraID);

            int validar = 0;
            using (SACServiceClient sv = new SACServiceClient())
            {
                validar = sv.GetCronogramaDA(UserData().PaisID, fechaFacturacion);
            }

            return Json(new
            {
                success = validar == 1
            });

        }

        #endregion
    }
}
