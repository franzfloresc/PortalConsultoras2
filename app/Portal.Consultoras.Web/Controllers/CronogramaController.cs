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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            int paisId = userData.PaisID;

            bool croAuto;
            int campaniaIdActual;
            using (SACServiceClient sv = new SACServiceClient())
            {
                croAuto = sv.GetCronogramaAutomaticoActivacion(paisId);
                campaniaIdActual = sv.GetCampaniaFacturacionPais(paisId);
            }

            var cronogramaModel = new CronogramaModel()
            {
                listaPaises = DropDowListPaises(),
                listaCampania = DropDowListCampanias(paisId),
                listaZonas = _baseProvider.DropDownListZonas(paisId),
                PaisID = paisId,
                CampaniaID = campaniaIdActual
            };

            ViewBag.TieneCronogramaExtendido = croAuto ? 1 : 0;
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
            IEnumerable<ZonaModel> lstZonas = _baseProvider.DropDownListZonas(PaisID);

            return Json(new
            {
                lista = lst,
                listaZonas = lstZonas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            PaisID = userData.PaisID;
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

                    DateTime fechaFinFacturacion = Convert.ToDateTime(FechaFacturacion).AddDays(usuarioModel.DiasDuracionCronograma - 1);

                    lst = sv.UpdLogActualizacionFacturacion(userData.PaisID, CampaniaCodigo, codigos, Convert.ToInt32(Tipo), Convert.ToDateTime(FechaFacturacion), Convert.ToDateTime(FechaReFacturacion), userData.CodigoUsuario).ToList();
                    sv.UpdateCronogramaDD(userData.PaisID, CampaniaCodigo, codigos, Convert.ToInt32(Tipo), Convert.ToDateTime(FechaFacturacion), fechaFinFacturacion, Convert.ToDateTime(FechaReFacturacion), userData.CodigoUsuario);
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

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

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
                        lst = sv.GetCronogramaByCampania(
                            PaisID == string.Empty ? 11 : int.Parse(PaisID),
                            CampaniaID == "" ? 0 : int.Parse(CampaniaID),
                            string.IsNullOrEmpty(ZonaID) ? -1 : int.Parse(ZonaID),
                            Int16.Parse(TipoCronogramaID)).ToList();
                    }
                }
                else
                {
                    lst = new List<BECronograma>();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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
                                   a.CodigoZona,
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
                    lst = sv.LogActualizacionFacturacion(userData.PaisID).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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
                    lst = sv.GetCronogramaByCampaniaAnticipado(
                        PaisID == string.Empty ? 11 : int.Parse(PaisID),
                        CampaniaID == "" ? -1 : int.Parse(CampaniaID),
                        string.IsNullOrEmpty(ZonaID) ? -1 : int.Parse(ZonaID),
                        Int16.Parse(TipoCronogramaID)).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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
                                   a.CodigoZona,
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

            string mensaje = "";

            if (model.FechaInicioWeb.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";
            if (model.FechaInicioDD.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Refacturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

            if (mensaje != "")
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
                BECronograma entidad = Mapper.Map<CronogramaModel, BECronograma>(model);

                entidad.CodigoUsuarioModificacion = userData.CodigoUsuario;

                int validar;
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
        public JsonResult Update(CronogramaModel model)
        {
            #region Validar Fechas

            string mensaje = "";

            if (model.FechaInicioWeb.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";
            if (model.FechaInicioDD.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Refacturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

            if (mensaje != "")
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
                BECronograma entidad = Mapper.Map<CronogramaModel, BECronograma>(model);

                entidad.CodigoUsuarioModificacion = userData.CodigoUsuario;

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
        public JsonResult Delete(CronogramaModel model)
        {

            try
            {
                BECronograma entidad = Mapper.Map<CronogramaModel, BECronograma>(model);

                entidad.CodigoUsuarioModificacion = userData.CodigoUsuario;


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
        public JsonResult MigrarAnticipado(string CampaniaID, string ZonaID)
        {
            try
            {
                int rslt;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    rslt = sv.MigrarCronogramaAnticipado(userData.PaisID, int.Parse(CampaniaID), int.Parse(ZonaID));
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

        public JsonResult GetCronogramaByCampaniayZona(int PaisID, int CampaniaID, int ZonaID)
        {
            try
            {
                BECronograma entidad;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    entidad = sv.GetCronogramaByCampaniayZona(PaisID, CampaniaID, ZonaID);
                }
                entidad.ZonaNombre = Convert.ToDateTime(entidad.FechaInicioDD.ToString()).ToShortDateString();
                entidad.CodigoZona = Convert.ToDateTime(entidad.FechaInicioWeb.ToString()).ToShortDateString();
                return Json(new
                {
                    success = true,
                    json = entidad
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                });
            }
        }

        [HttpPost]
        public JsonResult InsConfiguracionConsultoraDA(int tipoConfiguracion)
        {

            BEConfiguracionConsultoraDA configuracionConsultoraDa =
                new BEConfiguracionConsultoraDA
                {
                    ZonaID = userData.ZonaID,
                    ConsultoraID = Convert.ToInt32(userData.ConsultoraID),
                    TipoConfiguracion = Convert.ToByte(tipoConfiguracion),
                    CampaniaID = Convert.ToString(userData.CampaniaID),
                    CodigoUsuario = Convert.ToString(userData.CodigoUsuario)
                };

            int validar;
            using (SACServiceClient sv = new SACServiceClient())
            {
                validar = sv.InsConfiguracionConsultoraDA(userData.PaisID, configuracionConsultoraDa);
            }

            int paisId = userData.PaisID;
            string codigoUsuario = userData.CodigoUsuario;

            return Json(new
            {
                success = validar != 0,
                paisID = paisId,
                codigoUsuario = codigoUsuario
            });

        }

        [HttpPost]
        public JsonResult ValidacionConsultoraDA()
        {

            bool validar = false;
            string mensajeFechaDa = null;
            if (userData.EsquemaDAConsultora && userData.EsZonaDemAnti == 1)
                using (SACServiceClient sv = new SACServiceClient())
                {
                    var configuracionConsultoraDa = new BEConfiguracionConsultoraDA
                    {
                        CampaniaID = Convert.ToString(userData.CampaniaID),
                        ConsultoraID = Convert.ToInt32(userData.ConsultoraID),
                        ZonaID = userData.ZonaID
                    };

                    var consultoraDa = sv.GetConfiguracionConsultoraDA(userData.PaisID, configuracionConsultoraDa);

                    if (consultoraDa == 0)
                    {
                        var cronograma =
                            sv.GetCronogramaByCampaniaAnticipado(userData.PaisID, userData.CampaniaID,
                                userData.ZonaID, 2).FirstOrDefault();
                        if (cronograma != null && cronograma.FechaInicioWeb != null)
                        {
                            DateTime fechaDa = (DateTime)cronograma.FechaInicioWeb;

                            TimeSpan sp = userData.HoraCierreZonaDemAntiCierre;
                            var cierrezonademanti = new DateTime(sp.Ticks).ToString("HH:mm") + " hrs";
                            var diasemana = "";
                            var dia = fechaDa.DayOfWeek.ToString();

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

                            mensajeFechaDa = diasemana + " " + fechaDa.Day.ToString() + " de " +
                                             Util.NombreMes(fechaDa.Month) + " (" + cierrezonademanti + ")";
                        }

                        validar = true;
                    }
                }


            return Json(new
            {
                success = validar,
                mensajeFechaDA = mensajeFechaDa
            });

        }

        [HttpPost]
        public JsonResult GetCronogramaDA(DateTime fechaFacturacion)
        {
            int validar;
            using (SACServiceClient sv = new SACServiceClient())
            {
                validar = sv.GetCronogramaDA(userData.PaisID, fechaFacturacion);
            }

            return Json(new
            {
                success = validar == 1
            });

        }

        #endregion
    }
}
