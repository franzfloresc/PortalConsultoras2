using AutoMapper;
using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using sc = Portal.Consultoras.Web.ServiceCliente;
using SC = Portal.Consultoras.Web.ServiceCliente;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisPedidosController : BaseController
    {
        readonly PaqueteDocumentarioProvider _paqueteDocumentarioProvider;

        public MisPedidosController()
        {
            _paqueteDocumentarioProvider = new PaqueteDocumentarioProvider();
        }

        public ActionResult Index(bool lanzarTabConsultoraOnline = false)
        {
            var model = new MisPedidosSb2Model();
            var pedidoActual = new BEPedidoWeb();

            try
            {
                List<BEPedidoWeb> listaPedidoFacturados;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaPedidoFacturados = sv.GetPedidosIngresadoFacturado(userData.PaisID, Convert.ToInt32(userData.ConsultoraID), userData.CampaniaID, userData.CodigoConsultora, 6).ToList();
                }
                using (SC.ClienteServiceClient sv = new SC.ClienteServiceClient())
                {
                    model.Clientes = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }

                model.PedidoActual = pedidoActual;

                if (listaPedidoFacturados.Count > 0)
                {
                    listaPedidoFacturados.Update(x =>
                    {
                        x.RutaPaqueteDocumentario = ObtenerRutaPaqueteDocumentario(x.CampaniaID.ToString(), x.NumeroPedido.ToString());
                        x.ImporteTotal = x.ImporteTotal - x.DescuentoProl;
                        x.ImporteCredito = x.ImporteTotal - x.Flete;
                    });
                    model.ListaFacturados = listaPedidoFacturados;
                }
                else model.ListaFacturados = new List<BEPedidoWeb>();

                model.TienePercepcion = userData.CodigoISO == Constantes.CodigosISOPais.Peru;
                model.Simbolo = userData.Simbolo;
                model.UserIso = userData.CodigoISO;

                ServiceUsuario.BEUsuario usuario;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    usuario = sv.Select(userData.PaisID, userData.CodigoUsuario);
                }

                string paisId = usuario.PaisID.ToString();
                string codigoConsultora = userData.GetCodigoConsultora();
                string mostrarAyudaWebTracking = Convert.ToInt32(usuario.MostrarAyudaWebTraking).ToString();
                string paisIso = userData.CodigoISO.Trim();
                string campanhaId = userData.CampaniaID.ToString();

                string url = "/WebPages/WebTracking.aspx?data=" + Util.EncriptarQueryString(paisId, codigoConsultora, mostrarAyudaWebTracking, paisIso, campanhaId);

                ViewBag.URLWebTracking = url;
                ViewBag.PaisISO = userData.CodigoISO;

                string strpaises = _configuracionManagerProvider.GetPaisesConConsultoraOnlineFromConfig();
                model.MostrarClienteOnline = (_configuracionManagerProvider.GetMostrarPedidosPendientesFromConfig() && strpaises.Contains(userData.CodigoISO));
                if (model.MostrarClienteOnline)
                {
                    model.CampaniasConsultoraOnline = new List<CampaniaModel>();
                    for (int i = 0; i <= 4; i++)
                    {
                        model.CampaniasConsultoraOnline.Add(new CampaniaModel { CampaniaID = Util.AddCampaniaAndNumero(userData.CampaniaID, -i, userData.NroCampanias) });
                    }
                    model.CampaniasConsultoraOnline.Update(campania => campania.NombreCorto = campania.CampaniaID.ToString().Substring(0, 4) + "-" + campania.CampaniaID.ToString().Substring(4, 2));
                    model.CampaniaActualConsultoraOnline = userData.CampaniaID;

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        List<BEMotivoSolicitud> motivoSolicitud = sv.GetMotivosRechazo(userData.PaisID).ToList();
                        model.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(motivoSolicitud);
                    }
                    model.LanzarTabClienteOnline = lanzarTabConsultoraOnline;
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        public JsonResult ClienteOnline(int[] campanias)
        {
            int campaniaResultado = 0;

            try
            {
                var listPedidosClienteOnline = new List<BEMisPedidos>();
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    foreach (int campania in campanias)
                    {
                        campaniaResultado = campania;
                        listPedidosClienteOnline = sv.GetMisPedidosClienteOnline(userData.PaisID, userData.ConsultoraID, campania).ToList();
                        if (listPedidosClienteOnline.Count != 0) break;
                    }
                }
                var listModel = Mapper.Map<List<ClienteOnlineModel>>(listPedidosClienteOnline);
                listModel.Update(model =>
                {
                    model.TipoCliente = model.ClienteNuevo ? "NUEVO CLIENTE" : "CLIENTE EXISTENTE";
                    model.Origen = model.MarcaID == 0 ? "App Catálogos" : string.Format("Portal {0}", model.Marca);
                    model.Campania = campaniaResultado.ToString().Substring(0, 4) + "-" + campaniaResultado.ToString().Substring(4, 2);
                    model.FechaSolicitudString = model.FechaSolicitud.ToString("dd \\de MMMM", CultureInfo.GetCultureInfo("es-PE"));
                    model.PrecioTotalString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(model.PrecioTotal, userData.CodigoISO));
                    model.EstadoDesc = model.Estado == "A" ? "Aceptado" : "Cancelado";
                    model.Cliente = Util.ReemplazarSaltoLinea(model.Cliente, " ");
                    model.Direccion = Util.ReemplazarSaltoLinea(model.Direccion, " ");
                    model.Telefono = Util.ReemplazarSaltoLinea(model.Telefono, " ");
                    model.Email = Util.ReemplazarSaltoLinea(model.Email, " ");
                    model.MensajeDelCliente = Util.ReemplazarSaltoLinea(model.MensajeDelCliente, " ");
                });

                return Json(new
                {
                    success = true,
                    message = listModel.Count == 0 ? "No tiene pedidos del App de Catálogos para esta campaña" : "",
                    listaPedidosClienteOnline = listModel,
                    campaniaResultado = campaniaResultado
                });
            }
            catch (FaultException ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }
            catch (Exception ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }

            return Json(new
            {
                success = false,
                message = "Ocurrió un error al intentar cargar la información para esta campaña",
                listaCliente = "",
                campaniaResultado = campaniaResultado
            });
        }

        public JsonResult ClienteOnlineDetalle(long solicitudClienteId)
        {

            try
            {
                List<BEMisPedidosDetalle> listDetallesClienteOnline;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    listDetallesClienteOnline = sv.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, solicitudClienteId).ToList();
                }
                var listModel = Mapper.Map<List<ClienteOnlineDetalleModel>>(listDetallesClienteOnline);
                listModel.Update(model =>
                {
                    model.PrecioUnitarioString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(model.PrecioUnitario.ToDecimal(), userData.CodigoISO));
                    model.PrecioTotalString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(model.PrecioTotal.ToDecimal(), userData.CodigoISO));
                    model.TipoAtencionString = model.TipoAtencion == (int)(Enumeradores.ConsultoraOnlineTipoAtencion.YaTengo) ? Constantes.COTipoAtencionMensaje.YaTengo :
                        (model.TipoAtencion == (int)(Enumeradores.ConsultoraOnlineTipoAtencion.IngresadoPedido) ? Constantes.COTipoAtencionMensaje.IngresadoPedido :
                        (model.TipoAtencion == (int)(Enumeradores.ConsultoraOnlineTipoAtencion.Agotado) ? Constantes.COTipoAtencionMensaje.Agotado : ""));
                });

                return Json(new
                {
                    success = true,
                    message = "",
                    listaDetallesClienteOnline = listModel
                });
            }
            catch (FaultException ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }
            catch (Exception ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }

            return Json(new
            {
                success = false,
                message = "Ocurrió un error al intentar cargar el detalle de este cliente online.",
                listaCliente = ""
            });
        }

        public JsonResult ClienteOnlineCancelarSolicitud(int solicitudClienteId, int? motivoSolicitudId, string razonMotivoSolicitud)
        {
            try
            {
                using (SACServiceClient sc = new SACServiceClient())
                {
                    sc.CancelarSolicitudClienteYRemoverPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.CodigoConsultora, solicitudClienteId, motivoSolicitudId ?? 0, razonMotivoSolicitud);
                }

                BarraConsultoraModel dataBarra = new BarraConsultoraModel();
                try
                {
                    SessionManager.SetObservacionesProl(null);
                    SessionManager.SetDetallesPedido(null);
                    SessionManager.SetDetallesPedidoSetAgrupado(null);
                    UpdPedidoWebMontosPROL();
                    dataBarra = GetDataBarra();
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                return Json(new { success = true, message = "", dataBarra = dataBarra });
            }
            catch (FaultException ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userModel.CodigoConsultora, userModel.CodigoISO);
                return Json(new { success = false, message = ex.Message });
            }
            catch (Exception ex)
            {
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }

            return Json(new
            {
                success = false,
                message = "Ocurrió un error al intentar cancelar la solicitud."
            });
        }

        public string ObtenerRutaPaqueteDocumentario(string campania, string numeroPedido)
        {
            var lstRVPRFModel = _paqueteDocumentarioProvider.GetListPaqueteDocumentario(userData.GetCodigoConsultora(), campania, numeroPedido, userData.CodigoISO);
            return lstRVPRFModel.Count == 1 ? lstRVPRFModel[0].Ruta : "";
        }

        public string ObtenerFormatoFecha(DateTime fecha)
        {
            var dia = fecha.Day;
            var mes = fecha.Month;

            var resultado = dia + Util.NombreMes(mes);

            return resultado;
        }

        #region excel
        public ActionResult ExportarExcel(string vCampaniaID, string vClienteID)
        {
            List<SC.BEPedidoWebDetalle> lstCabecera;
            using (SC.ClienteServiceClient sv = new SC.ClienteServiceClient())
            {
                lstCabecera = sv.GetClientesByCampaniaByClienteID(userData.PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId(), vClienteID).OrderBy(p => p.Nombre).ToList();
            }

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();
            List<SC.BEPedidoWebDetalle> lstDetalles = new List<SC.BEPedidoWebDetalle>();
            foreach (SC.BEPedidoWebDetalle item in lstCabecera)
            {
                List<SC.BEPedidoWebDetalle> lstDetallesTemp;
                using (SC.ClienteServiceClient sv = new SC.ClienteServiceClient())
                {
                    lstDetallesTemp = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId(), item.ClienteID).ToList();
                }

                decimal suma = lstDetallesTemp.Sum(p => p.ImporteTotal);
                dicCabeceras.Add(new KeyValuePair<int, string>(lstDetallesTemp.Count, item.Nombre));
                lstDetallesTemp.Add(new SC.BEPedidoWebDetalle() { ImporteTotalPedido = suma });
                lstDetalles.AddRange(lstDetallesTemp);
            }

            Dictionary<string, string> dicDetalles = new Dictionary<string, string>
            {
                {"Código", "CUV"},
                {"Descripción", "DescripcionProd"},
                {"Cantidad", "Cantidad"},
                {"Precio Unit.", userData.Simbolo + " #PrecioUnidad"},
                {"Precio Total", userData.Simbolo + " #ImporteTotal"}
            };

            string[] arrTotal = { "Total:", userData.Simbolo + " #ImporteTotalPedido" };

            ExportToExcelMultiple("PedidosWebExcel", lstDetalles, dicCabeceras, dicDetalles, arrTotal);
            return new EmptyResult();
        }

        private void ExportToExcelMultiple(string filename, List<SC.BEPedidoWebDetalle> sourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
           Dictionary<string, string> columnDetailDefinition, string[] arrTotal)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();

                int row = 6;
                int col = 0;

                ws.Cell(1, 1).Value = "Código Consultora: " + userData.CodigoConsultora;
                ws.Range(string.Format("A{0}:E{1}", 1, 1)).Row(1).Merge();
                ws.Cell(1, 1).Style.Font.Bold = true;

                ws.Cell(2, 1).Value = "Nombre Consultora: " + userData.NombreConsultora;
                ws.Range(string.Format("A{0}:E{1}", 2, 2)).Row(1).Merge();
                ws.Cell(2, 1).Style.Font.Bold = true;

                ws.Cell(3, 1).Value = "Dirección: " + userData.Direccion;
                ws.Range(string.Format("A{0}:E{1}", 3, 3)).Row(1).Merge();
                ws.Cell(3, 1).Style.Font.Bold = true;

                ws.Cell(4, 1).Value = "Zona: " + userData.CodigoZona;
                ws.Range(string.Format("A{0}:E{1}", 4, 4)).Row(1).Merge();
                ws.Cell(4, 1).Style.Font.Bold = true;

                decimal totalPedido = 0;
                string simbolo = userData.Simbolo;

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
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#863A9A");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    var i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in columns)
                        {
                            SC.BEPedidoWebDetalle source = sourceDetails[i];

                            var arr = column.Contains("#") ? column.Split('#') : new string[] { "", column };
                            string value =
                                  arr[1] == "CUV" ? source.CUV
                                : arr[1] == "DescripcionProd" ? source.DescripcionProd
                                : arr[1] == "Cantidad" ? source.Cantidad.ToString()
                                : arr[1] == "ImporteTotal" ? Util.DecimalToStringFormat(source.ImporteTotal, userData.CodigoISO)
                                : arr[1] == "PrecioUnidad" ? Util.DecimalToStringFormat(source.PrecioUnidad, userData.CodigoISO)
                                : "";
                            if (value == "")
                            {
                                col++;
                                continue;
                            }

                            ws.Cell(row, col).Style.NumberFormat.Format =
                                arr[1] == "CUV" || arr[1] == "DescripcionProd" || arr[1] == "Cantidad" ? "@"
                                : ws.Cell(row, col).Style.NumberFormat.Format;

                            ws.Cell(row, col).Value = arr[0] + value;
                            ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
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

                        decimal importT = sourceDetails[i].ImporteTotalPedido;
                        string importeTotalPedido = Util.DecimalToStringFormat(importT, userData.CodigoISO);

                        ws.Cell(row, col - 2).Value = arrTotal[0];
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] + importeTotalPedido;
                        totalPedido += importT;
                    }
                    row++;
                    var index = keyvalue.Key + 1;
                    sourceDetails.RemoveRange(0, index);
                }

                string importeTotalFinal = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO);

                ws.Cell(row + 1, col - 2).Value = "Monto Total: ";
                ws.Cell(row + 1, col - 2).Style.Font.Bold = true;
                ws.Cell(row + 1, col - 1).Value = simbolo + " " + importeTotalFinal;
                ws.Cell(row + 1, col - 1).Style.Font.Bold = true;

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

        public ActionResult ExportarExcelFacturado(string vCampaniaID, string vTotalParcial, string vFlete, string vTotalFacturado, int vPedidoId)
        {
            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();
            List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();
            List<BEPedidoFacturado> lista;
            try
            {
                using (SACServiceClient client = new SACServiceClient())
                {
                    lista = client.GetPedidosFacturadosDetalle(userData.PaisID, vCampaniaID, "0", "0", userData.CodigoConsultora, vPedidoId).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                lista = null;
            }

            lista = lista ?? new List<BEPedidoFacturado>();

            foreach (var item in lista)
            {
                if (!string.IsNullOrEmpty(item.CUV))
                {
                    lst.Add(new BEPedidoWebDetalle()
                    {
                        CUV = item.CUV.Trim(),
                        DescripcionProd = item.Descripcion,
                        Cantidad = item.Cantidad,
                        PrecioUnidad = Convert.ToDecimal(item.PrecioUnidad),
                        ImporteTotal = Convert.ToDecimal(item.ImporteTotal),
                        ImporteTotalPedido = Convert.ToDecimal(item.MontoDescuento),
                    });
                }
            }

            dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, userData.NombreConsultora));

            Dictionary<string, string> dicDetalles = new Dictionary<string, string>
            {
                {"Código", "CUV"},
                {"Descripción", "DescripcionProd"},
                {"Cantidad", "Cantidad"},
                {"Precio Unitario", userData.Simbolo + " #PrecioUnidad"},
                {"Total", userData.Simbolo + " #ImporteTotal"},
                {"Descuento", userData.Simbolo + " #Descuento"},
                {"Importe a Pagar", userData.Simbolo + " #ImportePagar"}
            };

            //string[] arrTotal = { "Importe Total:", " #CodigoUsuarioCreacion", "Flete:", " #CodigoUsuarioModificacion", "Total Facturado:", " #Mensaje", };

            ExportToExcelMultipleFacturado("PedidosWebExcel", lst, dicCabeceras, dicDetalles, vTotalParcial, vFlete, vTotalFacturado);
            return new EmptyResult();
        }

        private void ExportToExcelMultipleFacturado(string filename, List<BEPedidoWebDetalle> sourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
            Dictionary<string, string> columnDetailDefinition, string vTotalParcial, string vFlete, string vTotalFacturado)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();

                int row = 5;
                int col = 0;

                ws.Cell(1, 1).Value = "Código Consultora: " + userData.CodigoConsultora;
                ws.Range(string.Format("A{0}:E{1}", 1, 1)).Row(1).Merge();
                ws.Cell(1, 1).Style.Font.Bold = true;

                ws.Cell(2, 1).Value = "Nombre Consultora: " + userData.NombreConsultora;
                ws.Range(string.Format("A{0}:E{1}", 2, 2)).Row(1).Merge();
                ws.Cell(2, 1).Style.Font.Bold = true;

                ws.Cell(3, 1).Value = "Dirección: " + userData.Direccion;
                ws.Range(string.Format("A{0}:E{1}", 3, 3)).Row(1).Merge();
                ws.Cell(3, 1).Style.Font.Bold = true;

                ws.Cell(4, 1).Value = "Zona: " + userData.CodigoZona;
                ws.Range(string.Format("A{0}:E{1}", 4, 4)).Row(1).Merge();
                ws.Cell(4, 1).Style.Font.Bold = true;

                string simbolo = userData.Simbolo;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
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
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#863A9A");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    var i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in columns)
                        {
                            BEPedidoWebDetalle source = sourceDetails[i];
                            string[] arr = column.Contains("#") ? column.Split('#') : new string[] { "", column };

                            string value =
                                  arr[1] == "CUV" ? source.CUV
                                : arr[1] == "DescripcionProd" ? source.DescripcionProd
                                : arr[1] == "Cantidad" ? source.Cantidad.ToString()
                                : arr[1] == "ImporteTotal" ? Util.DecimalToStringFormat(source.ImporteTotal, userData.CodigoISO)
                                : arr[1] == "PrecioUnidad" ? Util.DecimalToStringFormat(source.PrecioUnidad, userData.CodigoISO)
                                : arr[1] == "Descuento" ? Util.DecimalToStringFormat(source.ImporteTotalPedido, userData.CodigoISO)
                                : arr[1] == "ImportePagar" ? Util.DecimalToStringFormat(source.ImporteTotal - source.ImporteTotalPedido, userData.CodigoISO)
                                : "";

                            if (value == "")
                            {
                                col++;
                                continue;
                            }

                            ws.Cell(row, col).Style.NumberFormat.Format =
                                arr[1] == "CUV" || arr[1] == "DescripcionProd" || arr[1] == "Cantidad" ? "@"
                                : ws.Cell(row, col).Style.NumberFormat.Format;

                            ws.Cell(row, col).Value = arr[0] + value;
                            ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");

                            col++;
                        }
                        row++;
                        i++;
                    }
                    row++;
                }

                ws.Cell(row + 1, col - 2).Value = "Importe Total: ";
                ws.Cell(row + 1, col - 2).Style.Font.Bold = true;
                ws.Cell(row + 1, col - 1).Value = simbolo + " " + vTotalParcial.Trim();
                ws.Cell(row + 1, col - 1).Style.Font.Bold = true;

                ws.Cell(row + 2, col - 2).Value = "Flete: ";
                ws.Cell(row + 2, col - 2).Style.Font.Bold = true;
                ws.Cell(row + 2, col - 1).Value = simbolo + " " + vFlete.Trim();
                ws.Cell(row + 2, col - 1).Style.Font.Bold = true;

                ws.Cell(row + 3, col - 2).Value = "Total Facturado: ";
                ws.Cell(row + 3, col - 2).Style.Font.Bold = true;
                ws.Cell(row + 3, col - 1).Value = simbolo + " " + vTotalFacturado.Trim();
                ws.Cell(row + 3, col - 1).Style.Font.Bold = true;

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
                UsuarioModel userModel = userData ?? new UsuarioModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userModel.CodigoConsultora, userModel.CodigoISO);
            }
        }

        #endregion

        #region Detalle Campaña

        public ActionResult ConsultarPedidoWebDetallePorCamania(string sidx, string sord, int page, int rows, string CampaniaId)
        {
            List<BEPedidoWebDetalle> lst = GetDetallePorEstado(CampaniaId, "i", 0);
            List<BEPedidoWebDetalle> items = new List<BEPedidoWebDetalle>();
            foreach (var item in lst)
            {
                var existe = items.Any(p => p.ClienteID == item.ClienteID);
                if (existe) continue;
                var itemx = new BEPedidoWebDetalle
                {
                    ClienteID = item.ClienteID,
                    Nombre = item.Nombre,
                    eMail = item.eMail,
                    Cantidad = lst.Where(p => p.ClienteID == item.ClienteID).Sum(p => p.Cantidad),
                    ImporteTotal = lst.Where(p => p.ClienteID == item.ClienteID).Sum(p => p.ImporteTotal)
                };

                items.Add(itemx);
            }

            BEGrid grid = new BEGrid(sidx, sord, page, rows);

            BEPager pag = Util.PaginadorGenerico(grid, items);
            var importeTotal = Util.DecimalToStringFormat(items.Sum(p => p.ImporteTotal), userData.CodigoISO);
            var data = new
            {
                CampaniaId,

                pag.PageCount,
                pag.CurrentPage,
                pag.RecordCount,
                grid.PageSize,

                userData.Simbolo,
                CantidadCliente = items.Count,
                CantidadProducto = items.Sum(p => p.Cantidad),
                SubTotal = importeTotal,
                OfertaNiveles = Util.DecimalToStringFormat(0, userData.CodigoISO),
                ImporteTotal = importeTotal,
                Rows = items.Select(a => new
                {
                    userData.Simbolo,
                    CampaniaId,
                    pag.CurrentPage,
                    pag.PageCount,
                    a.Nombre,
                    a.ClienteID,
                    a.Cantidad,
                    ImporteTotal = Util.DecimalToStringFormat(a.ImporteTotal, userData.CodigoISO)
                })
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ConsultarPedidoWebDetallePorCamaniaPorCliente(string sidx, string sord, int page, int rows, string CampaniaId, int cliente, string estado, int pedidoId)
        {
            BEGrid grid = new BEGrid(sidx, sord, page, rows);

            List<BEPedidoWebDetalle> lst = GetDetallePorEstado(CampaniaId, estado, pedidoId);
            var pedidoWeb = lst.Any() ? lst[0] : new BEPedidoWebDetalle();

            var listaCliente = (from item in lst
                                select new ServiceCliente.BECliente { ClienteID = item.ClienteID, Nombre = string.IsNullOrEmpty(item.Nombre) ? userData.NombreConsultora : item.Nombre }
                    ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();

            List<BEPedidoWebDetalle> itemCliente = lst.Where(p => p.ClienteID == cliente || cliente == -1).ToList();
            BEPager pag = Util.PaginadorGenerico(grid, itemCliente);

            List<BEPedidoWebDetalle> items = itemCliente.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();

            var totalpedido = itemCliente.Sum(p => p.ImporteTotal);
            var montoConDescto = cliente == -1 ? totalpedido - pedidoWeb.DescuentoProl : totalpedido;
            var importeTotal = Util.DecimalToStringFormat(totalpedido, userData.CodigoISO);
            var montoConDesctoString = Util.DecimalToStringFormat(montoConDescto, userData.CodigoISO);
            var itm = items.FirstOrDefault() ?? new BEPedidoWebDetalle();
            var data = new
            {
                pedidoId,
                tipo = estado.ToLower(),
                ClienteID = cliente,
                Nombre = cliente == -1 ? "" : itm.Nombre,
                CampaniaId,
                userData.NombreConsultora,

                pag.PageCount,
                pag.CurrentPage,
                pag.RecordCount,
                grid.PageSize,

                userData.Simbolo,

                CantidadProducto = itemCliente.Sum(p => p.Cantidad),
                ImporteTotal = importeTotal,
                ImporteFlete = Util.DecimalToStringFormat(0, userData.CodigoISO),
                OfertaNiveles = Util.DecimalToStringFormat(pedidoWeb.DescuentoProl, userData.CodigoISO),
                ImporteFacturado = montoConDesctoString,
                Ganancia = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroCatalogo + pedidoWeb.MontoAhorroRevista, userData.CodigoISO),
                Rows = items.Select(a => new
                {
                    tipo = estado.ToLower(),
                    userData.Simbolo,
                    a.CUV,
                    a.DescripcionProd,
                    a.Cantidad,
                    PrecioUnidad = Util.DecimalToStringFormat(a.PrecioUnidad, userData.CodigoISO),
                    ImporteTotal = Util.DecimalToStringFormat(a.ImporteTotal, userData.CodigoISO),
                    MontoEscala = Util.DecimalToStringFormat(a.ImporteTotalPedido, userData.CodigoISO),
                    ImportePagar = Util.DecimalToStringFormat(a.ImporteTotal - a.ImporteTotalPedido, userData.CodigoISO),
                    a.NombreCliente
                }),
                listaCliente
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        private List<BEPedidoWebDetalle> GetDetallePorEstado(string campaniaId, string estado, int pedidoId)
        {
            List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();

            var listx = Session["MisPedidos-DetallePorCampania"];
            string campSes = (string)Session["MisPedidos-DetallePorCampania-Campania"];
            string estadoCombo = (string)Session["MisPedidos-DetallePorCampania-Estado"];
            int pedidoIdSesion = (int)(Session["MisPedidos-DetallePorCampania-PedidoId"] ?? 0);

            if (!(listx == null || campSes == null || campSes != campaniaId || estadoCombo == null || estadoCombo != estado || pedidoIdSesion != pedidoId))
            {
                lst = (List<BEPedidoWebDetalle>)listx;
                return lst;
            }
            estado = (estado ?? "").Trim().ToLower();
            if (estado == "i")
            {
                #region ingresado

                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                {
                    PaisId = userData.PaisID,
                    CampaniaId = int.Parse(campaniaId),
                    ConsultoraId = ObtenerConsultoraId(),
                    Consultora = userData.NombreConsultora,
                    EsBpt = EsOpt() == 1,
                    CodigoPrograma = userData.CodigoPrograma,
                    NumeroPedido = userData.ConsecutivoNueva
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                }
                lst.Update(c => c.NombreCliente = string.IsNullOrEmpty(c.Nombre) ? userData.NombreConsultora : c.Nombre);
                #endregion
            }

            else if (estado == "f")
            {
                #region facturado
                List<BEPedidoFacturado> lista;
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosDetalle(userData.PaisID, campaniaId, "0", "0", userData.CodigoConsultora, pedidoId).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    lista = new List<BEPedidoFacturado>();
                }

                foreach (var pedido in lista)
                {
                    pedido.CUV = Util.Trim(pedido.CUV);
                    pedido.Descripcion = Util.Trim(pedido.Descripcion);

                    if (pedido.CUV.Trim() == "" || pedido.Descripcion.Trim() == "")
                    {
                        continue;
                    }

                    lst.Add(new BEPedidoWebDetalle
                    {
                        CUV = pedido.CUV,
                        DescripcionProd = pedido.Descripcion,
                        Cantidad = pedido.Cantidad,
                        PrecioUnidad = pedido.PrecioUnidad,
                        ImporteTotal = pedido.ImporteTotal,
                        ImporteTotalPedido = pedido.MontoDescuento,
                        NombreCliente = ""
                    });
                }
                lst.Update(c => c.NombreCliente = string.IsNullOrEmpty(c.Nombre) ? userData.NombreConsultora : c.Nombre);
                #endregion
            }

            Session["MisPedidos-DetallePorCampania"] = lst;
            Session["MisPedidos-DetallePorCampania-Campania"] = campaniaId;
            Session["MisPedidos-DetallePorCampania-Estado"] = estado;
            Session["MisPedidos-DetallePorCampania-PedidoId"] = pedidoId;

            return lst;
        }

        public long ObtenerConsultoraId()
        {
            long consultoraIdmetodo;
            if (userData.UsuarioPrueba == 1)
            {
                using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
                {
                    consultoraIdmetodo = sv.GetConsultoraIdByCodigo(userData.PaisID, userData.ConsultoraAsociada);
                }
            }
            else
            {
                consultoraIdmetodo = userData.ConsultoraID;
            }
            return consultoraIdmetodo;
        }
        #endregion
    }
}
