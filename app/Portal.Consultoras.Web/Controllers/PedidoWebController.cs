using ClosedXML.Excel;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoWebController : BaseController
    {
        #region Actions

        public ActionResult PedidoWeb()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "PedidoWeb/PedidoWeb"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View();
        }

        public ActionResult PedidoWebDetalle()
        {
            if (Request.Form["data"] == null) return RedirectToAction("PedidoWeb");
            JObject jObject = JObject.Parse(Request.Form["data"]);

            PedidoWebDetalleModel model = new PedidoWebDetalleModel
            {
                CampaniaID = (int)jObject["CampaniaId"],
                CodigoConsultora = userData.CodigoConsultora,
                NombreConsultora = userData.NombreConsultora,
                Direccion = userData.Direccion,
                CodigoZona = userData.CodigoZona,
                Simbolo = userData.Simbolo
            };


            List<ServicePedido.BEPedidoWebDetalle> olstPedido;
            using (ServicePedido.PedidoServiceClient sv = new ServicePedido.PedidoServiceClient())
            {
                var bePedidoWebDetalleParametros =
                    new ServicePedido.BEPedidoWebDetalleParametros
                    {
                        PaisId = userData.PaisID,
                        CampaniaId = model.CampaniaID,
                        ConsultoraId = ObtenerConsultoraId(),
                        Consultora = "",
                        EsBpt = EsOpt() == 1,
                        CodigoPrograma = userData.CodigoPrograma,
                        NumeroPedido = userData.ConsecutivoNueva
                    };

                olstPedido = sv.SelectByCampania(bePedidoWebDetalleParametros).ToList();
            }

            model.TieneDescuentoCuv = userData.EstadoSimplificacionCUV &&
                olstPedido.Any(item => string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOfertaCUV);

            decimal subtotal = 0, descuento = 0, total;
            if (model.TieneDescuentoCuv)
            {
                subtotal = olstPedido.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
                descuento = -olstPedido[0].DescuentoProl;
                total = subtotal + descuento;
            }
            else total = olstPedido.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);

            if (userData.PaisID == 4)
            {
                model.SubTotalString = string.Format("{0:#,##0}", subtotal).Replace(',', '.');
                model.DescuentoString = string.Format("{0:#,##0}", descuento).Replace(',', '.');
                model.TotalString = string.Format("{0:#,##0}", total).Replace(',', '.');
            }
            else
            {
                model.SubTotalString = string.Format("{0:N2}", subtotal);
                model.DescuentoString = string.Format("{0:N2}", descuento);
                model.TotalString = string.Format("{0:N2}", total);
            }
            return View(model);
        }

        public ActionResult ConsultarPedidoWeb(string sidx, string sord, int page, int rows)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWeb> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.GetPedidosWebByConsultora(userData.PaisID, ObtenerConsultoraId()).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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
                        case "Clientes":
                            items = lst.OrderBy(x => x.Clientes);
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
                        case "Clientes":
                            items = lst.OrderByDescending(x => x.Clientes);
                            break;
                        case "EstadoPedidoDesc":
                            items = lst.OrderByDescending(x => x.EstadoPedidoDesc);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                if (userData.PaisID == 4)
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
                                (userData.Simbolo + " " +
                                 string.Format("{0:#,##0}", a.ImporteTotal).Replace(',', '.')),
                                a.Clientes.ToString(),
                                (userData.ZonaValida ? a.EstadoPedidoDesc : "Registrado"),
                                a.ConsultoraID.ToString(),
                                a.PedidoID.ToString()
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
                                (userData.Simbolo + " " + string.Format("{0:#,##0.00}", a.ImporteTotal)),
                                a.Clientes.ToString(),
                                (userData.ZonaValida ? a.EstadoPedidoDesc : "Registrado"),
                                a.ConsultoraID.ToString(),
                                a.PedidoID.ToString()
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public string DescripcionCampania(string campaniaId)
        {
            string desCamp;
            try
            {
                desCamp = campaniaId.Substring(0, 4) + "-C" + campaniaId.Substring(4, 2);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                desCamp = campaniaId;
            }
            return desCamp;
        }

        public ActionResult ConsultarPedidoWebDetalleClientes(string sidx, string sord, int page, int rows, string CampaniaId)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWebDetalle> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.GetClientesByCampania(userData.PaisID, int.Parse(CampaniaId), ObtenerConsultoraId()).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEPedidoWebDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderBy(x => x.Nombre);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderByDescending(x => x.Nombre);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ClienteID,
                               cell = new string[]
                               {
                                   a.Nombre,
                                   a.ClienteID.ToString(),
                                   a.eMail
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarPedidoWebDetalleProductos(string sidx, string sord, int page, int rows, string CampaniaId, string ClientId)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWebDetalle> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(CampaniaId), ObtenerConsultoraId(), int.Parse(ClientId)).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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
                            items = lst.OrderBy(x => x.CUV);
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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                if (userData.PaisID == 4)
                {
                    var data = new
                    {
                        simbolo = userData.Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = string.Format("{0:#,##0}", (from req in lst select req.ImporteTotal).Sum()).Replace(',', '.'),
                        rows = from a in items
                               select new
                               {
                                   id = a.PedidoDetalleID,
                                   cell = new string[]
                                   {
                                       a.CUV,
                                       a.DescripcionProd,
                                       a.Cantidad.ToString(),
                                       (userData.Simbolo + " " + string.Format("{0:#,##0}",a.PrecioUnidad).Replace(',','.')),
                                       (userData.Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
                                       a.ImporteTotal.ToString("#0.00"),
                                       a.IndicadorOfertaCUV.ToString()
                                    }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new
                    {
                        simbolo = userData.Simbolo,
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        totalSum = string.Format("{0:#,##0.00}", (from req in lst select req.ImporteTotal).Sum()),
                        rows = from a in items
                               select new
                               {
                                   id = a.PedidoDetalleID,
                                   cell = new string[]
                                   {
                                        a.CUV,
                                        a.DescripcionProd,
                                        a.Cantidad.ToString(),
                                        (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.PrecioUnidad)),
                                        (userData.Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal)),
                                        a.ImporteTotal.ToString("#0.00"),
                                       a.IndicadorOfertaCUV.ToString()
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            return RedirectToAction("PedidoWeb");
        }

        [HttpPost]
        public JsonResult EnviarEmail(string ClientId, string Email, string CampaniaId)
        {
            try
            {
                string nombreCliente = string.Empty;
                if (userData.UsuarioPrueba == 1)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Esta opción no está habilitada para los Usuarios de Prueba.",
                        extra = ""
                    });
                }
                else
                {
                    decimal total = 0;
                    List<BEPedidoWebDetalle> lst;
                    using (ClienteServiceClient sv = new ClienteServiceClient())
                    {
                        lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(CampaniaId), userData.ConsultoraID, int.Parse(ClientId)).ToList();
                    }


                    #region Mensaje a Enviar
                    var txtBuil = new StringBuilder();

                    for (int i = 0; i < lst.Count; i++)
                    {

                        txtBuil.Append("<tr>");
                        txtBuil.Append("<td style='font-size:11px; width: 126px; text-align: center;'>");
                        txtBuil.Append("" + lst[i].CUV + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append(" <td style='font-size:11px; width: 347px;'>");
                        txtBuil.Append("" + lst[i].DescripcionProd + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; width: 124px; text-align: center;'>");
                        txtBuil.Append("" + lst[i].Cantidad.ToString() + "");
                        txtBuil.Append("</td>");

                        if (userData.PaisID == 4)
                        {
                            txtBuil.Append("<td style='font-size:11px; width: 182px; text-align: center;'>");
                            txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].PrecioUnidad).Replace(',', '.') + "");
                            txtBuil.Append("</td>");
                            txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                            txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].ImporteTotal).Replace(',', '.') + "");
                            txtBuil.Append("</td>");
                        }
                        else
                        {
                            txtBuil.Append("<td style='font-size:11px; width: 182px; text-align: center;'>");
                            txtBuil.Append("" + userData.Simbolo + lst[i].PrecioUnidad.ToString("#0.00") + "");
                            txtBuil.Append("</td>");
                            txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                            txtBuil.Append("" + userData.Simbolo + lst[i].ImporteTotal.ToString("#0.00") + "");
                            txtBuil.Append("</td>");
                        }
                        txtBuil.Append("</tr>");

                        total += lst[i].ImporteTotal;
                        nombreCliente = lst[i].NombreCliente;
                    }

                    string mailbodygrid = txtBuil.ToString();

                    String[] nombreClienteConsultora = nombreCliente.Split(' ');

                    string mailBody = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
                    if (ClientId.Equals("0"))
                    {
                        mailBody += "<div style='font-size:12px;'>Hola " + userData.PrimerNombre + ",</div> <br />";

                    }
                    else
                    {
                        mailBody += "<div style='font-size:12px;'>Hola " + nombreClienteConsultora[0] + ",</div> <br />";
                    }

                    mailBody += "<div style='font-size:12px;'> Te envío el detalle de tu pedido para esta campaña. <br/>Recuerda que el monto a pagar es de <b>" + userData.Simbolo + total.ToString("#0.00") + "</b></div> <br /><br />";
                    mailBody += "<table border='1' style='width: 80%;'>";
                    mailBody += "<tr style='color: #FFFFFF'>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 126px; background-color: #666699;'>";
                    mailBody += "Cod. Venta";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #666699;'>";
                    mailBody += "Descripción";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #666699;'>";
                    mailBody += "Cantidad";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #666699;'>";
                    mailBody += "Precio Unit.";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>";
                    mailBody += "Precio Total";
                    mailBody += "</td>";
                    mailBody += "</tr>";

                    mailBody += mailbodygrid;

                    mailBody += "<tr>";
                    mailBody += "<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>";
                    mailBody += "Total :";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; text-align: center; font-weight: bold'>";
                    if (userData.PaisID == 4)
                    {
                        mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", total).Replace(',', '.') + "";
                    }
                    else
                    {
                        mailBody += "" + userData.Simbolo + total.ToString("#0.00") + "";
                    }

                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";
                    mailBody += "<br /><br />";
                    mailBody += "<div style='font-size:12px;'>Muchas Gracias,</div>";
                    mailBody += "<br /><br />";
                    mailBody += "<table border='0'>";
                    mailBody += "<tr>";
                    mailBody += "<td>";
                    mailBody += "<img src='cid:Logo' border='0' />";
                    mailBody += "</td>";
                    mailBody += "<td style='text-align: center; font-size:12px;'>";
                    mailBody += "<strong>" + userData.NombreConsultora + "</strong> <br />";
                    mailBody += "<strong>Consultora</strong>";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";

                    #endregion
                    Util.EnviarMail("no-responder@somosbelcorp.com", ClientId.Equals("0") ? userData.EMail : Email, "(" + userData.CodigoISO + ") Pedido Solicitado", mailBody, true, userData.NombreConsultora);


                    return Json(new
                    {
                        success = true,
                        message = "Se envió satisfactoriamente el correo al cliente seleccionado.",
                        extra = ""
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el envió de correo, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el envió de correo, intente nuevamente.",
                    extra = ""
                });
            }
        }

        public ActionResult ExportarExcel(string vCampaniaID, bool tieneDescuentoCuv, string subtotalString, string descuentoString, string totalString)
        {
            List<BEPedidoWebDetalle> lstCabecera;
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lstCabecera = sv.GetClientesByCampania(userData.PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId()).OrderBy(p => p.Nombre).ToList();
            }

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();
            List<BEPedidoWebDetalle> lstDetalles = new List<BEPedidoWebDetalle>();
            foreach (BEPedidoWebDetalle item in lstCabecera)
            {
                List<BEPedidoWebDetalle> lstDetallesTemp;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lstDetallesTemp = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId(), item.ClienteID).ToList();
                }

                decimal suma = lstDetallesTemp.Sum(p => p.ImporteTotal);
                dicCabeceras.Add(new KeyValuePair<int, string>(lstDetallesTemp.Count, item.Nombre));
                lstDetallesTemp.Add(new BEPedidoWebDetalle()
                {
                    ImporteTotalPedido = suma
                });
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

            ExportToExcelMultiple("PedidosWebExcel", lstDetalles, dicCabeceras, dicDetalles, arrTotal, tieneDescuentoCuv, subtotalString, descuentoString, totalString);
            return View();
        }

        private void ExportToExcelMultiple(string filename, List<BEPedidoWebDetalle> sourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
            Dictionary<string, string> columnDetailDefinition, string[] arrTotal, bool tieneDescuentoCuv, string subtotalString, string descuentoString, string totalString)
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
                            BEPedidoWebDetalle source = sourceDetails[i];
                            var arr = column.Contains("#")
                                ? column.Split('#')
                                : new string[] { "", column };

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
                                var importeTotal = userData.PaisID == 4
                                    ? source.ImporteTotal.ToString("#,##0").Replace(',', '.')
                                    : source.ImporteTotal.ToString("0.00");

                                ws.Cell(row, col).Value = arr[0] + importeTotal;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                            }

                            else if (arr[1] == "PrecioUnidad")
                            {
                                var precioUnidad = userData.PaisID == 4
                                    ? source.PrecioUnidad.ToString("#,##0").Replace(',', '.')
                                    : source.PrecioUnidad.ToString("0.00");

                                ws.Cell(row, col).Value = arr[0] + precioUnidad;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
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
                        titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                        titlesStyle.Fill.BackgroundColor = XLColor.NoColor;
                        titlesStyleh.Font.FontColor = XLColor.FromHtml("#000000");
                        wb.NamedRanges.NamedRange("Totals").Ranges.Style = titlesStyle;

                        var importeTotalPedido = userData.PaisID == 4
                            ? (sourceDetails[i]).ImporteTotalPedido.ToString("#,##0").Replace(',', '.')
                            : (sourceDetails[i]).ImporteTotalPedido.ToString("0.00");

                        ws.Cell(row, col - 2).Value = arrTotal[0];
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] + importeTotalPedido;
                    }
                    row++;
                    var index = keyvalue.Key + 1;
                    sourceDetails.RemoveRange(0, index);
                }

                if (tieneDescuentoCuv)
                {
                    ws.Range(row + 1, col - 2, row + 3, col - 1).Style.Font.Bold = true;
                    ws.Range(row + 1, col - 2, row + 3, col - 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                    ws.Cell(row + 1, col - 2).Value = "SubTotal: ";
                    ws.Cell(row + 1, col - 1).Value = simbolo + " " + subtotalString;
                    ws.Cell(row + 2, col - 2).Value = "Descuento por ofertas con más de un precio: ";
                    ws.Cell(row + 2, col - 1).Value = simbolo + " " + descuentoString;
                    ws.Cell(row + 3, col - 2).Value = "Monto Total: ";
                    ws.Cell(row + 3, col - 1).Value = simbolo + " " + totalString;
                }
                else
                {
                    ws.Range(row + 1, col - 2, row + 1, col - 1).Style.Font.Bold = true;
                    ws.Range(row + 1, col - 2, row + 1, col - 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                    ws.Cell(row + 1, col - 2).Value = "Monto Total: ";
                    ws.Cell(row + 1, col - 1).Value = simbolo + " " + totalString;
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
        #endregion


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
    }
}
