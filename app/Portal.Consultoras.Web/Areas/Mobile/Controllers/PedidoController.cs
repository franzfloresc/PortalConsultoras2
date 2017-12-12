using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;
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

            sessionManager.SetObservacionesProl(null);
            sessionManager.SetPedidoWeb(null);
            sessionManager.SetDetallesPedido(null);

            var configuracionCampania = GetConfiguracionCampania(userData);
            if (configuracionCampania == null)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (configuracionCampania.CampaniaID == 0)
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

            if (configuracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && !configuracionCampania.ModificaPedidoReservado
                && !configuracionCampania.ValidacionAbierta)
                return RedirectToAction("Validado", "Pedido", new { area = "Mobile" });



            var detallesPedidoWeb = ObtenerPedidoWebDetalle();
            if ((detallesPedidoWeb == null || !detallesPedidoWeb.Any())
                && GetSeInsertoProductoAutomaticos(userData))
            {
                sessionManager.SetDetallesPedido(null);
                detallesPedidoWeb = ObtenerPedidoWebDetalle();
                UpdPedidoWebMontosPROL();
            }

            detallesPedidoWeb = detallesPedidoWeb ?? new List<BEPedidoWebDetalle>();
            BEPedidoWeb pedidoWeb = ObtenerPedidoWeb() ?? new BEPedidoWeb(); ;

            model.MontoAhorroCatalogo = pedidoWeb.MontoAhorroCatalogo;
            model.MontoAhorroRevista = pedidoWeb.MontoAhorroRevista;

            if (userData.PedidoID == 0 && detallesPedidoWeb.Count > 0)
            {
                userData.PedidoID = detallesPedidoWeb[0].PedidoID;
                SetUserData(userData);
            }

            model.PaisId = userData.PaisID;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = ViewBag.Campania;
            model.CampaniaNro = userData.CampaniaNro;
            model.Total = detallesPedidoWeb.Sum(p => p.ImporteTotal);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, userData.CodigoISO);
            model.TotalMinimo = detallesPedidoWeb.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, userData.CodigoISO);
            model.MontoConDsctoStr = Util.DecimalToStringFormat(model.Total - pedidoWeb.DescuentoProl, userData.CodigoISO);
            model.DescuentoStr = (pedidoWeb.DescuentoProl > 0 ? "-" : "") + Util.DecimalToStringFormat(pedidoWeb.DescuentoProl, userData.CodigoISO);
            model.ListaProductos = detallesPedidoWeb.ToList();
            model.CantidadProductos = detallesPedidoWeb.Sum(p => p.Cantidad);
            model.GananciaFormat = Util.DecimalToStringFormat(model.MontoAhorroCatalogo + model.MontoAhorroRevista, userData.CodigoISO);
            model.FormatoMontoAhorroCatalogo = Util.DecimalToStringFormat(model.MontoAhorroCatalogo, userData.CodigoISO);
            model.FormatoMontoAhorroRevista = Util.DecimalToStringFormat(model.MontoAhorroRevista, userData.CodigoISO);
            model.ListaClientes = GetClientesByConsultora(userData) ?? new List<BECliente>();
            model.ListaClientes.Insert(0, new BECliente { ClienteID = 0, Nombre = userData.NombreConsultora });
            model.ListaClientes.Insert(0, new BECliente { ClienteID = -1, Nombre = "NUEVO CLIENTE +" });
            model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
            model.TieneCupon = userData.TieneCupon;
            model.EmailActivo = userData.EMailActivo;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = userData.CampaniaID.ToString();
            model.EMail = userData.EMail;
            model.Celular = userData.Celular;
            model.TieneMasVendidos = userData.TieneMasVendidos;
            model.RevistaDigital = revistaDigital;
            var isMobileApp = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion", false) != null;
            var mobileConfiguracion = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");
            model.ClienteId = mobileConfiguracion.ClienteID;
            model.Nombre = string.Empty;
            if (isMobileApp && model.ListaClientes.Any(x => x.ClienteID == mobileConfiguracion.ClienteID))
            {
                model.Nombre = model.ListaClientes.FirstOrDefault(x => x.ClienteID == mobileConfiguracion.ClienteID).Nombre;
            }

            ViewBag.MobileApp = isMobileApp;
            ViewBag.MensajePedidoMobile = userData.MensajePedidoMobile;
            ViewBag.paisISO = userData.CodigoISO;
            ViewBag.Ambiente = GetBucketNameFromConfig();
            ViewBag.UrlFranjaNegra = GetUrlFranjaNegra();
            ViewBag.DataBarra = GetDataBarra(true, true);

            model.MostrarPopupPrecargados = (GetMostradoPopupPrecargados() == 0);

            return View("Index", model);
        }

        private BEConfiguracionCampania GetConfiguracionCampania( UsuarioModel userData)
        {
            BEConfiguracionCampania configuracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                configuracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            return configuracionCampania;
        }

        private bool GetSeInsertoProductoAutomaticos(UsuarioModel userData)
        {
            bool seInsertoProductosAutomaticos;

            var bePedidoWeb = new BEPedidoWeb();
            bePedidoWeb.CampaniaID = userData.CampaniaID;
            bePedidoWeb.ConsultoraID = userData.ConsultoraID;
            bePedidoWeb.PaisID = userData.PaisID;
            bePedidoWeb.IPUsuario = userData.IPUsuario;
            bePedidoWeb.CodigoUsuarioCreacion = userData.CodigoUsuario;
            using (var sv = new PedidoServiceClient())
            {
                seInsertoProductosAutomaticos = sv.GetProductoCUVsAutomaticosToInsert(bePedidoWeb) > 0;
            }

            return seInsertoProductosAutomaticos;
        }

        private List<BECliente> GetClientesByConsultora(UsuarioModel userData)
        {
            List<BECliente> clientesByConsultora;
            using (var sv = new ClienteServiceClient())
            {
                clientesByConsultora = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }

            return clientesByConsultora;
        }





        public ActionResult virtualCoach(string param = "")
        {
            string cuv = String.Empty;
            string campanaId = "0";
            int campana = 0;
            try
            {
                cuv = param.Substring(0, 5);
                campanaId = param.Substring(5, 6);
                campana = Convert.ToInt32(campanaId);
            }
            catch (Exception ex)
            {
                cuv = "";
                campana = 0;
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return RedirectToAction("Detalle", new RouteValueDictionary(new { controller = "FichaProducto", area = "Mobile", param=param }));
        }

        public ActionResult Detalle(bool autoReservar = false)
        {
            sessionManager.SetObservacionesProl(null);
            sessionManager.SetDetallesPedido(null);

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
            model.AutoReservar = autoReservar;
            model.CodigoISO = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = userData.CampaniaID.ToString();
            model.FechaFacturacionPedido = ViewBag.FechaFacturacionPedido;
            model.FlagValidacionPedido = beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && beConfiguracionCampania.ModificaPedidoReservado ? "1" : "0";

            ValidarStatusCampania(beConfiguracionCampania);

            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            DateTime diaActual = DateTime.Today.Add(HoraCierrePortal);
            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month);

            if (!userData.DiaPROL)  // Periodo de venta
            {
                ViewBag.AccionBoton = "guardar";
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);

                if (userData.CodigoISO == "BO")
                {
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                }
            }
            else // Periodo de facturacion
            {
                if (userData.NuevoPROL && userData.ZonaNuevoPROL)   // PROL 2
                {
                    ViewBag.AccionBoton = "validar";
                    model.Prol = "RESERVA TU PEDIDO";
                    model.ProlTooltip = "Haz click aqui para reservar tu pedido";

                    if (diaActual <= userData.FechaInicioCampania)
                    {
                        model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                    }
                    else
                    {
                        if (userData.CodigoISO == "BO")
                        {
                            model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                        }
                        else
                        {
                            model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                        }
                    }
                }
                else // PROL 1
                {
                    if (userData.PROLSinStock)
                    {
                        ViewBag.AccionBoton = "guardar";
                        model.Prol = "GUARDA TU PEDIDO";
                        model.ProlTooltip = "Es importante que guardes tu pedido";
                        model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                    }
                    else
                    {
                        ViewBag.AccionBoton = "validar";
                        model.Prol = "VALIDA TU PEDIDO";
                        model.ProlTooltip = "Haz click aqui para validar tu pedido";

                        if (diaActual <= userData.FechaInicioCampania)
                        {
                            model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                        }
                        else
                        {
                            if (userData.CodigoISO == "BO")
                            {
                                model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                            }
                            else
                            {
                                model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                            }
                        }
                    }

                }
            }

            var pedidoWeb = ObtenerPedidoWeb();
            ViewBag.MontoAhorroCatalogo = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroCatalogo, userData.CodigoISO);
            ViewBag.MontoAhorroRevista = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroRevista, userData.CodigoISO);
            ViewBag.MontoDescuento = Util.DecimalToStringFormat(pedidoWeb.DescuentoProl, userData.CodigoISO);
            ViewBag.GananciaEstimada = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroCatalogo + pedidoWeb.MontoAhorroRevista, userData.CodigoISO);

            model.PaisID = userData.PaisID;

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

            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
            model.EsFacturacion = esFacturacion;
            model.OfertaFinal = userData.OfertaFinal;
            model.EsOfertaFinalZonaValida = userData.EsOfertaFinalZonaValida;

            model.OfertaFinalGanaMas = userData.OfertaFinalGanaMas;
            model.EsOFGanaMasZonaValida = userData.EsOFGanaMasZonaValida;

            model.ListaParametriaOfertaFinal = GetParametriaOfertaFinal();
            model.EsConsultoraNueva = VerificarConsultoraNueva();
            model.MontoMinimo = userData.MontoMinimo;
            model.MontoMaximo = userData.MontoMaximo;
            model.Total = pedidoWeb.ImporteTotal;
            model.DataBarra = GetDataBarra(true, true);

            ViewBag.CUVOfertaProl = TempData["CUVOfertaProl"];
            model.TieneCupon = userData.TieneCupon;
            model.EmailActivo = userData.EMailActivo;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = userData.CampaniaID.ToString();
            model.EMail = userData.EMail;
            model.Celular = userData.Celular;
            ViewBag.paisISO = userData.CodigoISO;
            ViewBag.Ambiente = GetBucketNameFromConfig();

            ViewBag.NombreConsultora = userData.Sobrenombre;
            if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                model.Prol = "GUARDA TU PEDIDO";
            var ofertaFinalModel = GetOfertaFinal();
            ViewBag.OfertaFinalEstado = ofertaFinalModel.Estado;
            ViewBag.OfertaFinalAlgoritmo = ofertaFinalModel.Algoritmo;
            ViewBag.UrlTerminosOfertaFinalRegalo = string.Format(GetConfiguracionManager(Constantes.ConfiguracionManager.oferta_final_regalo_url_s3), userData.CodigoISO);

            if (Session["EsShowRoom"] != null && Session["EsShowRoom"].ToString() == "1")
            {
                ViewBag.ImagenFondoOFRegalo = ObtenerValorPersonalizacionShowRoom("ImagenFondoOfertaFinalRegalo", "Mobile");
                ViewBag.Titulo1OFRegalo = ObtenerValorPersonalizacionShowRoom("Titulo1OfertaFinalRegalo", "Mobile");
                ViewBag.ColorFondo1OFRegalo = ObtenerValorPersonalizacionShowRoom("ColorFondo1OfertaFinalRegalo", "Mobile");
            }
            model.MostrarPopupPrecargados = (GetMostradoPopupPrecargados() == 0);

            return View(model);
        }

        public ActionResult CampaniaZonaNoConfigurada()
        {
            ViewBag.MensajeCampaniaZona = userData.CampaniaID == 0 ? "Campaña" : "Zona";
            return View();
        }

        [HttpGet]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult Validado()
        {
            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            beConfiguracionCampania = beConfiguracionCampania ?? new BEConfiguracionCampania();
            
            if (beConfiguracionCampania.CampaniaID > userData.CampaniaID)
                return RedirectToAction("Index");
            
            if (beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                && (beConfiguracionCampania.ModificaPedidoReservado
                || beConfiguracionCampania.ValidacionAbierta))
            {
                return RedirectToAction("Index", new { area = "Mobile" });
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

            ViewBag.MontoAhorroCatalogo = Util.DecimalToStringFormat(model.MontoAhorroCatalogo, userData.CodigoISO);
            ViewBag.MontoAhorroRevista = Util.DecimalToStringFormat(model.MontoAhorroRevista, userData.CodigoISO);
            model.PaisID = userData.PaisID;

            if (lstPedidoWebDetalle.Count != 0)
            {
                if (userData.PedidoID == 0)
                {
                    userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                    SetUserData(userData);
                }
                model.Email = userData.EMail;
            }

            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            DateTime diaActual = DateTime.Today.Add(HoraCierrePortal);
            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month);

            if (!userData.DiaPROL)  // Periodo de venta
            {
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);

                if (userData.CodigoISO == "BO")
                {
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                }
            }
            else // Periodo de facturacion
            {
                if (userData.NuevoPROL && userData.ZonaNuevoPROL)   // PROL 2
                {
                    model.Prol = "MODIFICA TU PEDIDO";
                    model.ProlTooltip = "Modifica tu pedido sin perder lo que ya reservaste.";

                    if (diaActual <= userData.FechaInicioCampania)
                    {
                        model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                    }
                    else
                    {
                        model.ProlTooltip += string.Format("|Hazlo antes de las {0} para facturarlo.", diaActual.ToString("hh:mm tt"));
                    }
                }
                else // PROL 1
                {
                    if (userData.PROLSinStock)
                    {
                        model.Prol = "GUARDA TU PEDIDO";
                        model.ProlTooltip = "Es importante que guardes tu pedido";
                        model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                    }
                    else
                    {
                        model.Prol = "VALIDA TU PEDIDO";
                        model.ProlTooltip = "Haz click aquí para validar tu pedido";

                        if (diaActual <= userData.FechaInicioCampania)
                        {
                            model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                        }
                        else
                        {
                            if (userData.CodigoISO == "BO")
                            {
                                model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                            }
                            else
                            {
                                model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                            }
                        }
                    }
                }
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
            model.HoraCierre = FormatearHora(sp);
            model.ModificacionPedidoProl = userData.NuevoPROL && userData.ZonaNuevoPROL ? 0 : 1;

            if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                model.Prol = "GUARDA TU PEDIDO";

            return View(model);
        }

        #endregion

        #region Metodos

        private void ValidarStatusCampania(BEConfiguracionCampania beConfiguracionCampania)
        {
            UsuarioModel usuario = userData;
            usuario.ZonaValida = beConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = beConfiguracionCampania.FechaInicioFacturacion;

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
            if (sessionManager.GetUserData() != null)
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
                    int cantidad = 0;
                    if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
                    {
                        cantidad = BuildFechaNoHabil();
                    }
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
                        int cantidad = 0;
                        if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
                        {
                            cantidad = BuildFechaNoHabil();
                        }
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
                if (items.Any())
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
            ProductosIndicadorDscto.ForEach(delegate (BEPedidoWebDetalleDescuento productoIndicadorDscto)
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

        private List<BEEscalaDescuento> GetParametriaOfertaFinal()
        {
            List<BEEscalaDescuento> listaParametriaOfertaFinal = new List<BEEscalaDescuento>();

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaParametriaOfertaFinal = sv.GetParametriaOfertaFinal(userData.PaisID, GetOfertaFinal().Algoritmo).ToList() ?? new List<BEEscalaDescuento>();
                }
            }
            catch (Exception)
            {
                listaParametriaOfertaFinal = new List<BEEscalaDescuento>();
            }

            return listaParametriaOfertaFinal;
        }

        public bool VerificarConsultoraNueva()
        {
            int segmentoId;

            if (userData.CodigoISO == "VE")
            {
                segmentoId = userData.SegmentoID;
            }
            else
            {
                segmentoId = (userData.SegmentoInternoID == null) ? userData.SegmentoID : (int)userData.SegmentoInternoID;
            }

            bool resultado = segmentoId == 1;

            return resultado;
        }

    }
}
