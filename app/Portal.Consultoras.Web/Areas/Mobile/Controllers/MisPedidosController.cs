using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.CustomHelpers;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MisPedidosController : BaseMobileController
    {
        [HttpGet]
        public async Task<ViewResult> Index()
        {
            var listaPedidos = new List<MisPedidosCampaniaModel>();
            var top = 6;
            var campaniaMarcada = false;
          
            try
            {
                var mobileConfiguracion = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");

                using (var service = new PedidoServiceClient())
                {
                    var result = await service.GetMisPedidosByCampaniaAsync(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, mobileConfiguracion.ClienteID, top);

                    foreach (var item in result)
                    {
                        if (mobileConfiguracion.EsAppMobile && mobileConfiguracion.Campania > 0) campaniaMarcada = (item.CampaniaID == mobileConfiguracion.Campania);

                        listaPedidos.Add(new MisPedidosCampaniaModel()
                        {
                            CampaniaID = item.CampaniaID,
                            CodigoEstadoPedido = item.CodigoEstadoPedido,
                            DescripcionEstadoPedido = item.DescripcionEstadoPedido,
                            NumeroCampania = (item.CampaniaID.ToString().Length == 6 ? string.Format("C{0}", item.CampaniaID.Substring(4, 2)) : string.Empty),
                            EsCampaniaActual = (item.CampaniaID == userData.CampaniaID),
                            EsCampaniaMarcarda = campaniaMarcada
                        });
                    }
                }

                if (!listaPedidos.Any(p => p.EsCampaniaMarcarda)) listaPedidos[0].EsCampaniaMarcarda =  true;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(listaPedidos);
        }

        [HttpGet]
        public PartialViewResult IngresadoDetalle()
        {
            var listaPedidos = new List<MisPedidosIngresadosModel>();

            try
            {
                var mobileConfiguracion = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");

                using (var service = new PedidoServiceClient())
                {
                    var result = service.GetMisPedidosIngresados(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, mobileConfiguracion.ClienteID, userData.NombreConsultora);

                    var totalPedido = result.Sum(x => x.ImportePedido);
                    ViewBag.TotalPedido = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO, userData.Simbolo);

                    foreach (var item in result)
                    {
                        listaPedidos.Add(new MisPedidosIngresadosModel()
                        {
                            CampaniaID = item.CampaniaID,
                            ClienteID = item.ClienteID,
                            NombreCliente = item.NombreCliente,
                            CantidadPedido = item.CantidadPedido,
                            ImportePedido = Util.DecimalToStringFormat(item.ImportePedido, userData.CodigoISO, userData.Simbolo),
                            Detalle = item.Detalle.Select(x => new MisPedidosIngresadosDetalleModel()
                            {
                                ClienteID = x.ClienteID,
                                CUV = x.CUV,
                                DescripcionProducto = x.DescripcionProducto,
                                Cantidad = x.Cantidad,
                                PrecioUnidad = Util.DecimalToStringFormat(x.PrecioUnidad, userData.CodigoISO, userData.Simbolo),
                                ImporteTotal = Util.DecimalToStringFormat(x.ImporteTotal, userData.CodigoISO, userData.Simbolo)
                            }).ToList()
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

            return PartialView(listaPedidos);
        }

        [HttpGet]
        public PartialViewResult FacturadoDetalle(int campaniaID)
        {
            var listaPedidos = new List<MisPedidosFacturadosModel>();

            try
            {
                var mobileConfiguracion = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");

                using (var service = new PedidoServiceClient())
                {
                    var result = service.GetMisPedidosFacturados(userData.PaisID, userData.ConsultoraID, campaniaID, mobileConfiguracion.ClienteID, userData.NombreConsultora);

                    var totalPedido = result.Sum(x => x.ImportePedido);
                    ViewBag.TotalPedido = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO, userData.Simbolo);

                    foreach (var item in result)
                    {
                        listaPedidos.Add(new MisPedidosFacturadosModel()
                        {
                            CampaniaID = item.CampaniaID,
                            ClienteID = item.ClienteID,
                            NombreCliente = item.NombreCliente,
                            CantidadPedido = item.CantidadPedido,
                            ImportePedido = Util.DecimalToStringFormat(item.ImportePedido, userData.CodigoISO, userData.Simbolo),
                            Detalle = item.Detalle.Select(x => new MisPedidosFacturadosDetalleModel()
                            {
                                ClienteID = x.ClienteID,
                                CUV = x.CUV,
                                DescripcionProducto = x.DescripcionProducto,
                                Cantidad = x.Cantidad,
                                PrecioUnidad = Util.DecimalToStringFormat(x.PrecioUnidad, userData.CodigoISO, userData.Simbolo),
                                ImporteTotal = Util.DecimalToStringFormat(x.ImporteTotal, userData.CodigoISO, userData.Simbolo)
                            }).ToList()
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

            return PartialView(listaPedidos);
        }
    }
}