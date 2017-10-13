﻿using ClosedXML.Excel;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return View();
        }

        public ActionResult PedidoWebDetalle()
        {
            if (Request.Form["data"] == null) return RedirectToAction("PedidoWeb");
            JObject jObject = JObject.Parse(Request.Form["data"]);
            UsuarioModel userData = UserData();
            PedidoWebDetalleModel model = new PedidoWebDetalleModel();

            model.CampaniaID = (int)jObject["CampaniaId"];
            model.CodigoConsultora = userData.CodigoConsultora;
            model.NombreConsultora = userData.NombreConsultora;
            model.Direccion = userData.Direccion;
            model.CodigoZona = userData.CodigoZona;
            model.Simbolo = userData.Simbolo;

            List<ServicePedido.BEPedidoWebDetalle> olstPedido = new List<ServicePedido.BEPedidoWebDetalle>();
            using (ServicePedido.PedidoServiceClient sv = new ServicePedido.PedidoServiceClient())
            {
                olstPedido = sv.SelectByCampania(userData.PaisID, model.CampaniaID, ObtenerConsultoraId(), "", EsOpt()).ToList();//ITG 1793 HFMG
            }

            model.TieneDescuentoCuv = userData.EstadoSimplificacionCUV && olstPedido != null &&
                olstPedido.Any(item => string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOfertaCUV);

            decimal subtotal = 0, descuento = 0, total = 0;
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
                    //lst = sv.GetPedidosWebByConsultora(UserData().PaisID, UserData().ConsultoraID).ToList().FindAll(x => x.CampaniaID == UserData().CampaniaID);
                    //Inicio ITG 1793 HFMG
                    lst = sv.GetPedidosWebByConsultora(UserData().PaisID, ObtenerConsultoraId()).ToList();
                    //Fin ITG 1793 HFMG
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                //UserData().ZonaValida

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
                                   (UserData().Simbolo + " " +  string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
                                   a.Clientes.ToString(),
                                   (UserData().ZonaValida ? a.EstadoPedidoDesc : "Registrado"),
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
                                   (UserData().Simbolo + " " +  string.Format("{0:#,##0.00}",a.ImporteTotal)),
                                   a.Clientes.ToString(),
                                   (UserData().ZonaValida ? a.EstadoPedidoDesc : "Registrado"),
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

        public string DescripcionCampania(string CampaniaID)
        {
            string DesCamp = string.Empty;
            try
            {
                DesCamp = CampaniaID.Substring(0, 4) + "-C" + CampaniaID.Substring(4, 2);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                DesCamp = CampaniaID;
            }
            return DesCamp;
        }

        public ActionResult ConsultarPedidoWebDetalleClientes(string sidx, string sord, int page, int rows, string CampaniaId)
        {
            if (ModelState.IsValid)
            {
                List<BEPedidoWebDetalle> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    //Inicio ITG 1793 HFMG
                    lst = sv.GetClientesByCampania(UserData().PaisID, int.Parse(CampaniaId), ObtenerConsultoraId()).ToList();
                    //Fin ITG 1793 HFMG
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);


                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
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
                    //Inicio ITG 1793 HFMG
                    lst = sv.GetPedidoWebDetalleByCliente(UserData().PaisID, int.Parse(CampaniaId), ObtenerConsultoraId(), int.Parse(ClientId)).ToList();
                    //Fin ITG 1793 HFMG
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
                                       (UserData().Simbolo + " " + string.Format("{0:#,##0}",a.PrecioUnidad).Replace(',','.')),
                                       (UserData().Simbolo + " " + string.Format("{0:#,##0}",a.ImporteTotal).Replace(',','.')),
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
                        simbolo = UserData().Simbolo,
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
                                        (UserData().Simbolo + " " + string.Format("{0:#,##0.00}",a.PrecioUnidad)),
                                        (UserData().Simbolo + " " + string.Format("{0:#,##0.00}",a.ImporteTotal)),
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
                //Inicio ITG 1793 HFMG
                string NombreCliente = string.Empty;
                if (UserData().UsuarioPrueba == 1)
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
                    decimal Total = 0;
                    List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();
                    using (ClienteServiceClient sv = new ClienteServiceClient())
                    {
                        lst = sv.GetPedidoWebDetalleByCliente(UserData().PaisID, int.Parse(CampaniaId), UserData().ConsultoraID, int.Parse(ClientId)).ToList();
                    }


                    #region Mensaje a Enviar
                    //Mejora - Correo
                    //string nomPais = Util.ObtenerNombrePaisPorISO(UserData().CodigoISO);
                    string mailBody = string.Empty;
                    /*RE2584 - CS(CGI) - INI*/
                    string mailbodygrid = string.Empty;

                    /* Armado de Data */
                    for (int i = 0; i < lst.Count; i++)
                    {

                        mailbodygrid += "<tr>";
                        mailbodygrid += "<td style='font-size:11px; width: 126px; text-align: center;'>";
                        mailbodygrid += "" + lst[i].CUV.ToString() + "";
                        mailbodygrid += "</td>";
                        mailbodygrid += " <td style='font-size:11px; width: 347px;'>";
                        mailbodygrid += "" + lst[i].DescripcionProd.ToString() + "";
                        mailbodygrid += "</td>";
                        mailbodygrid += "<td style='font-size:11px; width: 124px; text-align: center;'>";
                        mailbodygrid += "" + lst[i].Cantidad.ToString() + "";
                        mailbodygrid += "</td>";
                        if (UserData().PaisID == 4) // validación para colombia req. 1478
                        {
                            mailbodygrid += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailbodygrid += "" + UserData().Simbolo + string.Format("{0:#,##0}", lst[i].PrecioUnidad).Replace(',', '.') + "";
                            mailbodygrid += "</td>";
                            mailbodygrid += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailbodygrid += "" + UserData().Simbolo + string.Format("{0:#,##0}", lst[i].ImporteTotal).Replace(',', '.') + "";
                            mailbodygrid += "</td>";

                        }
                        else
                        {
                            mailbodygrid += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailbodygrid += "" + UserData().Simbolo + lst[i].PrecioUnidad.ToString("#0.00") + "";
                            mailbodygrid += "</td>";
                            mailbodygrid += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailbodygrid += "" + UserData().Simbolo + lst[i].ImporteTotal.ToString("#0.00") + "";
                            mailbodygrid += "</td>";
                        }
                        mailbodygrid += "</tr>";
                        Total += lst[i].ImporteTotal;
                        NombreCliente = lst[i].NombreCliente.ToString();
                    }
                    String[] NombreClienteConsultora = NombreCliente.Split(' ');

                    mailBody = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
                    if (ClientId.ToString().Equals("0"))
                    {
                        mailBody += "<div style='font-size:12px;'>Hola " + UserData().PrimerNombre + ",</div> <br />";

                    }
                    else
                    {
                        mailBody += "<div style='font-size:12px;'>Hola " + NombreClienteConsultora[0] + ",</div> <br />";
                    }

                    mailBody += "<div style='font-size:12px;'> Te envío el detalle de tu pedido para esta campaña. <br/>Recuerda que el monto a pagar es de <b>" + UserData().Simbolo + Total.ToString("#0.00") + "</b></div> <br /><br />";
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

                    /*RE2584 - CS(CGI) - FIN*/


                    /* Fin de Armado de Data*/
                    mailBody += "<tr>";
                    mailBody += "<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>";
                    mailBody += "Total :";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; text-align: center; font-weight: bold'>";
                    if (UserData().PaisID == 4) // validación para colombia req. 1478
                    {
                        mailBody += "" + UserData().Simbolo + string.Format("{0:#,##0}", Total).Replace(',', '.') + "";
                    }
                    else
                    {
                        mailBody += "" + UserData().Simbolo + Total.ToString("#0.00") + "";
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
                    mailBody += "<strong>" + UserData().NombreConsultora + "</strong> <br />";
                    mailBody += "<strong>Consultora</strong>";
                    //Mejora - Correo
                    //mailBody += "</td>";
                    //mailBody += "</tr>";
                    //mailBody += "</table>";
                    //mailBody += "<table border='0' style='width: 80%;'>";
                    //mailBody += "<tr>";
                    //mailBody += "<td style='font-family:Arial, Helvetica, sans-serif, serif; font-weight:bold; font-size:12px; text-align:right; padding-top:8px;'>";
                    //mailBody += "Belcorp - " + nomPais;
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";

                    #endregion

                    //Mejora - Correo
                    //Util.EnviarMail("no-responder@somosbelcorp.com", ClientId.ToString().Equals("0") ? UserData().EMail : Email, "Pedido Solicitado", mailBody, true, string.Format("{0} - Pedido total", Util.SinAcentosCaracteres(nomPais.ToUpper())));
                    //Util.EnviarMail(Globals.EmailCatalogos, ClientId.ToString().Equals("0") ? UserData().EMail : Email, "Pedido Solicitado", mailBody, true, UserData().NombreConsultora);
                    Util.EnviarMail("no-responder@somosbelcorp.com", ClientId.ToString().Equals("0") ? UserData().EMail : Email, "(" + UserData().CodigoISO + ") Pedido Solicitado", mailBody, true, UserData().NombreConsultora);


                    return Json(new
                    {
                        success = true,
                        message = "Se envió satisfactoriamente el correo al cliente seleccionado.",
                        extra = ""
                    });
                }
                //Fin ITG 1793 HFMG
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar el envió de correo, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                //Inicio ITG 1793 HFMG
                lstCabecera = sv.GetClientesByCampania(UserData().PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId()).OrderBy(p => p.Nombre).ToList();
                //Fin ITG 1793 HFMG
            }

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();
            List<BEPedidoWebDetalle> lstDetalles = new List<BEPedidoWebDetalle>();
            List<BEPedidoWebDetalle> lstDetallesTemp;
            foreach (BEPedidoWebDetalle item in lstCabecera)
            {
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    //Inicio ITG 1793 HFMG
                    lstDetallesTemp = sv.GetPedidoWebDetalleByCliente(UserData().PaisID, int.Parse(vCampaniaID), ObtenerConsultoraId(), item.ClienteID).ToList();
                    //Fin ITG 1793 HFMG
                }

                decimal suma = lstDetallesTemp.Sum(p => p.ImporteTotal);
                dicCabeceras.Add(new KeyValuePair<int, string>(lstDetallesTemp.Count, item.Nombre));
                lstDetallesTemp.Add(new BEPedidoWebDetalle()
                {
                    ImporteTotalPedido = suma
                });
                lstDetalles.AddRange((List<BEPedidoWebDetalle>)lstDetallesTemp);
            }

            Dictionary<string, string> dicDetalles = new Dictionary<string, string>();
            dicDetalles.Add("Código", "CUV");
            dicDetalles.Add("Descripción", "DescripcionProd");
            dicDetalles.Add("Cantidad", "Cantidad");
            dicDetalles.Add("Precio Unit.", UserData().Simbolo + " #PrecioUnidad");
            dicDetalles.Add("Precio Total", UserData().Simbolo + " #ImporteTotal");

            string[] arrTotal = { "Total:", UserData().Simbolo + " #ImporteTotalPedido" };

            ExportToExcelMultiple("PedidosWebExcel", lstDetalles, dicCabeceras, dicDetalles, arrTotal, tieneDescuentoCuv, subtotalString, descuentoString, totalString);
            return View();
        }

        private void ExportToExcelMultiple(string filename, List<BEPedidoWebDetalle> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
            Dictionary<string, string> columnDetailDefinition, string[] arrTotal, bool tieneDescuentoCuv, string subtotalString, string descuentoString, string totalString)
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

                string Simbolo = UserData().Simbolo;

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
                                if (UserData().PaisID == 4) importeTotal = source.ImporteTotal.ToString("#,##0").Replace(',', '.');
                                else importeTotal = source.ImporteTotal.ToString("0.00");

                                ws.Cell(row, col).Value = arr[0] + importeTotal;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                            }

                            else if (arr[1] == "PrecioUnidad")
                            {
                                string precioUnidad = "";
                                if (UserData().PaisID == 4) precioUnidad = source.PrecioUnidad.ToString("#,##0").Replace(',', '.');
                                else precioUnidad = source.PrecioUnidad.ToString("0.00");

                                ws.Cell(row, col).Value = arr[0] + precioUnidad;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                ws.Cell(row, col).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
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
                        titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                        titlesStyle.Fill.BackgroundColor = XLColor.NoColor;
                        titlesStyleh.Font.FontColor = XLColor.FromHtml("#000000");
                        wb.NamedRanges.NamedRange("Totals").Ranges.Style = titlesStyle;

                        string importeTotalPedido = "";
                        if (UserData().PaisID == 4)
                        { // validación para pais colombia req. 1478
                            importeTotalPedido = ((BEPedidoWebDetalle)SourceDetails[i]).ImporteTotalPedido.ToString("#,##0").Replace(',', '.');
                        }
                        else
                        {
                            importeTotalPedido = ((BEPedidoWebDetalle)SourceDetails[i]).ImporteTotalPedido.ToString("0.00");
                        }

                        ws.Cell(row, col - 2).Value = arrTotal[0]; //Total:
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] + importeTotalPedido;
                    }
                    row++;
                    index = keyvalue.Key + 1;
                    SourceDetails.RemoveRange(0, index);
                }

                if (tieneDescuentoCuv)
                {
                    ws.Range(row + 1, col - 2, row + 3, col - 1).Style.Font.Bold = true;
                    ws.Range(row + 1, col - 2, row + 3, col - 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                    ws.Cell(row + 1, col - 2).Value = "SubTotal: ";
                    ws.Cell(row + 1, col - 1).Value = Simbolo + " " + subtotalString;
                    ws.Cell(row + 2, col - 2).Value = "Descuento por ofertas con más de un precio: ";
                    ws.Cell(row + 2, col - 1).Value = Simbolo + " " + descuentoString;
                    ws.Cell(row + 3, col - 2).Value = "Monto Total: ";
                    ws.Cell(row + 3, col - 1).Value = Simbolo + " " + totalString;
                }
                else
                {
                    ws.Range(row + 1, col - 2, row + 1, col - 1).Style.Font.Bold = true;
                    ws.Range(row + 1, col - 2, row + 1, col - 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                    ws.Cell(row + 1, col - 2).Value = "Monto Total: ";
                    ws.Cell(row + 1, col - 1).Value = Simbolo + " " + totalString;
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
            catch { }
        }
        #endregion


        public long ObtenerConsultoraId()
        {
            long ConsultoraIdmetodo;
            if (UserData().UsuarioPrueba == 1)
            {
                using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
                {
                    ConsultoraIdmetodo = sv.GetConsultoraIdByCodigo(UserData().PaisID, UserData().ConsultoraAsociada);
                }
            }
            else
            {
                ConsultoraIdmetodo = UserData().ConsultoraID;
            }
            return ConsultoraIdmetodo;
        }
    }
}
