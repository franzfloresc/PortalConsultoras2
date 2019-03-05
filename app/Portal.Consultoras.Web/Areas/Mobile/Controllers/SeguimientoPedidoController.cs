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

                if (pedidoSeleccionado == null)
                {
                    return View(model);
                }

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
                    if (_configuracionManagerProvider.GetConfiguracionManagerContains(Constantes.ConfiguracionManager.WebTrackingConfirmacion, userData.CodigoISO))
                    {
                        novedades = service.GetNovedadesTracking(userData.PaisID, model.NumeroPedido).ToList();
                    }
                }
                if (listaEstadoSeguimiento.Count == 0 && model.Fecha != null)
                    listaEstadoSeguimiento = AgregarTracking(codigoConsultora, model.Fecha.Value);

                var listaEstado = ListaEstadoSeguimiento(listaEstadoSeguimiento, novedades);
                model.ListaEstadoSeguimiento.AddRange(listaEstado);

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

        private List<SeguimientoMobileModel> ListaEstadoSeguimiento(List<BETracking> listaEstado, List<BENovedadTracking> novedades)
        {
            var listaEstadoSeguimiento = new List<SeguimientoMobileModel>();

             var   listaSeguimiento = AutoMapper.Mapper.Map<List<BETracking>, List<SeguimientoMobileModel>>(listaEstado);

            var listaSeguimientoSecundario = listaSeguimiento.Where(a => a.Etapa != Constantes.SegPedidoSituacion.HoraEstimadaEntregaDesde 
            && a.Etapa != Constantes.SegPedidoSituacion.HoraEstimadaEntregaHasta);


            var horaEstimadaEntregaDesde = string.Empty;
            var horaEstimadaEntregaHasta = string.Empty;
            var desde = listaEstado.FirstOrDefault(a => a.Etapa == Constantes.SegPedidoSituacion.HoraEstimadaEntregaDesde);
            var hasta = listaEstado.FirstOrDefault(a => a.Etapa == Constantes.SegPedidoSituacion.HoraEstimadaEntregaHasta);

            if (desde.Fecha.HasValue) horaEstimadaEntregaDesde = desde.Fecha.Value.TimeOfDay.TotalHours.Equals(0) ? desde.Fecha.Value.ToString() : desde.Fecha.Value.ToString("HH:mm tt");
            if (hasta.Fecha.HasValue) horaEstimadaEntregaHasta = hasta.Fecha.Value.TimeOfDay.TotalHours.Equals(0) ? hasta.Fecha.Value.ToString() : hasta.Fecha.Value.ToString("HH:mm tt");


            foreach (var item in listaSeguimientoSecundario)
            {
                //var estadoSeguimiento = Mapper.Map<SeguimientoMobileModel>(item);
                if (!item.Fecha.HasValue)
                {
                    listaEstadoSeguimiento.Add(item);
                    continue;
                }

                item.DiaMes = item.Fecha.Value.ToString("dd/MM");
                item.HoraMinuto = item.Fecha.Value.ToString("hh:mm tt");

                var fechaFormatted = item.Fecha.Value.TimeOfDay.TotalHours.Equals(0)
                        ? item.Fecha.Value.ToString("dd/MM/yyyy")
                        : item.Fecha.Value.ToString();

                switch (fechaFormatted)
                {
                    case "01/01/0001":
                    case "1/01/0001":
                    case "01/01/2001":
                        item.DiaMes = string.Empty;
                        item.HoraMinuto = string.Empty;
                        break;
                    case "01/01/2010":
                        var temp = novedades.FirstOrDefault(p => p.TipoEntrega == "01");
                        if (temp != null && temp.FechaNovedad.HasValue)
                        {
                            var fechaTemp = temp.FechaNovedad;
                            item.DiaMes = fechaTemp.Value.ToString("dd/MM");
                            item.HoraMinuto = fechaTemp.Value.ToString("hh:mm tt");
                        }
                        else
                        {
                            item.DiaMes = string.Empty;
                            item.HoraMinuto = string.Empty;
                        }
                        break;
                    case "02/01/2010":
                        item.DiaMes = "No Entregado";
                        item.HoraMinuto = "";
                        break;
                }

                if (item.Etapa == Constantes.SegPedidoSituacion.FechaEstimadaEntrega && ValidarZonaRegion())
                {
                    item.HoraEstimadaDesdeHasta = string.Format("{0} {1}", horaEstimadaEntregaDesde, horaEstimadaEntregaHasta);
                }

                listaEstadoSeguimiento.Add(item);
            }

            return listaEstadoSeguimiento;
        }

        public bool ValidarZonaRegion()
        {

            try
            {
                using (var sv = new ServiceSAC.SACServiceClient())
                {
                    int paisid, zonaid, regionid;

                    int.TryParse(userData.PaisID.ToString(), out paisid);

                    int.TryParse(userData.ZonaID.ToString(), out zonaid);
                    int.TryParse(userData.RegionID.ToString(), out regionid);

                    var resultado = sv.GetTablaLogicaDatos(paisid, Constantes.TablaLogica.SegPedidoRegionZona).FirstOrDefault();
                    if (resultado == null) return false;
                    if (resultado.Valor.IsNullOrEmptyTrim()) return false;
                    string[] arrZonaRegion = resultado.Valor.Split(';');
                    foreach (var item in arrZonaRegion)
                    {
                        //Extraer la zona y la region
                        string[] arrItem = item.Split(',');
                        int nzonaid,nregionid;

                        int.TryParse(arrItem[1], out nzonaid);
                        int.TryParse(arrItem[0], out nregionid);

                        if (zonaid == nzonaid && regionid == nregionid) return true;

                    }

                }

                return false;
            }
            catch (FaultException ex)
            {

                ViewBag.MensajeError = ex.Message;
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
            catch (Exception ex)
            {
                ViewBag.MensajeError = ex.Message;
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }


        #endregion
    }
}
