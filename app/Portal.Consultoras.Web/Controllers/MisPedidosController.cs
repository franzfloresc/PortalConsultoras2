using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using sc =  Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using SC = Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceUsuario;
using AutoMapper;
using System.Globalization;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisPedidosController : BaseController
    {
        public ActionResult Index(bool lanzarTabConsultoraOnline = false)
        {
            var model = new MisPedidosSb2Model();
            var pedidoActual = new BEPedidoWeb();
            var listaPedidoFacturados = new List<BEPedidoWeb>();

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    //pedidoActual = sv.GetPedidosWebByConsultoraCampania(userData.PaisID, Convert.ToInt32(userData.ConsultoraID), userData.CampaniaID);
                    listaPedidoFacturados = sv.GetPedidosIngresadoFacturado(userData.PaisID, Convert.ToInt32(userData.ConsultoraID), userData.CampaniaID).ToList();
                }
                using (sc.ClienteServiceClient sv = new sc.ClienteServiceClient())
                {
                    model.Clientes = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }

                listaPedidoFacturados = listaPedidoFacturados ?? new List<BEPedidoWeb>();

                model.PedidoActual = pedidoActual ?? new BEPedidoWeb();

                if (listaPedidoFacturados.Count > 0)
                {
                    listaPedidoFacturados.Update(x => {
                        x.RutaPaqueteDocumentario = ObtenerRutaPaqueteDocumentario(x.CampaniaID);
                        x.ImporteCredito = x.ImporteTotal - x.Flete; 
                    });
                    model.ListaFacturados = listaPedidoFacturados;
                }
                else model.ListaFacturados = new List<BEPedidoWeb>();

                model.TienePercepcion = userData.CodigoISO == Constantes.CodigosISOPais.Peru;
                model.Simbolo = userData.Simbolo;
                model.UserIso = userData.CodigoISO;
                
                BEUsuario usuario;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    usuario = sv.Select(UserData().PaisID, UserData().CodigoUsuario);
                }

                string paisID = usuario.PaisID.ToString();
                string codigoConsultora = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : usuario.CodigoConsultora;
                string mostrarAyudaWebTracking = Convert.ToInt32(usuario.MostrarAyudaWebTraking).ToString();
                string paisISO = UserData().CodigoISO.Trim();
                string campanhaID = UserData().CampaniaID.ToString();

                string url = "/WebPages/WebTracking.aspx?data=" + Util.EncriptarQueryString(paisID, codigoConsultora, mostrarAyudaWebTracking, paisISO, campanhaID);

                ViewBag.URLWebTracking = url;
                ViewBag.PaisISO = userData.CodigoISO;

                string mostrarPedidosPendientes = ConfigurationManager.AppSettings.Get("MostrarPedidosPendientes");
                string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
                model.MostrarClienteOnline = (mostrarPedidosPendientes == "1" && strpaises.Contains(userData.CodigoISO));
                if (model.MostrarClienteOnline)
                {
                    model.CampaniasConsultoraOnline = new List<CampaniaModel>(model.ListaFacturados.Select (
                        facturado => new CampaniaModel
                        {
                            CampaniaID = facturado.CampaniaID,
                            NombreCorto = facturado.CampaniaID.ToString().Substring(0, 4) + "-" + facturado.CampaniaID.ToString().Substring(4, 2)
                        }
                    ));
                    if (!model.CampaniasConsultoraOnline.Any(cco => cco.CampaniaID == userData.CampaniaID))
                    {
                        model.CampaniasConsultoraOnline.Insert(0,new CampaniaModel{
                            CampaniaID = userData.CampaniaID,
                            NombreCorto = userData.CampaniaID.ToString().Substring(0, 4) + "-" + userData.CampaniaID.ToString().Substring(4, 2)
                        });
                    }
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
        public JsonResult ClienteOnline(int campania)
        {
            var listPedidosClienteOnline = new List<BEMisPedidos>();
            var listModel = new List<ClienteOnlineModel>();

            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    listPedidosClienteOnline = sv.GetMisPedidosClienteOnline(userData.PaisID, userData.ConsultoraID, campania).ToList();
                    if (listPedidosClienteOnline == null || listPedidosClienteOnline.Count == 0)
                    {
                        campania = AddCampaniaAndNumero(campania, -1);
                        listPedidosClienteOnline = sv.GetMisPedidosClienteOnline(userData.PaisID, userData.ConsultoraID, campania).ToList();
                    }
                }
                listModel = Mapper.Map<List<ClienteOnlineModel>>(listPedidosClienteOnline);
                listModel.Update(model => {
                    model.TipoCliente = model.ClienteNuevo ? "CLIENTE NUEVO" : "CLIENTE EXISTENTE";
                    model.Origen = model.MarcaID == 0 ? "App Catálogos" : string.Format("Portal {0}", model.Marca);
                    model.Campania = campania.ToString();
                    model.CampaniaDescripcion = campania.ToString().Substring(0, 4) + "-" + campania.ToString().Substring(4, 2);
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
                    message = listModel.Count == 0 ? "No tiene pedidos de Consultora Online para esta campaña, con el filtro en la campaña actual." : "",
                    listaPedidosClienteOnline = listModel
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
                listaCliente = ""
            });
        }
        public JsonResult ClienteOnlineDetalle(int solicitudClienteId)
        {
            var listDetallesClienteOnline = new List<BEMisPedidosDetalle>();
            var listModel = new List<ClienteOnlineDetalleModel>();

            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    listDetallesClienteOnline = sv.GetMisPedidosDetalleConsultoraOnline(userData.PaisID, solicitudClienteId).ToList();
                }
                listModel = Mapper.Map<List<ClienteOnlineDetalleModel>>(listDetallesClienteOnline);
                listModel.Update(model =>
                {
                    model.PrecioUnitarioString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(model.PrecioUnitario.ToDecimal(), userData.CodigoISO));
                    model.PrecioTotalString = string.Format("{0} {1}", userData.Simbolo, Util.DecimalToStringFormat(model.PrecioTotal.ToDecimal(), userData.CodigoISO));
                    model.TipoAtencionString = model.TipoAtencion == 2 ? "Ya lo tengo" : (model.TipoAtencion == 1 ? "Ingresado al Pedido" : "Agotado");
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
            var listDetallesClienteOnline = new List<BEMisPedidosDetalle>();
            var listModel = new List<ClienteOnlineDetalleModel>();
            try
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    sc.CancelarSolicitudClienteYRemoverPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.CodigoConsultora, solicitudClienteId, motivoSolicitudId ?? 0, razonMotivoSolicitud);
                }

                try
                {
                    Session["ObservacionesPROL"] = null;
                    Session["PedidoWebDetalle"] = null;
                    UpdPedidoWebMontosPROL();
                }
                catch { }

                return Json(new { success = true, message = "" });
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

        public string ObtenerRutaPaqueteDocumentario(int campaniaId)
        {
            var complain = new RVDWebCampaniasParam
            {
                Pais = userData.CodigoISO,
                Tipo = "1",
                CodigoConsultora = ((userData.UsuarioPrueba == 1) ? userData.ConsultoraAsociada : userData.CodigoConsultora),
                Campana = campaniaId.ToString()
            };
            List<RVPRFModel> lstRVPRFModel = new List<RVPRFModel>();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string output = serializer.Serialize(complain);

            string strUri = ConfigurationManager.AppSettings["WS_RV_PDF_NEW"];
            Uri uri = new Uri(strUri);
            WebRequest request = WebRequest.Create(uri);
            request.Method = "POST";
            request.ContentType = "application/json; charset=utf-8";

            using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
            {
                writer.Write(output);
            }

            WebResponse responce = request.GetResponse();
            Stream reader = responce.GetResponseStream();
            StreamReader sReader = new StreamReader(reader);
            string outResult = sReader.ReadToEnd();
            sReader.Close();

            JavaScriptSerializer json_serializer = new JavaScriptSerializer();

            WrapperPDFWeb st = json_serializer.Deserialize<WrapperPDFWeb>(outResult);

            if (st != null)
            {
                if (st.GET_URLResult != null)
                {
                    if (st.GET_URLResult.errorCode == "00000" || st.GET_URLResult.errorMessage == "OK")
                    {
                        //R20150906
                        if (st.GET_URLResult.objeto != null && st.GET_URLResult.objeto.Count != 0)
                        {
                            foreach (var item in st.GET_URLResult.objeto)
                            {
                                lstRVPRFModel.Add(new RVPRFModel() { Nombre = "Paquete Documentario", FechaFacturacion = item.fechaFacturacion, Ruta = Convert.ToString(item.url) });
                            }
                        }
                    }
                }
            }

            string resultado = "";

            if (lstRVPRFModel.Count > 0)
            {
                resultado = lstRVPRFModel[0].Ruta;
            }

            return resultado;
        }

        public string ObtenerFormatoFecha(DateTime fecha)
        {
            string resultado = "";

            var dia = fecha.Day;
            var mes = fecha.Month;

            resultado = dia + NombreMes(mes);

            return resultado;
        }

        #region excel
        public ActionResult ExportarExcel(string vCampaniaID)
        {
            List<SC.BEPedidoWebDetalle> lstCabecera;
            using (SC.ClienteServiceClient sv = new SC.ClienteServiceClient())
            {
                lstCabecera = sv.GetClientesByCampania(userData.PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId()).OrderBy(p => p.Nombre).ToList();
            }

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();
            List<SC.BEPedidoWebDetalle> lstDetalles = new List<SC.BEPedidoWebDetalle>();
            List<SC.BEPedidoWebDetalle> lstDetallesTemp;
            foreach (SC.BEPedidoWebDetalle item in lstCabecera)
            {
                using (SC.ClienteServiceClient sv = new SC.ClienteServiceClient())
                {
                    lstDetallesTemp = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId(), item.ClienteID).ToList();
                }

                decimal suma = lstDetallesTemp.Sum(p => p.ImporteTotal);
                dicCabeceras.Add(new KeyValuePair<int, string>(lstDetallesTemp.Count, item.Nombre));
                lstDetallesTemp.Add(new SC.BEPedidoWebDetalle() { ImporteTotalPedido = suma });
                lstDetalles.AddRange((List<SC.BEPedidoWebDetalle>)lstDetallesTemp);
            }

            Dictionary<string, string> dicDetalles = new Dictionary<string, string>();
            dicDetalles.Add("Código", "CUV");
            dicDetalles.Add("Descripción", "DescripcionProd");
            dicDetalles.Add("Cantidad", "Cantidad");
            dicDetalles.Add("Precio Unit.", userData.Simbolo + " #PrecioUnidad");
            dicDetalles.Add("Precio Total", userData.Simbolo + " #ImporteTotal");

            string[] arrTotal = { "Total:", userData.Simbolo + " #ImporteTotalPedido" };

            ExportToExcelMultiple("PedidosWebExcel", lstDetalles, dicCabeceras, dicDetalles, arrTotal);
            return View();
        }

        private void ExportToExcelMultiple(string filename, List<SC.BEPedidoWebDetalle> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
           Dictionary<string, string> columnDetailDefinition, string[] arrTotal)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                int row = 6;
                int col = 0;
                int i = 0;

                int col2 = 1;

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

                decimal TotalPedido = 0;
                string Simbolo = userData.Simbolo;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    //Establece las columnas
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
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#863A9A");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in Columns) // itera las columnas del detalle
                        {
                            //Establece el valor para esa columna
                            SC.BEPedidoWebDetalle source = SourceDetails[i];

                            string[] arr = new string[2];
                            arr = column.Contains("#") ? column.Split('#') : new string[] { "", column };
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

                        decimal importT = ((SC.BEPedidoWebDetalle)SourceDetails[i]).ImporteTotalPedido;
                        string importeTotalPedido = Util.DecimalToStringFormat(importT, userData.CodigoISO);

                        ws.Cell(row, col - 2).Value = arrTotal[0]; //Total:
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] + importeTotalPedido;
                        TotalPedido += importT;
                    }
                    row++;
                    index = keyvalue.Key + 1;
                    SourceDetails.RemoveRange(0, index);
                }

                string importeTotalFinal = Util.DecimalToStringFormat(TotalPedido, userData.CodigoISO);

                ws.Cell(row + 1, col - 2).Value = "Monto Total: ";
                ws.Cell(row + 1, col - 2).Style.Font.Bold = true;
                ws.Cell(row + 1, col - 1).Value = Simbolo + " " + importeTotalFinal;
                ws.Cell(row + 1, col - 1).Style.Font.Bold = true;

                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                //HttpContext.Current.Response.SetCookie("Cache-Control", "private");
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                //HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
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
        
        public ActionResult ExportarExcelFacturado(string vCampaniaID, string vTotalParcial, string vFlete, string vTotalFacturado)
        {
            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();
            List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();
            List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
            try
            {
                using (SACServiceClient client = new SACServiceClient())
                {
                    lista = client.GetPedidosFacturadosDetalle(userData.PaisID, vCampaniaID, "0", "0", userData.CodigoConsultora).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                lista = null;
            }

            foreach (var item in lista)
            {
                if (!string.IsNullOrEmpty(item.CUV.Trim()))
                {
                    lst.Add(new BEPedidoWebDetalle()
                    {
                        CUV = item.CUV,
                        DescripcionProd = item.Descripcion,
                        Cantidad = item.Cantidad,
                        PrecioUnidad = Convert.ToDecimal(item.PrecioUnidad),
                        ImporteTotal = Convert.ToDecimal(item.ImporteTotal),
                        ImporteTotalPedido = Convert.ToDecimal(item.MontoDescuento),
                    });
                }
            }

            dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, userData.NombreConsultora));

            Dictionary<string, string> dicDetalles = new Dictionary<string, string>();
            dicDetalles.Add("Código", "CUV");
            dicDetalles.Add("Descripción", "DescripcionProd");
            dicDetalles.Add("Cantidad", "Cantidad");
            dicDetalles.Add("Precio Unitario", userData.Simbolo + " #PrecioUnidad");
            dicDetalles.Add("Total", userData.Simbolo + " #ImporteTotal");
            dicDetalles.Add("Descuento", userData.Simbolo + " #Descuento");
            dicDetalles.Add("Importe a Pagar", userData.Simbolo + " #ImportePagar");

            string[] arrTotal = { "Importe Total:", " #CodigoUsuarioCreacion", "Flete:", " #CodigoUsuarioModificacion", "Total Facturado:", " #Mensaje", };

            ExportToExcelMultipleFacturado("PedidosWebExcel", lst, dicCabeceras, dicDetalles, arrTotal, vTotalParcial, vFlete, vTotalFacturado);
            return View();
        }

        private void ExportToExcelMultipleFacturado(string filename, List<BEPedidoWebDetalle> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
            Dictionary<string, string> columnDetailDefinition, string[] arrTotal, string vTotalParcial, string vFlete, string vTotalFacturado)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();

                int row = 5;
                int col = 0;
                int i = 0;

                int col2 = 1;

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

                //decimal TotalPedido = 0;
                string Simbolo = userData.Simbolo;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
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
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#863A9A");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in Columns) // itera las columnas del detalle
                        {
                            //Establece el valor para esa columna
                            BEPedidoWebDetalle source = SourceDetails[i];
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
                ws.Cell(row + 1, col - 1).Value = Simbolo + " " + vTotalParcial.Trim();
                ws.Cell(row + 1, col - 1).Style.Font.Bold = true;

                ws.Cell(row + 2, col - 2).Value = "Flete: ";
                ws.Cell(row + 2, col - 2).Style.Font.Bold = true;
                ws.Cell(row + 2, col - 1).Value = Simbolo + " " + vFlete.Trim();
                ws.Cell(row + 2, col - 1).Style.Font.Bold = true;

                ws.Cell(row + 3, col - 2).Value = "Total Facturado: ";
                ws.Cell(row + 3, col - 2).Style.Font.Bold = true;
                ws.Cell(row + 3, col - 1).Value = Simbolo + " " + vTotalFacturado.Trim();
                ws.Cell(row + 3, col - 1).Style.Font.Bold = true;

                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                //HttpContext.Current.Response.SetCookie("Cache-Control", "private");
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                //HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
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

        #endregion

        #region Detalle Campaña

        public ActionResult ConsultarPedidoWebDetallePorCamania(string sidx, string sord, int page, int rows, string CampaniaId)
        {
            List<BEPedidoWebDetalle> lst = GetDetallePorEstado(CampaniaId, "i");
            List<BEPedidoWebDetalle> items = new List<BEPedidoWebDetalle>();
            var existe = false;
            foreach (var item in lst)
            {
                existe = items.Any(p => p.ClienteID == item.ClienteID);
                if (existe) continue;
                var itemx = new BEPedidoWebDetalle
                {
                    ClienteID = item.ClienteID,
                    Nombre = item.Nombre,
                    eMail = item.eMail,
                    Cantidad = lst.ToList().Where(p => p.ClienteID == item.ClienteID).Sum(p => p.Cantidad),
                    ImporteTotal = lst.ToList().Where(p => p.ClienteID == item.ClienteID).Sum(p => p.ImporteTotal)
                };

                items.Add(itemx);
            }

            BEGrid grid = SetGrid(sidx, sord, page, rows);
            
            BEPager pag = Util.PaginadorGenerico(grid, items);
            var importeTotal = Util.DecimalToStringFormat(items.Sum(p => p.ImporteTotal), userData.CodigoISO);
            // Creamos la estructura
            var data = new
            {
                CampaniaId,

                pag.PageCount,
                pag.CurrentPage,
                pag.RecordCount,
                grid.PageSize,

                Simbolo = userData.Simbolo,
                CantidadCliente = items.Count(),
                CantidadProducto = items.Sum(p=>p.Cantidad),
                SubTotal = importeTotal,
                OfertaNiveles = Util.DecimalToStringFormat(0, userData.CodigoISO),
                ImporteTotal = importeTotal,
                Rows = items.Select(a => new
                {
                    userData.Simbolo,
                    CampaniaId,
                    CurrentPage = pag.CurrentPage,
                    PageCount = pag.PageCount,
                    a.Nombre,
                    a.ClienteID,
                    a.Cantidad,
                    ImporteTotal = Util.DecimalToStringFormat(a.ImporteTotal, userData.CodigoISO)
                })
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ConsultarPedidoWebDetallePorCamaniaPorCliente(string sidx, string sord, int page, int rows, string CampaniaId, int cliente, string estado)
        {
            BEGrid grid = SetGrid(sidx, sord, page, rows);
            
            List<BEPedidoWebDetalle> lst = GetDetallePorEstado(CampaniaId, estado);
            var pedidoWeb = lst.Count() > 0 ? lst[0] : new BEPedidoWebDetalle();

            var listaCliente = (from item in lst
                                select new Portal.Consultoras.Web.ServiceCliente.BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre }
                    ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();

            List<BEPedidoWebDetalle> itemCliente = lst.Where(p => p.ClienteID == cliente || cliente == -1).ToList();
            BEPager pag = Util.PaginadorGenerico(grid, itemCliente);

            List<BEPedidoWebDetalle> items = itemCliente.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();
            
            var totalpedido = itemCliente.Sum(p => p.ImporteTotal);
            var ImporteTotal = Util.DecimalToStringFormat(totalpedido, userData.CodigoISO);
            var montoConDescto = Util.DecimalToStringFormat(totalpedido - pedidoWeb.DescuentoProl, userData.CodigoISO);
            var itm = items.FirstOrDefault() ?? new BEPedidoWebDetalle();
            // Creamos la estructura
            var data = new
            {
                tipo = estado.ToLower(),
                ClienteID = cliente,
                Nombre = cliente == -1 ? "" : itm.Nombre,
                CampaniaId,
                userData.NombreConsultora,

                pag.PageCount,
                pag.CurrentPage,
                pag.RecordCount,
                grid.PageSize,

                Simbolo = userData.Simbolo,

                CantidadProducto = itemCliente.Sum(p => p.Cantidad),
                ImporteTotal,
                ImporteFlete = Util.DecimalToStringFormat(0, userData.CodigoISO),
                OfertaNiveles = Util.DecimalToStringFormat(pedidoWeb.DescuentoProl, userData.CodigoISO),
                ImporteFacturado = montoConDescto,
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
                    MontoEscala = Util.DecimalToStringFormat(a.ImporteTotalPedido,userData.CodigoISO),
                    ImportePagar = Util.DecimalToStringFormat(a.ImporteTotal - a.ImporteTotalPedido, userData.CodigoISO),
                    a.NombreCliente
                }),
                listaCliente
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        private List<BEPedidoWebDetalle> GetDetallePorEstado( string CampaniaId, string estado)
        {
            List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();

            var listx = Session["MisPedidos-DetallePorCampania"];
            string campSes = (string)Session["MisPedidos-DetallePorCampania-Campania"];
            string estadoCombo = (string)Session["MisPedidos-DetallePorCampania-Estado"];

            if (!(listx == null || campSes == null || campSes != CampaniaId || estadoCombo == null || estadoCombo != estado))
            {
                 lst = (List<BEPedidoWebDetalle>)listx;
                 return lst;
            }
            estado = (estado ?? "").Trim().ToLower();
            if (estado == "i")
            {
                #region ingresado

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.SelectByCampania(userData.PaisID, int.Parse(CampaniaId), ObtenerConsultoraId(), userData.NombreConsultora).ToList();
                }
                lst.Update(c => c.NombreCliente = c.Nombre);
                #endregion
            }

            else if (estado == "f")
            {
                #region facturado
                List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosDetalle(userData.PaisID, CampaniaId, "0", "0", userData.CodigoConsultora).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    lista = new List<BEPedidoFacturado>();
                }

                foreach (var pedido in lista)
                {
                    pedido.CUV = pedido.CUV ?? "";
                    pedido.Descripcion = pedido.Descripcion ?? "";

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
                #endregion
            }
            
            Session["MisPedidos-DetallePorCampania"] = lst;
            Session["MisPedidos-DetallePorCampania-Campania"] = CampaniaId;
            Session["MisPedidos-DetallePorCampania-Estado"] = estado;

            return lst;
        }
        
        public long ObtenerConsultoraId()
        {
            long ConsultoraIdmetodo;
            if (userData.UsuarioPrueba == 1)
            {
                using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
                {
                    ConsultoraIdmetodo = sv.GetConsultoraIdByCodigo(userData.PaisID, userData.ConsultoraAsociada);
                }
            }
            else
            {
                ConsultoraIdmetodo = userData.ConsultoraID;
            }
            return ConsultoraIdmetodo;
        }
        #endregion
    }
}
