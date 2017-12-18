﻿using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisPagosController : BaseController
    {
        #region Acciones

        public ActionResult Index(string pestanhaInicial)
        {
            Session["ListadoEstadoCuenta"] = null;

            string fechaVencimiento;
            string montoPagar;
            decimal montoPagarDec;

            ObtenerFechaVencimientoMontoPagar(out fechaVencimiento, out montoPagar, out montoPagarDec);

            var parametroAEncriptar = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;

            var model = new MisPagosModel();
            model.CodigoISO = userData.CodigoISO;
            model.UrlChileEncriptada = Util.EncriptarQueryString(parametroAEncriptar);
            model.RutaChile = userData.CodigoISO == "CL" ? GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPagoLineaChile) : string.Empty;
            model.MostrarFE = userData.CodigoISO == "EC" || userData.CodigoISO == "PE" ? " " : "display: none;";
            model.Simbolo = string.Format("{0} ", userData.Simbolo);
            model.TieneFlexipago = userData.IndicadorFlexiPago;
            model.MontoMinimoFlexipago = userData.MontoMinimoFlexipago;
            model.TienePagoOnline = userData.IndicadorPagoOnline;
            model.UrlPagoOnline = userData.UrlPagoOnline;
            model.CorreoConsultora = userData.EMail;
            model.FechaVencimiento = fechaVencimiento;
            model.MontoPagar = montoPagar;
            model.PestanhaInicial = pestanhaInicial ?? "";

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
            List<EstadoCuentaModel> lst;

            lst = ObtenerEstadoCuenta();
            if (lst.Count != 0)
            {
                lst.RemoveAt(lst.Count - 1);
            }

            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;

            BEPager pag = new BEPager();
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

            items = items.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = Util.PaginadorGenerico(grid, lst);

            items.Where(x => x.Glosa == null).Update(r => r.Glosa = string.Empty);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,

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
            string aux_fechaVencimiento;
            string montoPagar;
            decimal montoPagarDec = 0;

            try
            {
                List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();
                lst = ObtenerEstadoCuenta();
                lst = lst.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).ToList();

                ObtenerFechaVencimientoMontoPagar(out aux_fechaVencimiento, out montoPagar, out montoPagarDec);
                lst.Add(new EstadoCuentaModel()
                {
                    Cargo = montoPagarDec
                });

                #region cotnenido del correo
                string cadena = "<span style='font-family:Calibri'><h2> Estado de Cuenta Belcorp </h2></span>" +
                                "<table width='650px' border = '1px' bordercolor='black' cellpadding='5px' cellspacing='0px' bgcolor='dddddd' >" +
                                "<tr>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Fecha</th>" +
                                    "<th bgcolor='666666' width='350px' align='center'><font color='#FFFFFF'>Últimos Movimientos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Pedidos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Abonos</th>" +
                                "</tr>";

                for (int i = 0; i < lst.Count - 1; i++)
                {
                    cadena = cadena + "<tr>" +
                                        "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                        "<td align='left'>" + lst[i].Glosa + "</td>" +
                                        "<td align='right'>" + Util.DecimalToStringFormat(lst[i].Cargo, userData.CodigoISO) + "</td>" +
                                        "<td align='right'>" + Util.DecimalToStringFormat(lst[i].Abono, userData.CodigoISO) + "</td>" +
                                      "</tr>";
                }

                if (lst.Count > 0)
                {
                    string fechaVencimiento = string.Empty;
                    if (!lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("19000101") && !lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("00010101"))
                    {
                        fechaVencimiento = lst[lst.Count - 1].Fecha.ToString("dd/MM/yyyy");
                    }
                    if (Math.Abs(lst[lst.Count - 1].Cargo) > 0)
                    {

                        cadena = cadena + "</table><br /><br />" +
                                     "TOTAL A PAGAR: " + string.Format("{0:0.##}", lst[lst.Count - 1].Cargo).Replace(',', '.') + "<br />";

                    }
                    else if (Math.Abs(lst[lst.Count - 1].Abono) > 0)
                    {

                        cadena = cadena + "</table><br /><br />" +
                                         "TOTAL A PAGAR: " + string.Format("{0:0.##}", lst[lst.Count - 1].Abono).Replace(',', '.') + "<br />";

                    }
                    else
                    {
                        cadena = cadena + "</table><br /><br />" +
                                          "TOTAL A PAGAR: " + "0" + "<br />";
                    }
                }

                #endregion

                Util.EnviarMail("no-responder@somosbelcorp.com", correo, "(" + userData.CodigoISO + ") Estado de Cuenta", cadena, true, userData.NombreConsultora);
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
            string fechaVencimiento;
            string montoPagar;
            decimal montoPagarDec = 0;
            List<EstadoCuentaModel> lst = ObtenerEstadoCuenta();
            lst = lst.OrderByDescending(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento).ToList();

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();

            if (lst.Count != 0)
            {
                ObtenerFechaVencimientoMontoPagar(out fechaVencimiento, out montoPagar, out montoPagarDec);
                
                dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, userData.NombreConsultora));
                lst.Add(new EstadoCuentaModel()
                {
                    Cargo = montoPagarDec
                });
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("Fecha", "Fecha");
            dic.Add("Ultimos Movimientos", "Glosa");
            dic.Add("Pedidos", userData.Simbolo + " #Cargo");
            dic.Add("Abonos", userData.Simbolo + " #Abono");

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

            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            BEPager pag = new BEPager();
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

            pag = PaginadorPercepcion(grid, lst);

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
                    lsta = sv.GetDatosBelcorp(UserData().PaisID).ToList();
                }
                if (lsta == null)
                {
                    lsta = new List<BEDatosBelcorp>();
                }

                string ImportePercepcionTexto = "Son: " + Util.enletras(Convert.ToDecimal(item.ImportePercepcion).ToString("0.00")) + " Nuevos Soles";

                return Json(new
                {
                    success = true,
                    Direccion = lsta[0].Direccion,
                    RUC = lsta[0].RUC,
                    RazonSocial = lsta[0].RazonSocial,
                    Simbolo = UserData().Simbolo,
                    Texto = ImportePercepcionTexto
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                lst = sv.SelectComprobantePercepcionDetalle(UserData().PaisID, Convert.ToInt32(IdComprobantePercepcion)).ToList();
            }

            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            BEPager pag = new BEPager();
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

            pag = PaginadorDetallePercepcion(grid, lst);

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
            lista[6] = UserData().PaisID.ToString();
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

            string IdComprobantePercepcion = data["IdComprobantePercepcion"].ToString();
            string RUCAgentePerceptor = data["RUCAgentePerceptor"].ToString();
            string NombreAgentePerceptor = data["NombreAgentePerceptor"].ToString();
            string NumeroComprobanteSerie = data["NumeroComprobanteSerie"].ToString();
            string FechaEmision = data["FechaEmision"].ToString();
            string ImportePercepcion = Convert.ToDecimal(data["ImportePercepcion"]).ToString("0.00");
            string ImportePercepcionTexto = "Son: " + Util.enletras(Convert.ToDecimal(data["ImportePercepcion"]).ToString("0.00")) + " Nuevos Soles";

            using (SACServiceClient sv = new SACServiceClient())
            {
                lsta = sv.GetDatosBelcorp(UserData().PaisID).ToList();
            }

            var model = new PercepcionesModel();

            model.IdComprobantePercepcion = IdComprobantePercepcion;
            model.RUCAgentePerceptor = RUCAgentePerceptor;
            model.NombreAgentePerceptor = NombreAgentePerceptor;
            model.NumeroComprobanteSerie = NumeroComprobanteSerie;
            model.FechaEmision = FechaEmision;
            model.ImportePercepcion = UserData().Simbolo + " " + ImportePercepcion;
            model.ImportePercepcionTexto = ImportePercepcionTexto;
            model.Direccion = lsta[0].Direccion;
            model.RUC = lsta[0].RUC;
            model.RazonSocial = lsta[0].RazonSocial;

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

                List<EstadoCuentaModel> lst = ObtenerEstadoCuenta();

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
            int paisID = userData.PaisID;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = (sv.SelectLugarPago(paisID) ?? new BELugarPago[0]).OrderBy(x => x.Posicion).ToList();
            }

            foreach (var item in lst)
            {
                item.ArchivoLogo = Url.Content(item.ArchivoLogo);
            }

            string iso = userData.CodigoISO;
            var carpetaPais = Globals.UrlLugaresPago + "/" + iso;
            if (lst.Any())
                lst.Update(x => x.ArchivoLogo = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoLogo, Globals.RutaImagenesLugaresPago + "/" + iso));

            var lugaresPagoModel = new LugaresPagoModel()
            {
                PaisID = paisID,
                CampaniaID = userData.CampaniaID,
                ISO = iso,
                listaLugaresPago = lst
            };

            return lugaresPagoModel;
        }

        private void ExportToExcelEstadoCuenta(string filename, List<EstadoCuentaModel> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
           Dictionary<string, string> columnDetailDefinition, string[] arrTotal, decimal cargoTotal, decimal abonoTotal)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                int row = 1;
                int col = 0;
                int i = 0;

                int col2 = 1;
                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    ws.Cell(row, 1).Value = keyvalue.Value;
                    ws.Range(string.Format("A{0}:E{1}", row, row)).Row(1).Merge();
                    ws.Cell(row, 1).Style.Font.Bold = true;
                    col2 = 1;
                    foreach (KeyValuePair<string, string> keyvalue2 in columnDetailDefinition)
                    {
                        ws.Cell(row + 1, col2).Value = keyvalue2.Key;
                        col2++;
                        Columns.Add(keyvalue2.Value);
                    }

                    ws.Range(row + 1, 1, row + 1, col2 - 1).AddToNamed("HeadDetails");
                    var titlesStyleh = wb.Style;
                    titlesStyleh.Font.Bold = true;
                    titlesStyleh.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#00A2E8");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in Columns)
                        {
                            EstadoCuentaModel source = SourceDetails[i];

                            string[] arr = new string[2];
                            if (column.Contains("#"))
                                arr = column.Split('#');
                            else
                                arr = new string[] { "", column };

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
                                string cargo = "";
                                if (userData.PaisID == 4)
                                {
                                    cargo = source.Cargo.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    cargo = source.Cargo.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + cargo;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }

                            else if (arr[1] == "Abono")
                            {
                                string abono = "";
                                if (userData.PaisID == 4)
                                {
                                    abono = source.Abono.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    abono = source.Abono.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + abono;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            col++;
                        }
                        row++;
                        i++;
                    }
                    Columns = new List<string>();
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
                    index = keyvalue.Key + 1;
                    SourceDetails.RemoveRange(0, index);
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
            catch (Exception)
            {
            }
        }

        private BEPager PaginadorPercepcion(BEGrid item, List<BEComprobantePercepcion> lst)
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

        private BEPager PaginadorDetallePercepcion(BEGrid item, List<BEComprobantePercepcionDetalle> lst)
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

        #endregion
    }
}
