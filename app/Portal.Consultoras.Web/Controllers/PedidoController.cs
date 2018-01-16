using AutoMapper;
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
        private readonly int CUV_NO_TIENE_CREDITO = 2;
        private readonly int CODIGO_REVISTA_IMPRESA = 24;


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

                TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
                DateTime diaActual = DateTime.Today.Add(HoraCierrePortal);
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
                if (model.PedidoWebDetalle.Count != 0)
                {
                    if (userData.PedidoID == 0)
                    {
                        userData.PedidoID = model.PedidoWebDetalle[0].PedidoID;
                        SetUserData(userData);
                    }
                }

                #endregion

                #region Mensaje Guardar Colombia

                if (userData.CodigoISO == Constantes.CodigosISOPais.Colombia)
                {
                    List<BETablaLogicaDatos> tabla;
                    using (SACServiceClient sac = new SACServiceClient())
                    {
                        tabla = sac.GetTablaLogicaDatos(userData.PaisID, 27).ToList();
                    }

                    model.MensajeGuardarColombia = tabla != null && tabla.Count != 0
                        ? tabla[0].Descripcion
                        : string.Empty;
                }
                else
                {
                    model.MensajeGuardarColombia = string.Empty;
                }

                #endregion

                #region Banners

                string urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
                string urlProdDesc = WebConfigurationManager.AppSettings["ProdDesc"] + "/" + userData.CodigoISO;
                string banner01 = WebConfigurationManager.AppSettings["banner_01"];
                string banner02 = WebConfigurationManager.AppSettings["banner_02"];
                string banner03 = WebConfigurationManager.AppSettings["banner_03"];

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

                string nombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre;
                model.SobreNombre = Util.SubStrCortarNombre(nombreConsultora, 8).ToUpper();

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
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
                    string paisesConsultoraOnline = GetPaisesConConsultoraOnlineFromConfig();
                    if (paisesConsultoraOnline.Contains(userData.CodigoISO))
                    {
                        if (userData.TipoUsuario == Constantes.TipoUsuario.Consultora)
                        {
                            using (var svc = new UsuarioServiceClient())
                            {
                                var CantPedidosPendientes = svc.GetCantidadSolicitudesPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                                if (CantPedidosPendientes > 0)
                                {
                                    ViewBag.MostrarPedidosPendientes = "1";

                                    using (SACServiceClient sv = new SACServiceClient())
                                    {
                                        List<BEMotivoSolicitud> motivoSolicitud = sv.GetMotivosRechazo(userData.PaisID).ToList();
                                        ViewBag.MotivosRechazo = Mapper.Map<List<MisPedidosMotivoRechazoModel>>(motivoSolicitud);
                                    }
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
                model.RevistaDigital = revistaDigital;

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
            BEConfiguracionCampania configuracionCampania = null;

            if (userData.TipoUsuario == Constantes.TipoUsuario.Consultora)
            {
                using (var pedidoServiceClient = new PedidoServiceClient())
                {
                    var ConsultoraID = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID;
                    configuracionCampania = pedidoServiceClient.GetEstadoPedido(userData.PaisID, userData.CampaniaID, ConsultoraID, userData.ZonaID, userData.RegionID);
                }

                return configuracionCampania;
            }
            
            configuracionCampania = new BEConfiguracionCampania();
            configuracionCampania.CampaniaID = userData.CampaniaID;
            configuracionCampania.EstadoPedido = Constantes.EstadoPedido.Pendiente;
            configuracionCampania.ModificaPedidoReservado = false;
            configuracionCampania.ZonaValida = false;
            configuracionCampania.CampaniaDescripcion = Convert.ToString(userData.CampaniaID);

            return configuracionCampania;
        }

        public ActionResult virtualCoach(string param = "")
        {
            if (Request.Browser.IsMobileDevice)
            {
                return RedirectToAction("virtualCoach", new RouteValueDictionary(new { controller = "Pedido", area = "Mobile", param = param }));
            }
            try
            {
                string cuv = String.Empty;
                string campanaId = "0";
                int campana = 0;
                cuv = param.Substring(0, 5);
                campanaId = param.Substring(5, 6);
                campana = Convert.ToInt32(campanaId);
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
            UsuarioModel usuario = userData;
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
            DateTime fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

            usuario.DiaPROL = (usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) < fechaHoraActual
                && fechaHoraActual < usuario.FechaFinCampania.AddDays(1));

            usuario.MostrarBotonValidar = EsHoraReserva(usuario, fechaHoraActual);
        }

        private bool EsHoraReserva(UsuarioModel usuario, DateTime fechaHora)
        {
            if (!usuario.DiaPROL)
                return false;

            TimeSpan HoraNow = new TimeSpan(fechaHora.Hour, fechaHora.Minute, 0);
            bool esHorarioReserva = (fechaHora < usuario.FechaInicioCampania) ?
                (HoraNow > usuario.HoraInicioPreReserva && HoraNow < usuario.HoraFinPreReserva) :
                (HoraNow > usuario.HoraInicioReserva && HoraNow < usuario.HoraFinReserva);

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
                if (!string.IsNullOrEmpty(model.ClienteID))
                {
                    int ClienteID = Convert.ToInt32(model.ClienteID);

                    if (ClienteID > 0)
                    {
                        using (ClienteServiceClient service = new ClienteServiceClient())
                        {
                            var cliente = service.SelectByConsultoraByCodigo(userData.PaisID, userData.ConsultoraID, ClienteID, 0);
                            if (cliente.TieneTelefono == 0)
                            {
                                return Json(new
                                {
                                    success = false,
                                    message = "Debe actualizar los datos del cliente.",
                                    errorCliente = true
                                });
                            }
                        }
                    }
                }

                #region validar cuv de inicio obligatorio
                List<BEPedidoWebDetalle> olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                if (EsConsultoraNueva())
                {
                    var detCuv = olstPedidoWebDetalle.FirstOrDefault(d => d.CUV == model.CUV) ?? new BEPedidoWebDetalle();
                    detCuv.CUV = Util.SubStr(detCuv.CUV, 0);
                    if (detCuv.CUV != "")
                    {
                        BEConfiguracionProgramaNuevas oBEConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas("ConfiguracionProgramaNuevas");
                        if (oBEConfiguracionProgramaNuevas.IndProgObli == "1" && oBEConfiguracionProgramaNuevas.CUVKit == model.CUV)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "Ocurrió un error al ejecutar la operación.",
                                errorInsertarProducto = "1"
                            });
                        }
                    }
                }

                #endregion

                PedidoWebDetalleModel pedidoWebDetalleModel = new PedidoWebDetalleModel();

                BEPedidoWebDetalle oBePedidoWebDetalle = new BEPedidoWebDetalle();
                oBePedidoWebDetalle.IPUsuario = userData.IPUsuario;
                oBePedidoWebDetalle.CampaniaID = userData.CampaniaID;
                oBePedidoWebDetalle.ConsultoraID = userData.ConsultoraID;
                oBePedidoWebDetalle.PaisID = userData.PaisID;
                oBePedidoWebDetalle.TipoOfertaSisID = model.TipoOfertaSisID;
                oBePedidoWebDetalle.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
                oBePedidoWebDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);
                oBePedidoWebDetalle.PedidoID = userData.PedidoID;
                oBePedidoWebDetalle.OfertaWeb = model.OfertaWeb;
                oBePedidoWebDetalle.IndicadorMontoMinimo = Convert.ToInt32(model.IndicadorMontoMinimo);
                oBePedidoWebDetalle.SubTipoOfertaSisID = 0;
                oBePedidoWebDetalle.EsSugerido = model.EsSugerido;
                oBePedidoWebDetalle.EsKitNueva = model.EsKitNueva;

                oBePedidoWebDetalle.MarcaID = Convert.ToByte(model.MarcaID);
                oBePedidoWebDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                oBePedidoWebDetalle.PrecioUnidad = model.PrecioUnidad;
                oBePedidoWebDetalle.CUV = model.CUV;

                oBePedidoWebDetalle.OrigenPedidoWeb = model.OrigenPedidoWeb;

                oBePedidoWebDetalle.DescripcionProd = model.DescripcionProd;
                oBePedidoWebDetalle.ImporteTotal = oBePedidoWebDetalle.Cantidad * oBePedidoWebDetalle.PrecioUnidad;
                oBePedidoWebDetalle.Nombre = oBePedidoWebDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;

                bool errorServer;
                string tipo;
                bool modificoBackOrder;
                olstPedidoWebDetalle = AdministradorPedido(oBePedidoWebDetalle, "I", out errorServer, out tipo, out modificoBackOrder);

                decimal total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                string formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

                var listaCliente = new List<BECliente>();
                if (model.ClienteID_ != "-1")
                {
                    listaCliente = olstPedidoWebDetalle
                        .Select(item => new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre })
                        .GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                    listaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });
                }

                pedidoWebDetalleModel = Mapper.Map<BEPedidoWebDetalle, PedidoWebDetalleModel>(oBePedidoWebDetalle);
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

        public JsonResult CambiarCliente(string ClienteID)
        {
            try
            {
                List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
                var model = new PedidoSb2Model();

                olstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                model.Total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);

                decimal totalCliente = 0;
                if (ClienteID != "-1")
                {
                    olstPedidoWebDetalle = (from item in olstPedidoWebDetalle
                                            where item.ClienteID == Convert.ToInt16(ClienteID)
                                            select item).ToList();
                    totalCliente = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                    model.TotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                }
                else
                    model.TotalCliente = "";

                int cantidadTotal = olstPedidoWebDetalle.Count;

                string Paginas = (olstPedidoWebDetalle.Count % 100 == 0) ? (olstPedidoWebDetalle.Count / 100).ToString() : ((int)(olstPedidoWebDetalle.Count / 100) + 1).ToString();

                if (Paginas == "0")
                    model.Pagina = "0";
                else
                    model.Pagina = "1";

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

                model.PaginaDe = Paginas;
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
            bool Result = true;
            string Mensaje = string.Empty;
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.InsLogIngresoFAD(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, model.CUV, 1, model.PrecioUnidad, userData.ZonaID);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                Result = false;
                Mensaje = "Error (FAD): Volver a intentar.";
            }

            return Json(new
            {
                success = Result,
                message = Mensaje,
                extra = ""
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Update(PedidoWebDetalleModel model)
        {
            if (model.ClienteID > 0)
            {
                using (ClienteServiceClient service = new ClienteServiceClient())
                {
                    var cliente = service.SelectByConsultoraByCodigo(userData.PaisID, userData.ConsultoraID, model.ClienteID, 0);
                    if (cliente.TieneTelefono == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Debe actualizar los datos del cliente.",
                            errorCliente = true
                        });
                    }
                }
            }

            string message = string.Empty;
            BEPedidoWebDetalle oBEPedidoWebDetalle = new BEPedidoWebDetalle();
            oBEPedidoWebDetalle.PaisID = userData.PaisID;
            oBEPedidoWebDetalle.CampaniaID = model.CampaniaID;
            oBEPedidoWebDetalle.PedidoID = model.PedidoID;
            oBEPedidoWebDetalle.PedidoDetalleID = Convert.ToInt16(model.PedidoDetalleID);
            oBEPedidoWebDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
            oBEPedidoWebDetalle.PrecioUnidad = model.PrecioUnidad;
            oBEPedidoWebDetalle.ClienteID = string.IsNullOrEmpty(model.Nombre) ? (short)0 : Convert.ToInt16(model.ClienteID);

            oBEPedidoWebDetalle.CUV = model.CUV;
            oBEPedidoWebDetalle.TipoOfertaSisID = model.TipoOfertaSisID;
            oBEPedidoWebDetalle.Stock = model.Stock;
            oBEPedidoWebDetalle.Flag = model.Flag;

            oBEPedidoWebDetalle.DescripcionProd = model.DescripcionProd;
            oBEPedidoWebDetalle.ImporteTotal = oBEPedidoWebDetalle.Cantidad * oBEPedidoWebDetalle.PrecioUnidad;
            oBEPedidoWebDetalle.Nombre = oBEPedidoWebDetalle.ClienteID == 0 ? userData.NombreConsultora : model.Nombre;

            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();

            bool ErrorServer;
            string tipo;
            bool modificoBackOrder;

            olstPedidoWebDetalle = AdministradorPedido(oBEPedidoWebDetalle, "U", out ErrorServer, out tipo, out modificoBackOrder);

            decimal Total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            string formatoTotal = Util.DecimalToStringFormat(Total, userData.CodigoISO);

            string TotalFormato = formatoTotal;
            decimal totalCliente = 0;
            string Total_Cliente = "";

            if (model.ClienteID_ != "-1")
            {
                olstPedidoWebDetalle = (from item in olstPedidoWebDetalle
                                        where item.ClienteID == Convert.ToInt16(model.ClienteID_)
                                        select item).ToList();
                totalCliente = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                Total_Cliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
            }

            message = !ErrorServer ? "El registro ha sido actualizado de manera exitosa."
                        : tipo.Length > 1 ? tipo
                        : "Hubo un problema al intentar actualizar el registro. Por favor inténtelo nuevamente.";

            return Json(new
            {
                success = !ErrorServer,
                message,
                Total,
                TotalFormato,
                Total_Cliente,
                model.ClienteID_,
                userData.Simbolo,
                extra = "",
                tipo,
                modificoBackOrder,
                DataBarra = !ErrorServer ? GetDataBarra() : new BarraConsultoraModel(),
                cantidadTotalProductos = ObtenerPedidoWebDetalle().Sum(x => x.Cantidad)
            }, JsonRequestBehavior.AllowGet);
        }

        private PedidoDetalleModel DeletePedido(BEPedidoWebDetalle obe)
        {
            string mensaje = string.Empty;
            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
            PedidoModelo.Simbolo = userData.Simbolo;
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            if (sessionManager.GetObservacionesProl() != null)
            {
                List<ObservacionModel> Observaciones = sessionManager.GetObservacionesProl();
                List<ObservacionModel> Obs = Observaciones.Where(p => p.CUV == obe.CUV).ToList();
                if (Obs.Count != 0)
                {
                    obe.Mensaje = Obs[0].Descripcion;
                }

            }

            bool ErrorServer = false;
            string tipo = "";
            bool modificoBackOrder;

            if (ReservadoEnHorarioRestringido(out mensaje))
            {
                ModelState.AddModelError("", mensaje);
                olstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                PedidoModelo.ListaDetalle = olstPedidoWebDetalle;
                PedidoModelo.Total = string.Format("{0:N2}", olstPedidoWebDetalle.Sum(p => p.ImporteTotal));

                PedidoModelo.MensajeError = mensaje;
                return PedidoModelo;
            }

            olstPedidoWebDetalle = AdministradorPedido(obe, "D", out ErrorServer, out tipo, out modificoBackOrder);

            return PedidoModelo;
        }

        [HttpPost]
        public JsonResult Delete(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad, string ClienteID, string CUVReco, bool EsBackOrder)
        {
            try
            {
                List<BEPedidoWebDetalle> ListaPedidoWebDetalle = sessionManager.GetDetallesPedido() ?? new List<BEPedidoWebDetalle>();
                BEPedidoWebDetalle pedidoEliminado = ListaPedidoWebDetalle.FirstOrDefault(x => x.CUV == CUV);
                if (pedidoEliminado == null) return ErrorJson(Constantes.MensajesError.DeletePedido_CuvNoExiste);

                pedidoEliminado.DescripcionOferta = !string.IsNullOrEmpty(pedidoEliminado.DescripcionOferta)
                    ? pedidoEliminado.DescripcionOferta.Replace("[", "").Replace("]", "").Trim() : "";

                BEPedidoWebDetalle obe = new BEPedidoWebDetalle();
                obe.PaisID = userData.PaisID;
                obe.CampaniaID = CampaniaID;
                obe.PedidoID = PedidoID;
                obe.PedidoDetalleID = PedidoDetalleID;
                obe.TipoOfertaSisID = TipoOfertaSisID;
                obe.CUV = CUV;
                obe.Cantidad = Cantidad;
                obe.Mensaje = string.Empty;

                if (EsBackOrder) obe.Mensaje = Constantes.BackOrder.LogAccionCancelar;
                else if (sessionManager.GetObservacionesProl() != null)
                {
                    List<ObservacionModel> Observaciones = sessionManager.GetObservacionesProl();
                    List<ObservacionModel> Obs = Observaciones.Where(p => p.CUV == CUV).ToList();
                    if (Obs.Count != 0) obe.Mensaje = Obs[0].Descripcion;
                }

                bool ErrorServer;
                string tipo;
                bool modificoBackOrder;
                var olstPedidoWebDetalle = AdministradorPedido(obe, "D", out ErrorServer, out tipo, out modificoBackOrder);

                decimal total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                string formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);
                decimal totalCliente = 0;
                string formatoTotalCliente = "";

                if (!olstPedidoWebDetalle.Any())
                {
                    if (userData.ZonaValida)
                    {
                        using (ServicePROL.ServiceStockSsic sv = new ServicePROL.ServiceStockSsic())
                        {
                            sv.Url = ConfigurarUrlServiceProl();
                            sv.wsDesReservarPedido(userData.CodigoConsultora, userData.CodigoISO);
                        }
                    }
                }
                else
                {
                    if (ClienteID != "-1")
                    {
                        List<BEPedidoWebDetalle> lstTemp = (from item in olstPedidoWebDetalle
                                                            where item.ClienteID == Convert.ToInt16(ClienteID)
                                                            select item).ToList();

                        totalCliente = lstTemp.Sum(p => p.ImporteTotal);
                        formatoTotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                    }
                    else formatoTotalCliente = "";
                }

                List<BECliente> listaCliente;
                listaCliente = olstPedidoWebDetalle
                    .Select(item => new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre })
                    .GroupBy(x => x.ClienteID).Select(x => x.First())
                    .ToList();
                listaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });
                Session[Constantes.ConstSession.ListaEstrategia] = null;

                var message = !ErrorServer ? "OK"
                            : tipo.Length > 1 ? tipo
                            : "Ocurrió un error al ejecutar la operación.";

                return Json(new
                {
                    success = !ErrorServer,
                    message,
                    formatoTotal,
                    total,
                    formatoTotalCliente,
                    listaCliente,
                    tipo,
                    DataBarra = !ErrorServer ? GetDataBarra() : new BarraConsultoraModel(),
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

        [HttpPost]
        public JsonResult DeleteAll()
        {
            bool ErrorServer = false;
            bool EliminacionMasiva = false;
            string message = string.Empty;

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

                List<BEPedidoWebDetalle> olstTempListado = new List<BEPedidoWebDetalle>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    EliminacionMasiva = sv.DelPedidoWebDetalleMasivo(userData.PaisID, userData.CampaniaID, userData.PedidoID, userData.CodigoUsuario);
                }
                if (EliminacionMasiva)
                {
                    sessionManager.SetPedidoWeb(null);
                    sessionManager.SetDetallesPedido(null);
                    Session[Constantes.ConstSession.ListaEstrategia] = null;

                    UpdPedidoWebMontosPROL();

                    if (userData.ZonaValida)
                    {
                        using (ServicePROL.ServiceStockSsic sv = new ServicePROL.ServiceStockSsic())
                        {
                            sv.Url = ConfigurarUrlServiceProl();
                            sv.wsDesReservarPedido(userData.CodigoConsultora, userData.CodigoISO);
                        }
                    }
                }
                else
                {
                    ErrorServer = true;
                    message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ErrorServer = true;
                message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            }

            return Json(new
            {
                success = !ErrorServer,
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
                BEPedidoWebDetalle oBEPedidoWebDetalle = new BEPedidoWebDetalle
                {
                    PaisID = userData.PaisID,
                    CampaniaID = campaniaID,
                    PedidoID = pedidoID,
                    PedidoDetalleID = pedidoDetalleID
                };
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.AceptarBackOrderPedidoWebDetalle(oBEPedidoWebDetalle);
                }

                decimal total = 0;
                string formatoTotal = "";
                decimal totalCliente = 0;
                string formatoTotalCliente = "";

                sessionManager.SetDetallesPedido(null);
                var olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

                if (olstPedidoWebDetalle.Any())
                {
                    if (clienteID != "-1")
                    {
                        List<BEPedidoWebDetalle> lstTemp = (from item in olstPedidoWebDetalle
                                                            where item.ClienteID == Convert.ToInt16(clienteID)
                                                            select item).ToList();
                        totalCliente = lstTemp.Sum(p => p.ImporteTotal);
                        formatoTotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                    }
                    else formatoTotalCliente = "";
                }

                List<BECliente> listaCliente;
                listaCliente = (from item in olstPedidoWebDetalle
                                select new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre }
                                                        ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                listaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });

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

        #endregion

        #region Ofertas Flexipago

        public string CargarLinkPaisFlexipago()
        {
            string linkFlexipago = "";
            try
            {
                BEOfertaFlexipago entidad;
                using (PedidoServiceClient svc = new PedidoServiceClient())
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
                int vPaisID = userData.PaisID;
                string consultora = userData.CodigoConsultora;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    int CampaniaID = userData.CampaniaID;
                    BEOfertaFlexipago oBe = svc.GetLineaCreditoFlexipago(vPaisID, consultora, CampaniaID);
                    if (vPaisID == 4)
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
            string mensaje = "";
            bool resul = false;
            try
            {
                var entidad = new BEEstrategia();
                entidad.PaisID = userData.PaisID;

                int iCantidad = 0;
                if (int.TryParse(Cantidad, out iCantidad))
                    entidad.Cantidad = iCantidad;
                else
                    entidad.Cantidad = 0;

                int iTipoOferta = 0;
                if (int.TryParse(TipoOferta, out iTipoOferta))
                    entidad.FlagCantidad = iTipoOferta;
                else
                    entidad.FlagCantidad = 0;

                entidad.CUV2 = CUV;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.ConsultoraID = userData.ConsultoraID.ToString();

                mensaje = ValidarMontoMaximo(Convert.ToDecimal(PrecioUnidad), entidad.Cantidad, out resul);

                if (mensaje == "" || resul)
                {
                    using (PedidoServiceClient svc = new PedidoServiceClient())
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
                var packNuevas = lstPedidoWebDetalle.Where(x => x.FlagNueva).ToList();

                foreach (var item in packNuevas)
                {
                    if (!item.EsOfertaIndependiente)
                    {
                        DeletePedido(item);
                    }
                }
                sessionManager.SetDetallesPedido(null);
            }
        }
        #endregion

        #region Autocompletes

        public ActionResult AutocompleteByProductoCUV(string term)
        {
            var productos = new List<BEProducto>();
            var productosModel = new List<ProductoModel>();

            try
            {
                var userModel = userData;
                productos = SelectProductoByCodigoDescripcionSearchRegionZona(term, userModel, 10, CRITERIO_BUSQUEDA_CUV_PRODUCTO);

                if (revistaDigital.BloqueoRevistaImpresa && revistaDigital.EsActiva)
                {
                    productos = productos.Where(x => x.CodigoCatalogo != CODIGO_REVISTA_IMPRESA).ToList();
                }

                productos = productos.Take(CANTIDAD_FILAS_AUTOCOMPLETADO).ToList();

                if (!productos.Any())
                {
                    productosModel.Add(GetProductoNoExiste());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                var codigoEstrategia = Util.Trim(productos.First().TipoEstrategiaCodigo);
                if (NoEstaInscritaEnRevistaDigital(codigoEstrategia))
                {
                    productosModel.Add(GetProductoInscribeteEnRevistaDigital());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                string cuv = productos.First().CUV.Trim();
                var mensajeByCuv = GetMensajeByCUV(userModel, cuv);
                var tieneRDC = revistaDigital.TieneRDC &&
                    revistaDigital.EsActiva;

                foreach (var prod in productos)
                {
                    productosModel.Add(new ProductoModel()
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
                        TieneRDC = tieneRDC,
                        EsOfertaIndependiente = prod.EsOfertaIndependiente
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
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

        private ProductoModel GetProductoNoExiste()
        {
            return new ProductoModel()
            {
                MarcaID = 0,
                CUV = "El producto solicitado no existe.",
                TieneSugerido = 0
            };
        }

        private bool NoEstaInscritaEnRevistaDigital(string codigoEstrategia)
        {
            return (Constantes.TipoEstrategiaCodigo.Lanzamiento == codigoEstrategia
                                || Constantes.TipoEstrategiaCodigo.OfertasParaMi == codigoEstrategia
                                || Constantes.TipoEstrategiaCodigo.PackAltoDesembolso == codigoEstrategia)
                                && !revistaDigital.TieneRDR
                                && !revistaDigital.TieneRDC;
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

        private BEMensajeCUV GetMensajeByCUV(UsuarioModel userModel, string cuv)
        {
            var mensajeByCuv = new BEMensajeCUV();
            using (var odsServiceClient = new ODSServiceClient())
            {
                mensajeByCuv = odsServiceClient.GetMensajeByCUV(userModel.PaisID, userModel.CampaniaID, cuv);
            }

            return mensajeByCuv;
        }



        public ActionResult FindByCUV(PedidoDetalleModel model)
        {
            var productos = new List<BEProducto>();
            var productosModel = new List<ProductoModel>();
            try
            {
                var userModel = userData;
                productos = SelectProductoByCodigoDescripcionSearchRegionZona(model.CUV, userModel, 1, CRITERIO_BUSQUEDA_CUV_PRODUCTO);

                if (!productos.Any())
                {
                    productosModel.Add(GetProductoNoExiste());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                if (revistaDigital.BloqueoRevistaImpresa && revistaDigital.EsActiva)
                {
                    productos = productos.Where(x => x.CodigoCatalogo != CODIGO_REVISTA_IMPRESA).ToList();

                    if (!productos.Any())
                    {
                        productosModel.Add(GetProductoNoExisteEnEsikaParaMi());
                        return Json(productosModel, JsonRequestBehavior.AllowGet);
                    }
                }

                var codigoEstrategia = Util.Trim(productos.First().TipoEstrategiaCodigo);
                if (NoEstaInscritaEnRevistaDigital(codigoEstrategia))
                {
                    productosModel.Add(GetProductoInscribeteEnRevistaDigital());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }


                var estrategias = (List<BEEstrategia>)Session[Constantes.ConstSession.ListaEstrategia] ?? new List<BEEstrategia>();
                var estrategia = estrategias.FirstOrDefault(p => p.CUV2 == model.CUV) ?? new BEEstrategia();
                if (estrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                {
                    productosModel.Add(GetProductoNoExiste());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                var cuvCredito = ValidarCUVCreditoPorCUVRegular(model, userModel);
                
                string ObservacionCUV = ObtenerObservacionCreditoCuv(userModel, cuvCredito);
                
                if (cuvCredito.IdMensaje == CUV_NO_TIENE_CREDITO)
                {
                    productosModel.Add(GetProductoCuvRegular(cuvCredito));
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                string cuv = productos.First().CUV.Trim();
                var mensajeByCuv = GetMensajeByCUV(userModel, cuv);

                var tieneRDC = revistaDigital.TieneRDC && revistaDigital.EsActiva;

                int? revistaGana = ValidarDesactivaRevistaGana(userModel);

                productosModel.Add(new ProductoModel()
                {
                    CUV = productos[0].CUV.Trim(),
                    Descripcion = productos[0].Descripcion.Trim(),
                    PrecioCatalogo = productos[0].PrecioCatalogo,
                    MarcaID = productos[0].MarcaID,
                    EstaEnRevista = productos[0].EstaEnRevista,
                    TieneStock = productos[0].TieneStock,
                    EsExpoOferta = productos[0].EsExpoOferta,
                    CUVRevista = productos[0].CUVRevista.Trim(),
                    CUVComplemento = productos[0].CUVComplemento.Trim(),
                    IndicadorMontoMinimo = productos[0].IndicadorMontoMinimo.ToString().Trim(),
                    TipoOfertaSisID = productos[0].TipoOfertaSisID,
                    ConfiguracionOfertaID = productos[0].ConfiguracionOfertaID,
                    ObservacionCUV = ObservacionCUV,
                    MensajeCUV = mensajeByCuv.Mensaje,
                    DesactivaRevistaGana = revistaGana,
                    DescripcionMarca = productos[0].DescripcionMarca,
                    DescripcionEstrategia = productos[0].DescripcionEstrategia,
                    DescripcionCategoria = productos[0].DescripcionCategoria,
                    FlagNueva = productos[0].FlagNueva,
                    TipoEstrategiaID = productos[0].TipoEstrategiaID,
                    TieneSugerido = productos[0].TieneSugerido,
                    CodigoProducto = productos[0].CodigoProducto,
                    LimiteVenta = estrategia != null ? estrategia.LimiteVenta : 99,
                    EsOfertaIndependiente = estrategia.EsOfertaIndependiente,
                    TieneRDC = tieneRDC
                });

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo.", TieneSugerido = 0 });
            }

            return Json(productosModel, JsonRequestBehavior.AllowGet);

        }

        private ProductoModel GetProductoNoExisteEnEsikaParaMi()
        {
            return new ProductoModel()
            {
                MarcaID = 0,
                CUV = "Los códigos de la guía impresa no están disponibles para ti. Accede a tus ofertas digitales.",
                TieneSugerido = 0
            };
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
                ? userModel.PrimerNombre.ToString()
                    + " tienes el beneficio de pagar en 2 partes el valor de este SET de productos. Si lo deseas ingresa este código al pedir el set: "
                    + cuvCredito.CuvCredito
                : string.Empty;
        }

        private ProductoModel GetProductoCuvRegular(BECUVCredito cuvCredito)
        {
            return new ProductoModel() { MarcaID = 0, CUV = "Código incorrecto, Para solicitar el set: ingresa el código " + cuvCredito.CuvRegular, TieneSugerido = 0 };
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
            List<BEProducto> listaProduto = new List<BEProducto>();
            List<ProductoModel> listaProductoModel = new List<ProductoModel>();

            try
            {
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    listaProduto = sv.GetProductoSugeridoByCUV(userData.PaisID, userData.CampaniaID, Convert.ToInt32(userData.ConsultoraID), CUV, userData.RegionID,
                        userData.ZonaID, userData.CodigorRegion, userData.CodigoZona).ToList();
                }

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                var listaTieneStock = new List<Lista>();

                if (esFacturacion)
                {
                    string codigoSap = "";                    
                    foreach (var beProducto in listaProduto)
                    {
                        if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                        {
                            codigoSap += beProducto.CodigoProducto + "|";
                        }
                    }

                    codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                    try
                    {
                        if (!string.IsNullOrEmpty(codigoSap))
                        {
                            using (var sv = new ServicePROLConsultas.wsConsulta())
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
                    bool tieneStockProl = true;
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
            resultado = 0;

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                idPais = sv.GetPaisBannerMarquesina(CampaniaID, Convert.ToInt32(IdBanner));
            }

            if (idPais != 0)
            {
                using (PedidoServiceClient sv2 = new PedidoServiceClient())
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

        [HttpPost]
        public JsonResult InsertarPedidoCuvBanner(string CUV, int CantCUVpedido)
        {
            List<BEProducto> olstProducto = new List<BEProducto>();
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();

            UsuarioModel oUsuarioModel = userData;
            try
            {
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, CUV, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 1, false).ToList();
                }

                if (olstProducto.Count == 0)
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe." });
                    return Json(new
                    {
                        success = false,
                        message = "El producto solicitado no existe.",
                        oPedidoDetalle = ""
                    });
                }

                var strCUV = CUV;

                List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();

                BEPedidoWebDetalle oBEPedidoWebDetalle = new BEPedidoWebDetalle();
                oBEPedidoWebDetalle.IPUsuario = oUsuarioModel.IPUsuario;
                oBEPedidoWebDetalle.CampaniaID = oUsuarioModel.CampaniaID;
                oBEPedidoWebDetalle.ConsultoraID = oUsuarioModel.ConsultoraID;
                oBEPedidoWebDetalle.PaisID = oUsuarioModel.PaisID;
                oBEPedidoWebDetalle.TipoOfertaSisID = 1700;
                oBEPedidoWebDetalle.ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID;
                oBEPedidoWebDetalle.ClienteID = (short)0;
                oBEPedidoWebDetalle.PedidoID = oUsuarioModel.PedidoID;
                oBEPedidoWebDetalle.OfertaWeb = false;
                oBEPedidoWebDetalle.IndicadorMontoMinimo = Convert.ToInt32(olstProducto[0].IndicadorMontoMinimo.ToString().Trim());
                oBEPedidoWebDetalle.SubTipoOfertaSisID = Convert.ToInt32(0);

                oBEPedidoWebDetalle.MarcaID = Convert.ToByte(olstProducto[0].MarcaID);
                oBEPedidoWebDetalle.Cantidad = CantCUVpedido;
                oBEPedidoWebDetalle.PrecioUnidad = olstProducto[0].PrecioCatalogo;
                oBEPedidoWebDetalle.CUV = olstProducto[0].CUV.Trim();

                oBEPedidoWebDetalle.DescripcionProd = olstProducto[0].Descripcion.Trim();
                oBEPedidoWebDetalle.ImporteTotal = oBEPedidoWebDetalle.Cantidad * oBEPedidoWebDetalle.PrecioUnidad;
                oBEPedidoWebDetalle.Nombre = oUsuarioModel.NombreConsultora;
                oBEPedidoWebDetalle.DescripcionLarga = olstProducto[0].DescripcionMarca;
                oBEPedidoWebDetalle.DescripcionEstrategia = olstProducto[0].DescripcionEstrategia;
                oBEPedidoWebDetalle.Categoria = olstProducto[0].DescripcionCategoria;

                oBEPedidoWebDetalle.OrigenPedidoWeb = Constantes.OrigenPedidoWeb.BannerDesktopHome;

                IList<BEPedidoWebService> olstCuvMarquesina = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    olstCuvMarquesina = sv.GetPedidoCuvMarquesina(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, oUsuarioModel.ConsultoraID, strCUV);
                }

                bool ErrorServer;
                string tipo;
                bool modificoBackOrder;

                if (olstCuvMarquesina.Count == 0 || olstCuvMarquesina[0].CUV == "")
                {
                    olstPedidoWebDetalle = AdministradorPedido(oBEPedidoWebDetalle, "I", out ErrorServer, out tipo, out modificoBackOrder);
                }
                else
                {
                    oBEPedidoWebDetalle.PedidoID = olstCuvMarquesina[0].PedidoWebID;
                    oBEPedidoWebDetalle.PedidoDetalleID = Convert.ToInt16(olstCuvMarquesina[0].PedidoWebDetalleID);
                    oBEPedidoWebDetalle.Cantidad = oBEPedidoWebDetalle.Cantidad + olstCuvMarquesina[0].Cantidad;
                    olstPedidoWebDetalle = AdministradorPedido(oBEPedidoWebDetalle, "U", out ErrorServer, out tipo, out modificoBackOrder);
                }

                return Json(new
                {
                    success = !ErrorServer,
                    message = !ErrorServer ? ("Has agregado " + Convert.ToString(CantCUVpedido) + " unidad(es) del producto a tu pedido.")
                    : tipo.Length > 1 ? tipo : "Ocurrió un error al ejecutar la operación.",
                    oPedidoDetalle = oBEPedidoWebDetalle,
                    DataBarra = !ErrorServer ? GetDataBarra() : new BarraConsultoraModel(),
                    tipo
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, oUsuarioModel.CodigoConsultora, oUsuarioModel.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
                return Json(new
                {
                    success = false,
                    message = "Ha ocurrido un Error. Vuelva a intentarlo."
                });
            }
        }

        public ActionResult AutocompleteByProductoDescripcion(string term)
        {
            var productos = new List<BEProducto>();
            var productosModel = new List<ProductoModel>();
            try
            {
                var userModel = userData;
                productos = SelectProductoByCodigoDescripcionSearchRegionZona(term, userModel, 10, CRITERIO_BUSQUEDA_DESC_PRODUCTO);

                if (revistaDigital.BloqueoRevistaImpresa && revistaDigital.EsActiva)
                {
                    productos = productos.Where(x => x.CodigoCatalogo != CODIGO_REVISTA_IMPRESA).ToList();
                }

                productos = productos.Take(CANTIDAD_FILAS_AUTOCOMPLETADO).ToList();

                if (!productos.Any())
                {
                    productosModel.Add(GetProductoNoExiste());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                var codigoEstrategia = Util.Trim(productos.First().TipoEstrategiaCodigo);

                if (NoEstaInscritaEnRevistaDigital(codigoEstrategia))
                {
                    productosModel.Add(GetProductoInscribeteEnRevistaDigital());
                    return Json(productosModel, JsonRequestBehavior.AllowGet);
                }

                string cuv = productos.First().CUV.Trim();
                var BEMensajeCUV = GetMensajeByCUV(userModel, cuv);

                foreach (var item in productos)
                {
                    productosModel.Add(new ProductoModel()
                    {
                        CUV = item.CUV.Trim(),
                        Descripcion = item.Descripcion.Trim(),
                        PrecioCatalogo = item.PrecioCatalogo,
                        MarcaID = item.MarcaID,
                        EstaEnRevista = item.EstaEnRevista,
                        TieneStock = item.TieneStock,
                        EsExpoOferta = item.EsExpoOferta,
                        CUVRevista = item.CUVRevista.Trim(),
                        CUVComplemento = item.CUVComplemento.Trim(),
                        TipoOfertaSisID = item.TipoOfertaSisID,
                        ConfiguracionOfertaID = item.ConfiguracionOfertaID,
                        IndicadorMontoMinimo = productos[0].IndicadorMontoMinimo.ToString().Trim(),
                        MensajeCUV = BEMensajeCUV.Mensaje,
                        DescripcionMarca = item.DescripcionMarca,
                        DescripcionEstrategia = item.DescripcionEstrategia,
                        DescripcionCategoria = item.DescripcionCategoria,
                        TipoEstrategiaID = item.TipoEstrategiaID,
                        FlagNueva = item.FlagNueva,
                        TieneRDC = revistaDigital.TieneRDC && revistaDigital.EsActiva
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                productosModel.Add(new ProductoModel() { CUV = "0", Descripcion = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(productosModel, JsonRequestBehavior.AllowGet);
        }



        public ActionResult AutocompleteByCliente(string term)
        {
            List<ServiceCliente.BECliente> olstCliente = new List<ServiceCliente.BECliente>();
            List<ClienteModel> olstClienteModel = new List<ClienteModel>();
            try
            {
                using (ServiceCliente.ClienteServiceClient sv = new ServiceCliente.ClienteServiceClient())
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
            List<ServiceCliente.BECliente> olstCliente = new List<ServiceCliente.BECliente>();
            List<ClienteModel> olstClienteModel = new List<ClienteModel>();
            try
            {
                using (ServiceCliente.ClienteServiceClient sv = new ServiceCliente.ClienteServiceClient())
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
                var productosFaltantes = this.GetProductosFaltantes(cuv, descripcion);
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
            int vValidation = 0;
            try
            {
                ServiceCliente.BECliente entidad = Mapper.Map<PedidoDetalleModel, ServiceCliente.BECliente>(model);
                string ClienteId = string.Empty;
                using (ServiceCliente.ClienteServiceClient sv = new ServiceCliente.ClienteServiceClient())
                {
                    vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);

                    if (vValidation == 0)
                    {
                        entidad.PaisID = userData.PaisID;
                        entidad.ConsultoraID = userData.ConsultoraID;
                        entidad.Activo = true;
                        ClienteId = sv.InsertById(entidad).ToString();
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
                    extra = ClienteId
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

                BEResultadoReservaProl resultado = null;
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
                    if (resultado.Reserva) CambioBannerGPR(true);
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
                bool envioCorreo = false;
                var input = Mapper.Map<BEInputReservaProl>(userData);
                input.EsOpt = EsOpt();
                using (var sv = new PedidoServiceClient()) { envioCorreo = await sv.EnviarCorreoReservaProlAsync(input); }
                if (envioCorreo) return SuccessJson("Se envio el correo a la consultora.", true);
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
            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            DateTime diaActual = DateTime.Today.Add(HoraCierrePortal);

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
            short result = 0;
            string message = string.Empty;
            List<BEPedidoWebDetalle> olstPedidos = new List<BEPedidoWebDetalle>();
            try
            {
                foreach (var item in lista)
                {
                    BEPedidoWebDetalle oBEPedidoWebDetalle = new BEPedidoWebDetalle();
                    oBEPedidoWebDetalle.PaisID = userData.PaisID;
                    oBEPedidoWebDetalle.CampaniaID = userData.CampaniaID;
                    oBEPedidoWebDetalle.PedidoID = userData.PedidoID;
                    oBEPedidoWebDetalle.PedidoDetalleID = item.PedidoDetalleID;
                    oBEPedidoWebDetalle.Cantidad = Convert.ToInt32(item.Cantidad);
                    oBEPedidoWebDetalle.PrecioUnidad = item.PrecioUnidad;
                    oBEPedidoWebDetalle.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : item.ClienteID;
                    oBEPedidoWebDetalle.ImporteTotal = oBEPedidoWebDetalle.Cantidad * oBEPedidoWebDetalle.PrecioUnidad;
                    olstPedidos.Add(oBEPedidoWebDetalle);
                }

                int Clientes; decimal Importe;
                CalcularMasivo(ObtenerPedidoWebDetalle(), olstPedidos, out Clientes, out Importe);
                olstPedidos[0].Clientes = Clientes;
                olstPedidos[0].ImporteTotalPedido = Importe;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    result = sv.UpdPedidoWebDetalleMasivo(olstPedidos.ToArray());
                }

                message = result == 0 ? "Hubo un problema al intentar actualizar los registros. Por favor inténtelo nuevamente." : "Los registros han sido actualizados de manera exitosa.";

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

        private bool CambioBannerGPR(bool pedidoReservado)
        {
            if (userData.IndicadorGPRSB == 2)
            {
                userData.MostrarBannerRechazo = userData.RechazadoXdeuda;
                userData.CerrarRechazado = userData.RechazadoXdeuda ? 0 : 1;
                return true;
            }
            return false;
        }

        #region Campaña y Zona No Configurada

        public ActionResult CampaniaZonaNoConfigurada()
        {
            ViewBag.MensajeCampaniaZona = userData.CampaniaID == 0 ? "Campaña" : "Zona";
            ViewBag.CodigoIso = userData.CodigoISO;

            string urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
            string banner01 = WebConfigurationManager.AppSettings["banner_01"];
            string banner02 = WebConfigurationManager.AppSettings["banner_02"];
            string banner03 = WebConfigurationManager.AppSettings["banner_03"];

            ViewBag.UrlBanner01 = ConfigS3.GetUrlFileS3(urlCarpeta, banner01, String.Empty);
            ViewBag.UrlBanner02 = ConfigS3.GetUrlFileS3(urlCarpeta, banner02, String.Empty);
            ViewBag.UrlBanner03 = ConfigS3.GetUrlFileS3(urlCarpeta, banner03, String.Empty);

            return View();
        }

        #endregion

        #region Pedido Validado

        public ActionResult PedidoValidado()
        {
            BEConfiguracionCampania oBEConfiguracionCampania = null;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }
            if (oBEConfiguracionCampania != null)
            {
                if (oBEConfiguracionCampania.CampaniaID > userData.CampaniaID)
                    return RedirectToAction("Index");
            }

            List<BEPedidoWebDetalle> lstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
            }

            PedidoDetalleModel model = new PedidoDetalleModel();
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = PedidoJerarquico(lstPedidoWebDetalle);

            model.eMail = userData.EMail;
            ViewBag.Simbolo = model.Simbolo;
            ViewBag.Total_Minimo = model.Total_Minimo;
            ViewBag.CodigoISOPais = userData.CodigoISO;

            ViewBag.GananciaEstimada = Util.DecimalToStringFormat(0, userData.CodigoISO);
            ViewBag.PedidoProductoMovil = 0;
            if (lstPedidoWebDetalle.Count > 0)
            {
                ViewBag.PedidoProductoMovil = lstPedidoWebDetalle
                    .Where(p => p.TipoPedido.ToUpper().Trim() == "PNV")
                    .ToList().Any() ? 1 : 0;

                if (userData.PedidoID == 0)
                {
                    userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                    SetUserData(userData);
                }
            }

            #region kitNueva

            List<BEKitNueva> KitNueva = new List<BEKitNueva>();
            int EsColaborador = 0;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                KitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora).ToList();
                EsColaborador = sv.GetValidarColaboradorZona(userData.PaisID, userData.CodigoZona);
            }
            int EsKitNueva = 0;
            decimal MontoKitNueva = 0;
            if (KitNueva[0].Estado == 1 && KitNueva[0].EstadoProceso == 1 && EsColaborador == 0)
            {
                EsKitNueva = 1;
                MontoKitNueva = userData.MontoMinimo - KitNueva[0].Monto;
            }
            ViewBag.MontoKitNueva = Util.DecimalToStringFormat(MontoKitNueva, userData.CodigoISO);
            ViewBag.EsKitNueva = EsKitNueva;
            #endregion

            #region mensaje monto logro para la meta

            decimal totalPedido = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
            decimal totalMinimoPedido = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.Total_Minimo = Util.DecimalToStringFormat(totalMinimoPedido, userData.CodigoISO);

            BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();
            var SubTotal = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
            decimal Descuento = 0;
            var PedidoConDescuentoCuv = userData.EstadoSimplificacionCUV && lstPedidoWebDetalle.Any(p => p.IndicadorOfertaCUV);
            if (PedidoConDescuentoCuv) Descuento = -bePedidoWebByCampania.DescuentoProl;
            var total = SubTotal + Descuento;
            model.Total = Util.DecimalToStringFormat(total, userData.CodigoISO);

            ViewBag.Descuento = Util.DecimalToStringFormat(Descuento, userData.CodigoISO);
            ViewBag.SubTotal = model.Total;
            ViewBag.GananciaEstimada = Util.DecimalToStringFormat(bePedidoWebByCampania.MontoAhorroCatalogo + bePedidoWebByCampania.MontoAhorroRevista, userData.CodigoISO);

            decimal montoLogro = 0;
            string montoMaximoStr = Util.ValidaMontoMaximo(userData.MontoMaximo, userData.CodigoISO);
            if (!string.IsNullOrEmpty(montoMaximoStr) || SubTotal < userData.MontoMinimo) montoLogro = total;
            else if (userData.MontoMinimo > bePedidoWebByCampania.MontoEscala) montoLogro = userData.MontoMinimo;
            else montoLogro = bePedidoWebByCampania.MontoEscala;

            BEFactorGanancia beFactorGanancia = null;
            using (SACServiceClient sv = new SACServiceClient())
            {
                beFactorGanancia = sv.GetFactorGananciaSiguienteEscala(totalPedido, userData.PaisID);
            }
            ViewBag.EscalaDescuento = 0;
            ViewBag.MontoEscalaDescuento = Util.DecimalToStringFormat(0, userData.CodigoISO);
            ViewBag.PorcentajeEscala = Util.DecimalToStringFormat(0, userData.CodigoISO);
            if (beFactorGanancia != null && EsColaborador == 0 && beFactorGanancia.RangoMinimo <= userData.MontoMaximo)
            {
                ViewBag.EscalaDescuento = 1;
                ViewBag.PorcentajeEscala = Util.DecimalToStringFormat(beFactorGanancia.Porcentaje, userData.CodigoISO);
                ViewBag.MontoEscalaDescuento = Util.DecimalToStringFormat(beFactorGanancia.RangoMinimo - montoLogro, userData.CodigoISO);
            }
            #endregion

            int HoraCierre = userData.EsZonaDemAnti;
            TimeSpan sp = HoraCierre == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
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

            TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
            DateTime diaActual = DateTime.Today.Add(HoraCierrePortal);
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

            string urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
            string urlProdDesc = WebConfigurationManager.AppSettings["ProdDesc"] + "/" + userData.CodigoISO;
            string banner01 = WebConfigurationManager.AppSettings["banner_01"];
            string banner02 = WebConfigurationManager.AppSettings["banner_02"];
            string banner03 = WebConfigurationManager.AppSettings["banner_03"];

            ViewBag.UrlBanner01 = ConfigS3.GetUrlFileS3(urlCarpeta, banner01, String.Empty);
            ViewBag.UrlBanner02 = ConfigS3.GetUrlFileS3(urlCarpeta, banner02, String.Empty);
            ViewBag.UrlBanner03 = ConfigS3.GetUrlFileS3(urlCarpeta, banner03, String.Empty);

            model.accionBanner_01 = ConfigS3.GetUrlFileS3(urlProdDesc, userData.CampaniaID + ".pdf", String.Empty);

            #endregion

            #region GPR

            userData.ValidacionAbierta = oBEConfiguracionCampania.ValidacionAbierta;

            #endregion

            ViewBag.UrlFranjaNegra = GetUrlFranjaNegra();

            return View(model);
        }

        [HttpPost]
        public JsonResult CargarDetallePedidoValidado(string sidx, string sord, int page, int rows)
        {
            try
            {
                List<BEPedidoWebDetalle> lstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                }

                decimal totalPedido = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
                decimal totalMinimoPedido = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);

                lstPedidoWebDetalle.Update(p => p.DescripcionCortadaProd = Util.SubStrCortarNombre(p.DescripcionProd, 73, ""));

                PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
                PedidoModelo.eMail = userData.EMail;
                PedidoModelo.ListaDetalle = PedidoJerarquico(lstPedidoWebDetalle);
                PedidoModelo.Simbolo = userData.Simbolo;
                PedidoModelo.Total = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO);
                PedidoModelo.Total_Minimo = Util.DecimalToStringFormat(totalMinimoPedido, userData.CodigoISO);

                if (PedidoModelo.ListaDetalle.Any())
                {
                    BEGrid grid = SetGrid(sidx, sord, page, rows);
                    BEPager pag = Util.PaginadorGenerico(grid, PedidoModelo.ListaDetalle);

                    PedidoModelo.ListaDetalle = PedidoModelo.ListaDetalle.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).ToList();
                    PedidoModelo.ListaDetalle.Update(detalle => { if (string.IsNullOrEmpty(detalle.Nombre)) detalle.Nombre = userData.NombreConsultora; });

                    PedidoModelo.Registros = grid.PageSize.ToString();
                    PedidoModelo.RegistrosTotal = pag.RecordCount.ToString();
                    PedidoModelo.Pagina = pag.CurrentPage.ToString();
                    PedidoModelo.PaginaDe = pag.PageCount.ToString();
                }
                else
                {
                    PedidoModelo.RegistrosTotal = "0";
                    PedidoModelo.Pagina = "0";
                    PedidoModelo.PaginaDe = "0";
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = PedidoModelo,
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
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(new char[] { ';' });
            string PaisID = lista[0];
            string CampaniaID = lista[1];
            string ConsultoraID = lista[2];

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                olstPedidoWebDetalle = sv.SelectByPedidoValidado(Convert.ToInt32(PaisID), Convert.ToInt32(CampaniaID), Convert.ToInt64(ConsultoraID), lista[4]).ToList();
            }

            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
            PedidoModelo.ListaDetalle = PedidoJerarquico(olstPedidoWebDetalle);
            PedidoModelo.Simbolo = lista[3];
            PedidoModelo.Total = string.Format("{0:N2}", olstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal));
            PedidoModelo.Total_Minimo = string.Format("{0:N2}", olstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal));
            ViewBag.Simbolo = PedidoModelo.Simbolo;
            ViewBag.Total = PedidoModelo.Total;
            ViewBag.Total_Minimo = PedidoModelo.Total_Minimo;
            ViewBag.Usuario = lista[4];
            ViewBag.BanderaImagen = lista[5];
            ViewBag.NombrePais = lista[6];
            return View(PedidoModelo);
        }

        [AllowAnonymous]
        public ActionResult PedidoValidadoExportarPdf()
        {
            string[] lista = new string[7];
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
                decimal Total = 0;
                List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    olstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
                }
                olstPedidoWebDetalle = PedidoJerarquico(olstPedidoWebDetalle);
                #region cotnenido del correo

                string mailBody = string.Empty;
                mailBody = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
                mailBody += "<div style='font-size:12px;'>Hola,</div> <br />";
                mailBody += "<div style='font-size:12px;'> El detalle de tu pedido para la campaña <b>" + userData.CampaniaID + "</b> es el siguiente :</div> <br /><br />";
                mailBody += "<table border='1' style='width: 80%;'>";
                mailBody += "<tr style='color: #FFFFFF'>";
                mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 126px; background-color: #666699;'>";
                mailBody += "Cod. Venta";
                mailBody += "</td>";
                mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #666699;'>";
                mailBody += "Descripción";
                mailBody += "</td>";
                mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #666699;'>";
                mailBody += "Cantidad";
                mailBody += "</td>";
                mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #666699;'>";
                mailBody += "Precio Unit.";
                mailBody += "</td>";
                mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>";
                mailBody += "Precio Total";
                mailBody += "</td>";
                mailBody += "<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #666699;'>";
                mailBody += "Cliente";
                mailBody += "</td>";
                mailBody += "</tr>";

                for (int i = 0; i < olstPedidoWebDetalle.Count; i++)
                {
                    if (olstPedidoWebDetalle[i].PedidoDetalleIDPadre == 0)
                    {
                        mailBody += "<tr>";
                        mailBody += "<td style='font-size:11px; width: 126px; text-align: center;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].CUV.ToString() + "";
                        mailBody += "</td>";
                        mailBody += " <td style='font-size:11px; width: 347px;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].DescripcionProd.ToString() + "";
                        mailBody += "</td>";
                        mailBody += "<td style='font-size:11px; width: 124px; text-align: center;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].Cantidad.ToString() + "";
                        mailBody += "</td>";
                        mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                        mailBody += userData.Simbolo + Util.DecimalToStringFormat(olstPedidoWebDetalle[i].PrecioUnidad, userData.CodigoISO);
                        mailBody += "</td>";
                        mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                        mailBody += userData.Simbolo + Util.DecimalToStringFormat(olstPedidoWebDetalle[i].ImporteTotal, userData.CodigoISO);
                        mailBody += "</td>";
                        mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                        mailBody += string.IsNullOrEmpty(olstPedidoWebDetalle[i].Nombre) ? userData.NombreConsultora : olstPedidoWebDetalle[i].Nombre;
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        Total += olstPedidoWebDetalle[i].ImporteTotal;
                    }
                    else
                    {
                        mailBody += "<tr>";
                        mailBody += "<td></td>";
                        mailBody += "<td style='font-size:11px; width: 126px; text-align: center;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].CUV + "";
                        mailBody += "</td>";
                        mailBody += " <td colspan='4' style='font-size:11px;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].DescripcionProd + "";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                    }

                }

                mailBody += "<tr>";
                mailBody += "<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>";
                mailBody += "Total :";
                mailBody += "</td>";
                mailBody += "<td style='font-size:11px; text-align: center; font-weight: bold'>";
                mailBody += "" + userData.Simbolo + Util.DecimalToStringFormat(Total, userData.CodigoISO);
                mailBody += "</td>";
                mailBody += "<td></td>";
                mailBody += "</tr>";
                mailBody += "</table>";
                mailBody += "<br /><br />";
                mailBody += "<div style='font-size:12px;'>Saludos,</div>";
                mailBody += "<br /><br />";
                mailBody += "<table border='0'>";
                mailBody += "<tr>";
                mailBody += "<td>";
                mailBody += "<img src='cid:Logo' border='0' />";
                mailBody += "</td>";
                mailBody += "<td style='text-align: center; font-size:12px;'>";
                mailBody += "<strong>" + userData.NombreConsultora + "</strong> <br />";
                mailBody += "<strong>Consultora</strong>";
                mailBody += "</td>";
                mailBody += "</tr>";
                mailBody += "</table>";

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
                string respuesta = PedidoValidadoDeshacer(Tipo);
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
            var mensaje = "";
            var usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                mensaje = sv.DeshacerPedidoValidado(usuario, tipo);
            }
            if (!string.IsNullOrEmpty(mensaje)) return mensaje;

            if (userData.IndicadorGPRSB != 2 || string.IsNullOrEmpty(userData.GPRBannerMensaje)) return "";
            BEConfiguracionCampania bEConfiguracionCampania = null;
            using (PedidoServiceClient sv = new PedidoServiceClient())
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
            int pedidoID = 0;
            using (var sv = new PedidoServiceClient()) { pedidoID = sv.InsertarDesglose(input); }
            if (pedidoID == -1) return Json(new { success = false, message = Constantes.MensajesError.InsertarDesglose }, JsonRequestBehavior.AllowGet);

            try
            {
                if (pedidoID != 0)
                {
                    userData.PedidoID = pedidoID;
                    CambioBannerGPR(true);
                    SetUserData(userData);

                    List<BEPedidoWebDetalle> reemplazos = ObtenerPedidoWebDetalle().Where(p => !string.IsNullOrEmpty(p.Mensaje)).ToList();
                    if (reemplazos.Count != 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
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


        private List<BEPedidoWebDetalle> PedidoJerarquico(List<BEPedidoWebDetalle> ListadoPedidos)
        {
            List<BEPedidoWebDetalle> Result = new List<BEPedidoWebDetalle>();
            List<BEPedidoWebDetalle> Padres = ListadoPedidos.Where(p => p.PedidoDetalleIDPadre == 0).ToList();
            foreach (var item in Padres)
            {
                Result.Add(item);
                var items = ListadoPedidos.Where(p => p.PedidoDetalleIDPadre == item.PedidoDetalleID);
                if (items.Any())
                    Result.AddRange(items);
            }

            return Result;
        }

        private List<BEPedidoWebDetalle> AdministradorPedido(BEPedidoWebDetalle oBEPedidoWebDetalle, string TipoAdm, out bool ErrorServer, out string tipo, out bool modificoBackOrder)
        {
            List<BEPedidoWebDetalle> olstTempListado = new List<BEPedidoWebDetalle>();
            modificoBackOrder = false;

            try
            {
                var mensaje = "";
                if (!(oBEPedidoWebDetalle.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinal
                    || oBEPedidoWebDetalle.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinal
                    || oBEPedidoWebDetalle.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.AppOfertaFinalSinPopup))
                {
                    var noPasa = ReservadoEnHorarioRestringido(out mensaje);
                    if (noPasa)
                    {
                        ErrorServer = true;
                        tipo = mensaje ?? " ";
                        return olstTempListado;
                    }
                }

                var pedidoWebDetalleNula = sessionManager.GetDetallesPedido() == null;

                olstTempListado = ObtenerPedidoWebDetalle();

                if (pedidoWebDetalleNula == false)
                {
                    if (oBEPedidoWebDetalle.PedidoDetalleID == 0)
                    {
                        if (olstTempListado.Any(p => p.CUV == oBEPedidoWebDetalle.CUV))
                            oBEPedidoWebDetalle.TipoPedido = "X";
                    }
                    else
                    {
                        if (olstTempListado.Any(p => p.PedidoDetalleID == oBEPedidoWebDetalle.PedidoDetalleID))
                            oBEPedidoWebDetalle.TipoPedido = "X";
                    }
                }

                if (TipoAdm == "I")
                {
                    int Cantidad;
                    short Result = ValidarInsercion(olstTempListado, oBEPedidoWebDetalle, out Cantidad);
                    if (Result != 0)
                    {
                        TipoAdm = "U";
                        oBEPedidoWebDetalle.Stock = oBEPedidoWebDetalle.Cantidad;
                        oBEPedidoWebDetalle.Cantidad += Cantidad;
                        oBEPedidoWebDetalle.ImporteTotal = oBEPedidoWebDetalle.Cantidad * oBEPedidoWebDetalle.PrecioUnidad;
                        oBEPedidoWebDetalle.PedidoDetalleID = Result;
                        oBEPedidoWebDetalle.Flag = 2;
                        oBEPedidoWebDetalle.OrdenPedidoWD = 1;
                    }
                }

                int TotalClientes = CalcularTotalCliente(olstTempListado, oBEPedidoWebDetalle, TipoAdm == "D" ? oBEPedidoWebDetalle.PedidoDetalleID : (short)0, TipoAdm);
                decimal TotalImporte = CalcularTotalImporte(olstTempListado, oBEPedidoWebDetalle, TipoAdm == "I" ? (short)0 : oBEPedidoWebDetalle.PedidoDetalleID, TipoAdm);

                oBEPedidoWebDetalle.ImporteTotalPedido = TotalImporte;
                oBEPedidoWebDetalle.Clientes = TotalClientes;

                oBEPedidoWebDetalle.CodigoUsuarioCreacion = userData.CodigoUsuario;
                oBEPedidoWebDetalle.CodigoUsuarioModificacion = userData.CodigoUsuario;

                bool quitoCantBackOrder = false;
                if (TipoAdm == "U")
                {
                    if (oBEPedidoWebDetalle.PedidoDetalleID != 0)
                    {
                        var oldPedidoWebDetalle = olstTempListado.Where(x => x.PedidoDetalleID == oBEPedidoWebDetalle.PedidoDetalleID).FirstOrDefault();

                        if (oldPedidoWebDetalle != null)
                        {
                            if (oldPedidoWebDetalle.AceptoBackOrder)
                            {
                                if (oBEPedidoWebDetalle.Cantidad < oldPedidoWebDetalle.Cantidad)
                                {
                                    quitoCantBackOrder = true;
                                }
                            }
                        }
                    }
                }

                Portal.Consultoras.Web.ServicePedido.BEIndicadorPedidoAutentico indPedidoAutentico = new Portal.Consultoras.Web.ServicePedido.BEIndicadorPedidoAutentico();
                indPedidoAutentico.PedidoID = oBEPedidoWebDetalle.PedidoID;
                indPedidoAutentico.CampaniaID = oBEPedidoWebDetalle.CampaniaID;
                indPedidoAutentico.PedidoDetalleID = oBEPedidoWebDetalle.PedidoDetalleID;
                indPedidoAutentico.IndicadorIPUsuario = GetIPCliente();
                indPedidoAutentico.IndicadorFingerprint = "";
                indPedidoAutentico.IndicadorToken = (Session["TokenPedidoAutentico"] != null) ? Session["TokenPedidoAutentico"].ToString() : "";
                oBEPedidoWebDetalle.IndicadorPedidoAutentico = indPedidoAutentico;
                oBEPedidoWebDetalle.OrigenPedidoWeb = ProcesarOrigenPedido(oBEPedidoWebDetalle.OrigenPedidoWeb);

                switch (TipoAdm)
                {
                    case "I":
                        BEPedidoWebDetalle oBePedidoWebDetalleTemp = null;

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            oBePedidoWebDetalleTemp = sv.Insert(oBEPedidoWebDetalle);
                        }

                        oBePedidoWebDetalleTemp.ImporteTotal = oBEPedidoWebDetalle.ImporteTotal;
                        oBePedidoWebDetalleTemp.DescripcionProd = oBEPedidoWebDetalle.DescripcionProd;
                        oBePedidoWebDetalleTemp.Nombre = oBEPedidoWebDetalle.Nombre;

                        oBEPedidoWebDetalle.PedidoDetalleID = oBePedidoWebDetalleTemp.PedidoDetalleID;

                        if (userData.PedidoID == 0)
                        {
                            UsuarioModel usuario = userData;
                            usuario.PedidoID = oBePedidoWebDetalleTemp.PedidoID;
                            SetUserData(usuario);
                        }

                        olstTempListado.Add(oBePedidoWebDetalleTemp);

                        break;
                    case "U":

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoWebDetalle(oBEPedidoWebDetalle);
                        }

                        olstTempListado.Where(p => p.PedidoDetalleID == oBEPedidoWebDetalle.PedidoDetalleID)
                            .Update(p =>
                            {
                                p.Cantidad = oBEPedidoWebDetalle.Cantidad;
                                p.ImporteTotal = oBEPedidoWebDetalle.ImporteTotal;
                                p.ClienteID = oBEPedidoWebDetalle.ClienteID;
                                p.DescripcionProd = oBEPedidoWebDetalle.DescripcionProd;
                                p.Nombre = oBEPedidoWebDetalle.Nombre;
                                p.TipoPedido = oBEPedidoWebDetalle.TipoPedido;
                            });

                        break;
                    case "D":

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.DelPedidoWebDetalle(oBEPedidoWebDetalle);
                        }

                        olstTempListado.RemoveAll(p => p.PedidoDetalleID == oBEPedidoWebDetalle.PedidoDetalleID);

                        break;
                }

                ErrorServer = false;
                tipo = TipoAdm;
                if (tipo == "U")
                {

                    if (quitoCantBackOrder)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.QuitarBackOrderPedidoWebDetalle(oBEPedidoWebDetalle);
                        }
                        modificoBackOrder = true;
                    }
                }

                sessionManager.SetDetallesPedido(null);
                olstTempListado = ObtenerPedidoWebDetalle();
                UpdPedidoWebMontosPROL();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                olstTempListado = ObtenerPedidoWebDetalle();
                ErrorServer = true;
                tipo = "";
            }
            return olstTempListado;
        }

        private int CalcularTotalCliente(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, short PedidoDetalleID, string Adm)
        {
            List<BEPedidoWebDetalle> Temp = new List<BEPedidoWebDetalle>(Pedido);
            if (PedidoDetalleID == 0)
            {
                if (Adm == "I")
                    Temp.Add(ItemPedido);
                else
                    Temp.Where(p => p.PedidoDetalleID == ItemPedido.PedidoDetalleID).Update(p => p.ClienteID = ItemPedido.ClienteID);

            }
            else
                Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();

            return Temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, short PedidoDetalleID, string Adm)
        {
            List<BEPedidoWebDetalle> Temp = new List<BEPedidoWebDetalle>(Pedido);
            if (PedidoDetalleID == 0)
                Temp.Add(ItemPedido);
            else
                Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();
            return Temp.Sum(p => p.ImporteTotal) + (Adm == "U" ? ItemPedido.ImporteTotal : 0);
        }

        private short ValidarInsercion(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, out int Cantidad)
        {
            List<BEPedidoWebDetalle> Temp = new List<BEPedidoWebDetalle>(Pedido);
            BEPedidoWebDetalle obe = Temp.FirstOrDefault(p => p.ClienteID == ItemPedido.ClienteID && p.CUV == ItemPedido.CUV);
            Cantidad = obe != null ? obe.Cantidad : 0;
            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        private void CalcularMasivo(List<BEPedidoWebDetalle> Pedido, List<BEPedidoWebDetalle> Actualizar, out int Clientes, out decimal Importe)
        {
            List<BEPedidoWebDetalle> TempPedido = new List<BEPedidoWebDetalle>(Pedido);
            List<BEPedidoWebDetalle> TempActualizar = new List<BEPedidoWebDetalle>(Actualizar);

            foreach (var item in TempActualizar)
            {
                TempPedido.Where(p => p.PedidoDetalleID == item.PedidoDetalleID).ToList().ForEach(p =>
                {
                    p.Cantidad = item.Cantidad;
                    p.ImporteTotal = item.ImporteTotal;
                    p.ClienteID = item.ClienteID;
                    p.EstadoItem = (short)0;
                });
            }

            Clientes = TempPedido.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
            Importe = TempPedido.Sum(p => p.ImporteTotal);
        }

        public ActionResult EnHorarioRestringido()
        {
            try
            {
                string mensaje = string.Empty;
                bool estado = false;

                if (userData == null) mensaje = "Sesión expirada.";
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        var result = sv.ValidacionModificarPedidoSelectiva(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA, false, false, true);
                        if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.HorarioRestringido)
                        {
                            mensaje = result.Mensaje;
                            estado = true;
                        }
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
            try
            {
                string mensaje = string.Empty;
                bool pedidoReservado = false;
                bool estado = false;

                if (userData == null) mensaje = "Sesión expirada.";
                else
                {
                    BEValidacionModificacionPedido result = null;
                    using (var sv = new PedidoServiceClient())
                    {
                        result = sv.ValidacionModificarPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA);
                    }
                    pedidoReservado = result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado;
                    estado = result.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno;
                    mensaje = result.Mensaje;
                }

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

        public JsonResult ObtenerProductosRecomendados(string CUV)
        {
            List<BECrossSellingProducto> lst;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosRecomendadosByCUVCampaniaPortal(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, CUV).ToList();
            }
            lst = lst ?? new List<BECrossSellingProducto>();
            string Marca = string.Empty;
            if (lst.Any())
            {
                Marca = GetDescripcionMarca(string.IsNullOrEmpty(lst[0].MarcaID) ? 0 : Convert.ToInt32(lst[0].MarcaID));
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO));

                if (lst.Count > 1)
                {
                    Marca = Marca + "," + GetDescripcionMarca(string.IsNullOrEmpty(lst[1].MarcaID) ? 0 : Convert.ToInt32(lst[1].MarcaID));
                }
            }
            return Json(new
            {
                lista = lst,
                Simbolo = userData.Simbolo,
                ISO = userData.CodigoISO,
                DescripcionMarca = Marca
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarCrossSelling()
        {
            int rslt = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
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
            int result = 0;
            if (sessionManager.GetUserData() != null)
            {
                int PaisID = userData.PaisID;
                int RolID = userData.RolID;
                string CodigoZona = userData.CodigoZona;
                if (RolID != 0)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        result = sv.GetFechaNoHabilFacturacion(PaisID, CodigoZona, DateTime.Today);
                    }

                }
            }

            return result;
        }

        [HttpPost]
        public JsonResult ConsultarBannerPedido()
        {
            bool issuccess;

            if (ModelState.IsValid)
            {
                List<BEBannerPedido> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectBannerPedido(userData.PaisID, userData.CampaniaID).ToList();
                }

                if (lst != null)
                    if (lst.Count > 0)
                    {
                        var carpetaPais = Globals.UrlBanner + "/" + userData.CodigoISO;
                        lst.Update(x => x.ArchivoPortada = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPortada, Globals.RutaImagenesIncentivos));
                        carpetaPais = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                        lst.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(carpetaPais, x.Archivo, Globals.RutaImagenesIncentivos));
                    }

                issuccess = true;
                return Json(new
                {
                    success = issuccess,
                    data = lst
                });
            }

            issuccess = true;
            List<BEBannerPedido> lst1 = null;
            return Json(new
            {

                success = issuccess,
                data = lst1
            });
        }

        public int UpdEstadoPacksOfertasNueva()
        {
            int result;
            try
            {
                int num = 0;
                using (PedidoServiceClient pedidoServiceClient = new PedidoServiceClient())
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
            bool issuccess;

            if (ModelState.IsValid)
            {
                Int32 resultado = 0;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.UpdVisualizacionPopupProRecom(Convert.ToInt32(userData.ConsultoraID), userData.CampaniaID, userData.PaisID);
                }

                issuccess = true;
                return Json(new
                {
                    success = issuccess
                });
            }

            issuccess = true;
            return Json(new
            {

                success = issuccess
            });
        }

        [HttpPost]
        public JsonResult ValidarKitNuevas()
        {
            try
            {
                if (Session["ConfiguracionProgramaNuevas"] == null) this.AgregarKitNuevas();
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
            bool flagkit = false;

            if (Session["ConfiguracionProgramaNuevas"] != null) return;

            if (!EsConsultoraNueva())
            {
                /* Kit de nuevas para segundo y tercer pedido*/
                if (userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
                    userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
                    userData.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
                {
                    var PaisesFraccionKit = WebConfigurationManager.AppSettings["PaisesFraccionKitNuevas"];

                    if (!PaisesFraccionKit.Contains(userData.CodigoISO))
                    {
                        Session["ConfiguracionProgramaNuevas"] = new BEConfiguracionProgramaNuevas();
                        return;
                    }

                    flagkit = true;
                }
                /****************/

                if (!flagkit)
                {
                    Session["ConfiguracionProgramaNuevas"] = new BEConfiguracionProgramaNuevas();
                    return;
                }
            }
            
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                try
                {
                    BEConfiguracionProgramaNuevas oBEConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas("ConfiguracionProgramaNuevas");

                    if (oBEConfiguracionProgramaNuevas == null)
                    {
                        Session["ConfiguracionProgramaNuevas"] = new BEConfiguracionProgramaNuevas();
                        return;
                    }

                    Session["ConfiguracionProgramaNuevas"] = oBEConfiguracionProgramaNuevas;
                    if (!flagkit) //Kit en 2 y 3 pedido
                        if (oBEConfiguracionProgramaNuevas.IndProgObli != "1") return;

                    var listaTempListado = ObtenerPedidoWebDetalle();

                    BEPedidoWebDetalle det = new BEPedidoWebDetalle();
                    if (listaTempListado != null)
                        det = listaTempListado.FirstOrDefault(d => d.CUV == oBEConfiguracionProgramaNuevas.CUVKit) ?? new BEPedidoWebDetalle();

                    if (det.PedidoDetalleID > 0) return;

                    List<BEProducto> olstProducto;                    
                    using (ODSServiceClient svOds = new ODSServiceClient())
                    {
                        olstProducto = svOds.SelectProductoToKitInicio(userData.PaisID, userData.CampaniaID, oBEConfiguracionProgramaNuevas.CUVKit).ToList();
                    }

                    if (olstProducto != null && olstProducto.Count > 0)
                    {
                        var producto = olstProducto[0];
                        var model = new PedidoSb2Model();
                        model.TipoOfertaSisID = 0;
                        model.ConfiguracionOfertaID = 0;
                        model.IndicadorMontoMinimo = producto.IndicadorMontoMinimo.ToString().Trim();
                        model.MarcaID = producto.MarcaID;
                        model.Cantidad = "1";
                        model.PrecioUnidad = producto.PrecioCatalogo;
                        model.CUV = oBEConfiguracionProgramaNuevas.CUVKit;
                        model.Tipo = 0;
                        model.DescripcionProd = producto.Descripcion;
                        model.Pagina = "0";
                        model.DescripcionEstrategia = "";
                        model.EsSugerido = false;
                        model.EsKitNueva = true;

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
                PedidoSb2Model model = new PedidoSb2Model();
                model.CodigoIso = userData.CodigoISO;
                model.EstadoSimplificacionCuv = userData.EstadoSimplificacionCUV;
                var listaDetalle = ObtenerPedidoWebDetalle() ?? new List<BEPedidoWebDetalle>();

                if (mobil)
                {
                    if (listaDetalle.Count == 0)
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
                            sessionManager.SetDetallesPedido(null);
                            listaDetalle = ObtenerPedidoWebDetalle();

                            UpdPedidoWebMontosPROL();
                        }
                    }

                    page = 1;
                    rows = listaDetalle.Count;
                }

                decimal total = listaDetalle.Sum(p => p.ImporteTotal);

                model.ListaCliente = (from item in listaDetalle
                                      select new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre }
                    ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                model.ListaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });

                listaDetalle = listaDetalle.Where(p => p.ClienteID == clienteId || clienteId == -1).ToList();
                decimal totalCliente = listaDetalle.Sum(p => p.ImporteTotal);

                var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoWebDetalle>, List<PedidoWebDetalleModel>>(listaDetalle);

                pedidoWebDetalleModel.ForEach(p => p.Simbolo = userData.Simbolo);
                pedidoWebDetalleModel.ForEach(p => p.CodigoIso = userData.CodigoISO);
                pedidoWebDetalleModel.ForEach(p => p.DescripcionCortadaProd = Util.SubStrCortarNombre(p.DescripcionProd, 73, ""));

                model.ListaDetalleModel = pedidoWebDetalleModel;
                model.Total = total;
                model.TotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                model.TotalProductos = pedidoWebDetalleModel.Sum(p => Convert.ToInt32(p.Cantidad));

                BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();
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

                    BEGrid grid = SetGrid(sidx, sord, page, rows);
                    BEPager pag = Util.PaginadorGenerico(grid, model.ListaDetalleModel);

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
            List<BEEscalaDescuento> listaParametriaOfertaFinal = new List<BEEscalaDescuento>();

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaParametriaOfertaFinal = sv.GetParametriaOfertaFinal(userData.PaisID, algoritmo).ToList() ?? new List<BEEscalaDescuento>();
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
                using (ProductoServiceClient ps = new ProductoServiceClient())
                {
                    RegaloOfertaFinal regalo = ps.ObtenerRegaloOfertaFinal(userData.CodigoISO, userData.CampaniaID, userData.ConsultoraID);

                    if (regalo != null)
                    {
                        model = Mapper.Map<RegaloOfertaFinal, RegaloOfertaFinalModel>(regalo);
                        model.CodigoISO = userData.CodigoISO;
                        string carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
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
                using (ProductoServiceClient ps = new ProductoServiceClient())
                {
                    double montoTotal = Convert.ToDouble(ObtenerPedidoWebDetalle().Sum(p => p.ImporteTotal));
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
                segmentoId = (userData.SegmentoInternoID == null) ? userData.SegmentoID : (int)userData.SegmentoInternoID;
            }

            bool resultado = segmentoId == 1;

            return resultado;
        }

        [HttpPost]
        public JsonResult InsertarOfertaFinalLog(string CUV, int cantidad, string tipoOfertaFinal_Log, decimal gap_Log, int tipoRegistro, string desTipoRegistro)
        {
            try
            {
                using (PedidoServiceClient svp = new PedidoServiceClient())
                {
                    BEOfertaFinalConsultoraLog entidad = new BEOfertaFinalConsultoraLog();
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.CodigoConsultora = userData.CodigoConsultora;
                    entidad.CUV = CUV;
                    entidad.Cantidad = cantidad;
                    entidad.TipoOfertaFinal = tipoOfertaFinal_Log;
                    entidad.GAP = gap_Log;
                    entidad.TipoRegistro = tipoRegistro;
                    entidad.DesTipoRegistro = desTipoRegistro;

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
                    List<BEOfertaFinalConsultoraLog> listaOfertaFinalLog = new List<BEOfertaFinalConsultoraLog>();

                    foreach (var item in lista)
                    {
                        BEOfertaFinalConsultoraLog ofertaFinalLog = new BEOfertaFinalConsultoraLog();
                        ofertaFinalLog.CampaniaID = userData.CampaniaID;
                        ofertaFinalLog.CodigoConsultora = userData.CodigoConsultora;
                        ofertaFinalLog.CUV = item.CUV;
                        ofertaFinalLog.Cantidad = item.Cantidad;
                        ofertaFinalLog.TipoOfertaFinal = item.TipoOfertaFinal;
                        ofertaFinalLog.GAP = item.GAP;
                        ofertaFinalLog.TipoRegistro = item.TipoRegistro;
                        ofertaFinalLog.DesTipoRegistro = item.DesTipoRegistro;
                        listaOfertaFinalLog.Add(ofertaFinalLog);
                    }

                    using (PedidoServiceClient svc = new PedidoServiceClient())
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
            var lista = new List<Producto>();
            string paisesConPcm = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesConPcm);

            int tipoProductoMostrar = paisesConPcm.Contains(userData.CodigoISO) ? 2 : 1;

            int limiteJetlore = int.Parse(GetConfiguracionManager(Constantes.ConfiguracionManager.LimiteJetloreOfertaFinal));

            decimal descuentoprol=0;

            try { descuentoprol = ObtenerPedidoWebDetalle()[0].DescuentoProl; } catch { descuentoprol=0; }
            

            ListaParametroOfertaFinal ObjOfertaFinal = new ListaParametroOfertaFinal();
            var ofertaFinal = GetOfertaFinal();
            ObjOfertaFinal.ZonaID = userData.ZonaID;
            ObjOfertaFinal.CampaniaID = userData.CampaniaID;
            ObjOfertaFinal.CodigoConsultora = userData.CodigoConsultora;
            ObjOfertaFinal.CodigoISO = userData.CodigoISO;
            ObjOfertaFinal.CodigoRegion = userData.CodigorRegion;
            ObjOfertaFinal.CodigoZona = userData.CodigoZona;
            ObjOfertaFinal.Limite = limiteJetlore;
            ObjOfertaFinal.MontoEscala = GetDataBarra().MontoEscala;
            ObjOfertaFinal.MontoMinimo = userData.MontoMinimo;
            ObjOfertaFinal.MontoTotal = ObtenerPedidoWebDetalle().Sum(p => p.ImporteTotal)  - (descuentoprol.Equals(null) ? 0 : descuentoprol);
            ObjOfertaFinal.TipoOfertaFinal = tipoOfertaFinal;
            ObjOfertaFinal.TipoProductoMostrar = tipoProductoMostrar;

            ObjOfertaFinal.Algoritmo = ofertaFinal.Algoritmo;
            ObjOfertaFinal.Estado = ofertaFinal.Estado;

            using (ProductoServiceClient ps = new ProductoServiceClient())
            {
                lista = ps.ObtenerProductosOfertaFinal(ObjOfertaFinal).ToList();
            }
            var listaProductoModel = Mapper.Map<List<Producto>, List<ProductoModel>>(lista);
            if (listaProductoModel.Count(x => x.ID == 0) == listaProductoModel.Count)
            {
                for (int i = 0; i <= listaProductoModel.Count - 1; i++) { listaProductoModel[i].ID = i; }
            }
            if (lista.Count != 0)
            {
                var detallePedido = ObtenerPedidoWebDetalle();
                bool TipoCross = lista[0].TipoCross;
                listaProductoModel.Update(p =>
                {
                    p.PrecioCatalogoString = Util.DecimalToStringFormat(p.PrecioCatalogo, userData.CodigoISO);
                    p.PrecioValorizadoString = Util.DecimalToStringFormat(p.PrecioValorizado, userData.CodigoISO);
                    p.MetaMontoStr = Util.DecimalToStringFormat(p.MontoMeta, userData.CodigoISO);
                    p.Simbolo = userData.Simbolo;
                    p.UrlCompartirFB = GetUrlCompartirFB();
                    p.NombreComercialCorto = Util.SubStrCortarNombre(p.NombreComercial, 40, "...");
                    string imagenUrl = Util.SubStr(p.Imagen, 0);

                    if (!TipoCross)
                    {
                        if (userData.OfertaFinal == Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp)
                        {
                            string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                            imagenUrl = ConfigS3.GetUrlFileS3(carpetapais, imagenUrl, carpetapais);
                        }
                    }
                    p.ImagenProductoSugerido = imagenUrl;
                    p.ImagenProductoSugeridoSmall = ObtenerRutaImagenResize(p.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall);
                    p.ImagenProductoSugeridoMedium = ObtenerRutaImagenResize(p.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium);
                    p.TipoCross = TipoCross;
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
                var campaniaID = listaParemetros.Length > 1 ? listaParemetros[1] : "";
                var codigoConsultora = listaParemetros.Length > 2 ? listaParemetros[2] : "";
                var cuv = listaParemetros.Length > 3 ? listaParemetros[3] : "";

                TempData["CUVOfertaProl"] = Util.Trim(cuv);

                if (codigoIso != userData.CodigoISO || campaniaID != userData.CampaniaID.ToString() || codigoConsultora != userData.CodigoConsultora)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = area });
                }

                var listaDetallePedido = ObtenerPedidoWebDetalle();
                if (listaDetallePedido.Count == 0)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = area });
                }

                BEConfiguracionCampania oBEConfiguracionCampania;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }

                if (oBEConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                            !oBEConfiguracionCampania.ModificaPedidoReservado &&
                            !oBEConfiguracionCampania.ValidacionAbierta)
                {
                    var mensaje = PedidoValidadoDeshacer("PV");
                    if (mensaje != "")
                    {
                        return RedirectToAction("Index", "Bienvenida", new { area = area });
                    }
                }

                if (area == "")
                    return RedirectToAction("Index", "Pedido", new { area = area });
                else
                    return RedirectToAction("Detalle", "Pedido", new { area = area });

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
                        using (PedidoServiceClient svc = new PedidoServiceClient())
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

                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
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
                UsuarioModel userData = UserData();
                ConsultoraRegaloProgramaNuevasModel model = null;
                var f = false;

                if (userData != null)
                {
                    model = userData.ConsultoraRegaloProgramaNuevas;
                    if (model != null) f = true;
                }

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
                bool horario = ReservadoOEnHorarioRestringido(ref mensaje, ref urlRedireccionar);
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
                int IndFlagNueva = 0;
                Int32.TryParse(FlagNueva == "" ? "0" : FlagNueva, out IndFlagNueva);
                BEEstrategia estrategia = FiltrarEstrategiaPedido(EstrategiaID, IndFlagNueva);
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

            bool resul = false;
            mensaje = ValidarMontoMaximo(estrategia.Precio2, estrategia.Cantidad, out resul);
            if (mensaje.Length > 1)
            {
                return Json(new
                {
                    success = false,
                    message = mensaje
                });
            }

            mensaje = ValidarStockEstrategia(estrategia.CUV2, estrategia.Cantidad, estrategia.TipoEstrategiaID, estrategia.Precio2);

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
            bool estado = false;
            try
            {
                mensaje = "";
                string area = Request.Browser.IsMobileDevice ? "Mobile" : "";

                if (userData == null)
                {
                    mensaje = "Sesión expirada.";
                    urlRedireccionar = Url.Action("Index", "Login");
                    return true;
                }

                BEValidacionModificacionPedido result = null;
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.ValidacionModificarPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA);
                }

                estado = result.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno;
                bool pedidoReservado = result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado;

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

        private BEEstrategia FiltrarEstrategiaPedido(string EstrategiaID, int FlagNueva = 0)
        {
            List<BEEstrategia> lst;

            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.EstrategiaID = Convert.ToInt32(EstrategiaID);
            entidad.FlagNueva = FlagNueva;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.FiltrarEstrategiaPedido(entidad).ToList();
            }

            string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var estrategia = lst != null && lst.Count > 0 ? lst[0] : new BEEstrategia();
            estrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, estrategia.ImagenURL);
            estrategia.Simbolo = userData.Simbolo;

            return estrategia;

        }

        private string ValidarStockEstrategia(string CUV, int Cantidad, int TipoOferta, decimal Precio)
        {
            string mensaje = "";
            try
            {
                var entidad = new BEEstrategia();
                entidad.PaisID = userData.PaisID;
                entidad.Cantidad = Cantidad;
                entidad.CUV2 = CUV;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.ConsultoraID = userData.ConsultoraID.ToString();
                entidad.FlagCantidad = TipoOferta;

                using (PedidoServiceClient svc = new PedidoServiceClient())
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
                bool horario = ReservadoOEnHorarioRestringido(ref mensaje, ref urlRedireccionar);
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
                int IndFlagNueva = 0;
                Int32.TryParse(FlagNueva == "" ? "0" : FlagNueva, out IndFlagNueva);
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
                    numero = ficha.LimiteVenta;
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
                        descripcion = brother.Select(m => m.DescripcionComercial).SingleOrDefault();
                    }

                    respuesta = AgregarProductoZE(ficha.MarcaID.ToString(), ficha.CUV2, ficha.Precio2.ToString(), descripcion, Cantidad.ToString(), ficha.IndicadorMontoMinimo.ToString(), ficha.CodigoEstrategia, OrigenPedidoWeb, ClienteID_, ficha.TipoEstrategiaImagenMostrar);
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
    }
}
