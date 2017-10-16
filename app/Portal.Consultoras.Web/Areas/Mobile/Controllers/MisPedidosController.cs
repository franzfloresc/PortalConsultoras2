using System;
using System.Web.Mvc;
using System.ServiceModel;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Globalization;

using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MisPedidosController : BaseMobileController
    {
        [HttpGet]
        public async Task<ViewResult> Index()
        {
            var listaPedidos = new List<MisPedidosCampaniaModel>();
            var top = 3;

            try
            {
                var mobileConfiguracion = (Session["MobileAppConfiguracion"] == null ? new MobileAppConfiguracionModel() : (MobileAppConfiguracionModel)Session["MobileAppConfiguracion"]);

                using (var service = new PedidoServiceClient())
                {
                    var result = await service.GetMisPedidosByCampaniaAsync(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, mobileConfiguracion.ClienteID, top);

                    foreach(var item in result)
                    {
                        listaPedidos.Add(new MisPedidosCampaniaModel()
                        {
                            CampaniaID = item.CampaniaID,
                            CodigoEstadoPedido = item.CodigoEstadoPedido,
                            DescripcionEstadoPedido = item.DescripcionEstadoPedido,
                            NumeroCampania = (item.CampaniaID.ToString().Length == 6 ? string.Format("C{0}", item.CampaniaID.Substring(4, 2)) : string.Empty),
                            AnioCampania = (item.CampaniaID.ToString().Length == 6 ? item.CampaniaID.Substring(0, 4) : string.Empty),
                            EsCampaniaActual = (item.CampaniaID == userData.CampaniaID)
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

            return View(listaPedidos);
        }

        [HttpGet]
        public PartialViewResult IngresadoDetalle()
        {
            var listaPedidos = new List<MisPedidosIngresadosModel>();

            try
            {
                var mobileConfiguracion = (Session["MobileAppConfiguracion"] == null ? new MobileAppConfiguracionModel() : (MobileAppConfiguracionModel)Session["MobileAppConfiguracion"]);

                using (var service = new PedidoServiceClient())
                {
                    var result = service.GetMisPedidosIngresados(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, mobileConfiguracion.ClienteID, userData.NombreConsultora);

                    var TotalPedido = result.Sum(x => x.ImportePedido);
                    ViewBag.TotalPedido = this.FormatoMontos(TotalPedido);

                    foreach (var item in result)
                    {
                        listaPedidos.Add(new MisPedidosIngresadosModel()
                        {
                            CampaniaID = item.CampaniaID,
                            ClienteID = item.ClienteID,
                            NombreCliente = item.NombreCliente,
                            CantidadPedido = item.CantidadPedido,
                            ImportePedido = this.FormatoMontos(item.ImportePedido),
                            Detalle = item.Detalle.Select(x => new MisPedidosIngresadosDetalleModel()
                            {
                                ClienteID = x.ClienteID,
                                CUV = x.CUV,
                                DescripcionProducto = x.DescripcionProducto,
                                Cantidad = x.Cantidad,
                                PrecioUnidad = this.FormatoMontos(x.PrecioUnidad),
                                ImporteTotal = this.FormatoMontos(x.ImporteTotal)
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
                var mobileConfiguracion = (Session["MobileAppConfiguracion"] == null ? new MobileAppConfiguracionModel() : (MobileAppConfiguracionModel)Session["MobileAppConfiguracion"]);

                using (var service = new PedidoServiceClient())
                {
                    var result = service.GetMisPedidosFacturados(userData.PaisID, userData.ConsultoraID, campaniaID, mobileConfiguracion.ClienteID, userData.NombreConsultora);

                    var TotalPedido = result.Sum(x => x.ImportePedido);
                    ViewBag.TotalPedido = this.FormatoMontos(TotalPedido);

                    foreach (var item in result)
                    {
                        listaPedidos.Add(new MisPedidosFacturadosModel()
                        {
                            CampaniaID = item.CampaniaID,
                            ClienteID = item.ClienteID,
                            NombreCliente = item.NombreCliente,
                            CantidadPedido = item.CantidadPedido,
                            ImportePedido = this.FormatoMontos(item.ImportePedido),
                            Detalle = item.Detalle.Select(x => new MisPedidosFacturadosDetalleModel()
                            {
                                ClienteID = x.ClienteID,
                                CUV = x.CUV,
                                DescripcionProducto = x.DescripcionProducto,
                                Cantidad = x.Cantidad,
                                PrecioUnidad = this.FormatoMontos(x.PrecioUnidad),
                                ImporteTotal = this.FormatoMontos(x.ImporteTotal)
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

        private string FormatoMontos(decimal importe)
        {
            string MontoCadena = string.Empty;
            if (userData.PaisID == Util.GetPaisID(Constantes.CodigosISOPais.Colombia))
                MontoCadena = importe.ToString("n2", new CultureInfo("es-CO")).Replace(',', '.');
            else
                MontoCadena = importe.ToString("n2", new CultureInfo("es-PE")).Replace(',', '.');

            return string.Format("{0} {1}", userData.Simbolo, MontoCadena);
        }
    }
}