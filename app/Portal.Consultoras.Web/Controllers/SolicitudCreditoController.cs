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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }

        public ActionResult ReporteActualizacionDatos()
        {
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);

        }

        public IEnumerable<ZonaModel> DropDownZonas(int paisId)
        {
            IList<BEZona> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectAllZonas(paisId);
            }

            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lista);
        }

        private IEnumerable<PaisModel> CargarDropDowListPaises()
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
            lista[10] = userData.BanderaImagen;
            lista[11] = userData.NombrePais;
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
            lista[10] = userData.BanderaImagen;
            lista[11] = userData.NombrePais;
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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                            userData.CodigoISO,
                            a.CodigoZona,
                            a.SolicitudCreditoID.ToString(),
                            a.CodigoConsultoraRecomienda,
                            a.NombreConsultoraRecomienda,
                            (a.NumeroDocumento == null)
                                ? ""
                                : (userData.CodigoISO == Constantes.CodigosISOPais.PuertoRico)
                                    ? string.Format("*****{0}", a.NumeroDocumento.Remove(0, 5))
                                    : a.NumeroDocumento,
                            a.CodigoConsultora,
                            (a.FechaCreacion == null
                                ? ""
                                : Convert.ToDateTime(a.FechaCreacion).ToString("dd/MM/yyyy hh:mm tt")),
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
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaSolicitudes = new List<BESolicitudCredito>();
            }

            var list = Mapper.Map<IList<BESolicitudCredito>, IList<SolicitudCreditoModel>>(listaSolicitudes);

            if (userData.CodigoISO == Constantes.CodigosISOPais.PuertoRico)
            {
                list.ToList().ForEach(x =>
                {
                    x.NumeroDocumento = x.NumeroDocumento.Length > 4 ? string.Format("*****{0}", x.NumeroDocumento.Remove(0, 5)) : string.Empty;
                });
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Zona", "CodigoZona"},
                {"ID Interno", "SolicitudCreditoID"},
                {"Cod. Consultora que Refiere", "CodigoConsultoraRecomienda"},
                {"Nombre", "NombreConsultoraRecomienda"},
                {"Doc. Identidad", "NumeroDocumento"},
                {"Cod. Consultora", "CodigoConsultora"},
                {"Fecha", "FechaCreacion"},
                {"Estado", "EstadoDescripcion"},
                {"Tipo", "TipoSolicitud"}
            };
            Util.ExportToExcel("SolicitudesExcel", list.ToList(), dic);
            return View();


        }

        public ActionResult DetalleCreditoVE()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("SolicitudCredito", "SolicitudCredito");
            JObject obj = JObject.Parse(Request.Form["data"]);

            BESolicitudCredito beSolicitud;

            int solicitudCreditoId = Convert.ToInt32(obj["SolicitudID"].ToString());

            using (SACServiceClient srv = new SACServiceClient())
            {
                beSolicitud = srv.BuscarSolicitudCreditoPorID(userData.PaisID, solicitudCreditoId);
            }

            SolicitudCreditoModel model = new SolicitudCreditoModel();
            MapeoEntidadModelo(ref model, beSolicitud);

            BEUbigeo beUbigeo;
            using (ODSServiceClient ods = new ODSServiceClient())
            {
                beUbigeo = ods.GetUbigeoPorCodigoUbigeo(userData.PaisID, model.CodigoUbigeo ?? "");
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
                model.ListaTipoMeta = ods.GetTipoMeta(userData.PaisID).ToList();
            }

            return View(model);
        }

        public ActionResult DetalleCreditoPR()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("SolicitudCredito", "SolicitudCredito");
            JObject obj = JObject.Parse(Request.Form["data"]);

            BESolicitudCredito beSolicitud;

            int solicitudCreditoId = Convert.ToInt32(obj["SolicitudID"].ToString());

            using (SACServiceClient srv = new SACServiceClient())
            {
                beSolicitud = srv.BuscarSolicitudCreditoPorID(userData.PaisID, solicitudCreditoId);
            }

            SolicitudCreditoModel model = new SolicitudCreditoModel();
            MapeoEntidadModelo(ref model, beSolicitud);

            BEUbigeo beUbigeo;
            using (ODSServiceClient ods = new ODSServiceClient())
            {
                beUbigeo = ods.GetUbigeoPorCodigoUbigeo(userData.PaisID, model.CodigoUbigeo ?? "");
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

            BESolicitudCredito beSolicitud;

            int solicitudCreditoId = Convert.ToInt32(obj["SolicitudID"].ToString());

            using (SACServiceClient srv = new SACServiceClient())
            {
                beSolicitud = srv.BuscarSolicitudCreditoPorID(userData.PaisID, solicitudCreditoId);
            }

            SolicitudCreditoModel model = new SolicitudCreditoModel();
            MapeoEntidadModelo(ref model, beSolicitud);

            BEUbigeo beUbigeo;
            using (ODSServiceClient ods = new ODSServiceClient())
            {
                beUbigeo = ods.GetUbigeoPorCodigoUbigeo(userData.PaisID, model.CodigoUbigeo ?? "");
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
            model = Mapper.Map<BESolicitudCredito, SolicitudCreditoModel>(beSolicitudCredito);
        }

        private List<InfoGenerica> ObtenerAnioNacimiento()
        {
            List<InfoGenerica> lista = new List<InfoGenerica>();
            int minAnho = DateTime.Now.Year - 80;
            int maxAnho = DateTime.Now.Year - 18;
            int count;
            for (count = minAnho; count < maxAnho; count++)
            {
                InfoGenerica infoGenerica = new InfoGenerica
                {
                    Valor = count.ToString(),
                    Texto = count.ToString()
                };
                lista.Add(infoGenerica);
            }

            return lista;
        }

        private List<InfoGenerica> ObtenerDiaNacimiento()
        {
            List<InfoGenerica> listaDiaNacimiento = new List<InfoGenerica>();

            for (int i = 1; i <= 31; i++)
            {
                listaDiaNacimiento.Add(i < 10
                    ? new InfoGenerica { Texto = string.Format("0{0}", i), Valor = string.Format("0{0}", i) }
                    : new InfoGenerica { Texto = i.ToString(), Valor = i.ToString() });
            }
            return listaDiaNacimiento;
        }

        private List<InfoGenerica> ObtenerMesNacimiento()
        {
            List<InfoGenerica> listaMesNacimiento = new List<InfoGenerica>()
            {
                new InfoGenerica {Valor = "01", Texto = "Enero"},
                new InfoGenerica {Valor = "02", Texto = "Febrero"},
                new InfoGenerica {Valor = "03", Texto = "Marzo"},
                new InfoGenerica {Valor = "04", Texto = "Abril"},
                new InfoGenerica {Valor = "05", Texto = "Mayo"},
                new InfoGenerica {Valor = "06", Texto = "Junio"},
                new InfoGenerica {Valor = "07", Texto = "Julio"},
                new InfoGenerica {Valor = "08", Texto = "Agosto"},
                new InfoGenerica {Valor = "09", Texto = "Setiembre"},
                new InfoGenerica {Valor = "10", Texto = "Octubre"},
                new InfoGenerica {Valor = "11", Texto = "Noviembre"},
                new InfoGenerica {Valor = "12", Texto = "Diciembre"},
            };
            return listaMesNacimiento;
        }

        private void CargarValoresModelo(ref SolicitudCreditoModel model)
        {
            #region Cargando Valores Por Defecto de los Combos

            using (SACServiceClient sv = new SACServiceClient())
            {
                model.ListaTipoContacto = sv.GetTablaLogicaDatos(userData.PaisID, 31).ToList();
                model.ListaTipoDocumento = sv.GetTablaLogicaDatos(userData.PaisID, 32).ToList();
                model.ListaEstadoCivil = sv.GetTablaLogicaDatos(userData.PaisID, 33).ToList();
                model.ListaNivelEducativo = sv.GetTablaLogicaDatos(userData.PaisID, 34).ToList();
                model.ListaOtrasMarcas = sv.GetTablaLogicaDatos(userData.PaisID, 35).ToList();
                model.ListaTipoVinculoFamiliar = sv.GetTablaLogicaDatos(userData.PaisID, 36).ToList();
                model.ListaTipoVinculoNoFamiliar = sv.GetTablaLogicaDatos(userData.PaisID, 37).ToList();
                model.ListaTipoVinculoAval = sv.GetTablaLogicaDatos(userData.PaisID, 38).ToList();
                model.ListaTipoVia = sv.GetTablaLogicaDatos(userData.PaisID, 40).ToList();
                model.ListaTipoNacionalidad = sv.GetTablaLogicaDatos(userData.PaisID, 41).ToList();
            }

            List<InfoGenerica> listaAvenidaCalle = new List<InfoGenerica>() {
                new InfoGenerica { Valor="AV", Texto="Avenida" },
                new InfoGenerica { Valor="CL", Texto="Calle" }
            };

            List<InfoGenerica> listaCasaEdificio = new List<InfoGenerica>() {
                new InfoGenerica { Valor="CAS", Texto="Casa" },
                new InfoGenerica { Valor="EDF", Texto="Edificio" }
            };

            List<InfoGenerica> listaUrbanizacionSector = new List<InfoGenerica>() {
                new InfoGenerica { Valor="URB", Texto="Urbanización" },
                new InfoGenerica { Valor="SEC", Texto="Sector" }
            };

            List<InfoGenerica> listaApartamentoCasa = new List<InfoGenerica>() {
                new InfoGenerica { Valor="APTO", Texto="N° Apartamento" },
                new InfoGenerica { Valor="CASA", Texto="N° Casa" }
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

            ViewBag.NombrePais = userData.NombrePais;
            return View();
        }

        [HttpPost]
        public JsonResult RealizarDescarga()
        {
            try
            {
                string[] resultado;

                using (var ws = new SACServiceClient())
                {
                    resultado = ws.DescargaSolicitudes(userData.PaisID, userData.CodigoUsuario);
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

                return Json(new
                {
                    success = true,
                    mensaje = "El proceso de carga de solicitudes ha finalizado satisfactoriamente."
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoUsuario, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
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