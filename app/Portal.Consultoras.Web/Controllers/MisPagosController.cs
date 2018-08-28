using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisPagosController : BaseController
    {
        protected EstadoCuentaProvider _estadoCuentaProvider;

        public MisPagosController()
        {
            _estadoCuentaProvider = new EstadoCuentaProvider();
        }

        #region Acciones

        public ActionResult Index(string pestanhaInicial)
        {
            if (EsDispositivoMovil())
            {
                return RedirectToAction("Index", "EstadoCuenta", new { area = "Mobile" });
            }
            sessionManager.SetListadoEstadoCuenta(null);

            string fechaVencimiento;
            string montoPagar;
            decimal montoPagarDec;
            ObtenerFechaVencimientoMontoPagar(out fechaVencimiento, out montoPagar, out montoPagarDec);

            var parametroAEncriptar = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;

            var model = new MisPagosModel
            {
                CodigoISO = userData.CodigoISO,
                UrlChileEncriptada = Util.EncriptarQueryString(parametroAEncriptar),
                RutaChile = userData.CodigoISO == Constantes.CodigosISOPais.Chile
                    ? _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPagoLineaChile)
                    : string.Empty,
                MostrarFE = GetDatosFacturacionElectronica(userData.PaisID, Constantes.FacturacionElectronica.TablaLogicaID, Constantes.FacturacionElectronica.FlagActivacion) == "1" ? " " : "display: none;",
                Simbolo = string.Format("{0} ", userData.Simbolo),
                TieneFlexipago = userData.IndicadorFlexiPago,
                MontoMinimoFlexipago = userData.MontoMinimoFlexipago,
                TienePagoOnline = userData.IndicadorPagoOnline,
                UrlPagoOnline = userData.UrlPagoOnline,
                CorreoConsultora = userData.EMail,
                FechaVencimiento = fechaVencimiento,
                MontoPagar = montoPagar,
                PestanhaInicial = pestanhaInicial ?? "",
                TienePagoEnLinea = userData.TienePagoEnLinea
            };

            List<string> pestanhaMisPagosAll = new List<string> {
                Constantes.PestanhasMisPagos.EstadoCuenta,
                Constantes.PestanhasMisPagos.LugaresPago,
                Constantes.PestanhasMisPagos.MisPercepciones
            };
            if (!pestanhaMisPagosAll.Contains(model.PestanhaInicial)) model.PestanhaInicial = Constantes.PestanhasMisPagos.EstadoCuenta;

            return View(model);
        }

        #region Estado Cuenta

        [HttpPost]
        public JsonResult ListarEstadoCuenta(string sidx, string sord, int page, int rows, string vCampania)
        {
            var lst = _estadoCuentaProvider.ObtenerEstadoCuenta();
            if (lst.Count != 0)
            {
                lst.RemoveAt(lst.Count - 1);
            }

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };

            IEnumerable<EstadoCuentaModel> items = lst;

            lst.ForEach(l =>
            {
                if (l.Cargo > 0)
                {
                    l.TipoMovimiento = 1;
                }
                if (l.Abono > 0)
                {
                    l.TipoMovimiento = 2;
                }
            });

            var ultimoMovimiento = _estadoCuentaProvider.ObtenerUltimoMovimientoEstadoCuenta(userData.PaisID, userData.TienePagoEnLinea, userData.ConsultoraID, userData.ZonaHoraria, userData.Simbolo, userData.CodigoISO);

            items = items.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = Util.PaginadorGenerico(grid, lst);

            items.Where(x => x.Glosa == null).Update(r => r.Glosa = string.Empty);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                UltimoMovimiento = ultimoMovimiento,
                Rows = items.Select(a => new
                {
                    Fecha = a.Fecha.ToString("dd/MM/yyyy"),
                    a.Glosa,
                    Cargo = string.Format("{0} ", userData.Simbolo) + Util.DecimalToStringFormat(a.Cargo, userData.CodigoISO),
                    Abono = string.Format("{0} ", userData.Simbolo) + Util.DecimalToStringFormat(a.Abono, userData.CodigoISO)
                })
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EnviarCorreoEstadoCuenta(string correo)
        {
            try
            {
                var lst = _estadoCuentaProvider.ObtenerEstadoCuenta();
                lst = lst.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).ToList();

                string auxFechaVencimiento;
                string montoPagar;
                decimal montoPagarDec;
                ObtenerFechaVencimientoMontoPagar(out auxFechaVencimiento, out montoPagar, out montoPagarDec);

                lst.Add(new EstadoCuentaModel()
                {
                    Cargo = montoPagarDec
                });

                #region cotnenido del correo

                var txtBuil = new StringBuilder();
                txtBuil.Append("<span style='font-family:Calibri'><h2> Estado de Cuenta Belcorp </h2></span>" +
                                "<table width='650px' border = '1px' bordercolor='black' cellpadding='5px' cellspacing='0px' bgcolor='dddddd' >" +
                                "<tr>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Fecha</th>" +
                                    "<th bgcolor='666666' width='350px' align='center'><font color='#FFFFFF'>Últimos Movimientos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Pedidos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Abonos</th>" +
                                "</tr>"
                            );

                for (int i = 0; i < lst.Count - 1; i++)
                {
                    txtBuil.Append("<tr>" +
                                        "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                        "<td align='left'>" + lst[i].Glosa + "</td>" +
                                        "<td align='right'>" + Util.DecimalToStringFormat(lst[i].Cargo, userData.CodigoISO) + "</td>" +
                                        "<td align='right'>" + Util.DecimalToStringFormat(lst[i].Abono, userData.CodigoISO) + "</td>" +
                                      "</tr>");
                }

                if (lst.Count > 0)
                {
                    if (Math.Abs(lst[lst.Count - 1].Cargo) > 0)
                    {

                        txtBuil.Append("</table><br /><br />" +
                                     "TOTAL A PAGAR: " + string.Format("{0:0.##}", lst[lst.Count - 1].Cargo).Replace(',', '.') +
                                     "<br />");

                    }
                    else if (Math.Abs(lst[lst.Count - 1].Abono) > 0)
                    {

                        txtBuil.Append("</table><br /><br />" +
                                         "TOTAL A PAGAR: " + string.Format("{0:0.##}", lst[lst.Count - 1].Abono).Replace(',', '.') +
                                         "<br />");

                    }
                    else
                    {
                        txtBuil.Append("</table><br /><br />" +
                                          "TOTAL A PAGAR: " + "0" +
                                          "<br />");
                    }
                }

                #endregion

                Util.EnviarMail("no-responder@somosbelcorp.com", correo, "(" + userData.CodigoISO + ") Estado de Cuenta", txtBuil.ToString(), true, userData.NombreConsultora);
                return Json(new
                {
                    success = true,
                    message = "El correo se envió de forma correcta a la cuenta: " + correo,
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

        public ActionResult ExportarExcelEstadoCuenta()
        {
            decimal abono = 0;
            decimal montoPagarDec = 0;
            List<EstadoCuentaModel> lst = _estadoCuentaProvider.ObtenerEstadoCuenta();
            lst = lst.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).ToList();

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();

            if (lst.Count != 0)
            {
                string fechaVencimiento;
                string montoPagar;
                ObtenerFechaVencimientoMontoPagar(out fechaVencimiento, out montoPagar, out montoPagarDec);

                dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, userData.NombreConsultora));
                lst.Add(new EstadoCuentaModel()
                {
                    Cargo = montoPagarDec
                });
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Fecha", "Fecha"},
                {"Ultimos Movimientos", "Glosa"},
                {"Pedidos", userData.Simbolo + " #Cargo"},
                {"Abonos", userData.Simbolo + " #Abono"}
            };

            string[] arrTotal = { "Total a Pagar:", userData.Simbolo + " #Cargo" };

            ExportToExcelEstadoCuenta("EstadoCuentaExcel", lst, dicCabeceras, dic, arrTotal, montoPagarDec, abono);
            return new EmptyResult();
        }

        #endregion

        #region Lugares Pago

        [HttpPost]
        public JsonResult ListarLugaresPago()
        {
            try
            {
                var lugaresPagoModel = ObtenerLugaresPago();
                return Json(lugaresPagoModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return Json(new LugaresPagoModel { listaLugaresPago = new List<BELugarPago>() });
        }

        #endregion

        #region Percepciones

        [HttpPost]
        public JsonResult ListarPercepciones(string sidx, string sord, int page, int rows)
        {
            List<BEComprobantePercepcion> lst;
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                ((BasicHttpBinding)sv.Endpoint.Binding).MaxReceivedMessageSize = int.MaxValue;
                lst = sv.SelectComprobantePercepcion(userData.PaisID, userData.ConsultoraID).ToList();
            }

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            IEnumerable<BEComprobantePercepcion> items = lst;

            #region Sort Section

            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "NumeroComprobanteSerie":
                        items = lst.OrderBy(x => x.NumeroComprobanteSerie).ThenBy(x => x.ImportePercepcion);
                        break;

                    case "FechaEmision":
                        items = lst.OrderBy(x => x.FechaEmision).ThenBy(x => x.ImportePercepcion);
                        break;

                    case "ImportePercepcion":
                        items = lst.OrderBy(x => x.ImportePercepcion);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "NumeroComprobanteSerie":
                        items = lst.OrderByDescending(x => x.NumeroComprobanteSerie).ThenBy(x => x.ImportePercepcion);
                        break;

                    case "FechaEmision":
                        items = lst.OrderByDescending(x => x.FechaEmision).ThenBy(x => x.ImportePercepcion);
                        break;

                    case "ImportePercepcion":
                        items = lst.OrderByDescending(x => x.ImportePercepcion);
                        break;
                }
            }

            #endregion Sort Section

            items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = PaginadorPercepcion(grid, lst);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage.ToString(),
                records = pag.RecordCount,
                paginaDe = pag.PageCount.ToString(),
                pageSize = grid.PageSize,
                rows = items.Select(x => new
                {
                    x.IdComprobantePercepcion,
                    x.RUCAgentePerceptor,
                    x.DireccionAgentePerceptor,
                    x.NombreAgentePerceptor,
                    x.NumeroComprobante,
                    FechaEmision = x.FechaEmision.ToString("dd/MM/yyyy"),
                    x.ImportePercepcion
                })
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerDetallePercepcion(PercepcionesModel item)
        {
            try
            {
                List<BEDatosBelcorp> lsta;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lsta = sv.GetDatosBelcorp(userData.PaisID).ToList();
                }

                string importePercepcionTexto = "Son: " + Util.Enletras(Convert.ToDecimal(item.ImportePercepcion).ToString("0.00")) + " Nuevos Soles";

                return Json(new
                {
                    success = true,
                    Direccion = lsta[0].Direccion,
                    RUC = lsta[0].RUC,
                    RazonSocial = lsta[0].RazonSocial,
                    Simbolo = userData.Simbolo,
                    Texto = importePercepcionTexto
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                });
            }
        }

        [HttpPost]
        public JsonResult ListarDetallePercepcion(string sidx, string sord, int page, int rows, string IdComprobantePercepcion)
        {
            List<BEComprobantePercepcionDetalle> lst;
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                lst = sv.SelectComprobantePercepcionDetalle(userData.PaisID, Convert.ToInt32(IdComprobantePercepcion)).ToList();
            }

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            IEnumerable<BEComprobantePercepcionDetalle> items = lst;

            #region Sort Section

            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "TipoDocumento":
                        items = lst.OrderBy(x => x.TipoDocumento);
                        break;

                    case "NumeroDocumentoSerie":
                        items = lst.OrderBy(x => x.NumeroDocumentoSerie);
                        break;

                    case "NumeroDocumentoCorrelativo":
                        items = lst.OrderBy(x => x.NumeroDocumentoCorrelativo);
                        break;

                    case "FechaEmisionDocumento":
                        items = lst.OrderBy(x => x.FechaEmisionDocumento);
                        break;

                    case "Monto":
                        items = lst.OrderBy(x => x.Monto);
                        break;

                    case "PorcentajePercepcion":
                        items = lst.OrderBy(x => x.PorcentajePercepcion);
                        break;

                    case "ImportePercepcion":
                        items = lst.OrderBy(x => x.ImportePercepcion);
                        break;

                    case "MontoTotal":
                        items = lst.OrderBy(x => x.MontoTotal);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "TipoDocumento":
                        items = lst.OrderByDescending(x => x.TipoDocumento);
                        break;

                    case "NumeroDocumentoSerie":
                        items = lst.OrderByDescending(x => x.NumeroDocumentoSerie);
                        break;

                    case "NumeroDocumentoCorrelativo":
                        items = lst.OrderByDescending(x => x.NumeroDocumentoCorrelativo);
                        break;

                    case "FechaEmisionDocumento":
                        items = lst.OrderByDescending(x => x.FechaEmisionDocumento);
                        break;

                    case "Monto":
                        items = lst.OrderByDescending(x => x.Monto);
                        break;

                    case "PorcentajePercepcion":
                        items = lst.OrderByDescending(x => x.PorcentajePercepcion);
                        break;

                    case "ImportePercepcion":
                        items = lst.OrderByDescending(x => x.ImportePercepcion);
                        break;

                    case "MontoTotal":
                        items = lst.OrderByDescending(x => x.MontoTotal);
                        break;
                }
            }

            #endregion Sort Section

            items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = PaginadorDetallePercepcion(grid, lst);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = items.Select(x => new
                {
                    x.IdComprobantePercepcion,
                    x.NumeroDocumentoSerie,
                    x.NumeroDocumentoCorrelativo,
                    FechaEmisionDocumento = x.FechaEmisionDocumento.ToString("dd/MM/yyyy"),
                    Monto = x.Monto.ToString("0.00"),
                    PorcentajePercepcion = x.PorcentajePercepcion.ToString("0.00"),
                    ImportePercepcion = x.ImportePercepcion.ToString("0.00"),
                    MontoTotal = x.MontoTotal.ToString("0.00"),
                    x.TipoDocumento
                })
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ExportarPDFPercepcion(string vIdComprobantePercepcion, string vRUCAgentePerceptor, string vNombreAgentePerceptor, string vNumeroComprobanteSerie, string vFechaEmision, string vImportePercepcion, string vSimbolo)
        {
            string[] lista = new string[10];
            lista[0] = vIdComprobantePercepcion;
            lista[1] = vRUCAgentePerceptor;
            lista[2] = vNombreAgentePerceptor;
            lista[3] = vNumeroComprobanteSerie;
            lista[4] = vFechaEmision;
            lista[5] = vImportePercepcion;
            lista[6] = userData.PaisID.ToString();
            lista[7] = vSimbolo;
            Util.ExportToPdfWebPages(this, "Percepciones.pdf", "PercepcionDetalle", Util.EncriptarQueryString(lista));
            return View();
        }

        public ActionResult DetallePercepcion()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("Index");

            JavaScriptSerializer serializer = new JavaScriptSerializer();

            Dictionary<string, object> data = serializer.Deserialize<Dictionary<string, object>>(Request.Form["data"]);

            List<BEDatosBelcorp> lsta;

            string idComprobantePercepcion = data["IdComprobantePercepcion"].ToString();
            string rucAgentePerceptor = data["RUCAgentePerceptor"].ToString();
            string nombreAgentePerceptor = data["NombreAgentePerceptor"].ToString();
            string numeroComprobanteSerie = data["NumeroComprobanteSerie"].ToString();
            string fechaEmision = data["FechaEmision"].ToString();
            string importePercepcion = Convert.ToDecimal(data["ImportePercepcion"]).ToString("0.00");
            string importePercepcionTexto = "Son: " + Util.Enletras(Convert.ToDecimal(data["ImportePercepcion"]).ToString("0.00")) + " Nuevos Soles";

            using (SACServiceClient sv = new SACServiceClient())
            {
                lsta = sv.GetDatosBelcorp(userData.PaisID).ToList();
            }

            var model = new PercepcionesModel
            {
                IdComprobantePercepcion = idComprobantePercepcion,
                RUCAgentePerceptor = rucAgentePerceptor,
                NombreAgentePerceptor = nombreAgentePerceptor,
                NumeroComprobanteSerie = numeroComprobanteSerie,
                FechaEmision = fechaEmision,
                ImportePercepcion = userData.Simbolo + " " + importePercepcion,
                ImportePercepcionTexto = importePercepcionTexto,
                Direccion = lsta[0].Direccion,
                RUC = lsta[0].RUC,
                RazonSocial = lsta[0].RazonSocial
            };


            return View(model);
        }

        #endregion

        #endregion

        #region Métodos privados

        private void ObtenerFechaVencimientoMontoPagar(out string fechaVencimiento, out string montoPagar, out decimal montoPagarDec)
        {
            fechaVencimiento = "--/--";
            montoPagar = Util.DecimalToStringFormat(0, userData.CodigoISO);
            montoPagarDec = 0;

            try
            {
                var fechaVencimientoTemp = userData.FechaLimPago;
                fechaVencimiento = fechaVencimientoTemp.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : fechaVencimientoTemp.ToString("dd/MM");

                List<EstadoCuentaModel> lst = _estadoCuentaProvider.ObtenerEstadoCuenta();

                if (lst.Count != 0)
                {
                    montoPagarDec = userData.MontoDeuda;
                    montoPagar = Util.DecimalToStringFormat(montoPagarDec, userData.CodigoISO);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        private LugaresPagoModel ObtenerLugaresPago()
        {
            List<BELugarPago> lst;
            int paisId = userData.PaisID;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = (sv.SelectLugarPago(paisId) ?? new BELugarPago[0]).OrderBy(x => x.Posicion).ToList();
            }

            foreach (var item in lst)
            {
                item.ArchivoLogo = Url.Content(item.ArchivoLogo);
            }

            string iso = userData.CodigoISO;
            
            if (lst.Any())
            {
                var carpetaPais = Globals.UrlLugaresPago + "/" + iso;
                lst.Update(x => x.ArchivoLogo = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ArchivoLogo));
            }                

            var lugaresPagoModel = new LugaresPagoModel()
            {
                PaisID = paisId,
                CampaniaID = userData.CampaniaID,
                ISO = iso,
                listaLugaresPago = lst
            };

            return lugaresPagoModel;
        }

        private void ExportToExcelEstadoCuenta(string filename, List<EstadoCuentaModel> sourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
           Dictionary<string, string> columnDetailDefinition, string[] arrTotal, decimal cargoTotal, decimal abonoTotal)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();

                int row = 1;
                int col = 0;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    ws.Cell(row, 1).Value = keyvalue.Value;
                    ws.Range(string.Format("A{0}:E{1}", row, row)).Row(1).Merge();
                    ws.Cell(row, 1).Style.Font.Bold = true;
                    var col2 = 1;
                    foreach (KeyValuePair<string, string> keyvalue2 in columnDetailDefinition)
                    {
                        ws.Cell(row + 1, col2).Value = keyvalue2.Key;
                        col2++;
                        columns.Add(keyvalue2.Value);
                    }

                    ws.Range(row + 1, 1, row + 1, col2 - 1).AddToNamed("HeadDetails");
                    var titlesStyleh = wb.Style;
                    titlesStyleh.Font.Bold = true;
                    titlesStyleh.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#00A2E8");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    var i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in columns)
                        {
                            EstadoCuentaModel source = sourceDetails[i];

                            var arr = column.Contains("#")
                                ? column.Split('#')
                                : new string[] { "", column };

                            if (arr[1] == "Fecha")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Fecha.ToShortDateString();
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }

                            else if (arr[1] == "Glosa")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Glosa;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }

                            else if (arr[1] == "Cargo")
                            {
                                string cargo = userData.PaisID == 4
                                    ? source.Cargo.ToString("#,##0").Replace(',', '.')
                                    : source.Cargo.ToString("0.00");

                                ws.Cell(row, col).Value = arr[0] + cargo;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }

                            else if (arr[1] == "Abono")
                            {
                                string abono = userData.PaisID == 4
                                    ? source.Abono.ToString("#,##0").Replace(',', '.')
                                    : source.Abono.ToString("0.00");
                                ws.Cell(row, col).Value = arr[0] + abono;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            col++;
                        }
                        row++;
                        i++;
                    }
                    columns = new List<string>();
                    if (arrTotal.Length > 0)
                    {
                        ws.Range(row, 1, row, col - 1).AddToNamed("Totals");
                        var titlesStyle = wb.Style;
                        titlesStyle.Font.Bold = true;
                        titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                        titlesStyle.Fill.BackgroundColor = XLColor.NoColor;
                        titlesStyleh.Font.FontColor = XLColor.FromHtml("#000000");
                        wb.NamedRanges.NamedRange("Totals").Ranges.Style = titlesStyle;

                        string cargo = "";
                        if (userData.PaisID == 4)
                        {
                            if (Math.Abs(cargoTotal) > 0)
                            {
                                cargo = cargoTotal.ToString("#,##0").Replace(',', '.');
                            }
                            else if (Math.Abs(abonoTotal) > 0)
                            {
                                cargo = abonoTotal.ToString("#,##0").Replace(',', '.');
                            }

                        }
                        else
                        {
                            if (Math.Abs(cargoTotal) > 0)
                            {
                                cargo = cargoTotal.ToString("0.00");
                            }
                            else if (Math.Abs(abonoTotal) > 0)
                            {
                                cargo = abonoTotal.ToString("0.00");
                            }
                        }

                        ws.Cell(row, col - 2).Value = arrTotal[0];
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] + cargo;
                    }
                    row++;
                    var index = keyvalue.Key + 1;
                    sourceDetails.RemoveRange(0, index);
                }

                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        private BEPager PaginadorPercepcion(BEGrid item, List<BEComprobantePercepcion> lst)
        {
            BEPager pag = new BEPager();

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        private BEPager PaginadorDetallePercepcion(BEGrid item, List<BEComprobantePercepcionDetalle> lst)
        {
            BEPager pag = new BEPager();

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        #endregion
    }
}
