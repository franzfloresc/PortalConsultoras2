using AutoMapper;
using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReportePedidoCampaniaController : BaseController
    {
        #region Actions
        public async Task<ActionResult> Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ReportePedidoCampania/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            await Task.Run(() => LoadConsultorasCache(11));
            var listaCampanias = DropDowListCampanias(11);
            var reportePedidoCampaniaModel = new ReportePedidoCampaniaModel()
            {
                listaCampanias = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                listaRegiones = new List<RegionModel>(),
                listaZonas = new List<ZonaModel>()
            };
            return View(reportePedidoCampaniaModel);
        }

        public ActionResult ReportePedidoCampaniaImp(string parametros)
        {
            #region GetParameters
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(new char[] { ';' });

            string Paisddl = lista[0];
            string Campaniaddl = lista[1];
            string Regionddl = lista[2];
            string Zonaddl = lista[3];
            string CodConsultoratxt = lista[4];
            string Paisddl_val = (lista[5] == string.Empty ? "0" : lista[5]);
            string Campaniaddl_val = (lista[6] == string.Empty ? "0" : lista[6]);
            string Regionddl_val = (lista[7] == string.Empty ? "0" : lista[7]);
            string Zonaddl_val = (lista[8] == string.Empty ? "0" : lista[8]);
            string CodConsultoratxt_ID = lista[9];
            string page = lista[10];
            string sortname = lista[11];
            string sortorder = lista[12];
            string rowNum = lista[13];

            IEnumerable<PaisModel> listaPaises = new List<PaisModel>() {
                                new PaisModel() {
                                    PaisID = Convert.ToInt32(Paisddl_val),
                                    Nombre = Paisddl
                                }
            };

            IEnumerable<CampaniaModel> lstCampania = new List<CampaniaModel>() {
                                new CampaniaModel() {
                                    CampaniaID = Convert.ToInt32((string.IsNullOrEmpty(Campaniaddl_val) ? "0" : Campaniaddl_val)),
                                    NombreCorto = Campaniaddl
                                }
            };
            IEnumerable<RegionModel> lstRegion = new List<RegionModel>() {
                                new RegionModel() {
                                    RegionID = Convert.ToInt32((string.IsNullOrEmpty(Regionddl_val) ? "0" :Regionddl_val )),
                                    Codigo = Regionddl
                                }
            };
            IEnumerable<ZonaModel> lstZona = new List<ZonaModel>() {
                                new ZonaModel() {
                                    ZonaID = Convert.ToInt32((string.IsNullOrEmpty(Zonaddl_val) ? "0" :Zonaddl_val)),
                                    Codigo = Zonaddl
                                }
            };

            #endregion

            var model = new ReportePedidoCampaniaModel()
            {
                listaPaises = listaPaises,
                listaCampanias = lstCampania,
                listaRegiones = lstRegion,
                listaZonas = lstZona,
                CodConsultoratxt_ID = CodConsultoratxt_ID,
                vpage = page,
                PaisID = int.Parse(Paisddl_val),
                CampaniaID = int.Parse(Campaniaddl_val),
                RegionID = int.Parse(Regionddl_val),
                ZonaID = int.Parse(Zonaddl_val),
                CodConsultoratxt = CodConsultoratxt,
                vsortname = sortname,
                vsortorder = sortorder,
                vrowNum = rowNum
            };
            return View(model);
        }

        public ActionResult ExportarPDF(string vPaisddl, string vCampaniaddl, string vRegionddl, string vZonaddl, string vCodConsultoratxt, string vPaisddl_val,
                string vCampaniaddl_val, string vRegionddl_val, string vZonaddl_val, string vCodConsultoratxt_ID, string vUsuario)
        {
            Session["PaisID"] = UserData().PaisID;
            string[] lista = new string[14];
            lista[0] = vPaisddl; lista[1] = vCampaniaddl; lista[2] = vRegionddl; lista[3] = vZonaddl; lista[4] = vCodConsultoratxt;
            lista[5] = vPaisddl_val; lista[6] = vCampaniaddl_val; lista[7] = vRegionddl_val; lista[8] = vZonaddl_val; lista[9] = vCodConsultoratxt_ID;
            lista[10] = vUsuario; lista[11] = UserData().BanderaImagen; lista[12] = UserData().NombrePais; lista[13] = UserData().Simbolo;
            Util.ExportToPdfWebPages(this, "ReportePedidosCampania.pdf", "ReportePedidoCampaniaImp", Util.EncriptarQueryString(lista));
            return View();
        }

        public JsonResult ObtenterCampaniasyRegionesPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<RegionModel> lstRegiones = DropDownListRegiones(PaisID);
            IEnumerable<ZonaModel> lstZonas = DropDownListZonas(PaisID);

            return Json(new
            {
                lista = lst,
                lstRegiones = lstRegiones.OrderBy(x => x.Codigo),
                listaZonas = lstZonas.OrderBy(x => x.Codigo)
            }, JsonRequestBehavior.AllowGet);
        }

        public void LoadConsultorasCache(int PaisID)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                sv.LoadConsultoraCodigo(PaisID);
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
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

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult GetConsultorasIds(int RegionID, int ZonaID, int rowCount, string vBusqueda)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                ServiceODS.BEConsultoraCodigo[] entidad = sv.SelectConsultoraCodigo(UserData().PaisID, RegionID, ZonaID, vBusqueda, rowCount);
                return Json(entidad, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ConsultarPedidoCampania(string sidx, string sord, int page, int rows, string vPaisID, string vCampania, string vRegion, string vZona, string vConsultora)
        {
            if (ModelState.IsValid)
            {
                List<ReportePedidoCampaniaModel> lst = new List<ReportePedidoCampaniaModel>();
                BEPais bepais = new BEPais();

                List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
                try
                {
                    try
                    {
                        using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                        {
                            bepais = sv.SelectPais(Convert.ToInt32(vPaisID));
                        }
                    }
                    catch (FaultException ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                    }


                    if (vRegion == "" || vRegion == "-- Todas --") vRegion = "0";
                    if (vZona == "" || vZona == "-- Todas --") vZona = "0";
                    if (vConsultora == "") vConsultora = "0";

                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosDetalle(UserData().PaisID, vCampania, vRegion, vZona, vConsultora, 0).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                }
                if (lista == null)
                {
                    lst = new List<ReportePedidoCampaniaModel>();
                }
                else
                {
                    foreach (var pedido in lista)
                    {
                        lst.Add(new ReportePedidoCampaniaModel
                        {
                            CodigoConsultora = pedido.CodigoConsultora,
                            Territorio = pedido.CodigoTerritorio,
                            CUV = pedido.CUV,
                            CodigoProducto = pedido.CodigoProducto,
                            UnidadesDemandadas = pedido.Cantidad.ToString(),
                            MontoDemandado = pedido.ImporteTotal.ToString("#0.00"),
                            TipoOferta = pedido.CodigoTipoOferta,
                            Origen = pedido.Origen,
                            FechaUltima = pedido.FechaUltimaActualizacion.ToShortDateString()
                        });
                    }
                }
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;

                IEnumerable<ReportePedidoCampaniaModel> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderBy(x => x.CodigoConsultora);
                            break;
                        case "Territorio":
                            items = lst.OrderBy(x => x.Territorio);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderBy(x => x.CodigoProducto);
                            break;
                        case "UnidadesDemandadas":
                            items = lst.OrderBy(x => x.UnidadesDemandadas);
                            break;
                        case "MontoDemandado":
                            items = lst.OrderBy(x => x.MontoDemandado);
                            break;
                        case "TipoOferta":
                            items = lst.OrderBy(x => x.TipoOferta);
                            break;
                        case "Origen":
                            items = lst.OrderBy(x => x.Origen);
                            break;
                        case "FechaUltima":
                            items = lst.OrderBy(x => x.FechaUltima);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoConsultora":
                            items = lst.OrderByDescending(x => x.CodigoConsultora);
                            break;
                        case "Territorio":
                            items = lst.OrderByDescending(x => x.Territorio);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderByDescending(x => x.CodigoProducto);
                            break;
                        case "UnidadesDemandadas":
                            items = lst.OrderByDescending(x => x.UnidadesDemandadas);
                            break;
                        case "MontoDemandado":
                            items = lst.OrderByDescending(x => x.MontoDemandado);
                            break;
                        case "TipoOferta":
                            items = lst.OrderByDescending(x => x.TipoOferta);
                            break;
                        case "Origen":
                            items = lst.OrderByDescending(x => x.Origen);
                            break;
                        case "FechaUltima":
                            items = lst.OrderByDescending(x => x.FechaUltima);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Paginador(grid, lst);

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
                                   a.CodigoConsultora,
                                   a.Territorio,
                                   a.CUV,
                                   a.CodigoProducto,
                                   a.UnidadesDemandadas,
                                   (UserData().PaisID == 4)? SeparadorMiles(Convert.ToDecimal(a.MontoDemandado)) : a.MontoDemandado,
                                   a.TipoOferta,
                                   a.Origen,
                                   a.FechaUltima
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("ConsultarPedidoCampania");
        }

        public string SeparadorMiles(decimal monto)
        {
            return monto.ToString("#,##0").Replace(',', '.');
        }

        public ActionResult ExportarExcel(string vPaisID, string vCampania, string vRegion, string vZona, string vConsultora)
        {
            List<ReportePedidoCampaniaModel> lst = new List<ReportePedidoCampaniaModel>();
            BEPais bepais = new BEPais();

            List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                bepais = sv.SelectPais(Convert.ToInt32(vPaisID));
            }

            if (vRegion == "" || vRegion == "-- Todas --") vRegion = "0";
            if (vZona == "" || vZona == "-- Todas --") vZona = "0";
            if (vConsultora == "") vConsultora = "0";

            using (SACServiceClient client = new SACServiceClient())
            {
                lista = client.GetPedidosFacturadosDetalle(UserData().PaisID, vCampania, vRegion, vZona, vConsultora, 0).ToList();
            }

            if (lista == null)
            {
                lst = new List<ReportePedidoCampaniaModel>();
            }
            else
            {
                foreach (var pedido in lista)
                {
                    lst.Add(new ReportePedidoCampaniaModel
                    {
                        CodigoConsultora = pedido.CodigoConsultora,
                        Territorio = pedido.CodigoTerritorio,
                        CUV = pedido.CUV,
                        CodigoProducto = pedido.CodigoProducto,
                        UnidadesDemandadas = pedido.Cantidad.ToString(),
                        MontoDemandado = pedido.ImporteTotal.ToString("#0.00"),
                        TipoOferta = pedido.CodigoTipoOferta,
                        Origen = pedido.Origen,
                        FechaUltima = pedido.FechaUltimaActualizacion.ToShortDateString()
                    });
                }
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Cod. Consultora", "CodigoConsultora");
            dic.Add("Territorio", "Territorio");
            dic.Add("Cod. Venta", "CUV");
            dic.Add("Cod. Producto", "CodigoProducto");
            dic.Add("Unidades Demandadas", "UnidadesDemandadas");
            dic.Add("Monto Demandado", "MontoDemandado");
            dic.Add("Cod. Tipo Oferta", "TipoOferta");
            dic.Add("Origen", "Origen");
            dic.Add("Fecha Ult. Act.", "FechaUltima");
            ExportToExcel("PedidosExcel", lst, dic);
            return View();
        }

        #endregion

        public bool ExportToExcel<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    Columns.Add(keyvalue.Value);
                }
                int row = 2;
                int col = 0;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    col = 1;
                    foreach (string column in Columns)
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

                                    if (UserData().PaisID == 4)
                                    {
                                        if (col == 6)
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

        public BEPager Paginador(BEGrid item, List<ReportePedidoCampaniaModel> lst)
        {
            BEPager pag = new BEPager();

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }
    }
}
