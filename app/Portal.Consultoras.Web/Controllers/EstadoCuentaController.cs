using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Common;
using System.Web.Script.Serialization;
using Portal.Consultoras.Web.ServiceODS;
using System.Threading.Tasks;
using System.ServiceModel;
using ClosedXML.Excel;
using System.IO;
using Portal.Consultoras.Web.ServicePedido;
using AutoMapper;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceContenido; //R2073

namespace Portal.Consultoras.Web.Controllers
{
    public class EstadoCuentaController : BaseController
    {
        // GET: /EstadoCuenta/

        #region Action

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "EstadoCuenta/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var model = new EstadoCuentaModel();
                List<EstadoCuentaModel> lst = EstadodeCuenta();
                List<BEConsultora> lst_Consultora = new List<BEConsultora>();

                //Funcionalidad no activada, por defecto se colocará al IndicadorFlexipado para la página en 0.
                ViewBag.IndicadorFlexiPago = 0;
                //string hasFlexipago = System.Configuration.ConfigurationManager.AppSettings.Get("PaisesFlexipago") ?? string.Empty;
                //if (hasFlexipago.Contains(userData.CodigoISO))
                //{
                //    int flexipago = userData.IndicadorFlexiPago;
                //    ViewBag.IndicadorFlexiPago = flexipago;
                //    if (flexipago != 0)
                //    {
                //        ViewBag.CuotasCampaniaFlexipago = ObtenerCuotasFlexipago();
                //        //ViewBag.CuotasCampaniaFlexipago = new List<OfertaFlexipagoModel>();
                //        ViewBag.MontoMinimoFlexipago = ObtenerMontoMinimo();
                //        int c = userData.CampaniaID;
                //        ViewBag.CampaniaActual = c.ToString().Substring(4, 2);
                //        ViewBag.CampaniaSig = string.Format("{0}", c + 1).Substring(4, 2);
                //    }
                //}
                //else
                //    ViewBag.IndicadorFlexiPago = 0;

                if (lst_Consultora.Count == 0) model.CorreoConsultora = userData.EMail;
                else model.CorreoConsultora = userData.EMail;

                if (lst.Count == 0)
                {
                    model.FechaVencimiento = "--/--";
                    if (userData.PaisID == 4) // Validación para país colombia req. 1478
                    {
                        model.MontoPagar = "0";
                    }
                    else
                    {
                        model.MontoPagar = "0.0";
                    }
                }
                else
                {
                    //if (!lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("19000101") && !lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("00010101"))
                    //    model.FechaVencimiento = lst[lst.Count - 1].Fecha.ToString("dd/MM/yyyy");
                    //else
                    //    model.FechaVencimiento = string.Empty;

                    var fechaVencimiento = DateTime.MinValue;
                    using (ContenidoServiceClient sv = new ContenidoServiceClient())
                    {
                        if (userData.PaisID == 4 || userData.PaisID == 11)
                            model.MontoPagar = sv.GetDeudaTotal(userData.PaisID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente.ToString();
                        else
                            model.MontoPagar = sv.GetSaldoPendiente(userData.PaisID, userData.CampaniaID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente.ToString();

                        //fechaVencimiento = sv.GetFechaVencimiento(userData.PaisID, userData.CodigoISO, userData.CampaniaID, userData.CodigoConsultora);

                        model.FechaVencimiento = fechaVencimiento.ToString("dd/MM/yyyy") == "01/01/0001"
                            ? "--/--"
                            : fechaVencimiento.ToString("dd/MM/yyyy");
                    }
                }
                model.Simbolo = string.Format("{0} ", userData.Simbolo);
                ViewBag.CodigoISO = userData.CodigoISO;
                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new EstadoCuentaModel());

        }

        public ActionResult ConsultarEstadoCuenta(string sidx, string sord, int page, int rows, string vCampania)
        {
            if (ModelState.IsValid)
            {
                List<EstadoCuentaModel> lst;

                lst = EstadodeCuenta();
                if (lst.Count != 0)
                {
                    lst.RemoveAt(lst.Count - 1);
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
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

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Fecha":
                            items = lst.OrderBy(x => x.Fecha).ThenByDescending(x => x.TipoMovimiento);
                            break;
                        case "Glosa":
                            items = lst.OrderBy(x => x.Glosa);
                            break;
                        case "Cargo":
                            items = lst.OrderBy(x => x.Cargo);
                            break;
                        case "Abono":
                            items = lst.OrderBy(x => x.Abono);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Fecha":
                            items = lst.OrderByDescending(x => x.Fecha).ThenBy(x => x.TipoMovimiento);
                            break;
                        case "Glosa":
                            items = lst.OrderByDescending(x => x.Glosa);
                            break;
                        case "Cargo":
                            items = lst.OrderByDescending(x => x.Cargo);
                            break;
                        case "Abono":
                            items = lst.OrderByDescending(x => x.Abono);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, lst);

                items.Where(x => x.Glosa == null).Update(r => r.Glosa = string.Empty);


                // Creamos la estructura
                if (userData.PaisID == 4) // validación para colombia req. 1478
                {
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
                                   a.Fecha.ToString("dd/MM/yyyy"),
                                   a.Glosa.ToString(),
                                   string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0}", a.Cargo).Replace(',','.'),
                                   string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0}", a.Abono).Replace(',','.')
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
                                   cell = new string[] 
                               {
                                   a.Fecha.ToString("dd/MM/yyyy"),
                                   a.Glosa.ToString(),
                                   string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0.00}", a.Cargo),
                                   string.Format("{0} ", userData.Simbolo) + string.Format("{0:#,##0.00}", a.Abono)
                                }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }

            }
            return RedirectToAction("Index", "Bienvenida");
        }
        public JsonResult EnviarCorreo(string correo)
        {
            try
            {
                List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();
                lst = EstadodeCuenta();
                //Mejora-Correo
                //string nomPais = Util.ObtenerNombrePaisPorISO(userData.CodigoISO);
                #region cotnenido del correo
                /*CO-RE2584 - CS(CGI) */
                string cadena = "<span style='font-family:Calibri'><h2> Estado de Cuenta Belcorp </h2></span>" +
                                "<table width='650px' border = '1px' bordercolor='black' cellpadding='5px' cellspacing='0px' bgcolor='dddddd' >" +
                                "<tr>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Fecha</th>" +
                                    "<th bgcolor='666666' width='350px' align='center'><font color='#FFFFFF'>Últimos Movimientos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Pedidos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Abonos</th>" +
                                "</tr>";

                if (userData.PaisID == 4) // validación para colombia req. 1478
                {

                    for (int i = 0; i < lst.Count - 1; i++)
                    {
                        cadena = cadena + "<tr>" +
                                            "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                            "<td align='left'>" + lst[i].Glosa + "</td>" +
                                            "<td align='right'>" + string.Format("{0:#,##0}", lst[i].Cargo).Replace(',', '.') + "</td>" +
                                            "<td align='right'>" + string.Format("{0:#,##0}", lst[i].Abono).Replace(',', '.') + "</td>" +
                                          "</tr>";
                    }
                }
                else
                {
                    for (int i = 0; i < lst.Count - 1; i++)
                    {
                        cadena = cadena + "<tr>" +
                                            "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                            "<td align='left'>" + lst[i].Glosa + "</td>" +
                                            "<td align='right'>" + lst[i].Cargo.ToString("0.00") + "</td>" +
                                            "<td align='right'>" + lst[i].Abono.ToString("0.00") + "</td>" +
                                          "</tr>";
                    }
                }
                //R2524 - JICM - Eliminando FEcha Vencimiento,Por ahora Si no existen movimientos no se mostrará 0 en la etiqueta
                //Total a pagar si no que mostrará el valor del Monto Total a Pagar.
                if (lst.Count > 0)
                {
                    string fechaVencimiento = string.Empty;
                    if (!lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("19000101") && !lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("00010101"))
                    {
                        fechaVencimiento = lst[lst.Count - 1].Fecha.ToString("dd/MM/yyyy");
                    }
                    //R2524 - JICM - Formateando decimal y Eliminando Fecha Vencimiento
                    //R2524 - JICM - CC - Validación Cargo y Abono para el envío de Mail
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
                // else
                // {
                //R2524 - JICM - Eliminando FEcha Vencimiento,Por ahora Si no existen movimientos no se mostrará 0 en la etiqueta
                //Total a pagar si no que mostrará el valor del Monto Total a Pagar.

                //cadena = cadena + "</table><br /><br />" +
                //                  "TOTAL A PAGAR: " + "0" + "<br />" ;

                //  }


                //Mejora - Correo
                //cadena += "<table border='0' style='width: 650px;'>";
                //cadena += "<tr>";
                //cadena += "<td style='font-family:Arial, Helvetica, sans-serif, serif; font-weight:bold; font-size:12px; text-align:right; padding-top:8px;'>";
                //cadena += "Belcorp - " + nomPais;
                //cadena += "</td>";
                //cadena += "</tr>";
                //cadena += "</table>";

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
        public ActionResult LugaresPago()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "EstadoCuenta/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                ViewBag.CodigoISO = userData.CodigoISO;
                return View();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new EstadoCuentaModel());
        }

        #region Ofertas Flexipago

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private List<OfertaFlexipagoModel> ObtenerCuotasFlexipago()
        {
            List<OfertaFlexipagoModel> lista;
            int vPaisID = userData.PaisID;
            string consultora = userData.CodigoConsultora;
            string simbolo = userData.Simbolo;
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                int CampaniaID = userData.CampaniaID;
                List<BEOfertaFlexipago> lstresult = svc.GetCuotasAnterioresFlexipago(vPaisID, consultora, CampaniaID).ToList();

                Mapper.CreateMap<BEOfertaFlexipago, OfertaFlexipagoModel>()
               .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
               .ForMember(t => t.MontoTotal, f => f.MapFrom(c => c.MontoTotal))
               .ForMember(t => t.MontoPagado, f => f.MapFrom(c => c.MontoPagado))
               .ForMember(t => t.MontoPorCuota, f => f.MapFrom(c => c.MontoPorCuota))
               .ForMember(t => t.InteresePorCuota, f => f.MapFrom(c => c.InteresePorCuota))
               .ForMember(t => t.CuotaPendCampaniaActual, f => f.MapFrom(c => c.CuotaPendCampaniaActual))
               .ForMember(t => t.CuotaPendCampaniaSiguiente, f => f.MapFrom(c => c.CuotaPendCampaniaSiguiente));

                lista = Mapper.Map<IList<BEOfertaFlexipago>, List<OfertaFlexipagoModel>>(lstresult);
                lista.Each(p => p.Simbolo = simbolo);
            }
            return lista;
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private string ObtenerMontoMinimo()
        {
            int vPaisID = userData.PaisID;
            string consultora = userData.CodigoConsultora;
            string result = string.Empty;
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                int CampaniaID = userData.CampaniaID;
                BEOfertaFlexipago oBe = svc.GetLineaCreditoFlexipago(vPaisID, consultora, CampaniaID);
                result = string.Format("{0:#,##0.00}", (oBe.MontoMinimoFlexipago < 0 ? 0M : oBe.MontoMinimoFlexipago));
            }
            return result;
        }

        #endregion

        #endregion

        #region Metodos

        //R2073
        private List<EstadoCuentaModel> EstadodeCuenta()
        {
            List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();
            List<BEEstadoCuenta> EstadoCuenta = new List<BEEstadoCuenta>();
            try
            {
                //Inicio ITG 1793 HFMG
                using (SACServiceClient client = new SACServiceClient())
                {
                    EstadoCuenta = client.GetEstadoCuentaConsultora(userData.PaisID, userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora).ToList();
                }
                //Fin ITG 1793 HFMG
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            foreach (var ec in EstadoCuenta)
            {
                lst.Add(new EstadoCuentaModel
                {
                    Fecha = ec.FechaRegistro,
                    Glosa = ec.DescripcionOperacion,
                    Cargo = ec.Cargo,
                    Abono = ec.Abono
                });
            }
            return lst;
        }

        //R2073
        public ActionResult ExportarExcel()
        {
            //R2524 - Variables Abono y Cargo
            decimal cargo = 0;
            decimal abono = 0;
            List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();
            List<BEEstadoCuenta> EstadoCuenta = new List<BEEstadoCuenta>();
            try
            {
                //Inicio ITG 1793 HFMG
                using (SACServiceClient client = new SACServiceClient())
                {
                    EstadoCuenta = client.GetEstadoCuentaConsultora(userData.PaisID, userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora).ToList();
                }
                //Fin ITG 1793 HFMG
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();

            foreach (var ec in EstadoCuenta)
            {
                lst.Add(new EstadoCuentaModel
                {
                    Fecha = ec.FechaRegistro,
                    Glosa = ec.DescripcionOperacion,
                    Cargo = ec.Cargo,
                    Abono = ec.Abono
                });
            }

            if (lst.Count != 0)
            {
                EstadoCuentaModel cuenta = lst[lst.Count - 1];
                cargo = cuenta.Cargo;
                abono = cuenta.Abono;
                lst.RemoveAt(lst.Count - 1);
                //R2524 - JICM - Antes de que se borre el monto se guarda el valor



                dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, userData.NombreConsultora));
                lst.Add(new EstadoCuentaModel()
                {
                    Cargo = cuenta.Cargo
                });
            }


            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("Fecha", "Fecha");
            dic.Add("Ultimos Movimientos", "Glosa");
            dic.Add("Pedidos", userData.Simbolo + " #Cargo");
            dic.Add("Abonos", userData.Simbolo + " #Abono");

            string[] arrTotal = { "Total a Pagar:", userData.Simbolo + " #Cargo" };

            //R2524 - Agregando parámetros adicionales
            ExportToExcelMultiple("EstadoCuentaExcel", lst, dicCabeceras, dic, arrTotal, cargo, abono);
            return new EmptyResult();

        }

        private void ExportToExcelMultiple(string filename, List<EstadoCuentaModel> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
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
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#00A2E8");
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
                            EstadoCuentaModel source = SourceDetails[i];
                            //foreach (PropertyInfo property in source.GetType().GetProperties())
                            //{
                            //for (int m = 0; m < 5; m++)
                            //{
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
                                { // validación para pais colombia req. 1478
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
                                { // validación para pais colombia req. 1478
                                    abono = source.Abono.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    abono = source.Abono.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + abono;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            //}
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
                        { // validación para pais colombia req. 1478
                            //R2524 - JICM - Se validará si existe valor en abono y cargo
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
                            //R2524 - JICM - Se validará si existe valor en abono y cargo - sobre el req 1478
                            if (Math.Abs(cargoTotal) > 0)
                            {
                                cargo = cargoTotal.ToString("0.00");
                            }
                            else if (Math.Abs(abonoTotal) > 0)
                            {
                                cargo = abonoTotal.ToString("0.00");
                            }


                        }

                        ws.Cell(row, col - 2).Value = arrTotal[0]; //Total:
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

        public BEPager Paginador(BEGrid item, List<EstadoCuentaModel> lst)
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
