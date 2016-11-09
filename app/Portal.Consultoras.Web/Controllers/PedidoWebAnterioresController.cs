using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Newtonsoft.Json.Linq;
using System.ServiceModel;
using ClosedXML.Excel;
using System.IO;
using Portal.Consultoras.Web.ServiceSAC; //R2073

namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoWebAnterioresController : BaseController
    {
        public ActionResult PedidoWebAnteriores()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "PedidoWebAnteriores/PedidoWebAnteriores"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View();
        }

        public ActionResult PedidoWebAnterioresDetalle()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("PedidoWebAnteriores");

            JObject o = JObject.Parse(Request.Form["data"]);
            int CampaniaId = (int)o["CampaniaId"];
            decimal Flete = o["Flete"].ToString() == string.Empty ? 0 : (decimal)o["Flete"];
            decimal Total = o["Total"].ToString() == string.Empty ? 0 : (decimal)o["Total"];
            ViewBag.CampaniaId = CampaniaId;

            if (UserData().PaisID == 4)
            { 
                // Validación pais Colombia Req. 1478
                ViewBag.Flete = string.Format("{0:#,##0}", Flete).Replace(',', '.');
                ViewBag.Total = string.Format("{0:#,##0}", Total).Replace(',', '.');
                ViewBag.Parcial = string.Format("{0:#,##0}", Total - Flete).Replace(',', '.');
            }
            else
            {
                ViewBag.Flete = string.Format("{0:#,##0.00}", Flete);
                ViewBag.Total = string.Format("{0:#,##0.00}", Total);
                ViewBag.Parcial = string.Format("{0:#,##0.00}", Total - Flete);
            }
            UsuarioModel usuario = UserData();

            ViewBag.CodigoPW = usuario.CodigoConsultora;
            ViewBag.NombrePW = usuario.NombreConsultora;
            ViewBag.DireccionPW = usuario.Direccion;
            ViewBag.Zona = usuario.CodigoZona;
            ViewBag.SimboloPW = usuario.Simbolo;

            return View();
        }

        public string OrigenDescripcion(string Origen)
        {
            string result = string.Empty;
            switch (Origen)
            {
                case "A":
                    result = "PEDIDO ESPECIAL";
                    break;
                case "O":
                    result = "DIGITADO / OCR";
                    break;
                case "OCR":
                    result = "OCR";
                    break;
                case "W":
                case "WEB":
                    result = "WEB";
                    break;
                case "D":
                case "DD":
                    result = "DD";
                    break;
                case "M":
                case "MIXTO":
                    result = "MIXTO (DD + WEB)";
                    break;
                default:
                    result = Origen;
                    break;

            }
            return result;
        }

        //R2073
		public ActionResult ConsultarPedidoWebAnteriores(string sidx, string sord, int page, int rows)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWeb> lst = new List<BEPedidoWeb>();
                List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosCabecera(UserData().PaisID, UserData().CodigoConsultora).ToList();
                }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                }

                foreach (var pedido in lista)
                    {
                        BEPedidoWeb oBEPedidoWeb = new BEPedidoWeb();
                    oBEPedidoWeb.CampaniaID = pedido.Campania;
                    oBEPedidoWeb.ImporteTotal = pedido.ImporteTotal;
                    oBEPedidoWeb.CantidadProductos = pedido.Cantidad;
                    if (!string.IsNullOrEmpty(pedido.EstadoPedido))
                        {
                        string[] parametros = pedido.EstadoPedido.Split(';');
                        if (parametros.Length >= 3)
                            {
                                //Se utilizará el campo para enviar la información de Origen
                                oBEPedidoWeb.EstadoPedidoDesc = OrigenDescripcion(parametros[0]);
                                //Se utilizará el campo para enviar la información de Flete
                                oBEPedidoWeb.Direccion = parametros[1] == string.Empty ? "0" : parametros[1];
                                //Se utilizará el campo para enviar la fecha de Facturación
                                oBEPedidoWeb.CodigoUsuarioCreacion = parametros[2] == string.Empty ? "" : Convert.ToDateTime(parametros[2]).ToShortDateString();
                            }
                            
                            
                        }
                        
                        lst.Add(oBEPedidoWeb);
                    }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEPedidoWeb> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderBy(x => x.CampaniaID);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderBy(x => x.ImporteTotal);
                            break;
                        case "CantidadProductos":
                            items = lst.OrderBy(x => x.CantidadProductos);
                            break;
                        case "EstadoPedidoDesc":
                            items = lst.OrderBy(x => x.EstadoPedidoDesc);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CampaniaID":
                            items = lst.OrderByDescending(x => x.CampaniaID);
                            break;
                        case "ImporteTotal":
                            items = lst.OrderByDescending(x => x.ImporteTotal);
                            break;
                        case "CantidadProductos":
                            items = lst.OrderByDescending(x => x.Clientes);
                            break;
                        case "EstadoPedidoDesc":
                            items = lst.OrderByDescending(x => x.EstadoPedidoDesc);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);


                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                if (UserData().PaisID == 4) // validación pais colombia req. 1478
                {
                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.CampaniaID,
                                   cell = new string[] 
                               {
                                   DescripcionCampania(a.CampaniaID.ToString()),
                                   a.EstadoPedidoDesc,
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
                                   a.CantidadProductos.ToString(),
                                   a.CodigoUsuarioCreacion,
                                   a.Direccion,
                                   a.ImporteTotal.ToString()
                                }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.CampaniaID,
                                   cell = new string[] 
                               {
                                   DescripcionCampania(a.CampaniaID.ToString()),
                                   a.EstadoPedidoDesc,
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal)),
                                   a.CantidadProductos.ToString(),
                                   a.CodigoUsuarioCreacion,
                                   a.Direccion,
                                   a.ImporteTotal.ToString()
                                }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public string DescripcionCampania(string CampaniaID)
        {
            string DesCamp = string.Empty;
            try
            {
                DesCamp = CampaniaID.Substring(0, 4) + "-C" + CampaniaID.Substring(4, 2);
            }
            catch (Exception ex)
            {
                DesCamp = CampaniaID;
            }
            return DesCamp;
        }

        //R2073
		public ActionResult ConsultarPedidoWebAnterioresProductos(string sidx, string sord, int page, int rows, string CampaniaId)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();
                List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosDetalle(UserData().PaisID, CampaniaId, "0", "0", UserData().CodigoConsultora, 0).ToList();
                }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                    lista = null;
                }

                foreach (var pedido in lista)
                {
                    if (pedido.CUV.Trim().Length > 0 &&
                        pedido.Descripcion.Trim().Length > 0)
                        lst.Add(new BEPedidoWebDetalle
                        {
                            CUV = pedido.CUV,
                            DescripcionProd = pedido.Descripcion,
                            Cantidad = pedido.Cantidad,
                            PrecioUnidad = pedido.PrecioUnidad,
                            ImporteTotal = pedido.ImporteTotal,
                            //Se esta reutilizando este campo para devolver el descuente correspondiente al CUV
                            ImporteTotalPedido = pedido.MontoDescuento
                        });
                    }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
                IEnumerable<BEPedidoWebDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;

                        case "DescripcionProd":
                            items = lst.OrderBy(x => x.DescripcionProd);
                            break;

                        case "Cantidad":
                            items = lst.OrderBy(x => x.Cantidad);
                            break;

                        case "PrecioUnidad":
                            items = lst.OrderBy(x => x.PrecioUnidad);
                            break;

                        case "ImporteTotal":
                            items = lst.OrderBy(x => x.ImporteTotal);
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

                        case "DescripcionProd":
                            items = lst.OrderByDescending(x => x.DescripcionProd);
                            break;

                        case "Cantidad":
                            items = lst.OrderByDescending(x => x.Cantidad);
                            break;

                        case "PrecioUnidad":
                            items = lst.OrderByDescending(x => x.PrecioUnidad);
                            break;

                        case "ImporteTotal":
                            items = lst.OrderByDescending(x => x.ImporteTotal);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);


                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                if (UserData().PaisID == 4)
                { // validación país colombia req. 1478
                    var data = new
                    {
                        simbolo = UserData().Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = "0",//string.Format("{0:#,##0.00}", Math.Truncate((from req in lst select req.ImporteTotal - req.ImporteTotalPedido).Sum()*100)/100),
                        rows = from a in items
                               select new
                               {
                                   id = a.CUV,
                                   cell = new string[] 
                               {
                                   a.CUV,
                                   a.DescripcionProd,
                                   a.Cantidad.ToString(),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0}",a.PrecioUnidad).Replace(',','.')),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
                                   (" " + a.ImporteTotal.ToString("#,##0").Replace(',','.')),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotalPedido).Replace(',','.')),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal - a.ImporteTotalPedido).Replace(',','.'))
                                }
                               }
                    };

                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new
                    {
                        simbolo = UserData().Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = "0",//string.Format("{0:#,##0.00}", Math.Truncate((from req in lst select req.ImporteTotal - req.ImporteTotalPedido).Sum()*100)/100),
                        rows = from a in items
                               select new
                               {
                                   id = a.CUV,
                                   cell = new string[] 
                               {
                                   a.CUV,
                                   a.DescripcionProd,
                                   a.Cantidad.ToString(),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0.00}",a.PrecioUnidad)),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal)),
                                   (" " + a.ImporteTotal.ToString("#0.00")),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotalPedido)),
                                   (UserData().Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal - a.ImporteTotalPedido))
                                }
                               }
                    };

                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        //R2073
		public ActionResult ExportarExcel(string vCampaniaID, string vTotalParcial, string vFlete, string vTotalFacturado)
        {
            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();
            List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();
            List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
            try
            {
                using (SACServiceClient client = new SACServiceClient())
                {
                    lista = client.GetPedidosFacturadosDetalle(UserData().PaisID, vCampaniaID, "0", "0", UserData().CodigoConsultora, 0).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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

                dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, UserData().NombreConsultora));

            Dictionary<string, string> dicDetalles = new Dictionary<string, string>();
            dicDetalles.Add("Código", "CUV");
            dicDetalles.Add("Descripción", "DescripcionProd");
            dicDetalles.Add("Cantidad", "Cantidad");
            dicDetalles.Add("Precio Unitario", UserData().Simbolo + " #PrecioUnidad");
            dicDetalles.Add("Total", UserData().Simbolo + " #ImporteTotal");
            dicDetalles.Add("Descuento", UserData().Simbolo + " #Descuento");
            dicDetalles.Add("Importe a Pagar", UserData().Simbolo + " #ImportePagar");

            string[] arrTotal = { "Importe Total:", " #CodigoUsuarioCreacion", "Flete:", " #CodigoUsuarioModificacion", "Total Facturado:", " #Mensaje", };

            ExportToExcelMultiple("PedidosWebExcel", lst, dicCabeceras, dicDetalles, arrTotal, vTotalParcial, vFlete, vTotalFacturado);
            return View();
        }

        private void ExportToExcelMultiple(string filename, List<BEPedidoWebDetalle> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
            Dictionary<string, string> columnDetailDefinition, string[] arrTotal, string vTotalParcial, string vFlete, string vTotalFacturado)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                int row = 5;
                int col = 0;
                int i = 0;

                int col2 = 1;

                ws.Cell(1, 1).Value = "Código Consultora: " + UserData().CodigoConsultora;
                ws.Range(string.Format("A{0}:E{1}", 1, 1)).Row(1).Merge();
                ws.Cell(1, 1).Style.Font.Bold = true;

                ws.Cell(2, 1).Value = "Nombre Consultora: " + UserData().NombreConsultora;
                ws.Range(string.Format("A{0}:E{1}", 2, 2)).Row(1).Merge();
                ws.Cell(2, 1).Style.Font.Bold = true;

                ws.Cell(3, 1).Value = "Dirección: " + UserData().Direccion;
                ws.Range(string.Format("A{0}:E{1}", 3, 3)).Row(1).Merge();
                ws.Cell(3, 1).Style.Font.Bold = true;

                ws.Cell(4, 1).Value = "Zona: " + UserData().CodigoZona;
                ws.Range(string.Format("A{0}:E{1}", 4, 4)).Row(1).Merge();
                ws.Cell(4, 1).Style.Font.Bold = true;

                //decimal TotalPedido = 0;
                string Simbolo = UserData().Simbolo;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    //Establece las columnas
                    //ws.Cell(row, 1).Value = keyvalue.Value;
                    //ws.Range(string.Format("A{0}:E{1}", row, row)).Row(1).Merge();
                    //ws.Cell(row, 1).Style.Font.Bold = true;
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
                    // ( i < ; i++)
                    {
                        col = 1;
                        foreach (string column in Columns) // itera las columnas del detalle
                        {
                            //Establece el valor para esa columna
                            BEPedidoWebDetalle source = SourceDetails[i];
                            //foreach (PropertyInfo property in source.GetType().GetProperties())
                            //{
                            //for (int m = 0; m < 5; m++)
                            //{
                            string[] arr = new string[2];
                            if (column.Contains("#"))
                                arr = column.Split('#');
                            else
                                arr = new string[] { "", column };

                            if (arr[1] == "CUV")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.CUV;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                            }

                            else if (arr[1] == "DescripcionProd")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.DescripcionProd;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                            }

                            else if (arr[1] == "Cantidad")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Cantidad;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                            }

                            else if (arr[1] == "ImporteTotal")
                            {
                                string importeTotal = "";
                                if (UserData().PaisID == 4)
                                { // validación para pais colombia req. 1478
                                    importeTotal = source.ImporteTotal.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    importeTotal = source.ImporteTotal.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + importeTotal;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                            }

                            else if (arr[1] == "PrecioUnidad")
                            {
                                string precioUnidad = "";
                                if (UserData().PaisID == 4)
                                { // validación para pais colombia req. 1478
                                    precioUnidad = source.PrecioUnidad.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    precioUnidad = source.PrecioUnidad.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + precioUnidad;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                            }
                            else if (arr[1] == "Descuento")
                            {
                                string importeTotalPedido = "";
                                if (UserData().PaisID == 4)
                                { // validación para pais colombia req. 1478
                                    importeTotalPedido = source.ImporteTotalPedido.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    importeTotalPedido = source.ImporteTotalPedido.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + importeTotalPedido;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                            }
                            else if (arr[1] == "ImportePagar")
                            {
                                string importePagar = "";
                                if (UserData().PaisID == 4)
                                { // validación para pais colombia req. 1478
                                    importePagar = (source.ImporteTotal - source.ImporteTotalPedido).ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    importePagar = (source.ImporteTotal - source.ImporteTotalPedido).ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + importePagar;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                            }
                            //}
                            col++;
                        }
                        row++;
                        i++;
                    }
                    //Columns = new List<string>();
                    //if (arrTotal.Length > 0)
                    //{
                    //    ws.Range(row, 1, row, col - 1).AddToNamed("Totals");
                    //    var titlesStyle = wb.Style;
                    //    titlesStyle.Font.Bold = true;
                    //    titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                    //    titlesStyle.Fill.BackgroundColor = XLColor.NoColor;
                    //    titlesStyleh.Font.FontColor = XLColor.FromHtml("#000000");
                    //    wb.NamedRanges.NamedRange("Totals").Ranges.Style = titlesStyle;

                    //    ws.Cell(row, col - 2).Value = arrTotal[0]; //Total:
                    //    ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] + ((BEPedidoWebDetalle)SourceDetails[i]).ImporteTotalPedido.ToString("0.00");
                        
                        
                    //    //TotalPedido += ((BEPedidoWebDetalle)SourceDetails[i]).ImporteTotalPedido;
                    //}
                    row++;
                    //index = keyvalue.Key + 1;
                    //SourceDetails.RemoveRange(0, index);
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

    }
}
