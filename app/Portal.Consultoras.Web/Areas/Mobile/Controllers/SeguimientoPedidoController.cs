using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class SeguimientoPedidoController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index(int campania = 0, string numeroPedido = "")
        {
            var model = new SeguimientoMobileModel { ListaEstadoSeguimiento = new List<SeguimientoMobileModel>() };
            try
            {
                BETracking[] arrayTracking;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    arrayTracking = sv.GetPedidosByConsultora(userData.PaisID, userData.CodigoConsultora, 3);
                }
                if (arrayTracking != null && arrayTracking.Any())
                {
                    model.ListaEstadoSeguimiento = Mapper.Map<List<SeguimientoMobileModel>>(arrayTracking);

                    var pedidoSeleccionado = model.ListaEstadoSeguimiento.FirstOrDefault(p => p.Campana == campania && (p.NumeroPedido ?? "") == (numeroPedido ?? ""));
                    if (pedidoSeleccionado == null) pedidoSeleccionado = model.ListaEstadoSeguimiento.FirstOrDefault(p => TieneDetalles(p));
                    if (pedidoSeleccionado == null) pedidoSeleccionado = model.ListaEstadoSeguimiento.First();

                    model.Campana = pedidoSeleccionado.Campana;
                    model.NumeroPedido = pedidoSeleccionado.NumeroPedido;
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

        public ActionResult Detalle(int campania = 0, string numeroPedido = "")
        {
            var model = new SeguimientoMobileModel { ListaEstadoSeguimiento = new List<SeguimientoMobileModel>() };
            try
            {
                var codigoConsultora = userData.GetCodigoConsultora();
                BETracking[] listaPedidos;
                using (var service = new PedidoServiceClient())
                {
                    listaPedidos = service.GetPedidosByConsultora(userData.PaisID, codigoConsultora, 3);
                }

                BETracking pedidoSeleccionado = null;
                if (listaPedidos != null && listaPedidos.Length > 0)
                {
                    pedidoSeleccionado = listaPedidos.FirstOrDefault(p => p.Campana == campania && (p.NumeroPedido ?? "") == (numeroPedido ?? ""));
                }

                if (pedidoSeleccionado != null)
                {
                    Mapper.Map(pedidoSeleccionado, model);
                    if (!TieneDetalles(model))
                    {
                        model.ListaEstadoSeguimiento = new List<SeguimientoMobileModel>();
                        return View(model);
                    }

                    List<BETracking> listaEstadoSeguimiento;
                    var novedades = new List<BENovedadTracking>();
                    using (var service = new PedidoServiceClient())
                    {
                        listaEstadoSeguimiento = service.GetTrackingByPedido(userData.PaisID, codigoConsultora, model.Campana.ToString(), model.NumeroPedido).ToList();
                        if (_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.WebTrackingConfirmacion).Contains(userData.CodigoISO))
                        {
                            novedades = service.GetNovedadesTracking(userData.PaisID, model.NumeroPedido).ToList();
                        }
                    }
                    if (listaEstadoSeguimiento.Count == 0 && model.Fecha != null)
                        listaEstadoSeguimiento = AgregarTracking(codigoConsultora, model.Fecha.Value);

                    foreach (var item in listaEstadoSeguimiento)
                    {
                        var estadoSeguimiento = Mapper.Map<SeguimientoMobileModel>(item);
                        if (item.Fecha.HasValue)
                        {
                            estadoSeguimiento.DiaMes = item.Fecha.Value.ToString("dd/MM");
                            estadoSeguimiento.HoraMinuto = item.Fecha.Value.ToString("hh:mm tt");

                            var fechaFormatted = item.Fecha.HasValue
                                ? item.Fecha.Value.TimeOfDay.TotalHours.Equals(0)
                                    ? item.Fecha.Value.ToString("dd/MM/yyyy")
                                    : item.Fecha.Value.ToString()
                                : "";

                            switch (fechaFormatted)
                            {
                                case "01/01/2001":
                                    estadoSeguimiento.DiaMes = string.Empty;
                                    estadoSeguimiento.HoraMinuto = string.Empty;
                                    break;
                                case "01/01/2010":
                                    var temp = novedades.FirstOrDefault(p => p.TipoEntrega == "01");
                                    if (temp != null && temp.FechaNovedad.HasValue)
                                    {
                                        var fechaTemp = temp.FechaNovedad;
                                        estadoSeguimiento.DiaMes = fechaTemp.Value.ToString("dd/MM");
                                        estadoSeguimiento.HoraMinuto = fechaTemp.Value.ToString("hh:mm tt");
                                    }
                                    break;
                                case "02/01/2010":
                                    estadoSeguimiento.DiaMes = "No Entregado";
                                    estadoSeguimiento.HoraMinuto = "";
                                    break;
                            }
                        }
                        model.ListaEstadoSeguimiento.Add(estadoSeguimiento);
                    }
                }
            }
            catch (FaultException ex)
            {
                ViewBag.MensajeError = ex.Message;
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                ViewBag.MensajeError = ex.Message;
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        #endregion

        #region Metodos

        private bool TieneDetalles(SeguimientoMobileModel model)
        {
            if (!model.Fecha.HasValue) return false;
            if (string.IsNullOrEmpty(model.NumeroPedido)) return false;

            return true;
        }

        private List<BETracking> AgregarTracking(string codigo, DateTime fecha)
        {
            List<BETracking> lista = new List<BETracking>();
            BETracking beTracking = new BETracking
            {
                CodigoConsultora = codigo,
                Etapa = 1,
                Situacion = "Pedido Recibido",
                Fecha = fecha
            };
            lista.Add(beTracking);

            beTracking = new BETracking
            {
                Etapa = 2,
                Situacion = "Facturado",
                Fecha = null
            };
            lista.Add(beTracking);

            beTracking = new BETracking
            {
                Etapa = 3,
                Situacion = "Inicio de Armado",
                Fecha = null
            };
            lista.Add(beTracking);

            beTracking = new BETracking
            {
                Etapa = 4,
                Situacion = "Chequeado",
                Fecha = null
            };
            lista.Add(beTracking);

            beTracking = new BETracking
            {
                Etapa = 5,
                Situacion = "Puesto en transporte",
                Fecha = null
            };
            lista.Add(beTracking);

            beTracking = new BETracking
            {
                Etapa = 6,
                Situacion = "Fecha Estimada de Entrega",
                Fecha = null
            };
            lista.Add(beTracking);

            beTracking = new BETracking
            {
                Etapa = 7,
                Situacion = "Entregado",
                Fecha = null
            };
            lista.Add(beTracking);

            return lista;
        }

        #endregion
    }
}
