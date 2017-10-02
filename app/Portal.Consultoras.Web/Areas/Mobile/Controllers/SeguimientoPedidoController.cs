using AutoMapper;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Configuration;
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
                    arrayTracking = sv.GetPedidosByConsultora(userData.PaisID, userData.CodigoConsultora);
                }
                if(arrayTracking != null && arrayTracking.Count() > 0)
                {
                    model.ListaEstadoSeguimiento = Mapper.Map<List<SeguimientoMobileModel>>(arrayTracking);
                    if (model.ListaEstadoSeguimiento.Count > 3) model.ListaEstadoSeguimiento = model.ListaEstadoSeguimiento.Take(3).ToList();

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
                var codigoConsultora = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora;
                BETracking[] listaPedidos;
                using (var service = new PedidoServiceClient())
                {
                    listaPedidos = service.GetPedidosByConsultora(userData.PaisID, codigoConsultora);
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

                    var listaEstadoSeguimiento = new List<BETracking>();
                    var novedades = new List<BENovedadTracking>();
                    using (var service = new PedidoServiceClient())
                    {
                        listaEstadoSeguimiento = service.GetTrackingByPedido(userData.PaisID, codigoConsultora, model.Campana.ToString(), model.NumeroPedido).ToList();
                        if (ConfigurationManager.AppSettings["WebTrackingConfirmacion"].Contains(userData.CodigoISO))
                        {
                            novedades = service.GetNovedadesTracking(userData.PaisID, model.NumeroPedido).ToList();
                        }
                    }
                    if (listaEstadoSeguimiento.Count == 0) listaEstadoSeguimiento = AgregarTracking(codigoConsultora, model.Fecha.Value);
                    
                    foreach (var item in listaEstadoSeguimiento)
                    {
                        var estadoSeguimiento = Mapper.Map<SeguimientoMobileModel>(item);
                        if (item.Fecha.HasValue)
                        {
                            var strFecha = item.Fecha.Value.TimeOfDay.TotalHours == 0 ? item.Fecha.Value.ToString("dd/MM/yyyy") : item.Fecha.Value.ToString();
                            estadoSeguimiento.DiaMes = item.Fecha.Value.ToString("dd/MM");
                            estadoSeguimiento.HoraMinuto = item.Fecha.Value.ToString("hh:mm tt");

                            switch (estadoSeguimiento.DiaMes)
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
            BETracking beTracking = new BETracking();
            beTracking.CodigoConsultora = codigo;
            beTracking.Etapa = 1;
            beTracking.Situacion = "Pedido Recibido";
            beTracking.Fecha = fecha;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 2;
            beTracking.Situacion = "Facturado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 3;
            beTracking.Situacion = "Inicio de Armado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 4;
            beTracking.Situacion = "Chequeado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 5;
            beTracking.Situacion = "Puesto en transporte";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 6;
            beTracking.Situacion = "Fecha Estimada de Entrega";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            beTracking = new BETracking();
            beTracking.Etapa = 7;
            beTracking.Situacion = "Entregado";
            beTracking.Fecha = null;
            lista.Add(beTracking);

            return lista;
        }

        #endregion
    }
}
