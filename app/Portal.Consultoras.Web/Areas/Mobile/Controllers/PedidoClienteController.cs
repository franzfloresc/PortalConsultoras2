using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PedidoClienteController : BaseMobileController
    {
        #region Actions

        public ActionResult Index()
        {
            var model = new PedidoWebClientePrincipalMobilModel();
            try
            {
                model.PaisID = userData.PaisID;
                model.Simbolo = userData.Simbolo;

                List<BEPedidoWeb> lst;
                using (var sv = new ClienteServiceClient())
                {
                    lst = sv.GetPedidosWebByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }

                var lista3Ultimos = lst.OrderByDescending(p => p.CampaniaID).Take(3).ToList();

                foreach (var item in lista3Ultimos)
                {
                    if (item.CampaniaID != 0)
                    {
                        model.ListaPedidoCliente.Add(new PedidoWebMobilModel
                        {
                            CampaniaID = item.CampaniaID,
                            ImporteTotal = item.ImporteTotal,
                            Descuento = -item.DescuentoProl
                        });
                    }

                }

                foreach (var pedidoCliente in model.ListaPedidoCliente)
                {
                    BEPedidoWebDetalle[] lstPedidoDetalle;
                    using (var sv = new ClienteServiceClient())
                    {
                        lstPedidoDetalle = sv.GetClientesByCampania(userData.PaisID, pedidoCliente.CampaniaID, userData.ConsultoraID);
                    }
                    foreach (var pedidoDetalle in lstPedidoDetalle)
                    {
                        pedidoCliente.ListaPedidoWebDetalle.Add(new PedidoWebClienteMobilModel
                        {
                            ClienteID = pedidoDetalle.ClienteID,
                            Nombre = pedidoDetalle.Nombre,
                            eMail = pedidoDetalle.eMail,
                            CampaniaID = pedidoDetalle.CampaniaID
                        });
                    }

                    foreach (var pedidoDetalleProducto in pedidoCliente.ListaPedidoWebDetalle)
                    {
                        BEPedidoWebDetalle[] lstPedidoDetalleProducto;
                        using (var sv = new ClienteServiceClient())
                        {
                            lstPedidoDetalleProducto = sv.GetPedidoWebDetalleByCliente(userData.PaisID, pedidoCliente.CampaniaID, userData.ConsultoraID, pedidoDetalleProducto.ClienteID);
                        }
                        foreach (var producto in lstPedidoDetalleProducto)
                        {
                            pedidoDetalleProducto.ListaPedidoWebDetalleProductos.Add(new PedidoWebDetalleMobilModel
                            {
                                ClienteID = producto.ClienteID,
                                Nombre = producto.Nombre,
                                eMail = producto.eMail,
                                CampaniaID = producto.CampaniaID,
                                DescripcionProd = producto.DescripcionProd,
                                CUV = producto.CUV,
                                ObservacionPROL = producto.ObservacionPROL,
                                IndicadorOfertaCUV = producto.IndicadorOfertaCUV,
                                PrecioUnidad = producto.PrecioUnidad,
                                Cantidad = producto.Cantidad,
                                ImporteTotal = producto.ImporteTotal
                            });
                        }
                        pedidoDetalleProducto.ImporteTotalPedido = pedidoDetalleProducto.ListaPedidoWebDetalleProductos.Sum(p => p.ImporteTotal);
                    }

                    pedidoCliente.TieneDescuentoCuv = userData.EstadoSimplificacionCUV && pedidoCliente.ListaPedidoWebDetalle.Any(pedidoWebDetalle =>
                        pedidoWebDetalle.ListaPedidoWebDetalleProductos.Any(item =>
                            string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOfertaCUV
                        )
                    );
                    if (pedidoCliente.TieneDescuentoCuv)
                    {
                        pedidoCliente.Subtotal = pedidoCliente.ImporteTotal;
                        pedidoCliente.ImporteTotal = pedidoCliente.Subtotal + pedidoCliente.Descuento;
                    }

                    if (userData.PaisID == 4)
                    {
                        pedidoCliente.SubtotalString = pedidoCliente.Subtotal.ToString("n0", new System.Globalization.CultureInfo("es-CO"));
                        pedidoCliente.DescuentoString = pedidoCliente.Descuento.ToString("n0", new System.Globalization.CultureInfo("es-CO"));
                        pedidoCliente.ImporteTotalString = pedidoCliente.ImporteTotal.ToString("n0", new System.Globalization.CultureInfo("es-CO"));
                    }
                    else
                    {
                        pedidoCliente.SubtotalString = pedidoCliente.Subtotal.ToString("n2", new System.Globalization.CultureInfo("es-PE"));
                        pedidoCliente.DescuentoString = pedidoCliente.Descuento.ToString("n2", new System.Globalization.CultureInfo("es-PE"));
                        pedidoCliente.ImporteTotalString = pedidoCliente.ImporteTotal.ToString("n2", new System.Globalization.CultureInfo("es-PE"));
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }

        [HttpPost]
        public JsonResult EnviarEmailCliente(string ClientId, string Email, string CampaniaId)
        {
            try
            {
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
                    using (var sv = new ClienteServiceClient())
                    {
                        lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(CampaniaId), userData.ConsultoraID, int.Parse(ClientId)).ToList();
                    }

                    #region Mensaje a Enviar

                    var txtBuil = new StringBuilder();

                    txtBuil.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
                    txtBuil.Append("<div style='font-size:12px;'>Hola,</div> <br />");
                    txtBuil.Append("<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + CampaniaId + "</b> es el siguiente :</div> <br /><br />");
                    txtBuil.Append("<table border='1' style='width: 80%;'>");
                    txtBuil.Append("<tr style='color: #FFFFFF'>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 126px; background-color: #666699;'>");
                    txtBuil.Append("Cod. Venta");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #666699;'>");
                    txtBuil.Append("Descripción");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #666699;'>");
                    txtBuil.Append("Cantidad");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #666699;'>");
                    txtBuil.Append("Precio Unit.");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>");
                    txtBuil.Append("Precio Total");
                    txtBuil.Append("</td>");
                    txtBuil.Append("</tr>");

                    for (var i = 0; i < lst.Count; i++)
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
                    }

                    txtBuil.Append("<tr>");
                    txtBuil.Append("<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>");
                    txtBuil.Append("Total :");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; text-align: center; font-weight: bold'>");

                    if (userData.PaisID == 4)
                    {
                        txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", total).Replace(',', '.') + "");
                    }
                    else
                    {
                        txtBuil.Append("" + userData.Simbolo + total.ToString("#0.00") + "");
                    }

                    txtBuil.Append("</td>");
                    txtBuil.Append("</tr>");
                    txtBuil.Append("</table>");
                    txtBuil.Append("<br /><br />");
                    txtBuil.Append("<div style='font-size:12px;'>Saludos,</div>");
                    txtBuil.Append("<br /><br />");
                    txtBuil.Append("<table border='0'>");
                    txtBuil.Append("<tr>");
                    txtBuil.Append("<td>");
                    txtBuil.Append("<img src='cid:Logo' border='0' />");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='text-align: center; font-size:12px;'>");
                    txtBuil.Append("<strong>" + userData.NombreConsultora + "</strong> <br />");
                    txtBuil.Append("<strong>Consultora</strong>");
                    txtBuil.Append("</td>");
                    txtBuil.Append("</tr>");
                    txtBuil.Append("</table>");

                    var mailBody = txtBuil.ToString();
                    #endregion

                    Util.EnviarMailMobile("no-responder@somosbelcorp.com", ClientId.Equals("0") ? userData.EMail : Email, "(" + userData.CodigoISO + ") Pedido Solicitado", mailBody, true, userData.NombreConsultora);

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

        [HttpPost]
        public JsonResult EnviarEmailConsultora(string campaniaId)
        {
            try
            {
                
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
                    ServicePedido.BEPedidoWeb pedidoWeb;
                    using (var sv = new ServicePedido.PedidoServiceClient())
                    {
                        pedidoWeb = sv.GetPedidoWebByCampaniaConsultora(userData.PaisID, int.Parse(campaniaId), userData.ConsultoraID);
                    }

                    List<PedidoWebClienteMobilModel> listaClientes = new List<PedidoWebClienteMobilModel>();
                    List<BEPedidoWebDetalle> lstCabecera;
                    using (ClienteServiceClient sv = new ClienteServiceClient())
                    {
                        lstCabecera = sv.GetClientesByCampania(userData.PaisID, int.Parse(campaniaId), userData.ConsultoraID).ToList();
                    }
                    var objCabecera = lstCabecera;
                    foreach (var dato1 in objCabecera)
                    {
                        listaClientes.Add(
                            new PedidoWebClienteMobilModel
                            {
                                ClienteID = dato1.ClienteID,
                                Nombre = dato1.Nombre,
                                eMail = dato1.eMail,
                                CampaniaID = dato1.CampaniaID
                            });
                    }
                    List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();

                    foreach (var item in listaClientes)
                    {
                        List<BEPedidoWebDetalle> lstDetallesTemp;
                        using (ClienteServiceClient sv = new ClienteServiceClient())
                        {
                            lstDetallesTemp = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(campaniaId), userData.ConsultoraID, item.ClienteID).ToList();
                        }
                        var objDetalle = lstDetallesTemp;
                        decimal suma = lstDetallesTemp.Sum(p => p.ImporteTotal);
                        dicCabeceras.Add(new KeyValuePair<int, string>(lstDetallesTemp.Count, item.Nombre));
                        item.ListaPedidoWebDetalleProductos = new List<PedidoWebDetalleMobilModel>();
                        foreach (var dato2 in objDetalle)
                        {
                            item.ListaPedidoWebDetalleProductos.Add(
                                new PedidoWebDetalleMobilModel
                                {
                                    ClienteID = dato2.ClienteID,
                                    Nombre = dato2.Nombre,
                                    eMail = dato2.eMail,
                                    CampaniaID = dato2.CampaniaID,
                                    DescripcionProd = dato2.DescripcionProd,
                                    CUV = dato2.CUV,
                                    ObservacionPROL = dato2.ObservacionPROL,
                                    IndicadorOfertaCUV = dato2.IndicadorOfertaCUV,
                                    PrecioUnidad = dato2.PrecioUnidad,
                                    Cantidad = dato2.Cantidad,
                                    ImporteTotal = dato2.ImporteTotal,
                                    ImporteTotalPedido = suma,
                                });
                        }
                        item.ImporteTotalPedido = suma;
                    }


                    PedidoWebMobilModel pedidoCliente = new PedidoWebMobilModel
                    {
                        TieneDescuentoCuv = userData.EstadoSimplificacionCUV && listaClientes.Any(pedidoWebDetalle =>
                                                pedidoWebDetalle.ListaPedidoWebDetalleProductos.Any(item =>
                                                    string.IsNullOrEmpty(item.ObservacionPROL) &&
                                                    item.IndicadorOfertaCUV
                                                )
                                            )
                    };

                    if (pedidoCliente.TieneDescuentoCuv)
                    {
                        pedidoCliente.Subtotal = pedidoWeb.ImporteTotal;
                        pedidoCliente.Descuento = -pedidoWeb.DescuentoProl;
                        pedidoCliente.ImporteTotal = pedidoCliente.Subtotal + pedidoCliente.Descuento;
                    }
                    else pedidoCliente.ImporteTotal = pedidoWeb.ImporteTotal;

                    if (userData.PaisID == 4)
                    {
                        pedidoCliente.SubtotalString = string.Format("{0:#,##0}", pedidoCliente.Subtotal).Replace(',', '.');
                        pedidoCliente.DescuentoString = string.Format("{0:#,##0}", pedidoCliente.Descuento).Replace(',', '.');
                        pedidoCliente.ImporteTotalString = string.Format("{0:#,##0}", pedidoCliente.ImporteTotal).Replace(',', '.');
                    }
                    else
                    {
                        pedidoCliente.SubtotalString = string.Format("{0:#,##0.00}", pedidoCliente.Subtotal);
                        pedidoCliente.DescuentoString = string.Format("{0:#,##0.00}", pedidoCliente.Descuento);
                        pedidoCliente.ImporteTotalString = string.Format("{0:#,##0.00}", pedidoCliente.ImporteTotal);
                    }

                    #region Mensaje a Enviar

                    var txtBuil = new StringBuilder();

                    txtBuil.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
                    txtBuil.Append("<div style='font-size:12px;'>Hola,</div> <br />");
                    txtBuil.Append("<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + campaniaId + "</b> es el siguiente :</div> <br /><br />");
                    txtBuil.Append("<table border='1' style='width: 80%;'>");
                    txtBuil.Append("<tr style='color: #FFFFFF'>");
                    txtBuil.Append("<td style='font-size:11px; width: 347px; font-weight: bold; text-align: center; background-color: #666699;'>");
                    txtBuil.Append("Cliente");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 126px; background-color: #666699;'>");
                    txtBuil.Append("Cod. Venta");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #666699;'>");
                    txtBuil.Append("Descripción");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #666699;'>");
                    txtBuil.Append("Cantidad");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #666699;'>");
                    txtBuil.Append("Precio Unit.");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>");
                    txtBuil.Append("Precio Total");
                    txtBuil.Append("</td>");
                    txtBuil.Append("</tr>");
                    /* Armado de Data */
                    foreach (var item in listaClientes)
                    {
                        //for a la segunda lista para obtener los detalles
                        foreach (var item2 in item.ListaPedidoWebDetalleProductos)
                        {
                            txtBuil.Append("<tr>");
                            txtBuil.Append("<td style='font-size:11px; width: 347px; text-align: center;'>");
                            txtBuil.Append("" + item.Nombre + "");
                            txtBuil.Append("</td>");
                            txtBuil.Append("<td style='font-size:11px; width: 126px; text-align: center;'>");
                            txtBuil.Append("" + item2.CUV + "");
                            txtBuil.Append("</td>");
                            txtBuil.Append(" <td style='font-size:11px; width: 347px;'>");
                            txtBuil.Append("" + item2.DescripcionProd + "");
                            txtBuil.Append("</td>");
                            txtBuil.Append("<td style='font-size:11px; width: 124px; text-align: center;'>");
                            txtBuil.Append("" + item2.Cantidad.ToString() + "");
                            txtBuil.Append("</td>");
                            if (userData.PaisID == 4)
                            {
                                txtBuil.Append("<td style='font-size:11px; width: 182px; text-align: center;'>");
                                txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", item2.PrecioUnidad).Replace(',', '.') + "");
                                txtBuil.Append("</td>");
                                txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                                txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", item2.ImporteTotal).Replace(',', '.') + "");
                                txtBuil.Append("</td>");
                            }
                            else
                            {
                                txtBuil.Append("<td style='font-size:11px; width: 182px; text-align: center;'>");
                                txtBuil.Append(userData.Simbolo + item2.PrecioUnidad.ToString("#0.00"));
                                txtBuil.Append("</td>");
                                txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                                txtBuil.Append(userData.Simbolo + item2.ImporteTotal.ToString("#0.00"));
                                txtBuil.Append("</td>");
                            }
                            txtBuil.Append("</tr>");
                        }
                        /* Fin de Armado de Data*/
                        txtBuil.Append("<tr>");
                        txtBuil.Append("<td colspan='5' style='font-size:11px; text-align: right; font-weight: bold'>");
                        txtBuil.Append("Total :");
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; text-align: center; font-weight: bold'>");

                        if (userData.PaisID == 4) txtBuil.Append("" + userData.Simbolo + string.Format("{0:#,##0}", item.ImporteTotalPedido).Replace(',', '.') + "");
                        else txtBuil.Append("" + userData.Simbolo + item.ImporteTotalPedido.ToString("#0.00") + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append("</tr>");
                    }
                    txtBuil.Append("</table>");

                    txtBuil.Append("<div style='font-size:12px;font-weight:bold;width:80%;text-align:right; margin-top:5px;'>");
                    if (pedidoCliente.TieneDescuentoCuv)
                    {
                        txtBuil.Append("<div style='float:right;width:120px;'>" + userData.Simbolo + pedidoCliente.SubtotalString + "</div>");
                        txtBuil.Append("<div style='float:right;'>SubTotal:</div>");
                        txtBuil.Append("<div style='clear:both;height:3px;'></div>");
                        txtBuil.Append("<div style='float:right;width:120px;'>" + userData.Simbolo + pedidoCliente.DescuentoString + "</div>");
                        txtBuil.Append("<div style='float:right;'>Descuento por ofertas con más de un precio:</div>");
                        txtBuil.Append("<div style='clear:both;height:3px;'></div>");
                    }
                    txtBuil.Append("<div style='float:right;width:120px;'>" + userData.Simbolo + pedidoCliente.ImporteTotalString + "</div>");
                    txtBuil.Append("<div style='float:right;'>Total:</div>");
                    txtBuil.Append("<div style='clear:both;'></div>");
                    txtBuil.Append("</div>");

                    txtBuil.Append("<br /><br />");
                    txtBuil.Append("<div style='font-size:12px;'>Saludos,</div>");
                    txtBuil.Append("<br /><br />");
                    txtBuil.Append("<table border='0'>");
                    txtBuil.Append("<tr>");
                    txtBuil.Append("<td>");
                    txtBuil.Append("<img src='cid:Logo' border='0' />");
                    txtBuil.Append("</td>");
                    txtBuil.Append("<td style='text-align: center; font-size:12px;'>");
                    txtBuil.Append("<strong>" + userData.NombreConsultora + "</strong> <br />");
                    txtBuil.Append("<strong>Consultora</strong>");
                    txtBuil.Append("</td>");
                    txtBuil.Append("</tr>");
                    txtBuil.Append("</table>");

                    var mailBody = txtBuil.ToString();
                    #endregion

                    Util.EnviarMailMobile("no-responder@somosbelcorp.com", userData.EMail, "(" + userData.CodigoISO + ") Pedido Solicitado", mailBody, true, userData.NombreConsultora);

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

        #endregion
    }
}
