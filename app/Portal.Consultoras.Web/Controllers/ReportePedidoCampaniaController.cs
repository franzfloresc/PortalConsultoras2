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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            await Task.Run(() => LoadConsultorasCache(11));
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
            string[] lista = param.Split(';');

            string paisddl = lista[0];
            string campaniaddl = lista[1];
            string regionddl = lista[2];
            string zonaddl = lista[3];
            string codConsultoratxt = lista[4];
            string paisddlVal = (lista[5] == string.Empty ? "0" : lista[5]);
            string campaniaddlVal = (lista[6] == string.Empty ? "0" : lista[6]);
            string regionddlVal = (lista[7] == string.Empty ? "0" : lista[7]);
            string zonaddlVal = (lista[8] == string.Empty ? "0" : lista[8]);
            string codConsultoratxtId = lista[9];
            string page = lista[10];
            string sortname = lista[11];
            string sortorder = lista[12];
            string rowNum = lista[13];

            IEnumerable<PaisModel> listaPaises = new List<PaisModel>() {
                                new PaisModel() {
                                    PaisID = Convert.ToInt32(paisddlVal),
                                    Nombre = paisddl
                                }
            };

            IEnumerable<CampaniaModel> lstCampania = new List<CampaniaModel>() {
                                new CampaniaModel() {
                                    CampaniaID = Convert.ToInt32((string.IsNullOrEmpty(campaniaddlVal) ? "0" : campaniaddlVal)),
                                    NombreCorto = campaniaddl
                                }
            };
            IEnumerable<RegionModel> lstRegion = new List<RegionModel>() {
                                new RegionModel() {
                                    RegionID = Convert.ToInt32((string.IsNullOrEmpty(regionddlVal) ? "0" :regionddlVal )),
                                    Codigo = regionddl
                                }
            };
            IEnumerable<ZonaModel> lstZona = new List<ZonaModel>() {
                                new ZonaModel() {
                                    ZonaID = Convert.ToInt32((string.IsNullOrEmpty(zonaddlVal) ? "0" :zonaddlVal)),
                                    Codigo = zonaddl
                                }
            };

            #endregion

            var model = new ReportePedidoCampaniaModel()
            {
                listaPaises = listaPaises,
                listaCampanias = lstCampania,
                listaRegiones = lstRegion,
                listaZonas = lstZona,
                CodConsultoratxt_ID = codConsultoratxtId,
                vpage = page,
                PaisID = int.Parse(paisddlVal),
                CampaniaID = int.Parse(campaniaddlVal),
                RegionID = int.Parse(regionddlVal),
                ZonaID = int.Parse(zonaddlVal),
                CodConsultoratxt = codConsultoratxt,
                vsortname = sortname,
                vsortorder = sortorder,
                vrowNum = rowNum
            };
            return View(model);
        }

        public ActionResult ExportarPDF(string vPaisddl, string vCampaniaddl, string vRegionddl, string vZonaddl, string vCodConsultoratxt, string vPaisddl_val,
                string vCampaniaddl_val, string vRegionddl_val, string vZonaddl_val, string vCodConsultoratxt_ID, string vUsuario)
        {
            SessionManager.SetPaisID(userData.PaisID);
            string[] lista = new string[14];
            lista[0] = vPaisddl; lista[1] = vCampaniaddl; lista[2] = vRegionddl; lista[3] = vZonaddl; lista[4] = vCodConsultoratxt;
            lista[5] = vPaisddl_val; lista[6] = vCampaniaddl_val; lista[7] = vRegionddl_val; lista[8] = vZonaddl_val; lista[9] = vCodConsultoratxt_ID;
            lista[10] = vUsuario; lista[11] = userData.BanderaImagen; lista[12] = userData.NombrePais; lista[13] = userData.Simbolo;
            Util.ExportToPdfWebPages(this, "ReportePedidosCampania.pdf", "ReportePedidoCampaniaImp", Util.EncriptarQueryString(lista));
            return View();
        }

        public JsonResult ObtenterCampaniasyRegionesPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<RegionModel> lstRegiones = _baseProvider.DropDownListRegiones(PaisID);
            IEnumerable<ZonaModel> lstZonas = _baseProvider.DropDownListZonas(PaisID);

            return Json(new
            {
                lista = lst,
                lstRegiones = lstRegiones.OrderBy(x => x.Codigo),
                listaZonas = lstZonas.OrderBy(x => x.Codigo)
            }, JsonRequestBehavior.AllowGet);
        }

        public void LoadConsultorasCache(int paisId)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                sv.LoadConsultoraCodigo(paisId);
            }
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

        public JsonResult GetConsultorasIds(int RegionID, int ZonaID, int rowCount, string vBusqueda)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                ServiceODS.BEConsultoraCodigo[] entidad = sv.SelectConsultoraCodigo(userData.PaisID, RegionID, ZonaID, vBusqueda, rowCount);
                return Json(entidad, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ConsultarPedidoCampania(string sidx, string sord, int page, int rows, string vPaisID, string vCampania, string vRegion, string vZona, string vConsultora)
        {
            if (ModelState.IsValid)
            {
                List<ReportePedidoCampaniaModel> lst = new List<ReportePedidoCampaniaModel>();

                List<BEPedidoFacturado> lista = new List<BEPedidoFacturado>();
                try
                {
                    if (vRegion == "" || vRegion == "-- Todas --") vRegion = "0";
                    if (vZona == "" || vZona == "-- Todas --") vZona = "0";
                    if (vConsultora == "") vConsultora = "0";

                    using (SACServiceClient client = new SACServiceClient())
                    {
                        lista = client.GetPedidosFacturadosDetalle(userData.PaisID, vCampania, vRegion, vZona, vConsultora, 0).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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
                                   (userData.PaisID == 4)? SeparadorMiles(Convert.ToDecimal(a.MontoDemandado)) : a.MontoDemandado,
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

            if (vRegion == "" || vRegion == "-- Todas --") vRegion = "0";
            if (vZona == "" || vZona == "-- Todas --") vZona = "0";
            if (vConsultora == "") vConsultora = "0";

            List<BEPedidoFacturado> lista;
            using (SACServiceClient client = new SACServiceClient())
            {
                lista = client.GetPedidosFacturadosDetalle(userData.PaisID, vCampania, vRegion, vZona, vConsultora, 0).ToList();
            }

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

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Cod. Consultora", "CodigoConsultora"},
                {"Territorio", "Territorio"},
                {"Cod. Venta", "CUV"},
                {"Cod. Producto", "CodigoProducto"},
                {"Unidades Demandadas", "UnidadesDemandadas"},
                {"Monto Demandado", "MontoDemandado"},
                {"Cod. Tipo Oferta", "TipoOferta"},
                {"Origen", "Origen"},
                {"Fecha Ult. Act.", "FechaUltima"}
            };
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
                List<string> columns = new List<string>();
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
    }
}
