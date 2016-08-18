using AutoMapper;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class SolicitudCreditoController : BaseController
    {
        public ActionResult SolicitudCredito()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "SolicitudCredito/SolicitudCredito"))
                return RedirectToAction("Index", "Bienvenida");
            var model = new SolicitudCreditoModel();
            try
            {
                IEnumerable<ZonaModel> lstZona = new List<ZonaModel>();
                model.ListaPaises = CargarDropDowListPaises();
                model.ListaZonas = lstZona;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
        }

        public ActionResult ReporteActualizacionDatos() {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "SolicitudCredito/ReporteActualizacionDatos"))
                return RedirectToAction("Index", "Bienvenida");
            var model = new SolicitudCreditoModel();
            try
            {
                IEnumerable<ZonaModel> lstZona = new List<ZonaModel>();
                model.ListaPaises = CargarDropDowListPaises();
                model.ListaZonas = lstZona;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
        
        }

        public IEnumerable<ZonaModel> DropDownZonas(int PaisID)
        {
            IList<BEZona> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectAllZonas(PaisID);
            }

            Mapper.CreateMap<BEZona, ZonaModel>()
               .ForMember(x => x.ZonaID, t => t.MapFrom(c => c.ZonaID))
               .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo))
               .ForMember(x => x.Nombre, t => t.MapFrom(c => c.Nombre))
               .ForMember(x => x.RegionID, t => t.MapFrom(c => c.RegionID));

            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lista);
        }

        private IEnumerable<PaisModel> CargarDropDowListPaises()
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

        public JsonResult ObtenterDropDownPorPais(int PaisID)
        {
            IEnumerable<ZonaModel> lstzona = DropDownZonas(PaisID);

            return Json(new
            {
                lstZona = lstzona
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ExportarPDFSolicitud(string vPaisddl, string vFechaSolicitud, string vZonaddl, string vSeccion, string vDocumento,
              string vEstadoddl, string vpage, string vsortname, string vsortorder, string vrowNum, string vZonaVal, string vPaisVal, string vTipoSolicitud)
        {
            string[] lista = new string[15];
            lista[0] = vPaisddl;
            lista[1] = vFechaSolicitud;
            lista[2] = vZonaddl;
            lista[3] = vSeccion;
            lista[4] = vDocumento;
            lista[5] = vEstadoddl;
            lista[6] = vpage;
            lista[7] = vsortname;
            lista[8] = vsortorder;
            lista[9] = vrowNum;
            lista[10] = UserData().BanderaImagen;
            lista[11] = UserData().NombrePais;
            lista[12] = vZonaVal;
            lista[13] = vPaisVal;
            lista[14] = vTipoSolicitud;
            Util.ExportToPdfWebPages(this, "ListadoSolicitudCredito.pdf", "SolicitudCreditoImp", Util.EncriptarQueryString(lista));
            return View();
        }

        public ActionResult ExportarPDFSolicitud_ReporteActualizacionDatos(string vPaisddl, string vFechaSolicitud, string vZonaddl, string vSeccion, string vDocumento,
              string vEstadoddl, string vpage, string vsortname, string vsortorder, string vrowNum, string vZonaVal, string vPaisVal, string vTipoSolicitud)
        {
            string[] lista = new string[15];
            lista[0] = vPaisddl;
            lista[1] = vFechaSolicitud;
            lista[2] = vZonaddl;
            lista[3] = vSeccion;
            lista[4] = vDocumento;
            lista[5] = vEstadoddl;
            lista[6] = vpage;
            lista[7] = vsortname;
            lista[8] = vsortorder;
            lista[9] = vrowNum;
            lista[10] = UserData().BanderaImagen;
            lista[11] = UserData().NombrePais;
            lista[12] = vZonaVal;
            lista[13] = vPaisVal;
            lista[14] = vTipoSolicitud;
            Util.ExportToPdfWebPages(this, "ListadoActualizacionDatos.pdf", "ReporteActualizacionDatos", Util.EncriptarQueryString(lista));
            return View();
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, string vFecha,
                                     string vZonaID, string vSeccionID, string vDocumento, int vEstadoPedido, string vTipoSolicitud)
        {
            if (ModelState.IsValid)
            {
                List<BESolicitudCredito> lst;
                using (SACServiceClient srv = new SACServiceClient())
                {
                    Nullable<DateTime> fecha = null;
                    if (!string.IsNullOrEmpty(vFecha))
                        fecha = Convert.ToDateTime(vFecha);

                    if (vTipoSolicitud == "INS")
                    {
                        BESolicitudCredito solicitud = new BESolicitudCredito()
                        {
                            PaisID = paisID,
                            FechaCreacion = fecha,
                            CodigoZona = vZonaID.Equals("-1") ? "" : vZonaID,
                            CodigoTerritorio = vSeccionID,
                            NumeroDocumento = vDocumento,
                            CodigoLote = vEstadoPedido,
                            TipoSolicitud = vTipoSolicitud,
                            CodigoConsultora = null
                        };
                        lst = srv.GetSolicitudCreditos(solicitud).ToList();
                    }
                    else
                    {
                        BESolicitudCredito solicitud = new BESolicitudCredito()
                        {
                            PaisID = paisID,
                            FechaCreacion = fecha,
                            CodigoZona = vZonaID.Equals("-1") ? "" : vZonaID,
                            CodigoTerritorio = vSeccionID,
                            NumeroDocumento = null,
                            CodigoLote = vEstadoPedido,
                            TipoSolicitud = vTipoSolicitud,
                            CodigoConsultora = vDocumento
                        };
                        lst = srv.GetSolicitudCreditos(solicitud).ToList();
                    }
                                     
                }
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;

                BEPager pag = new BEPager();
                IEnumerable<BESolicitudCredito> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoZona":
                            items = lst.OrderBy(x => x.CodigoZona);
                            break;
                        case "SolicitudCreditoID":
                            items = lst.OrderBy(x => x.SolicitudCreditoID);
                            break;
                        case "CodigoConsultoraRecomienda":
                            items = lst.OrderBy(x => x.CodigoConsultoraRecomienda);
                            break;
                        case "Nombres":
                            items = lst.OrderBy(x => x.NombreConsultoraRecomienda);
                            break;
                        case "NumeroDocumento":
                            items = lst.OrderBy(x => x.NumeroDocumento);
                            break;
                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoConsultora);
                            break;
                        case "TipoSolicitud":
                            items = lst.OrderBy(x => x.TipoSolicitud);
                            break;
                        case "FechaSolicitud":
                            items = lst.OrderBy(x => x.FechaCreacion);
                            break;
                        case "Estado":
                            items = lst.OrderBy(x => x.CodigoLote);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoZona":
                            items = lst.OrderByDescending(x => x.CodigoZona);
                            break;
                        case "SolicitudCreditoID":
                            items = lst.OrderByDescending(x => x.SolicitudCreditoID);
                            break;
                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoConsultoraRecomienda);
                            break;
                        case "Nombres":
                            items = lst.OrderByDescending(x => x.NombreConsultoraRecomienda);
                            break;
                        case "NumeroDocumento":
                            items = lst.OrderByDescending(x => x.NumeroDocumento);
                            break;
                        case "TipoSolicitud":
                            items = lst.OrderByDescending(x => x.TipoSolicitud);
                            break;
                        case "FechaSolicitud":
                            items = lst.OrderByDescending(x => x.FechaCreacion);
                            break;
                        case "Estado":
                            items = lst.OrderByDescending(x => x.CodigoLote);
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
                    totalregistros = lst.Count,
                    rows = from a in items
                           select new
                           {
                               id = a.SolicitudCreditoID,
                               cell = new string[]
                                                                    {
                                                                        a.SolicitudCreditoID.ToString(),
                                                                        UserData().CodigoISO,
                                                                        a.CodigoZona,
                                                                        a.SolicitudCreditoID.ToString(),
                                                                        a.CodigoConsultoraRecomienda,
                                                                        a.NombreConsultoraRecomienda,
                                                                        (a.NumeroDocumento == null) ? "" :(UserData().CodigoISO == Constantes.CodigosISOPais.PuertoRico) ? a.NumeroDocumento = string.Format("*****{0}",a.NumeroDocumento.Remove(0,5)) : a.NumeroDocumento ,                                                                       
                                                                        a.CodigoConsultora,
                                                                        (a.FechaCreacion == null
                                                                             ? ""
                                                                             : Convert.ToDateTime(a.FechaCreacion).
                                                                                   ToString("dd/MM/yyyy hh:mm tt")),
                                                                        a.CodigoLote > 0 ? "ENVIADO" : "PENDIENTE",
                                                                         a.TipoSolicitud
                                                                    }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Consultar");
        }

        public ActionResult ExportarExcel(int vPaisID, string vFecha, string vZonaID, string vSeccionID, string vDocumento, int vEstadoPedido, string vTipoSolicitud)
        {
            IList<BESolicitudCredito> listaSolicitudes;
            try
            {
                using (SACServiceClient srv = new SACServiceClient())
                {
                    Nullable<DateTime> fecha = null;
                    if (!string.IsNullOrEmpty(vFecha))
                        fecha = Convert.ToDateTime(vFecha);

                    if (vTipoSolicitud == "INS")
                    {
                        listaSolicitudes = new List<BESolicitudCredito>();
                        BESolicitudCredito solicitud = new BESolicitudCredito()
                        {
                            PaisID = vPaisID,
                            FechaCreacion = fecha,
                            CodigoZona = vZonaID.Equals("-1") ? "" : vZonaID,
                            CodigoTerritorio = vSeccionID,
                            NumeroDocumento = vDocumento,
                            CodigoLote = vEstadoPedido,
                            TipoSolicitud = vTipoSolicitud,
                            CodigoConsultora = null
                        };

                        listaSolicitudes = srv.GetSolicitudCreditos(solicitud);
                    }
                    else
                    {
                        listaSolicitudes = new List<BESolicitudCredito>();
                        BESolicitudCredito solicitud = new BESolicitudCredito()
                        {
                            PaisID = vPaisID,
                            FechaCreacion = fecha,
                            CodigoZona = vZonaID.Equals("-1") ? "" : vZonaID,
                            CodigoTerritorio = vSeccionID,
                            NumeroDocumento = null,
                            CodigoLote = vEstadoPedido,
                            TipoSolicitud = vTipoSolicitud,
                            CodigoConsultora = vDocumento
                        };

                        listaSolicitudes = srv.GetSolicitudCreditos(solicitud);                        
                    }                                          
                }
            }
            catch (Exception)
            {
                listaSolicitudes = new List<BESolicitudCredito>();
            }

            Mapper.CreateMap<BESolicitudCredito, SolicitudCreditoModel>()
          .ForMember(x => x.SolicitudCreditoID, t => t.MapFrom(c => c.SolicitudCreditoID))
          .ForMember(x => x.CodigoZona, t => t.MapFrom(c => c.CodigoZona))
          .ForMember(x => x.CodigoConsultoraRecomienda, t => t.MapFrom(c => c.CodigoConsultoraRecomienda))
          .ForMember(x => x.NombreConsultoraRecomienda, t => t.MapFrom(c => c.NombreConsultoraRecomienda))
          .ForMember(x => x.NumeroDocumento, t => t.MapFrom(c => c.NumeroDocumento))
          .ForMember(x => x.CodigoConsultora, t => t.MapFrom(c => c.CodigoConsultora))
          .ForMember(x => x.FechaCreacion, t => t.MapFrom(c => c.FechaCreacion))
          .ForMember(x => x.CodigoLote, t => t.MapFrom(c => c.CodigoLote))
          .ForMember(x => x.TipoSolicitud, t => t.MapFrom(c => c.TipoSolicitud));

            var list = Mapper.Map<IList<BESolicitudCredito>, IList<SolicitudCreditoModel>>(listaSolicitudes);

            if (UserData().CodigoISO == Consultoras.Common.Constantes.CodigosISOPais.PuertoRico)
            {
                list.ToList().ForEach(x =>
                {
                    x.NumeroDocumento = x.NumeroDocumento.Length > 4 ? string.Format("*****{0}", x.NumeroDocumento.Remove(0, 5)) : string.Empty;
                });
            }
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Zona", "CodigoZona");
            dic.Add("ID Interno", "SolicitudCreditoID");
            dic.Add("Cod. Consultora que Refiere", "CodigoConsultoraRecomienda");
            dic.Add("Nombre", "NombreConsultoraRecomienda");
            dic.Add("Doc. Identidad", "NumeroDocumento");
            dic.Add("Cod. Consultora", "CodigoConsultora");
            dic.Add("Fecha", "FechaCreacion");
            dic.Add("Estado", "EstadoDescripcion");
            dic.Add("Tipo", "TipoSolicitud");
            Util.ExportToExcel("SolicitudesExcel", list.ToList(), dic);
            return View();


        }

        public ActionResult DetalleCreditoVE()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("SolicitudCredito", "SolicitudCredito");
            JObject obj = JObject.Parse(Request.Form["data"]);

            BESolicitudCredito beSolicitud = new BESolicitudCredito();
            SolicitudCreditoModel model = new SolicitudCreditoModel();

            int solicitudCreditoID = Convert.ToInt32(obj["SolicitudID"].ToString());

            using (SACServiceClient srv = new SACServiceClient())
            {
                beSolicitud = srv.BuscarSolicitudCreditoPorID(UserData().PaisID, solicitudCreditoID);
            }

            MapeoEntidadModelo(ref model, beSolicitud);

            BEUbigeo beUbigeo = new BEUbigeo();
            using (ODSServiceClient ods = new ODSServiceClient())
            {
                beUbigeo = ods.GetUbigeoPorCodigoUbigeo(UserData().PaisID, model.CodigoUbigeo ?? "");
            }

            model.UnidadGeografica1 = beUbigeo.UnidadGeografica1 != null ? beUbigeo.UnidadGeografica1.Trim() : "";
            model.UnidadGeografica2 = beUbigeo.UnidadGeografica2 != null ? beUbigeo.UnidadGeografica2.Trim() : "";
            model.UnidadGeografica3 = beUbigeo.UnidadGeografica3 != null ? beUbigeo.UnidadGeografica3.Trim() : "";

            model.EsInsercion = false;

            model.DiaNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Day.ToString().PadLeft(2, '0');
            model.MesNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Month.ToString().PadLeft(2, '0');
            model.AnioNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Year.ToString();

            string direccion = model.Direccion ?? "";
            direccion = direccion.PadRight(140, ' ');
            model.AvenidaCalleCodigo = direccion.Substring(0, 2).Trim();
            model.AvenidaCalle = direccion.Substring(3, 33);
            model.CasaEdificioCodigo = direccion.Substring(37, 3).Trim();
            model.CasaEdificio = direccion.Substring(41, 20);
            model.UrbanizacionSectorCodigo = direccion.Substring(62, 4).Trim();
            model.UrbanizacionSector = direccion.Substring(66, 30);
            model.ApartamentoCasaCodigo = direccion.Substring(97, 4).Trim();
            model.ApartamentoCasa = direccion.Substring(102, 10);
            model.CiudadSolicitante = direccion.Substring(113, 25);

            string direccionEntrega = model.DireccionEntrega ?? "";
            direccionEntrega = direccionEntrega.PadRight(140, ' ');
            model.AvenidaCalleEntregaCodigo = direccionEntrega.Substring(0, 2).Trim();
            model.AvenidaCalleEntrega = direccionEntrega.Substring(3, 33);
            model.CasaEdificioEntregaCodigo = direccionEntrega.Substring(37, 3).Trim();
            model.CasaEdificioEntrega = direccionEntrega.Substring(41, 20);
            model.UrbanizacionSectorEntregaCodigo = direccionEntrega.Substring(62, 4).Trim();
            model.UrbanizacionSectorEntrega = direccionEntrega.Substring(66, 30);
            model.ApartamentoCasaEntregaCodigo = direccionEntrega.Substring(97, 4).Trim();
            model.ApartamentoCasaEntrega = direccionEntrega.Substring(102, 10);
            model.CiudadEntrega = direccionEntrega.Substring(113, 25);

            CargarValoresModelo(ref model);

            using (ODSServiceClient ods = new ODSServiceClient())
            {
                model.ListaTipoMeta = ods.GetTipoMeta(UserData().PaisID).ToList();
            }

            return View(model);
        }

        public ActionResult DetalleCreditoPR()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("SolicitudCredito", "SolicitudCredito");
            JObject obj = JObject.Parse(Request.Form["data"]);

            BESolicitudCredito beSolicitud = new BESolicitudCredito();
            SolicitudCreditoModel model = new SolicitudCreditoModel();

            int solicitudCreditoID = Convert.ToInt32(obj["SolicitudID"].ToString());

            using (SACServiceClient srv = new SACServiceClient())
            {
                beSolicitud = srv.BuscarSolicitudCreditoPorID(UserData().PaisID, solicitudCreditoID);
            }

            MapeoEntidadModelo(ref model, beSolicitud);

            BEUbigeo beUbigeo = new BEUbigeo();
            using (ODSServiceClient ods = new ODSServiceClient())
            {
                beUbigeo = ods.GetUbigeoPorCodigoUbigeo(UserData().PaisID, model.CodigoUbigeo ?? "");
            }

            model.UnidadGeografica1 = beUbigeo.UnidadGeografica1 != null ? beUbigeo.UnidadGeografica1.Trim() : "";
            model.UnidadGeografica2 = beUbigeo.UnidadGeografica2 != null ? beUbigeo.UnidadGeografica2.Trim() : "";
            model.UnidadGeografica3 = beUbigeo.UnidadGeografica3 != null ? beUbigeo.UnidadGeografica3.Trim() : "";

            model.EsInsercion = false;

            model.DiaNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Day.ToString().PadLeft(2, '0');
            model.MesNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Month.ToString().PadLeft(2, '0');
            model.AnioNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Year.ToString();

            CargarValoresModelo(ref model);

            return View(model);
        }

        public ActionResult DetalleCreditoDO()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("SolicitudCredito", "SolicitudCredito");
            JObject obj = JObject.Parse(Request.Form["data"]);

            BESolicitudCredito beSolicitud = new BESolicitudCredito();
            SolicitudCreditoModel model = new SolicitudCreditoModel();

            int solicitudCreditoID = Convert.ToInt32(obj["SolicitudID"].ToString());

            using (SACServiceClient srv = new SACServiceClient())
            {
                beSolicitud = srv.BuscarSolicitudCreditoPorID(UserData().PaisID, solicitudCreditoID);
            }

            MapeoEntidadModelo(ref model, beSolicitud);

            BEUbigeo beUbigeo = new BEUbigeo();
            using (ODSServiceClient ods = new ODSServiceClient())
            {
                beUbigeo = ods.GetUbigeoPorCodigoUbigeo(UserData().PaisID, model.CodigoUbigeo ?? "");
            }

            model.UnidadGeografica1 = beUbigeo.UnidadGeografica1 != null ? beUbigeo.UnidadGeografica1.Trim() : "";
            model.UnidadGeografica2 = beUbigeo.UnidadGeografica2 != null ? beUbigeo.UnidadGeografica2.Trim() : "";
            model.UnidadGeografica3 = beUbigeo.UnidadGeografica3 != null ? beUbigeo.UnidadGeografica3.Trim() : "";

            model.EsInsercion = false;

            model.DiaNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Day.ToString().PadLeft(2, '0');
            model.MesNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Month.ToString().PadLeft(2, '0');
            model.AnioNacimiento = model.FechaNacimiento == null ? "" : model.FechaNacimiento.Value.Year.ToString();

            CargarValoresModelo(ref model);

            return View(model);
        }

        private void MapeoEntidadModelo(ref SolicitudCreditoModel model, BESolicitudCredito beSolicitudCredito)
        {
            #region Mapeo

            Mapper.CreateMap<BESolicitudCredito, SolicitudCreditoModel>()
                .ForMember(x => x.SolicitudCreditoID, t => t.MapFrom(c => c.SolicitudCreditoID))
                .ForMember(x => x.PaisID, t => t.MapFrom(c => c.PaisID))
                .ForMember(x => x.TipoSolicitud, t => t.MapFrom(c => c.TipoSolicitud ?? ""))
                .ForMember(x => x.CodigoUbigeo, t => t.MapFrom(c => c.CodigoUbigeo ?? ""))
                .ForMember(x => x.IndicadorActivo, t => t.MapFrom(c => c.IndicadorActivo))
                .ForMember(x => x.UsuarioCreacion, t => t.MapFrom(c => c.UsuarioCreacion ?? ""))
                .ForMember(x => x.FechaCreacion, t => t.MapFrom(c => c.FechaCreacion))
                .ForMember(x => x.CodigoLote, t => t.MapFrom(c => c.CodigoLote))
                .ForMember(x => x.FuenteIngreso, t => t.MapFrom(c => c.FuenteIngreso ?? ""))
                .ForMember(x => x.NumeroPreimpreso, t => t.MapFrom(c => c.NumeroPreimpreso ?? ""))
                .ForMember(x => x.CodigoZona, t => t.MapFrom(c => c.CodigoZona ?? ""))
                .ForMember(x => x.CodigoTerritorio, t => t.MapFrom(c => c.CodigoTerritorio ?? ""))
                .ForMember(x => x.TipoContacto, t => t.MapFrom(c => c.TipoContacto))
                .ForMember(x => x.CampaniaID, t => t.MapFrom(c => c.CampaniaID))
                .ForMember(x => x.CodigoConsultoraRecomienda, t => t.MapFrom(c => c.CodigoConsultoraRecomienda ?? ""))
                .ForMember(x => x.NombreConsultoraRecomienda, t => t.MapFrom(c => c.NombreConsultoraRecomienda ?? ""))
                .ForMember(x => x.CodigoConsultora, t => t.MapFrom(c => c.CodigoConsultora ?? ""))
                .ForMember(x => x.CodigoPremio, t => t.MapFrom(c => c.CodigoPremio ?? ""))
                .ForMember(x => x.ApellidoPaterno, t => t.MapFrom(c => c.ApellidoPaterno ?? ""))
                .ForMember(x => x.ApellidoMaterno, t => t.MapFrom(c => c.ApellidoMaterno ?? ""))
                .ForMember(x => x.PrimerNombre, t => t.MapFrom(c => c.PrimerNombre ?? ""))
                .ForMember(x => x.SegundoNombre, t => t.MapFrom(c => c.SegundoNombre ?? ""))
                .ForMember(x => x.TipoDocumento, t => t.MapFrom(c => c.TipoDocumento ?? ""))
                .ForMember(x => x.NumeroDocumento, t => t.MapFrom(c => c.NumeroDocumento ?? ""))
                .ForMember(x => x.Sexo, t => t.MapFrom(c => c.Sexo ?? ""))
                .ForMember(x => x.FechaNacimiento, t => t.MapFrom(c => c.FechaNacimiento))
                .ForMember(x => x.EstadoCivil, t => t.MapFrom(c => c.EstadoCivil ?? ""))
                .ForMember(x => x.NivelEducativo, t => t.MapFrom(c => c.NivelEducativo ?? ""))
                .ForMember(x => x.CodigoOtrasMarcas, t => t.MapFrom(c => c.CodigoOtrasMarcas))
                .ForMember(x => x.TipoNacionalidad, t => t.MapFrom(c => c.TipoNacionalidad ?? ""))
                .ForMember(x => x.Telefono, t => t.MapFrom(c => c.Telefono ?? ""))
                .ForMember(x => x.Celular, t => t.MapFrom(c => c.Celular ?? ""))
                .ForMember(x => x.CorreoElectronico, t => t.MapFrom(c => c.CorreoElectronico ?? ""))
                .ForMember(x => x.Direccion, t => t.MapFrom(c => c.Direccion ?? ""))
                .ForMember(x => x.Referencia, t => t.MapFrom(c => c.Referencia ?? ""))
                .ForMember(x => x.Ciudad, t => t.MapFrom(c => c.Ciudad ?? ""))
                .ForMember(x => x.TipoVia, t => t.MapFrom(c => c.TipoVia ?? ""))
                .ForMember(x => x.PoblacionVilla, t => t.MapFrom(c => c.PoblacionVilla ?? ""))
                .ForMember(x => x.CodigoPostal, t => t.MapFrom(c => c.CodigoPostal ?? ""))
                .ForMember(x => x.DireccionEntrega, t => t.MapFrom(c => c.DireccionEntrega ?? ""))
                .ForMember(x => x.ReferenciaEntrega, t => t.MapFrom(c => c.ReferenciaEntrega ?? ""))
                .ForMember(x => x.TelefonoEntrega, t => t.MapFrom(c => c.TelefonoEntrega ?? ""))
                .ForMember(x => x.CelularEntrega, t => t.MapFrom(c => c.CelularEntrega ?? ""))
                .ForMember(x => x.ObservacionEntrega, t => t.MapFrom(c => c.ObservacionEntrega ?? ""))
                .ForMember(x => x.ApellidoFamiliar, t => t.MapFrom(c => c.ApellidoFamiliar ?? ""))
                .ForMember(x => x.NombreFamiliar, t => t.MapFrom(c => c.NombreFamiliar ?? ""))
                .ForMember(x => x.DireccionFamiliar, t => t.MapFrom(c => c.DireccionFamiliar ?? ""))
                .ForMember(x => x.TelefonoFamiliar, t => t.MapFrom(c => c.TelefonoFamiliar ?? ""))
                .ForMember(x => x.CelularFamiliar, t => t.MapFrom(c => c.CelularFamiliar ?? ""))
                .ForMember(x => x.TipoVinculoFamiliar, t => t.MapFrom(c => c.TipoVinculoFamiliar))
                .ForMember(x => x.ApellidoNoFamiliar, t => t.MapFrom(c => c.ApellidoNoFamiliar ?? ""))
                .ForMember(x => x.NombreNoFamiliar, t => t.MapFrom(c => c.NombreNoFamiliar ?? ""))
                .ForMember(x => x.DireccionNoFamiliar, t => t.MapFrom(c => c.DireccionNoFamiliar ?? ""))
                .ForMember(x => x.TelefonoNoFamiliar, t => t.MapFrom(c => c.TelefonoNoFamiliar ?? ""))
                .ForMember(x => x.CelularNoFamiliar, t => t.MapFrom(c => c.CelularNoFamiliar ?? ""))
                .ForMember(x => x.TipoVinculoNoFamiliar, t => t.MapFrom(c => c.TipoVinculoNoFamiliar))
                .ForMember(x => x.ApellidoPaternoAval, t => t.MapFrom(c => c.ApellidoPaternoAval ?? ""))
                .ForMember(x => x.ApellidoMaternoAval, t => t.MapFrom(c => c.ApellidoMaternoAval ?? ""))
                .ForMember(x => x.PrimerNombreAval, t => t.MapFrom(c => c.PrimerNombreAval ?? ""))
                .ForMember(x => x.SegundoNombreAval, t => t.MapFrom(c => c.SegundoNombreAval ?? ""))
                .ForMember(x => x.DireccionAval, t => t.MapFrom(c => c.DireccionAval ?? ""))
                .ForMember(x => x.TelefonoAval, t => t.MapFrom(c => c.TelefonoAval ?? ""))
                .ForMember(x => x.CelularAval, t => t.MapFrom(c => c.CelularAval ?? ""))
                .ForMember(x => x.TipoDocumentoAval, t => t.MapFrom(c => c.TipoDocumentoAval ?? ""))
                .ForMember(x => x.NumeroDocumentoAval, t => t.MapFrom(c => c.NumeroDocumentoAval ?? ""))
                .ForMember(x => x.TipoVinculoAval, t => t.MapFrom(c => c.TipoVinculoAval))
                .ForMember(x => x.MontoMeta, t => t.MapFrom(c => c.MontoMeta))
                .ForMember(x => x.TipoMeta, t => t.MapFrom(c => c.TipoMeta ?? ""))
                .ForMember(x => x.DescripcionMeta, t => t.MapFrom(c => c.DescripcionMeta ?? ""));

            model = Mapper.Map<BESolicitudCredito, SolicitudCreditoModel>(beSolicitudCredito);

            #endregion
        }

        private List<InfoGenerica> ObtenerAnioNacimiento()
        {
            List<InfoGenerica> lista = new List<InfoGenerica>();
            int minAnho = DateTime.Now.Year - 80;
            int maxAnho = DateTime.Now.Year - 18;
            int count;
            for (count = minAnho; count < maxAnho; count++)
            {
                InfoGenerica infoGenerica = new InfoGenerica();
                infoGenerica.Valor = count.ToString();
                infoGenerica.Texto = count.ToString();
                lista.Add(infoGenerica);
            }

            return lista;
        }

        private List<InfoGenerica> ObtenerDiaNacimiento()
        {
            List<InfoGenerica> listaDiaNacimiento = new List<InfoGenerica>();

            for (int i = 1; i <= 31; i++)
            {
                if (i < 10)
                {
                    listaDiaNacimiento.Add(new InfoGenerica { Texto = string.Format("0{0}", i), Valor = string.Format("0{0}", i) });
                }
                else
                {
                    listaDiaNacimiento.Add(new InfoGenerica { Texto = i.ToString(), Valor = i.ToString() });
                }
            }
            return listaDiaNacimiento;
        }

        private List<InfoGenerica> ObtenerMesNacimiento()
        {
            List<InfoGenerica> listaMesNacimiento = new List<InfoGenerica>()
                                                        {
                                                            new InfoGenerica() {Valor = "01", Texto = "Enero"},
                                                            new InfoGenerica() {Valor = "02", Texto = "Febrero"},
                                                            new InfoGenerica() {Valor = "03", Texto = "Marzo"},
                                                            new InfoGenerica() {Valor = "04", Texto = "Abril"},
                                                            new InfoGenerica() {Valor = "05", Texto = "Mayo"},
                                                            new InfoGenerica() {Valor = "06", Texto = "Junio"},
                                                            new InfoGenerica() {Valor = "07", Texto = "Julio"},
                                                            new InfoGenerica() {Valor = "08", Texto = "Agosto"},
                                                            new InfoGenerica() {Valor = "09", Texto = "Setiembre"},
                                                            new InfoGenerica() {Valor = "10", Texto = "Octubre"},
                                                            new InfoGenerica() {Valor = "11", Texto = "Noviembre"},
                                                            new InfoGenerica() {Valor = "12", Texto = "Diciembre"},
                                                        };
            return listaMesNacimiento;
        }

        private void CargarValoresModelo(ref SolicitudCreditoModel model)
        {
            #region Cargando Valores Por Defecto de los Combos

            using (SACServiceClient sv = new SACServiceClient())
            {
                model.ListaTipoContacto = sv.GetTablaLogicaDatos(UserData().PaisID, 31).ToList();
                model.ListaTipoDocumento = sv.GetTablaLogicaDatos(UserData().PaisID, 32).ToList();
                model.ListaEstadoCivil = sv.GetTablaLogicaDatos(UserData().PaisID, 33).ToList();
                model.ListaNivelEducativo = sv.GetTablaLogicaDatos(UserData().PaisID, 34).ToList();
                model.ListaOtrasMarcas = sv.GetTablaLogicaDatos(UserData().PaisID, 35).ToList();
                model.ListaTipoVinculoFamiliar = sv.GetTablaLogicaDatos(UserData().PaisID, 36).ToList();
                model.ListaTipoVinculoNoFamiliar = sv.GetTablaLogicaDatos(UserData().PaisID, 37).ToList();
                model.ListaTipoVinculoAval = sv.GetTablaLogicaDatos(UserData().PaisID, 38).ToList();
                model.ListaTipoVia = sv.GetTablaLogicaDatos(UserData().PaisID, 40).ToList();
                model.ListaTipoNacionalidad = sv.GetTablaLogicaDatos(UserData().PaisID, 41).ToList();
            }

            List<InfoGenerica> listaAvenidaCalle = new List<InfoGenerica>() { 
                new InfoGenerica(){ Valor="AV", Texto="Avenida" },
                new InfoGenerica(){ Valor="CL", Texto="Calle" }
            };

            List<InfoGenerica> listaCasaEdificio = new List<InfoGenerica>() { 
                new InfoGenerica(){ Valor="CAS", Texto="Casa" },
                new InfoGenerica(){ Valor="EDF", Texto="Edificio" }
            };

            List<InfoGenerica> listaUrbanizacionSector = new List<InfoGenerica>() { 
                new InfoGenerica(){ Valor="URB", Texto="Urbanización" },
                new InfoGenerica(){ Valor="SEC", Texto="Sector" }
            };

            List<InfoGenerica> listaApartamentoCasa = new List<InfoGenerica>() { 
                new InfoGenerica(){ Valor="APTO", Texto="N° Apartamento" },
                new InfoGenerica(){ Valor="CASA", Texto="N° Casa" }
            };

            model.ListaAvenidaCalle = listaAvenidaCalle;
            model.ListaCasaEdificio = listaCasaEdificio;
            model.ListaUrbanizacionSector = listaUrbanizacionSector;
            model.ListaApartamentoCasa = listaApartamentoCasa;

            model.ListaDiaNacimiento = ObtenerDiaNacimiento();
            model.ListaMesNacimiento = ObtenerMesNacimiento();
            model.ListaAnioNacimiento = ObtenerAnioNacimiento();

            List<InfoGenerica> listaSexos = new List<InfoGenerica>
            {
                (new InfoGenerica{ Valor = "F", Texto = "FEMENINO" }),
                (new InfoGenerica{ Valor = "M", Texto = "MASCULINO" })
            };

            model.ListaSexos = listaSexos;

            #endregion
        }

        public ActionResult DescargarSolicitud()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "SolicitudCredito/DescargarSolicitud"))
                return RedirectToAction("Index", "Bienvenida");

            ViewBag.NombrePais = UserData().NombrePais;
            return View();
        }

        [HttpPost]
        public JsonResult RealizarDescarga()
        {
            try
            {
                string[] resultado = null;

                using (var ws = new SACServiceClient())
                {
                    resultado = ws.DescargaSolicitudes(UserData().PaisID, UserData().CodigoUsuario);
                }

                if (resultado.Length == 2)
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de solicitudes ha finalizado satisfactoriamente.",
                        IsFox = true,
                        rutaSolCredito = resultado[0],
                        rutaSolActualizacion = resultado[1]
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de carga de solicitudes ha finalizado satisfactoriamente."
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoUsuario, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoUsuario, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = "Ocurrio un Error inesperado.",
                    exception = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}