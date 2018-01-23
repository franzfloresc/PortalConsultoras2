﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
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

        public ActionResult Index(bool lanzarTabConsultoraOnline = false, string cuv = "", int campana = 0)
        {
            var model = new PedidoSb2Model();

            try
            {
                model.EsPais = GetMarcaPorCodigoIso(userData.CodigoISO);
                model.CodigoIso = userData.CodigoISO;

                sessionManager.SetObservacionesProl(null);
                sessionManager.SetPedidoWeb(null);
                sessionManager.SetDetallesPedido(null);

                AgregarKitNuevas();
                
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

                if (configuracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                    !configuracionCampania.ModificaPedidoReservado &&
                    !configuracionCampania.ValidacionAbierta)
                {
                    return RedirectToAction("PedidoValidado");
                }

                userData.ZonaValida = configuracionCampania.ZonaValida;

                model.FlagValidacionPedido = "0";
                if (configuracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                    configuracionCampania.ModificaPedidoReservado)
                {
                    model.FlagValidacionPedido = "1";
                }

                model.EstadoPedido = configuracionCampania.EstadoPedido == Constantes.EstadoPedido.Pendiente ? 0 : 1;


                ActualizarUserDataConInformacionCampania(configuracionCampania);

                var horaCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
                var diaActual = DateTime.Today.Add(horaCierrePortal);
                var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month);

                if (!userData.DiaPROL)  // Periodo de venta
                {
                    model.AccionBoton = "guardar";
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
                        model.AccionBoton = "validar";
                        model.Prol = "RESERVA TU PEDIDO";
                        model.ProlTooltip = "Haz click aqui para reservar tu pedido";
                        model.IndicadorGPRSB = configuracionCampania.IndicadorGPRSB;

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
                            model.AccionBoton = "guardar";
                            model.Prol = "GUARDA TU PEDIDO";
                            model.ProlTooltip = "Es importante que guardes tu pedido";
                            model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                        }
                        else
                        {
                            model.AccionBoton = "validar";
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

                #endregion

                #region Pedido Web y Detalle

                if (userData.TipoUsuario == Constantes.TipoUsuario.Consultora)
                {
                    var pedidoWeb = ObtenerPedidoWeb();

                    model.PedidoWebDetalle = ObtenerPedidoWebDetalle();
                    model.Total = model.PedidoWebDetalle.Sum(p => p.ImporteTotal);
                    model.MontoAhorroCatalogo = pedidoWeb.MontoAhorroCatalogo;
                    model.MontoAhorroRevista = pedidoWeb.MontoAhorroRevista;
                    model.MontoDescuento = pedidoWeb.DescuentoProl;
                    model.MontoEscala = pedidoWeb.MontoEscala;
                    model.TotalConDescuento = model.Total - model.MontoDescuento;

                    model.ListaParametriaOfertaFinal = GetParametriaOfertaFinal(GetOfertaFinal().Algoritmo);
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
                    SetUserData(userData);
                }

                #endregion

                #region Mensaje Guardar Colombia

                if (userData.CodigoISO == Constantes.CodigosISOPais.Colombia)
                {
                    List<BETablaLogicaDatos> tabla;
                    using (var sac = new SACServiceClient())
                    {
                        tabla = sac.GetTablaLogicaDatos(userData.PaisID, 27).ToList();
                    }

                    model.MensajeGuardarColombia = tabla.Count != 0
                        ? tabla[0].Descripcion
                        : string.Empty;
                }
                else
                {
                    model.MensajeGuardarColombia = string.Empty;
                }

                #endregion

                #region Banners

                var urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
                var urlProdDesc = WebConfigurationManager.AppSettings["ProdDesc"] + "/" + userData.CodigoISO;
                var banner01 = WebConfigurationManager.AppSettings["banner_01"];
                var banner02 = WebConfigurationManager.AppSettings["banner_02"];
                var banner03 = WebConfigurationManager.AppSettings["banner_03"];

                model.UrlBanner01 = ConfigS3.GetUrlFileS3(urlCarpeta, banner01, String.Empty);
                model.UrlBanner02 = ConfigS3.GetUrlFileS3(urlCarpeta, banner02, String.Empty);
                model.UrlBanner03 = ConfigS3.GetUrlFileS3(urlCarpeta, banner03, String.Empty);

                model.accionBanner_01 = ConfigS3.GetUrlFileS3(urlProdDesc, userData.CampaniaID + ".pdf", String.Empty);

                #endregion

                #region Valores de userdata

                model.TotalCliente = "";
                model.ClienteID_ = "-1";

                model.EstadoSimplificacionCuv = userData.EstadoSimplificacionCUV;
                model.ErrorInsertarProducto = "";
                model.ListaEstrategias = new List<BEEstrategia>();
                model.ZonaNuevoProlM = userData.ZonaNuevoPROL;
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
                ViewBag.LanzarTabConsultoraOnline = (lanzarTabConsultoraOnline) ? "1" : "0";

                if (GetMostrarPedidosPendientesFromConfig())
                {
                    var paisesConsultoraOnline = GetPaisesConConsultoraOnlineFromConfig();
                    if (paisesConsultoraOnline.Contains(userData.CodigoISO)
                        && userData.TipoUsuario == Constantes.TipoUsuario.Consultora)
                    {
                        using (var svc = new UsuarioServiceClient())
                        {
                            var cantPedidosPendientes = svc.GetCantidadSolicitudesPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                            if (cantPedidosPendientes > 0)
                            {
                                ViewBag.MostrarPedidosPendientes = "1";

                                using (var sv = new SACServiceClient())
                                {
                                    var motivoSolicitud = sv.GetMotivosRechazo(userData.PaisID).ToList();
                                    ViewBag.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(motivoSolicitud);
                                }
                            }
                        }

                    }
                }

                #endregion
                
                ViewBag.UrlTerminosOfertaFinalRegalo = string.Format(GetConfiguracionManager(Constantes.ConfiguracionManager.oferta_final_regalo_url_s3), userData.CodigoISO);
                model.MostrarPopupPrecargados = (GetMostradoPopupPrecargados() == 0);
                
                ViewBag.CUVOfertaProl = TempData["CUVOfertaProl"];
                ViewBag.MensajePedidoDesktop = userData.MensajePedidoDesktop;
                model.PartialSectionBpt = GetPartialSectionBptModel();

                ViewBag.NombreConsultora = userData.Sobrenombre;
                if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                    model.Prol = "GUARDA TU PEDIDO";

                model.CampaniaActual = userData.CampaniaID;
                model.Simbolo = userData.Simbolo;
                #region Cupon
                model.TieneCupon = userData.TieneCupon;
                model.EMail = userData.EMail;
                model.Celular = userData.Celular;
                model.EmailActivo = userData.EMailActivo;
                #endregion
                ViewBag.paisISO = userData.CodigoISO;
                ViewBag.Ambiente = GetBucketNameFromConfig();
                ViewBag.CodigoConsultora = userData.CodigoConsultora;
                model.TieneMasVendidos = userData.TieneMasVendidos;
                var ofertaFinal = GetOfertaFinal();
                ViewBag.OfertaFinalEstado = ofertaFinal.Estado;
                ViewBag.OfertaFinalAlgoritmo = ofertaFinal.Algoritmo;
                ViewBag.UrlFranjaNegra = GetUrlFranjaNegra();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }
            

            ViewBag.UrlTerminosOfertaFinalRegalo = string.Format(GetConfiguracionManager(Constantes.ConfiguracionManager.oferta_final_regalo_url_s3), userData.CodigoISO);

            if (Session["EsShowRoom"] != null && Session["EsShowRoom"].ToString() == "1")
            {
                ViewBag.ImagenFondoOFRegalo = ObtenerValorPersonalizacionShowRoom("ImagenFondoOfertaFinalRegalo", "Desktop");
                ViewBag.Titulo1OFRegalo = ObtenerValorPersonalizacionShowRoom("Titulo1OfertaFinalRegalo", "Desktop");
            }

            return View("Index", model);
        }

        private BEConfiguracionCampania GetConfiguracionCampania()
        {
            BEConfiguracionCampania configuracionCampania;

            if (userData.TipoUsuario == Constantes.TipoUsuario.Consultora)
            {
                using (var pedidoServiceClient = new PedidoServiceClient())
                {
                    var consultoraId = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID;
                    configuracionCampania = pedidoServiceClient.GetEstadoPedido(userData.PaisID, userData.CampaniaID, consultoraId, userData.ZonaID, userData.RegionID);
                }

                return configuracionCampania;
            }

            configuracionCampania = new BEConfiguracionCampania
            {
                CampaniaID = userData.CampaniaID,
                EstadoPedido = Constantes.EstadoPedido.Pendiente,
                ModificaPedidoReservado = false,
                ZonaValida = false,
                CampaniaDescripcion = Convert.ToString(userData.CampaniaID)
            };

            return configuracionCampania;
        }

        public ActionResult virtualCoach(string param = "")
        {
            try
            {
                if (Request.Browser.IsMobileDevice)
                {
                    return RedirectToAction("virtualCoach", new RouteValueDictionary(new { controller = "Pedido", area = "Mobile", param = param }));
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
            return GetPaisesEsikaFromConfig().Contains(codigoIso) ? "Ésika" : "L'bel";
        }

        private string GetPaisesFlexiPago()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesFlexipago);
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

            SetUserData(usuario);
        }

        private void ActualizarEsDiaPROLyMostrarBotonValidarPedido(UsuarioModel usuario)
        {
            var fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

            usuario.DiaPROL = (usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) < fechaHoraActual
                && fechaHoraActual < usuario.FechaFinCampania.AddDays(1));

            usuario.MostrarBotonValidar = EsHoraReserva(usuario, fechaHoraActual);
        }

        private bool EsHoraReserva(UsuarioModel usuario, DateTime fechaHora)
        {
            if (!usuario.DiaPROL)
                return false;

            var horaNow = new TimeSpan(fechaHora.Hour, fechaHora.Minute, 0);
            var esHorarioReserva = (fechaHora < usuario.FechaInicioCampania) ?
                (horaNow > usuario.HoraInicioPreReserva && horaNow < usuario.HoraFinPreReserva) :
                (horaNow > usuario.HoraInicioReserva && horaNow < usuario.HoraFinReserva);

            if (!esHorarioReserva)
                return false;

            if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
                return (BuildFechaNoHabil() == 0);

            return true;
        }

        #region CRUD

        [HttpPost]
        public JsonResult Insert(PedidoSb2Model model)
        {
            try
            {
                var objValidad = InsertarMensajeValidarDatos(model.ClienteID);
                if (objValidad != null)
                    return Json(objValidad);

                objValidad = InsertarValidarKitInicio(model);
                if (objValidad != null)
                    return Json(objValidad);

                #region AdministradorPedido
                var obePedidoWebDetalle = new BEPedidoWebDetalle
                {
                    IPUsuario = userData.IPUsuario,
                    CampaniaID = userData.CampaniaID,
                    ConsultoraID = userData.ConsultoraID,
                    PaisID = userData.PaisID,
                    TipoOfertaSisID = model.TipoOfertaSisID,
                    ConfiguracionOfertaID = model.ConfiguracionOfertaID,
                    ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short) 0 : Convert.ToInt16(model.ClienteID),
                    PedidoID = userData.PedidoID,
                    OfertaWeb = model.OfertaWeb,
                    IndicadorMontoMinimo = Convert.ToInt32(model.IndicadorMontoMinimo),
                    SubTipoOfertaSisID = 0,
                    EsSugerido = model.EsSugerido,
                    EsKitNueva = model.EsKitNueva,
                    MarcaID = Convert.ToByte(model.MarcaID),
                    Cantidad = Convert.ToInt32(model.Cantidad),
                    PrecioUnidad = model.PrecioUnidad,
                    CUV = model.CUV,
                    OrigenPedidoWeb = model.OrigenPedidoWeb,
                    DescripcionProd = model.DescripcionProd
                };
                
                obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;
                obePedidoWebDetalle.Nombre = obePedidoWebDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;

                bool errorServer;
                string tipo;
                bool modificoBackOrder;
                var olstPedidoWebDetalle = AdministradorPedido(obePedidoWebDetalle, "I", out errorServer, out tipo, out modificoBackOrder);

                #endregion

                var total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                var formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

                var listaCliente = ListarClienteSegunPedido(model.ClienteID_, olstPedidoWebDetalle);

                #region PedidoWebDetalleModel
                var pedidoWebDetalleModel = Mapper.Map<BEPedidoWebDetalle, PedidoWebDetalleModel>(obePedidoWebDetalle);
                pedidoWebDetalleModel.Simbolo = userData.Simbolo;
                pedidoWebDetalleModel.EstadoSimplificacionCuv = userData.EstadoSimplificacionCUV;
                pedidoWebDetalleModel.ClienteID_ = model.ClienteID_;
                pedidoWebDetalleModel.CodigoIso = userData.CodigoISO;

                var bePedidoWebDetalle = olstPedidoWebDetalle.FirstOrDefault(p => p.CUV == model.CUV);
                if (bePedidoWebDetalle != null)
                {
                    pedidoWebDetalleModel.IndicadorOfertaCUV = bePedidoWebDetalle.IndicadorOfertaCUV;
                    pedidoWebDetalleModel.DescripcionLarga = !string.IsNullOrEmpty(bePedidoWebDetalle.DescripcionLarga)
                        ? bePedidoWebDetalle.DescripcionLarga : "";
                    pedidoWebDetalleModel.DescripcionOferta = !string.IsNullOrEmpty(bePedidoWebDetalle.DescripcionOferta)
                        ? bePedidoWebDetalle.DescripcionOferta.Replace("[", "").Replace("]", "").Trim() : "";
                    pedidoWebDetalleModel.TipoPedido = !string.IsNullOrEmpty(bePedidoWebDetalle.TipoPedido)
                        ? bePedidoWebDetalle.TipoPedido : "";
                    pedidoWebDetalleModel.TipoEstrategiaID = bePedidoWebDetalle.TipoEstrategiaID;
                    pedidoWebDetalleModel.Mensaje = bePedidoWebDetalle.Mensaje;
                    pedidoWebDetalleModel.TipoObservacion = bePedidoWebDetalle.TipoObservacion;
                }
                #endregion

                return Json(new
                {
                    success = !errorServer,
                    message = !errorServer ? "OK"
                        : tipo.Length > 1 ? tipo
                        : "Ocurrió un error al ejecutar la operación.",
                    data = pedidoWebDetalleModel,
                    total,
                    formatoTotal,
                    listaCliente,
                    errorInsertarProducto = !errorServer ? "0" : "1",
                    tipo,
                    modificoBackOrder,
                    DataBarra = !errorServer ? GetDataBarra() : new BarraConsultoraModel(),
                    cantidadTotalProductos = ObtenerPedidoWebDetalle().Sum(dp => dp.Cantidad)
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
                    total = "",
                    formatoTotal = "",
                    listaCliente = "",
                    errorInsertarProducto = "0",
                    tipo = ""
                });
            }
        }

        private object InsertarMensajeValidarDatos(string clienteIdStr)
        {
            if (string.IsNullOrEmpty(clienteIdStr))
                return null;

            var clienteId = Convert.ToInt32(clienteIdStr);

            if (clienteId > 0)
            {
                using (var service = new ClienteServiceClient())
                {
                    var cliente = service.SelectByConsultoraByCodigo(userData.PaisID, userData.ConsultoraID, clienteId, 0);
                    if (cliente.TieneTelefono == 0)
                    {
                        return new
                        {
                            success = false,
                            message = "Debe actualizar los datos del cliente.",
                            errorCliente = true
                        };
                    }
                }
            }
            
            return null;
        }

        private object InsertarValidarKitInicio(PedidoSb2Model model)
        {
            var olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
            if (userData.EsConsultoraNueva)
            {
                var detCuv = olstPedidoWebDetalle.FirstOrDefault(d => d.CUV == model.CUV) ?? new BEPedidoWebDetalle();
                detCuv.CUV = Util.SubStr(detCuv.CUV, 0);
                if (detCuv.CUV != "")
                {
                    var obeConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas("ConfiguracionProgramaNuevas");
                    if (obeConfiguracionProgramaNuevas.IndProgObli == "1" && obeConfiguracionProgramaNuevas.CUVKit == model.CUV)
                    {
                        return new
                        {
                            success = false,
                            message = "Ocurrió un error al ejecutar la operación.",
                            errorInsertarProducto = "1"
                        };
                    }
                }
            }
            return null;
        }

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

                var model = new PedidoSb2Model {Total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal)};

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
        public JsonResult Update(PedidoWebDetalleModel model)
        {
            var objvalida = InsertarMensajeValidarDatos(model.ClienteID.ToString());
            if (objvalida != null)
            {
                return Json(objvalida);
            }

            var obePedidoWebDetalle = new BEPedidoWebDetalle
            {
                PaisID = userData.PaisID,
                CampaniaID = model.CampaniaID,
                PedidoID = model.PedidoID,
                PedidoDetalleID = Convert.ToInt16(model.PedidoDetalleID),
                Cantidad = Convert.ToInt32(model.Cantidad),
                PrecioUnidad = model.PrecioUnidad,
                ClienteID = string.IsNullOrEmpty(model.Nombre) ? (short) 0 : Convert.ToInt16(model.ClienteID),
                CUV = model.CUV,
                TipoOfertaSisID = model.TipoOfertaSisID,
                Stock = model.Stock,
                Flag = model.Flag,
                DescripcionProd = model.DescripcionProd
            };

            obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;
            obePedidoWebDetalle.Nombre = obePedidoWebDetalle.ClienteID == 0 ? userData.NombreConsultora : model.Nombre;

            bool errorServer;
            string tipo;
            bool modificoBackOrder;

            var olstPedidoWebDetalle = AdministradorPedido(obePedidoWebDetalle, "U", out errorServer, out tipo, out modificoBackOrder);

            var total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            var totalFormato = Util.DecimalToStringFormat(total, userData.CodigoISO);

            var totalCliente = PedidoWebTotalClienteFormato(model.ClienteID_, olstPedidoWebDetalle);

            var message = !errorServer ? "El registro ha sido actualizado de manera exitosa."
                : tipo.Length > 1 ? tipo
                : "Hubo un problema al intentar actualizar el registro. Por favor inténtelo nuevamente.";

            return Json(new
            {
                success = !errorServer,
                message,
                Total = total,
                TotalFormato = totalFormato,
                Total_Cliente = totalCliente,
                model.ClienteID_,
                userData.Simbolo,
                extra = "",
                tipo,
                modificoBackOrder,
                DataBarra = !errorServer ? GetDataBarra() : new BarraConsultoraModel(),
                cantidadTotalProductos = ObtenerPedidoWebDetalle().Sum(x => x.Cantidad)
            }, JsonRequestBehavior.AllowGet);
        }

        private void DeletePedido(BEPedidoWebDetalle obe)
        {
            string mensaje;
            if (ReservadoEnHorarioRestringido(out mensaje))
            {
                ModelState.AddModelError("", mensaje);
                return;
            }

            obe.Mensaje = GetObservacionesProlPorCuv(obe.CUV);
            
            bool errorServer;
            string tipo;
            bool modificoBackOrder;
            AdministradorPedido(obe, "D", out errorServer, out tipo, out modificoBackOrder);
            
        }

        [HttpPost]
        public JsonResult Delete(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad, string ClienteID, string CUVReco, bool EsBackOrder)
        {
            try
            {
                var listaPedidoWebDetalle = sessionManager.GetDetallesPedido() ?? new List<BEPedidoWebDetalle>();
                var pedidoEliminado = listaPedidoWebDetalle.FirstOrDefault(x => x.CUV == CUV);
                if (pedidoEliminado == null)
                    return ErrorJson(Constantes.MensajesError.DeletePedido_CuvNoExiste);

                pedidoEliminado.DescripcionOferta = !string.IsNullOrEmpty(pedidoEliminado.DescripcionOferta)
                    ? pedidoEliminado.DescripcionOferta.Replace("[", "").Replace("]", "").Trim() : "";

                var obe = new BEPedidoWebDetalle
                {
                    PaisID = userData.PaisID,
                    CampaniaID = CampaniaID,
                    PedidoID = PedidoID,
                    PedidoDetalleID = PedidoDetalleID,
                    TipoOfertaSisID = TipoOfertaSisID,
                    CUV = CUV,
                    Cantidad = Cantidad,
                    Mensaje = string.Empty
                };

                if (EsBackOrder) obe.Mensaje = Constantes.BackOrder.LogAccionCancelar;
                else obe.Mensaje = GetObservacionesProlPorCuv(CUV);
                
                bool errorServer;
                string tipo;
                bool modificoBackOrder;
                var olstPedidoWebDetalle = AdministradorPedido(obe, "D", out errorServer, out tipo, out modificoBackOrder);

                var total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                var formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);
                var formatoTotalCliente = "";

                if (!olstPedidoWebDetalle.Any())
                {
                    if (userData.ZonaValida)
                    {
                        using (var sv = new ServicePROL.ServiceStockSsic())
                        {
                            sv.Url = ConfigurarUrlServiceProl();
                            sv.wsDesReservarPedido(userData.CodigoConsultora, userData.CodigoISO);
                        }
                    }
                }
                else
                {
                    formatoTotalCliente = PedidoWebTotalClienteFormato(ClienteID, olstPedidoWebDetalle);
                }

                var listaCliente = ListarClienteSegunPedido("", olstPedidoWebDetalle);

                Session[Constantes.ConstSession.ListaEstrategia] = null;

                var message = !errorServer ? "OK"
                            : tipo.Length > 1 ? tipo
                            : "Ocurrió un error al ejecutar la operación.";

                return Json(new
                {
                    success = !errorServer,
                    message,
                    formatoTotal,
                    total,
                    formatoTotalCliente,
                    listaCliente,
                    tipo,
                    DataBarra = !errorServer ? GetDataBarra() : new BarraConsultoraModel(),
                    data = new
                    {
                        DescripcionProducto = pedidoEliminado.DescripcionProd,
                        CUV = pedidoEliminado.CUV,
                        Precio = pedidoEliminado.PrecioUnidad.ToString("F"),
                        DescripcionMarca = pedidoEliminado.DescripcionLarga,
                        DescripcionOferta = pedidoEliminado.DescripcionOferta
                    },
                    cantidadTotalProductos = olstPedidoWebDetalle.Sum(x => x.Cantidad)
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(ex.Message);
            }
        }

        private string GetObservacionesProlPorCuv(string cuv)
        {
            if (sessionManager.GetObservacionesProl() != null)
            {
                var observaciones = sessionManager.GetObservacionesProl();
                var obs = observaciones.Where(p => p.CUV == cuv).ToList();
                if (obs.Count != 0)
                {
                    return Util.Trim(obs[0].Descripcion);
                }
            }
            return "";
        }

        private string PedidoWebTotalClienteFormato(string clienteId, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            string formatoTotalCliente = "";
            if (olstPedidoWebDetalle.Any() && clienteId != "-1")
            {
                var lstTemp = (from item in olstPedidoWebDetalle
                                where item.ClienteID == Convert.ToInt16(clienteId)
                                select item).ToList();

                var totalCliente = lstTemp.Sum(p => p.ImporteTotal);
                formatoTotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
            }
            return formatoTotalCliente;
        }

        [HttpPost]
        public JsonResult DeleteAll()
        {
            var errorServer = false;
            string message;

            try
            {
                var noPasa = ReservadoEnHorarioRestringido(out message);
                if (noPasa)
                {
                    return Json(new
                    {
                        success = false,
                        message = message,
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                bool eliminacionMasiva;
                using (var sv = new PedidoServiceClient())
                {
                    eliminacionMasiva = sv.DelPedidoWebDetalleMasivo(userData.PaisID, userData.CampaniaID, userData.PedidoID, userData.CodigoUsuario);
                }
                if (eliminacionMasiva)
                {
                    sessionManager.SetPedidoWeb(null);
                    sessionManager.SetDetallesPedido(null);
                    Session[Constantes.ConstSession.ListaEstrategia] = null;

                    UpdPedidoWebMontosPROL();

                    if (userData.ZonaValida)
                    {
                        using (var sv = new ServicePROL.ServiceStockSsic())
                        {
                            sv.Url = ConfigurarUrlServiceProl();
                            sv.wsDesReservarPedido(userData.CodigoConsultora, userData.CodigoISO);
                        }
                    }
                }
                else
                {
                    errorServer = true;
                    message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                errorServer = true;
                message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            }

            return Json(new
            {
                success = !errorServer,
                message = message,
                extra = "",
                DataBarra = GetDataBarra()
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
                
                sessionManager.SetDetallesPedido(null);
                var olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                var total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                var formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

                var formatoTotalCliente = PedidoWebTotalClienteFormato(clienteID, olstPedidoWebDetalle);

                var listaCliente = ListarClienteSegunPedido("", olstPedidoWebDetalle);

                var message = "OK";

                return Json(new
                {
                    success = true,
                    message,
                    formatoTotal,
                    total,
                    formatoTotalCliente,
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

        [HttpPost]
        public JsonResult InsertarPedidoCuvBanner(string CUV, int CantCUVpedido)
        {
            try
            {
                List<BEProducto> olstProducto;
                using (var sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, CUV, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, false).ToList();
                }

                if (olstProducto.Count == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El producto solicitado no existe.",
                        oPedidoDetalle = ""
                    });
                }

                var strCuv = CUV;

                var obePedidoWebDetalle = new BEPedidoWebDetalle
                {
                    IPUsuario = userData.IPUsuario,
                    CampaniaID = userData.CampaniaID,
                    ConsultoraID = userData.ConsultoraID,
                    PaisID = userData.PaisID,
                    TipoOfertaSisID = 1700,
                    ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID,
                    ClienteID = (short)0,
                    PedidoID = userData.PedidoID,
                    OfertaWeb = false,
                    IndicadorMontoMinimo = Convert.ToInt32(olstProducto[0].IndicadorMontoMinimo.ToString().Trim()),
                    SubTipoOfertaSisID = Convert.ToInt32(0),
                    MarcaID = Convert.ToByte(olstProducto[0].MarcaID),
                    Cantidad = CantCUVpedido,
                    PrecioUnidad = olstProducto[0].PrecioCatalogo,
                    CUV = olstProducto[0].CUV.Trim(),
                    DescripcionProd = olstProducto[0].Descripcion.Trim(),
                    Nombre = userData.NombreConsultora,
                    DescripcionLarga = olstProducto[0].DescripcionMarca,
                    DescripcionEstrategia = olstProducto[0].DescripcionEstrategia,
                    Categoria = olstProducto[0].DescripcionCategoria,
                    OrigenPedidoWeb = Constantes.OrigenPedidoWeb.BannerDesktopHome
                };

                obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;

                IList<BEPedidoWebService> olstCuvMarquesina;
                using (var sv = new PedidoServiceClient())
                {
                    olstCuvMarquesina = sv.GetPedidoCuvMarquesina(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, strCuv);
                }

                string accion;

                if (olstCuvMarquesina.Count == 0 || olstCuvMarquesina[0].CUV == "")
                {
                    accion = "I";
                }
                else
                {
                    obePedidoWebDetalle.PedidoID = olstCuvMarquesina[0].PedidoWebID;
                    obePedidoWebDetalle.PedidoDetalleID = Convert.ToInt16(olstCuvMarquesina[0].PedidoWebDetalleID);
                    obePedidoWebDetalle.Cantidad = obePedidoWebDetalle.Cantidad + olstCuvMarquesina[0].Cantidad;
                    accion = "U";
                }

                bool errorServer;
                string tipo;
                bool modificoBackOrder;
                AdministradorPedido(obePedidoWebDetalle, accion, out errorServer, out tipo, out modificoBackOrder);

                return Json(new
                {
                    success = !errorServer,
                    message = !errorServer 
                        ? ("Has agregado " + Convert.ToString(CantCUVpedido) + " unidad(es) del producto a tu pedido.")
                        : tipo.Length > 1 ? tipo : "Ocurrió un error al ejecutar la operación.",
                    oPedidoDetalle = obePedidoWebDetalle,
                    DataBarra = !errorServer ? GetDataBarra() : new BarraConsultoraModel(),
                    tipo
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ha ocurrido un Error. Vuelva a intentarlo."
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
                    if (vPaisId == 4)
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

                if (userData.PaisID == 4)
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

                if (userData.PaisID == 4)
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

        #region Zona de Estretegias
        [HttpPost]
        public JsonResult ValidarStockEstrategia(
            string MarcaID, string CUV, string PrecioUnidad, string Descripcion, string Cantidad, string indicadorMontoMinimo, string TipoOferta)
        {
            var mensaje = "";
            var resul = false;
            try
            {
                var entidad = new BEEstrategia {PaisID = userData.PaisID};

                int iCantidad;
                entidad.Cantidad = int.TryParse(Cantidad, out iCantidad) ? iCantidad : 0;

                int iTipoOferta;
                entidad.FlagCantidad = int.TryParse(TipoOferta, out iTipoOferta) ? iTipoOferta : 0;

                entidad.CUV2 = CUV;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.ConsultoraID = userData.ConsultoraID.ToString();

                mensaje = ValidarMontoMaximo(Convert.ToDecimal(PrecioUnidad), entidad.Cantidad, out resul);

                if (mensaje == "" || resul)
                {
                    using (var svc = new PedidoServiceClient())
                    {
                        mensaje = svc.ValidarStockEstrategia(entidad);
                    }
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

            if (mensaje == "OK")
            {
                return Json(new
                {
                    result = true,
                    message = mensaje
                });
            }
            else
            {
                return Json(new
                {
                    result = resul,
                    message = mensaje
                }, JsonRequestBehavior.AllowGet);
            }

        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult AgregarProductoZE(string MarcaID, string CUV, string PrecioUnidad, string Descripcion, string Cantidad, string indicadorMontoMinimo,
                                              string TipoOferta, string OrigenPedidoWeb, string ClienteID_ = "", int tipoEstrategiaImagen = 0, bool EsOfertaIndependiente = false)
        {
            OrigenPedidoWeb = Util.Trim(OrigenPedidoWeb) ?? "0";
            OrigenPedidoWeb = OrigenPedidoWeb == "" ? "0" : OrigenPedidoWeb;

            var pedidoModel = new PedidoSb2Model()
            {
                ClienteID = string.Empty,
                ClienteID_ = ClienteID_,
                ClienteDescripcion = string.Empty,
                Tipo = 1,
                MarcaID = Convert.ToByte(MarcaID),
                Cantidad = Cantidad,
                PrecioUnidad = Convert.ToDecimal(PrecioUnidad),
                CUV = CUV,
                IndicadorMontoMinimo = indicadorMontoMinimo,
                DescripcionProd = Descripcion,
                TipoOfertaSisID = Convert.ToInt32(TipoOferta),
                ConfiguracionOfertaID = Convert.ToInt32(TipoOferta),
                OfertaWeb = false,
                OrigenPedidoWeb = Convert.ToInt32(OrigenPedidoWeb),
                EsOfertaIndependiente = EsOfertaIndependiente
            };

            EliminarDetallePackNueva(pedidoModel, tipoEstrategiaImagen);
            Session[Constantes.ConstSession.ListaEstrategia] = null;
            return Insert(pedidoModel);
        }

        #endregion

        #region Eliminar Detalle Pack Nueva
        private void EliminarDetallePackNueva(PedidoSb2Model entidad, int tipoEstrategiaImagen)
        {
            if (entidad.EsOfertaIndependiente) return;

            if (tipoEstrategiaImagen == Constantes.TipoEstrategia.PackNuevas)
            {
                var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                var packNuevas = lstPedidoWebDetalle.Where(x => x.FlagNueva && !x.EsOfertaIndependiente).ToList();

                foreach (var item in packNuevas)
                {
                    DeletePedido(item);
                }
                sessionManager.SetDetallesPedido(null);
            }
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
            var userModel = userData;
            var productos = SelectProductoByCodigoDescripcionSearchRegionZona(term, userModel, CRITERIO_BUSQUEDA_PRODUCTO_CANT, criterio);

            BloqueoProductosCatalogo(ref productos);

            BloqueoProductosDigitales(ref productos);

            if (!productos.Any())
            {
                productosModel.Add(GetProductoNoExiste());
                return productosModel;
            }

            productos = productos.Take(CANTIDAD_FILAS_AUTOCOMPLETADO).ToList();

            var cuv = productos.First().CUV.Trim();
            var mensajeByCuv = GetMensajeByCUV(userModel, cuv);
            var tieneRdc = revistaDigital.TieneRDC && revistaDigital.EsActiva;

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
                EsOfertaIndependiente = prod.EsOfertaIndependiente
            }));

            return productosModel;
        }

        public ActionResult FindByCUV(PedidoDetalleModel model)
        {
            var productosModel = new List<ProductoModel>();
            try
            {
                var userModel = userData;
                var productos = SelectProductoByCodigoDescripcionSearchRegionZona(model.CUV, userModel, 1, CRITERIO_BUSQUEDA_CUV_PRODUCTO);

                BloqueoProductosCatalogo(ref productos);
                if (!productos.Any())
                {
                    productosModel.Add(GetProductoNoExiste());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                var producto = productos.FirstOrDefault(prod => prod.CUV == model.CUV) ?? new BEProducto();

                var codigoEstrategia = Util.Trim(producto.TipoEstrategiaCodigo);
                if (BloqueoProductosRevistaDigital(codigoEstrategia))
                {
                    productosModel.Add(GetProductoInscribeteEnRevistaDigital());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }
                
                BloqueoProductosDigitales(ref productos);
                if (!productos.Any())
                {
                    productosModel.Add(GetProductoNoExiste());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                var cuvCredito = ValidarCUVCreditoPorCUVRegular(model, userModel);
                if (cuvCredito.IdMensaje == CUV_NO_TIENE_CREDITO)
                {
                    productosModel.Add(GetProductoCuvRegular(cuvCredito));
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                producto = productos.FirstOrDefault(prod => prod.CUV == model.CUV) ?? new BEProducto();

                var estrategias = (List<BEEstrategia>)Session[Constantes.ConstSession.ListaEstrategia] ?? new List<BEEstrategia>();
                var estrategia = estrategias.FirstOrDefault(p => p.CUV2 == producto.CUV) ?? new BEEstrategia();

                var observacionCuv = ObtenerObservacionCreditoCuv(userModel, cuvCredito);

                var mensajeByCuv = GetMensajeByCUV(userModel, producto.CUV.Trim());

                var tieneRdc = revistaDigital.TieneRDC && revistaDigital.EsActiva;

                var revistaGana = ValidarDesactivaRevistaGana(userModel);

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
                    EsOfertaIndependiente = estrategia.EsOfertaIndependiente,
                    TieneRDC = tieneRdc
                });

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel.Add(new ProductoModel { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo.", TieneSugerido = 0 });
            }

            return Json(productosModel, JsonRequestBehavior.AllowGet);

        }

        private List<BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(string codigoDescripcion, UsuarioModel userModel, int cantidadFilas, int criterioBusqueda)
        {
            List<BEProducto> productos;

            using (var odsServiceClient = new ODSServiceClient())
            {
                productos = odsServiceClient.SelectProductoByCodigoDescripcionSearchRegionZona(
                    userModel.PaisID,
                    userModel.CampaniaID,
                    codigoDescripcion,
                    userModel.RegionID,
                    userModel.ZonaID,
                    userModel.CodigorRegion,
                    userModel.CodigoZona,
                    criterioBusqueda,
                    cantidadFilas,
                    true).ToList();
            }

            return productos;
        }

        private void BloqueoProductosCatalogo(ref List<BEProducto> beProductos)
        {
            if (!beProductos.Any()) return;

            if (!(revistaDigital.TieneRDC || revistaDigital.TieneRDR)) return;

            if (!revistaDigital.EsActiva) return;

            if (revistaDigital.BloquearRevistaImpresaGeneral != null)
            {
                if (revistaDigital.BloquearRevistaImpresaGeneral == 1)
                {
                    beProductos = beProductos
                        .Where(x => !userData.CodigosRevistaImpresa.Contains(x.CodigoCatalogo.ToString())).ToList();
                }
            }
            else
            {
                if (revistaDigital.BloqueoRevistaImpresa)
                {
                    beProductos = beProductos
                        .Where(x => !userData.CodigosRevistaImpresa.Contains(x.CodigoCatalogo.ToString())).ToList();
                }
            }
        }

        private void BloqueoProductosDigitales(ref List<BEProducto> beProductos)
        {
            if (beProductos == null) return;
            if (!beProductos.Any()) return;

            if (revistaDigital.TieneRDC && !revistaDigital.EsActiva)
            {
                beProductos = beProductos
                    .Where(prod =>
                        !(prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                          || prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                          || prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                        )
                    )
                    .ToList();
            }

            if (revistaDigital.BloqueoProductoDigital)
            {
                beProductos = beProductos
                    .Where(prod =>
                        !(prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
                          || prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                          || prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                          || prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                        )
                    )
                    .ToList();
            }

            if (userData.OfertaDelDia != null && userData.OfertaDelDia.BloqueoProductoDigital)
            {
                beProductos = beProductos
                    .Where(prod => prod.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaDelDia)
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

            //beProductos = beProductos
            //    .Where(prod => !(prod.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.LosMasVendidos))
            //    .ToList();

        }

        private bool BloqueoProductosRevistaDigital(string codigoEstrategia)
        {
            return (Constantes.TipoEstrategiaCodigo.Lanzamiento == codigoEstrategia
                    || Constantes.TipoEstrategiaCodigo.OfertasParaMi == codigoEstrategia
                    || Constantes.TipoEstrategiaCodigo.PackAltoDesembolso == codigoEstrategia)
                   && !revistaDigital.TieneRDR
                   && !revistaDigital.TieneRDC;
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

        private ProductoModel GetProductoInscribeteEnRevistaDigital()
        {
            return new ProductoModel()
            {
                MarcaID = 0,
                CUV = "Para agregar este producto tienes que estar incrita a la revista digital.",
                TieneSugerido = 0
            };
        }

        private ProductoModel GetProductoCuvRegular(BECUVCredito cuvCredito)
        {
            return new ProductoModel() { MarcaID = 0, CUV = "Código incorrecto, Para solicitar el set: ingresa el código " + cuvCredito.CuvRegular, TieneSugerido = 0 };
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

        public ActionResult ObtenerProductosSugeridos(string CUV)
        {
            var listaProductoModel = new List<ProductoModel>();

            try
            {
                List<BEProducto> listaProduto;
                using (var sv = new ODSServiceClient())
                {
                    listaProduto = sv.GetProductoSugeridoByCUV(userData.PaisID, userData.CampaniaID, Convert.ToInt32(userData.ConsultoraID), CUV, userData.RegionID,
                        userData.ZonaID, userData.CodigorRegion, userData.CodigoZona).ToList();
                }

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                var esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                var listaTieneStock = new List<Lista>();

                if (esFacturacion)
                {
                    var txtBuil = new StringBuilder();

                    foreach (var beProducto in listaProduto)
                    {
                        if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                        {
                            txtBuil.Append(beProducto.CodigoProducto + "|");
                        }
                    }

                    var codigoSap = txtBuil.ToString();
                    codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                    try
                    {
                        if (!string.IsNullOrEmpty(codigoSap))
                        {
                            using (var sv = new wsConsulta())
                            {
                                sv.Url = GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
                                listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                        listaTieneStock = new List<Lista>();
                    }
                }

                foreach (var beProducto in listaProduto)
                {
                    var tieneStockProl = true;
                    if (esFacturacion)
                    {
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beProducto.CodigoProducto);
                        if (itemStockProl != null) tieneStockProl = itemStockProl.estado == 1;
                    }

                    if (beProducto.TieneStock && tieneStockProl)
                    {
                        listaProductoModel.Add(new ProductoModel()
                        {
                            CUV = beProducto.CUV.Trim(),
                            Descripcion = beProducto.Descripcion.Trim(),
                            PrecioCatalogoString = Util.DecimalToStringFormat(beProducto.PrecioCatalogo, userData.CodigoISO),
                            PrecioCatalogo = beProducto.PrecioCatalogo,
                            MarcaID = beProducto.MarcaID,
                            EstaEnRevista = beProducto.EstaEnRevista,
                            TieneStock = true,
                            EsExpoOferta = beProducto.EsExpoOferta,
                            CUVRevista = beProducto.CUVRevista.Trim(),
                            CUVComplemento = beProducto.CUVComplemento.Trim(),
                            IndicadorMontoMinimo = beProducto.IndicadorMontoMinimo.ToString().Trim(),
                            TipoOfertaSisID = beProducto.TipoOfertaSisID,
                            ConfiguracionOfertaID = beProducto.ConfiguracionOfertaID,
                            MensajeCUV = "",
                            DesactivaRevistaGana = -1,
                            DescripcionMarca = beProducto.DescripcionMarca,
                            DescripcionEstrategia = beProducto.DescripcionEstrategia,
                            DescripcionCategoria = beProducto.DescripcionCategoria,
                            FlagNueva = beProducto.FlagNueva,
                            TipoEstrategiaID = beProducto.TipoEstrategiaID,
                            ImagenProductoSugerido = beProducto.ImagenProductoSugerido ?? "",
                            ImagenProductoSugeridoSmall = ObtenerRutaImagenResize(beProducto.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall),
                            ImagenProductoSugeridoMedium = ObtenerRutaImagenResize(beProducto.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium),
                            CodigoProducto = beProducto.CodigoProducto,
                            TieneStockPROL = true
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaProductoModel = null;
            }

            return Json(listaProductoModel, JsonRequestBehavior.AllowGet);
        }

        public string ObtenerRutaImagenResize(string rutaImagen, string rutaNombreExtension)
        {
            string ruta = "";

            if (string.IsNullOrEmpty(rutaImagen))
                return ruta;

            var valorAppCatalogo = Constantes.ConfiguracionImagenResize.ValorTextoDefaultAppCatalogo;

            if (rutaImagen.ToLower().Contains(valorAppCatalogo))
            {
                string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);
                string soloExtension = Path.GetExtension(rutaImagen);

                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                
                ruta = ConfigS3.GetUrlFileS3(carpetaPais, soloImagen + rutaNombreExtension + soloExtension);
            }
            else
            {
                ruta = Util.GenerarRutaImagenResize(rutaImagen, rutaNombreExtension);
            }

            return ruta;
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
                    olstClienteModel.Add(new ClienteModel() { ClienteID = -1, Nombre = "Tu cliente  no está registrado. Haz click aquí para ingresarlo." });
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
                    olstClienteModel.Add(new ClienteModel() { ClienteID = 0, Nombre = "Tu cliente  no está registrado." });
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
        public JsonResult GetProductoFaltante(string cuv, string descripcion)
        {
            try
            {
                var productosFaltantes = GetProductosFaltantes(cuv, descripcion);
                var model = productosFaltantes.GroupBy(pf => pf.Categoria).Select(pfg => new ProductoFaltanteModel
                {
                    Categoria = pfg.Key,
                    Detalle = pfg.Select(pf => pf).OrderBy(pf => pf.Catalogo).ThenBy(pf => pf.NumeroPagina).ToList()
                });
                return Json(new { result = true, data = model }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { result = false, data = ex.Message }, JsonRequestBehavior.AllowGet);
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
        public JsonResult EjecutarServicioPROL()
        {
            try
            {
                ActualizarEsDiaPROLyMostrarBotonValidarPedido(userData);

                var input = Mapper.Map<BEInputReservaProl>(userData);
                input.EnviarCorreo = false;
                input.CodigosConcursos = userData.CodigosConcursos;
                input.EsOpt = EsOpt();

                BEResultadoReservaProl resultado;
                using (var sv = new PedidoServiceClient())
                {
                    resultado = sv.EjecutarReservaProl(input);

                    if (!string.IsNullOrEmpty(resultado.ListaConcursosCodigos))
                        sv.ActualizarInsertarPuntosConcurso(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID.ToString(), resultado.ListaConcursosCodigos, resultado.ListaConcursosPuntaje, resultado.ListaConcursosPuntajeExigido);
                }
                var listObservacionModel = Mapper.Map<List<ObservacionModel>>(resultado.ListPedidoObservacion.ToList());

                sessionManager.SetObservacionesProl(null);
                sessionManager.SetDetallesPedido(null);
                if (resultado.RefreshMontosProl)
                {
                    sessionManager.SetMontosProl(
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
                    sessionManager.SetObservacionesProl(listObservacionModel);
                    if (resultado.RefreshPedido) sessionManager.SetPedidoWeb(null);
                }
                SetUserData(userData);

                var listPedidoWebDetalle = ObtenerPedidoWebDetalle();
                var model = new PedidoSb2Model
                {
                    ListaObservacionesProl = listObservacionModel,
                    ObservacionInformativa = resultado.Informativas,
                    ObservacionRestrictiva = resultado.Restrictivas,
                    ErrorProl = resultado.Error,
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
                    ProlSinStock = userData.PROLSinStock,
                    ZonaNuevoProlM = userData.ZonaNuevoPROL,
                    CodigoIso = userData.CodigoISO,
                    CodigoMensajeProl = resultado.CodigoMensaje
                };
                SetMensajesBotonesProl(model, resultado.Reserva);

                return Json(new
                {
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
                    flagCorreo = resultado.EnviarCorreo ? "1" : ""
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

        private void SetMensajesBotonesProl(PedidoSb2Model model, bool reservaProl)
        {
            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month);
            var horaCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            var diaActual = DateTime.Today.Add(horaCierrePortal);

            if (!userData.DiaPROL)
            {
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                if (userData.CodigoISO == "BO") model.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                else model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
            }
            else if (userData.NuevoPROL && userData.ZonaNuevoPROL)
            {
                model.Prol = "RESERVA TU PEDIDO";
                model.ProlTooltip = "Haz click aqui para reservar tu pedido";
                if (diaActual <= userData.FechaInicioCampania) model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                else if (userData.CodigoISO == "BO") model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                else model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                return;
            }
            else if (!reservaProl)
            {
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido.";
                if (diaActual <= userData.FechaInicioCampania) model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                else if (userData.CodigoISO == "BO") model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                else model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                return;
            }
            else if (!userData.PROLSinStock)
            {
                model.Prol = "VALIDA TU PEDIDO";
                model.ProlTooltip = "Haz click aqui para validar tu pedido";
                if (diaActual <= userData.FechaInicioCampania) model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                else if (userData.CodigoISO == "BO") model.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                else model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                return;
            }
            else
            {
                model.Prol = "GUARDA TU PEDIDO";
                model.ProlTooltip = "Es importante que guardes tu pedido";
                model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
            }
            if (userData.TipoUsuario == Constantes.TipoUsuario.Postulante)
                model.Prol = "GUARDA TU PEDIDO";

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
                        ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short) 0 : item.ClienteID
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
                userData.CerrarRechazado = userData.RechazadoXdeuda ? 0 : 1;
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

            ViewBag.UrlBanner01 = ConfigS3.GetUrlFileS3(urlCarpeta, banner01, String.Empty);
            ViewBag.UrlBanner02 = ConfigS3.GetUrlFileS3(urlCarpeta, banner02, String.Empty);
            ViewBag.UrlBanner03 = ConfigS3.GetUrlFileS3(urlCarpeta, banner03, String.Empty);

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

            List<BEPedidoWebDetalle> lstPedidoWebDetalle;
            using (var sv = new PedidoServiceClient())
            {
                lstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
            }

            var model = new PedidoDetalleModel
            {
                Simbolo = userData.Simbolo,
                ListaDetalle = PedidoJerarquico(lstPedidoWebDetalle),
                eMail = userData.EMail
            };

            ViewBag.Simbolo = model.Simbolo;
            ViewBag.Total_Minimo = model.Total_Minimo;
            ViewBag.CodigoISOPais = userData.CodigoISO;

            ViewBag.GananciaEstimada = Util.DecimalToStringFormat(0, userData.CodigoISO);
            ViewBag.PedidoProductoMovil = 0;
            if (lstPedidoWebDetalle.Count > 0)
            {
                ViewBag.PedidoProductoMovil = lstPedidoWebDetalle
                    .Any(p => p.TipoPedido.ToUpper().Trim() == "PNV")
                     ? 1 : 0;

                if (userData.PedidoID == 0)
                {
                    userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                    SetUserData(userData);
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
            ViewBag.HoraCierre = FormatearHora(sp);
            model.TotalSinDsctoFormato = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO);
            model.TotalConDsctoFormato = Util.DecimalToStringFormat(totalPedido - bePedidoWebByCampania.DescuentoProl, userData.CodigoISO);

            ViewBag.EstadoSimplificacionCUV = userData.EstadoSimplificacionCUV;
            ViewBag.ZonaNuevoPROL = userData.ZonaNuevoPROL;
            model.ModificacionPedidoProl = userData.NuevoPROL && userData.ZonaNuevoPROL ? 0 : 1;

            model.PaisID = userData.PaisID;
            var pedidoWeb = ObtenerPedidoWeb();
            ViewBag.MontoAhorroCatalogo = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroCatalogo, userData.CodigoISO);
            ViewBag.MontoAhorroRevista = Util.DecimalToStringFormat(pedidoWeb.MontoAhorroRevista, userData.CodigoISO);
            ViewBag.MontoDescuento = Util.DecimalToStringFormat(pedidoWeb.DescuentoProl, userData.CodigoISO);

            var horaCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            var diaActual = DateTime.Today.Add(horaCierrePortal);
            var fechaFacturacionFormat = userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month);

            if (!userData.DiaPROL)
            {
                ViewBag.ProlTooltip = "Es importante que guardes tu pedido";
                ViewBag.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);

                if (userData.CodigoISO == "BO")
                {
                    ViewBag.ProlTooltip = "Es importante que guardes tu pedido";
                    ViewBag.ProlTooltip += string.Format("|No olvides reservar tu pedido el dia {0} para que sea enviado a facturar", fechaFacturacionFormat);
                }
            }
            else // Periodo de facturacion
            {
                if (userData.NuevoPROL && userData.ZonaNuevoPROL)   // PROL 2
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
                else // PROL 1
                {
                    if (userData.PROLSinStock)
                    {
                        ViewBag.ProlTooltip = "Es importante que guardes tu pedido";
                        ViewBag.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                    }
                    else
                    {
                        ViewBag.ProlTooltip = "Haz click aquí para validar tu pedido";

                        if (diaActual <= userData.FechaInicioCampania)
                        {
                            ViewBag.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", fechaFacturacionFormat);
                        }
                        else
                        {
                            if (userData.CodigoISO == "BO")
                            {
                                ViewBag.ProlTooltip += "|No olvides reservar tu pedido el dia de hoy para que sea enviado a facturar";
                            }
                            else
                            {
                                ViewBag.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm tt"));
                            }
                        }
                    }
                }
            }

            #region Banners

            var urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
            var urlProdDesc = WebConfigurationManager.AppSettings["ProdDesc"] + "/" + userData.CodigoISO;
            var banner01 = WebConfigurationManager.AppSettings["banner_01"];
            var banner02 = WebConfigurationManager.AppSettings["banner_02"];
            var banner03 = WebConfigurationManager.AppSettings["banner_03"];

            ViewBag.UrlBanner01 = ConfigS3.GetUrlFileS3(urlCarpeta, banner01, String.Empty);
            ViewBag.UrlBanner02 = ConfigS3.GetUrlFileS3(urlCarpeta, banner02, String.Empty);
            ViewBag.UrlBanner03 = ConfigS3.GetUrlFileS3(urlCarpeta, banner03, String.Empty);

            model.accionBanner_01 = ConfigS3.GetUrlFileS3(urlProdDesc, userData.CampaniaID + ".pdf", String.Empty);

            #endregion

            #region GPR

            userData.ValidacionAbierta = obeConfiguracionCampania.ValidacionAbierta;

            #endregion

            ViewBag.UrlFranjaNegra = GetUrlFranjaNegra();

            return View(model);
        }

        [HttpPost]
        public JsonResult CargarDetallePedidoValidado(string sidx, string sord, int page, int rows)
        {
            try
            {
                List<BEPedidoWebDetalle> lstPedidoWebDetalle;
                using (var sv = new PedidoServiceClient())
                {
                    lstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                }

                var totalPedido = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
                var totalMinimoPedido = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);

                lstPedidoWebDetalle.Update(p => p.DescripcionCortadaProd = Util.SubStrCortarNombre(p.DescripcionProd, 73));

                var pedidoModelo = new PedidoDetalleModel
                {
                    eMail = userData.EMail,
                    ListaDetalle = PedidoJerarquico(lstPedidoWebDetalle),
                    Simbolo = userData.Simbolo,
                    Total = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO),
                    Total_Minimo = Util.DecimalToStringFormat(totalMinimoPedido, userData.CodigoISO)
                };

                if (pedidoModelo.ListaDetalle.Any())
                {
                    var grid = SetGrid(sidx, sord, page, rows);
                    var pag = Util.PaginadorGenerico(grid, pedidoModelo.ListaDetalle);

                    pedidoModelo.ListaDetalle = pedidoModelo.ListaDetalle.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();
                    pedidoModelo.ListaDetalle.Update(detalle => { if (string.IsNullOrEmpty(detalle.Nombre)) detalle.Nombre = userData.NombreConsultora; });

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
            SetUserData(userData);
            return "";
        }

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult InsertarDesglose()
        {
            var input = Mapper.Map<BEInputReservaProl>(userData);
            input.EsOpt = EsOpt();
            int pedidoId;
            using (var sv = new PedidoServiceClient()) { pedidoId = sv.InsertarDesglose(input); }
            if (pedidoId == -1) return Json(new { success = false, message = Constantes.MensajesError.InsertarDesglose }, JsonRequestBehavior.AllowGet);

            try
            {
                if (pedidoId != 0)
                {
                    userData.PedidoID = pedidoId;
                    CambioBannerGPR();
                    SetUserData(userData);

                    var reemplazos = ObtenerPedidoWebDetalle().Where(p => !string.IsNullOrEmpty(p.Mensaje)).ToList();
                    if (reemplazos.Count != 0)
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            //Tipo 100: Manual, Accion 102: Aceptar Reemplazos
                            sv.InsPedidoWebAccionesPROL(reemplazos.ToArray(), 100, 102);
                        }
                    }
                }
                return Json(new { success = true, message = "" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = Constantes.MensajesError.InsertarDesglose }, JsonRequestBehavior.AllowGet);
            }
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

        private List<BEPedidoWebDetalle> AdministradorPedido(BEPedidoWebDetalle obePedidoWebDetalle, string tipoAdm, out bool errorServer, out string tipo, out bool modificoBackOrder)
        {
            var olstTempListado = new List<BEPedidoWebDetalle>();
            modificoBackOrder = false;

            try
            {
                if (!(obePedidoWebDetalle.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinal
                    || obePedidoWebDetalle.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinal
                    || obePedidoWebDetalle.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.AppOfertaFinalSinPopup))
                {
                    string mensaje;
                    var noPasa = ReservadoEnHorarioRestringido(out mensaje);
                    if (noPasa)
                    {
                        errorServer = true;
                        tipo = mensaje ?? " ";
                        return olstTempListado;
                    }
                }

                var pedidoWebDetalleNula = sessionManager.GetDetallesPedido() == null;

                olstTempListado = ObtenerPedidoWebDetalle();

                if (!pedidoWebDetalleNula)
                {
                    if (obePedidoWebDetalle.PedidoDetalleID == 0)
                    {
                        if (olstTempListado.Any(p => p.CUV == obePedidoWebDetalle.CUV))
                            obePedidoWebDetalle.TipoPedido = "X";
                    }
                    else
                    {
                        if (olstTempListado.Any(p => p.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID))
                            obePedidoWebDetalle.TipoPedido = "X";
                    }
                }

                if (tipoAdm == "I")
                {
                    int cantidad;
                    var result = ValidarInsercion(olstTempListado, obePedidoWebDetalle, out cantidad);
                    if (result != 0)
                    {
                        tipoAdm = "U";
                        obePedidoWebDetalle.Stock = obePedidoWebDetalle.Cantidad;
                        obePedidoWebDetalle.Cantidad += cantidad;
                        obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;
                        obePedidoWebDetalle.PedidoDetalleID = result;
                        obePedidoWebDetalle.Flag = 2;
                        obePedidoWebDetalle.OrdenPedidoWD = 1;
                    }
                }

                var totalClientes = CalcularTotalCliente(olstTempListado, obePedidoWebDetalle, tipoAdm == "D" ? obePedidoWebDetalle.PedidoDetalleID : (short)0, tipoAdm);
                var totalImporte = CalcularTotalImporte(olstTempListado, obePedidoWebDetalle, tipoAdm == "I" ? (short)0 : obePedidoWebDetalle.PedidoDetalleID, tipoAdm);

                obePedidoWebDetalle.ImporteTotalPedido = totalImporte;
                obePedidoWebDetalle.Clientes = totalClientes;

                obePedidoWebDetalle.CodigoUsuarioCreacion = userData.CodigoUsuario;
                obePedidoWebDetalle.CodigoUsuarioModificacion = userData.CodigoUsuario;

                var quitoCantBackOrder = false;
                if (tipoAdm == "U"
                    && obePedidoWebDetalle.PedidoDetalleID != 0)
                {
                    var oldPedidoWebDetalle = olstTempListado.FirstOrDefault(x => x.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID) ?? new BEPedidoWebDetalle();

                    if (oldPedidoWebDetalle.AceptoBackOrder
                        && obePedidoWebDetalle.Cantidad < oldPedidoWebDetalle.Cantidad
                        )
                    {
                        quitoCantBackOrder = true;
                    }

                }

                var indPedidoAutentico = new ServicePedido.BEIndicadorPedidoAutentico
                {
                    PedidoID = obePedidoWebDetalle.PedidoID,
                    CampaniaID = obePedidoWebDetalle.CampaniaID,
                    PedidoDetalleID = obePedidoWebDetalle.PedidoDetalleID,
                    IndicadorIPUsuario = GetIPCliente(),
                    IndicadorFingerprint = "",
                    IndicadorToken = Session["TokenPedidoAutentico"] != null
                        ? Session["TokenPedidoAutentico"].ToString()
                        : ""
                };
                obePedidoWebDetalle.IndicadorPedidoAutentico = indPedidoAutentico;
                obePedidoWebDetalle.OrigenPedidoWeb = ProcesarOrigenPedido(obePedidoWebDetalle.OrigenPedidoWeb);

                switch (tipoAdm)
                {
                    case "I":
                        BEPedidoWebDetalle oBePedidoWebDetalleTemp;

                        using (var sv = new PedidoServiceClient())
                        {
                            oBePedidoWebDetalleTemp = sv.Insert(obePedidoWebDetalle);
                        }

                        oBePedidoWebDetalleTemp.ImporteTotal = obePedidoWebDetalle.ImporteTotal;
                        oBePedidoWebDetalleTemp.DescripcionProd = obePedidoWebDetalle.DescripcionProd;
                        oBePedidoWebDetalleTemp.Nombre = obePedidoWebDetalle.Nombre;

                        obePedidoWebDetalle.PedidoDetalleID = oBePedidoWebDetalleTemp.PedidoDetalleID;

                        if (userData.PedidoID == 0)
                        {
                            var usuario = userData;
                            usuario.PedidoID = oBePedidoWebDetalleTemp.PedidoID;
                            SetUserData(usuario);
                        }

                        olstTempListado.Add(oBePedidoWebDetalleTemp);

                        break;
                    case "U":

                        using (var sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoWebDetalle(obePedidoWebDetalle);
                        }

                        olstTempListado.Where(p => p.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = obePedidoWebDetalle.Cantidad;
                                p.ImporteTotal = obePedidoWebDetalle.ImporteTotal;
                                p.ClienteID = obePedidoWebDetalle.ClienteID;
                                p.DescripcionProd = obePedidoWebDetalle.DescripcionProd;
                                p.Nombre = obePedidoWebDetalle.Nombre;
                                p.TipoPedido = obePedidoWebDetalle.TipoPedido;
                            });

                        break;
                    case "D":

                        using (var sv = new PedidoServiceClient())
                        {
                            sv.DelPedidoWebDetalle(obePedidoWebDetalle);
                        }

                        olstTempListado.RemoveAll(p => p.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID);

                        break;
                }

                errorServer = false;
                tipo = tipoAdm;
                if (tipo == "U" && quitoCantBackOrder)
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.QuitarBackOrderPedidoWebDetalle(obePedidoWebDetalle);
                    }
                    modificoBackOrder = true;
                }

                sessionManager.SetDetallesPedido(null);
                olstTempListado = ObtenerPedidoWebDetalle();
                UpdPedidoWebMontosPROL();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                olstTempListado = ObtenerPedidoWebDetalle();
                errorServer = true;
                tipo = "";
            }
            return olstTempListado;
        }

        private int CalcularTotalCliente(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            if (pedidoDetalleId == 0)
            {
                if (adm == "I")
                    temp.Add(itemPedido);
                else
                    temp.Where(p => p.PedidoDetalleID == itemPedido.PedidoDetalleID).Update(p => p.ClienteID = itemPedido.ClienteID);

            }
            else
                temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();

            return temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            if (pedidoDetalleId == 0)
                temp.Add(itemPedido);
            else
                temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();
            return temp.Sum(p => p.ImporteTotal) + (adm == "U" ? itemPedido.ImporteTotal : 0);
        }

        private short ValidarInsercion(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, out int cantidad)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            var obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV) ?? new BEPedidoWebDetalle();
            cantidad = obe.Cantidad;
            return obe.PedidoDetalleID;
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
                var pedidoReservado = result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado;
                var estado = result.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno;
                var mensaje = result.Mensaje;

                return Json(new
                {
                    success = estado,
                    pedidoReservado = pedidoReservado,
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
                marca = GetDescripcionMarca(string.IsNullOrEmpty(lst[0].MarcaID) ? 0 : Convert.ToInt32(lst[0].MarcaID));
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO));

                if (lst.Count > 1)
                {
                    marca = marca + "," + GetDescripcionMarca(string.IsNullOrEmpty(lst[1].MarcaID) ? 0 : Convert.ToInt32(lst[1].MarcaID));
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

        public int BuildFechaNoHabil()
        {
            var result = 0;
            if (sessionManager.GetUserData() != null)
            {
                var paisId = userData.PaisID;
                var rolId = userData.RolID;
                var codigoZona = userData.CodigoZona;
                if (rolId != 0)
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        result = sv.GetFechaNoHabilFacturacion(paisId, codigoZona, DateTime.Today);
                    }

                }
            }

            return result;
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
                    lst.Update(x => x.ArchivoPortada = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPortada, Globals.RutaImagenesIncentivos));
                    carpetaPais = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                    lst.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(carpetaPais, x.Archivo, Globals.RutaImagenesIncentivos));
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
                data = (List<BEBannerPedido>) null
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

                return Json(new
                {
                    success = true
                });
            }
            
            return Json(new
            {
                success = true
            });
        }

        [HttpPost]
        public JsonResult ValidarKitNuevas()
        {
            try
            {
                if (Session["ConfiguracionProgramaNuevas"] == null) AgregarKitNuevas();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false });
            }
            return Json(new { success = true });
        }

        private void AgregarKitNuevas()
        {
            if (Session["ConfiguracionProgramaNuevas"] != null) return;

            if (!userData.EsConsultoraNueva)
            {
                Session["ConfiguracionProgramaNuevas"] = new BEConfiguracionProgramaNuevas();
                return;
            }
            
            using (var sv = new PedidoServiceClient())
            {
                try
                {
                    var obeConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas("ConfiguracionProgramaNuevas");

                    if (obeConfiguracionProgramaNuevas == null)
                    {
                        Session["ConfiguracionProgramaNuevas"] = new BEConfiguracionProgramaNuevas();
                        return;
                    }

                    Session["ConfiguracionProgramaNuevas"] = obeConfiguracionProgramaNuevas;
                    if (obeConfiguracionProgramaNuevas.IndProgObli != "1") return;

                    var listaTempListado = ObtenerPedidoWebDetalle();

                    var det = new BEPedidoWebDetalle();
                    if (listaTempListado != null)
                        det = listaTempListado.FirstOrDefault(d => d.CUV == obeConfiguracionProgramaNuevas.CUVKit) ?? new BEPedidoWebDetalle();

                    if (det.PedidoDetalleID > 0) return;

                    List<BEProducto> olstProducto;
                    using (var svOds = new ODSServiceClient())
                    {
                        olstProducto = svOds.SelectProductoToKitInicio(userData.PaisID, userData.CampaniaID, obeConfiguracionProgramaNuevas.CUVKit).ToList();
                    }

                    if (olstProducto.Count > 0)
                    {
                        var producto = olstProducto[0];
                        var model = new PedidoSb2Model
                        {
                            TipoOfertaSisID = 0,
                            ConfiguracionOfertaID = 0,
                            IndicadorMontoMinimo = producto.IndicadorMontoMinimo.ToString().Trim(),
                            MarcaID = producto.MarcaID,
                            Cantidad = "1",
                            PrecioUnidad = producto.PrecioCatalogo,
                            CUV = obeConfiguracionProgramaNuevas.CUVKit,
                            Tipo = 0,
                            DescripcionProd = producto.Descripcion,
                            Pagina = "0",
                            DescripcionEstrategia = "",
                            EsSugerido = false,
                            EsKitNueva = true
                        };

                        Insert(model);
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    sv.Abort();
                }
            }
        }

        [HttpPost]
        public JsonResult CargarDetallePedido(string sidx, string sord, int page, int rows, int clienteId, bool mobil = false)
        {
            try
            {
                var model = new PedidoSb2Model
                {
                    CodigoIso = userData.CodigoISO,
                    EstadoSimplificacionCuv = userData.EstadoSimplificacionCUV
                };
                var listaDetalle = ObtenerPedidoWebDetalle() ?? new List<BEPedidoWebDetalle>();

                if (mobil)
                {
                    if (listaDetalle.Count == 0)
                    {
                        int isInsert;
                        using (var sv = new PedidoServiceClient())
                        {
                            var bePedidoWeb = new BEPedidoWeb
                            {
                                CampaniaID = userData.CampaniaID,
                                ConsultoraID = userData.ConsultoraID,
                                PaisID = userData.PaisID,
                                IPUsuario = userData.IPUsuario,
                                CodigoUsuarioCreacion = userData.CodigoUsuario
                            };

                            isInsert = sv.GetProductoCUVsAutomaticosToInsert(bePedidoWeb);
                        }
                        if (isInsert > 0)
                        {
                            sessionManager.SetDetallesPedido(null);
                            listaDetalle = ObtenerPedidoWebDetalle();

                            UpdPedidoWebMontosPROL();
                        }
                    }

                    page = 1;
                    rows = listaDetalle.Count;
                }

                var total = listaDetalle.Sum(p => p.ImporteTotal);

                model.ListaCliente = ListarClienteSegunPedido("", listaDetalle);

                listaDetalle = listaDetalle.Where(p => p.ClienteID == clienteId || clienteId == -1).ToList();
                var totalCliente = listaDetalle.Sum(p => p.ImporteTotal);

                var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoWebDetalle>, List<PedidoWebDetalleModel>>(listaDetalle);

                pedidoWebDetalleModel.ForEach(p => p.Simbolo = userData.Simbolo);
                pedidoWebDetalleModel.ForEach(p => p.CodigoIso = userData.CodigoISO);
                pedidoWebDetalleModel.ForEach(p => p.DescripcionCortadaProd = Util.SubStrCortarNombre(p.DescripcionProd, 73));

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
                    SetUserData(userData);

                    var grid = SetGrid(sidx, sord, page, rows);
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

                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.Simbolo = userData.Simbolo;

                return Json(new
                {
                    success = false,
                    message = "OK",
                    data = model,
                    dataBarra = GetDataBarra()
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

        #region Parametria Oferta Final

        private List<BEEscalaDescuento> GetParametriaOfertaFinal(string algoritmo)
        {
            List<BEEscalaDescuento> listaParametriaOfertaFinal;

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
                listaParametriaOfertaFinal = new List<BEEscalaDescuento>();
            }

            return listaParametriaOfertaFinal;
        }
        #endregion

        public JsonResult ObtenerProductosOfertaFinal(int tipoOfertaFinal)
        {
            try
            {
                var listaProductoModel = ObtenerListadoProductosOfertaFinal(tipoOfertaFinal);

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaProductoModel
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
                    limiteJetlore = 0
                });
            }
        }

        public JsonResult ObtenerOfertaFinalRegalo()
        {
            try
            {
                RegaloOfertaFinalModel model = null;
                using (var ps = new ProductoServiceClient())
                {
                    var regalo = ps.ObtenerRegaloOfertaFinal(userData.CodigoISO, userData.CampaniaID, userData.ConsultoraID);

                    if (regalo != null)
                    {
                        model = Mapper.Map<RegaloOfertaFinal, RegaloOfertaFinalModel>(regalo);
                        model.CodigoISO = userData.CodigoISO;
                        var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                        model.RegaloImagenUrl = ConfigS3.GetUrlFileS3(carpetaPais, regalo.RegaloImagenUrl, carpetaPais);
                    }
                }

                return Json(new
                {
                    success = true,
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
                });
            }
        }

        public JsonResult InsertarOfertaFinalRegalo()
        {
            try
            {
                using (var ps = new ProductoServiceClient())
                {
                    var montoTotal = Convert.ToDouble(ObtenerPedidoWebDetalle().Sum(p => p.ImporteTotal));
                    ps.InsertarRegaloOfertaFinal(userData.CodigoISO, userData.CampaniaID, userData.ConsultoraID, montoTotal, GetOfertaFinal().Algoritmo);
                }

                return Json(new
                {
                    success = true
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                });
            }
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
                segmentoId = userData.SegmentoInternoID ?? userData.SegmentoID;
            }

            var resultado = segmentoId == 1;

            return resultado;
        }

        [HttpPost]
        public JsonResult InsertarOfertaFinalLog(string CUV, int cantidad, string tipoOfertaFinal_Log, decimal gap_Log, int tipoRegistro, string desTipoRegistro)
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

        private List<ProductoModel> ObtenerListadoProductosOfertaFinal(int tipoOfertaFinal)
        {
            var paisesConPcm = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesConPcm);

            var tipoProductoMostrar = paisesConPcm.Contains(userData.CodigoISO) ? 2 : 1;

            var limiteJetlore = int.Parse(GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreOfertaFinal));

            decimal descuentoprol;

            try
            {
                descuentoprol = ObtenerPedidoWebDetalle()[0].DescuentoProl;
            }
            catch
            {
                descuentoprol = 0;
            }
            

            var ofertaFinal = GetOfertaFinal();
            var objOfertaFinal = new ListaParametroOfertaFinal
            {
                ZonaID = userData.ZonaID,
                CampaniaID = userData.CampaniaID,
                CodigoConsultora = userData.CodigoConsultora,
                CodigoISO = userData.CodigoISO,
                CodigoRegion = userData.CodigorRegion,
                CodigoZona = userData.CodigoZona,
                Limite = limiteJetlore,
                MontoEscala = GetDataBarra().MontoEscala,
                MontoMinimo = userData.MontoMinimo,
                MontoTotal = ObtenerPedidoWebDetalle().Sum(p => p.ImporteTotal) -
                             (descuentoprol.Equals(null) ? 0 : descuentoprol),
                TipoOfertaFinal = tipoOfertaFinal,
                TipoProductoMostrar = tipoProductoMostrar,
                Algoritmo = ofertaFinal.Algoritmo,
                Estado = ofertaFinal.Estado
            };


            List<Producto> lista;
            using (var ps = new ProductoServiceClient())
            {
                lista = ps.ObtenerProductosOfertaFinal(objOfertaFinal).ToList();
            }
            var listaProductoModel = Mapper.Map<List<Producto>, List<ProductoModel>>(lista);
            if (listaProductoModel.Count(x => x.ID == 0) == listaProductoModel.Count)
            {
                for (var i = 0; i <= listaProductoModel.Count - 1; i++) { listaProductoModel[i].ID = i; }
            }
            if (lista.Count != 0)
            {
                var tipoCross = lista[0].TipoCross;
                listaProductoModel.Update(p =>
                {
                    p.PrecioCatalogoString = Util.DecimalToStringFormat(p.PrecioCatalogo, userData.CodigoISO);
                    p.PrecioValorizadoString = Util.DecimalToStringFormat(p.PrecioValorizado, userData.CodigoISO);
                    p.MetaMontoStr = Util.DecimalToStringFormat(p.MontoMeta, userData.CodigoISO);
                    p.Simbolo = userData.Simbolo;
                    p.UrlCompartirFB = GetUrlCompartirFB();
                    p.NombreComercialCorto = Util.SubStrCortarNombre(p.NombreComercial, 40, "...");
                    var imagenUrl = Util.SubStr(p.Imagen, 0);

                    if (!tipoCross && userData.OfertaFinal == Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp)
                    {
                        var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                        imagenUrl = ConfigS3.GetUrlFileS3(carpetapais, imagenUrl, carpetapais);
                    }
                    p.ImagenProductoSugerido = imagenUrl;
                    p.ImagenProductoSugeridoSmall = ObtenerRutaImagenResize(p.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall);
                    p.ImagenProductoSugeridoMedium = ObtenerRutaImagenResize(p.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium);
                    p.TipoCross = tipoCross;
                });
            }

            Session["ProductosOfertaFinal"] = listaProductoModel;
            return listaProductoModel;
        }

        public JsonResult GetOfertaDelDia()
        {
            try
            {
                var oddModel = GetOfertaDelDiaModel();

                return Json(new
                {
                    success = oddModel != null,
                    data = oddModel
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

        public JsonResult CloseOfertaDelDia()
        {
            try
            {
                userData.CloseOfertaDelDia = true;
                sessionManager.SetUserData(userData);

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

                sessionManager.SetUserData(userData);

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
                Session["OcultarBannerTop"] = true;

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
                            var tpa = svc.GetTokenIndicadorPedidoAutentico(userData.PaisID, userData.CodigoISO, userData.CodigorRegion, userData.CodigoZona);
                            codigo = AESAlgorithm.Encrypt(tpa);
                        }
                        if (!string.IsNullOrEmpty(codigo))
                        {
                            Session["TokenPedidoAutentico"] = codigo;
                        }
                        break;
                    case "3":
                        if (!string.IsNullOrEmpty(codigo))
                        {
                            Session["TokenPedidoAutentico"] = codigo;
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

                    SetUserData(userData);
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
                var f = false;

                var model = userData.ConsultoraRegaloProgramaNuevas;
                if (model != null) f = true;
                
                return Json(new
                {
                    success = f,
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

        public JsonResult AgregarProducto(string listaCuvTonos
            , string EstrategiaID, string FlagNueva
            , string Cantidad
            , string OrigenPedidoWeb, string ClienteID_ = "", int tipoEstrategiaImagen = 0
        )
        {
            try
            {
                string mensaje = "", urlRedireccionar = "";

                #region SesiónExpirada
                if (userData == null)
                {
                    mensaje = "Sesión expirada.";
                    urlRedireccionar = Url.Action("Index", "Login");
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        urlRedireccionar
                    }, JsonRequestBehavior.AllowGet);

                }
                #endregion

                #region ReservadoOEnHorarioRestringido
                var horario = ReservadoOEnHorarioRestringido(ref mensaje, ref urlRedireccionar);
                if (horario)
                {
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        urlRedireccionar
                    }, JsonRequestBehavior.AllowGet);
                }
                #endregion

                #region FiltrarEstrategiaPedido
                FlagNueva = Util.Trim(FlagNueva);
                int indFlagNueva;
                Int32.TryParse(FlagNueva == "" ? "0" : FlagNueva, out indFlagNueva);
                var estrategia = FiltrarEstrategiaPedido(EstrategiaID, indFlagNueva);
                if (estrategia.EstrategiaID <= 0)
                {
                    var ficha = (FichaProductoDetalleModel)Session[Constantes.SessionNames.FichaProductoTemporal];
                    if (ficha != null)
                    {
                        return AgregarProductoVC(listaCuvTonos, FlagNueva, Cantidad, OrigenPedidoWeb, ClienteID_);
                    }
                    mensaje = "Estrategia no encontrada.";
                    return Json(new
                    {
                        success = false,
                        message = mensaje
                    }, JsonRequestBehavior.AllowGet);
                }
                #endregion

                estrategia.Cantidad = Convert.ToInt32(Cantidad);

                if (estrategia.Cantidad > estrategia.LimiteVenta)
                {
                    mensaje = "La cantidad no debe ser mayor que la cantidad limite ( " + estrategia.LimiteVenta + " ).";
                    return Json(new
                    {
                        success = false,
                        message = mensaje
                    }, JsonRequestBehavior.AllowGet);

                }

                listaCuvTonos = Util.Trim(listaCuvTonos);
                if (listaCuvTonos == "")
                {
                    listaCuvTonos = estrategia.CUV2;
                }
                var tonos = listaCuvTonos.Split('|');
                var respuesta = new JsonResult();
                foreach (var tono in tonos)
                {
                    var listSp = tono.Split(';');
                    estrategia.CUV2 = listSp.Length > 0 ? listSp[0] : estrategia.CUV2;
                    estrategia.MarcaID = listSp.Length > 1 ? Convert.ToInt32(listSp[1]) : estrategia.MarcaID;
                    estrategia.Precio2 = listSp.Length > 2 ? Convert.ToDecimal(listSp[2]) : estrategia.Precio2;

                    respuesta = EstrategiaAgregarProducto(ref mensaje, estrategia, OrigenPedidoWeb, ClienteID_, tipoEstrategiaImagen);
                }

                return Json(respuesta.Data, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrio un error, vuelva ha intentalo."
                });
            }
        }

        private JsonResult EstrategiaAgregarProducto(ref string mensaje, BEEstrategia estrategia, string OrigenPedidoWeb, string ClienteID_ = "", int tipoEstrategiaImagen = 0)
        {
            #region ValidarStockEstrategia
            var ofertas = estrategia.DescripcionCUV2.Split('|');
            var descripcion = ofertas[0];
            if (estrategia.FlagNueva == 1)
            {
                estrategia.Cantidad = estrategia.LimiteVenta;
            }
            else
            {
                descripcion = estrategia.DescripcionCUV2;
            }

            var resul = false;
            mensaje = ValidarMontoMaximo(estrategia.Precio2, estrategia.Cantidad, out resul);
            if (mensaje.Length > 1)
            {
                return Json(new
                {
                    success = false,
                    message = mensaje
                });
            }

            mensaje = ValidarStockEstrategia(estrategia.CUV2, estrategia.Cantidad, estrategia.TipoEstrategiaID);

            if (mensaje != "")
            {
                return Json(new
                {
                    success = false,
                    message = mensaje
                });
            }
            #endregion

            #region AgregarProductoZE

            return AgregarProductoZE(estrategia.MarcaID.ToString(),
                estrategia.CUV2,
                estrategia.Precio2.ToString(),
                descripcion,
                estrategia.Cantidad.ToString(),
                estrategia.IndicadorMontoMinimo.ToString(),
                estrategia.TipoEstrategiaID.ToString(),
                OrigenPedidoWeb,
                ClienteID_,
                tipoEstrategiaImagen,
                estrategia.EsOfertaIndependiente
                );
            #endregion

        }

        private bool ReservadoOEnHorarioRestringido(ref string mensaje, ref string urlRedireccionar, bool mostrarAlerta = true)
        {
            var estado = false;
            try
            {
                mensaje = "";
                var area = Request.Browser.IsMobileDevice ? "Mobile" : "";

                if (userData == null)
                {
                    mensaje = "Sesión expirada.";
                    urlRedireccionar = Url.Action("Index", "Login");
                    return true;
                }

                BEValidacionModificacionPedido result;
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.ValidacionModificarPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA);
                }

                estado = result.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno;
                var pedidoReservado = result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado;

                if (estado)
                {
                    mensaje = mostrarAlerta ? Util.Trim(result.Mensaje) : "";

                    if (pedidoReservado)
                    {
                        urlRedireccionar = Url.Action("PedidoValidado", "Pedido", new { area = area });
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                mensaje = "Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.";
            }

            return estado;
        }

        private BEEstrategia FiltrarEstrategiaPedido(string estrategiaId, int flagNueva = 0)
        {
            List<BEEstrategia> lst;

            var entidad = new BEEstrategia
            {
                PaisID = userData.PaisID,
                EstrategiaID = Convert.ToInt32(estrategiaId),
                FlagNueva = flagNueva
            };

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.FiltrarEstrategiaPedido(entidad).ToList();
            }

            var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var estrategia = lst.Count > 0 ? lst[0] : new BEEstrategia();
            estrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, estrategia.ImagenURL);
            estrategia.Simbolo = userData.Simbolo;

            return estrategia;

        }

        private string ValidarStockEstrategia(string cuv, int cantidad, int tipoOferta)
        {
            var mensaje = "";
            try
            {
                var entidad = new BEEstrategia
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
        #endregion

        #region FichaProducto VirtualCoach
        [HttpPost]
        public JsonResult AgregarProductoVC(string listaCuvTonos, string FlagNueva, string Cantidad, string OrigenPedidoWeb, string ClienteID_ = "")
        {
            try
            {
                string mensaje = "", urlRedireccionar = "";

                #region SesiónExpirada
                if (userData == null)
                {
                    mensaje = "Sesión expirada.";
                    urlRedireccionar = Url.Action("Index", "Login");
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        urlRedireccionar
                    }, JsonRequestBehavior.AllowGet);

                }
                #endregion

                #region ReservadoOEnHorarioRestringido
                var horario = ReservadoOEnHorarioRestringido(ref mensaje, ref urlRedireccionar);
                if (horario)
                {
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        urlRedireccionar
                    }, JsonRequestBehavior.AllowGet);
                }
                #endregion

                #region FiltrarPedido
                FlagNueva = Util.Trim(FlagNueva);
                var indFlagNueva = 0;
                Int32.TryParse(FlagNueva == "" ? "0" : FlagNueva, out indFlagNueva);
                var ficha = (FichaProductoDetalleModel)Session[Constantes.SessionNames.FichaProductoTemporal];
                #endregion

                var numero = Convert.ToInt32(Cantidad);

                if (numero > ficha.LimiteVenta)
                {
                    mensaje = "La cantidad no debe ser mayor que la cantidad limite ( " + ficha.LimiteVenta + " ).";
                    return Json(new
                    {
                        success = false,
                        message = mensaje
                    }, JsonRequestBehavior.AllowGet);
                }

                var descripcion = ficha.DescripcionCompleta;
                if (ficha.FlagNueva == 1)
                {
                    descripcion = ficha.DescripcionCortada;
                }

                listaCuvTonos = Util.Trim(listaCuvTonos);
                if (listaCuvTonos == "")
                {
                    listaCuvTonos = ficha.CUV2;
                }

                var tonos = listaCuvTonos.Split('|');
                var respuesta = new JsonResult();
                foreach (var tono in tonos)
                {
                    var listSp = tono.Split(';');
                    ficha.CUV2 = listSp.Length > 0 ? listSp[0] : ficha.CUV2;
                    if (ficha.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
                    {
                        var brother = ficha.Hermanos.Select(m => m.Hermanos.Where(s => s.CUV == listSp[0])).SingleOrDefault();
                        if (brother != null)
                        {
                            descripcion = brother.Select(m => m.DescripcionComercial).SingleOrDefault();
                        }
                    }

                    respuesta = AgregarProductoZE(ficha.MarcaID.ToString(), ficha.CUV2, ficha.Precio2.ToString(), descripcion, Cantidad, ficha.IndicadorMontoMinimo.ToString(), ficha.CodigoEstrategia, OrigenPedidoWeb, ClienteID_, ficha.TipoEstrategiaImagenMostrar);
                }

                return Json(respuesta.Data, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrio un error, vuelva ha intentalo."
                });
            }
        }

        #endregion
        

        private PartialSectionBpt GetPartialSectionBptModel()
        {
            var partial = new PartialSectionBpt();

            try
            {
                partial.RevistaDigital = revistaDigital;

                if (revistaDigital.TieneRDC)
                {
                    if (revistaDigital.EsActiva)
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DPedidoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DPedidoNoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                    else
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DPedidoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DPedidoNoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                }
                else if (revistaDigital.TieneRDR)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RDR.DPedidoRdr) ?? new ConfiguracionPaisDatosModel();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return partial;
        }
    }
}
