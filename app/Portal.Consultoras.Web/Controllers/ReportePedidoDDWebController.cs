using AutoMapper;
using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceOSBBelcorpPedido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReportePedidoDDWebController : BaseController
    {
        #region Action

        public ActionResult ReportePedidosDDWeb()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ReportePedidoDDWeb/ReportePedidosDDWeb"))
                    return RedirectToAction("Index", "Bienvenida");
                Session["PedidosWebDDConf"] = null;
                Session["PedidosWebDD"] = null;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var model = new ReportePedidoDDWebModel
            {
                DropDownListCampania = new List<BECampania>(),
                DropDownListZona = new List<BEZona>(),
                DropDownListRegion = new List<BERegion>(),
                listaPaises = DropDowListPaises(),
                hdnpaisISO = userData.CodigoISO
            };
            ViewBag.PaisOcultoID = userData.PaisID;
            return View(model);
        }

        public ActionResult ReportePedidosDDWebDetalle()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("ReportePedidosDDWeb");

            var serializer = new JavaScriptSerializer();
            var data = serializer.Deserialize<Dictionary<string, object>>(Request.Form["data"]);

            var model = new ReportePedidoDDWebModel
            {
                lblCampaniaCod = data["CampaniaCod"].ToString(),
                lblConsultoraCod = data["ConsultoraCod"].ToString(),
                lblConsultoraNombre = data["ConsultoraNombre"].ToString(),
                lblUsuarioNombre = data["UsuarioNombre"].ToString(),
                lblOrigen = data["Origen"].ToString(),
                lblValidado = data["Validado"].ToString(),
                lblSaldo = data["Saldo"].ToString(),
                lblImporte = data["Importe"].ToString(),
                lblImporteConDescuento = data["ImporteConDescuento"].ToString(),
                hdnpaisISO = data["paisISO"].ToString(),
                Usuario = Convert.ToString(data["Usuario"]),
                TipoProceso = data["TipoProceso"].ToString(),
                MotivoRechazo = data["MotivoRechazo"].ToString()
            };

            return View(model);
        }

        public ActionResult ReportePedidosDDWebDetalleImp(string parametros)
        {
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(';');

            var model = new ReportePedidoDDWebModel
            {
                hdnpaisISO = lista[0],
                lblCampaniaCod = lista[1],
                lblConsultoraCod = lista[2],
                lblConsultoraNombre = lista[3],
                lblUsuarioNombre = lista[4],
                lblOrigen = lista[5],
                lblValidado = lista[6],
                lblSaldo = lista[7],
                lblImporte = lista[8],
                vpage = lista[9],
                vsortname = lista[10],
                vsortorder = lista[11],
                vrowNum = lista[12],
                Usuario = lista[13],
                TipoProceso = lista[17],
                MotivoRechazo = lista[18]
            };

            return View(model);
        }

        public ActionResult ConsultarPedidosDDWeb(FiltroReportePedidoDDWebModel model)
        {
            ViewBag.PaisOcultoID = userData.PaisID;
            var list = GetPedidoWebDD(model);

            bool orderAsc = (model.Sord == "asc");
            switch (model.Sidx)
            {
                case "NroRegistro": list = list.OrderBy(x => x.NroRegistro, orderAsc).ToList(); break;
                case "FechaRegistro": list = list.OrderBy(x => x.FechaRegistro, orderAsc).ToList(); break;
                case "CampaniaCodigo": list = list.OrderBy(x => x.CampaniaCodigo, orderAsc).ToList(); break;
                case "Seccion": list = list.OrderBy(x => x.Seccion, orderAsc).ToList(); break;
                case "ConsultoraCodigo": list = list.OrderBy(x => x.ConsultoraCodigo, orderAsc).ToList(); break;
                case "ImporteTotal": list = list.OrderBy(x => x.ImporteTotal, orderAsc).ToList(); break;
                case "ImporteTotalConDescuento": list = list.OrderBy(x => x.ImporteTotalConDescuento, orderAsc).ToList(); break;
                case "ConsultoraNombre": list = list.OrderBy(x => x.ConsultoraNombre, orderAsc).ToList(); break;
                case "UsuarioResponsable": list = list.OrderBy(x => x.UsuarioResponsable, orderAsc).ToList(); break;
                case "ConsultoraSaldo": list = list.OrderBy(x => x.ConsultoraSaldo, orderAsc).ToList(); break;
                case "OrigenNombre": list = list.OrderBy(x => x.OrigenNombre, orderAsc).ToList(); break;
                case "EstadoValidacionNombre": list = list.OrderBy(x => x.EstadoValidacionNombre, orderAsc).ToList(); break;
            }

            var grid = new BEGrid(model.Sidx, model.Sord, model.Page, model.Rows);
            var items = list.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
            var pag = Util.PaginadorGenerico(grid, list);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = items.Select(a => new
                {
                    idCampania = a.CampaniaID.ToString(),
                    idPedido = a.PedidoID.ToString(),
                    cell = new string[]
                    {
                        a.paisISO,
                        a.NroRegistro,
                        a.FechaRegistro.ToString(),
                        a.FechaReserva.HasValue ? a.FechaReserva.Value.ToString() : "",
                        a.CampaniaCodigo,
                        a.Region,
                        a.Zona,
                        a.Seccion,
                        a.ConsultoraCodigo,
                        a.ConsultoraNombre,
                        a.DocumentoIdentidad,
                        Util.DecimalToStringFormat(a.ImporteTotal, model.PaisID, userData.Simbolo),
                        Util.DecimalToStringFormat(a.ImporteTotalConDescuento, model.PaisID, userData.Simbolo),
                        Util.DecimalToStringFormat(a.ConsultoraSaldo, model.PaisID, userData.Simbolo),
                        a.OrigenNombre,
                        a.EstadoValidacionNombre,
                        a.IndicadorEnviado,
                        a.TipoProceso,
                        FomatearMontoDecimalGPR(string.IsNullOrEmpty(a.MotivoRechazo) ? " " : a.MotivoRechazo)
                    }
                }).ToList()
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        private string FomatearMontoDecimalGPR(string motivoRechazo)
        {
            var txtBuil = new StringBuilder();
            string[] motivos = motivoRechazo.Split(',');

            foreach (string item in motivos)
            {
                var motivoItem = item;
                if (motivoItem.Contains(':') && userData.CodigoISO.Equals(Constantes.CodigosISOPais.Colombia))
                {
                    decimal montoDecimal = Convert.ToDecimal(motivoItem.Substring(motivoItem.IndexOf(':') + 1).Replace(" ", string.Empty));

                    motivoItem = motivoItem.Remove(motivoItem.IndexOf(':'));
                    txtBuil.Append(string.Format("{0}: {1}", motivoItem, (userData.PaisID == 4) ? montoDecimal.ToString("#,##0").Replace(',', '.') : montoDecimal.ToString("0.00")));
                }
            }

            string textoDecimal = txtBuil.ToString();
            return string.IsNullOrEmpty(textoDecimal) ? motivoRechazo : textoDecimal;
        }

        public ActionResult ConsultarPedidosDDWebDetalle(string sidx, string sord, int page, int rows, string vPaisISO, string vCampania, string vConsultoraCodigo, string vTipoProceso)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoDDWebDetalle> lst;

                PedidoBS businessService = new PedidoBS();

                string isoWs = vPaisISO;

                if (vTipoProceso == "SRV")
                {
                    var lista = businessService.obtenerPedidoWebAnteriorDetalle(vCampania, isoWs, "0", "0", vConsultoraCodigo);
                    if (lista == null)
                    {
                        lst = new List<BEPedidoDDWebDetalle>();
                    }
                    else
                    {
                        lst = (from c in lista
                               where !string.IsNullOrEmpty(c.descripcion.Trim())
                               select new BEPedidoDDWebDetalle
                               {
                                   CUV = c.cuv,
                                   Descripcion = c.descripcion,
                                   Cantidad = c.cantidad,
                                   PrecioUnitario = Convert.ToDecimal(c.precioUnidad),
                                   PrecioTotal = Convert.ToDecimal(c.importeTotal)
                               }).ToList();

                    }
                }
                else
                {
                    isoWs = userData.CodigoISO;
                    List<BEPedidoDDWebDetalle> lstPedidosDdWebNoFacturados;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        lstPedidosDdWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(userData.PaisID, isoWs, Convert.ToInt32(vCampania), vConsultoraCodigo, vTipoProceso).ToList();
                    }

                    lst = (from c in lstPedidosDdWebNoFacturados
                           select new BEPedidoDDWebDetalle
                           {
                               CUV = c.CUV,
                               Descripcion = c.Descripcion,
                               Cantidad = c.Cantidad,
                               PrecioUnitario = c.PrecioUnitario,
                               PrecioTotal = c.PrecioTotal
                           }).ToList();

                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEPedidoDDWebDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "Cantidad":
                            items = lst.OrderBy(x => x.Cantidad);
                            break;
                        case "PrecioUnitario":
                            items = lst.OrderBy(x => x.PrecioUnitario);
                            break;
                        case "PrecioTotal":
                            items = lst.OrderBy(x => x.PrecioTotal);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "Cantidad":
                            items = lst.OrderByDescending(x => x.Cantidad);
                            break;
                        case "PrecioUnitario":
                            items = lst.OrderByDescending(x => x.PrecioUnitario);
                            break;
                        case "PrecioTotal":
                            items = lst.OrderByDescending(x => x.PrecioTotal);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

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
                                   a.CUV,
                                   a.Descripcion,
                                   a.Cantidad.ToString("0.00"),
                                   userData.Simbolo + " " + (userData.PaisID == 4 ? a.PrecioUnitario.ToString("#,##0").Replace(',','.') : a.PrecioUnitario.ToString("0.00")),
                                   userData.Simbolo + " " + (userData.PaisID == 4 ? a.PrecioTotal.ToString("#,##0").Replace(',','.') : a.PrecioTotal.ToString("0.00"))
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ExportarExcel(string vCampania, string vPaisISO, string vConsultoraCodigo, string vTipoProceso, string vMotivoRechazo)
        {
            var lst = new List<BEPedidoDDWebDetalle>();

            PedidoBS businessService = new PedidoBS();
            string isoWs = vPaisISO;


            if (vTipoProceso == "SRV")
            {
                var lista = businessService.obtenerPedidoWebAnteriorDetalle(vCampania, isoWs, "0", "0", vConsultoraCodigo);

                if (lista != null)
                {
                    lst = (from c in lista
                           where !string.IsNullOrEmpty(c.descripcion.Trim())
                           select new BEPedidoDDWebDetalle
                           {
                               CUV = c.cuv,
                               Descripcion = c.descripcion,
                               Cantidad = c.cantidad,
                               PrecioUnitario = Convert.ToDecimal(c.precioUnidad),
                               PrecioTotal = Convert.ToDecimal(c.importeTotal),
                               MotivoRechazo = vMotivoRechazo
                           }).ToList();
                }
            }
            else
            {
                isoWs = userData.CodigoISO;
                List<BEPedidoDDWebDetalle> lstPedidosDdWebNoFacturados;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lstPedidosDdWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(userData.PaisID, isoWs, Convert.ToInt32(vCampania), vConsultoraCodigo, vTipoProceso).ToList();
                }

                lst = (from c in lstPedidosDdWebNoFacturados
                       select new BEPedidoDDWebDetalle
                       {
                           CUV = c.CUV,
                           Descripcion = c.Descripcion,
                           Cantidad = c.Cantidad,
                           PrecioUnitario = c.PrecioUnitario,
                           PrecioTotal = c.PrecioTotal,
                           MotivoRechazo = vMotivoRechazo
                       }).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Código Único de Venta", "CUV"},
                {"Descripción", "Descripcion"},
                {"Cantidad", "Cantidad"},
                {"Precio Unitario", "PrecioUnitario"},
                {"Precio Total", "PrecioTotal"},
                {"MotivoRechazo", "MotivoRechazo"}
            };


            ExportToExcelDetallePedido("exportar", lst, dic, "DescargaCompleta", "1");
            return new EmptyResult();
        }

        public ActionResult ExportarExcelDetallePedido(FiltroReportePedidoDDWebModel model)
        {
            var dic = new Dictionary<string, string>{
                { "Región", "RegionCodigo" },
                { "Zona", "Zona" },
                { "Cod. Consultora", "ConsultoraCodigo" },
                { "CUV", "CUV" },
                { "Cantidad", "Cantidad" }
            };
            List<BEPedidoDDWeb> lst = GetPedidoWebDDDetalle(model);

            Util.ExportToExcel("PedidoDetalleConsultora", lst, dic, "DescargaCompleta", "1");
            return new EmptyResult();
        }

        public JsonResult ValidLimitCountDetalle(FiltroReportePedidoDDWebModel model)
        {
            try
            {
                int maxItems = int.Parse(GetConfiguracionManager(Constantes.ConstSession.DescargaExcelMaxItems));
                int count = GetPedidoWebDDDetalle(model).Count;

                if (maxItems < count) return ErrorJson(string.Format(Constantes.MensajesError.LimiteDescargaSobrepasado, maxItems), true);
                return SuccessJson(string.Empty, true);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.ReportePedidoDDWeb_DescargaCabecera, true);
            }
        }

        public JsonResult ValidLimitCountCabecera(FiltroReportePedidoDDWebModel model)
        {
            try
            {
                int maxItems = int.Parse(GetConfiguracionManager(Constantes.ConstSession.DescargaExcelMaxItems));
                int count = GetPedidoWebDD(model).Count;

                if (maxItems < count) return ErrorJson(string.Format(Constantes.MensajesError.LimiteDescargaSobrepasado, maxItems), true);
                return SuccessJson(string.Empty, true);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.ReportePedidoDDWeb_DescargaCabecera, true);
            }
        }

        public ActionResult ExportarExcelCabecera(FiltroReportePedidoDDWebModel model)
        {
            var dic = new Dictionary<string, string>{
                { "NroRegistro", "Nro. Registro," },
                { "FechaRegistro", "Fecha/Hora Ingreso," },
                { "FechaReserva", "Fecha Reserva," },
                { "CampaniaCodigo", "Año/Campaña," },
                { "Region", "Región," },
                { "Zona", "Zona," },
                { "Seccion", "Sección," },
                { "ConsultoraCodigo", "Cod. Consultora," },
                { "ConsultoraNombre", "Nombre Consultora," },
                { "DocumentoIdentidad", "Documento Identidad," },
                { "ImporteTotal", "Monto Total Pedido," },
                { "ImporteTotalConDescuento", "Monto Total Pedido con Descuento," },
                { "ConsultoraSaldo", "Saldo," },
                { "OrigenNombre", "Origen," },
                { "EstadoValidacionNombre", "Validado," },
                { "IndicadorEnviado", "Estado," },
                { "MotivoRechazo", "Motivo de Rechazo" }
            };

            var list = GetPedidoWebDD(model);
            var lista = list.Select(a => new
            {
                a.NroRegistro,
                a.FechaRegistro,
                a.FechaReserva,
                a.CampaniaCodigo,
                a.Region,
                a.Zona,
                a.Seccion,
                a.ConsultoraCodigo,
                a.ConsultoraNombre,
                a.DocumentoIdentidad,
                ImporteTotal = Util.DecimalToStringFormat(a.ImporteTotal, model.CodigoISO, userData.Simbolo),
                ImporteTotalConDescuento = Util.DecimalToStringFormat(a.ImporteTotalConDescuento, model.CodigoISO, userData.Simbolo),
                ConsultoraSaldo = Util.DecimalToStringFormat(a.ConsultoraSaldo, model.CodigoISO, userData.Simbolo),
                a.OrigenNombre,
                a.EstadoValidacionNombre,
                a.IndicadorEnviado,
                MotivoRechazo = string.IsNullOrEmpty(a.MotivoRechazo) ? "" : a.MotivoRechazo.Replace(",", ";")
            }).ToList();

            ExportToCSV("exportar", lista, dic, "DescargaCompleta", "1");
            return new EmptyResult();
        }

        public bool ExportToExcel<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                var columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";


                                    ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }

        public bool ExportToExcelCO<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                var columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";

                                    if (col == 9 || col == 10)
                                    {
                                        string valorDecimal = Convert.ToDecimal(System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null)).ToString("#,##0").Replace(',', '.');
                                        ws.Cell(row, col).Value = valorDecimal;
                                    }
                                    else
                                    {
                                        ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    }

                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }

        public bool ExportToExcelDetallePedido<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                var columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";

                                    if (userData.PaisID == 4)
                                    {
                                        if (col == 4 || col == 5)
                                        {
                                            string valorDecimal = Convert.ToDecimal(System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null)).ToString("#,##0").Replace(',', '.');
                                            ws.Cell(row, col).Value = valorDecimal;
                                        }
                                        else
                                        {
                                            ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                        }
                                    }
                                    else
                                    {
                                        ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    }
                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }

        public JsonResult SelectConsultora(string codigo, int rowCount)
        {
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                BEConsultoraCodigo[] beconsultora = sv.SelectConsultoraCodigo_A(userData.PaisID, codigo, rowCount);
                return Json(beconsultora, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ExportarPDF(string vPaisISO, string vCampaniaCod, string vConsultoraCod, string vConsultoraNombre,
                                        string vUsuarioNombre, string vOrigen, string vValidado, string vSaldo, string vImporte, string vImporteConDescuento,
                                        string vpage, string vsortname, string vsortorder, string vrowNum, string vUsuario, string vTipoProceso, string vMotivoRechazo)
        {
            string[] lista = new string[21];

            Session["PaisID"] = userData.PaisID;

            lista[0] = vPaisISO; lista[1] = vCampaniaCod; lista[2] = vConsultoraCod; lista[3] = vConsultoraNombre;
            lista[4] = vUsuarioNombre; lista[5] = vOrigen; lista[6] = vValidado; lista[7] = vSaldo;
            lista[8] = vImporte; lista[9] = vImporteConDescuento; lista[10] = vpage; lista[11] = vsortname; lista[12] = vsortorder;
            lista[13] = vrowNum; lista[14] = vUsuario; lista[15] = userData.Simbolo; lista[16] = userData.BanderaImagen;
            lista[17] = userData.NombrePais; lista[18] = vTipoProceso; lista[19] = userData.PaisID.ToString(); lista[20] = vMotivoRechazo;

            Util.ExportToPdfWebPages(this, "PedidoDDWeb.pdf", "ReportePedidoDDWebDetalleImp", Util.EncriptarQueryString(lista));
            return new EmptyResult();
        }

        #endregion

        #region Metodos

        public List<BECampania> CargarCampania()
        {
            var model = new ReportePedidoDDWebModel();

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                BECampania[] becampania = sv.SelectCampanias(userData.PaisID);

                model.DropDownListCampania = becampania.ToList();
                model.DropDownListCampania.Insert(0, new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" });
                return model.DropDownListCampania;
            }
        }

        public List<BEZona> CargarZona()
        {
            var model = new ReportePedidoDDWebModel();

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                BEZona[] bezona = sv.SelectAllZonas(userData.PaisID);

                model.DropDownListZona = bezona.ToList();
                model.DropDownListZona.Insert(0, new BEZona { ZonaID = 0, Codigo = "-- Todas --" });
                return model.DropDownListZona;
            }
        }

        public JsonResult ObtenterCampaniasyZonasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ZonaModel> lstZonas = DropDownListZonas(PaisID);
            IEnumerable<RegionModel> lstRegiones = DropDownListRegiones(PaisID);

            return Json(new
            {
                DropDownListCampania = lst,
                DropDownListZona = lstZonas.OrderBy(p => p.Codigo),
                DropDownListRegion = lstRegiones.OrderBy(p => p.Codigo),
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2 ? sv.SelectPaises().ToList() : new List<BEPais> { sv.SelectPais(userData.PaisID) };
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

        private List<BEPedidoDDWeb> GetPedidoWebDD(FiltroReportePedidoDDWebModel model)
        {
            AjustarModel(model);
            //if ((string)Session[Constantes.ConstSession.PedidoWebDDConf] == model.UniqueId) return (List<BEPedidoDDWeb>)Session[Constantes.ConstSession.PedidoWebDD];

            //Session[Constantes.ConstSession.PedidoWebDDConf] = model.UniqueId;
            List<BEPedidoDDWeb> list;

            if (model.EsPrimeraBusqueda) return new List<BEPedidoDDWeb>();
            try
            {
                var pedidoDDWebFiltro = Mapper.Map<BEPedidoDDWeb>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    list = sv.GetPedidosWebDDNoFacturados(pedidoDDWebFiltro).ToList();
                }

                var i = 0;
                list.Update(p=>{
                    p.NroRegistro = (i + 1).ToString();
                    p.paisISO = model.CodigoISO;
                    p.TipoProceso = p.OrigenNombre;
                    i++;

                });
           
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                list = new List<BEPedidoDDWeb>();
            }
            //Session[Constantes.ConstSession.PedidoWebDD] = list;
            return list;
        }

        private List<BEPedidoDDWeb> GetPedidoWebDDDetalle(FiltroReportePedidoDDWebModel model)
        {
            AjustarModel(model);
            if ((string)Session[Constantes.ConstSession.PedidoWebDDDetalleConf] == model.UniqueId) return (List<BEPedidoDDWeb>)Session[Constantes.ConstSession.PedidoWebDDDetalle];

            Session[Constantes.ConstSession.PedidoWebDDDetalleConf] = model.UniqueId;
            List<BEPedidoDDWeb> list;
            try
            {
                var pedidoDDWebFiltro = Mapper.Map<BEPedidoDDWeb>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    list = sv.GetPedidosWebDDDetalleConsultora(pedidoDDWebFiltro).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                list = new List<BEPedidoDDWeb>();
            }
            Session[Constantes.ConstSession.PedidoWebDDDetalle] = list;
            return list;
        }

        private void AjustarModel(FiltroReportePedidoDDWebModel model)
        {
            if (model.RegionID == "" || model.RegionID == "-- Todas --") model.RegionID = null;
           
            //if (model.ZonaID == "" || model.ZonaID == "-- Todas --") model.ZonaID = "0";
            //if (model.Consultora == "") model.Consultora = "0";

            if (model.Campania == null) model.EsPrimeraBusqueda = true;
            model.CodigoISO = Util.GetPaisISO(Convert.ToInt32(model.PaisID));
        }

        #endregion

        public bool ExportToCSV<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".csv";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                string nombre = originalFileName;
                var sw = new StringWriter();

                var txtBuilNombre = new StringBuilder();
                var txtBuilCabecera = new StringBuilder();
                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    txtBuilNombre.Append(keyvalue.Key + ",");
                    txtBuilCabecera.Append(keyvalue.Value);
                }
                string csv = CreateCSVTextFile(txtBuilNombre.ToString(), Source);
                sw.WriteLine(txtBuilCabecera.ToString());
                sw.Write(csv);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-Disposition", "attachment; filename=" + nombre);
                var isoEncoding = Encoding.GetEncoding("iso-8859-1");
                HttpContext.Response.Charset = isoEncoding.WebName;
                HttpContext.Response.ContentEncoding = isoEncoding;
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "text/csv";
                HttpContext.Response.Write(sw);
                HttpContext.Response.Flush();
                HttpContext.Response.End();

                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }

        private static string CreateCSVTextFile<T>(string nombreCabecera, List<T> data)
        {
            PropertyInfo[] properties = typeof(T).GetProperties();
            StringBuilder result = new StringBuilder();

            foreach (var row in data)
            {
                var values = properties.Where(x => nombreCabecera.Contains(x.Name))
                                       .Select(p => p.GetValue(row, null))
                                       .Select(v => StringToCSVCell(Convert.ToString(v)));
                var line = string.Join(",", values);
                result.AppendLine(line);
            }

            return result.ToString();
        }

        private static string StringToCSVCell(string str)
        {
            bool mustQuote = (str.Contains(",") || str.Contains("\"") || str.Contains("\r") || str.Contains("\n"));
            if (mustQuote)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("\"");
                foreach (char nextChar in str)
                {
                    sb.Append(nextChar);
                    if (nextChar == '"')
                        sb.Append("\"");
                }
                sb.Append("\"");
                return sb.ToString();
            }

            return str;
        }

    }
}
