using AutoMapper;
using ClosedXML.Excel;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.ServiceModel;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultaPedidoController : BaseController
    {
        #region Action
        public ActionResult ConsultaPedido()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ConsultaPedido/ConsultaPedido"))
                return RedirectToAction("Index", "Bienvenida");
            var model = new ConsultaPedidoModel();
            try
            {
                IEnumerable<CampaniaModel> lstCampania = new List<CampaniaModel>() { 
                                new CampaniaModel() {
                                    CampaniaID = 0, 
                                    Codigo = "-- Seleccionar --" 
                                }};
                IEnumerable<RegionModel> lstRegion = new List<RegionModel>();
                //{ 
                //                new RegionModel() {
                //                    RegionID = 0, 
                //                    Codigo = "-- Seleccionar --" 
                //                }};
                IEnumerable<ZonaModel> lstZona = new List<ZonaModel>();
                //{ 
                //                new ZonaModel() {
                //                    ZonaID = 0, 
                //                    Codigo = "-- Seleccionar --" 
                //                }};

                model.listaPaises = CargarDropDowListPaises();
                model.listaCampania = lstCampania;
                model.listaRegiones = lstRegion;
                model.listaZonas = lstZona;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
        }

        public ActionResult BloqueoPedido()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("ConsultaPedido", "ConsultaPedido");
            JObject obj = JObject.Parse(Request.Form["data"]);
            var model = new ConsultaPedidoModel()
            {
                CodigoConsultora = obj["CodigoConsultora"].ToString(),
                Nombres = obj["Nombres"].ToString(),
                Direccion = obj["Direccion"].ToString(),
                CodigoTerritorio = obj["CodigoTerritorio"].ToString(),
                PedidoID = obj["PedidoID"].ToString(),
                CampaniaID = Convert.ToInt32(obj["CampaniaID"].ToString()),
                PaisID = Convert.ToInt32(obj["PaisID"].ToString()),
                Usuario = obj["Usuario"].ToString(),
                Bloqueado = Convert.ToInt16(obj["Bloqueado"].ToString()),
                DescripcionBloqueo = obj["DescripcionBloqueo"].ToString(),
                IndicadorEnviado = Convert.ToInt16(obj["IndicadorEnviado"].ToString()),
                FechaProceso = HttpUtility.UrlDecode(obj["FechaProceso"].ToString()).Trim()
            };
            return View(model);
        }

        public ActionResult ConsultaPedidoImp(string parametros)
        {
            ConsultaPedidoModel model = null;
            try
            {
                string param = Util.DesencriptarQueryString(parametros);
                string[] lista = param.Split(new char[] { ';' });

                string Campaniaddl = lista[0];
                string Regionddl = lista[1];
                string Zonaddl = lista[2];
                string Paisddl = lista[3];
                string Fechaddl = lista[4];
                string territoriotxt = lista[5];
                string EstadoPedidoddl = lista[6];
                string CodConsultoratxt = lista[7];
                string Bloqueadoddl = lista[8];

                string Campaniaddl_val = lista[9];
                string Regionddl_val = lista[10];
                string Zonaddl_val = lista[11];
                string Paisddl_val = lista[12];
                string Fechaddl_val = lista[13];
                string EstadoPedidoddl_val = lista[14];
                string Bloqueadoddl_val = lista[15];
                string territoriotxt_ID = lista[16];
                string CodConsultoratxt_ID = lista[17];

                string page = lista[18];
                string sortname = lista[19];
                string sortorder = lista[20];
                string rowNum = lista[21];

                IEnumerable<CampaniaModel> lstCampania = new List<CampaniaModel>() { 
                                new CampaniaModel() {
                                    CampaniaID = Convert.ToInt32((string.IsNullOrEmpty(Campaniaddl_val) ? "0" : Campaniaddl_val)), 
                                    Codigo = Campaniaddl 
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
                IEnumerable<PaisModel> listaPaises = new List<PaisModel>() { 
                                new PaisModel() {
                                    PaisID = Convert.ToInt32(Paisddl_val), 
                                    Nombre = Paisddl 
                                }
            };
                model = new ConsultaPedidoModel()
                {
                    listaPaises = listaPaises,
                    listaCampania = lstCampania,
                    listaRegiones = lstRegion,
                    listaZonas = lstZona,
                    Fechaddl_val = Fechaddl_val,
                    EstadoPedidoddl_val = EstadoPedidoddl_val,
                    Bloqueadoddl_val = Bloqueadoddl_val,
                    territoriotxt = territoriotxt,
                    CodConsultoratxt = CodConsultoratxt,
                    territoriotxt_ID = territoriotxt_ID,
                    CodConsultoratxt_ID = CodConsultoratxt_ID,
                    vpage = page,
                    vsortname = sortname,
                    vsortorder = sortorder,
                    vrowNum = rowNum
                };
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
        }

        public ActionResult BloqueoPedidoImp(string parametros)
        {

            string obj = Util.DesencriptarQueryString(parametros);
            string[] lista = obj.Split(new char[] { ';' });

            var model = new ConsultaPedidoModel();
            model.CodigoConsultora = lista[0].ToString();
            model.Nombres = lista[1].ToString();
            model.Direccion = lista[2].ToString();
            model.CodigoTerritorio = lista[3].ToString();
            model.PedidoID = lista[4].ToString();
            model.CampaniaID = Convert.ToInt32(lista[5].ToString());
            model.vpage = lista[6].ToString();
            model.vsortname = lista[7].ToString();
            model.vsortorder = lista[8].ToString();
            model.vrowNum = lista[9].ToString();
            model.PaisID = Convert.ToInt32(lista[10]);
            model.Usuario = lista[11];
            return View(model);
        }
        #endregion

        #region Metodos
        public JsonResult ObtenterDropDownPorPais(int PaisID)
        {
            //PaisID = 11;
            IEnumerable<CampaniaModel> lstcampania = DropDownCampanias(PaisID);
            IEnumerable<ZonaModel> lstzona = DropDownZonas(PaisID);
            IEnumerable<RegionModel> lstregion = DropDownListRegiones(PaisID);

            return Json(new
            {
                lstCampania = lstcampania,
                lstZona = lstzona,
                lstRegion = lstregion

            }, JsonRequestBehavior.AllowGet);
        }

        public IEnumerable<CampaniaModel> DropDownCampanias(int PaisID)
        {
            IList<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
               .ForMember(x => x.CampaniaID, t => t.MapFrom(c => c.CampaniaID))
               .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo))
               .ForMember(x => x.Anio, t => t.MapFrom(c => c.Anio))
               .ForMember(x => x.NombreCorto, t => t.MapFrom(c => c.NombreCorto))
               .ForMember(x => x.PaisID, t => t.MapFrom(c => c.PaisID))
               .ForMember(x => x.Activo, t => t.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        public IEnumerable<ZonaModel> DropDownZonas(int PaisID)
        {
            IList<BEZona> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectAllZonas(PaisID);
            }

            Mapper.CreateMap<BEZona, ZonaModel>()
               .ForMember(x => x.ZonaID, t => t.MapFrom(c => c.ZonaID))
               .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo))
               .ForMember(x => x.Nombre, t => t.MapFrom(c => c.Nombre))
               .ForMember(x => x.RegionID, t => t.MapFrom(c => c.RegionID));

            return Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lista);
        }

        public JsonResult SelectTerritorioByCodigo(string codigo, int rowCount, int paisID)
        {
            try
            {
                using (ZonificacionServiceClient service = new ZonificacionServiceClient())
                {
                    BETerritorio[] beterritorio = service.SelectTerritorioByCodigo(paisID, codigo, rowCount);
                    return Json(beterritorio, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(null, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult SelectConsultoraByCodigo(string codigo, int rowCount, int paisID)
        {
            using (ODSServiceClient service = new ODSServiceClient())
            {
                BEConsultoraCodigo[] beconsultora = service.SelectConsultoraCodigo_A(paisID, codigo, rowCount);
                return Json(beconsultora, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, string vRegionID,
                                     string vCampaniaID, string vZonaID, string vTerritorioID, string vEstadoPedido,
                                     string vConsultoraID, string vBloqueado, string vFechaProceso)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWeb> lst;
                using (PedidoServiceClient srv = new PedidoServiceClient())
                {
                    BEPedidoWeb pedido = new BEPedidoWeb()
                    {
                        PaisID = paisID,
                        CodigoZona = vZonaID.Equals("-1") ? "" : vZonaID,
                        CodigoConsultora = vConsultoraID,
                        CampaniaID = (string.IsNullOrEmpty(vCampaniaID) ? 0 : Convert.ToInt32(vCampaniaID)),
                        EstadoPedido = Convert.ToByte(vEstadoPedido),
                        Bloqueado = Convert.ToInt16(vBloqueado)
                    };

                    int? regionid = null;
                    if (!string.IsNullOrEmpty(vRegionID))
                        regionid = int.Parse(vRegionID);

                    int? territorioid = null;
                    if (!string.IsNullOrEmpty(vTerritorioID))
                        territorioid = int.Parse(vTerritorioID);

                    lst = srv.SelectPedidosWebByFilter(pedido, "01012013", regionid, territorioid).ToList();
                }
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;

                BEPager pag = new BEPager();
                IEnumerable<BEPedidoWeb> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodZona":
                            items = lst.OrderBy(x => x.CodigoZona);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodZona":
                            items = lst.OrderByDescending(x => x.CodigoZona);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                int total = lst.FindAll(x => x.Bloqueado == 0).Count;

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    totalregistros = lst.Count,
                    pedidosfacturar = total,
                    rows = from a in items
                           select new
                           {
                               id = a.PedidoID,
                               cell = new string[]
                                        {
                                           a.CampaniaID.ToString(),
                                           a.Direccion,
                                           a.CodigoTerritorio,
                                           a.PedidoID.ToString(),
                                           a.CodigoZona.ToString(), // Codigo Zona
                                           a.CodigoConsultora.ToString(), // Codigo Consultora
                                           a.Nombres,
                                           (UserData().PaisID == 4)? a.MontoPedido.ToString("#,##0").Replace(',','.') : a.MontoPedido.ToString("0.00"), // Validación colombia req. 1478
                                           (UserData().PaisID == 4)? a.SaldoDeuda.ToString("#,##0").Replace(',','.') : a.SaldoDeuda.ToString("0.00"),
                                           a.DescripcionBloqueo,
                                           a.Bloqueado.ToString(),
                                           a.IndicadorEnviado.ToString(),
                                           a.FechaProceso.ToString()
                                        }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Consultar");
        }

        public ActionResult ConsultarBloqueo(string sidx, string sord, int page, int rows, int pedidoID, string vCodVenta, int paisID)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWebDetalle> lst;
                using (PedidoServiceClient srv = new PedidoServiceClient())
                {
                    lst = srv.SelectDetalleBloqueoPedidoByPedidoId(paisID, pedidoID).ToList();
                }
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
                        case "CodVenta":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodVenta":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                    }
                }
                #endregion
                if (string.IsNullOrEmpty(vCodVenta))
                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                else
                    items = items.Where(p => p.CUV.ToUpper().Contains(vCodVenta.ToUpper())).ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst.ToList());

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    totalimporte = (UserData().PaisID == 4) ? lst.Sum(x => x.ImporteTotal).ToString("#,##0").Replace(',', '.') : lst.Sum(x => x.ImporteTotal).ToString("0.00"),
                    simbolo = lst[0].Simbolo,
                    rows = from a in lst
                           select new
                           {
                               id = a.PedidoID,
                               cell = new string[]
                                        {
                                           a.CUV,
                                           a.DescripcionProd,
                                           a.Cantidad.ToString(),
                                           (UserData().PaisID == 4)? a.PrecioUnidad.ToString("#,##0").Replace(',','.') : a.PrecioUnidad.ToString("0.00"), // Validación colombia req. 1478
                                           (UserData().PaisID == 4)? a.ImporteTotal.ToString("#,##0").Replace(',','.') : a.ImporteTotal.ToString("0.00")
                                           
                                       }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult BloquearPedido(ConsultaPedidoModel model)
        {
            try
            {
                Mapper.CreateMap<ConsultaPedidoModel, BEPedidoWeb>()
                    .ForMember(t => t.PedidoID, f => f.MapFrom(c => c.PedidoID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                    .ForMember(t => t.DescripcionBloqueo, f => f.MapFrom(c => c.DescripcionBloqueo));

                BEPedidoWeb pedido = Mapper.Map<ConsultaPedidoModel, BEPedidoWeb>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    pedido.PaisID = model.PaisID;
                    pedido.CodigoUsuarioModificacion = UserData().CodigoUsuario;
                    sv.UpdBloqueoPedido(pedido);
                    sv.InsertarLogPedidoWeb(model.PaisID, pedido.CampaniaID, pedido.CodigoConsultora, pedido.PedidoID, "BLOQUEO", UserData().CodigoUsuario);
                }

                return Json(new
                {
                    success = true,
                    message = "El Pedido ha sido actualizado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public JsonResult DesbloquearPedido(ConsultaPedidoModel model)
        {
            try
            {
                Mapper.CreateMap<ConsultaPedidoModel, BEPedidoWeb>()
                    .ForMember(t => t.PedidoID, f => f.MapFrom(c => c.PedidoID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

                BEPedidoWeb pedido = Mapper.Map<ConsultaPedidoModel, BEPedidoWeb>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    pedido.PaisID = model.PaisID;
                    pedido.CodigoUsuarioModificacion = UserData().CodigoUsuario;
                    sv.UpdDesbloqueoPedido(pedido);
                    sv.InsertarLogPedidoWeb(model.PaisID, pedido.CampaniaID, pedido.CodigoConsultora, pedido.PedidoID, "DESBLOQUEO", UserData().CodigoUsuario);
                }

                return Json(new
                {
                    success = true,
                    message = "El Pedido ha sido desbloqueado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public ActionResult ExportarExcel(int vPaisID, string vRegionID,
                                     string vCampaniaID, string vZonaID, string vFecha, string vTerritorioID, string vEstadoPedido,
                                     string vConsultoraID, string vBloqueado)
        {
            List<BEPedidoWeb> lst;
            using (PedidoServiceClient srv = new PedidoServiceClient())
            {
                BEPedidoWeb pedido = new BEPedidoWeb()
                {
                    PaisID = vPaisID,
                    CodigoZona = vZonaID.Equals("-1") ? "" : vZonaID,
                    CodigoConsultora = vConsultoraID,
                    CampaniaID = (string.IsNullOrEmpty(vCampaniaID) ? 0 : Convert.ToInt32(vCampaniaID)),
                    EstadoPedido = Convert.ToByte(vEstadoPedido),
                    Bloqueado = Convert.ToInt16(vBloqueado)
                };

                int? regionid = null;
                if (!string.IsNullOrEmpty(vRegionID))
                    regionid = int.Parse(vRegionID);

                int? territorioid = null;
                if (!string.IsNullOrEmpty(vTerritorioID))
                    territorioid = int.Parse(vTerritorioID);

                lst = srv.SelectPedidosWebByFilter(pedido, vFecha, regionid, territorioid).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Cod. Zona", "CodigoZona");
            dic.Add("Cod. Consultora", "CodigoConsultora");
            dic.Add("Nombre", "Nombres");
            dic.Add("Monto Pedido", "MontoPedido");
            dic.Add("Saldo Deuda", "SaldoDeuda");
            dic.Add("pedido Bloqueado", "Bloqueado");
            ExportToExcel("PedidosExcel", lst, dic);
            return View();
        }

        public ActionResult ExportarExcelBloqueo(int pedidoID, int paisID)
        {
            List<BEPedidoWebDetalle> lst;
            using (PedidoServiceClient srv = new PedidoServiceClient())
            {
                lst = srv.SelectDetalleBloqueoPedidoByPedidoId(paisID, pedidoID).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Cod. Venta", "CUV");
            dic.Add("Descripción", "DescripcionProd");
            dic.Add("Cantidad", "Cantidad");
            dic.Add("Precio Unitario", "PrecioUnidad");
            dic.Add("Precio Total", "ImporteTotal");
            ExportToExcel("PedidosBloqueoExcel", lst, dic);
            return View();
        }

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
                    //Establece las columnas
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
                        //Establece el valor para esa columna
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
                                    { // validación pais colombia req. 1478

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
                //ws.Row(1).Style.Font.Bold = true;
                //ws.Row(1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                //ws.Row(1).Style.Fill.BackgroundColor = XLColor.Aquamarine;

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;
                //ws.Columns().AdjustToContents();

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

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public ActionResult ExportarPDF(string vCampaniaddl, string vRegionddl, string vZonaddl, string vPaisddl,
                                        string vterritoriotxt, string vEstadoPedidoddl, string vCodConsultoratxt, string vBloqueadoddl, string vCampaniaddl_val,
                                        string vRegionddl_val, string vZonaddl_val, string vPaisddl_val, string vEstadoPedidoddl_val,
                                        string vBloqueadoddl_val, string vterritoriotxt_ID, string vCodConsultoratxt_ID, string vUsuario,
                                        string vTotalPedidos, string vPorFacturar)
        {
            string[] lista = new string[23];
            lista[0] = vCampaniaddl; lista[1] = vRegionddl; lista[2] = vZonaddl; lista[3] = vPaisddl;
            lista[5] = vterritoriotxt; lista[6] = vEstadoPedidoddl; lista[7] = vCodConsultoratxt; lista[8] = vBloqueadoddl; lista[9] = vCampaniaddl_val;
            lista[10] = vRegionddl_val; lista[11] = vZonaddl_val; lista[12] = vPaisddl_val; lista[14] = vEstadoPedidoddl_val;
            lista[15] = vBloqueadoddl_val; lista[16] = vterritoriotxt_ID; lista[17] = vCodConsultoratxt_ID; lista[18] = vUsuario;
            lista[19] = vTotalPedidos; lista[20] = vPorFacturar; lista[21] = UserData().BanderaImagen;
            lista[22] = UserData().NombrePais;

            Session["PaisID"] = UserData().PaisID;

            Util.ExportToPdfWebPages(this, "PedidosPDF.pdf", "ConsultaPedidoImp", Util.EncriptarQueryString(lista));
            //Util.ExportToPdf(this, "PedidosPDF.pdf", "ConsultaPedidoImp", Util.EncriptarQueryString(lista));
            return View();
        }

        public ActionResult ExportarPDFBloqueo(string vCodigoConsultora, string vNombres, string vDireccion, string vCodigoTerritorio, string vPedidoID,
                                               string vCampaniaID, string vpage, string vsortname, string vsortorder, string vrowNum, string vpaisID, string vUsuario,
                                               string vTotalImporte)
        {
            string[] lista = new string[16];

            lista[0] = vCodigoConsultora; lista[1] = vNombres; lista[2] = vDireccion; lista[3] = vCodigoTerritorio; lista[4] = vPedidoID;
            lista[5] = vCampaniaID; lista[6] = vpage; lista[7] = vsortname; lista[8] = vsortorder; lista[9] = vrowNum; lista[10] = vpaisID;
            lista[11] = vUsuario; lista[12] = UserData().BanderaImagen; lista[13] = UserData().NombrePais; lista[14] = UserData().Simbolo;
            lista[15] = vTotalImporte;

            Util.ExportToPdfWebPages(this, "PedidosBloqueoPDF.pdf", "BloqueoPedidoImp", Util.EncriptarQueryString(lista));
            //Util.ExportToPdf(this, "PedidosBloqueoPDF.pdf", "BloqueoPedidoImp", Util.EncriptarQueryString(lista));
            return View();
        }

        private IEnumerable<PaisModel> CargarDropDowListPaises()
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
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        #endregion
    }
}
