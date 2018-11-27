﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Web.Infraestructure.Validator.PagoEnLinea;

namespace Portal.Consultoras.Web.Controllers
{
    public class PagoEnLineaController : BaseController
    {
        protected PagoEnLineaProvider _pagoEnLineaProvider;

        public PagoEnLineaController()
        {
            _pagoEnLineaProvider = new PagoEnLineaProvider();
        }

        // GET: PagoEnLinea
        public ActionResult Index()
        {
            string sap = "";
            var url = (Request.Url.Query).Split('?');
            if (EsDispositivoMovil())
            {
                if (url.Length > 1)
                {
                    sap = "&" + url[1];
                    return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile", sap });
                }
                else
                {
                    return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });
                }
            }

            if (!userData.TienePagoEnLinea)
                return RedirectToAction("Index", "Bienvenida");

            var model = SessionManager.GetDatosPagoVisa();
            if (!_pagoEnLineaProvider.IsLoadMetodoPago(model)) return RedirectToAction("MetodoPago");

            model = _pagoEnLineaProvider.ObtenerValoresPagoEnLinea(model);

            ViewBag.PagoEnLineaGastosLabel = userData.PaisID == Constantes.PaisID.Mexico ? Constantes.PagoEnLineaMensajes.GastosLabelMx : Constantes.PagoEnLineaMensajes.GastosLabelPe;

            return View(model);
        }

        public ActionResult MetodoPago()
        {
            if (!userData.TienePagoEnLinea)
                return RedirectToAction("Index", "Bienvenida");

            var model = new PagoEnLineaModel
            {
                ListaMetodoPago = _pagoEnLineaProvider.ObtenerListaMetodoPago()
            };
            SessionManager.SetDatosPagoVisa(model);

            return View(model);
        }

        [HttpPost]
        public string ObtenerBancos()
        {
            string bancos = "";
            using (var ps = new PedidoServiceClient())
            {
                bancos = ps.ObtenerPagoEnLineaURLPaginasBancos(userData.PaisID);
        
            }
            return bancos;
        }

        [HttpGet]
        public ActionResult PasarelaPago()
        {
            var pago = SessionManager.GetDatosPagoVisa();
            if (!_pagoEnLineaProvider.IsLoadMetodoPago(pago)) return RedirectToAction("MetodoPago");
            if (!_pagoEnLineaProvider.CanPay(userData, pago)) return RedirectToAction("Index", "Bienvenida");

            pago.PagoVisaModel = _pagoEnLineaProvider.ObtenerValoresPagoPayu();
            LoadViewParameters(pago, _pagoEnLineaProvider.ObtenerCamposRequeridos());

            var model = new PaymentInfo
            {
                Phone = userData.Celular,
                Email = userData.EMail
            };

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> PasarelaPago(PaymentInfo info)
        {
            var pago = SessionManager.GetDatosPagoVisa();
            if (!_pagoEnLineaProvider.IsLoadMetodoPago(pago)) return RedirectToAction("MetodoPago");
            if (!_pagoEnLineaProvider.CanPay(userData, pago)) return RedirectToAction("Index", "Bienvenida");

            var requiredFields = _pagoEnLineaProvider.ObtenerCamposRequeridos();

            if (ModelState.IsValid)
            {
                var expRegular = pago.MetodoPagoSeleccionado.ExpresionRegularTarjeta;
                var validator = new PasarelaValidator
                {
                    RequiredFields = requiredFields,
                    PatternCard = expRegular
                };

                if (validator.IsValid(info))
                {
                    return await GetPayResult(info, pago);
                }

                foreach (var error in validator.Errors)
                {
                    ModelState.AddModelError(error.Key, error.Value);
                }
            }

            LoadViewParameters(pago, requiredFields);

            return View(info);
        }

        [HttpPost]
        public JsonResult GuardarDatosPago(int id)
        {
            var model = SessionManager.GetDatosPagoVisa();
            if (model == null || model.ListaMetodoPago == null) return Json(new { success = false });

            model.MetodoPagoSeleccionado = model.ListaMetodoPago.FirstOrDefault(r => r.PagoEnLineaMedioPagoDetalleId == id);

            if (model.MetodoPagoSeleccionado == null) return Json(new { success = false });

            SessionManager.SetDatosPagoVisa(model);

            return Json(new
            {
                success = true,
                message = "OK"
            });
        }

        [HttpPost]
        public JsonResult GuardarMontoDeuda(decimal MontoDeuda)
        {
            var model = SessionManager.GetDatosPagoVisa();
            if (model == null) return Json(new { success = false });

            model.MontoDeuda = MontoDeuda;
            SessionManager.SetDatosPagoVisa(model);

            return Json(new
            {
                success = true,
                message = "OK"
            });
        }

        public ActionResult PagoVisa()
        {
            var model = SessionManager.GetDatosPagoVisa();

            if (!_pagoEnLineaProvider.IsLoadMetodoPago(model)) return RedirectToAction("MetodoPago");
            if (!_pagoEnLineaProvider.CanPay(userData, model)) return RedirectToAction("Index", "Bienvenida");

            model.PagoVisaModel = _pagoEnLineaProvider.ObtenerValoresPagoVisa(model);
            SessionManager.SetDatosPagoVisa(model);

            return View(model);
        }

        public ActionResult PagoVisaResultado()
        {
            var model = SessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("MetodoPago");

            try
            {
                string transactionToken = Request.Form["transactionToken"];
                if (string.IsNullOrWhiteSpace(transactionToken)) return RedirectToAction("MetodoPago");

                bool pagoOk = _pagoEnLineaProvider.ProcesarPagoVisa(ref model, transactionToken);

                if (pagoOk)
                {
                    ViewBag.UrlCondiciones = _menuProvider.GetMenuLinkByDescription(Constantes.ConfiguracionManager.MenuCondicionesDescripcion);
                    ViewBag.PaisId = userData.PaisID;

                    return View("PagoExitoso", model);
                }
                else
                {
                    return View("PagoRechazado", model);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return View("PagoRechazado", model);
        }

        public ActionResult Reporte()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "PagoEnLinea/Reporte"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            int paisId = userData.PaisID;
            int campaniaIdActual;
            using (SACServiceClient sv = new SACServiceClient())
            {
                campaniaIdActual = sv.GetCampaniaFacturacionPais(paisId);
            }

            var model = new PagoEnLineaReporteModel()
            {
                listaPaises = DropDowListPaises(),
                lista = DropDowListCampanias(paisId),
                listaRegiones = DropDownListRegiones(paisId),
                listaZonas = DropDownListZonas(paisId),
                PaisId = paisId,
                CampaniaId = campaniaIdActual
            };

            return View(model);
        }

        public ActionResult ConsultaReporte(string sidx, string sord, int page, int rows, string CampaniaID, string RegionID,
                                                         string ZonaID, string PaisID, string CodigoConsultora, string Estado,
                                                         string FechaPagoDesde, string FechaPagoHasta, string FechaProcesoDesde,
                                                         string FechaProcesoHasta)
        {
            if (ModelState.IsValid)
            {
                BEPagoEnLineaFiltro filtro = new BEPagoEnLineaFiltro();
                filtro.CampaniaId = CampaniaID == "" ? 0 : int.Parse(CampaniaID);
                filtro.RegionId = RegionID == "" ? 0 : int.Parse(RegionID);
                filtro.ZonaId = ZonaID == "" ? 0 : int.Parse(ZonaID);
                filtro.CodigoConsultora = CodigoConsultora;
                filtro.Estado = Estado;
                filtro.FechaPagoDesde = FechaPagoDesde == "" ? default(DateTime) : Convert.ToDateTime(FechaPagoDesde);
                filtro.FechaPagoHasta = FechaPagoHasta == "" ? default(DateTime) : Convert.ToDateTime(FechaPagoHasta);
                filtro.FechaProcesoDesde = FechaProcesoDesde == "" ? default(DateTime) : Convert.ToDateTime(FechaProcesoDesde);
                filtro.FechaProcesoHasta = FechaProcesoHasta == "" ? default(DateTime) : Convert.ToDateTime(FechaProcesoHasta);

                List<BEPagoEnLineaResultadoLogReporte> lst;

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    lst = ps.ObtenerPagoEnLineaByFiltro(userData.PaisID, filtro).ToList();
                }

                lst.Update(p => p.NombreCompleto = (p.PrimerNombre ?? "") + " " + (p.SegundoNombre ?? "") + " " + (p.PrimerApellido ?? "") + " " + (p.SegundoApellido ?? ""));

                lst.Update(p => p.FechaTransaccionFormat = p.FechaTransaccion.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : p.FechaTransaccion.ToString("dd/MM/yyyy"));
                lst.Update(p => p.FechaTransaccionHoraFormat = p.FechaTransaccion.ToString("dd/MM/yyyy") == "01/01/0001" ? "" : p.FechaTransaccion.ToString("HH:mm"));

                lst.Update(p => p.FechaCreacionFormat = p.FechaCreacion.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : p.FechaCreacion.ToString("dd/MM/yyyy"));
                lst.Update(p => p.FechaCreacionHoraFormat = p.FechaCreacion.ToString("dd/MM/yyyy") == "01/01/0001" ? "" : p.FechaCreacion.ToString("HH:mm"));

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEPagoEnLineaResultadoLogReporte> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CampaniaId":
                            items = lst.OrderBy(x => x.CampaniaId);
                            break;
                        case "NombreComercio":
                            items = lst.OrderBy(x => x.NombreComercio);
                            break;
                        case "IdUnicoTransaccion":
                            items = lst.OrderBy(x => x.IdUnicoTransaccion);
                            break;
                        case "PagoEnLineaResultadoLogId":
                            items = lst.OrderBy(x => x.PagoEnLineaResultadoLogId);
                            break;
                        case "NombreCompleto":
                            items = lst.OrderBy(x => x.NombreCompleto);
                            break;
                        case "FechaCreacionFormat":
                            items = lst.OrderBy(x => x.FechaCreacionFormat);
                            break;
                        case "FechaCreacionHoraFormat":
                            items = lst.OrderBy(x => x.FechaCreacionHoraFormat);
                            break;
                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoConsultora);
                            break;
                        case "NumeroDocumento":
                            items = lst.OrderBy(x => x.NumeroDocumento);
                            break;
                        case "Canal":
                            items = lst.OrderBy(x => x.Canal);
                            break;
                        case "Ciclo":
                            items = lst.OrderBy(x => x.Ciclo);
                            break;
                        case "ImporteAutorizado":
                            items = lst.OrderBy(x => x.ImporteAutorizado);
                            break;
                        case "MontoGastosAdministrativos":
                            items = lst.OrderBy(x => x.MontoGastosAdministrativos);
                            break;
                        case "IVA":
                            items = lst.OrderBy(x => x.IVA);
                            break;
                        case "MontoPago":
                            items = lst.OrderBy(x => x.MontoPago);
                            break;
                        case "TicketId":
                            items = lst.OrderBy(x => x.TicketId);
                            break;
                        case "CodigoRegion":
                            items = lst.OrderBy(x => x.CodigoRegion);
                            break;
                        case "CodigoZona":
                            items = lst.OrderBy(x => x.CodigoZona);
                            break;
                        case "OrigenTarjeta":
                            items = lst.OrderBy(x => x.OrigenTarjeta);
                            break;
                        case "NumeroTarjeta":
                            items = lst.OrderBy(x => x.NumeroTarjeta);
                            break;
                        case "NumeroOrdenTienda":
                            items = lst.OrderBy(x => x.NumeroOrdenTienda);
                            break;
                        case "MensajeError":
                            items = lst.OrderBy(x => x.MensajeError);
                            break;
                        case "CodigoError":
                            items = lst.OrderBy(x => x.CodigoError);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CampaniaId":
                            items = lst.OrderByDescending(x => x.CampaniaId);
                            break;
                        case "NombreComercio":
                            items = lst.OrderByDescending(x => x.NombreComercio);
                            break;
                        case "IdUnicoTransaccion":
                            items = lst.OrderByDescending(x => x.IdUnicoTransaccion);
                            break;
                        case "PagoEnLineaResultadoLogId":
                            items = lst.OrderByDescending(x => x.PagoEnLineaResultadoLogId);
                            break;
                        case "NombreCompleto":
                            items = lst.OrderByDescending(x => x.NombreCompleto);
                            break;
                        case "FechaCreacionFormat":
                            items = lst.OrderByDescending(x => x.FechaCreacionFormat);
                            break;
                        case "FechaCreacionHoraFormat":
                            items = lst.OrderByDescending(x => x.FechaCreacionHoraFormat);
                            break;
                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoConsultora);
                            break;
                        case "NumeroDocumento":
                            items = lst.OrderByDescending(x => x.NumeroDocumento);
                            break;
                        case "Canal":
                            items = lst.OrderByDescending(x => x.Canal);
                            break;
                        case "Ciclo":
                            items = lst.OrderByDescending(x => x.Ciclo);
                            break;
                        case "ImporteAutorizado":
                            items = lst.OrderByDescending(x => x.ImporteAutorizado);
                            break;
                        case "MontoGastosAdministrativos":
                            items = lst.OrderByDescending(x => x.MontoGastosAdministrativos);
                            break;
                        case "IVA":
                            items = lst.OrderByDescending(x => x.IVA);
                            break;
                        case "MontoPago":
                            items = lst.OrderByDescending(x => x.MontoPago);
                            break;
                        case "TicketId":
                            items = lst.OrderByDescending(x => x.TicketId);
                            break;
                        case "CodigoRegion":
                            items = lst.OrderByDescending(x => x.CodigoRegion);
                            break;
                        case "CodigoZona":
                            items = lst.OrderByDescending(x => x.CodigoZona);
                            break;
                        case "OrigenTarjeta":
                            items = lst.OrderByDescending(x => x.OrigenTarjeta);
                            break;
                        case "NumeroTarjeta":
                            items = lst.OrderByDescending(x => x.NumeroTarjeta);
                            break;
                        case "NumeroOrdenTienda":
                            items = lst.OrderByDescending(x => x.NumeroOrdenTienda);
                            break;
                        case "MensajeError":
                            items = lst.OrderByDescending(x => x.MensajeError);
                            break;
                        case "CodigoError":
                            items = lst.OrderByDescending(x => x.CodigoError);
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
                               id = a.PagoEnLineaResultadoLogId,
                               cell = new string[]
                               {
                            a.CampaniaId.ToString(),
                            a.NombreComercio ?? string.Empty,
                            a.IdUnicoTransaccion ?? string.Empty,
                            a.PagoEnLineaResultadoLogId.ToString(),
                            a.NombreCompleto ?? string.Empty,
                            a.FechaTransaccionFormat ?? string.Empty,
                            a.FechaTransaccionHoraFormat ?? string.Empty,
                            a.CodigoConsultora ?? string.Empty,
                            a.NumeroDocumento ?? string.Empty,
                            a.Canal ?? string.Empty,
                            a.Ciclo ?? string.Empty,
                            a.ImporteAutorizado.ToString(),
                            a.MontoGastosAdministrativos.ToString(),
                            a.IVA.ToString(),
                            a.MontoPago.ToString(),
                            a.TicketId ?? string.Empty,
                            a.CodigoRegion?? string.Empty,
                            a.CodigoZona ?? string.Empty,
                            a.OrigenTarjeta ?? string.Empty,
                            a.NumeroTarjeta ?? string.Empty,
                            a.NumeroOrdenTienda ?? string.Empty,
                            a.MensajeError ?? string.Empty,
                            a.CodigoError ?? string.Empty,
                            a.FechaCreacionFormat ?? string.Empty,
                            a.FechaCreacionHoraFormat ?? string.Empty,
                            a.Origen ?? string.Empty
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ExportarExcel(string CampaniaID, string RegionID, string ZonaID, string PaisID, string CodigoConsultora, string Estado,
                                                            string FechaPagoDesde, string FechaPagoHasta, string FechaProcesoDesde,
                                                            string FechaProcesoHasta)
        {
            BEPagoEnLineaFiltro filtro = new BEPagoEnLineaFiltro();
            filtro.CampaniaId = CampaniaID == "" ? 0 : int.Parse(CampaniaID);
            filtro.RegionId = RegionID == "" ? 0 : int.Parse(RegionID);
            filtro.ZonaId = ZonaID == "" ? 0 : int.Parse(ZonaID);
            filtro.CodigoConsultora = CodigoConsultora;
            filtro.Estado = Estado;

            filtro.FechaPagoDesde = FechaPagoDesde == "" ? default(DateTime) : Convert.ToDateTime(FechaPagoDesde);
            filtro.FechaPagoHasta = FechaPagoHasta == "" ? default(DateTime) : Convert.ToDateTime(FechaPagoHasta);
            filtro.FechaProcesoDesde = FechaProcesoDesde == "" ? default(DateTime) : Convert.ToDateTime(FechaProcesoDesde);
            filtro.FechaProcesoHasta = FechaProcesoHasta == "" ? default(DateTime) : Convert.ToDateTime(FechaProcesoHasta);

            IList<BEPagoEnLineaResultadoLogReporte> lst;
            using (PedidoServiceClient ps = new PedidoServiceClient())
            {
                lst = ps.ObtenerPagoEnLineaByFiltro(userData.PaisID, filtro).ToList();
            }

            lst.Update(p => p.NombreCompleto = (p.PrimerNombre ?? "") + " " + (p.SegundoNombre ?? "") + " " + (p.PrimerApellido ?? "") + " " + (p.SegundoApellido ?? ""));

            lst.Update(p => p.FechaTransaccionFormat = p.FechaTransaccion.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : p.FechaTransaccion.ToString("dd/MM/yyyy"));
            lst.Update(p => p.FechaTransaccionHoraFormat = p.FechaTransaccion.ToString("dd/MM/yyyy") == "01/01/0001" ? "" : p.FechaTransaccion.ToString("HH:mm"));

            lst.Update(p => p.FechaCreacionFormat = p.FechaCreacion.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : p.FechaCreacion.ToString("dd/MM/yyyy"));
            lst.Update(p => p.FechaCreacionHoraFormat = p.FechaCreacion.ToString("dd/MM/yyyy") == "01/01/0001" ? "" : p.FechaCreacion.ToString("HH:mm"));

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Campaña", "CampaniaId"},
                {"Nombre de Comercio", "NombreComercio"},
                {"Id de Pago", "IdUnicoTransaccion"},
                {"Nro. de Pago", "PagoEnLineaResultadoLogId"},
                {"Consultora", "NombreCompleto"},
                {"Fecha de Pago", "FechaTransaccionFormat"},
                {"Hora de Pago", "FechaTransaccionHoraFormat"},
                {"Codigo de Cliente", "CodigoConsultora"},
                {"Identificación de Cliente", "NumeroDocumento"},
                {"Canal", "Canal"},
                {"Ciclo", "Ciclo"},
                {"Total Pagado", "ImporteAutorizado"},
                {"Comisión", "MontoGastosAdministrativos"},
                {"IVA", "IVA"},
                {"Total a Consignar", "MontoPago"},
                {"Ticket ID", "TicketId"},
                {"Region", "CodigoRegion"},
                {"Zona", "CodigoZona"},
                {"Origen Tarjeta", "OrigenTarjeta"},
                {"Número de Tarjeta", "NumeroTarjeta"},
                {"Número de Operación", "NumeroOrdenTienda"},
                {"Descripcion de Transacción", "MensajeError"},
                {"Estado Transacción", "CodigoError"},
                {"Fecha de Proceso","FechaCreacionFormat" },
                {"Hora de Proceso","FechaCreacionHoraFormat" },
                {"Origen","Origen" }
            };

            Util.ExportToExcel("ReportePagoEnLineaExcel", lst.ToList(), dic, GetExcelSecureCallback());
            return View();
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

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        protected IEnumerable<RegionModel> DropDownListRegiones(int paisId)
        {
            IList<BERegion> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllRegiones(paisId);
            }
            return Mapper.Map<IList<BERegion>, IEnumerable<RegionModel>>(lst.OrderBy(zona => zona.Codigo).ToList());
        }

        protected IEnumerable<ZonaModel> DropDownListZonas(int paisId)
        {
            IList<BEZona> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectAllZonas(paisId);
            }
            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lst);
        }

        private async Task<ActionResult> GetPayResult(PaymentInfo info, PagoEnLineaModel pago)
        {
            var provider = new PagoPayuProvider
            {
                User = userData,
                SessionId = Session.SessionID,
                IpClient = GetIPCliente(),
                Agent = Request.UserAgent,
                PagoProvider = _pagoEnLineaProvider
            };

            var success = await provider.Pay(info, pago);
            SessionManager.SetDatosPagoVisa(null);
            SessionManager.SetListadoEstadoCuenta(null);

            if (!success)
                return View("PagoRechazado", pago);

            ViewBag.UrlCondiciones = _menuProvider.GetMenuLinkByDescription(Constantes.ConfiguracionManager.MenuCondicionesDescripcionMx);
            ViewBag.PaisId = userData.PaisID;

            var view = View("PagoExitoso", pago);

            return view;
        }

        private void LoadViewParameters(PagoEnLineaModel pago, string[] requiredFields)
        {
            pago.DeviceSessionId = GetDeviceSessionId();
            SessionManager.SetDatosPagoVisa(pago);

            ViewBag.DeviceSessionId = pago.DeviceSessionId;
            ViewBag.PagoLineaCampos = requiredFields;
            ViewBag.UrlIconMedioPago = _pagoEnLineaProvider.GetUrlIconMedioPago(pago);
            ViewBag.PagoMontoTotal = pago.Simbolo + " " + pago.MontoDeudaConGastosString;
            CargarListsPasarela();
        }

        private void CargarListsPasarela()
        {
            Func<string, SelectListItem> fnSelect = m => new SelectListItem { Value = m, Text = m };
            ViewBag.MonthList = _pagoEnLineaProvider.ObtenerMeses().Select(fnSelect);
            ViewBag.YearList = _pagoEnLineaProvider.ObtenerAnios().Select(fnSelect);
        }

        private string GetDeviceSessionId()
        {
            var provider = new PagoPayuProvider
            {
                SessionId = Session.SessionID
            };
            return provider.GetDeviceSessionId();
        }
    }
}