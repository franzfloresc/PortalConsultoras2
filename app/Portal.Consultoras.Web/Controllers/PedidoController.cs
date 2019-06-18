using AutoMapper;
using AutoMapper.Internal;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.OrigenPedidoWeb;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ProgramaNuevas;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Routing;
using BEPedidoWeb = Portal.Consultoras.Web.ServicePedido.BEPedidoWeb;
using BEPedidoWebDetalle = Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle;


namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoController : BaseController
    {
        private readonly int CANTIDAD_FILAS_AUTOCOMPLETADO = 5;
        private readonly int CRITERIO_BUSQUEDA_CUV_PRODUCTO = 1;
        private readonly int CRITERIO_BUSQUEDA_DESC_PRODUCTO = 2;
        private readonly int CRITERIO_BUSQUEDA_PRODUCTO_CANT = 10;
        private readonly int CUV_NO_TIENE_CREDITO = 2;

        private readonly PedidoSetProvider _pedidoSetProvider;
        private readonly OfertaBaseProvider _ofertaBaseProvider;
        protected ProductoFaltanteProvider _productoFaltanteProvider;
        private readonly ConfiguracionPaisDatosProvider _configuracionPaisDatosProvider;
        private readonly CaminoBrillanteProvider _caminoBrillanteProvider;

        public PedidoController()
            : this(new PedidoSetProvider(),
                  new ProductoFaltanteProvider(),
                  new ConfiguracionPaisDatosProvider(), new OfertaBaseProvider(), new CaminoBrillanteProvider())
        {
        }

        public PedidoController(PedidoSetProvider pedidoSetProvider,
            ProductoFaltanteProvider productoFaltanteProvider,
            ConfiguracionPaisDatosProvider configuracionPaisDatosProvider, OfertaBaseProvider ofertaBaseProvider, CaminoBrillanteProvider caminoBrillanteProvider)
        {
            _pedidoSetProvider = pedidoSetProvider;
            _ofertaBaseProvider = ofertaBaseProvider;
            _productoFaltanteProvider = productoFaltanteProvider;
            _configuracionPaisDatosProvider = configuracionPaisDatosProvider;
            _caminoBrillanteProvider = caminoBrillanteProvider;
        }

        public ActionResult Index(bool lanzarTabConsultoraOnline = false, string cuv = "", int campana = 0)
        {
            var model = new PedidoSb2Model();

            try
            {
                if (EsDispositivoMovil())
                {
                    var url = (Request.Url.Query).Split('?');
                    if (url.Length > 1 && url[1].Contains("sap"))
                    {
                        string sap = "&" + url[1];
                        return RedirectToAction("Index", "Pedido", new { area = "Mobile", sap });
                    }
                    else
                    {
                        return RedirectToAction("Index", "Pedido", new { area = "Mobile" });
                    }
                }

                model.EsPais = GetMarcaPorCodigoIso(userData.CodigoISO);
                model.CodigoIso = userData.CodigoISO;
                model.EsConsultoraOficina = userData.EsConsultoraOficina;
                SessionManager.SetObservacionesProl(null);
                SessionManager.SetPedidoWeb(null);
                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);

                #region Flexipago
                if (PaisTieneFlexiPago(userData.CodigoISO))
                {
                    model.IndicadorFlexiPago = userData.IndicadorFlexiPago;

                    if (userData.IndicadorFlexiPago != 0)
                    {
                        var flexipago = GetLineaCreditoFlexipago(userData);
                        model.LineaCredito = flexipago.LineaCredito;
                        model.PedidoBase = flexipago.PedidoBase;
                    }
                }
                #endregion

                #region Configuracion de Campaña

                var configuracionCampania = GetConfiguracionCampania();

                if (configuracionCampania == null)
                    return RedirectToAction("CampaniaZonaNoConfigurada");

                if (configuracionCampania.CampaniaID == 0)
                    return RedirectToAction("CampaniaZonaNoConfigurada");

                SessionManager.SetPedidoValidado(false);

                if ((configuracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado && userData.FechaFinCampania == Util.GetDiaActual(userData.ZonaHoraria)) &&
                    !configuracionCampania.ModificaPedidoReservado &&
                    !configuracionCampania.ValidacionAbierta)
                {
                    SessionManager.SetPedidoValidado(true);
                    return RedirectToAction("PedidoValidado");
                }

                userData.ZonaValida = configuracionCampania.ZonaValida;

                model.FlagValidacionPedido = "0";
                if ((configuracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado && userData.FechaFinCampania == Util.GetDiaActual(userData.ZonaHoraria)) &&
                    configuracionCampania.ModificaPedidoReservado)
                {
                    model.FlagValidacionPedido = "1";
                }

                model.EstadoPedido = EsPedidoReservado(configuracionCampania).ToInt();


                ActualizarUserDataConInformacionCampania(configuracionCampania);

                var horaCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
                var diaActual = DateTime.Today.Add(horaCierrePortal);
                var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month);

                if (!userData.DiaPROL)  // Periodo de venta
                {
                    model.AccionBoton = "guardar";
                    model.Prol = "GUARDAR TU PEDIDO";
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);

                    if (userData.CodigoISO == Constantes.CodigosISOPais.Bolivia)
                    {
                        model.ProlTooltip = "Es importante que guardes tu pedido";
                        model.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                    }
                }
                else // Periodo de facturacion
                {
                    model.AccionBoton = "validar";
                    if (model.EstadoPedido == 1) //Reservado
                        model.Prol = "MODIFICA TU PEDIDO";
                    else
                        model.Prol = "RESERVA TU PEDIDO";

                    model.ProlTooltip = "Haz click aqui para reservar tu pedido";
                    model.IndicadorGPRSB = configuracionCampania.IndicadorGPRSB;

                    if (diaActual <= userData.FechaInicioCampania)
                    {
                        model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                    }
                    else
                    {
                        if (userData.CodigoISO == Constantes.CodigosISOPais.Bolivia)
                        {
                            model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                        }
                        else
                        {
                            model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                        }
                    }
                }

                #endregion

                #region Pedido Web y Detalle

                if (userData.EsConsultora())
                {
                    var pedidoWeb = ObtenerPedidoWeb();

                    model.PedidoWebDetalle = ObtenerPedidoWebDetalle();
                    model.Total = model.PedidoWebDetalle.Sum(p => p.ImporteTotal);
                    model.MontoAhorroCatalogo = pedidoWeb.MontoAhorroCatalogo;
                    model.MontoAhorroRevista = pedidoWeb.MontoAhorroRevista;
                    model.MontoDescuento = pedidoWeb.DescuentoProl;
                    model.MontoEscala = pedidoWeb.MontoEscala;
                    model.TotalConDescuento = model.Total - model.MontoDescuento;
                    model.GananciaRevista = pedidoWeb.GananciaRevista;
                    model.GananciaWeb = pedidoWeb.GananciaWeb;
                    model.GananciaOtros = pedidoWeb.GananciaOtros;
                    model.IsShowGananciaConsultora = IsCalculoGananaciaConsultora(pedidoWeb);

                    SessionManager.SetMontosProl(
                        new List<ObjMontosProl>
                        {
                            new ObjMontosProl
                            {
                                AhorroCatalogo = model.MontoAhorroCatalogo.ToString(),
                                AhorroRevista = model.MontoAhorroRevista.ToString(),
                                MontoTotalDescuento = model.MontoDescuento.ToString(),
                                MontoEscala = model.MontoEscala.ToString()
                            }
                        }
                    );

                    model.ListaParametriaOfertaFinal = GetParametriaOfertaFinal(SessionManager.GetOfertaFinalModel().Algoritmo);
                }
                else
                {
                    model.PedidoWebDetalle = new List<BEPedidoWebDetalle>();
                }

                model.DataBarra = GetDataBarra(true, true);

                userData.PedidoID = 0;
                if (model.PedidoWebDetalle.Count != 0
                    && userData.PedidoID == 0)
                {
                    userData.PedidoID = model.PedidoWebDetalle[0].PedidoID;
                    SessionManager.SetUserData(userData);
                }

                #endregion

                #region Banners

                var urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
                var urlProdDesc = WebConfigurationManager.AppSettings["ProdDesc"] + "/" + userData.CodigoISO;
                var banner01 = WebConfigurationManager.AppSettings["banner_01"];
                var banner02 = WebConfigurationManager.AppSettings["banner_02"];
                var banner03 = WebConfigurationManager.AppSettings["banner_03"];

                model.UrlBanner01 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner01);
                model.UrlBanner02 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner02);
                model.UrlBanner03 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner03);

                model.accionBanner_01 = ConfigCdn.GetUrlFileCdn(urlProdDesc, userData.CampaniaID + ".pdf");

                #endregion

                #region Valores de userdata

                model.TotalCliente = "";
                model.ClienteID_ = "-1";

                model.EstadoSimplificacionCuv = userData.EstadoSimplificacionCUV;
                model.ErrorInsertarProducto = "";
                model.ListaEstrategias = new List<ServicePedido.BEEstrategia>();
                model.NombreConsultora = userData.NombreConsultora;
                model.PaisID = userData.PaisID;
                model.Simbolo = userData.Simbolo;

                model.Campania = ViewBag.Campania;
                model.CampaniaId = userData.CampaniaID;
                model.Dias = ViewBag.Dias;
                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.CodigoZona = userData.CodigoZona;
                model.FechaFacturacionPedido = ViewBag.FechaFacturacionPedido;

                var nombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre;
                model.SobreNombre = Util.SubStrCortarNombre(nombreConsultora, 8).ToUpper();

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                var esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
                model.EsFacturacion = esFacturacion;
                model.OfertaFinal = userData.OfertaFinal;

                model.EsOfertaFinalZonaValida = userData.EsOfertaFinalZonaValida;

                model.OfertaFinalGanaMas = userData.OfertaFinalGanaMas;
                model.EsOFGanaMasZonaValida = userData.EsOFGanaMasZonaValida;
                model.MontoMinimo = userData.MontoMinimo;
                model.MontoMaximo = userData.MontoMaximo;

                model.EsConsultoraNueva = VerificarConsultoraNueva();

                #endregion

                #region Pedidos Pendientes

                ViewBag.MostrarPedidosPendientes = "0";

                if (_configuracionManagerProvider.GetMostrarPedidosPendientesFromConfig())
                {
                    var paisesConsultoraOnline = _configuracionManagerProvider.GetPaisesConConsultoraOnlineFromConfig();
                    if (paisesConsultoraOnline.Contains(userData.CodigoISO) && userData.EsConsultora())
                    {
                        using (var svc = new UsuarioServiceClient())
                        {
                            var cantPedidosPendientes = svc.GetCantidadSolicitudesPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                            if (cantPedidosPendientes > 0)
                            {
                                ViewBag.MostrarPedidosPendientes = "1";
                                ViewBag.CantPedidosPendientes = cantPedidosPendientes;

                            }
                        }
                    }
                }

                #endregion

                ViewBag.UrlTerminosOfertaFinalRegalo = string.Format(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.oferta_final_regalo_url_s3), userData.CodigoISO);
                model.MostrarPopupPrecargados = (GetMostradoPopupPrecargados() == 0);

                ViewBag.CUVOfertaProl = TempData["CUVOfertaProl"];
                ViewBag.MensajePedidoDesktop = userData.MensajePedidoDesktop;
                model.PartialSectionBpt = _configuracionPaisDatosProvider.GetPartialSectionBptModel(Constantes.OrigenPedidoWeb.SectionBptDesktopPedido);

                ViewBag.NombreConsultora = userData.Sobrenombre;
                if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                    model.Prol = "GUARDAR TU PEDIDO";

                model.CampaniaActual = userData.CampaniaID;
                model.Simbolo = userData.Simbolo;

                #region Cupon
                model.TieneCupon = userData.TieneCupon;
                model.EMail = userData.EMail;
                model.Celular = userData.Celular;
                model.EmailActivo = userData.EMailActivo;
                #endregion

                ViewBag.paisISO = userData.CodigoISO;
                ViewBag.Ambiente = _configuracionManagerProvider.GetBucketNameFromConfig();
                ViewBag.CodigoConsultora = userData.CodigoConsultora;
                model.TieneMasVendidos = userData.TieneMasVendidos;
                var ofertaFinal = SessionManager.GetOfertaFinalModel();
                ViewBag.OfertaFinalEstado = ofertaFinal.Estado;
                ViewBag.OfertaFinalAlgoritmo = ofertaFinal.Algoritmo;
                ViewBag.UrlFranjaNegra = _eventoFestivoProvider.GetUrlFranjaNegra();

                ViewBag.ActivarRecomendaciones = ObtenerFlagActivacionRecomendaciones();
                ViewBag.MaxCaracteresRecomendaciones = ObtenerNumeroMaximoCaracteresRecomendaciones(false);

                #region Camino Brillante 

                ViewBag.KitsCaminoBrillante = _caminoBrillanteProvider.GetKitsCaminoBrillante().ToList();

                #endregion

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }


            ViewBag.UrlTerminosOfertaFinalRegalo = string.Format(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.oferta_final_regalo_url_s3), userData.CodigoISO);

            if (!SessionManager.GetEsShowRoom() && SessionManager.GetEsShowRoom().ToString() == "1")
            {
                ViewBag.ImagenFondoOFRegalo =
                    _showRoomProvider.ObtenerValorPersonalizacionShowRoom("ImagenFondoOfertaFinalRegalo", "Desktop");
                ViewBag.Titulo1OFRegalo =
                    _showRoomProvider.ObtenerValorPersonalizacionShowRoom("Titulo1OfertaFinalRegalo", "Desktop");
            }

            model.MensajeKitNuevas = _programaNuevasProvider.GetMensajeKit();

            return View("Index", model);
        }

        public ActionResult virtualCoach(string param = "")
        {
            try
            {
                if (EsDispositivoMovil())
                {
                    var url = (Request.Url.Query).Split('?');

                    if (url.Length > 1 && url[1].Contains("sap"))
                    {
                        string sap = "&" + url[1].Remove(0, 22);
                        return RedirectToAction("virtualCoach", new RouteValueDictionary(new { controller = "Pedido", area = "Mobile", param, sap }));
                    }
                    else
                    {
                        return RedirectToAction("virtualCoach", new RouteValueDictionary(new { controller = "Pedido", area = "Mobile", param }));
                    }

                }

                var cuv = param.Substring(0, 5);
                var campanaId = param.Substring(5, 6);
                var campana = Convert.ToInt32(campanaId);
                ViewBag.VirtualCoachCuv = cuv;
                ViewBag.VirtualCoachCampana = campanaId;
                return Index(false, cuv, campana);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            return Index();
        }

        private string GetMarcaPorCodigoIso(string codigoIso)
        {
            return _configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(codigoIso) ? "Ésika" : "L'bel";
        }

        private string GetPaisesFlexiPago()
        {
            return _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesFlexipago);
        }

        private bool PaisTieneFlexiPago(string codigoIso)
        {
            return GetPaisesFlexiPago().Contains(codigoIso);
        }

        private void ActualizarUserDataConInformacionCampania(BEConfiguracionCampania configuracionCampania)
        {
            var usuario = userData;
            usuario.ZonaValida = configuracionCampania.ZonaValida;
            usuario.FechaInicioCampania = configuracionCampania.FechaInicioFacturacion;
            usuario.FechaFinCampania = configuracionCampania.FechaFinFacturacion;
            usuario.HoraInicioReserva = configuracionCampania.HoraInicio;
            usuario.HoraFinReserva = configuracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = configuracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = configuracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = configuracionCampania.DiasAntes;
            ActualizarEsDiaPROLyMostrarBotonValidarPedido(usuario);
            usuario.NombreCorto = configuracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = configuracionCampania.CampaniaID;
            usuario.ZonaHoraria = configuracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = configuracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = configuracionCampania.HoraCierreZonaNormal;
            usuario.ValidacionAbierta = configuracionCampania.ValidacionAbierta;
            usuario.ValidacionInteractiva = configuracionCampania.ValidacionInteractiva;
            usuario.MensajeValidacionInteractiva = configuracionCampania.MensajeValidacionInteractiva;

            if (DateTime.Now.AddHours(configuracionCampania.ZonaHoraria) < configuracionCampania.FechaInicioFacturacion.AddDays(-configuracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = configuracionCampania.FechaInicioFacturacion.AddDays(-configuracionCampania.DiasAntes);
                usuario.HoraFacturacion = configuracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = configuracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = configuracionCampania.HoraFin;
            }
            var fechaActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            var horaActual = new TimeSpan(fechaActual.Hour, fechaActual.Minute, 0);
            var horaCierrePais = usuario.EsZonaDemAnti == 0 ? usuario.HoraCierreZonaNormal : usuario.HoraCierreZonaDemAnti;

            if (horaActual > horaCierrePais)
            {
                usuario.IngresoPedidoCierre = true;
            }

            SessionManager.SetUserData(usuario);
        }

        private void ActualizarEsDiaPROLyMostrarBotonValidarPedido(UsuarioModel usuario)
        {
            var fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

            usuario.DiaPROL = (usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) < fechaHoraActual
                && fechaHoraActual < usuario.FechaFinCampania.AddDays(1));

            usuario.MostrarBotonValidar = _pedidoWebProvider.EsHoraReserva(usuario, fechaHoraActual);
        }

        #region CRUD

        private List<BECliente> ListarClienteSegunPedido(string clienteId, List<BEPedidoWebDetalle> listaPedido)
        {
            var listaCliente = new List<BECliente>();
            if (clienteId != "-1")
            {
                listaCliente = listaPedido
                    .Select(item => new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre })
                    .GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                listaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });
            }

            return listaCliente;
        }

        public JsonResult CambiarCliente(string ClienteID)
        {
            try
            {
                var olstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                var model = new PedidoSb2Model { Total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal) };

                if (ClienteID != "-1")
                {
                    olstPedidoWebDetalle = (from item in olstPedidoWebDetalle
                                            where item.ClienteID == Convert.ToInt16(ClienteID)
                                            select item).ToList();
                    var totalCliente = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                    model.TotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                }
                else
                    model.TotalCliente = "";

                var cantidadTotal = olstPedidoWebDetalle.Count;

                var paginas = (olstPedidoWebDetalle.Count % 100 == 0) ? (olstPedidoWebDetalle.Count / 100).ToString() : ((olstPedidoWebDetalle.Count / 100) + 1).ToString();

                model.Pagina = paginas == "0" ? "0" : "1";

                if (model.Pagina != "0")
                {
                    olstPedidoWebDetalle = olstPedidoWebDetalle.Skip((Convert.ToInt32(model.Pagina) - 1) * 100).Take(100).ToList();
                }

                if (model.Pagina == "0")
                {
                    model.Registros = "0";
                    model.RegistrosDe = "0";
                    model.RegistrosTotal = "0";
                }
                else
                {
                    model.Registros = "1";
                    model.RegistrosDe = olstPedidoWebDetalle.Count < 100 ? olstPedidoWebDetalle.Count.ToString() : "100";
                    model.RegistrosTotal = cantidadTotal.ToString();
                }

                model.PaginaDe = paginas;
                model.Simbolo = userData.Simbolo;
                model.ClienteID_ = ClienteID;

                var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoWebDetalle>, List<PedidoWebDetalleModel>>(olstPedidoWebDetalle);

                pedidoWebDetalleModel.Update(p => p.Simbolo = userData.Simbolo);

                model.ListaDetalleModel = pedidoWebDetalleModel;

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = model
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        [HttpPost]
        public JsonResult IngresoFAD(PedidoDetalleModel model)
        {
            var result = true;
            var mensaje = string.Empty;
            try
            {
                using (var sv = new SACServiceClient())
                {
                    sv.InsLogIngresoFAD(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, model.CUV, 1, model.PrecioUnidad, userData.ZonaID);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                result = false;
                mensaje = "Error (FAD): Volver a intentar.";
            }

            return Json(new
            {
                success = result,
                message = mensaje,
                extra = ""
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult AceptarBackOrder(int campaniaID, int pedidoID, short pedidoDetalleID, string clienteID)
        {
            try
            {
                var obePedidoWebDetalle = new BEPedidoWebDetalle
                {
                    PaisID = userData.PaisID,
                    CampaniaID = campaniaID,
                    PedidoID = pedidoID,
                    PedidoDetalleID = pedidoDetalleID
                };
                using (var sv = new PedidoServiceClient())
                {
                    sv.AceptarBackOrderPedidoWebDetalle(obePedidoWebDetalle);
                }

                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);

                var olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                var total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                var formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

                var listaCliente = ListarClienteSegunPedido("", olstPedidoWebDetalle);

                var message = "OK";

                return Json(new
                {
                    success = true,
                    message,
                    formatoTotal,
                    total,
                    listaCliente,
                    DataBarra = GetDataBarra()
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    formatoTotal = "",
                    total = "",
                    formatoTotalCliente = "",
                    listaCliente = "",
                    DataBarra = new BarraConsultoraModel()
                });
            }
        }

        #endregion

        #region Ofertas Flexipago

        public string CargarLinkPaisFlexipago()
        {
            var linkFlexipago = "";
            try
            {
                BEOfertaFlexipago entidad;
                using (var svc = new PedidoServiceClient())
                {
                    entidad = svc.GetLinksOfertaFlexipago(userData.PaisID);
                }

                if (!string.IsNullOrEmpty(entidad.LinksFlexipago))
                    linkFlexipago = entidad.LinksFlexipago;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return linkFlexipago;
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private BEOfertaFlexipago GetLineaCreditoFlexipago(UsuarioModel usuarioModel)
        {
            BEOfertaFlexipago ofertaFlexipago = null;
            try
            {
                using (var pedidoServiceClient = new PedidoServiceClient())
                {
                    ofertaFlexipago = pedidoServiceClient.GetLineaCreditoFlexipago(usuarioModel.PaisID,
                        usuarioModel.CodigoConsultora,
                        usuarioModel.CampaniaID);

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

            return ofertaFlexipago;
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private void ObtenerLineaCredito()
        {
            try
            {
                var vPaisId = userData.PaisID;
                var consultora = userData.CodigoConsultora;
                using (var svc = new PedidoServiceClient())
                {
                    var campaniaId = userData.CampaniaID;
                    var oBe = svc.GetLineaCreditoFlexipago(vPaisId, consultora, campaniaId);
                    if (vPaisId == Constantes.PaisID.Colombia)
                    {
                        ViewBag.LineaCredito = string.Format("{0:#,##0}", oBe.LineaCredito);
                        ViewBag.PedidoBase = string.Format("{0:#,##0}", oBe.PedidoBase);
                    }
                    else
                    {
                        ViewBag.LineaCredito = string.Format("{0:#,##0.00}", oBe.LineaCredito);
                        ViewBag.PedidoBase = string.Format("{0:#,##0.00}", oBe.PedidoBase);
                    }

                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);

                if (userData.PaisID == Constantes.PaisID.Colombia)
                {
                    ViewBag.LineaCredito = "0";
                    ViewBag.PedidoBase = "0";

                }
                else
                {
                    ViewBag.LineaCredito = "0.0";
                    ViewBag.PedidoBase = "0.0";
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                if (userData.PaisID == Constantes.PaisID.Colombia)
                {
                    ViewBag.LineaCredito = "0";
                    ViewBag.PedidoBase = "0";

                }
                else
                {
                    ViewBag.LineaCredito = "0.0";
                    ViewBag.PedidoBase = "0.0";
                }
            }
        }

        #endregion

        #region Zona de Estrategias
        [HttpPost]
        public JsonResult ValidarStockEstrategia(string CUV, string PrecioUnidad, string Cantidad, string TipoOferta, bool esCuponNuevas, string descripcion = "")
        {
            string mensajeMontoMax = "", mensaje = "";
            bool validoMontoMax = false, valido = false;

            try
            {
                var intCantidad = Cantidad.ToInt32Secure();
                mensajeMontoMax = ValidarMontoMaximo(Convert.ToDecimal(PrecioUnidad), intCantidad, out validoMontoMax);
                valido = mensajeMontoMax == "" || validoMontoMax;

                if (valido)
                {
                    if (esCuponNuevas)
                    {
                        CrearLogProgNuevas("ProgNuevas: ValidarStockEstrategia", CUV);
                        mensaje = ValidarCantidadEnProgramaNuevas(CUV, Convert.ToInt32(Cantidad));
                    }
                    else mensaje = ValidarStockLimiteVenta(CUV, intCantidad, descripcion);

                    if (mensaje == "") mensaje = ValidarStockEstrategiaMensaje(CUV, intCantidad, TipoOferta.ToInt32Secure());
                    if (mensaje == "") mensaje = ValidarStockArmaTuPackMensaje(CUV, intCantidad);
                    valido = mensaje == "";
                }

                if (valido) mensaje = mensajeMontoMax;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return Json(new { result = valido, message = mensaje }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Autocompletes

        public ActionResult AutocompleteByProductoCUV(string term)
        {
            var productosModel = new List<ProductoModel>();

            try
            {
                productosModel = AutocompleteProductoPedido(term, CRITERIO_BUSQUEDA_CUV_PRODUCTO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(productosModel, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AutocompleteByProductoDescripcion(string term)
        {
            var productosModel = new List<ProductoModel>();

            try
            {
                productosModel = AutocompleteProductoPedido(term, CRITERIO_BUSQUEDA_DESC_PRODUCTO);
                if (productosModel.Count == 1 && productosModel[0].Descripcion == null) productosModel[0].Descripcion = "Sin Resultados";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel.Add(new ProductoModel() { CUV = "0", Descripcion = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(productosModel, JsonRequestBehavior.AllowGet);
        }

        private List<ProductoModel> AutocompleteProductoPedido(string term, int criterio)
        {
            var productosModel = new List<ProductoModel>();
            var productos = SelectProductoByCodigoDescripcionSearchRegionZona(term, userData, CRITERIO_BUSQUEDA_PRODUCTO_CANT, criterio);

            Dictionary<string, Enumeradores.ValidacionProgramaNuevas> dicValidacionCuv;
            var arrayCuvProductos = productos.Select(p => p.CUV).ToArray();
            using (var odsServiceClient = new ODSServiceClient())
            {
                dicValidacionCuv = odsServiceClient.ValidarBusquedaProgramaNuevasList(userData.PaisID, userData.CampaniaID, userData.CodigoPrograma, userData.ConsecutivoNueva, arrayCuvProductos);
            }

            var listEstadosNuevasBloquear = new List<Enumeradores.ValidacionProgramaNuevas> {
                Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste,
                Enumeradores.ValidacionProgramaNuevas.ConsultoraNoNueva,
                Enumeradores.ValidacionProgramaNuevas.CuvNoPerteneceASuPrograma
            };
            var listCuvNuevasBloquear = dicValidacionCuv.Where(vc => listEstadosNuevasBloquear.Contains(vc.Value)).Select(vc => vc.Key).ToList();
            productos = productos.Where(p => !listCuvNuevasBloquear.Contains(p.CUV)).ToList();

            var siExiste = productos.Any(p => p.CUV == term);
            BloqueoProductosCatalogo(ref productos);
            BloqueoProductosDigitales(ref productos);

            if (!productos.Any())
            {
                if (siExiste) productosModel.Add(GetProductoDigital());
                else productosModel.Add(GetProductoNoExiste());

                return productosModel;
            }

            productos = productos.Take(CANTIDAD_FILAS_AUTOCOMPLETADO).ToList();
            var cuv = productos.First().CUV.Trim();
            var mensajeByCuv = GetMensajeByCUV(userData, cuv);
            var tieneRdc = ValidarTieneRDoRDR();

            var listEstadosNuevasValidas = new List<Enumeradores.ValidacionProgramaNuevas> { Enumeradores.ValidacionProgramaNuevas.CuvPerteneceProgramaNuevas };
            var listCuvNuevasValidas = dicValidacionCuv.Where(vc => listEstadosNuevasValidas.Contains(vc.Value)).Select(vc => vc.Key).ToList();
            productosModel.AddRange(productos.Select(prod => new ProductoModel()
            {
                CUV = prod.CUV.Trim(),
                Descripcion = prod.Descripcion.Trim(),
                PrecioCatalogo = prod.PrecioCatalogo,
                MarcaID = prod.MarcaID,
                EstaEnRevista = prod.EstaEnRevista,
                TieneStock = prod.TieneStock,
                EsExpoOferta = prod.EsExpoOferta,
                CUVRevista = prod.CUVRevista.Trim(),
                CUVComplemento = prod.CUVComplemento.Trim(),
                IndicadorMontoMinimo = prod.IndicadorMontoMinimo.ToString().Trim(),
                TipoOfertaSisID = prod.TipoOfertaSisID,
                ConfiguracionOfertaID = prod.ConfiguracionOfertaID,
                MensajeCUV = mensajeByCuv.Mensaje,
                DescripcionMarca = prod.DescripcionMarca,
                DescripcionEstrategia = prod.DescripcionEstrategia,
                DescripcionCategoria = prod.DescripcionCategoria,
                FlagNueva = prod.FlagNueva,
                TipoEstrategiaID = prod.TipoEstrategiaID,
                TieneRDC = tieneRdc,
                EsOfertaIndependiente = prod.EsOfertaIndependiente,
                EsCuponNuevas = listCuvNuevasValidas.Contains(prod.CUV.Trim()),
                CodigoProducto = prod.CodigoProducto,
                CodigoCatalago = prod.CodigoCatalogo,
                EstrategiaIDSicc = prod.EstrategiaIDSicc
            }));
            return productosModel;
        }

        public ActionResult FindByCUV(PedidoDetalleModel model)
        {
            var productosModel = new List<ProductoModel>();
            try
            {
                model.CUV = Util.Trim(model.CUV);

                #region ValidarProgramaNuevas
                var esCuponNuevas = false;
                Enumeradores.ValidacionProgramaNuevas num = ValidarProgramaNuevas(model.CUV);
                switch (num)
                {
                    case Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste:
                        productosModel.Add(GetProductoNoExiste());
                        return Json(productosModel, JsonRequestBehavior.AllowGet);
                    case Enumeradores.ValidacionProgramaNuevas.ConsultoraNoNueva:
                        productosModel.Add(GetValidacionProgramaNuevas(Constantes.ProgNuevas.Mensaje.ConsultoraNoNueva));
                        return Json(productosModel, JsonRequestBehavior.AllowGet);
                    case Enumeradores.ValidacionProgramaNuevas.CuvNoPerteneceASuPrograma:
                        productosModel.Add(GetValidacionProgramaNuevas(Constantes.ProgNuevas.Mensaje.CuvNoPerteneceASuPrograma));
                        return Json(productosModel, JsonRequestBehavior.AllowGet);
                    case Enumeradores.ValidacionProgramaNuevas.CuvPerteneceProgramaNuevas:
                        esCuponNuevas = true;
                        break;
                }
                #endregion

                #region Venta exclusiva
                if (!esCuponNuevas)
                {
                    Enumeradores.ValidacionVentaExclusiva numExclu = ValidarVentaExclusiva(model.CUV);
                    if (numExclu != Enumeradores.ValidacionVentaExclusiva.ContinuaFlujo)
                    {
                        productosModel.Add(GetValidacionProgramaNuevas(Constantes.VentaExclusiva.CuvNoEsVentaExclusiva));
                        return Json(productosModel, JsonRequestBehavior.AllowGet);
                    }
                }
                #endregion

                #region Camino Brillante
                var valCaminoBrillante = _caminoBrillanteProvider.ValidarBusquedaCaminoBrillante(model.CUV);

                if (valCaminoBrillante.Validacion != Enumeradores.ValidacionCaminoBrillante.ProductoNoExiste)
                {
                    productosModel.Add(GetValidacionProgramaNuevas(valCaminoBrillante.Mensaje));
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                #endregion

                var userModel = userData;
                var productos = SelectProductoByCodigoDescripcionSearchRegionZona(model.CUV, userModel, 5, CRITERIO_BUSQUEDA_CUV_PRODUCTO);
                var siExiste = productos.Any(p => p.CUV == model.CUV);
                BloqueoProductosCatalogo(ref productos);
                BloqueoProductosDigitales(ref productos);

                if (!productos.Any())
                {
                    if (siExiste) productosModel.Add(GetProductoDigital());
                    else productosModel.Add(GetProductoNoExiste());

                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                var cuvCredito = ValidarCUVCreditoPorCUVRegular(model, userModel);
                if (cuvCredito.IdMensaje == CUV_NO_TIENE_CREDITO)
                {
                    productosModel.Add(GetProductoCuvRegular(cuvCredito));
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }
                var producto = productos.FirstOrDefault(prod => prod.CUV == model.CUV) ?? new ServiceODS.BEProducto();

                var estrategias = SessionManager.GetBEEstrategia(Constantes.ConstSession.ListaEstrategia) ?? new List<ServiceOferta.BEEstrategia>();

                if (producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackNuevas)
                {
                    var listProdEstraProgNuevas = _programaNuevasProvider.GetListCuvEstrategia();

                    listProdEstraProgNuevas.ForEach(x =>
                    {
                        if (x.Cuv.Equals(producto.CUV))
                        {
                            producto.EsOfertaIndependiente = x.EsCuponIndependiente;
                        }
                    });
                }

                var estrategia = estrategias.FirstOrDefault(p => p.CUV2 == producto.CUV) ?? new ServiceOferta.BEEstrategia();

                var observacionCuv = ObtenerObservacionCreditoCuv(userModel, cuvCredito);

                var mensajeByCuv = GetMensajeByCUV(userModel, producto.CUV.Trim());

                var tieneRdc = ValidarTieneRDoRDR();

                var revistaGana = ValidarDesactivaRevistaGana(userModel);

                var esDuoPerfecto = _programaNuevasProvider.TieneDuoPerfecto();


                productosModel.Add(new ProductoModel()
                {
                    CUV = producto.CUV.Trim(),
                    Descripcion = producto.Descripcion.Trim(),
                    PrecioCatalogo = producto.PrecioCatalogo,
                    MarcaID = producto.MarcaID,
                    EstaEnRevista = producto.EstaEnRevista,
                    TieneStock = producto.TieneStock,
                    EsExpoOferta = producto.EsExpoOferta,
                    CUVRevista = producto.CUVRevista.Trim(),
                    CUVComplemento = producto.CUVComplemento.Trim(),
                    IndicadorMontoMinimo = producto.IndicadorMontoMinimo.ToString().Trim(),
                    TipoOfertaSisID = producto.TipoOfertaSisID,
                    ConfiguracionOfertaID = producto.ConfiguracionOfertaID,
                    ObservacionCUV = observacionCuv,
                    MensajeCUV = mensajeByCuv.Mensaje,
                    DesactivaRevistaGana = revistaGana,
                    DescripcionMarca = producto.DescripcionMarca,
                    DescripcionEstrategia = producto.DescripcionEstrategia,
                    DescripcionCategoria = producto.DescripcionCategoria,
                    FlagNueva = producto.FlagNueva,
                    TipoEstrategiaID = producto.TipoEstrategiaID,
                    TieneSugerido = producto.TieneSugerido,
                    CodigoProducto = producto.CodigoProducto,
                    LimiteVenta = estrategia.LimiteVenta,
                    EsOfertaIndependiente = producto.EsOfertaIndependiente,
                    TieneRDC = tieneRdc,
                    EstrategiaID = producto.EstrategiaID,
                    EsCuponNuevas = esCuponNuevas,
                    CodigoCatalago = producto.CodigoCatalogo,
                    EstrategiaIDSicc = producto.EstrategiaIDSicc,
                    CodigoPalanca = (new OfertaPersonalizadaProvider()).getCodigoPalanca(producto.TipoEstrategiaCodigo),
                    CampaniaID = userModel.CampaniaID,
                    EsDuoPerfecto = producto.FlagNueva == "1" && esDuoPerfecto,
                    CodigoEstrategia = producto.TipoEstrategiaCodigo


                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, "cuv consulta  = " + model.CUV);
                productosModel.Add(new ProductoModel { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo.", TieneSugerido = 0 });
            }
            return Json(productosModel, JsonRequestBehavior.AllowGet);
        }

        private List<ServiceODS.BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(string codigoDescripcion, UsuarioModel userModel, int cantidadFilas, int criterioBusqueda)
        {
            List<ServiceODS.BEProducto> productos;
            ServiceODS.BEProductoBusqueda busqueda = new BEProductoBusqueda
            {
                PaisID = userModel.PaisID,
                CampaniaID = userModel.CampaniaID,
                CodigoDescripcion = codigoDescripcion,
                RegionID = userModel.RegionID,
                ZonaID = userModel.ZonaID,
                CodigoRegion = userModel.CodigorRegion,
                CodigoZona = userModel.CodigoZona,
                Criterio = criterioBusqueda,
                RowCount = cantidadFilas,
                ValidarOpt = true,
                CodigoPrograma = userModel.CodigoPrograma,
                NumeroPedido = userModel.ConsecutivoNueva + 1
            };

            using (var odsServiceClient = new ODSServiceClient())
            {
                productos = odsServiceClient.SelectProductoByCodigoDescripcionSearchRegionZona(busqueda).ToList();
            }

            return productos;
        }

        private void BloqueoProductosCatalogo(ref List<ServiceODS.BEProducto> beProductos)
        {
            if (!beProductos.Any()) return;

            if (!revistaDigital.TieneRDC) return;

            if (!revistaDigital.EsActiva) return;

            if (revistaDigital.BloquearRevistaImpresaGeneral == 1 || revistaDigital.BloqueoRevistaImpresa)
            {
                beProductos = beProductos
                    .Where(x => !("," + userData.CodigosRevistaImpresa + ",").Contains("," + x.CodigoCatalogo.ToString() + ",")).ToList();
            }
        }

        private void BloqueoProductosDigitales(ref List<ServiceODS.BEProducto> beProductos)
        {
            if (beProductos == null) return;
            if (!beProductos.Any()) return;

            beProductos = beProductos
                    .Where(prod =>
                         (prod.CodigoEstrategia != Constantes.TipoEstrategiaSet.CompuestaVariable)
                    )
                    .ToList();

            if (revistaDigital.BloqueoProductoDigital)
            {
                beProductos = beProductos
                    .Where(prod =>
                        !(prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                          || prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                          || prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso)
                        )
                        .ToList();
            }

            if (guiaNegocio.BloqueoProductoDigital)
            {
                beProductos = beProductos
                    .Where(prod =>
                        prod.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada)
                    .ToList();
            }

            if (userData.OptBloqueoProductoDigital)
            {
                beProductos = beProductos
                    .Where(prod => prod.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaParaTi)
                    .ToList();
            }

            if (revistaDigital.TieneRDCR)
            {
                var dato = guiaNegocio.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.BloquearProductoGnd) ?? new ConfiguracionPaisDatosModel();
                dato.Valor1 = Util.Trim(dato.Valor1);
                if (dato.Estado && dato.Valor1 != "")
                {
                    beProductos = beProductos
                        .Where(prod => !dato.Valor1.Contains(prod.CUV))
                        .ToList();
                }
            }

            if (configEstrategiaSR.BloqueoProductoDigital)
            {
                beProductos = beProductos
                    .Where(prod => prod.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.ShowRoom)
                    .ToList();
            }
        }

        private ProductoModel GetProductoNoExiste()
        {
            return new ProductoModel()
            {
                MarcaID = 0,
                CUV = "El producto solicitado no existe.",
                TieneSugerido = 0
            };
        }

        private ProductoModel GetProductoDigital()
        {
            return new ProductoModel()
            {
                MarcaID = 0,
                CUV = "Este producto es una oferta digital. Te invitamos a que revises tu sección de ofertas.",
                TieneSugerido = 0
            };
        }

        private ProductoModel GetProductoCuvRegular(BECUVCredito cuvCredito)
        {
            return new ProductoModel() { MarcaID = 0, CUV = "Código incorrecto, Para solicitar el set: ingresa el código " + cuvCredito.CuvRegular, TieneSugerido = 0 };
        }

        private ProductoModel GetValidacionProgramaNuevas(string mensaje)
        {
            return new ProductoModel()
            {
                MarcaID = 0,
                CUV = mensaje,
                TieneSugerido = 0
            };
        }

        private BEMensajeCUV GetMensajeByCUV(UsuarioModel userModel, string cuv)
        {
            BEMensajeCUV mensajeByCuv;
            using (var odsServiceClient = new ODSServiceClient())
            {
                mensajeByCuv = odsServiceClient.GetMensajeByCUV(userModel.PaisID, userModel.CampaniaID, cuv);
            }

            return mensajeByCuv;
        }

        private BECUVCredito ValidarCUVCreditoPorCUVRegular(PedidoDetalleModel model, UsuarioModel userModel)
        {
            BECUVCredito cuvCredito;
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                cuvCredito = pedidoServiceClient.ValidarCUVCreditoPorCUVRegular(userModel.PaisID, userModel.CodigoConsultora, model.CUV, userModel.CampaniaID);
            }

            return cuvCredito;
        }

        private string ObtenerObservacionCreditoCuv(UsuarioModel userModel, BECUVCredito cuvCredito)
        {
            return cuvCredito.IdMensaje == 1
                ? userModel.PrimerNombre
                    + " tienes el beneficio de pagar en 2 partes el valor de este SET de productos. Si lo deseas ingresa este código al pedir el set: "
                    + cuvCredito.CuvCredito
                : string.Empty;
        }

        private int? ValidarDesactivaRevistaGana(UsuarioModel userModel)
        {
            int? revistaGana;
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                revistaGana = pedidoServiceClient.ValidarDesactivaRevistaGana(userModel.PaisID, userModel.CampaniaID, userModel.CodigoZona);
            }

            return revistaGana;
        }

        [HttpPost]
        public JsonResult ValidarCuvMarquesina(string CampaniaID, string Cuv, string IdBanner)
        {
            int resultado;
            int idPais;

            using (var sv = new ContenidoServiceClient())
            {
                idPais = sv.GetPaisBannerMarquesina(CampaniaID, Convert.ToInt32(IdBanner));
            }

            if (idPais != 0)
            {
                using (var sv2 = new PedidoServiceClient())
                {
                    resultado = sv2.ValidarCuvMarquesina(CampaniaID, Convert.ToInt32(Cuv), idPais);
                }
            }
            else
            {
                resultado = -1;
            }

            return Json(new
            {
                _validado = Convert.ToString(resultado)
            });
        }

        public ActionResult AutocompleteByCliente(string term)
        {
            var olstClienteModel = new List<ClienteModel>();
            try
            {
                List<BECliente> olstCliente;
                using (var sv = new ClienteServiceClient())
                {
                    olstCliente = sv.SelectByNombre(userData.PaisID, userData.ConsultoraID, term).ToList();
                }

                foreach (var item in olstCliente)
                {
                    olstClienteModel.Add(new ClienteModel()
                    {
                        ClienteID = item.ClienteID,
                        Nombre = item.Nombre,
                        TieneTelefono = item.TieneTelefono,
                        CodigoCliente = item.CodigoCliente,
                        eMail = item.eMail,
                        Telefono = item.Telefono,
                        Celular = item.Celular
                    });
                }

                if (olstClienteModel.Count == 0)
                {
                    olstClienteModel.Add(new ClienteModel() { ClienteID = -1, Nombre = "Tu cliente no está registrado. Haz click aquí para ingresarlo." });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstClienteModel.Add(new ClienteModel() { ClienteID = 0, Nombre = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstClienteModel, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AutocompleteByClienteListado(string term)
        {
            var olstClienteModel = new List<ClienteModel>();
            try
            {
                List<BECliente> olstCliente;
                using (var sv = new ClienteServiceClient())
                {
                    olstCliente = sv.SelectByNombre(userData.PaisID, userData.ConsultoraID, term).ToList();
                }

                foreach (var item in olstCliente)
                {
                    olstClienteModel.Add(new ClienteModel()
                    {
                        ClienteID = item.ClienteID,
                        Nombre = item.Nombre,
                        TieneTelefono = item.TieneTelefono,
                        CodigoCliente = item.CodigoCliente,
                        eMail = item.eMail,
                        Telefono = item.Telefono,
                        Celular = item.Celular
                    });
                }

                if (olstClienteModel.Count == 0)
                {
                    olstClienteModel.Add(new ClienteModel() { ClienteID = 0, Nombre = "Tu cliente no está registrado." });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstClienteModel.Add(new ClienteModel() { ClienteID = 0, Nombre = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstClienteModel, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Productos Faltantes

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult GetProductoFaltante(string cuv, string descripcion, string categoria, string revista)
        {
            try
            {
                var productosFaltantes = _productoFaltanteProvider.GetProductosFaltantes(userData, cuv, descripcion, categoria, revista);
                ProductoFaltanteModel model = new ProductoFaltanteModel { Detalle = productosFaltantes };
                return Json(new { result = true, data = model }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { result = false, data = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetFiltrosProductoFaltante()
        {
            try
            {
                BECategoria[] beCategoria;
                BECatalogoRevista_ODS[] beCatalogoRevista_ODS;

                using (var sv = new SACServiceClient())
                {
                    beCategoria = sv.SelectCategoria(userData.PaisID);
                    beCatalogoRevista_ODS = sv.SelectCatalogoRevista_Filtro(userData.PaisID);
                }
                return Json(new
                {
                    result = true,
                    data = beCategoria,
                    data1 = beCatalogoRevista_ODS
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { result = false, data = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        #region Producto Sugerido
        public JsonResult InsertarDemandaTotalReemplazoSugerido(AdministrarProductoSugeridoModel model)
        {
            try
            {
                var entidad = Mapper.Map<AdministrarProductoSugeridoModel, BEProductoSugerido>(model);
                entidad.ConsultoraID = Convert.ToInt32(userData.ConsultoraID);
                entidad.CampaniaID = userData.CampaniaID;

                using (var svc = new PedidoServiceClient())
                    svc.InsDemandaTotalReemplazoSugerido(userData.PaisID, entidad);
                return Json(new
                {
                    success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        #region Clientes

        [HttpPost]
        public JsonResult RegistrarCliente(PedidoDetalleModel model)
        {
            try
            {
                var entidad = Mapper.Map<PedidoDetalleModel, BECliente>(model);
                string clienteId;
                using (var sv = new ClienteServiceClient())
                {
                    var vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);

                    if (vValidation == 0)
                    {
                        entidad.PaisID = userData.PaisID;
                        entidad.ConsultoraID = userData.ConsultoraID;
                        entidad.Activo = true;
                        clienteId = sv.InsertById(entidad).ToString();
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "El nombre del cliente ya se encuentra registrado, por favor verifique.",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }
                return Json(new
                {
                    success = true,
                    message = "Cliente registrado satisfactoriamente.",
                    extra = clienteId
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult EjecutarServicioPROL(bool enviarCorreo = false)
        {
            try
            {
                ActualizarEsDiaPROLyMostrarBotonValidarPedido(userData);
                var input = Mapper.Map<BEInputReservaProl>(userData);
                input.EnviarCorreo = enviarCorreo;
                input.EsOpt = EsOpt();

                BEResultadoReservaProl resultado;
                using (var sv = new PedidoServiceClient())
                {
                    resultado = sv.EjecutarReservaProl(input);
                }
                var listObservacionModel = Mapper.Map<List<ObservacionModel>>(resultado.ListPedidoObservacion.ToList());

                SessionManager.SetObservacionesProl(null);
                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);
                if (resultado.RefreshPedido)
                {
                    SessionManager.SetMontosProl(
                        new List<ObjMontosProl>
                        {
                            new ObjMontosProl
                            {
                                AhorroCatalogo = resultado.MontoAhorroCatalogo.ToString(),
                                AhorroRevista = resultado.MontoAhorroRevista.ToString(),
                                MontoTotalDescuento = resultado.MontoDescuento.ToString(),
                                MontoEscala = resultado.MontoEscala.ToString()
                            }
                        }
                    );
                }
                if (resultado.ResultadoReservaEnum != Enumeradores.ResultadoReserva.ReservaNoDisponible)
                {
                    if (resultado.Reserva) CambioBannerGPR();
                    SessionManager.SetObservacionesProl(listObservacionModel);
                    if (resultado.RefreshPedido) SessionManager.SetPedidoWeb(null);
                }
                SessionManager.SetUserData(userData);

                var listPedidoWebDetalle = ObtenerPedidoWebDetalle();
                var model = new PedidoSb2Model
                {
                    ListaObservacionesProl = listObservacionModel,
                    ObservacionRestrictiva = resultado.Restrictivas,
                    ErrorProl = resultado.Error,
                    AvisoProl = resultado.Aviso,
                    Reserva = resultado.Reserva,
                    ZonaValida = userData.ZonaValida,
                    ValidacionInteractiva = userData.ValidacionInteractiva,
                    MensajeValidacionInteractiva = userData.MensajeValidacionInteractiva,
                    MontoAhorroCatalogo = resultado.MontoAhorroCatalogo,
                    MontoAhorroRevista = resultado.MontoAhorroRevista,
                    MontoDescuento = resultado.MontoDescuento,
                    MontoEscala = resultado.MontoEscala,
                    Total = listPedidoWebDetalle.Sum(d => d.ImporteTotal),
                    EsDiaProl = userData.DiaPROL,
                    CodigoIso = userData.CodigoISO,
                    CodigoMensajeProl = resultado.CodigoMensaje
                };
                model.TotalConDescuento = model.Total - model.MontoDescuento;
                SetMensajesBotonesProl(model);

                var listPermiteOfertaFinal = new List<Enumeradores.ResultadoReserva> {
                    Enumeradores.ResultadoReserva.Reservado,
                    Enumeradores.ResultadoReserva.ReservadoObservaciones,
                    Enumeradores.ResultadoReserva.NoReservadoMontoMinimo
                };


                var mensajeCondicional = resultado.ListaMensajeCondicional != null && resultado.ListaMensajeCondicional.Any() ? resultado.ListaMensajeCondicional[0].MensajeRxP : null;
                return Json(new
                {
                    success = true,
                    data = model,
                    mensajeAnalytics = ObtenerMensajePROLAnalytics(listObservacionModel),
                    pedidoDetalle = from item in listPedidoWebDetalle
                                    select new
                                    {
                                        name = item.DescripcionProd,
                                        id = item.CUV,
                                        price = item.PrecioUnidad,
                                        brand = item.DescripcionLarga,
                                        variant = !string.IsNullOrEmpty(item.DescripcionOferta) ? item.DescripcionOferta.Replace("]", "").Replace("[", "").Trim() : "",
                                        quantity = item.Cantidad
                                    },
                    flagCorreo = resultado.EnviarCorreo ? "1" : "",
                    permiteOfertaFinal = listPermiteOfertaFinal.Contains(resultado.ResultadoReservaEnum),
                    mensajeCondicional,
                    UltimoDiaFacturacion = (userData.FechaFacturacion == Util.GetDiaActual(userData.ZonaHoraria))
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    mensajeAnalytics = "",
                    flagCorreo = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public async Task<JsonResult> EnviarCorreoPedidoReservado()
        {
            try
            {
                var input = Mapper.Map<BEInputReservaProl>(userData);
                input.EsOpt = EsOpt();

                bool envioCorreo;
                using (var sv = new PedidoServiceClient())
                {
                    envioCorreo = await sv.EnviarCorreoReservaProlAsync(input);
                }
                if (envioCorreo)
                    return SuccessJson("Se envio el correo a la consultora.", true);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return ErrorJson("Ocurrió un problema al tratar de enviar el correo a la consultora, intente nuevamente.", true);
        }

        private void SetMensajesBotonesProl(PedidoSb2Model model)
        {
            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month);
            var horaCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            var diaActual = DateTime.Today.Add(horaCierrePortal);

            if (!userData.DiaPROL)
            {
                model.Prol = "GUARDAR TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                if (userData.CodigoISO == Constantes.CodigosISOPais.Bolivia) model.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                else model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
            }
            else
            {
                model.Prol = "RESERVA TU PEDIDO";
                model.ProlTooltip = "Haz click aqui para reservar tu pedido";
                if (diaActual <= userData.FechaInicioCampania) model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                else if (userData.CodigoISO == Constantes.CodigosISOPais.Bolivia) model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                else model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
            }
        }

        private string ObtenerMensajePROLAnalytics(List<ObservacionModel> lista)
        {
            if (lista == null || lista.Count == 0) return "00_Tu pedido se guardó con éxito";

            foreach (var item in lista)
            {
                if (!Regex.IsMatch(Util.SubStr(item.CUV, 0), @"^\d+$")) return item.Caso + "_" + item.Descripcion;
            }
            return "01_Tu pedido tiene observaciones, por favor revísalo";
        }

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult ActualizarMasivo(List<PedidoActualizaModel> lista)
        {
            var olstPedidos = new List<BEPedidoWebDetalle>();
            try
            {
                foreach (var item in lista)
                {
                    var obePedidoWebDetalle = new BEPedidoWebDetalle
                    {
                        PaisID = userData.PaisID,
                        CampaniaID = userData.CampaniaID,
                        PedidoID = userData.PedidoID,
                        PedidoDetalleID = item.PedidoDetalleID,
                        Cantidad = Convert.ToInt32(item.Cantidad),
                        PrecioUnidad = item.PrecioUnidad,
                        ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : item.ClienteID
                    };
                    obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;
                    olstPedidos.Add(obePedidoWebDetalle);
                }

                int clientes;
                decimal importe;
                CalcularMasivo(ObtenerPedidoWebDetalle(), olstPedidos, out clientes, out importe);
                olstPedidos[0].Clientes = clientes;
                olstPedidos[0].ImporteTotalPedido = importe;

                short result;
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.UpdPedidoWebDetalleMasivo(olstPedidos.ToArray());
                }

                var message = result == 0 ? "Hubo un problema al intentar actualizar los registros. Por favor inténtelo nuevamente." : "Los registros han sido actualizados de manera exitosa.";

                return Json(new
                {
                    success = true,
                    message = message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un problema al tratar de Actualiza los registros, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al tratar de Actualiza los registros, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private void CambioBannerGPR()
        {
            if (userData.IndicadorGPRSB == 2)
            {
                userData.MostrarBannerRechazo = userData.RechazadoXdeuda;
                userData.CerrarRechazado = (!userData.RechazadoXdeuda).ToInt();
            }
        }

        #region Campaña y Zona No Configurada

        public ActionResult CampaniaZonaNoConfigurada()
        {
            ViewBag.MensajeCampaniaZona = userData.CampaniaID == 0 ? "Campaña" : "Zona";
            ViewBag.CodigoIso = userData.CodigoISO;

            var urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
            var banner01 = WebConfigurationManager.AppSettings["banner_01"];
            var banner02 = WebConfigurationManager.AppSettings["banner_02"];
            var banner03 = WebConfigurationManager.AppSettings["banner_03"];

            ViewBag.UrlBanner01 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner01);
            ViewBag.UrlBanner02 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner02);
            ViewBag.UrlBanner03 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner03);

            return View();
        }

        #endregion

        #region Pedido Validado

        public ActionResult PedidoValidado()
        {
            BEConfiguracionCampania obeConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                obeConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID) ?? new BEConfiguracionCampania();
            }

            if (obeConfiguracionCampania.CampaniaID > userData.CampaniaID)
            {
                return RedirectToAction("Index");
            }

            List<BEPedidoWebDetalle> lstPedidoWebDetalle = _pedidoWebProvider.ObtenerPedidoWebSetDetalleAgrupado();

            var model = new PedidoDetalleModel
            {
                Simbolo = userData.Simbolo,
                ListaDetalle = lstPedidoWebDetalle,
                eMail = userData.EMail
            };

            ViewBag.Total_Minimo = model.Total_Minimo;
            ViewBag.CodigoISOPais = userData.CodigoISO;

            ViewBag.GananciaEstimada = Util.DecimalToStringFormat(0, userData.CodigoISO);
            ViewBag.PedidoProductoMovil = 0;
            if (lstPedidoWebDetalle.Count > 0)
            {
                ViewBag.PedidoProductoMovil = lstPedidoWebDetalle
                    .Any(p => p.TipoPedido.ToUpper().Trim() == "PNV")
                    .ToInt();

                if (userData.PedidoID == 0)
                {
                    userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                    SessionManager.SetUserData(userData);
                }
            }

            #region kitNueva

            List<BEKitNueva> kitNueva;
            int esColaborador;
            using (var sv = new UsuarioServiceClient())
            {
                kitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora).ToList();
                esColaborador = sv.GetValidarColaboradorZona(userData.PaisID, userData.CodigoZona);
            }
            var esKitNueva = 0;
            decimal montoKitNueva = 0;
            if (kitNueva[0].Estado == 1 && kitNueva[0].EstadoProceso == 1 && esColaborador == 0)
            {
                esKitNueva = 1;
                montoKitNueva = userData.MontoMinimo - kitNueva[0].Monto;
            }
            ViewBag.MontoKitNueva = Util.DecimalToStringFormat(montoKitNueva, userData.CodigoISO);
            ViewBag.EsKitNueva = esKitNueva;
            #endregion

            #region mensaje monto logro para la meta

            var totalPedido = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
            var totalMinimoPedido = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.Total_Minimo = Util.DecimalToStringFormat(totalMinimoPedido, userData.CodigoISO);

            var bePedidoWebByCampania = ObtenerPedidoWeb();
            var subTotal = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
            decimal descuento = 0;
            var pedidoConDescuentoCuv = userData.EstadoSimplificacionCUV && lstPedidoWebDetalle.Any(p => p.IndicadorOfertaCUV);
            if (pedidoConDescuentoCuv) descuento = -bePedidoWebByCampania.DescuentoProl;
            var total = subTotal + descuento;
            model.Total = Util.DecimalToStringFormat(total, userData.CodigoISO);

            ViewBag.Descuento = Util.DecimalToStringFormat(descuento, userData.CodigoISO);
            ViewBag.SubTotal = model.Total;
            ViewBag.GananciaEstimada = Util.DecimalToStringFormat(bePedidoWebByCampania.MontoAhorroCatalogo + bePedidoWebByCampania.MontoAhorroRevista, userData.CodigoISO);

            decimal montoLogro;
            var montoMaximoStr = Util.ValidaMontoMaximo(userData.MontoMaximo, userData.CodigoISO);
            if (!string.IsNullOrEmpty(montoMaximoStr) || subTotal < userData.MontoMinimo) montoLogro = total;
            else if (userData.MontoMinimo > bePedidoWebByCampania.MontoEscala) montoLogro = userData.MontoMinimo;
            else montoLogro = bePedidoWebByCampania.MontoEscala;

            BEFactorGanancia beFactorGanancia;
            using (var sv = new SACServiceClient())
            {
                beFactorGanancia = sv.GetFactorGananciaSiguienteEscala(totalPedido, userData.PaisID);
            }
            ViewBag.EscalaDescuento = 0;
            ViewBag.MontoEscalaDescuento = Util.DecimalToStringFormat(0, userData.CodigoISO);
            ViewBag.PorcentajeEscala = Util.DecimalToStringFormat(0, userData.CodigoISO);
            if (beFactorGanancia != null && esColaborador == 0 && beFactorGanancia.RangoMinimo <= userData.MontoMaximo)
            {
                ViewBag.EscalaDescuento = 1;
                ViewBag.PorcentajeEscala = Util.DecimalToStringFormat(beFactorGanancia.Porcentaje, userData.CodigoISO);
                ViewBag.MontoEscalaDescuento = Util.DecimalToStringFormat(beFactorGanancia.RangoMinimo - montoLogro, userData.CodigoISO);
            }
            #endregion

            var horaCierre = userData.EsZonaDemAnti;
            var sp = horaCierre == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            ViewBag.HoraCierre = Util.FormatearHora(sp);
            model.TotalSinDsctoFormato = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO);
            model.TotalConDsctoFormato = Util.DecimalToStringFormat(totalPedido - bePedidoWebByCampania.DescuentoProl, userData.CodigoISO);

            ViewBag.EstadoSimplificacionCUV = userData.EstadoSimplificacionCUV;
            ViewBag.ZonaNuevoPROL = true;
            model.ModificacionPedidoProl = 0;

            model.PaisID = userData.PaisID;
            var pedidoWeb = ObtenerPedidoWeb();
            ViewBag.MontoAhorroCatalogo = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroCatalogo, userData.CodigoISO);
            ViewBag.MontoAhorroRevista = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroRevista, userData.CodigoISO);
            ViewBag.MontoDescuento = Util.DecimalToStringFormat(pedidoWeb.DescuentoProl, userData.CodigoISO);

            var horaCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            var diaActual = DateTime.Today.Add(horaCierrePortal);
            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + Util.NombreMes(userData.FechaInicioCampania.Month);

            if (!userData.DiaPROL)
            {
                ViewBag.ProlTooltip = "Es importante que guardes tu pedido";
                ViewBag.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);

                if (userData.CodigoISO == Constantes.CodigosISOPais.Bolivia)
                {
                    ViewBag.ProlTooltip = "Es importante que guardes tu pedido";
                    ViewBag.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                }
            }
            else // Periodo de facturacion
            {
                ViewBag.ProlTooltip = "Modifica tu pedido sin perder lo que ya reservaste.";

                if (diaActual <= userData.FechaInicioCampania)
                {
                    ViewBag.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                }
                else
                {
                    ViewBag.ProlTooltip += string.Format("|Hazlo antes de las {0} para facturarlo.", diaActual.ToString("hh:mm tt"));
                }
            }

            #region Banners

            var urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
            var urlProdDesc = WebConfigurationManager.AppSettings["ProdDesc"] + "/" + userData.CodigoISO;
            var banner01 = WebConfigurationManager.AppSettings["banner_01"];
            var banner02 = WebConfigurationManager.AppSettings["banner_02"];
            var banner03 = WebConfigurationManager.AppSettings["banner_03"];

            ViewBag.UrlBanner01 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner01);
            ViewBag.UrlBanner02 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner02);
            ViewBag.UrlBanner03 = ConfigCdn.GetUrlFileCdn(urlCarpeta, banner03);

            model.accionBanner_01 = ConfigCdn.GetUrlFileCdn(urlProdDesc, userData.CampaniaID + ".pdf");

            #endregion

            #region GPR

            userData.ValidacionAbierta = obeConfiguracionCampania.ValidacionAbierta;

            #endregion

            ViewBag.UrlFranjaNegra = _eventoFestivoProvider.GetUrlFranjaNegra();

            return View(model);
        }

        [HttpPost]
        public JsonResult CargarDetallePedidoValidado(string sidx, string sord, int page, int rows)
        {
            try
            {
                List<BEPedidoWebDetalle> lstPedidoWebDetalle = _pedidoWebProvider.ObtenerPedidoWebSetDetalleAgrupado();
                lstPedidoWebDetalle.ForEach(x =>
                {
                    x.DescripcionOferta = string.Empty;
                });

                var totalPedido = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
                var totalMinimoPedido = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);

                lstPedidoWebDetalle.Update(p => p.DescripcionCortadaProd = Util.SubStrCortarNombre(p.DescripcionProd, 73));

                var pedidoModelo = new PedidoDetalleModel
                {
                    eMail = userData.EMail,
                    Simbolo = userData.Simbolo,
                    Total = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO),
                    Total_Minimo = Util.DecimalToStringFormat(totalMinimoPedido, userData.CodigoISO)
                };


                var pedidoWeb = ObtenerPedidoWeb();

                pedidoModelo.ListaDetalle = lstPedidoWebDetalle;

                var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoWebDetalle>, List<PedidoWebDetalleModel>>(pedidoModelo.ListaDetalle);
                pedidoWebDetalleModel.ForEach(p => p.CodigoIso = userData.CodigoISO);
                pedidoModelo.ListaDetalleFormato = pedidoWebDetalleModel;

                if (pedidoModelo.ListaDetalleFormato.Any())
                {
                    BEGrid grid = new BEGrid(sidx, sord, page, rows);
                    var pag = Util.PaginadorGenerico(grid, pedidoModelo.ListaDetalleFormato);

                    pedidoModelo.ListaDetalleFormato = pedidoModelo.ListaDetalleFormato.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();
                    pedidoModelo.ListaDetalleFormato.Update(detalle => { if (string.IsNullOrEmpty(detalle.Nombre)) detalle.Nombre = userData.NombreConsultora; });

                    pedidoModelo.Registros = grid.PageSize.ToString();
                    pedidoModelo.RegistrosTotal = pag.RecordCount.ToString();
                    pedidoModelo.Pagina = pag.CurrentPage.ToString();
                    pedidoModelo.PaginaDe = pag.PageCount.ToString();
                }
                else
                {
                    pedidoModelo.RegistrosTotal = "0";
                    pedidoModelo.Pagina = "0";
                    pedidoModelo.PaginaDe = "0";
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = pedidoModelo,
                    dataBarra = GetDataBarra(true, true)
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = "",
                    dataBarra = new BarraConsultoraModel()
                });
            }

        }

        [AllowAnonymous]
        public ActionResult PedidoValidadoPdf(string parametros)
        {
            List<BEPedidoWebDetalle> olstPedidoWebDetalle;
            var param = Util.DesencriptarQueryString(parametros);
            var lista = param.Split(';');
            var paisId = lista[0];
            var campaniaId = lista[1];
            var consultoraId = lista[2];

            using (var sv = new PedidoServiceClient())
            {
                olstPedidoWebDetalle = sv.SelectByPedidoValidado(Convert.ToInt32(paisId), Convert.ToInt32(campaniaId), Convert.ToInt64(consultoraId), lista[4]).ToList();
            }

            var pedidoModelo = new PedidoDetalleModel
            {
                ListaDetalle = PedidoJerarquico(olstPedidoWebDetalle),
                Simbolo = lista[3],
                Total = string.Format("{0:N2}", olstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal)),
                Total_Minimo = string.Format("{0:N2}", olstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal))
            };
            ViewBag.Simbolo = pedidoModelo.Simbolo;
            ViewBag.Total = pedidoModelo.Total;
            ViewBag.Total_Minimo = pedidoModelo.Total_Minimo;
            ViewBag.Usuario = lista[4];
            ViewBag.BanderaImagen = lista[5];
            ViewBag.NombrePais = lista[6];
            return View(pedidoModelo);
        }

        [AllowAnonymous]
        public ActionResult PedidoValidadoExportarPdf()
        {
            var lista = new string[7];
            lista[0] = userData.PaisID.ToString();
            lista[1] = userData.CampaniaID.ToString();
            lista[2] = userData.ConsultoraID.ToString();
            lista[3] = userData.Simbolo;
            lista[4] = userData.NombreConsultora;
            lista[5] = userData.BanderaImagen;
            lista[6] = userData.NombrePais;
            Util.ExportToPdfWebPages(this, "PedidoReservado.pdf", "PedidoReservadoPdf", Util.EncriptarQueryString(lista));
            return new EmptyResult();
        }

        public JsonResult PedidoValidadoEnviarCorreo(string correo)
        {
            try
            {
                decimal total = 0;
                List<BEPedidoWebDetalle> olstPedidoWebDetalle;
                using (var sv = new PedidoServiceClient())
                {
                    olstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                }
                olstPedidoWebDetalle = PedidoJerarquico(olstPedidoWebDetalle);
                #region cotnenido del correo

                var txtBuil = new StringBuilder();

                txtBuil.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
                txtBuil.Append("<div style='font-size:12px;'>Hola,</div> <br />");
                txtBuil.Append("<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + userData.CampaniaID + "</b> es el siguiente :</div> <br /><br />");
                txtBuil.Append("<table border='1' style='width: 80%;'>");
                txtBuil.Append("<tr style='color: #FFFFFF'>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 126px; background-color: #666699;'>");
                txtBuil.Append("Cod. Venta");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #666699;'>");
                txtBuil.Append("Descripción");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #666699;'>");
                txtBuil.Append("Cantidad");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #666699;'>");
                txtBuil.Append("Precio Unit.");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>");
                txtBuil.Append("Precio Total");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>");
                txtBuil.Append("Cliente");
                txtBuil.Append("</td>");
                txtBuil.Append("</tr>");

                for (var i = 0; i < olstPedidoWebDetalle.Count; i++)
                {
                    if (olstPedidoWebDetalle[i].PedidoDetalleIDPadre == 0)
                    {
                        txtBuil.Append("<tr>");
                        txtBuil.Append("<td style='font-size:11px; width: 126px; text-align: center;'>");
                        txtBuil.Append("" + olstPedidoWebDetalle[i].CUV + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append(" <td style='font-size:11px; width: 347px;'>");
                        txtBuil.Append("" + olstPedidoWebDetalle[i].DescripcionProd + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; width: 124px; text-align: center;'>");
                        txtBuil.Append("" + olstPedidoWebDetalle[i].Cantidad.ToString() + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; width: 182px; text-align: center;'>");
                        txtBuil.Append(userData.Simbolo + Util.DecimalToStringFormat(olstPedidoWebDetalle[i].PrecioUnidad, userData.CodigoISO));
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                        txtBuil.Append(userData.Simbolo + Util.DecimalToStringFormat(olstPedidoWebDetalle[i].ImporteTotal, userData.CodigoISO));
                        txtBuil.Append("</td>");
                        txtBuil.Append("<td style='font-size:11px; width: 165px; text-align: center;'>");
                        txtBuil.Append(string.IsNullOrEmpty(olstPedidoWebDetalle[i].Nombre) ? userData.NombreConsultora : olstPedidoWebDetalle[i].Nombre);
                        txtBuil.Append("</td>");
                        txtBuil.Append("</tr>");
                        total += olstPedidoWebDetalle[i].ImporteTotal;
                    }
                    else
                    {
                        txtBuil.Append("<tr>");
                        txtBuil.Append("<td></td>");
                        txtBuil.Append("<td style='font-size:11px; width: 126px; text-align: center;'>");
                        txtBuil.Append("" + olstPedidoWebDetalle[i].CUV + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append(" <td colspan='4' style='font-size:11px;'>");
                        txtBuil.Append("" + olstPedidoWebDetalle[i].DescripcionProd + "");
                        txtBuil.Append("</td>");
                        txtBuil.Append("</tr>");
                    }
                }

                txtBuil.Append("<tr>");
                txtBuil.Append("<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>");
                txtBuil.Append("Total :");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='font-size:11px; text-align: center; font-weight: bold'>");
                txtBuil.Append("" + userData.Simbolo + Util.DecimalToStringFormat(total, userData.CodigoISO));
                txtBuil.Append("</td>");
                txtBuil.Append("<td></td>");
                txtBuil.Append("</tr>");
                txtBuil.Append("</table>");
                txtBuil.Append("<br /><br />");
                txtBuil.Append("<div style='font-size:12px;'>Saludos,</div>");
                txtBuil.Append("<br /><br />");
                txtBuil.Append("<table border='0'>");
                txtBuil.Append("<tr>");
                txtBuil.Append("<td>");
                txtBuil.Append("<img src='cid:Logo' border='0' />");
                txtBuil.Append("</td>");
                txtBuil.Append("<td style='text-align: center; font-size:12px;'>");
                txtBuil.Append("<strong>" + userData.NombreConsultora + "</strong> <br />");
                txtBuil.Append("<strong>Consultora</strong>");
                txtBuil.Append("</td>");
                txtBuil.Append("</tr>");
                txtBuil.Append("</table>");

                string mailBody = txtBuil.ToString();

                #endregion

                Util.EnviarMail("no-responder@somosbelcorp.com", correo, "(" + userData.CodigoISO + ") Pedido Web", mailBody, true, userData.NombreConsultora);
                return Json(new
                {
                    success = true,
                    message = "El correo se envió de forma correcta a la cuenta: " + correo,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema al enviar el correo electrónico.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult PedidoValidadoDeshacerReserva(string Tipo)
        {
            try
            {
                var respuesta = PedidoValidadoDeshacer(Tipo);
                return Json(new
                {
                    success = respuesta == "",
                    message = respuesta == "" ? "OK" : respuesta,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al Deshacer el Pedido.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al Deshacer el Pedido.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private string PedidoValidadoDeshacer(string tipo)
        {
            string mensaje;
            var usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
            using (var sv = new PedidoServiceClient())
            {
                mensaje = sv.DeshacerPedidoValidado(usuario, tipo);
            }
            if (!string.IsNullOrEmpty(mensaje)) return mensaje;

            if (userData.IndicadorGPRSB != 2 || string.IsNullOrEmpty(userData.GPRBannerMensaje)) return "";
            BEConfiguracionCampania bEConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                bEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }
            if (!bEConfiguracionCampania.ValidacionAbierta) return "";

            userData.MostrarBannerRechazo = true;
            userData.CerrarRechazado = 0;
            SessionManager.SetUserData(userData);
            return "";
        }

        #endregion

        private List<BEPedidoWebDetalle> PedidoJerarquico(List<BEPedidoWebDetalle> listadoPedidos)
        {
            var result = new List<BEPedidoWebDetalle>();
            var padres = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == 0).ToList();
            foreach (var item in padres)
            {
                result.Add(item);
                var items = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == item.PedidoDetalleID).ToList();
                if (items.Any())
                    result.AddRange(items);
            }

            return result;
        }

        private void CalcularMasivo(List<BEPedidoWebDetalle> pedido, List<BEPedidoWebDetalle> actualizar, out int clientes, out decimal importe)
        {
            var tempPedido = new List<BEPedidoWebDetalle>(pedido);
            var tempActualizar = new List<BEPedidoWebDetalle>(actualizar);

            foreach (var item in tempActualizar)
            {
                tempPedido.Where(p => p.PedidoDetalleID == item.PedidoDetalleID).ToList().ForEach(p =>
                {
                    p.Cantidad = item.Cantidad;
                    p.ImporteTotal = item.ImporteTotal;
                    p.ClienteID = item.ClienteID;
                    p.EstadoItem = (short)0;
                });
            }

            clientes = tempPedido.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
            importe = tempPedido.Sum(p => p.ImporteTotal);
        }

        public ActionResult EnHorarioRestringido()
        {
            if (userData == null)
            {
                return Json(new
                {
                    success = false,
                    message = "Sesión expirada.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }

            try
            {
                var mensaje = string.Empty;
                var estado = false;

                using (var sv = new PedidoServiceClient())
                {
                    var result = sv.ValidacionModificarPedidoSelectiva(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA, false, false, true);
                    if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.HorarioRestringido)
                    {
                        mensaje = result.Mensaje;
                        estado = true;
                    }

                    if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Bloqueado)
                    {
                        mensaje = Constantes.TipoPopupAlert.Bloqueado + result.Mensaje;
                        estado = true;
                    }
                }

                return Json(new
                {
                    success = estado,
                    message = mensaje,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = true,
                    message = "Ocurrió un error al calcular el horario restringido",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ReservadoOEnHorarioRestringido(string tipoAccion = null)
        {

            if (userData == null)
            {
                return Json(new
                {
                    success = false,
                    pedidoReservado = false,
                    message = "Sesión expirada.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }

            try
            {
                BEValidacionModificacionPedido result;
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.ValidacionModificarPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA);
                }
                var pedidoReservado = (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado && userData.FechaFinCampania == Util.GetDiaActual(userData.ZonaHoraria));
                var estado = result.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno;
                var mensaje = result.Mensaje;
                if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Bloqueado) mensaje = Constantes.TipoPopupAlert.Bloqueado + result.Mensaje;

                return Json(new
                {
                    success = estado,
                    pedidoReservado = pedidoReservado,
                    message = mensaje,
                    UltimoDiaFacturacion = (userData.FechaFacturacion == Util.GetDiaActual(userData.ZonaHoraria)),
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = true,
                    pedidoReservado = false,
                    message = "Ocurrió un error al validar el horario restringido o si el pedido está reservado",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ObtenerProductosRecomendados(string cuv)
        {
            List<BECrossSellingProducto> lst;

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosRecomendadosByCUVCampaniaPortal(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, cuv).ToList();
            }

            var marca = string.Empty;
            if (lst.Any())
            {
                marca = Util.GetDescripcionMarca(string.IsNullOrEmpty(lst[0].MarcaID) ? 0 : Convert.ToInt32(lst[0].MarcaID));
                lst.Update(x => x.ImagenProducto = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, x.ImagenProducto));

                if (lst.Count > 1)
                {
                    marca = marca + "," + Util.GetDescripcionMarca(string.IsNullOrEmpty(lst[1].MarcaID) ? 0 : Convert.ToInt32(lst[1].MarcaID));
                }
            }

            return Json(new
            {
                lista = lst,
                Simbolo = userData.Simbolo,
                ISO = userData.CodigoISO,
                DescripcionMarca = marca
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarCrossSelling()
        {
            int rslt;

            using (var sv = new PedidoServiceClient())
            {
                rslt = sv.ValidarConfiguracionCrossSelling(userData.PaisID, userData.CampaniaID);
            }

            return Json(new
            {
                Habilitar = rslt,
                DiaPROL = userData.DiaPROL
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ConsultarBannerPedido()
        {
            if (ModelState.IsValid)
            {
                List<BEBannerPedido> lst;
                using (var sv = new SACServiceClient())
                {
                    lst = sv.SelectBannerPedido(userData.PaisID, userData.CampaniaID).ToList();
                }

                if (lst.Count > 0)
                {
                    var carpetaPais = Globals.UrlBanner + "/" + userData.CodigoISO;
                    var carpetaFileConsultoras = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                    lst.Update(x => x.ArchivoPortada = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ArchivoPortada));
                    lst.Update(x => x.Archivo = ConfigCdn.GetUrlFileCdn(carpetaFileConsultoras, x.Archivo));
                }

                return Json(new
                {
                    success = true,
                    data = lst
                });
            }

            return Json(new
            {
                success = true,
                data = (List<BEBannerPedido>)null
            });
        }

        public int UpdEstadoPacksOfertasNueva()
        {
            int result;
            try
            {
                int num;
                using (var pedidoServiceClient = new PedidoServiceClient())
                {
                    num = pedidoServiceClient.UpdEstadoPacksOfertasNueva(userData.PaisID, Convert.ToInt32(userData.ConsultoraID), userData.CodigoConsultora, userData.CampaniaID);
                }
                result = num;
            }
            catch (FaultException faulException)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(faulException, userData.CodigoConsultora, userData.CodigoISO);
                result = 0;
            }
            catch (Exception expException)
            {
                LogManager.LogManager.LogErrorWebServicesBus(expException, userData.CodigoConsultora, userData.CodigoISO);
                result = 0;
            }
            return result;
        }

        [HttpPost]
        public JsonResult ActualizarVisualizacionPopupProRecom()
        {
            if (ModelState.IsValid)
            {
                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdVisualizacionPopupProRecom(Convert.ToInt32(userData.ConsultoraID), userData.CampaniaID, userData.PaisID);
                }
            }
            return Json(new { success = true });
        }

        [HttpPost]
        public JsonResult CargarDetallePedido(string sidx, string sord, int page, int rows, int clienteId, bool mobil = false)
        {
            try
            {
                var listaDetalle = GetPedidoWebDetalle(mobil);

                if (mobil)
                {
                    page = 1;
                    rows = listaDetalle.Count;
                }

                var total = listaDetalle.Sum(p => p.ImporteTotal);

                var model = new PedidoSb2Model
                {
                    CodigoIso = userData.CodigoISO,
                    EstadoSimplificacionCuv = userData.EstadoSimplificacionCUV
                };
                model.ListaCliente = ListarClienteSegunPedido("", listaDetalle);

                listaDetalle = listaDetalle.Where(p => p.ClienteID == clienteId || clienteId == -1).ToList();
                var totalCliente = listaDetalle.Sum(p => p.ImporteTotal);

                var pedidoWebDetalleModel = MapearListaDetalleModel(listaDetalle);
                model.ListaDetalleModel = pedidoWebDetalleModel;
                model.Total = total;
                model.TotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                model.TotalProductos = pedidoWebDetalleModel.Sum(p => Convert.ToInt32(p.Cantidad));

                var bePedidoWebByCampania = ObtenerPedidoWeb();
                model.MontoAhorroCatalogo = bePedidoWebByCampania.MontoAhorroCatalogo;
                model.MontoAhorroRevista = bePedidoWebByCampania.MontoAhorroRevista;
                model.MontoDescuento = bePedidoWebByCampania.DescuentoProl;
                model.TotalConDescuento = total - bePedidoWebByCampania.DescuentoProl;

                ViewBag.GananciaEstimada = Util.DecimalToStringFormat(bePedidoWebByCampania.MontoAhorroCatalogo + bePedidoWebByCampania.MontoAhorroRevista, userData.CodigoISO);

                userData.PedidoID = 0;
                if (model.ListaDetalleModel.Any())
                {
                    userData.PedidoID = model.ListaDetalleModel[0].PedidoID;
                    SessionManager.SetUserData(userData);

                    BEGrid grid = new BEGrid(sidx, sord, page, rows);
                    var pag = Util.PaginadorGenerico(grid, model.ListaDetalleModel);

                    model.ListaDetalleModel = model.ListaDetalleModel.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();

                    model.Registros = grid.PageSize.ToString();
                    model.RegistrosTotal = pag.RecordCount.ToString();
                    model.Pagina = pag.CurrentPage.ToString();
                    model.PaginaDe = pag.PageCount.ToString();
                }
                else
                {
                    model.RegistrosTotal = "0";
                    model.Pagina = "1";
                    model.PaginaDe = "1";
                }

                model.TipoPaginador = Constantes.ClasificadorPedido.PedidoDetalle;
                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.Simbolo = userData.Simbolo;

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = model,
                    dataBarra = GetDataBarra(true, false, true)
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = "",
                    dataBarra = new BarraConsultoraModel()
                });
            }
        }

        private bool AgregarCuvsAutomatico()
        {
            int isInsert;
            var bePedidoWeb = new BEPedidoWeb
            {
                CampaniaID = userData.CampaniaID,
                ConsultoraID = userData.ConsultoraID,
                PaisID = userData.PaisID,
                IPUsuario = userData.IPUsuario,
                CodigoUsuarioCreacion = userData.CodigoUsuario
            };

            using (var sv = new PedidoServiceClient())
            {
                isInsert = sv.GetProductoCUVsAutomaticosToInsert(bePedidoWeb);
            }

            if (isInsert > 0)
            {
                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);

                UpdPedidoWebMontosPROL();

                return true;
            }

            return false;
        }

        private List<PedidoWebDetalleModel> MapearListaDetalleModel(List<BEPedidoWebDetalle> listaDetalle)
        {
            var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoWebDetalle>, List<PedidoWebDetalleModel>>(listaDetalle);

            var pedidoEditable = _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            userData.PaisID,
                            ConsTablaLogica.PasePedido.TablaLogicaId,
                            ConsTablaLogica.PasePedido.CuvEditable,
                            true
                            );

            var configuracionCampania = GetConfiguracionCampania();

            pedidoWebDetalleModel.ForEach(p =>
            {
                p.Simbolo = userData.Simbolo;
                p.CodigoIso = userData.CodigoISO;
                p.DescripcionCortadaProd = Util.SubStrCortarNombre(p.DescripcionProd, 73);
                p.TipoAccion = TipoAccionPedido(p, pedidoEditable);
                p.FlagModificaCantidad = FlagModificaCantidad(p);
                p.FlagModificaCliente = p.FlagModificaCantidad;
                p.FlagVerCuv = FlagVerCuv(p);
                p.LockPremioElectivo = p.EsPremioElectivo && string.IsNullOrEmpty(p.Mensaje);
                p.EsPedidoReservado = EsPedidoReservado(configuracionCampania);
            });

            return pedidoWebDetalleModel;
        }

        private int TipoAccionPedido(PedidoWebDetalleModel producto, bool valorConfi)
        {
            // los valores deben estar en constantes
            // considerar tipo estrategia codigo y origen pedido web
            // caso EsBackOrder

            if (!valorConfi) return 0;

            var modeloOrigenPedido = UtilOrigenPedidoWeb.GetModelo(producto.OrigenPedidoWeb);
            if (modeloOrigenPedido.Palanca == ConsOrigenPedidoWeb.Palanca.ProductoSugerido
                || modeloOrigenPedido.Palanca == ConsOrigenPedidoWeb.Palanca.OfertaFinal
                || (modeloOrigenPedido.Palanca == ConsOrigenPedidoWeb.Palanca.Showroom
                    && modeloOrigenPedido.Seccion == ConsOrigenPedidoWeb.Seccion.SubCampania) 
                )
            {
                return 0;
            }

            //if (
            //    (producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopPedidoProductoSugeridoCarrusel
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobilePedidoProductoSugeridoCarrusel)
            //    || (producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinalCarrusel
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinalFicha
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinalCarrusel
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinalFicha
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.AppConsultoraPedidoOfertaFinalCarrusel
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.AppConsultoraPedidoOfertaFinalFicha)
            //    || (producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.AppConsultoraLandingShowroomShowroomSubCampania
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopLandingShowroomShowroomSubCampania
            //    || producto.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobileLandingShowroomShowroomSubCampania)
            //    || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackNuevas
            //    )
            //    return 0;

            switch (producto.TipoEstrategiaCodigo)
            {
                case Constantes.TipoEstrategiaCodigo.MasGanadoras:
                case Constantes.TipoEstrategiaCodigo.ShowRoom:
                case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                case Constantes.TipoEstrategiaCodigo.OfertaParaTi:
                case Constantes.TipoEstrategiaCodigo.OfertasParaMi:
                case Constantes.TipoEstrategiaCodigo.OfertaDelDia:
                case Constantes.TipoEstrategiaCodigo.HerramientasVenta:
                case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                case Constantes.TipoEstrategiaCodigo.ArmaTuPack:
                    return 1;
                default:
                    return 0;
            }
        }

        private bool FlagModificaCantidad(PedidoWebDetalleModel producto)
        {
            bool flag = true;
            if (producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack
                || producto.EsKitNueva
                || producto.FlagNueva
                || producto.EsPremioElectivo
                || producto.EsKitCaminoBrillante)
            {
                flag = false;
            }
            return flag;
        }

        private bool FlagVerCuv(PedidoWebDetalleModel producto)
        {
            bool flag = true;
            if (producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack || producto.EsKitCaminoBrillante)
            {
                flag = false;
            }
            return flag;
        }

        private List<BEPedidoWebDetalle> GetPedidoWebDetalle(bool isMobile)
        {
            var listaDetalle = ObtenerPedidoWebSetDetalleAgrupado() ?? new List<BEPedidoWebDetalle>();
            if (isMobile && listaDetalle.Count == 0)
            {
                var inserto = AgregarCuvsAutomatico();
                if (inserto) listaDetalle = ObtenerPedidoWebSetDetalleAgrupado() ?? new List<BEPedidoWebDetalle>();
            }
            return listaDetalle;
        }

        #region Parametria Oferta Final

        private List<ServicePedido.BEEscalaDescuento> GetParametriaOfertaFinal(string algoritmo)
        {
            List<ServicePedido.BEEscalaDescuento> listaParametriaOfertaFinal;

            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    listaParametriaOfertaFinal = sv.GetParametriaOfertaFinal(userData.PaisID, algoritmo).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaParametriaOfertaFinal = new List<ServicePedido.BEEscalaDescuento>();
            }

            return listaParametriaOfertaFinal;
        }
        #endregion

        public bool VerificarConsultoraNueva()
        {
            int segmentoId;

            if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
            {
                segmentoId = userData.SegmentoID;
            }
            else
            {
                segmentoId = userData.SegmentoInternoID ?? userData.SegmentoID;
            }

            var resultado = segmentoId == 1;

            return resultado;
        }

        [HttpPost]
        public JsonResult InsertarOfertaFinalLog(string CUV, int cantidad, string tipoOfertaFinal_Log, decimal gap_Log, int tipoRegistro, string desTipoRegistro, bool? MuestraPopup, decimal? MontoInicial)
        {
            try
            {
                using (var svp = new PedidoServiceClient())
                {
                    var entidad = new BEOfertaFinalConsultoraLog
                    {
                        CampaniaID = userData.CampaniaID,
                        CodigoConsultora = userData.CodigoConsultora,
                        CUV = CUV,
                        Cantidad = cantidad,
                        TipoOfertaFinal = tipoOfertaFinal_Log,
                        GAP = gap_Log,
                        TipoRegistro = tipoRegistro,
                        DesTipoRegistro = desTipoRegistro
                    };

                    if (tipoRegistro == 2)
                    {
                        entidad.MuestraPopup = MuestraPopup;
                        entidad.MontoInicial = MontoInicial;
                    }

                    svp.InsLogOfertaFinal(userData.PaisID, entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "El log ha sido registrado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult InsertarOfertaFinalLogBulk(List<OfertaFinalConsultoraLogModel> lista)
        {
            try
            {
                var s = false;
                var m = string.Empty;

                if (lista.Any())
                {
                    var listaOfertaFinalLog = new List<BEOfertaFinalConsultoraLog>();

                    foreach (var item in lista)
                    {
                        var ofertaFinalLog = new BEOfertaFinalConsultoraLog
                        {
                            CampaniaID = userData.CampaniaID,
                            CodigoConsultora = userData.CodigoConsultora,
                            CUV = item.CUV,
                            Cantidad = item.Cantidad,
                            TipoOfertaFinal = item.TipoOfertaFinal,
                            GAP = item.GAP,
                            TipoRegistro = item.TipoRegistro,
                            DesTipoRegistro = item.DesTipoRegistro
                        };
                        listaOfertaFinalLog.Add(ofertaFinalLog);
                    }

                    using (var svc = new PedidoServiceClient())
                    {
                        svc.InsLogOfertaFinalBulk(userData.PaisID, listaOfertaFinalLog.ToArray());
                    }

                    s = true;
                    m = "El log ha sido registrado satisfactoriamente.";
                }

                return Json(new
                {
                    success = s,
                    message = m,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        #region Oferta del dia

        public JsonResult CloseOfertaDelDia()
        {
            try
            {
                userData.CloseOfertaDelDia = true;
                SessionManager.SetUserData(userData);

                return Json(new
                {
                    success = true,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion


        public JsonResult GetQtyPedidoDetalleByCuvODD(string cuv, string tipoEstrategiaID)
        {
            try
            {
                var qty = 0;
                var lstPedidoDetalle = ObtenerPedidoWebDetalle();

                if (lstPedidoDetalle.Any())
                {
                    foreach (var item in lstPedidoDetalle)
                    {
                        if (item.TipoOfertaSisID == int.Parse(tipoEstrategiaID)
                            && item.CUV.Trim().Contains(cuv.Trim()))
                        {
                            qty = item.Cantidad;
                            break;
                        }
                    }
                }

                return Json(new
                {
                    success = true,
                    cantidad = qty
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult CloseBannerPL20()
        {
            try
            {
                userData.CloseBannerPL20 = true;

                SessionManager.SetUserData(userData);

                return Json(new
                {
                    success = true,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult OcultarBannerTop()
        {
            try
            {
                SessionManager.SetOcultarBannerTop(true);

                return Json(new
                {
                    success = true,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult AccederOfertasVALAUTOPROL(string script)
        {
            var area = "";
            try
            {
                area = Request.Browser.IsMobileDevice ? "Mobile" : "";
                if (userData.CampaniaID <= 0)
                {
                    return RedirectToAction("Index", "Login", new { area = area });
                }

                var obj = Util.Decrypt(HttpUtility.UrlDecode(script)) != null ? Util.Decrypt(HttpUtility.UrlDecode(script)) : "";
                var listaParemetros = obj.Split('|');
                var codigoIso = listaParemetros.Length > 0 ? listaParemetros[0] : "";
                var campaniaId = listaParemetros.Length > 1 ? listaParemetros[1] : "";
                var codigoConsultora = listaParemetros.Length > 2 ? listaParemetros[2] : "";
                var cuv = listaParemetros.Length > 3 ? listaParemetros[3] : "";

                TempData["CUVOfertaProl"] = Util.Trim(cuv);

                if (codigoIso != userData.CodigoISO || campaniaId != userData.CampaniaID.ToString() || codigoConsultora != userData.CodigoConsultora)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = area });
                }

                var listaDetallePedido = ObtenerPedidoWebDetalle();
                if (listaDetallePedido.Count == 0)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = area });
                }

                BEConfiguracionCampania obeConfiguracionCampania;
                using (var sv = new PedidoServiceClient())
                {
                    obeConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }

                if (obeConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                            !obeConfiguracionCampania.ModificaPedidoReservado &&
                            !obeConfiguracionCampania.ValidacionAbierta)
                {
                    var mensaje = PedidoValidadoDeshacer("PV");
                    if (mensaje != "")
                    {
                        return RedirectToAction("Index", "Bienvenida", new { area = area });
                    }
                }

                return RedirectToAction(area == "" ? "Index" : "Detalle", "Pedido", new { area = area });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Index", "Bienvenida", new { area = area });
            }
        }

        public JsonResult GuardarIndicadorPedidoAutentico(string accion, string codigo)
        {
            try
            {
                switch (accion)
                {
                    case "2":
                        using (var svc = new PedidoServiceClient())
                        {
                            codigo = svc.GetTokenIndicadorPedidoAutentico(userData.PaisID, userData.CodigoISO, userData.CodigorRegion, userData.CodigoZona);
                        }
                        if (!string.IsNullOrEmpty(codigo))
                        {
                            SessionManager.SetTokenPedidoAutentico(codigo);
                        }
                        break;
                    case "3":
                        if (!string.IsNullOrEmpty(codigo))
                        {
                            SessionManager.SetTokenPedidoAutentico(codigo);
                        }
                        break;
                }

                return Json(new { success = true, message = codigo });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                });
            }
        }

        [HttpPost]
        public JsonResult UpdatePostulanteMensaje(string tipo)
        {
            try
            {
                if (!string.IsNullOrEmpty(tipo))
                {
                    var tipoMensaje = Convert.ToInt32(tipo);

                    using (var sv = new UsuarioServiceClient())
                    {
                        sv.UpdatePosutlanteMensajes(userData.PaisID, userData.CodigoUsuario, tipoMensaje);
                    }

                    switch (tipoMensaje)
                    {
                        case 1:
                            userData.MensajePedidoDesktop = 1;
                            break;
                        case 2:
                            userData.MensajePedidoMobile = 1;
                            break;
                    }

                    SessionManager.SetUserData(userData);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return Json(new
            {
                result = "OK"
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetRegaloProgramaNuevas()
        {
            try
            {
                if (!userData.ConfigPremioProgNuevas.MostrarRegaloOF) return ErrorJson("OK", true);

                var listPremioElec = userData.ConfigPremioProgNuevas.ListPremioElec;
                PremioProgNuevasModel premio;

                if (listPremioElec != null && listPremioElec.Any())
                {
                    var listDetalle = ObtenerPedidoWebDetalle();
                    premio = listPremioElec.FirstOrDefault(pe => listDetalle.Any(d => pe.Cuv == d.CUV));
                    if (premio == null) premio = listPremioElec.First();
                }
                else premio = userData.ConfigPremioProgNuevas.PremioAuto;

                var model = _programaNuevasProvider.GetConsultoraRegaloProgNuevasOF(premio);
                return Json(new
                {
                    success = model != null,
                    message = "OK",
                    data = model,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al procesar la solicitud",
                    data = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #region Nuevo AgregarProducto

        private string ValidarStockEstrategiaMensaje(string cuv, int cantidad, int tipoOferta)
        {
            var mensaje = "";
            try
            {
                var entidad = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    Cantidad = cantidad,
                    CUV2 = cuv,
                    CampaniaID = userData.CampaniaID,
                    ConsultoraID = userData.ConsultoraID.ToString(),
                    FlagCantidad = tipoOferta
                };

                using (var svc = new PedidoServiceClient())
                {
                    mensaje = svc.ValidarStockEstrategia(entidad);
                }
                mensaje = Util.Trim(mensaje);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            mensaje = mensaje == "OK" ? "" : mensaje;
            return mensaje;
        }

        private string ValidarStockArmaTuPackMensaje(string cuv, int cantidad)
        {
            string mensaje = "";
            try
            {
                bool estaEnLimite;
                var cantidadActual = ObtenerPedidoWebDetalle().Where(d => d.CUV == cuv).Sum(d => d.Cantidad);

                using (var sv = new ODSServiceClient())
                {
                    estaEnLimite = sv.CuvArmaTuPackEstaEnLimite(userData.PaisID, userData.CampaniaID, userData.CodigoZona, cuv, cantidad, cantidadActual);
                }
                if (estaEnLimite) mensaje = string.Format(Constantes.MensajesError.ExcedioLimiteVenta, 1);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return mensaje;
        }

        private string ValidarStockLimiteVenta(string cuv, int cantidad, string descripcion = "")
        {
            string mensaje = "";

            try
            {
                BERespValidarLimiteVenta respValidar;
                var cantidadActual = ObtenerPedidoWebDetalle().Where(d => d.CUV == cuv).Sum(d => d.Cantidad);

                using (var sv = new ODSServiceClient())
                {
                    respValidar = sv.CuvTieneLimiteVenta(userData.PaisID, userData.CampaniaID, userData.CodigorRegion, userData.CodigoZona, cuv, cantidad, cantidadActual);
                }
                if (respValidar.TieneLimite) mensaje = string.Format(Constantes.MensajesError.StockLimiteVenta, cuv, descripcion, respValidar.UnidadesMaximas);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return mensaje;
        }

        #endregion

        public JsonResult CargarPremiosElectivos()
        {
            var premios = _programaNuevasProvider.GetListPremioElectivo();

            var details = ObtenerPedidoWebSetDetalleAgrupado(true) ?? new List<BEPedidoWebDetalle>();

            var selected = premios.FirstOrDefault(c => details.Any(d => c.CUV2 == d.CUV));

            return Json(new
            {
                lista = premios,
                selected
            }, JsonRequestBehavior.AllowGet);
        }

        private Enumeradores.ValidacionProgramaNuevas ValidarProgramaNuevas(string cuv)
        {
            Enumeradores.ValidacionProgramaNuevas numero;
            try
            {
                using (var svc = new ODSServiceClient())
                {
                    numero = svc.ValidarBusquedaProgramaNuevas(userData.PaisID, userData.CampaniaID, userData.CodigoPrograma, userData.ConsecutivoNueva, cuv);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                numero = Enumeradores.ValidacionProgramaNuevas.ContinuaFlujo;
            }
            return numero;
        }

        private string ValidarCantidadEnProgramaNuevas(string cuvingresado, int cantidadIngresada)
        {
            int cantidadPedido = GetCantidadCuvPedidoWeb(cuvingresado);
            int valor = 0;
            using (var svc = new ODSServiceClient())
            {
                valor = svc.ValidarCantidadMaximaProgramaNuevas(userData.PaisID, userData.CampaniaID, userData.ConsecutivoNueva, userData.CodigoPrograma, cantidadPedido, cuvingresado, cantidadIngresada);
            }
            if (valor != 0) return string.Format(Constantes.MensajesError.ExcedioLimiteVenta, valor);

            return "";
        }

        private int GetCantidadCuvPedidoWeb(string cuvIngresado)
        {
            List<BEPedidoWebDetalle> lstPedidoDetalle = ObtenerPedidoWebDetalle();
            return lstPedidoDetalle.Where(a => a.CUV == cuvIngresado).Sum(b => b.Cantidad);
        }

        private Enumeradores.ValidacionVentaExclusiva ValidarVentaExclusiva(string cuv)
        {
            try
            {
                using (var svc = new ODSServiceClient())
                {
                    return svc.ValidarVentaExclusiva(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, cuv);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Enumeradores.ValidacionVentaExclusiva.ContinuaFlujo;
            }
        }

        private bool ValidarTieneRDoRDR()
        {
            return (revistaDigital.TieneRDC && revistaDigital.EsActiva) || revistaDigital.TieneRDCR;
        }

        private void CrearLogProgNuevas(string message, string cuv)
        {
            if (WebConfig.Ambiente != "QA") return;

            var listConsultoraRegistro = new List<string> { "006926193", "043862731", "011971059", "030320840", "003706273", "009118330", "020466782", "011930654", "011410731", "035515321" };
            if (!listConsultoraRegistro.Contains(userData.CodigoConsultora)) return;

            var exTrace = string.Format("ISO:{0};Consultora{1};Cuv:{2}", userData.CodigoISO, userData.CodigoConsultora, cuv);
            LogManager.LogManager.LogErrorWebServicesBus(new CustomTraceException(message, exTrace), userData.CodigoConsultora, userData.CodigoISO);
        }

        /// <summary>
        /// Obtiene informacion de componentes seleccionados en el pedido
        /// </summary>
        /// <param name="CampaniaID">Campania</param>
        /// <param name="SetID">Set</param>
        /// <returns></returns>
        public JsonResult ObtenerPedidoWebSetDetalle(int campaniaId, int set)
        {
            try
            {
                var pedidoSet = _pedidoSetProvider.ObtenerPorId(userData.PaisID, set);
                return Json(new
                {
                    success = true,
                    pedidoSet
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ObtenerOfertaByCUVSet(string campaniaId, int set, string cuv)
        {
            try
            {
                var pedidoSet = _pedidoSetProvider.ObtenerPorId(userData.PaisID, set);

                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    CUV2 = cuv,
                    CampaniaID = campaniaId.ToInt(),
                    CodigoEstrategia = Constantes.TipoPersonalizacion.ArmaTuPack
                };

                var estrategia = _ofertaBaseProvider.ObtenerModeloOfertaDesdeApi(estrategiaModelo, userData.CodigoISO);

                if (estrategia.Hermanos.Any())
                {
                    var componentesNivel01 = new List<EstrategiaComponenteModel>();

                    estrategia.Hermanos.Each(x =>
                    {
                        if (x.Hermanos.Any())
                        {
                            componentesNivel01.AddRange(x.Hermanos);
                        }
                    });

                    pedidoSet.Detalles.Update(x =>
                    {
                        var item = componentesNivel01.FirstOrDefault(i => i.Cuv == x.CUV);
                        x.NombreProducto = item != null ? item.NombreComercial : string.Empty;
                    });
                }

                return Json(new
                {
                    success = true,
                    pedidoSet
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Valida si la palanca tiene pedidos
        /// </summary>
        /// <param name="te">Tipo de estrategia</param>
        /// <returns></returns>
        public JsonResult ValidaExisteTipoEstrategiaEnPedido(string te)
        {
            try
            {
                var lstPedidoAgrupado = ObtenerPedidoWebSetDetalleAgrupado();
                var packAgregado = lstPedidoAgrupado != null ? lstPedidoAgrupado.FirstOrDefault(x => x.TipoEstrategiaCodigo == te) : null;

                return Json(new
                {
                    success = true,
                    TienePedido = packAgregado != null
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Requerimiento TESLA-28
        /// [Ganancia] Cálculo Ganancia ofertas Catálogo*
        /// </summary>
        /// <returns></returns>
        private bool IsCalculoGananaciaConsultora(BEPedidoWeb pedidoWeb)
        {
            return pedidoWeb.GananciaRevista.HasValue &&
                   pedidoWeb.GananciaWeb.HasValue && pedidoWeb.GananciaWeb.HasValue;
        }
    }
}