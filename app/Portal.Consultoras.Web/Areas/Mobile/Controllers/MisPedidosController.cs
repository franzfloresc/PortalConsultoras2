using System;
using System.Web.Mvc;
using System.ServiceModel;
using System.Linq;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;


namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MisPedidosController : BaseMobileController
    {
        public ActionResult Index()
        {
            var listaPedidos = new List<BEPedidoWeb>();
            var model = new PedidoWebClientePrincipalMobilModel();

            try
            {
                var mobileConfiguracion = (Session["MobileAppConfiguracion"] == null ? new MobileAppConfiguracionModel() : (MobileAppConfiguracionModel)Session["MobileAppConfiguracion"]);
                if (mobileConfiguracion.ClienteID > 0)
                {
                    using (var sv = new Portal.Consultoras.Web.ServiceCliente.ClienteServiceClient())
                    {
                        var cliente = sv.SelectByConsultoraByCodigo(userData.PaisID, userData.ConsultoraID, 0, mobileConfiguracion.ClienteID);
                        model.ClienteID = cliente.ClienteID;
                    }
                }

                using(var service = new PedidoServiceClient())
                {
                    listaPedidos = service.GetPedidosIngresadoFacturadoWebMobile(userData.PaisID, Convert.ToInt32(userData.ConsultoraID), userData.CampaniaID, model.ClienteID, 3, userData.CodigoConsultora).ToList();
                }

                foreach (var pedido in listaPedidos)
                {
                    var bePedidoWeb = new PedidoWebMobilModel();
                    bePedidoWeb.PedidoId = pedido.PedidoID;
                    bePedidoWeb.CampaniaID = pedido.CampaniaID;
                    bePedidoWeb.EstadoPedidoDesc = pedido.EstadoPedidoDesc;
                    bePedidoWeb.ImporteTotal = pedido.ImporteTotal;
                    bePedidoWeb.Descuento = -pedido.DescuentoProl;
                    bePedidoWeb.CantidadProductos = pedido.CantidadProductos;

                    bePedidoWeb.Flete = pedido.Flete;
                    bePedidoWeb.Subtotal = pedido.ImporteTotal - pedido.Flete;

                    model.ListaPedidoCliente.Add(bePedidoWeb);
                }

                Session["Pedidos"] = model;
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

        public PartialViewResult IngresadoDetalle(int campaniaID, int pedidoId)
        {
            var model = new PedidoWebMobilModel();
            Portal.Consultoras.Web.ServiceCliente.BEPedidoWebDetalle[] lstPedidoDetalle;
            Portal.Consultoras.Web.ServiceCliente.BEPedidoWebDetalle[] lstPedidoDetalleProducto;
            Portal.Consultoras.Web.ServiceCliente.BEPedidoWebDetalle[] lstPedidoDetallexCliente;

            try
            {
                var pedidosRegistrados = Session["Pedidos"] as PedidoWebClientePrincipalMobilModel;
                if (pedidosRegistrados == null) return PartialView();

                var pedidoWebMobile = pedidosRegistrados.ListaPedidoCliente.FirstOrDefault(p => p.CampaniaID == campaniaID);
                if (pedidoWebMobile == null) return PartialView();

                using (var sv = new Portal.Consultoras.Web.ServiceCliente.ClienteServiceClient())
                {
                    lstPedidoDetalle = sv.GetClientesByCampania(userData.PaisID, campaniaID, userData.ConsultoraID);
                }

                if (pedidosRegistrados.ClienteID != 0)
                    lstPedidoDetallexCliente = lstPedidoDetalle.Where(p => p.ClienteID == Convert.ToInt16(pedidosRegistrados.ClienteID)).ToArray();
                else
                    lstPedidoDetallexCliente = lstPedidoDetalle;

                foreach (var pedidoDetalle in lstPedidoDetallexCliente)
                {
                    model.ListaPedidoWebDetalle.Add(new PedidoWebClienteMobilModel
                    {
                        ClienteID = pedidoDetalle.ClienteID,
                        Nombre = pedidoDetalle.Nombre,
                        eMail = pedidoDetalle.eMail,
                        CampaniaID = pedidoDetalle.CampaniaID
                    });
                }

                foreach (var pedidoDetalleProducto in model.ListaPedidoWebDetalle)
                {
                    using (var sv = new Portal.Consultoras.Web.ServiceCliente.ClienteServiceClient())
                    {
                        lstPedidoDetalleProducto = sv.GetPedidoWebDetalleByCliente(userData.PaisID, campaniaID, userData.ConsultoraID, pedidoDetalleProducto.ClienteID);
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

                model.TieneDescuentoCuv = userData.EstadoSimplificacionCUV && model.ListaPedidoWebDetalle.Any(pedidoWebDetalle =>
                    pedidoWebDetalle.ListaPedidoWebDetalleProductos.Any(item =>
                        string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOfertaCUV
                    )
                );

                model.Subtotal = pedidoWebMobile.ImporteTotal;
                model.Descuento = pedidoWebMobile.Descuento;
                model.ImporteTotal = pedidoWebMobile.Subtotal + pedidoWebMobile.Descuento;

                if (userData.PaisID == 4)
                {
                    model.SubtotalString = model.Subtotal.ToString("n0", new System.Globalization.CultureInfo("es-CO"));
                    model.DescuentoString = model.Descuento.ToString("n0", new System.Globalization.CultureInfo("es-CO"));
                    model.ImporteTotalString = model.ImporteTotal.ToString("n0", new System.Globalization.CultureInfo("es-CO"));
                }
                else
                {
                    model.SubtotalString = model.Subtotal.ToString("n2", new System.Globalization.CultureInfo("es-PE"));
                    model.DescuentoString = model.Descuento.ToString("n2", new System.Globalization.CultureInfo("es-PE"));
                    model.ImporteTotalString = model.ImporteTotal.ToString("n2", new System.Globalization.CultureInfo("es-PE"));
                }

                model.Simbolo = userData.Simbolo;
                model.PaisID = userData.PaisID;
                model.CampaniaID = campaniaID;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return PartialView(model);
        }

        public PartialViewResult FacturadoDetalle(int campaniaID, int pedidoId)
        {
            var model = new PedidoWebMobilModel();
            BEPedidoFacturado[] listaPedidosFacturadosDetalle;

            try
            {
                var pedidosFacturados = Session["Pedidos"] as PedidoWebClientePrincipalMobilModel;
                if (pedidosFacturados == null) return PartialView();

                var pedidoWebMobile = pedidosFacturados.ListaPedidoCliente.FirstOrDefault(p => p.CampaniaID == campaniaID);
                if (pedidoWebMobile == null) return PartialView();

                model.CodigoISO = userData.CodigoISO;
                model.Simbolo = userData.Simbolo;
                model.ImporteTotal = pedidoWebMobile.ImporteTotal;
                model.Subtotal = pedidoWebMobile.Subtotal;
                model.Flete = pedidoWebMobile.Flete;

                var ClienteId = pedidosFacturados.ClienteID;
                using (var service = new SACServiceClient())
                {
                    listaPedidosFacturadosDetalle = service.GetPedidosFacturadosDetalleMobile(userData.PaisID, campaniaID.ToString(), userData.CodigoConsultora, ClienteId, pedidoId);
                }

                foreach (var pedidoDetalle in listaPedidosFacturadosDetalle)
                { 
                    if (pedidoDetalle.CUV.Trim().Length > 0 &&
                        pedidoDetalle.Descripcion.Trim().Length > 0)
                    {
                        model.ListaPedidoWebDetalle.Add(
                            new PedidoWebClienteMobilModel
                            {
                                PedidoID = pedidoDetalle.PedidoId,
                                CUV = pedidoDetalle.CUV,
                                DescripcionProd = pedidoDetalle.Descripcion,
                                Cantidad = pedidoDetalle.Cantidad,
                                PrecioUnidad = pedidoDetalle.PrecioUnidad,
                                ImporteTotal = pedidoDetalle.ImporteTotal,
                                ImporteDescuento = pedidoDetalle.MontoDescuento,
                                ImporteTotalPedido = pedidoDetalle.ImporteTotal - pedidoDetalle.MontoDescuento,
                                ClienteID = Convert.ToInt16(pedidoDetalle.ClienteID),
                                Nombre = pedidoDetalle.NombreCliente
                            });
                    }
                }

                using (var sv = new ServiceCliente.ClienteServiceClient())
                {
                    model.ListaClientes = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).OrderBy(x=>x.Nombre).ToList();
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

            return PartialView(model);
        }

        [HttpPost]
        public JsonResult EnviarEmailConsultora(string campaniaId)
        {
            var listaClientes = new List<PedidoWebClienteMobilModel>();
            var lstCabecera = new List<Portal.Consultoras.Web.ServiceCliente.BEPedidoWebDetalle>();
            var pedidoWeb = new BEPedidoWeb();

            var dicCabeceras = new List<KeyValuePair<int, string>>();
            var lst = new List<BEPedidoWebDetalle>();
            var lstDetallesTemp = new List<Portal.Consultoras.Web.ServiceCliente.BEPedidoWebDetalle>();

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
                    using (var sv = new PedidoServiceClient())
                    {
                        pedidoWeb = sv.GetPedidoWebByCampaniaConsultora(userData.PaisID, int.Parse(campaniaId), userData.ConsultoraID);
                    }

                    using (var sv = new Portal.Consultoras.Web.ServiceCliente.ClienteServiceClient())
                    {
                        lstCabecera = sv.GetClientesByCampania(userData.PaisID, int.Parse(campaniaId), userData.ConsultoraID).ToList();
                    }

                    foreach (var dato1 in lstCabecera)
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

                    foreach (var item in listaClientes)
                    {
                        using (var sv = new Portal.Consultoras.Web.ServiceCliente.ClienteServiceClient())
                        {
                            lstDetallesTemp = sv.GetPedidoWebDetalleByCliente(userData.PaisID, int.Parse(campaniaId), userData.ConsultoraID, item.ClienteID).ToList();
                        }

                        decimal suma = lstDetallesTemp.Sum(p => p.ImporteTotal);
                        dicCabeceras.Add(new KeyValuePair<int, string>(lstDetallesTemp.Count, item.Nombre));
                        item.ListaPedidoWebDetalleProductos = new List<PedidoWebDetalleMobilModel>();

                        foreach (var dato2 in lstDetallesTemp)
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


                    var pedidoCliente = new PedidoWebMobilModel();
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

        public JsonResult ActualizarClientePedidoFacturado(string CodigoPedido, string CodigoCliente)
        {
            try
            {
                int PaisID = UserData().PaisID;
                int result = 0;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    result = sv.UpdateClientePedidoFacturado(PaisID, Convert.ToInt32(CodigoPedido), Convert.ToInt32(CodigoCliente));
                }

                if (result == 1)
                {
                    return Json(new
                    {
                        success = true,
                        message = "Se actulizo satisfactoriamente el registro.",
                        extra = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se puede actulizar el registro.",
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
                    message = ex.Message,
                    extra = ""
                });
            }
        }
    }
}