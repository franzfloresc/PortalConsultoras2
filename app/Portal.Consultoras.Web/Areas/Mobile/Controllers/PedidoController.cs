using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using BEPedidoWeb = Portal.Consultoras.Web.ServicePedido.BEPedidoWeb;
using BEPedidoWebDetalle = Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PedidoController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            var model = new PedidoMobileModel();

            Session["ObservacionesPROL"] = null;
            Session["PedidoWeb"] = null;
            Session["PedidoWebDetalle"] = null;

            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            if (beConfiguracionCampania == null)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (beConfiguracionCampania.CampaniaID == 0)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && !beConfiguracionCampania.ModificaPedidoReservado
                && !beConfiguracionCampania.ValidacionAbierta)
                return RedirectToAction("Validado", "Pedido", new { area = "Mobile" });

            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

            if (lstPedidoWebDetalle.Count == 0)
            {
                int isInsert;

                using (var sv = new PedidoServiceClient())
                {
                    var bePedidoWeb = new BEPedidoWeb();
                    bePedidoWeb.CampaniaID = userData.CampaniaID;
                    bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                    bePedidoWeb.PaisID = userData.PaisID;
                    bePedidoWeb.IPUsuario = userData.IPUsuario;
                    bePedidoWeb.CodigoUsuarioCreacion = userData.CodigoUsuario;

                    isInsert = sv.GetProductoCUVsAutomaticosToInsert(bePedidoWeb);
                }
                if (isInsert > 0)
                {
                    Session["PedidoWebDetalle"] = null;
                    lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                    UpdPedidoWebMontosPROL();
                }
            }

            BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();

            if (bePedidoWebByCampania != null)
            {
                model.MontoAhorroCatalogo = bePedidoWebByCampania.MontoAhorroCatalogo;
                model.MontoAhorroRevista = bePedidoWebByCampania.MontoAhorroRevista;
            }

            if (userData.PedidoID == 0 && lstPedidoWebDetalle.Count > 0)
            {
                userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                SetUserData(userData);
            }

            model.PaisId = userData.PaisID;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = ViewBag.Campania;
            model.CampaniaNro = userData.CampaniaNro;
            model.Total = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, userData.CodigoISO);
            model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, userData.CodigoISO);
            model.MontoConDsctoStr = Util.DecimalToStringFormat(model.Total - bePedidoWebByCampania.DescuentoProl, userData.CodigoISO);
            model.DescuentoStr = Util.DecimalToStringFormat(bePedidoWebByCampania.DescuentoProl, userData.CodigoISO);
            model.ListaProductos = lstPedidoWebDetalle.ToList();
            model.CantidadProductos = lstPedidoWebDetalle.ToList().Sum(p => p.Cantidad);

            model.GananciaFormat = Util.DecimalToStringFormat(model.MontoAhorroCatalogo + model.MontoAhorroRevista, userData.CodigoISO);

            using (var sv = new ClienteServiceClient())
            {
                model.ListaClientes = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }
            model.ListaClientes.Insert(0, new BECliente { ClienteID = 0, Nombre = userData.NombreConsultora });

            model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);

            return View(model);
        }
        
        public ActionResult Detalle()
        {
            Session["ObservacionesPROL"] = null;
            Session["PedidoWebDetalle"] = null;

            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            if (beConfiguracionCampania == null)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (beConfiguracionCampania.CampaniaID == 0)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && !beConfiguracionCampania.ModificaPedidoReservado
                && !beConfiguracionCampania.ValidacionAbierta)
                return RedirectToAction("Validado", "Pedido", new { area = "Mobile" });

            var model = new PedidoDetalleMobileModel();
            model.CodigoISO = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = userData.CampaniaID.ToString();
            model.FechaFacturacionPedido = ViewBag.FechaFacturacionPedido;
            model.FlagValidacionPedido = beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && beConfiguracionCampania.ModificaPedidoReservado ? "1" : "0";

            ValidarStatusCampania(beConfiguracionCampania);

            /* SB20-287 - INICIO */
            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            DateTime diaActual = DateTime.Today.Add(HoraCierrePortal);

            if (!userData.DiaPROL)  // Periodo de venta
            {
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", ViewBag.FechaFacturacionPedido);

                if (userData.CodigoISO == "BO")
                {
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|No olvides validar tu pedido el dia {0} para que sea enviado a facturar", ViewBag.FechaFacturacionPedido);
                }
            }
            else // Periodo de facturacion
            {
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", ViewBag.FechaFacturacionPedido);

                if (userData.NuevoPROL && userData.ZonaNuevoPROL)   // PROL 2
                {
                    model.Prol = "RESERVA TU PEDIDO";
                    model.ProlTooltip = "Haz click aqui para reservar tu pedido";
                    if (diaActual <= userData.FechaInicioCampania)
                    {
                        model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", ViewBag.FechaFacturacionPedido);
                    }
                    else
                    {
                        model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                    }
                }
                else // PROL 1
                {
                    model.Prol = "VALIDA TU PEDIDO";
                    model.ProlTooltip = "Haz click aqui para validar tu pedido";
                    if (diaActual <= userData.FechaInicioCampania)
                    {
                        model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", ViewBag.FechaFacturacionPedido);
                    }
                    else
                    {
                        model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                    }
                }
            }
            /* SB20-287 - FIN */
            
            //Se desactiva dado que el mensaje de Guardar por MM no va en países SICC
            if (userData.CodigoISO == Constantes.CodigosISOPais.Colombia)
            {
                BETablaLogicaDatos[] tablaLogicaDatos;
                using (var sac = new SACServiceClient())
                {
                    tablaLogicaDatos = sac.GetTablaLogicaDatos(userData.PaisID, 27);
                }

                if (tablaLogicaDatos != null && tablaLogicaDatos.Length != 0)
                {
                    model.MensajeGuardarCO = tablaLogicaDatos[0].Descripcion;
                }
            }

            return View(model);
        }
        
        public ActionResult CampaniaZonaNoConfigurada()
        {
            ViewBag.MensajeCampaniaZona = userData.CampaniaID == 0 ? "Campaña" : "Zona";
            return View();
        }
        
        public ActionResult Validado()
        {
            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }
            if (beConfiguracionCampania != null)
            {
                if (beConfiguracionCampania.CampaniaID > userData.CampaniaID)
                    return RedirectToAction("Index");
            }

            List<BEPedidoWebDetalle> lstPedidoWebDetalle;
            using (var sv = new PedidoServiceClient())
            {
                lstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
            }

            BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();
            var model = new PedidoDetalleMobileModel();
            model.CodigoISO = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.SetDetalleMobileFromDetalleWeb(PedidoJerarquico(lstPedidoWebDetalle));
            model.Detalle.Update(item => item.DescripcionPrecioUnidad = Util.DecimalToStringFormat(item.PrecioUnidad, model.CodigoISO));
            model.Detalle.Update(item => item.DescripcionImporteTotal = Util.DecimalToStringFormat(item.ImporteTotal, model.CodigoISO));

            model.CantidadProductos = model.Detalle.Sum(item => item.Cantidad);
            model.PedidoConDescuentoCuv = userData.EstadoSimplificacionCUV && lstPedidoWebDetalle.Any(p => p.IndicadorOfertaCUV);
            model.PedidoConProductosExceptuadosMontoMinimo = lstPedidoWebDetalle.Any(p => p.IndicadorMontoMinimo == 0);

            model.SubTotal = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
            if (model.PedidoConDescuentoCuv) model.Descuento = -bePedidoWebByCampania.DescuentoProl;
            model.Total = model.SubTotal + model.Descuento;

            model.DescripcionSubTotal = Util.DecimalToStringFormat(model.SubTotal, model.CodigoISO);
            model.DescripcionDescuento = Util.DecimalToStringFormat(model.Descuento, model.CodigoISO);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, model.CodigoISO);

            model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, model.CodigoISO);
            
            model.MontoAhorroCatalogo = bePedidoWebByCampania.MontoAhorroCatalogo;
            model.MontoAhorroRevista = bePedidoWebByCampania.MontoAhorroRevista;
            model.GanaciaEstimada = model.MontoAhorroCatalogo + model.MontoAhorroRevista;
            model.DescripcionGanaciaEstimada = Util.DecimalToStringFormat(model.GanaciaEstimada, model.CodigoISO);

            if (lstPedidoWebDetalle.Count != 0)
            {
                if (userData.PedidoID == 0)
                {
                    userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                    SetUserData(userData);
                }
                model.Email = userData.EMail;
            }

            #region kitNueva
            BEKitNueva[] kitNueva;
            int esColaborador = 0;
            using (var sv = new UsuarioServiceClient())
            {
                kitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora);
                esColaborador = sv.GetValidarColaboradorZona(userData.PaisID, userData.CodigoZona);
            }
            int esKitNueva = 0;
            decimal montoKitNueva = 0;

            //Valida de que la consultora tenga estado registrada y de que el proceso de kit de nueva este activo
            if (kitNueva[0].Estado == 1 && kitNueva[0].EstadoProceso == 1 && esColaborador == 0)
            {
                esKitNueva = 1;
                montoKitNueva = userData.MontoMinimo - kitNueva[0].Monto;
            }
            ViewBag.MontoKitNueva = Util.DecimalToStringFormat(montoKitNueva, model.CodigoISO);
            ViewBag.EsKitNueva = esKitNueva;
            #endregion 

            #region mensaje monto logro para la meta
            decimal montoLogro = 0;
            string montoMaximoStr = Util.ValidaMontoMaximo(userData.MontoMaximo, userData.CodigoISO);
            if (!string.IsNullOrEmpty(montoMaximoStr) || model.SubTotal < userData.MontoMinimo) montoLogro = model.Total;
            else if (userData.MontoMinimo > bePedidoWebByCampania.MontoEscala) montoLogro = userData.MontoMinimo;
            else montoLogro = bePedidoWebByCampania.MontoEscala;

            BEFactorGanancia oBEFactorGanancia = null;
            using (var sv = new SACServiceClient())
            {
                oBEFactorGanancia = sv.GetFactorGananciaSiguienteEscala(montoLogro, userData.PaisID);
            }
            if (oBEFactorGanancia != null && esColaborador == 0 && oBEFactorGanancia.RangoMinimo <= userData.MontoMaximo)
            {
                model.MostrarEscalaDescuento = true;
                model.PorcentajeEscala = Convert.ToInt32(oBEFactorGanancia.Porcentaje);
                model.MontoEscalaDescuento = oBEFactorGanancia.RangoMinimo - montoLogro;
                model.DescripcionMontoEscalaDescuento = Util.DecimalToStringFormat(model.MontoEscalaDescuento, model.CodigoISO);
            }
            #endregion

            int horaCierre = userData.EsZonaDemAnti;
            TimeSpan sp = horaCierre == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            //model.HoraCierre = new DateTime(sp.Ticks).ToString("HH:mm");
            //model.HoraCierre = new DateTime(sp.Ticks).ToString("hh:mm tt");
            model.HoraCierre = FormatearHora(sp);
            model.ModificacionPedidoProl = userData.NuevoPROL && userData.ZonaNuevoPROL ? 0 : 1;

            return View(model);
        }

        #endregion

        #region Metodos

        private void ValidarStatusCampania(BEConfiguracionCampania beConfiguracionCampania)
        {
            UsuarioModel usuario = userData;
            usuario.ZonaValida = beConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = beConfiguracionCampania.FechaInicioFacturacion;

            // Se calcula la fecha de fin de campaña sumando la fecha de inicio mas los dias de duración del cronograma
            //usuario.FechaFinCampania = oBEConfiguracionCampania.FechaFinFacturacion;
            usuario.FechaFinCampania = beConfiguracionCampania.FechaFinFacturacion;

            usuario.HoraInicioReserva = beConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = beConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = beConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = beConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = beConfiguracionCampania.DiasAntes;

            bool mostrarBotonValidar;
            usuario.DiaPROL = ValidarPROL(usuario, out mostrarBotonValidar);
            usuario.MostrarBotonValidar = mostrarBotonValidar;
            usuario.NombreCorto = beConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = beConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = beConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = beConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = beConfiguracionCampania.HoraCierreZonaNormal;
            usuario.ValidacionAbierta = beConfiguracionCampania.ValidacionAbierta;

            if (DateTime.Now.AddHours(beConfiguracionCampania.ZonaHoraria) < beConfiguracionCampania.FechaInicioFacturacion.AddDays(-beConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = beConfiguracionCampania.FechaInicioFacturacion.AddDays(-beConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = beConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = beConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = beConfiguracionCampania.HoraFin;
            }
            SetUserData(usuario);
        }

        private int BuildFechaNoHabil()
        {
            int result = 0;
            if (Session["UserData"] != null)
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetFechaNoHabilFacturacion(userData.PaisID, userData.CodigoZona, DateTime.Today);
                }
            }
            return result;
        }

        private bool ValidarPROL(UsuarioModel usuario, out bool mostrarBotonValidar)
        {
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            bool DiaPROL = false;
            mostrarBotonValidar = false;
            TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);

            if (FechaHoraActual > usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) &&
                FechaHoraActual < usuario.FechaInicioCampania)
            {
                if (HoraNow > usuario.HoraInicioPreReserva && HoraNow < usuario.HoraFinPreReserva)
                {
                    int cantidad = BuildFechaNoHabil();
                    mostrarBotonValidar = cantidad == 0;
                }
                DiaPROL = true;
            }
            else
            {
                if (FechaHoraActual > usuario.FechaInicioCampania &&
                    FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
                {
                    if (HoraNow > usuario.HoraInicioReserva && HoraNow < usuario.HoraFinReserva)
                    {
                        int cantidad = BuildFechaNoHabil();
                        mostrarBotonValidar = cantidad == 0;
                    }
                    DiaPROL = true;
                }
            }
            return DiaPROL;
        }
        
        private List<BEPedidoWebDetalle> PedidoJerarquico(List<BEPedidoWebDetalle> listadoPedidos)
        {
            List<BEPedidoWebDetalle> result = new List<BEPedidoWebDetalle>();
            List<BEPedidoWebDetalle> padres = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == 0).ToList();
            foreach (var item in padres)
            {
                result.Add(item);
                var items = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == item.PedidoDetalleID);
                if (items.Count() != 0)
                    result.AddRange(items);
            }

            return result;
        }

        private dynamic CalcularGananciaEstimada(int paisId, int campaniaId, int pedidoId, decimal totalPedido)
        {
            // se consultan los indicadores de descuento de los productos del pedido (PedidoWebDetalle)
            BEFactorGanancia FactorGanancia = new BEFactorGanancia();
            List<BEPedidoWebDetalleDescuento> ProductosIndicadorDscto = new List<BEPedidoWebDetalleDescuento>();

            using (SACServiceClient sv = new SACServiceClient())
            {
                ProductosIndicadorDscto = sv.GetIndicadorDescuentoByPedidoWebDetalle(paisId, campaniaId, pedidoId).ToList();
                FactorGanancia = sv.GetFactorGananciaEscalaDescuento(totalPedido, paisId);
                if (FactorGanancia == null)
                    FactorGanancia = new BEFactorGanancia { FactorGananciaID = 0, Porcentaje = 0 };
            }

            // se recorren los productos del pedido y se evalua su indicador de descuento aplicando la logica siguiente:
            ProductosIndicadorDscto.ForEach(delegate(BEPedidoWebDetalleDescuento productoIndicadorDscto)
            {
                string indicador = productoIndicadorDscto.IndicadorDscto.ToLower();
                decimal indicadorNumero;

                // Espacio en blanco: Precio Unitario - Precio Catalogo
                if (indicador == " ")
                {
                    productoIndicadorDscto.MontoDscto = (productoIndicadorDscto.PrecioUnidad - productoIndicadorDscto.PrecioCatalogo2) * productoIndicadorDscto.Cantidad;
                    return;
                }
                // 'C': porcentaje de acuerdo al rango del total
                if (indicador == "c")
                {
                    productoIndicadorDscto.MontoDscto = (productoIndicadorDscto.PrecioUnidad * (FactorGanancia.Porcentaje / 100)) * productoIndicadorDscto.Cantidad;
                    return;
                }
                // numero: porcentaje de descuento
                if (decimal.TryParse(indicador, out indicadorNumero))
                {
                    // debe estar en el rango de 1 a 100
                    if (indicadorNumero >= 0 && indicadorNumero <= 100)
                    {
                        productoIndicadorDscto.MontoDscto = (productoIndicadorDscto.PrecioUnidad * (indicadorNumero / 100)) * productoIndicadorDscto.Cantidad;
                    }
                }
            });

            // se suman todos los montos de descuento para obtener el estimado de ganancia
            decimal estimadoGanancia = ProductosIndicadorDscto.Sum(p => p.MontoDscto);
            return estimadoGanancia;
        }

        #endregion
    }
}
