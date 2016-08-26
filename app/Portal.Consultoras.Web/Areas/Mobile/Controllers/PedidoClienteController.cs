using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PedidoClienteController : BaseMobileController
    {
        #region Actions

        public ActionResult Index()
        {
            var userData = UserData();
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
                    model.ListaPedidoCliente.Add(new PedidoWebMobilModel{
                        CampaniaID = item.CampaniaID,
                        ImporteTotal = item.ImporteTotal,
                        Descuento = -item.DescuentoProl
                    });
                }

                BEPedidoWebDetalle[] lstPedidoDetalle;
                BEPedidoWebDetalle[] lstPedidoDetalleProducto;
                foreach (var pedidoCliente in model.ListaPedidoCliente)
                {
                    using (var sv = new ClienteServiceClient())
                    {
                        lstPedidoDetalle = sv.GetClientesByCampania(userData.PaisID, pedidoCliente.CampaniaID, userData.ConsultoraID);
                    }
                    foreach (var pedidoDetalle in lstPedidoDetalle)
                    {
                        pedidoCliente.ListaPedidoWebDetalle.Add(new PedidoWebClienteMobilModel {
                            ClienteID = pedidoDetalle.ClienteID,
                            Nombre = pedidoDetalle.Nombre,
                            eMail = pedidoDetalle.eMail,
                            CampaniaID = pedidoDetalle.CampaniaID
                        });
                    }

                    foreach (var pedidoDetalleProducto in pedidoCliente.ListaPedidoWebDetalle)
                    {
                        using (var sv = new ClienteServiceClient())
                        {
                            lstPedidoDetalleProducto = sv.GetPedidoWebDetalleByCliente(userData.PaisID, pedidoCliente.CampaniaID, userData.ConsultoraID, pedidoDetalleProducto.ClienteID);
                        }
                        foreach (var producto in lstPedidoDetalleProducto)
                        {
                            pedidoDetalleProducto.ListaPedidoWebDetalleProductos.Add(new PedidoWebDetalleMobilModel {
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

                    if(userData.PaisID == 4)
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
                var userData = UserData();
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
                    var lst = new List<BEPedidoWebDetalle>();
                    using (var sv = new ClienteServiceClient())
                    {
                        lst = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(CampaniaId), userData.ConsultoraID, int.Parse(ClientId)).ToList();
                    }

                    #region Mensaje a Enviar
                    
                    var mailBody = string.Empty;
                    mailBody = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
                    mailBody += "<div style='font-size:12px;'>Hola,</div> <br />";
                    mailBody += "<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + CampaniaId.ToString() + "</b> es el siguiente :</div> <br /><br />";
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
                    
                    for (var i = 0; i < lst.Count; i++)
                    {
                        mailBody += "<tr>";
                        mailBody += "<td style='font-size:11px; width: 126px; text-align: center;'>";
                        mailBody += "" + lst[i].CUV.ToString() + "";
                        mailBody += "</td>";
                        mailBody += " <td style='font-size:11px; width: 347px;'>";
                        mailBody += "" + lst[i].DescripcionProd.ToString() + "";
                        mailBody += "</td>";
                        mailBody += "<td style='font-size:11px; width: 124px; text-align: center;'>";
                        mailBody += "" + lst[i].Cantidad.ToString() + "";
                        mailBody += "</td>";
                        if (UserData().PaisID == 4) 
                        {
                            mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].PrecioUnidad).Replace(',', '.') + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", lst[i].ImporteTotal).Replace(',', '.') + "";
                            mailBody += "</td>";
                        }
                        else
                        {
                            mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + lst[i].PrecioUnidad.ToString("#0.00") + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + lst[i].ImporteTotal.ToString("#0.00") + "";
                            mailBody += "</td>";
                        }
                        mailBody += "</tr>";
                        total += lst[i].ImporteTotal;
                    }
                    
                    mailBody += "<tr>";
                    mailBody += "<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>";
                    mailBody += "Total :";
                    mailBody += "</td>";
                    mailBody += "<td style='font-size:11px; text-align: center; font-weight: bold'>";
                    if (UserData().PaisID == 4) 
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
                    mailBody += "<div style='font-size:12px;'>Saludos,</div>";
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

                    Util.EnviarMailMobile("no-responder@somosbelcorp.com", ClientId.ToString().Equals("0") ? userData.EMail : Email, "(" + userData.CodigoISO + ") Pedido Solicitado", mailBody, true, userData.NombreConsultora);
                    
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

        [HttpPost]
        public JsonResult EnviarEmailConsultora(string campaniaId)
        {
            try
            {
                var userData = UserData();
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
                    ServicePedido.BEPedidoWeb pedidoWeb = new ServicePedido.BEPedidoWeb();
                    using (var sv = new ServicePedido.PedidoServiceClient())
                    {
                        pedidoWeb = sv.GetPedidoWebByCampaniaConsultora(userData.PaisID, int.Parse(campaniaId), userData.ConsultoraID);
                    }

                    List<PedidoWebClienteMobilModel> listaClientes = new List<PedidoWebClienteMobilModel>();
                    List<BEPedidoWebDetalle> lstCabecera = new List<BEPedidoWebDetalle>();
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
                    List<BEPedidoWebDetalle> lst = new List<BEPedidoWebDetalle>();
                    List<BEPedidoWebDetalle> lstDetallesTemp = new List<BEPedidoWebDetalle>();
                    foreach (var item in listaClientes)
                    {
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


                    PedidoWebMobilModel pedidoCliente = new PedidoWebMobilModel();
                    pedidoCliente.TieneDescuentoCuv = userData.EstadoSimplificacionCUV && listaClientes.Any(pedidoWebDetalle =>
                        pedidoWebDetalle.ListaPedidoWebDetalleProductos.Any(item =>
                            string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOfertaCUV
                        )
                    );
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
                    
                    var mailBody = string.Empty;
                    mailBody = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
                    mailBody += "<div style='font-size:12px;'>Hola,</div> <br />";
                    mailBody += "<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + campaniaId.ToString() + "</b> es el siguiente :</div> <br /><br />";
                    mailBody += "<table border='1' style='width: 80%;'>";
                    mailBody += "<tr style='color: #FFFFFF'>";
                    mailBody += "<td style='font-size:11px; width: 347px; font-weight: bold; text-align: center; background-color: #666699;'>";
                    mailBody += "Cliente";
                    mailBody += "</td>";
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
                    /* Armado de Data */
                    foreach (var item in listaClientes)
                    {
                        //for a la segunda lista para obtener los detalles
                        foreach (var item2 in item.ListaPedidoWebDetalleProductos)
                        {
                            mailBody += "<tr>";
                            mailBody += "<td style='font-size:11px; width: 347px; text-align: center;'>";
                            mailBody += "" + item.Nombre.ToString() + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 126px; text-align: center;'>";
                            mailBody += "" + item2.CUV.ToString() + "";
                            mailBody += "</td>";
                            mailBody += " <td style='font-size:11px; width: 347px;'>";
                            mailBody += "" + item2.DescripcionProd.ToString() + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 124px; text-align: center;'>";
                            mailBody += "" + item2.Cantidad.ToString() + "";
                            mailBody += "</td>";
                            if (userData.PaisID == 4) 
                            {
                                mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                                mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", item2.PrecioUnidad).Replace(',', '.') + "";
                                mailBody += "</td>";
                                mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                                mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", item2.ImporteTotal).Replace(',', '.') + "";
                                mailBody += "</td>";
                            }
                            else
                            {
                                mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                                mailBody += userData.Simbolo + item2.PrecioUnidad.ToString("#0.00");
                                mailBody += "</td>";
                                mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                                mailBody += userData.Simbolo + item2.ImporteTotal.ToString("#0.00");
                                mailBody += "</td>";
                            }
                            mailBody += "</tr>";
                        }
                        /* Fin de Armado de Data*/
                        mailBody += "<tr>";
                        mailBody += "<td colspan='5' style='font-size:11px; text-align: right; font-weight: bold'>";
                        mailBody += "Total :";
                        mailBody += "</td>";
                        mailBody += "<td style='font-size:11px; text-align: center; font-weight: bold'>";

                        if (userData.PaisID == 4) mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", item.ImporteTotalPedido).Replace(',', '.') + "";
                        else mailBody += "" + userData.Simbolo + item.ImporteTotalPedido.ToString("#0.00") + "";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                    }
                    mailBody += "</table>";


                    mailBody += "<div style='font-size:12px;font-weight:bold;width:80%;text-align:right; margin-top:5px;'>";
                    if (pedidoCliente.TieneDescuentoCuv)
                    {
                        mailBody += "<div style='float:right;width:120px;'>" + userData.Simbolo + pedidoCliente.SubtotalString + "</div>";
                        mailBody += "<div style='float:right;'>SubTotal:</div>";
                        mailBody += "<div style='clear:both;height:3px;'></div>";
                        mailBody += "<div style='float:right;width:120px;'>" + userData.Simbolo + pedidoCliente.DescuentoString + "</div>";
                        mailBody += "<div style='float:right;'>Descuento por ofertas con más de un precio:</div>";
                        mailBody += "<div style='clear:both;height:3px;'></div>";
                    }
                    mailBody += "<div style='float:right;width:120px;'>" + userData.Simbolo + pedidoCliente.ImporteTotalString + "</div>";
                    mailBody += "<div style='float:right;'>Total:</div>";
                    mailBody += "<div style='clear:both;'></div>";
                    mailBody += "</div>";

                    mailBody += "<br /><br />";
                    mailBody += "<div style='font-size:12px;'>Saludos,</div>";
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

        #endregion
    }
}
