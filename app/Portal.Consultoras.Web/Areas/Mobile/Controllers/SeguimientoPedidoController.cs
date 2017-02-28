using Portal.Consultoras.Common;
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

        public ActionResult Index()
        {
            var userData = UserData();
            var model = new SeguimientoMobileModel { ListaEstadoSeguimiento = new List<SeguimientoMobileModel>() };
            try
            {
                var codigoConsultora = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora;
                BETracking[] listaPedidos;
                using (var service = new PedidoServiceClient())
                {
                    listaPedidos = service.GetPedidosByConsultora(userData.PaisID, codigoConsultora);
                }

                if (listaPedidos.Length > 0)
                {
                    
                    /* EPD-758 - INICIO */
                    //var ultimoPedido = listaPedidos[0];
                    BETracking ultimoPedido = null;

                    foreach (var pd in listaPedidos)
                    {
                        if (!string.IsNullOrEmpty(pd.NumeroPedido))
                        {
                            ultimoPedido = pd;
                            break;
                        }
                    }

                    if (ultimoPedido == null)
                    {
                        ultimoPedido = listaPedidos[0];
                    }
                    /* EPD-758 - FIN */

                    model.PaisId = ultimoPedido.PaisID;
                    model.CodigoConsultora = ultimoPedido.CodigoConsultora;
                    model.Campana = ultimoPedido.Campana;
                    model.NumeroPedido = ultimoPedido.NumeroPedido;
                    model.Estado = ultimoPedido.Estado;
                    model.Situacion = ultimoPedido.Situacion;
                    model.Fecha = ultimoPedido.Fecha;

                    if (model.Fecha.HasValue)
                    {
                        var listaEstadoSeguimiento = new List<BETracking>();
                        var novedades = new List<BENovedadTracking>();

                        /* GR-1883 - INICIO */
                        if (string.IsNullOrEmpty(model.NumeroPedido))
                        {
                            model.ListaEstadoSeguimiento = new List<SeguimientoMobileModel>();
                            return View(model);
                        }
                        /* GR-1883 - FIN */

                        using (var service = new PedidoServiceClient())
                        {
                            /* GR-1883 - INICIO */
                            //listaEstadoSeguimiento = service.GetTrackingByPedido(userData.PaisID, codigoConsultora, model.Campana.ToString(), model.Fecha.Value).ToList();
                            listaEstadoSeguimiento = service.GetTrackingByPedido(userData.PaisID, codigoConsultora, model.Campana.ToString(), model.NumeroPedido).ToList();
                            /* GR-1883 - FIN */

                            var paisIso = Util.GetPaisISO(userData.PaisID);
                            if (ConfigurationManager.AppSettings["WebTrackingConfirmacion"].Contains(paisIso))
                            {
                                novedades = service.GetNovedadesTracking(userData.PaisID, model.NumeroPedido).ToList();
                            }
                        }

                        if (listaEstadoSeguimiento.Count == 0)
                        {
                            listaEstadoSeguimiento = AgregarTracking(codigoConsultora, model.Fecha.Value);
                        }

                        foreach (var item in listaEstadoSeguimiento)
                        {
                            var estadoSeguimiento = new SeguimientoMobileModel();
                            estadoSeguimiento.PaisId = item.PaisID;
                            estadoSeguimiento.CodigoConsultora = item.CodigoConsultora;
                            estadoSeguimiento.NumeroPedido = item.NumeroPedido;
                            estadoSeguimiento.Campana = item.Campana;
                            estadoSeguimiento.Estado = item.Estado;
                            estadoSeguimiento.Etapa = item.Etapa;
                            estadoSeguimiento.Situacion = item.Situacion;
                            estadoSeguimiento.Fecha = item.Fecha;
                            estadoSeguimiento.ValorTurno = item.ValorTurno; //SB20-964

                            var strFecha = string.Empty;
                            var strDiaMes = string.Empty;
                            var strHoraMinuto = string.Empty;

                            if (item.Fecha.HasValue)
                            {
                                strFecha = item.Fecha.Value.TimeOfDay.TotalHours == 0 ? item.Fecha.Value.ToString("dd/MM/yyyy") : item.Fecha.Value.ToString();
                                strDiaMes = item.Fecha.Value.ToString("dd/MM");
                                strHoraMinuto = item.Fecha.Value.ToString("hh:mm tt");
                            }

                            if (strFecha == "01/01/2001")
                            {
                                strDiaMes = string.Empty;
                                strHoraMinuto = string.Empty;
                            }
                            else
                            {
                                if (strFecha == "01/01/2010" || strFecha == "02/01/2010")
                                {
                                    if (strFecha == "01/01/2010")
                                    {
                                        var temp = novedades.Where(p => p.TipoEntrega == "01").ToList();
                                        if (temp.Count > 0)
                                        {
                                            var fechaTemp = temp[0].FechaNovedad;
                                            if (fechaTemp.HasValue)
                                            {
                                                strDiaMes = fechaTemp.Value.ToString("dd/MM");
                                                strHoraMinuto = fechaTemp.Value.ToString("hh:mm tt");
                                            }
                                        }
                                    }
                                    else
                                    {
                                        strDiaMes = "No Entregado";
                                        strHoraMinuto = "";
                                    }
                                }
                            }

                            estadoSeguimiento.DiaMes = strDiaMes;
                            estadoSeguimiento.HoraMinuto = strHoraMinuto;

                            model.ListaEstadoSeguimiento.Add(estadoSeguimiento);
                        }
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
