using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PedidosFacturadosController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            var model = new PedidoWebClientePrincipalMobilModel();

            model.PaisID = userData.PaisID;
            model.Simbolo = userData.Simbolo;

            try
            {
                BEPedidoFacturado[] listaPedidosFacturados;

                using (var service = new SACServiceClient())
                {
                    listaPedidosFacturados = service.GetPedidosFacturadosCabecera(userData.PaisID, userData.CodigoConsultora);
                }

                var lista3Ultimos = listaPedidosFacturados.OrderByDescending(p => p.Campania).Take(3).ToList();

                foreach (var pedido in lista3Ultimos)
                {
                    var bePedidoWeb = new PedidoWebMobilModel
                    {
                        PedidoId = pedido.PedidoId,
                        CampaniaID = pedido.Campania,
                        ImporteTotal = pedido.ImporteTotal,
                        CantidadProductos = pedido.Cantidad
                    };

                    if (!string.IsNullOrEmpty(pedido.EstadoPedido))
                    {
                        var parametros = pedido.EstadoPedido.Split(';');
                        if (parametros.Length >= 3)
                        {
                            bePedidoWeb.EstadoPedidoDesc = OrigenDescripcion(parametros[0]);
                            bePedidoWeb.Direccion = parametros[1] == string.Empty ? "0" : parametros[1];
                            bePedidoWeb.Flete = decimal.Parse(bePedidoWeb.Direccion);
                            bePedidoWeb.Subtotal = bePedidoWeb.ImporteTotal - bePedidoWeb.Flete;
                            bePedidoWeb.CodigoUsuarioCreacion = parametros[2] == string.Empty ? "" : Convert.ToDateTime(parametros[2]).ToShortDateString();
                        }
                        bePedidoWeb.ImporteTotal = pedido.ImporteTotal;

                    }

              
                    model.ListaPedidoCliente.Add(bePedidoWeb);
                }


                SessionManager.SetPedidosFacturados(model);
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

        public PartialViewResult Detalle(int campaniaID, int pedidoId)
        {
            
            var model = new PedidoWebMobilModel();
            try
            {
                var pedidosFacturados = SessionManager.GetPedidosFacturados();
                if (pedidosFacturados == null) return PartialView("Detalle", model);

                var pedidoWebMobile = pedidosFacturados.ListaPedidoCliente.FirstOrDefault(p => p.CampaniaID == campaniaID && p.PedidoId == pedidoId);
                if (pedidoWebMobile == null) return PartialView("Detalle", model);

                model.CodigoISO = userData.CodigoISO;
                model.Simbolo = userData.Simbolo;
                model.ImporteTotal = pedidoWebMobile.ImporteTotal;
                model.Subtotal = pedidoWebMobile.Subtotal;
                model.Flete = pedidoWebMobile.Flete;

                BEPedidoFacturado[] listaPedidosFacturadosDetalle;
                using (var service = new SACServiceClient())
                {

                    listaPedidosFacturadosDetalle = service.GetPedidosFacturadosDetalle(userData.PaisID, campaniaID.ToString(), "0", "0", userData.CodigoConsultora, pedidoId);
                }

                foreach (var pedidoDetalle in listaPedidosFacturadosDetalle)
                {
                    if (pedidoDetalle.CUV.Trim().Length > 0 &&
                        pedidoDetalle.Descripcion.Trim().Length > 0)
                    {
                        model.ListaPedidoWebDetalle.Add(
                            new PedidoWebClienteMobilModel
                            {
                                CUV = pedidoDetalle.CUV,
                                DescripcionProd = pedidoDetalle.Descripcion,
                                Cantidad = pedidoDetalle.Cantidad,
                                PrecioUnidad = pedidoDetalle.PrecioUnidad,
                                ImporteTotal = pedidoDetalle.ImporteTotal,
                                ImporteDescuento = pedidoDetalle.MontoDescuento,
                                ImporteTotalPedido = pedidoDetalle.ImporteTotal - pedidoDetalle.MontoDescuento
                            });
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
            ViewBag.CampaniaSession = campaniaID;

            return PartialView("Detalle", model);
        }

        #endregion

        #region Metodos

        public string OrigenDescripcion(string origen)
        {
            string result;
            switch (origen)
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
                    result = origen;
                    break;
            }
            return result;
        }

        public string DescripcionCampania(string campaniaId)
        {
            string descripcionCampania;
            try
            {
                descripcionCampania = campaniaId.Substring(0, 4) + "-C" + campaniaId.Substring(4, 2);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                descripcionCampania = campaniaId;
            }
            return descripcionCampania;
        }

        #endregion
    }
}
