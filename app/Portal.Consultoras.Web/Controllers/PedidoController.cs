using System.Web.UI;
using AutoMapper;
using Portal.Consultoras.Common;
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
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using BEPedidoWeb = Portal.Consultoras.Web.ServicePedido.BEPedidoWeb;
using BEPedidoWebDetalle = Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle;

namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoController : BaseController
    {
        public ActionResult Index()
        {
            var model = new PedidoSb2Model();

            try
            {
                model.EsPais = System.Configuration.ConfigurationManager.AppSettings.Get("PaisesEsika")
                    .Contains(userData.CodigoISO) ? "Ésika" : "L'bel";
                model.CodigoIso = userData.CodigoISO;

                #region Sesiones

                Session["ObservacionesPROL"] = null;
                Session["PedidoWeb"] = null;
                Session["PedidoWebDetalle"] = null;

                #endregion

                #region Flexipago

                string hasFlexipago = ConfigurationManager.AppSettings.Get("PaisesFlexipago") ?? string.Empty;

                if (hasFlexipago.Contains(userData.CodigoISO))
                {
                    model.IndicadorFlexiPago = userData.IndicadorFlexiPago;             

                    if (userData.IndicadorFlexiPago != 0)
                    {
                        decimal pedidoBase;
                        decimal lineaCredito;
                        ObtenerLineaCreditoSB2(out lineaCredito, out pedidoBase);

                        model.LineaCredito = lineaCredito;                              
                        model.PedidoBase = pedidoBase;                                 
                    }
                }
                else
                    model.IndicadorFlexiPago = 0;

                #endregion

                #region Configuracion de Campaña

                BEConfiguracionCampania oBEConfiguracionCampania;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }

                if (oBEConfiguracionCampania != null)
                {
                    if (oBEConfiguracionCampania.CampaniaID == 0)
                        return RedirectToAction("CampaniaZonaNoConfigurada");

                    if (oBEConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                        !oBEConfiguracionCampania.ModificaPedidoReservado &&
                        !oBEConfiguracionCampania.ValidacionAbierta)
                    {
                        return RedirectToAction("PedidoValidado");
                    }

                    userData.ZonaValida = oBEConfiguracionCampania.ZonaValida;

                    model.FlagValidacionPedido = "0";                               
                    if (oBEConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                        oBEConfiguracionCampania.ModificaPedidoReservado)
                    {
                        model.FlagValidacionPedido = "1";                            
                    }

                    model.EstadoPedido = oBEConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Pendiente ? 0 : 1;
                }
                else
                {
                    return RedirectToAction("CampaniaZonaNoConfigurada");
                }

                ValidarStatusCampania(oBEConfiguracionCampania);

                //model.Prol = oBEConfiguracionCampania.ZonaValida
                //    ? userData.PROLSinStock
                //        ? "Guarda tu pedido"
                //        : userData.NuevoPROL && userData.ZonaNuevoPROL
                //            ? "Guarda tu pedido"
                //            : userData.MostrarBotonValidar
                //                ? "Valida tu pedido"
                //                : "Guarda tu pedido"
                //    : "Guarda tu pedido";


                /* SB20-287 - INICIO */
                TimeSpan HoraCierrePortal = userData.EsZonaDemAnti == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;
                DateTime diaActual = DateTime.Today.Add(HoraCierrePortal);

                if (!userData.DiaPROL)  // Periodo de venta
                {
                    model.Prol = "Guarda tu pedido";
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}" ,ViewBag.FechaFacturacionPedido);

                    if (userData.CodigoISO == "BO")
                    {
                        model.ProlTooltip = "Es importante que guardes tu pedido";
                        model.ProlTooltip += string.Format("|No olvides validar tu pedido el dia {0} para que sea enviado a facturar", ViewBag.FechaFacturacionPedido);
                    }
                }
                else // Periodo de facturacion
                {
                    model.Prol = "Guarda tu pedido";
                    model.ProlTooltip = "Es importante que guardes tu pedido";
                    model.ProlTooltip += string.Format("|Puedes realizar cambios hasta el {0}", ViewBag.FechaFacturacionPedido);

                    if (userData.NuevoPROL && userData.ZonaNuevoPROL)   // PROL 2
                    {
                        model.Prol = "Reservar tu pedido";
                        model.ProlTooltip = "Haz click aqui para reservar tu pedido";
                        model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm:ss tt"));
                    }
                    else // PROL 1
                    {
                        model.Prol = "Valida tu pedido";
                        model.ProlTooltip = "Haz click aqui para validar tu pedido";
                        model.ProlTooltip += string.Format("|Tienes hasta hoy a las {0}", diaActual.ToString("hh:mm:ss tt"));
                    }
                }
                /* SB20-287 - FIN */

                #endregion

                #region Pedido Web y Detalle

                var pedidoWeb = ObtenerPedidoWeb();

                model.PedidoWebDetalle = ObtenerPedidoWebDetalle(); //Para cargar en Session 
                model.Total = model.PedidoWebDetalle.Sum(p => p.ImporteTotal);
                model.MontoAhorroCatalogo = pedidoWeb.MontoAhorroCatalogo;
                model.MontoAhorroRevista = pedidoWeb.MontoAhorroRevista;
                model.MontoDescuento = pedidoWeb.DescuentoProl;
                model.MontoEscala = pedidoWeb.MontoEscala;
                model.TotalConDescuento = model.Total - model.MontoDescuento;

                model.DataBarra = GetDataBarra(true, true);
                model.ListaParametriaOfertaFinal = GetParametriaOfertaFinal();

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

                //Se desactiva dado que el mensaje de Guardar por MM no va en países SICC
                if (userData.CodigoISO == Constantes.CodigosISOPais.Colombia)
                {
                    List<BETablaLogicaDatos> tabla;
                    using (SACServiceClient sac = new SACServiceClient())
                    {
                        tabla = sac.GetTablaLogicaDatos(userData.PaisID, 27).ToList();
                    }

                    model.MensajeGuardarColombia = tabla != null && tabla.Count != 0            //ViewBag.MensajeGuardarCO
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

                model.accionBanner_01 = ConfigS3.GetUrlFileS3(urlProdDesc, userData.CampaniaID+".pdf", String.Empty);

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
                model.TieneFechaPromesa = ViewBag.TieneFechaPromesa;
                model.MensajeFechaPromesa = ViewBag.MensajeFechaPromesa;
                model.CodigoZona = userData.CodigoZona;
                model.FechaFacturacionPedido = ViewBag.FechaFacturacionPedido;

                string nombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre;
                model.SobreNombre = Util.SubStrCortarNombre(nombreConsultora, 8).ToUpper();

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
                model.EsFacturacion = esFacturacion;
                model.OfertaFinal = userData.OfertaFinal;

                model.EsOfertaFinalZonaValida = userData.EsOfertaFinalZonaValida;
                model.MontoMinimo = userData.MontoMinimo;
                model.MontoMaximo = userData.MontoMaximo;

                model.EsConsultoraNueva = VerificarConsultoraNueva();

                #endregion

                #region Kit Nuevas

                if (Session["ConfiguracionProgramaNuevas"] == null)
                    AgregarKidNuevas();  

                #endregion
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        private void ValidarStatusCampania(BEConfiguracionCampania oBEConfiguracionCampania)
        {
            UsuarioModel usuario = userData;
            usuario.ZonaValida = oBEConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = oBEConfiguracionCampania.FechaInicioFacturacion;

            // OGA se calcula la fecha de fin de campaña sumando la fecha de inicio mas los dias de duración del cronograma
            //usuario.FechaFinCampania = oBEConfiguracionCampania.FechaFinFacturacion;
            usuario.FechaFinCampania = oBEConfiguracionCampania.FechaFinFacturacion;

            usuario.HoraInicioReserva = oBEConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = oBEConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = oBEConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = oBEConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = oBEConfiguracionCampania.DiasAntes;
            bool BotonValidar;
            usuario.DiaPROL = ValidarPROL(usuario, out BotonValidar);
            usuario.MostrarBotonValidar = BotonValidar;
            usuario.NombreCorto = oBEConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = oBEConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = oBEConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = oBEConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = oBEConfiguracionCampania.HoraCierreZonaNormal;
            usuario.ValidacionAbierta = oBEConfiguracionCampania.ValidacionAbierta; //CCSS_JZ_PROL
            usuario.ValidacionInteractiva = oBEConfiguracionCampania.ValidacionInteractiva; //R20160306
            usuario.MensajeValidacionInteractiva = oBEConfiguracionCampania.MensajeValidacionInteractiva; //R20160306

            if (DateTime.Now.AddHours(oBEConfiguracionCampania.ZonaHoraria) < oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraFin;
            }
            DateTime FecActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            TimeSpan HoActual = new TimeSpan(FecActual.Hour, FecActual.Minute, 0);
            TimeSpan HCierrePais = usuario.EsZonaDemAnti == 0 ? usuario.HoraCierreZonaNormal : usuario.HoraCierreZonaDemAnti;

            if (HoActual > HCierrePais)
            {
                usuario.IngresoPedidoCierre = true;
            }

            SetUserData(usuario);
        }

        private bool ValidarPROL(UsuarioModel usuario, out bool mostrarBotonValidar)
        {
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            bool DiaPROL = false;
            mostrarBotonValidar = false;
            if (FechaHoraActual > usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) &&
                FechaHoraActual < usuario.FechaInicioCampania)
            {
                TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
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
                    DiaPROL = true;
                    TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                    if (HoraNow > usuario.HoraInicioReserva && HoraNow < usuario.HoraFinReserva)
                    {
                        int cantidad = BuildFechaNoHabil();
                        mostrarBotonValidar = cantidad == 0;
                    }
                }
            }
            return DiaPROL;
        }

        #region CRUD

        [HttpPost]
        public JsonResult Insert(PedidoSb2Model model)
        {
            try
            {
                #region validar cuv de inicio obligatorio
                List<BEPedidoWebDetalle> olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                if ((userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Registrada
                    || userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Retirada))
                {
                    var detCuv = olstPedidoWebDetalle.FirstOrDefault(d => d.CUV == model.CUV) ?? new BEPedidoWebDetalle();

                    if (detCuv.CUV != "")
                    {
                        BEConfiguracionProgramaNuevas oBEConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas();
                        oBEConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas("ConfiguracionProgramaNuevas");
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

                oBePedidoWebDetalle.DescripcionProd = model.DescripcionProd;
                oBePedidoWebDetalle.ImporteTotal = oBePedidoWebDetalle.Cantidad * oBePedidoWebDetalle.PrecioUnidad;
                oBePedidoWebDetalle.Nombre = oBePedidoWebDetalle.ClienteID == 0 ? userData.NombreConsultora : model.ClienteDescripcion;

                bool errorServer;
                string tipo;
                olstPedidoWebDetalle = AdministradorPedido(oBePedidoWebDetalle, "I", out errorServer, out tipo);   

                decimal total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                string formatoTotal = "";

                formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

                var listaCliente = new List<BECliente>();
                if (model.ClienteID_ != "-1")
                {
                    listaCliente = (from item in olstPedidoWebDetalle
                        select new BECliente {ClienteID = item.ClienteID, Nombre = item.Nombre}
                        ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
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
                        ? bePedidoWebDetalle.DescripcionOferta : "";
                    pedidoWebDetalleModel.TipoPedido = !string.IsNullOrEmpty(bePedidoWebDetalle.TipoPedido)
                        ? bePedidoWebDetalle.TipoPedido : "";
                    pedidoWebDetalleModel.TipoEstrategiaID = bePedidoWebDetalle.TipoEstrategiaID;
                    pedidoWebDetalleModel.Mensaje = bePedidoWebDetalle.Mensaje;
                    pedidoWebDetalleModel.TipoObservacion = bePedidoWebDetalle.TipoObservacion;
                    pedidoWebDetalleModel.DescripcionLarga = bePedidoWebDetalle.DescripcionLarga;
                    pedidoWebDetalleModel.DescripcionOferta = bePedidoWebDetalle.DescripcionOferta.Replace("[", "").Replace("]", "").Trim();
                }                

                return Json(new
                {
                    success = !errorServer,
                    message = !errorServer ? "OK" : "Ocurrió un error al ejecutar la operación.",
                    data = pedidoWebDetalleModel,
                    total,
                    formatoTotal,
                    listaCliente,
                    errorInsertarProducto = !errorServer ? "0" : "1",
                    tipo,
                    DataBarra = !errorServer ? GetDataBarra() : new BarraConsultoraModel()
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
                //model.ListaDetalle = olstPedidoWebDetalle;
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
            string message = string.Empty;
            BEPedidoWebDetalle oBEPedidoWebDetalle = new BEPedidoWebDetalle();
            oBEPedidoWebDetalle.PaisID = userData.PaisID;
            oBEPedidoWebDetalle.CampaniaID = model.CampaniaID;
            oBEPedidoWebDetalle.PedidoID = model.PedidoID;
            oBEPedidoWebDetalle.PedidoDetalleID = Convert.ToInt16(model.PedidoDetalleID);
            oBEPedidoWebDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
            oBEPedidoWebDetalle.PrecioUnidad = model.PrecioUnidad;
            oBEPedidoWebDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID.ToString()) ? (short)0 : Convert.ToInt16(model.ClienteID);

            //Cambios para Oferta de Liquidación
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
            olstPedidoWebDetalle = AdministradorPedido(oBEPedidoWebDetalle, "U", out ErrorServer, out tipo);
            
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

            message = ErrorServer ? "Hubo un problema al intentar actualizar el registro. Por favor inténtelo nuevamente." : "El registro ha sido actualizado de manera exitosa.";

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
                DataBarra = !ErrorServer ?  GetDataBarra() : new BarraConsultoraModel(),
            }, JsonRequestBehavior.AllowGet);
        }

        public PedidoDetalleModel DeletePedido(BEPedidoWebDetalle obe)
        {
            string mensaje = string.Empty;
            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();
            PedidoModelo.Simbolo = userData.Simbolo;
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            if (Session["ObservacionesPROL"] != null)
            {
                List<ObservacionModel> Observaciones = (List<ObservacionModel>)Session["ObservacionesPROL"];
                List<ObservacionModel> Obs = Observaciones.Where(p => p.CUV == obe.CUV).ToList();
                if (Obs.Count != 0)
                {
                    obe.Mensaje = Obs[0].Descripcion;
                }

            }

            bool ErrorServer = false;
            string tipo = "";

            // se valida si esta en horario restringido
            if (ValidarHorarioRestringido(out mensaje))
            {
                // se crea el mensaje de error
                // ViewBag.ErrorDelete = mensaje;
                ModelState.AddModelError("", mensaje);
                // se restaura el modelo de la vista
                olstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                PedidoModelo.ListaDetalle = olstPedidoWebDetalle;
                PedidoModelo.Total = string.Format("{0:N2}", olstPedidoWebDetalle.Sum(p => p.ImporteTotal));

                PedidoModelo.MensajeError = mensaje;
                return PedidoModelo;
            }

            olstPedidoWebDetalle = AdministradorPedido(obe, "D", out ErrorServer, out tipo);

            return PedidoModelo;
        }

        [HttpPost]
        public JsonResult Delete(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad, string ClienteID, string CUVReco)
        {
            try
            {
                var model = new PedidoSb2Model();
                List<BEPedidoWebDetalle> ListaPedidoWebDetalle = (List<BEPedidoWebDetalle>)Session["PedidoWebDetalle"];
                BEPedidoWebDetalle PedidoEliminado = ListaPedidoWebDetalle.First(x => x.CUV == CUV);
                model.Simbolo = userData.Simbolo;
                List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
                BEPedidoWebDetalle obe = new BEPedidoWebDetalle();
                obe.PaisID = userData.PaisID;
                obe.CampaniaID = CampaniaID;
                obe.PedidoID = PedidoID;
                obe.PedidoDetalleID = PedidoDetalleID;
                obe.TipoOfertaSisID = TipoOfertaSisID;
                obe.CUV = CUV;
                obe.Cantidad = Cantidad;
                obe.Mensaje = string.Empty;
                if (Session["ObservacionesPROL"] != null)
                {
                    List<ObservacionModel> Observaciones = (List<ObservacionModel>)Session["ObservacionesPROL"];
                    List<ObservacionModel> Obs = Observaciones.Where(p => p.CUV == CUV).ToList();
                    if (Obs.Count != 0)
                    {
                        obe.Mensaje = Obs[0].Descripcion;
                    }
                }

                bool ErrorServer;
                string tipo;
                olstPedidoWebDetalle = AdministradorPedido(obe, "D", out ErrorServer, out tipo);

                decimal total = 0;
                string formatoTotal = "";
                decimal totalCliente = 0;
                string formatoTotalCliente = "";

                total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

                if (!olstPedidoWebDetalle.Any())
                {
                    model.ListaDetalle = new List<BEPedidoWebDetalle>();
                }
                else
                {                    
                    if (ClienteID != "-1")
                    {
                        List<BEPedidoWebDetalle>  lstTemp = (from item in olstPedidoWebDetalle
                                   where item.ClienteID == Convert.ToInt16(ClienteID)
                                   select item).ToList();

                        totalCliente = lstTemp.Sum(p => p.ImporteTotal);
                        formatoTotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                    }
                    else
                    {
                        formatoTotalCliente = "";
                    }
                }

                List<BECliente> listaCliente;
                listaCliente = (from item in olstPedidoWebDetalle
                                      select new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre }
                                                        ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                listaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });
                Session["ListadoEstrategiaPedido"] = null;
                
                return Json(new
                {
                    success = !ErrorServer,
                    message = !ErrorServer ? "OK" : "Ocurrió un error al ejecutar la operación.",
                    formatoTotal,
                    total,
                    formatoTotalCliente,
                    listaCliente,
                    DataBarra = !ErrorServer ? GetDataBarra() : new BarraConsultoraModel(),
                    data = new
                    {
                        DescripcionProducto = PedidoEliminado.DescripcionProd,
                        CUV = PedidoEliminado.CUV,
                        Precio = PedidoEliminado.PrecioUnidad.ToString("F"),
                        DescripcionMarca = PedidoEliminado.DescripcionLarga,
                        DescripcionOferta = PedidoEliminado.DescripcionOferta.Replace("[", "").Replace("]", "").Trim()
                    }
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
                    listaCliente = ""
                }); 
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
                List<BEPedidoWebDetalle> olstTempListado = new List<BEPedidoWebDetalle>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    EliminacionMasiva = sv.DelPedidoWebDetalleMasivo(userData.PaisID, userData.CampaniaID, userData.PedidoID, userData.CodigoUsuario);
                }
                if (EliminacionMasiva)
                {
                    UpdPedidoWebMontosPROL();

                    Session["PedidoWeb"] = null;
                    Session["PedidoWebDetalle"] = null;

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
                ErrorServer = true;
                message = "Hubo un problema al intentar eliminar el pedido. Por favor inténtelo nuevamente.";
            }

            return Json(new
            {
                success = ErrorServer,
                message = message,
                extra = "",
                DataBarra = GetDataBarra()
            }, JsonRequestBehavior.AllowGet);

        }

        #endregion

        #region Packs Ofertas para Nuevas

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public ActionResult GuardarOfertaNueva(string vMarcaID, string vPrecioUnidad, string vCUV, string vIndicadorMontoMinimo, string vDescripcionProd, string vCantidad)
        {

            var pedidoModel = new PedidoSb2Model()
            {
                ClienteID = string.Empty,
                IndicadorMontoMinimo = vIndicadorMontoMinimo,
                Tipo = 1,
                MarcaID = Convert.ToByte(vMarcaID),
                Cantidad = vCantidad,//1487
                PrecioUnidad = Convert.ToDecimal(vPrecioUnidad),
                CUV = vCUV,
                DescripcionProd = vDescripcionProd,
                ConfiguracionOfertaID = Constantes.TipoOferta.Nueva,
                TipoOfertaSisID = Constantes.ConfiguracionOferta.Nueva,
                OfertaWeb = true

            };
            Insert(pedidoModel);

            return null;
        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        private List<OfertaNuevaModel> ObtenerPackOfertasNuevasPorCampania(int vCampaniaID)//1487//1731
        {
            int result = 0;
            //int estado = -1;
            List<OfertaNuevaModel> lstresult = null;

            List<BEOfertaNueva> lista;
            int vPaisID = userData.PaisID;
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                result = svc.ObtenerEstadoPacksOfertasNueva(vPaisID, Convert.ToInt32(userData.ConsultoraID), userData.CampaniaID);

                // if (result >= 0 && result < 2)
                if (result >= 0)
                {
                    string simbolo = userData.Simbolo;
                    //lista = svc.GetPackOfertasNuevasByCampania(vPaisID, vCampaniaID).ToList();
                    lista = svc.GetProductosOfertaConsultoraNueva(userData.PaisID, userData.CampaniaID, Convert.ToInt32(userData.ConsultoraID)).ToList();

                    if (lista.Count > 0)
                    {
                        if (Session["isPedido"] == null)
                        {
                            UpdEstadoPacksOfertasNueva();
                        }
                        Session["isPedido"] = "1";
                    }

                    lstresult = Mapper.Map<IList<BEOfertaNueva>, List<OfertaNuevaModel>>(lista);
                    lstresult.Each(p => p.Simbolo = simbolo);
                }
            }

            ViewBag.EstadoOfertaNueva = -1;


            if (lstresult != null && lstresult.Count >= 1)
            {
                lstresult.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                ViewBag.EstadoOfertaNueva = lstresult.Count;

                var list = from t in lstresult
                           where t.IndicadorPedido.Equals(0)
                           select t;

                ViewBag.EstadoOfertaSinComprar = list.Count();
                if (list.Count() == 0)
                {
                    ViewBag.EstadoOfertaNueva = -1;
                    lstresult = null;
                }
            }
            else
            {
                lstresult = null;
            }



            return lstresult;
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
        private void ObtenerLineaCreditoSB2(out decimal lineaCredito, out decimal pedidoBase)
        {
            try
            {
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {                    
                    BEOfertaFlexipago oBe = svc.GetLineaCreditoFlexipago(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID);

                    lineaCredito = oBe.LineaCredito;
                    pedidoBase = oBe.PedidoBase;
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                lineaCredito = 0;
                pedidoBase = 0;

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                lineaCredito = 0;
                pedidoBase = 0;
            }
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
                    //R2118
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
                //ViewBag.LineaCredito = string.Format("{0:#,##0.00}", 0);
                //ViewBag.PedidoBase = string.Format("{0:#,##0.00}", 0);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                //R2118
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
                //R2118
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
        public JsonResult ValidarStockEstrategia(string MarcaID, string CUV, string PrecioUnidad, string Descripcion, string Cantidad, string indicadorMontoMinimo, string TipoOferta)
        {
            // Validar la cantidad que se está ingresando compararla con la cantidad ya ingresada y el campo límite
            string mensaje = "";
            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.Cantidad = Convert.ToInt32(Cantidad);
            entidad.CUV2 = CUV;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.ConsultoraID = userData.ConsultoraID.ToString().Trim();

            entidad.FlagCantidad = Convert.ToInt32(TipoOferta);

            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                mensaje = svc.ValidarStockEstrategia(entidad);
            }

            if (mensaje == "OK")
            {
                return Json(new
                {
                    result = true
                });
            }
            else
            {
                return Json(new
                {
                    result = false,
                    message = mensaje
                }, JsonRequestBehavior.AllowGet);
            }

        }

        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult AgregarProductoZE(string MarcaID, string CUV, string PrecioUnidad, string Descripcion, string Cantidad, string indicadorMontoMinimo,
                                              string TipoOferta, string ElementoOfertaTipoNuevo = null, string ClienteID_ = "", bool EsKitNueva = false)
        {
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
                TipoOfertaSisID = Convert.ToInt32(TipoOferta), // C1747
                ConfiguracionOfertaID = Convert.ToInt32(TipoOferta),                
                OfertaWeb = false
            };

            if (EsKitNueva)
            {
                var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                var packNuevas = lstPedidoWebDetalle.FirstOrDefault(x => x.TipoEstrategiaID == 1);

                if (packNuevas != null)
                {
                    DeletePedido(packNuevas);
                    Session["PedidoWebDetalle"] = null;
                }
            }

            Session["ListadoEstrategiaPedido"] = null;
            return Insert(pedidoModel);
        }
        #endregion

        #region Autocompletes

        public ActionResult AutocompleteByProductoCUV(string term)
        {
            List<BEProducto> olstProducto = new List<BEProducto>();
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                UsuarioModel oUsuarioModel = userData;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, term, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 5).ToList();
                }

                var strCUV = string.Empty;
                if (olstProducto.Count() > 0)
                {
                    strCUV = olstProducto[0].CUV.Trim();
                }


                var BEMensajeCUV = new BEMensajeCUV();
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    BEMensajeCUV = sv.GetMensajeByCUV(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, strCUV);
                }

                foreach (var item in olstProducto)
                {
                    olstProductoModel.Add(new ProductoModel()
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
                        IndicadorMontoMinimo = item.IndicadorMontoMinimo.ToString().Trim(),
                        //CUVComplemento = item.CUVComplemento.Trim(),
                        TipoOfertaSisID = item.TipoOfertaSisID,
                        ConfiguracionOfertaID = item.ConfiguracionOfertaID,
                        MensajeCUV = BEMensajeCUV.Mensaje,
                        /*CIG(RSA) REQ - 552 */

                        DescripcionMarca = item.DescripcionMarca,
                        DescripcionEstrategia = item.DescripcionEstrategia,
                        DescripcionCategoria = item.DescripcionCategoria,
                        FlagNueva = item.FlagNueva, // CGI(AHAA) - BUG 2015000858
                        TipoEstrategiaID = item.TipoEstrategiaID // CGI(AHAA) - BUG 2015000858
                    });
                }

                if (olstProductoModel.Count == 0)
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe." });
                }
            }
            catch (Exception ex)
            {
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
        }

        public ActionResult FindByCUV(PedidoDetalleModel model)
        {
            List<BEProducto> olstProducto = new List<BEProducto>();
            BECUVCredito beConsultoraCUV = new BECUVCredito();//R2140
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                UsuarioModel oUsuarioModel = userData;

                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, model.CUV, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 1).ToList();
                }

                if (olstProducto.Count == 0)
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe.", TieneSugerido = 0 });
                    return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
                }

                var listaEstrategias = (List<BEEstrategia>)Session["ListadoEstrategiaPedido"] ?? new List<BEEstrategia>();
                var estrategia = listaEstrategias.FirstOrDefault(p => p.CUV2 == model.CUV) ?? new BEEstrategia();
                if (estrategia.TipoEstrategiaImagenMostrar == @Portal.Consultoras.Common.Constantes.TipoEstrategia.OfertaParaTi)
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "El producto solicitado no existe.", TieneSugerido = 0 });
                    return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
                }

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    beConsultoraCUV = sv.ValidarCUVCreditoPorCUVRegular(oUsuarioModel.PaisID, oUsuarioModel.CodigoConsultora, model.CUV, oUsuarioModel.CampaniaID);
                }

                if (beConsultoraCUV.IdMensaje == 2)
                {
                    olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Código incorrecto, Para solicitar el set: ingresa el código " + beConsultoraCUV.CuvRegular, TieneSugerido = 0 });
                    return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
                }

                int? revistaGana = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    revistaGana = sv.ValidarDesactivaRevistaGana(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, oUsuarioModel.CodigoZona);
                }

                var strCUV = model.CUV;

                var BEMensajeCUV = new BEMensajeCUV();
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    BEMensajeCUV = sv.GetMensajeByCUV(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, strCUV);
                }

                var ObservacionCUV = beConsultoraCUV.IdMensaje == 1
                    ? oUsuarioModel.PrimerNombre.ToString()
                        + " tienes el beneficio de pagar en 2 partes el valor de este SET de productos. Si lo deseas ingresa este código al pedir el set: "
                        + beConsultoraCUV.CuvCredito
                    : "";
                
                olstProductoModel.Add(new ProductoModel()
                {
                    CUV = olstProducto[0].CUV.Trim(),
                    Descripcion = olstProducto[0].Descripcion.Trim(),
                    PrecioCatalogo = olstProducto[0].PrecioCatalogo,
                    MarcaID = olstProducto[0].MarcaID,
                    EstaEnRevista = olstProducto[0].EstaEnRevista,
                    TieneStock = olstProducto[0].TieneStock,
                    EsExpoOferta = olstProducto[0].EsExpoOferta,
                    CUVRevista = olstProducto[0].CUVRevista.Trim(),
                    CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                    IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                    TipoOfertaSisID = olstProducto[0].TipoOfertaSisID,
                    ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID,
                    MensajeCUV = BEMensajeCUV.Mensaje,
                    ObservacionCUV = ObservacionCUV,
                    DesactivaRevistaGana = revistaGana,
                    DescripcionMarca = olstProducto[0].DescripcionMarca,
                    DescripcionEstrategia = olstProducto[0].DescripcionEstrategia,
                    DescripcionCategoria = olstProducto[0].DescripcionCategoria,
                    FlagNueva = olstProducto[0].FlagNueva,
                    TipoEstrategiaID = olstProducto[0].TipoEstrategiaID,
                    TieneSugerido = olstProducto[0].TieneSugerido,
                    CodigoProducto = olstProducto[0].CodigoProducto,
                    LimiteVenta = estrategia != null ? estrategia.LimiteVenta : 99
                });

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { MarcaID = 0, CUV = "Ha ocurrido un Error. Vuelva a intentarlo.", TieneSugerido = 0 });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);

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
                    /*Obtener si tiene stock de PROL por CodigoSAP*/
                    string codigoSap = "";
                    foreach (var beProducto in listaProduto)
                        codigoSap += beProducto.CodigoProducto + "|";

                    try
                    {
                        using (var sv = new ServicePROLConsultas.wsConsulta())
                        {
                            sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                            listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
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
                    var rutaImagenSugerido = "";
                    if (string.IsNullOrEmpty(beProducto.ImagenProductoSugerido))
                    {
                        rutaImagenSugerido = "";
                    }
                    else
                    {
                        var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                        rutaImagenSugerido = ConfigS3.GetUrlFileS3(carpetaPais, beProducto.ImagenProductoSugerido, Globals.UrlMatriz + "/" + userData.CodigoISO);
                    }

                    bool tieneStockProl = true;

                    if (esFacturacion)
                    {
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beProducto.CodigoProducto);
                        if (itemStockProl != null)
                            tieneStockProl = itemStockProl.estado == 1;   
                    }

                    if (beProducto.TieneStock && tieneStockProl)
                    {
                        listaProductoModel.Add(new ProductoModel()
                        {
                            CUV = beProducto.CUV.Trim(),
                            Descripcion = beProducto.Descripcion.Trim(),
                            PrecioCatalogoString =  Util.DecimalToStringFormat(beProducto.PrecioCatalogo, userData.CodigoISO),
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
                            ImagenProductoSugerido = rutaImagenSugerido,
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
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, CUV, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 1, 1).ToList();
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

                //oBEPedidoWebDetalle.TipoOfertaSisID = model.TipoOfertaSisID;

                oBEPedidoWebDetalle.MarcaID = Convert.ToByte(olstProducto[0].MarcaID);
                oBEPedidoWebDetalle.Cantidad = Convert.ToInt32(CantCUVpedido);
                oBEPedidoWebDetalle.PrecioUnidad = olstProducto[0].PrecioCatalogo;
                oBEPedidoWebDetalle.CUV = olstProducto[0].CUV.Trim();


                oBEPedidoWebDetalle.DescripcionProd = olstProducto[0].Descripcion.Trim();
                oBEPedidoWebDetalle.ImporteTotal = oBEPedidoWebDetalle.Cantidad * oBEPedidoWebDetalle.PrecioUnidad;
                oBEPedidoWebDetalle.Nombre = oUsuarioModel.NombreConsultora;
                oBEPedidoWebDetalle.DescripcionLarga = olstProducto[0].DescripcionMarca;
                oBEPedidoWebDetalle.DescripcionEstrategia = olstProducto[0].DescripcionEstrategia;
                oBEPedidoWebDetalle.Categoria = olstProducto[0].DescripcionCategoria;

                IList<BEPedidoWebService> olstCuvMarquesina = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    olstCuvMarquesina = sv.GetPedidoCuvMarquesina(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, oUsuarioModel.ConsultoraID, strCUV);
                }

                bool ErrorServer;
                string tipo;

                if (olstCuvMarquesina.Count == 0 || olstCuvMarquesina[0].CUV == "")
                {
                    olstPedidoWebDetalle = AdministradorPedido(oBEPedidoWebDetalle, "I", out ErrorServer, out tipo);
                }
                else
                {
                    oBEPedidoWebDetalle.PedidoID = olstCuvMarquesina[0].PedidoWebID;
                    oBEPedidoWebDetalle.PedidoDetalleID = Convert.ToInt16(olstCuvMarquesina[0].PedidoWebDetalleID);
                    oBEPedidoWebDetalle.Cantidad = oBEPedidoWebDetalle.Cantidad + olstCuvMarquesina[0].Cantidad;
                    olstPedidoWebDetalle = AdministradorPedido(oBEPedidoWebDetalle, "U", out ErrorServer, out tipo);
                }

                return Json(new
                {
                    success = !ErrorServer,
                    message = "Has agregado " + Convert.ToString(CantCUVpedido) + " unidad(es) del producto a tu pedido.",
                    oPedidoDetalle = oBEPedidoWebDetalle,
                    DataBarra = !ErrorServer ? GetDataBarra() : new BarraConsultoraModel()
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
            List<BEProducto> olstProducto = new List<BEProducto>();
            List<ProductoModel> olstProductoModel = new List<ProductoModel>();
            try
            {
                UsuarioModel oUsuarioModel = userData;

                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, term, oUsuarioModel.RegionID, oUsuarioModel.ZonaID, oUsuarioModel.CodigorRegion, oUsuarioModel.CodigoZona, 2, 5).ToList();
                }

                var strCUV = string.Empty;
                if (olstProducto.Count() > 0)
                {
                    strCUV = olstProducto[0].CUV.Trim();
                }

                var BEMensajeCUV = new BEMensajeCUV();
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    BEMensajeCUV = sv.GetMensajeByCUV(oUsuarioModel.PaisID, oUsuarioModel.CampaniaID, strCUV);
                }

                foreach (var item in olstProducto)
                {
                    olstProductoModel.Add(new ProductoModel()
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
                        //CUVComplemento = item.CUVComplemento.Trim(),
                        IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                        MensajeCUV = BEMensajeCUV.Mensaje,
                        /*CIG(RSA) REQ - 552 */
                        DescripcionMarca = item.DescripcionMarca,
                        DescripcionEstrategia = item.DescripcionEstrategia,
                        DescripcionCategoria = item.DescripcionCategoria,
                        TipoEstrategiaID = item.TipoEstrategiaID // 
                    });
                }

                if (olstProductoModel.Count == 0)
                {
                    olstProductoModel.Add(new ProductoModel() { CUV = "0", Descripcion = "El producto solicitado no existe." });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                olstProductoModel.Add(new ProductoModel() { CUV = "0", Descripcion = "Ha ocurrido un Error. Vuelva a intentarlo." });
            }

            return Json(olstProductoModel, JsonRequestBehavior.AllowGet);
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
                        Nombre = item.Nombre
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
                        Nombre = item.Nombre
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
        public JsonResult GetProductoFaltante()
        {
            try
            {
                List<ServiceSAC.BEProductoFaltante> olstProductoFaltante = new List<ServiceSAC.BEProductoFaltante>();
                using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                {
                    olstProductoFaltante = sv.GetProductoFaltanteByCampaniaAndZonaID(userData.PaisID, userData.CampaniaID, userData.ZonaID).ToList();
                }

                return Json(new
                {
                    result = true,
                    data = olstProductoFaltante
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    result = false,
                    data = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }            

        }

        public ActionResult ExportarExcelProductoFaltante()
        {
            List<ServiceSAC.BEProductoFaltante> lst = new List<ServiceSAC.BEProductoFaltante>();
            using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
            {
                lst = sv.GetProductoFaltanteByCampaniaAndZonaID(userData.PaisID, userData.CampaniaID, userData.ZonaID).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Codigo", "CUV");
            dic.Add("Producto", "Descripcion");

            Util.ExportToExcel("FaltantesAnunciadosExcel", lst, dic);

            return new EmptyResult();
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
            bool esMovil = Request.Browser.IsMobileDevice;

            Session["ObservacionesPROL"] = null;

            bool botonValidar;
            UsuarioModel usuario = userData;
            usuario.DiaPROL = ValidarPROL(usuario, out botonValidar);
            usuario.MostrarBotonValidar = botonValidar;
            SetUserData(usuario);

            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            List<ObservacionModel> olstObservaciones = new List<ObservacionModel>();
            bool restrictivas = false, informativas = false, errorProl = false, reservaProl = false;
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;
            string codigoMensaje = "";

            try
            {
                olstPedidoWebDetalle = ObtenerPedidoWebServer();

                List<BECUVAutomatico> lst;
                using (SACServiceClient srv = new SACServiceClient())
                {
                    BECUVAutomatico producto = new BECUVAutomatico { CampaniaID = usuario.CampaniaID };

                    lst = srv.GetProductoCuvAutomatico(usuario.PaisID, producto, "CUV", "asc", 1, 1, 100).ToList();
                }

                if (lst.Count > 0)
                {
                    olstPedidoWebDetalle = olstPedidoWebDetalle.Where(x => !lst.Select(y => y.CUV).Contains(x.CUV)).ToList();
                }

                if (usuario.ZonaValida)
                {
                    if (usuario.ValidacionInteractiva)
                    {
                        if (usuario.NuevoPROL && usuario.ZonaNuevoPROL)
                            olstObservaciones = DevolverObservacionesPROLv2(olstPedidoWebDetalle, out restrictivas, out informativas, out errorProl, out reservaProl,
                                out montoAhorroCatalogo, out montoAhorroRevista, out montoDescuento, out montoEscala, out codigoMensaje);
                        else
                            olstObservaciones = DevolverObservacionesPROL(olstPedidoWebDetalle,
                                out restrictivas, out informativas, out errorProl, out reservaProl,
                                out montoAhorroCatalogo, out montoAhorroRevista, out montoDescuento, out montoEscala, out codigoMensaje);
                        Session["ObservacionesPROL"] = olstObservaciones;
                    }
                }
                else
                {
                    reservaProl = true;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuario.CodigoConsultora, usuario.CodigoISO);
                olstObservaciones.Add(new ObservacionModel() { Descripcion = "Hubo un error al tratar de realizar la validación del pedido, por favor vuelva a intentarlo." });
                restrictivas = false;
                informativas = false;
                errorProl = true;
                reservaProl = false;
            }

            var model = new PedidoSb2Model();
            model.ListaObservacionesProl = olstObservaciones;
            model.ObservacionInformativa = informativas;
            model.ObservacionRestrictiva = restrictivas;
            model.ErrorProl = errorProl;
            model.Reserva = reservaProl;
            model.ZonaValida = usuario.ZonaValida;
            model.ValidacionInteractiva = usuario.ValidacionInteractiva;
            model.MensajeValidacionInteractiva = usuario.MensajeValidacionInteractiva;
            model.MontoAhorroCatalogo = montoAhorroCatalogo;
            model.MontoAhorroRevista = montoAhorroRevista;
            model.MontoDescuento = montoDescuento;
            model.MontoEscala = montoEscala;
            model.Prol = model.ZonaValida
                ? usuario.PROLSinStock
                    ? "Guarda tu pedido"
                    : usuario.NuevoPROL && usuario.ZonaNuevoPROL
                        ? "Guarda tu pedido"
                        : usuario.MostrarBotonValidar
                            ? "Valida tu pedido"
                            : "Guarda tu pedido"
                : "Guarda tu pedido";
            model.EsDiaProl = usuario.DiaPROL;
            model.ProlSinStock = usuario.PROLSinStock;
            model.ZonaNuevoProlM = usuario.ZonaNuevoPROL;
            model.CodigoIso = usuario.CodigoISO;
            model.CodigoMensajeProl = codigoMensaje;

            try
            {
                #region Envio Correo PROL

                bool activoEnvioMail = false;
                List<BETablaLogicaDatos> lstLogicaDatos = new List<BETablaLogicaDatos>();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lstLogicaDatos = sv.GetTablaLogicaDatos(usuario.PaisID, 54).ToList();
                    activoEnvioMail = Int32.Parse(lstLogicaDatos.First().Codigo.Trim()) > 0;
                }

                if (model.Reserva && model.ZonaValida && usuario.ValidacionInteractiva && !model.ObservacionInformativa && usuario.EMail.Trim().Length > 0 && activoEnvioMail)
                {
                    var envio = esMovil ? EnviarPorCorreoPedidoValidadoMobile(olstPedidoWebDetalle) : EnviarPorCorreoPedidoValidado(olstPedidoWebDetalle);
                    if (envio)
                    {
                        using (PedidoServiceClient psv = new PedidoServiceClient())
                        {
                            BELogCabeceraEnvioCorreo beLogCabecera = new BELogCabeceraEnvioCorreo();
                            beLogCabecera.CodigoConsultora = usuario.CodigoConsultora;
                            beLogCabecera.ConsultoraID = usuario.ConsultoraID;
                            beLogCabecera.Email = usuario.EMail;
                            beLogCabecera.FechaFacturacion = usuario.FechaFacturacion;
                            beLogCabecera.Asunto = string.Format("({0}) Confirmación pedido Belcorp", usuario.CodigoISO);
                            beLogCabecera.FechaEnvio = DateTime.Now;

                            List<BELogDetalleEnvioCorreo> listLogDetalleEnvioCorreo = new List<BELogDetalleEnvioCorreo>();
                            foreach (BEPedidoWebDetalle bePedidoWebDetalle in olstPedidoWebDetalle)
                            {
                                BELogDetalleEnvioCorreo beLogDetalle = new BELogDetalleEnvioCorreo();
                                beLogDetalle.CUV = bePedidoWebDetalle.CUV;
                                beLogDetalle.Cantidad = bePedidoWebDetalle.Cantidad;
                                beLogDetalle.PrecioUnitario = bePedidoWebDetalle.PrecioUnidad;
                                listLogDetalleEnvioCorreo.Add(beLogDetalle);
                            }

                            psv.InsLogEnvioCorreoPedidoValidado(usuario.PaisID, beLogCabecera, listLogDetalleEnvioCorreo.ToArray());
                        }
                    }
                }

                #endregion            
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuario.CodigoConsultora, (esMovil ? "SB Mobile - " : "") + usuario.CodigoISO);
            }

            return Json(new
            {
                data = model
            }, JsonRequestBehavior.AllowGet);
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

        public List<BEPedidoWebDetalle> ObtenerPedidoWebServer()
        {
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                olstPedidoWebDetalle = sv.SelectByCampania(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
            }

            Session["PedidoWebDetalle"] = olstPedidoWebDetalle;
            return olstPedidoWebDetalle;
        }

        private List<ObservacionModel> DevolverObservacionesPROL(List<BEPedidoWebDetalle> olstPedidoWebDetalle,
            out bool Restrictivas, out bool Informativas, out bool Error, out bool Reserva,
            out decimal montoAhorroCatalogo, out decimal montoAhorroRevista, out decimal montoDescuento, 
            out decimal montoEscala, out string codigoMensaje)
        {
            Restrictivas = false; Informativas = false; Error = false; Reserva = false;
            montoAhorroCatalogo = 0;
            montoAhorroRevista = 0;
            montoDescuento = 0;
            montoEscala = 0;
            codigoMensaje = "";

            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("CodConsultora");
            dt.Columns.Add("CodVta");
            dt.Columns.Add("Cantidad", System.Type.GetType("System.Int32"));
            dt.Columns.Add("TipoOfertaSisID", System.Type.GetType("System.Int32"));
            decimal montodescontar = 0;
            decimal montoenviar = 0;

            foreach (var item in olstPedidoWebDetalle)
            {
                //if (item.TipoOfertaSisID != Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                //{
                    dt.Rows.Add(userData.CodigoConsultora, item.CUV, item.Cantidad, item.TipoOfertaSisID);
                //}
                //else
                //{
                //    montodescontar = montodescontar + item.ImporteTotal;
                //}
            }

            ds.Tables.Add(dt);

            List<BEKitNueva> KitNueva = new List<BEKitNueva>();

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                KitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora).ToList();
            }

            //Valida de que la consultora tenga estado registrada y de que el proceso de kit de nueva este activo
            if (KitNueva[0].Estado == 1 && KitNueva[0].EstadoProceso == 1)
            {
                montodescontar = montodescontar + KitNueva[0].Monto;
            }

            montoenviar = userData.MontoMinimo - montodescontar;


            if (montoenviar < 0)
            {
                montoenviar = 0;
            }
            ServicePROL.TransferirDatos datos = null;

            if (ds.Tables[0].Rows.Count == 0)
                return new List<ObservacionModel>();

            if (Constantes.CodigosISOPais.Peru.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Chile.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Ecuador.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.CostaRica.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Salvador.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Panama.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Guatemala.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Venezuela.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Colombia.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.PuertoRico.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Dominicana.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Mexico.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Bolivia.ToString().Equals(userData.CodigoISO.ToUpper())
                )
            {
                using (ServicePROL.ServiceStockSsic sv = new ServicePROL.ServiceStockSsic())
                {
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        sv.Url = ConfigurarUrlServiceProl();
                        bool valida = sv.wsDesReservarPedido(userData.CodigoConsultora, userData.CodigoISO);
                        datos = sv.wsValidarPedidoEX(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                    }
                    else
                    {
                        sv.Url = ConfigurarUrlServiceProl();
                        datos = sv.wsValidarEstrategia(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                    }
                }
            }
            else if (
                /* Constantes.CodigosISOPais.Mexico.ToString().Equals(userData.CodigoISO.ToUpper()) || R2455 Se Retiro la Linea y se agrego en la condicion superior*/
                Constantes.CodigosISOPais.Argentina.ToString().Equals(userData.CodigoISO.ToUpper()))
            {
                using (ServicePROLBO.ServiceStockV2 svb = new ServicePROLBO.ServiceStockV2())
                {
                    datos = new ServicePROL.TransferirDatos();
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        svb.Url = ConfigurarUrlServiceProl();
                        bool valida = false;
                        if (Constantes.CodigosISOPais.Bolivia.ToString().Equals(userData.CodigoISO.ToUpper()))
                        {
                            valida = svb.wsDesReservarPedido(userData.CodigoConsultora);
                            datos.data = svb.wsValidarPedido(ds, montoenviar, userData.MontoMaximo);
                        }
                        else
                        {
                            valida = svb.wsDesReservarPedidoPais(userData.CodigoConsultora, userData.CodigoISO);
                            datos.data = svb.wsValidarPedidoPais(ds, montoenviar, userData.MontoMaximo, userData.CodigoZona, userData.CodigoISO);
                        }

                        if (datos.data != null && datos.data.Tables[0] != null && datos.data.Tables[0].Rows.Count != 0)
                        {
                            datos.codigoMensaje = "01";
                        }
                        else
                        {
                            datos.data = new DataSet();
                            datos.data.Tables.Add(new DataTable());
                            datos.codigoMensaje = "00";
                        }
                    }
                    else
                    {
                        datos.data = new DataSet();
                        datos.data.Tables.Add(new DataTable());
                        datos.codigoMensaje = "00";
                    }
                }
            }

            //datos = Devolver2();

            List<ObservacionModel> olstPedidoWebDetalleObs = new List<ObservacionModel>();

            if (datos != null)
            {
                #region Actualizar montos del servicio de prol a Pedido
                
                Decimal.TryParse(datos.montoAhorroCatalogo, out montoAhorroCatalogo);
                Decimal.TryParse(datos.montoAhorroRevista, out montoAhorroRevista);
                Decimal.TryParse(datos.montoDescuento, out montoDescuento);
                Decimal.TryParse(datos.montoEscala, out montoEscala);

                codigoMensaje = datos.codigoMensaje;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
                    bePedidoWeb.PaisID = userData.PaisID;
                    bePedidoWeb.CampaniaID = userData.CampaniaID;
                    bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                    bePedidoWeb.CodigoConsultora = userData.CodigoConsultora;
                    bePedidoWeb.MontoAhorroCatalogo = montoAhorroCatalogo;
                    bePedidoWeb.MontoAhorroRevista = montoAhorroRevista;
                    bePedidoWeb.DescuentoProl = montoDescuento;
                    bePedidoWeb.MontoEscala = montoEscala;

                    sv.UpdateMontosPedidoWeb(bePedidoWeb);

                    Session["PedidoWeb"] = null;
                }

                #endregion

                ViewBag.MontoTotalPROL = datos.montototal;
                DataTable dtr = datos.data.Tables[0];
                if (datos.codigoMensaje != "00")
                {
                    #region codigoMensaje != "00"
                    foreach (DataRow row in dtr.Rows)
                    {
                        int TipoObs = Convert.ToInt32(row.ItemArray.GetValue(0));
                        switch (TipoObs)
                        {
                            case 0:
                                if (Constantes.CodigosISOPais.Peru.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Chile.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Ecuador.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.CostaRica.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Salvador.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Panama.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Guatemala.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Venezuela.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Colombia.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.PuertoRico.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Dominicana.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                     Constantes.CodigosISOPais.Mexico.ToString().Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Bolivia.ToString().Equals(userData.CodigoISO.ToUpper())
                                    )
                                {
                                    olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 0, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 1, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                }
                                else if (/* Constantes.CodigosISOPais.Mexico.ToString().Equals(userData.CodigoISO.ToUpper()) || R2455 Se Retiro la Linea y se agrego en la condicion superior*/
                                            Constantes.CodigosISOPais.Argentina.ToString().Equals(userData.CodigoISO.ToUpper()))
                                {
                                    if (Convert.ToString(row.ItemArray.GetValue(3)) == "-Reemplazo")
                                    {
                                        olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 0, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 1, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", "")) });
                                    }
                                    else
                                    {
                                        olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 0, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 1, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                    }
                                }
                                Informativas = true;
                                break;
                            case 1:
                            case 7:
                                //olstPedidoWebDetalleObs.Add(new ObservacionModel() { CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("EL PRODUCTO {0} - {1} POSEE {2}", Convert.ToString(row.ItemArray.GetValue(1)), Convert.ToString(row.ItemArray.GetValue(2)).Replace("-", "").Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("-", "").Replace("+", "")) });
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 7, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true;
                                break;
                            case 2:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 2, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("PRODUCTO {0} - {1} {2}", Convert.ToString(row.ItemArray.GetValue(1)), Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true;
                                break;
                            case 5:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 5, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true;
                                break;
                            case 8:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 8, CUV = string.Empty, Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true;
                                break;
                            case 9:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 9, CUV = string.Empty, Tipo = 3, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true; //R2004
                                break;
                            case 10:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 10, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true;
                                break;
                            case 11:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 11, CUV = string.Empty, Tipo = 3, Descripcion = string.Empty });
                                Error = true;
                                break;
                            case 16:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 16, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("PRODUCTO {0} - {1} {2}", Convert.ToString(row.ItemArray.GetValue(1)), Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true;
                                break;
                            case 95:
                                string input = Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "");
                                string regex = "(\\#.*\\#)";
                                string Observacion = Regex.Replace(input, regex, userData.MontoMinimo.ToString());
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = 95, CUV = string.Empty, Tipo = 2, Descripcion = Observacion });
                                Restrictivas = true;
                                break;
                            default:
                                olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = TipoObs, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                Restrictivas = true;
                                break;
                        }
                    }

                    if (Informativas && !Restrictivas)
                    {
                        if (userData.DiaPROL && userData.MostrarBotonValidar)
                        {
                            //La reserva sobre el portal se realiza al dar SI en el mensaje.
                            Reserva = true;
                        }
                    }

                    #endregion
                }
                else
                {
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        decimal montoTotalPROL = 0, descuentoPROL = 0;
                        Decimal.TryParse(datos.montototal, out montoTotalPROL);
                        Decimal.TryParse(datos.montoDescuento, out descuentoPROL);
                        EjecutarReservaPortal(dtr, olstPedidoWebDetalle, montoTotalPROL, descuentoPROL);
                        Reserva = true;
                    }
                }

            }
            return olstPedidoWebDetalleObs;
        }

        private List<ObservacionModel> DevolverObservacionesPROLv2(List<BEPedidoWebDetalle> olstPedidoWebDetalle, 
            out bool Restrictivas, out bool Informativas, out bool Error, out bool Reserva,
            out decimal montoAhorroCatalogo, out decimal montoAhorroRevista, out decimal montoDescuento, out decimal montoEscala, out string codigoMensaje)
        {
            Restrictivas = false; Informativas = false; Error = false; Reserva = false;
            montoAhorroCatalogo = 0;
            montoAhorroRevista = 0;
            montoDescuento = 0;
            montoEscala = 0;
            codigoMensaje = "";

            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("CodConsultora");
            dt.Columns.Add("CodVta");
            dt.Columns.Add("Cantidad", System.Type.GetType("System.Int32"));
            dt.Columns.Add("TipoOfertaSisID", System.Type.GetType("System.Int32"));
            decimal montodescontar = 0;
            decimal montoenviar = 0;

            foreach (var item in olstPedidoWebDetalle)
            {
                //if (item.TipoOfertaSisID != Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                //{
                    dt.Rows.Add(userData.CodigoConsultora, item.CUV, item.Cantidad, item.TipoOfertaSisID);
                //}
                //else
                //{
                //    montodescontar = montodescontar + item.ImporteTotal;
                //}
            }

            ds.Tables.Add(dt);

            List<BEKitNueva> KitNueva = new List<BEKitNueva>();

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                KitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora).ToList();
            }

            if (KitNueva[0].Estado == 1 && KitNueva[0].EstadoProceso == 1)
            {
                montodescontar = montodescontar + KitNueva[0].Monto;
            }

            montoenviar = userData.MontoMinimo - montodescontar;

            if (montoenviar < 0)
            {
                montoenviar = 0;
            }
            ServicePROL.TransferirDatos datos = null;

            if (ds.Tables[0].Rows.Count == 0)
                return new List<ObservacionModel>();

            bool EsReservaPedidoPROL = true;

            using (ServicePROL.ServiceStockSsic sv = new ServicePROL.ServiceStockSsic())
            {
                if (userData.DiaPROL && userData.MostrarBotonValidar)
                {
                    EsReservaPedidoPROL = true;
                    sv.Url = ConfigurarUrlServiceProl();
                    datos = sv.wsValidarPedidoInteractivo(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                }
                else
                {
                    EsReservaPedidoPROL = false;
                    sv.Url = ConfigurarUrlServiceProl();
                    datos = sv.wsValidarEstrategia(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                }
            }

            List<ObservacionModel> olstPedidoWebDetalleObs = new List<ObservacionModel>();

            if (datos != null)
            {
                ViewBag.MontoTotalPROL = datos.montototal;
                DataTable dtr = datos.data.Tables[0];
                bool ValidacionPROLMM = false;
                string CUV_Val = string.Empty;
                int ValidacionReemplazo = 0;
                decimal montoTotalPROL = 0, descuentoPROL = 0;
                Decimal.TryParse(datos.montototal, out montoTotalPROL);
                Decimal.TryParse(datos.montoDescuento, out descuentoPROL);

                #region Actualizar montos del servicio de prol a Pedido
                
                Decimal.TryParse(datos.montoAhorroCatalogo, out montoAhorroCatalogo);
                Decimal.TryParse(datos.montoAhorroRevista, out montoAhorroRevista);
                Decimal.TryParse(datos.montoDescuento, out montoDescuento);
                Decimal.TryParse(datos.montoEscala, out montoEscala);

                codigoMensaje = datos.codigoMensaje;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
                    bePedidoWeb.PaisID = userData.PaisID;
                    bePedidoWeb.CampaniaID = userData.CampaniaID;
                    bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                    bePedidoWeb.CodigoConsultora = userData.CodigoConsultora;                    
                    bePedidoWeb.MontoAhorroCatalogo = montoAhorroCatalogo;
                    bePedidoWeb.MontoAhorroRevista = montoAhorroRevista;
                    bePedidoWeb.DescuentoProl = montoDescuento;
                    bePedidoWeb.MontoEscala = montoEscala;

                    sv.UpdateMontosPedidoWeb(bePedidoWeb);

                    Session["PedidoWeb"] = null;
                }

                #endregion

                if (datos.codigoMensaje != "00")
                {
                    foreach (DataRow row in dtr.Rows)
                    {
                        int TipoObs = 0;
                        string CUV = string.Empty;
                        string Observacion = string.Empty;

                        if (EsReservaPedidoPROL)
                        {
                            TipoObs = Convert.ToInt32(row.ItemArray.GetValue(6));
                            CUV = Convert.ToString(row.ItemArray.GetValue(0));
                            Observacion = Convert.ToString(row.ItemArray.GetValue(7)).Replace("+", "");
                        }
                        else
                        {
                            TipoObs = Convert.ToInt32(row.ItemArray.GetValue(0));
                            CUV = Convert.ToString(row.ItemArray.GetValue(1));
                            Observacion = Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "");
                        }

                        if (TipoObs == 0)
                            ValidacionReemplazo += 1;

                        if (TipoObs == 95)
                        {
                            ValidacionPROLMM = true;
                            CUV_Val = CUV;
                            string regex = "(\\#.*\\#)";
                            Observacion = Regex.Replace(Observacion, regex, Util.DecimalToStringFormat(userData.MontoMinimo, userData.CodigoISO));
                        }

                        Restrictivas = true;
                        olstPedidoWebDetalleObs.Add(new ObservacionModel() { Caso = TipoObs, CUV = CUV, Tipo = 2, Descripcion = Observacion });
                    }

                    if (userData.ValidacionAbierta && ValidacionPROLMM && CUV_Val == "XXXXX")
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoWebByEstado(userData.PaisID, userData.CampaniaID, userData.PedidoID, Constantes.EstadoPedido.Pendiente, false, true, userData.CodigoUsuario, false);
                        }
                    }

                    if (dtr.Rows.Count == ValidacionReemplazo)
                    {
                        if (userData.DiaPROL && userData.MostrarBotonValidar)
                        {
                            EjecutarReservaPortalv2(dtr, olstPedidoWebDetalle, montoTotalPROL, descuentoPROL);
                            Reserva = true;
                        }
                    }
                }
                else
                {
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        EjecutarReservaPortalv2(dtr, olstPedidoWebDetalle, montoTotalPROL, descuentoPROL);
                        Reserva = true;
                    }
                }
            }
            return olstPedidoWebDetalleObs;
        }

        private void EjecutarReservaPortalv2(DataTable dtr, List<BEPedidoWebDetalle> olstPedidoWebDetalle, decimal MontoTotalProl = 0, decimal DescuentoProl = 0)
        {
            int PaisID = userData.PaisID;
            int CampaniaID = userData.CampaniaID;
            int PedidoID = userData.PedidoID;
            long ConsultoraID = userData.ConsultoraID;
            string PaisISO = userData.CodigoISO;

            if (PedidoID == 0)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    PedidoID = sv.GetPedidoWebID(PaisID, CampaniaID, ConsultoraID);
                }
                userData.PedidoID = PedidoID;
            }

            List<BEPedidoWebDetalle> olstPedidoReserva = new List<BEPedidoWebDetalle>();

            foreach (DataRow row in dtr.Rows)
            {
                var temp = olstPedidoWebDetalle.Where(p => p.CUV == Convert.ToString(row.ItemArray.GetValue(0)));
                if (temp != null)
                {
                    foreach (var item in temp)
                    {
                        BEPedidoWebDetalle detalle = new BEPedidoWebDetalle();
                        detalle.CampaniaID = item.CampaniaID;
                        detalle.PedidoID = item.PedidoID;
                        detalle.PedidoDetalleID = item.PedidoDetalleID;
                        detalle.ObservacionPROL = Convert.ToString(row.ItemArray.GetValue(7));
                        olstPedidoReserva.Add(detalle);
                    }
                }
            }
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                if (userData.PROLSinStock) //1510
                    sv.InsPedidoWebDetallePROLv2(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Pendiente, olstPedidoReserva.ToArray(), false, userData.CodigoUsuario, MontoTotalProl, DescuentoProl);
                else
                    sv.InsPedidoWebDetallePROLv2(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Procesado, olstPedidoReserva.ToArray(), false, userData.CodigoUsuario, MontoTotalProl, DescuentoProl);
            }
            using (SACServiceClient sv = new SACServiceClient())
            {
                //Se reutiliza la lista, pues desde el método origen devuelve la información de los productos del pedido de BD.
                decimal totalPedido = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                decimal gananciaEstimada = CalcularGananciaEstimada(PaisID, CampaniaID, PedidoID, totalPedido);
                sv.UpdatePedidoWebEstimadoGanancia(PaisID, CampaniaID, PedidoID, gananciaEstimada);
            }
        }

        private void EjecutarReservaPortal(DataTable dtr, List<BEPedidoWebDetalle> olstPedidoWebDetalle, decimal MontoTotalProl = 0, decimal DescuentoProl = 0)
        {
            int PaisID = userData.PaisID;
            int CampaniaID = userData.CampaniaID;
            int PedidoID = userData.PedidoID;
            long ConsultoraID = userData.ConsultoraID;
            string PaisISO = userData.CodigoISO;

            if (PedidoID == 0)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    PedidoID = sv.GetPedidoWebID(PaisID, CampaniaID, ConsultoraID);
                }
                userData.PedidoID = PedidoID;
            }

            List<BEPedidoWebDetalle> olstPedidoReserva = new List<BEPedidoWebDetalle>();

            foreach (DataRow row in dtr.Rows)
            {
                var temp = olstPedidoWebDetalle.Where(p => p.CUV == Convert.ToString(row.ItemArray.GetValue(0)));
                if (temp.Count() == 0)
                {
                    olstPedidoReserva.Add(new BEPedidoWebDetalle()
                    {

                        CampaniaID = olstPedidoWebDetalle[0].CampaniaID,
                        PedidoID = olstPedidoWebDetalle[0].PedidoID,
                        //Desactivado porque no existe Jerarquia
                        //PedidoDetalleID = PedidoDetalleIDPadre,
                        PedidoDetalleID = 0,
                        MarcaID = olstPedidoWebDetalle[0].MarcaID,
                        ConsultoraID = olstPedidoWebDetalle[0].ConsultoraID,
                        ClienteID = 0,
                        Cantidad = Convert.ToInt32(row.ItemArray.GetValue(3)),
                        //Precio Unidad deberia ser cero pero lo envían
                        //PrecioUnidad = Convert.ToDecimal(row.ItemArray.GetValue(2)),
                        PrecioUnidad = 0,
                        //ImporteTotal = Convert.ToDecimal(row.ItemArray.GetValue(4)),
                        ImporteTotal = 0,
                        CUV = Convert.ToString(row.ItemArray.GetValue(0)),
                        OfertaWeb = false,
                        //Desactivado porque no existe Jerarquia
                        //CUVPadre = CUVPadre
                        CUVPadre = "0",
                        CodigoUsuarioCreacion = userData.CodigoUsuario,
                        CodigoUsuarioModificacion = userData.CodigoUsuario
                    });
                }
            }
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                if (userData.PROLSinStock)
                    sv.InsPedidoWebDetallePROL(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Pendiente, olstPedidoReserva.ToArray(), 0, userData.CodigoUsuario, MontoTotalProl, DescuentoProl);
                else
                    sv.InsPedidoWebDetallePROL(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Procesado, olstPedidoReserva.ToArray(), 0, userData.CodigoUsuario, MontoTotalProl, DescuentoProl);
            }
            using (SACServiceClient sv = new SACServiceClient())
            {
                //Se reutiliza la lista, pues desde el método origen devuelve la información de los productos del pedido de BD.
                decimal totalPedido = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                decimal gananciaEstimada = CalcularGananciaEstimada(PaisID, CampaniaID, PedidoID, totalPedido);
                sv.UpdatePedidoWebEstimadoGanancia(PaisID, CampaniaID, PedidoID, gananciaEstimada);
            }
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

            // se calcula la ganancia estimada
            ViewBag.GananciaEstimada = Util.DecimalToStringFormat(0, userData.CodigoISO);
            ViewBag.PedidoProductoMovil = 0;
            if (lstPedidoWebDetalle.Count > 0)
            {
                //int paisId, int campaniaId, int pedidoId, decimal totalPedido                
                ViewBag.PedidoProductoMovil = lstPedidoWebDetalle
                    .Where(p=>p.TipoPedido.ToUpper().Trim() == "PNV")
                    .ToList().Count() > 0 ? 1 : 0;

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
            //Valida de que la consultora tenga estado registrada y de que el proceso de kit de nueva este activo
            if (KitNueva[0].Estado == 1 && KitNueva[0].EstadoProceso == 1 && EsColaborador == 0)
            {
                EsKitNueva = 1;
                MontoKitNueva = userData.MontoMinimo - KitNueva[0].Monto;
            }
            ViewBag.MontoKitNueva =  Util.DecimalToStringFormat(MontoKitNueva, userData.CodigoISO);
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
            ViewBag.HoraCierre = new DateTime(sp.Ticks).ToString("HH:mm");
            model.TotalSinDsctoFormato = Util.DecimalToStringFormat(totalPedido, userData.CodigoISO);
            model.TotalConDsctoFormato = Util.DecimalToStringFormat(totalPedido - bePedidoWebByCampania.DescuentoProl, userData.CodigoISO);

            ViewBag.EstadoSimplificacionCUV = userData.EstadoSimplificacionCUV;
            ViewBag.ZonaNuevoPROL = userData.ZonaNuevoPROL;
            model.ModificacionPedidoProl = userData.NuevoPROL && userData.ZonaNuevoPROL ? 0 : 1;
            //----------------------------------------------------

            #region Banners

            string urlCarpeta = WebConfigurationManager.AppSettings["Banners"] + "/IngresoPedido/" + userData.CodigoISO;
            string banner01 = WebConfigurationManager.AppSettings["banner_01"];
            string banner02 = WebConfigurationManager.AppSettings["banner_02"];
            string banner03 = WebConfigurationManager.AppSettings["banner_03"];

            ViewBag.UrlBanner01 = ConfigS3.GetUrlFileS3(urlCarpeta, banner01, String.Empty);
            ViewBag.UrlBanner02 = ConfigS3.GetUrlFileS3(urlCarpeta, banner02, String.Empty);
            ViewBag.UrlBanner03 = ConfigS3.GetUrlFileS3(urlCarpeta, banner03, String.Empty);

            #endregion
            
            return View(model);
        }


        /*
        public ActionResult PedidoValidadoPaginar(string Tipo, string PaginaActual)
        {
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            PedidoDetalleModel PedidoModelo = new PedidoDetalleModel();

            olstPedidoWebDetalle = ObtenerPedidoWebDetalle();

            PedidoModelo.Total = string.Format("{0:N2}", olstPedidoWebDetalle.Sum(p => p.ImporteTotal));
            PedidoModelo.Total_Minimo = string.Format("{0:N2}", olstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal));

            int cantidadTotal = olstPedidoWebDetalle.Count;

            string Paginas = (olstPedidoWebDetalle.Count % 100 == 0) ? (olstPedidoWebDetalle.Count / 100).ToString() : ((int)(olstPedidoWebDetalle.Count / 100) + 1).ToString();

            if (Tipo == "1")
            {
                if (Paginas == "0")
                    PedidoModelo.Pagina = "0";
                else
                    PedidoModelo.Pagina = "1";
            }

            if (Tipo == "2")
            {
                if (Paginas == "0")
                    PedidoModelo.Pagina = "0";
                else
                    PedidoModelo.Pagina = Paginas;
            }

            if (Tipo == "3")
            {
                if (Paginas == "0")
                    PedidoModelo.Pagina = "0";
                else if (PaginaActual == "1")
                    PedidoModelo.Pagina = "1";
                else
                    PedidoModelo.Pagina = (Convert.ToInt32(PaginaActual) - 1).ToString();
            }

            if (Tipo == "4")
            {
                if (Paginas == "0")
                    PedidoModelo.Pagina = "0";
                else if (PaginaActual == Paginas)
                    PedidoModelo.Pagina = Paginas;
                else
                    PedidoModelo.Pagina = (Convert.ToInt32(PaginaActual) + 1).ToString();
            }

            if (PedidoModelo.Pagina != "0")
            {
                olstPedidoWebDetalle = olstPedidoWebDetalle.Skip((Convert.ToInt32(PedidoModelo.Pagina) - 1) * 100).Take(100).ToList();
            }

            if (PedidoModelo.Pagina == "0")
            {
                PedidoModelo.Registros = "0";
                PedidoModelo.RegistrosDe = "0";
                PedidoModelo.RegistrosTotal = "0";
            }
            else if (PedidoModelo.Pagina == "1")
            {
                PedidoModelo.Registros = "1";
                PedidoModelo.RegistrosDe = olstPedidoWebDetalle.Count < 100 ? olstPedidoWebDetalle.Count.ToString() : "100";
                PedidoModelo.RegistrosTotal = cantidadTotal.ToString();
            }
            else
            {
                PedidoModelo.Registros = ((Convert.ToInt32(PedidoModelo.Pagina) * 100) - 99).ToString();
                PedidoModelo.RegistrosDe = (Convert.ToInt32(PedidoModelo.Registros) + olstPedidoWebDetalle.Count() - 1).ToString();
                PedidoModelo.RegistrosTotal = cantidadTotal.ToString();
            }

            PedidoModelo.PaginaDe = Paginas;
            PedidoModelo.ListaDetalle = olstPedidoWebDetalle;
            PedidoModelo.Simbolo = userData.Simbolo;

            if (Request.IsAjaxRequest())
            {
                return PartialView("ListadoPedidoReservado", PedidoModelo);
            }

            return RedirectToAction("Index");
        }
         * */

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

                //return View(PedidoModelo);
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
                /* Armado de Data */
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
                        if (userData.PaisID == 4) // validación para colombia req. 1478
                        {
                            mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", olstPedidoWebDetalle[i].PrecioUnidad).Replace(',', '.') + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", olstPedidoWebDetalle[i].ImporteTotal).Replace(',', '.') + "";
                            mailBody += "</td>";
                        }
                        else
                        {
                            mailBody += "<td style='font-size:11px; width: 182px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + olstPedidoWebDetalle[i].PrecioUnidad.ToString("#0.00") + "";
                            mailBody += "</td>";
                            mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                            mailBody += "" + userData.Simbolo + olstPedidoWebDetalle[i].ImporteTotal.ToString("#0.00") + "";
                            mailBody += "</td>";
                        }
                        mailBody += "<td style='font-size:11px; width: 165px; text-align: center;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].Nombre.ToString() + "";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        Total += olstPedidoWebDetalle[i].ImporteTotal;
                    }
                    else
                    {
                        mailBody += "<tr>";
                        mailBody += "<td></td>";
                        mailBody += "<td style='font-size:11px; width: 126px; text-align: center;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].CUV.ToString() + "";
                        mailBody += "</td>";
                        mailBody += " <td colspan='4' style='font-size:11px;'>";
                        mailBody += "" + olstPedidoWebDetalle[i].DescripcionProd.ToString() + "";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                    }

                }
                /* Fin de Armado de Data*/
                mailBody += "<tr>";
                mailBody += "<td colspan='4' style='font-size:11px; text-align: right; font-weight: bold'>";
                mailBody += "Total :";
                mailBody += "</td>";
                mailBody += "<td style='font-size:11px; text-align: center; font-weight: bold'>";
                if (userData.PaisID == 4) // validación para colombia req. 1478
                {
                    mailBody += "" + userData.Simbolo + string.Format("{0:#,##0}", Total).Replace(',', '.') + "";
                }
                else
                {
                    mailBody += "" + userData.Simbolo + Total.ToString("#0.00") + "";
                }
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
                    message = "Hubo un problema al enviar el correo eléctronico.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult PedidoValidadoDeshacerReserva(string Tipo)
        {
            try
            {
                bool valida = false;

                if (!userData.NuevoPROL && !userData.ZonaNuevoPROL && Tipo == "PV")
                {
                    using (ServicePROL.ServiceStockSsic sv = new ServicePROL.ServiceStockSsic())
                    {
                        sv.Url = ConfigurarUrlServiceProl();
                        valida = sv.wsDesReservarPedido(userData.CodigoConsultora, userData.CodigoISO);
                    }
                }
                else valida = true;

                if (valida)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        bool ValidacionAbierta = false;
                        short Estado = Constantes.EstadoPedido.Pendiente;
                        
                        if (userData.NuevoPROL && userData.ZonaNuevoPROL && Tipo == "PV")
                        {
                            ValidacionAbierta = true;
                            Estado = Constantes.EstadoPedido.Procesado;
                        }
                        //Dado que no se usa el indicador de ModificaPedidoReservado, este campo en el servicio será utilizado para enviar el campo: ValidacionAbierta
                        sv.UpdPedidoWebByEstado(userData.PaisID, userData.CampaniaID, userData.PedidoID, Estado, false, true, userData.CodigoUsuario, ValidacionAbierta);
                        if (Tipo == "PI")
                        {
                            //Inserta Aceptacion Reemplazos
                            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
                            olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                            List<BEPedidoWebDetalle> Reemplazos = olstPedidoWebDetalle.Where(p => !string.IsNullOrEmpty(p.Mensaje)).ToList();
                            if (Reemplazos.Count != 0)
                            {
                                //Tipo 100: Manual
                                //Tipo 103: Rechazar Reemplazos
                                sv.InsPedidoWebAccionesPROL(Reemplazos.ToArray(), 100, 103);
                            }
                        }
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
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

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult InsertarDesglose()
        {
            ServicePROL.TransferirDatos datos = null;
            try
            {
                using (ServicePROL.ServiceStockSsic sv = new ServicePROL.ServiceStockSsic())
                {
                    sv.Url = ConfigurarUrlServiceProl();
                    datos = sv.ObtenerExplotado(userData.CodigoConsultora, userData.CampaniaID.ToString(), userData.CodigoISO, userData.CodigoZona);
                }

                if (datos != null)
                {
                    List<BEPedidoWebDetalle> lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                    EjecutarReservaPortal(datos.data.Tables[0], lstPedidoWebDetalle);

                    //Inserta Aceptacion Reemplazos
                    List<BEPedidoWebDetalle> reemplazos = lstPedidoWebDetalle.Where(p => !string.IsNullOrEmpty(p.Mensaje)).ToList();
                    if (reemplazos.Count != 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            //Tipo 100: Manual
                            //Tipo 102: Aceptar Reemplazos
                            sv.InsPedidoWebAccionesPROL(reemplazos.ToArray(), 100, 102);
                        }
                    }

                    return Json(new
                    {
                        success = true,
                        message = "",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un error al procesar la reserva.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private decimal CalcularGananciaEstimada(int paisId, int campaniaId, int pedidoId, decimal totalPedido)
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

        private bool EnviarPorCorreoPedidoValidado(List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            DateTime fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            
            bool IndicadorOfertaCUV = false;

            StringBuilder mailBody = new StringBuilder();
            mailBody.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
            mailBody.Append("<meta http-equiv='Content-Type' content='Type=text/html; charset=utf-8'>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.AppendFormat("<tr><td><div style='font-size:12px;font-family: calibri;'>Hola {0},</div></td></tr>", userData.NombreConsultora);
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;font-family: calibri;'>¡Lo lograste!</div ></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;font-family: calibri;'>Tu pedido ha sido reservado con éxito.</div></td></tr>");

            if (fechaHoy < userData.FechaInicioCampania.Date)
            {
                mailBody.AppendFormat("<tr><td><div style='font-size:12px;font-family: calibri;'>Será enviado a Belcorp el día {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda pendiente.</div></div></td></tr>", userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month));
            }
            else
            {
                mailBody.AppendFormat("<tr><td><div style='font-size:12px;font-family: calibri;'>Será enviado a Belcorp el día de {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda pendiente.</div></div></td></tr>", "hoy");
            }
            mailBody.Append("<tr style='height:12px;'><td></td></tr><tr><td><div style='font-size:12px;font-family: calibri;margin-left: 10px;'>Detalle de pedido:</div ></td></tr>");
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("</table>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 90%; margin-left: 10px;'>");
            mailBody.Append("<tr style='color: #FFFFFF'>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 70px; background-color: #6c217f;'>");
            mailBody.Append("Cód.<br />Venta</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #6c217f; padding-left:5px; padding-right:5px;'>");
            mailBody.Append("Descripción</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #6c217f;'>");
            mailBody.Append("Cantidad</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #6c217f;'>");
            mailBody.Append("Precio Unit.</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Precio Total</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Cliente</td></tr>");

            foreach (BEPedidoWebDetalle pedidoDetalle in olstPedidoWebDetalle)
            {
                mailBody.Append("<tr>");
                mailBody.Append("<td style='font-size:11px; width: 56px; text-align: center; border-bottom: 1px solid #6c217f;  border-left: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.CUV);
                mailBody.Append("<td style='font-size:11px; width: 347px; text-align: left; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.DescripcionProd);
                mailBody.Append("<td style='font-size:11px; width: 124px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Cantidad);
                if (userData.PaisID == 4)
                {
                    mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.Append(String.Format("{0:#,##0}", pedidoDetalle.PrecioUnidad).Replace(',', '.'));
                    mailBody.Append("</td>");
                    mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.Append(String.Format("{0:#,##0}", pedidoDetalle.ImporteTotal).Replace(',', '.'));
                }
                else
                {
                    mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.AppendFormat("{0:#0.00}", pedidoDetalle.PrecioUnidad);
                    mailBody.Append("</td>");
                    mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.AppendFormat("{0:#0.00}", pedidoDetalle.ImporteTotal);
                }
                if (ViewBag.EstadoSimplificacionCUV != null && ViewBag.EstadoSimplificacionCUV == true)
                {
                    if (pedidoDetalle.IndicadorOfertaCUV)
                    {
                        IndicadorOfertaCUV = true;
                        mailBody.Append("<img id='IndicadorOfercarCUVImage' height='13' width='13' src=\"cid:IconoIndicador\" />");
                    }
                }
                mailBody.Append("</td>");
                mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;border-right: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Nombre);
            }
            mailBody.Append("</tr></table>");

            if (IndicadorOfertaCUV)
            {
                mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 90%; margin-left: 15px; margin-top:3px;'>");
                mailBody.Append("<tr><td>");
                mailBody.Append("<div id='LeyendaIndicadorCUV' style='font-family: arial; font-size: 11px; color: #722789; padding-right:10px; '>");
                mailBody.Append("<div><img src=\"cid:IconoIndicador\" height='13' width='13'/>El precio total no incluye el descuento para ofertas con más de un precio (1x, 2x). Al validar tu pedido, el sistema elegirá la mejor combinación de precios posibles para ti.</div>");
                mailBody.Append("</div>");
                mailBody.Append("</td></tr>");
                mailBody.Append("</table>");
            }
            mailBody.Append("<br />");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.Append("<tr><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;font-family: calibri;'>Gracias,</div></td></tr><tr><td>&nbsp;</td></tr>");
            mailBody.Append("<tr><td><img src='cid:Logo' border='0' /></td></tr>");
            mailBody.Append("</table>");
            bool resultado = false;
            try
            {  
                resultado = Util.EnviarMail("no-responder@somosbelcorp.com", userData.EMail, string.Empty, string.Format("({0}) Confirmación pedido Belcorp", userData.CodigoISO), mailBody.ToString(), true, null, IndicadorOfertaCUV);
            }
            catch (Exception ex)
            {
                resultado = false;
            }

            return resultado;
        }
        
        private bool EnviarPorCorreoPedidoValidadoMobile(List<BEPedidoWebDetalle> lstPedidoWebDetalle)
        {
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

            var mailBody = new StringBuilder();
            mailBody.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
            mailBody.Append("<meta http-equiv='Content-Type' content='Type=text/html; charset=utf-8'>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Hola {0},</div></td></tr>", userData.PrimerNombre);
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>¡Felicitaciones!</div ></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>Tu pedido ha sido reservado con éxito.</div></td></tr>");

            if (fechaHoy < userData.FechaInicioCampania.Date)
            {
                mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Será enviado a Belcorp el {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda.</div></div></td></tr>", userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month));
            }
            else
            {
                mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Será enviado a Belcorp {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda.</div></div></td></tr>", "hoy");
            }
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("</table>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 90%; margin-left: 10px;'>");
            mailBody.Append("<tr style='color: #FFFFFF'>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 70px; background-color: #6c217f;'>");
            mailBody.Append("Cód.<br />Venta</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #6c217f; padding-left:5px; padding-right:5px;'>");
            mailBody.Append("Descripción</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #6c217f;'>");
            mailBody.Append("Cantidad</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #6c217f;'>");
            mailBody.Append("Precio Unit.</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Precio Total</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Cliente</td></tr>");

            foreach (var pedidoDetalle in lstPedidoWebDetalle)
            {
                mailBody.Append("<tr>");
                mailBody.Append("<td style='font-size:11px; width: 56px; text-align: center; border-bottom: 1px solid #6c217f;  border-left: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.CUV);
                mailBody.Append("<td style='font-size:11px; width: 347px; text-align: left; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.DescripcionProd);
                mailBody.Append("<td style='font-size:11px; width: 124px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Cantidad);
                if (userData.PaisID == 4) //CO
                {
                    mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.Append(string.Format("{0:#,##0}", pedidoDetalle.PrecioUnidad).Replace(',', '.'));
                    mailBody.Append("</td>");
                    mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.Append(string.Format("{0:#,##0}", pedidoDetalle.ImporteTotal).Replace(',', '.'));
                    mailBody.Append("</td>");
                }
                else
                {
                    mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.AppendFormat("{0:#0.00}", pedidoDetalle.PrecioUnidad);
                    mailBody.Append("</td>");
                    mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.AppendFormat("{0:#0.00}", pedidoDetalle.ImporteTotal);
                    mailBody.Append("</td>");
                }
                mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;border-right: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Nombre);
            }
            mailBody.Append("</tr></table><br />");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.Append("<tr><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>Gracias,</div><tr><td><tr><td><div style='font-size:12px;'>Equipo Belcorp.</div></tr></td>");
            mailBody.Append("</table>");

            bool resultado;
            try
            {
                resultado = Util.EnviarMailMobile("no-responder@somosbelcorp.com", userData.EMail, string.Format("({0}) Confirmación pedido Belcorp", userData.CodigoISO), mailBody.ToString(), true, null);
            }
            catch (Exception ex)
            {
                resultado = false;
            }

            return resultado;
        }

        #endregion

        public ServicePROL.TransferirDatos Devolver()
        {
            ServicePROL.TransferirDatos datos = new ServicePROL.TransferirDatos();
            datos.codigoMensaje = "00";
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();

            dt.Columns.Add("0");
            dt.Columns.Add("1");
            dt.Columns.Add("2");
            dt.Columns.Add("3");

            dt.Rows.Add("1", "05400", "Test", "Test");

            ds.Tables.Add(dt);


            datos.data = ds;


            return datos;
        }

        public ServicePROL.TransferirDatos Devolver2()
        {
            ServicePROL.TransferirDatos datos = new ServicePROL.TransferirDatos();
            datos.codigoMensaje = "00";
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();

            dt.Columns.Add("0");
            dt.Columns.Add("1");
            dt.Columns.Add("2");
            dt.Columns.Add("3");
            dt.Columns.Add("4");
            dt.Columns.Add("5");

            dt.Rows.Add("05400", "ES AVENTOUR EDT 100 ML", "17.90", "12", "214.80", "1");

            ds.Tables.Add(dt);


            datos.data = ds;


            return datos;
        }

        private List<BEPedidoWebDetalle> PedidoJerarquico(List<BEPedidoWebDetalle> ListadoPedidos)
        {
            List<BEPedidoWebDetalle> Result = new List<BEPedidoWebDetalle>();
            List<BEPedidoWebDetalle> Padres = ListadoPedidos.Where(p => p.PedidoDetalleIDPadre == 0).ToList();
            foreach (var item in Padres)
            {
                Result.Add(item);
                var items = ListadoPedidos.Where(p => p.PedidoDetalleIDPadre == item.PedidoDetalleID);
                if (items.Count() != 0)
                    Result.AddRange(items);
            }

            return Result;
        }

        private List<BEPedidoWebDetalle> AdministradorPedido(BEPedidoWebDetalle oBEPedidoWebDetalle, string TipoAdm, out bool ErrorServer, out string tipo)
        {
            List<BEPedidoWebDetalle> olstTempListado = new List<BEPedidoWebDetalle>();

            try
            {
                var pedidoWebDetalleNula = Session["PedidoWebDetalle"] == null;

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

                Session["PedidoWebDetalle"] = null;

                olstTempListado = ObtenerPedidoWebDetalle();
                ErrorServer = false;
                tipo = TipoAdm;

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
                TempPedido.Where(p => p.PedidoDetalleID == item.PedidoDetalleID).Update(p =>
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

        // Valida si estamos en dia PROL y fuera del horario permitido (true = en horario restringido, false = en horario normal)
        public ActionResult EnHorarioRestringido()
        {
            /* CGI(RSA) – REQ – 571 – 03/06/2015 – Invocacion de metodo para validar sesion */
            var result = ValidarSession();
            if (result != null) return result;

            try
            {
                string mensaje = string.Empty;
                bool estado = ValidarHorarioRestringido(out mensaje);
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

        public ActionResult ReservadoOEnHorarioRestringido()
        {
            var result = ValidarSession();
            if (result != null) return result;

            try
            {
                string mensaje = string.Empty;
                bool pedidoReservado = ValidarPedidoReservado(out mensaje);
                bool estado = pedidoReservado;
                if (!estado)
                {
                    estado = ValidarHorarioRestringido(out mensaje);
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

        private ActionResult ValidarSession()
        {
            ActionResult Result = null;

            if (HttpContext.Session != null)
            {
                if (HttpContext.Session.IsNewSession)
                {
                    var sessionCookie = HttpContext.Request.Headers["Cookie"];
                    if ((sessionCookie != null) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0))
                    {
                        // loggear datos de variable de sesion clave
                        UsuarioModel usuario = (UsuarioModel)HttpContext.Session["UserData"];
                        if (usuario != null)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(new ApplicationException("Si existe Session[UserData]"), usuario.CodigoConsultora, usuario.CodigoISO);
                        }
                        else
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(new ApplicationException("No existe Session[UserData]"), string.Empty, string.Empty);
                        }
                        // loggear datos de variable de sesion clave

                        CerrarSesion();

                        // version 2
                        if (HttpContext.Request.IsAjaxRequest())
                        {
                            Result = new JsonResult { Data = "_Logon_", JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                        }
                        else
                        {
                            //string URLSignOut = "https://stsqa.somosbelcorp.com/adfs/ls/?wa=wsignout1.0";
                            string URLSignOut = "/SesionExpirada.html";
                            //filterContext.Result = new RedirectResult(URLSignOut);
                            Result = new RedirectResult(URLSignOut);
                        }
                        // version 2
                    }
                }
            }
            return Result;
        }

        private void CerrarSesion()
        {
            HttpContext.Session["UserData"] = null;
            HttpContext.Session.Abandon();
        }

        [HttpGet]
        public JsonResult JsonConsultarEstrategias(string cuv)
        {
            List<BEEstrategia> lst = ConsultarEstrategias(cuv ?? "");
            var listModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(lst);

            var listaPedido = ObtenerPedidoWebDetalle();
            listModel.Update(estrategia => estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim()));

            return Json(listModel, JsonRequestBehavior.AllowGet);
        }

        private List<BEEstrategia> ConsultarEstrategias(string cuv)
        {
            List<BEEstrategia> lst = new List<BEEstrategia>();

            if (Session["ListadoEstrategiaPedido"] != null)
            {
                lst = (List<BEEstrategia>)Session["ListadoEstrategiaPedido"];
                return lst;
            }

            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.ConsultoraID = userData.ConsultoraID.ToString();
            entidad.CUV2 = cuv ?? "";
            entidad.Zona = userData.ZonaID.ToString();

            var listaTemporal = new List<BEEstrategia>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaTemporal = sv.GetEstrategiasPedido(entidad).ToList();
            }
            listaTemporal = listaTemporal ?? new List<BEEstrategia>();

            if (listaTemporal.Count == 0)
            {
                Session["ListadoEstrategiaPedido"] = lst;
                return lst;
            }

            var codigoISO = userData.CodigoISO;
            var simbolo = userData.Simbolo;
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

            string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                string codigoSap = "";
                foreach (var beEstrategia in listaTemporal)
                    codigoSap += beEstrategia.CodigoProducto + "|";

                var listaTieneStock = new List<Lista>();

                try
                {
                    using (var sv = new ServicePROLConsultas.wsConsulta())
                    {
                        sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                        listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    listaTieneStock = new List<Lista>();
                }

                foreach (var beEstrategia in listaTemporal)
                {
                    var add = false;
                    if (beEstrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                    {
                        bool tieneStockProl = false;
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beEstrategia.CodigoProducto);
                        if (itemStockProl != null)
                            tieneStockProl = itemStockProl.estado == 1;

                        add = tieneStockProl || add;
                    }
                    else
                        add = true;

                    if (add)
                    {
                        beEstrategia.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, beEstrategia.FotoProducto01, carpetapais);
                        beEstrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, beEstrategia.ImagenURL, carpetapais);
                        beEstrategia.Simbolo = userData.Simbolo;
                        beEstrategia.TieneStockProl = true;                        
                        beEstrategia.PrecioString = Util.DecimalToStringFormat(beEstrategia.Precio2, userData.CodigoISO);
                        beEstrategia.PrecioTachado = Util.DecimalToStringFormat(beEstrategia.Precio, userData.CodigoISO);

                        lst.Add(beEstrategia);
                    }
                }
            }
            else
            {
                listaTemporal.Update(x =>
                {
                    x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais);
                    x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais);
                    x.Simbolo = userData.Simbolo;
                    x.TieneStockProl = true;
                    x.PrecioString = Util.DecimalToStringFormat(x.Precio2, userData.CodigoISO);
                    x.PrecioTachado = Util.DecimalToStringFormat(x.Precio, userData.CodigoISO);
                });

                lst.AddRange(listaTemporal);
            }

            Session["ListadoEstrategiaPedido"] = lst;


            return lst;
        }

        private bool ValidarHorarioRestringido(out string mensaje)
        {
            bool enHorarioRestringido = false;
            mensaje = string.Empty;
            UsuarioModel usuario = (UsuarioModel)Session["UserData"];
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

            if (!usuario.DiaPROL || !usuario.HabilitarRestriccionHoraria)
                return false;
            else
            {
                // rango de dias prol
                if (FechaHoraActual > usuario.FechaInicioCampania &&
                    FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
                {
                    TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                    TimeSpan HoraAdicional = TimeSpan.Parse(usuario.HorasDuracionRestriccion.ToString() + ":00");
                    // si no es demanda anticipada se usa la hora de cierre normal
                    if (usuario.EsZonaDemAnti == 0)
                    {
                        if (HoraNow > usuario.HoraCierreZonaNormal && HoraNow < usuario.HoraCierreZonaNormal + HoraAdicional)
                            enHorarioRestringido = true;
                        else
                            enHorarioRestringido = false;
                    }
                    else // sino se usa la hora de cierre de demanda anticipada
                    {
                        if (HoraNow > usuario.HoraCierreZonaDemAnti)
                            enHorarioRestringido = true;
                        else
                            enHorarioRestringido = false;
                    }
                }
                // si no es horario restringido se devuelve el resultado false , sino se prepara el mensaje correspondiente
                if (!enHorarioRestringido)
                    return false;
                else
                {
                    TimeSpan HoraCierrePais = usuario.EsZonaDemAnti == 0 ? usuario.HoraCierreZonaNormal : usuario.HoraCierreZonaDemAnti;
                    if (usuario.IngresoPedidoCierre)
                        mensaje = string.Format("Lamentablemente el rango de fechas para ingresar o modificar tu pedido ha concluido. Te recomendamos que en la siguiente campaña lo hagas antes de las {0}:{1} horas de tu día de facturación.", HoraCierrePais.Hours.ToString().PadLeft(2, '0'), HoraCierrePais.Minutes.ToString().PadLeft(2, '0'));
                    else
                        mensaje = string.Format("Se ha cerrado el período de facturación a las {0}:{1} horas. Todos los códigos ingresados hasta esa hora han sido registrados en el sistema. Gracias", HoraCierrePais.Hours.ToString().PadLeft(2, '0'), HoraCierrePais.Minutes.ToString().PadLeft(2, '0'));
                    return true;
                }
            }
        }

        private bool ValidarPedidoReservado(out string mensaje)
        {
            mensaje = string.Empty;

            BEConfiguracionCampania oBEConfiguracionCampania = null;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }
            if (oBEConfiguracionCampania != null && oBEConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                !oBEConfiguracionCampania.ModificaPedidoReservado && !oBEConfiguracionCampania.ValidacionAbierta)
            {
                mensaje = "Ya tienes un pedido reservado para esta campaña.";
                return true;
            }
            return false;
        }

        public JsonResult ObtenerProductosRecomendados(string CUV)
        {
            List<BECrossSellingProducto> lst = new List<BECrossSellingProducto>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosRecomendadosByCUVCampaniaPortal(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, CUV).ToList();
            }

            string Marca = string.Empty;
            if (lst != null && lst.Count > 0)
            {
                Marca = GetDescripcionMarca(string.IsNullOrEmpty(lst[0].MarcaID) ? 0 : Convert.ToInt32(lst[0].MarcaID));
                // 1664
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO));
            }

            if (lst.Count > 1)
            {
                Marca = Marca + "," + GetDescripcionMarca(string.IsNullOrEmpty(lst[1].MarcaID) ? 0 : Convert.ToInt32(lst[1].MarcaID));
            }
            //lst.Update(x=> x.PrecioOferta = x.PrecioOferta.ToString(""))
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

            //lst.Update(x=> x.PrecioOferta = x.PrecioOferta.ToString(""))
            return Json(new
            {
                Habilitar = rslt,
                DiaPROL = userData.DiaPROL
            }, JsonRequestBehavior.AllowGet);
        }

        public int BuildFechaNoHabil()
        {
            int result = 0;
            if (Session["UserData"] != null)
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

        public string GetDescripcionMarca(int MarcaID)
        {
            string result = string.Empty;
            
            switch (MarcaID)
            {
                case 1:
                    result = "L'Bel";
                    break;
                case 2:
                    result = "Ésika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 4:
                    result = "S&M";
                    break;
                case 5:
                    result = "Home Collection";
                    break;
                case 6:
                    result = "Finart";
                    break;
                case 7:
                    result = "Generico";
                    break;
                case 8:
                    result = "Glance";
                    break;
                default:
                    //result = "NO DISPONIBLE";
                    break;
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

                // 1664
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
                Portal.Consultoras.Web.LogManager.LogManager.LogErrorWebServicesPortal(faulException, userData.CodigoConsultora, userData.CodigoISO);
                result = 0;
            }
            catch (Exception expException)
            {
                Portal.Consultoras.Web.LogManager.LogManager.LogErrorWebServicesBus(expException, userData.CodigoConsultora, userData.CodigoISO);
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
                if (Session["ConfiguracionProgramaNuevas"] == null) this.AgregarKidNuevas();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false });
            }
            return Json(new { success = true });
        }

        public List<BETipoEstrategia> ListarTipoEstrategia()
        {
            List<BETipoEstrategia> lst;
            if (Session["ListaTipoEstrategia"] == null)
            {
                var entidad = new BETipoEstrategia();
                entidad.PaisID = userData.PaisID;
                entidad.TipoEstrategiaID = 0;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetTipoEstrategias(entidad).ToList();
                }
                Session["ListaTipoEstrategia"] = lst;
            }
            else
            {
                lst = (List<BETipoEstrategia>)Session["ListaTipoEstrategia"];
            }
            return lst;
        }

        public void AgregarKidNuevas()
        {
            if (Session["ConfiguracionProgramaNuevas"] != null)
            {
                return;
            }
                        
            if (!(userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Registrada
                || userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Retirada))
            {
                Session["ConfiguracionProgramaNuevas"] = new BEConfiguracionProgramaNuevas();
                return;
            }

            BEConfiguracionProgramaNuevas oBEConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas();
            oBEConfiguracionProgramaNuevas.CampaniaInicio = userData.CampaniaID.ToString();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                try
                {
                    oBEConfiguracionProgramaNuevas = sv.GetConfiguracionProgramaNuevas(userData.PaisID, oBEConfiguracionProgramaNuevas);

                    if (oBEConfiguracionProgramaNuevas == null)
                    {
                        Session["ConfiguracionProgramaNuevas"] = new BEConfiguracionProgramaNuevas();
                        return;
                    }

                    Session["ConfiguracionProgramaNuevas"] = oBEConfiguracionProgramaNuevas;
                    if (oBEConfiguracionProgramaNuevas.IndProgObli != "1")
                    {
                        return;
                    }

                    var listaTempListado = (List<BEPedidoWebDetalle>)Session["PedidoWebDetalle"];

                    BEPedidoWebDetalle det;
                    if (listaTempListado != null)
                        det = listaTempListado.FirstOrDefault(d => d.CUV == oBEConfiguracionProgramaNuevas.CUVKit) ?? new BEPedidoWebDetalle();
                    else
                        det = new BEPedidoWebDetalle();
                    
                    if (det.PedidoDetalleID > 0)
                    {
                        return;
                    }

                    List<BEProducto> olstProducto = new List<BEProducto>();
                    using (ODSServiceClient svOds = new ODSServiceClient())
                    {
                        olstProducto = svOds.SelectProductoByCodigoDescripcionSearchRegionZona(
                            userData.PaisID, userData.CampaniaID, oBEConfiguracionProgramaNuevas.CUVKit, userData.RegionID,
                            userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1).ToList();
                    }

                    if (olstProducto != null && olstProducto.Count > 0)
                    {
                        var producto = olstProducto[0];
                        var model = new PedidoSb2Model();
                        model.TipoOfertaSisID = producto.TipoOfertaSisID;
                        model.ConfiguracionOfertaID = producto.ConfiguracionOfertaID;
                        model.IndicadorMontoMinimo = producto.IndicadorMontoMinimo.ToString().Trim();
                        model.MarcaID = Convert.ToByte(producto.MarcaID);
                        model.Cantidad = "1";
                        model.PrecioUnidad = producto.PrecioCatalogo;
                        model.CUV = oBEConfiguracionProgramaNuevas.CUVKit;
                        model.Tipo = 0;
                        model.DescripcionProd = producto.Descripcion;
                        model.Pagina = "0";
                        model.DescripcionEstrategia = producto.DescripcionEstrategia;
                        model.EsSugerido = false;
                        model.EsKitNueva = true;

                        Insert(model);
                    }
                }
                catch (Exception)
                {
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
                            Session["PedidoWebDetalle"] = null;
                            listaDetalle = ObtenerPedidoWebDetalle();

                            UpdPedidoWebMontosPROL();
                        }
                    }
                    
                    page = 1;
                    rows = listaDetalle.Count();
                }

                decimal total = listaDetalle.Sum(p => p.ImporteTotal);

                model.ListaCliente = (from item in listaDetalle
                                      select new BECliente { ClienteID = item.ClienteID, Nombre = item.Nombre }
                    ).GroupBy(x => x.ClienteID).Select(x => x.First()).ToList();
                model.ListaCliente.Insert(0, new BECliente { ClienteID = -1, Nombre = "-- TODOS --" });

                listaDetalle = listaDetalle.Where(p => p.ClienteID == clienteId || clienteId == -1).ToList();
                decimal totalCliente = listaDetalle.Sum(p => p.ImporteTotal);                

                var pedidoWebDetalleModel = Mapper.Map<List<BEPedidoWebDetalle>, List<PedidoWebDetalleModel>>(listaDetalle);

                pedidoWebDetalleModel.Update(p => p.Simbolo = userData.Simbolo);
                pedidoWebDetalleModel.Update(p=> p.CodigoIso = userData.CodigoISO);

                model.ListaDetalleModel = pedidoWebDetalleModel;
                model.Total = total;
                model.TotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
                model.TotalProductos = pedidoWebDetalleModel.Sum(p => Convert.ToInt32(p.Cantidad));

                BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();
                model.MontoAhorroCatalogo = bePedidoWebByCampania.MontoAhorroCatalogo;
                model.MontoAhorroRevista = bePedidoWebByCampania.MontoAhorroRevista;
                model.MontoDescuento = bePedidoWebByCampania.DescuentoProl;
                model.TotalConDescuento = total - bePedidoWebByCampania.DescuentoProl;

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

        private List<BEEscalaDescuento> GetParametriaOfertaFinal()
        {
            List<BEEscalaDescuento> listaParametriaOfertaFinal = new List<BEEscalaDescuento>();

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaParametriaOfertaFinal = sv.GetParametriaOfertaFinal(userData.PaisID).ToList() ?? new List<BEEscalaDescuento>();
                }
            }
            catch (Exception)
            {
                listaParametriaOfertaFinal = new List<BEEscalaDescuento>();
            }

            return listaParametriaOfertaFinal;                        
        }
        
        #endregion

        public JsonResult ObtenerProductosOfertaFinal(int tipoOfertaFinal)
        {
            var lista = new List<Producto>();
            try
            {
                string paisesConPcm = ConfigurationManager.AppSettings.Get("PaisesConPcm");
                int tipoProductoMostrar = paisesConPcm.Contains(userData.CodigoISO) ? 2 : 1;

                using (ProductoServiceClient ps = new ProductoServiceClient())
                {
                    lista = ps.ObtenerProductos(tipoOfertaFinal, userData.CodigoISO, userData.CampaniaID, userData.CodigoConsultora, 
                        userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, tipoProductoMostrar).ToList();
                }                

                var listaProductoModel = new List<ProductoModel>();
                foreach (var producto in lista)
                {
                    List<BEProducto> olstProducto = new List<BEProducto>();
                    using (ODSServiceClient sv = new ODSServiceClient())
                    {
                        olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID,userData.CampaniaID, producto.Cuv,
                            userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1).ToList();
                    }

                    if (olstProducto.Count != 0)
                    {
                        if (userData.OfertaFinal == Constantes.TipoOfertaFinalCatalogoPersonalizado.Arp)
                        {
                            string infoEstrategia;
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                infoEstrategia = sv.GetImagenOfertaPersonalizadaOF(userData.PaisID, userData.CampaniaID, olstProducto[0].CUV.Trim());
                            }

                            string descripcion = "";
                            string imagen = "";
                            if (!string.IsNullOrEmpty(infoEstrategia))
                            {
                                descripcion = infoEstrategia.Split('|')[0];
                                imagen = infoEstrategia.Split('|')[1];   
                            }                            

                            if (!string.IsNullOrEmpty(imagen))
                            {
                                string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                                string imagenUrl = ConfigS3.GetUrlFileS3(carpetapais, imagen, carpetapais);

                                listaProductoModel.Add(new ProductoModel()
                                {
                                    CUV = olstProducto[0].CUV.Trim(),
                                    Descripcion = descripcion,
                                    PrecioCatalogoString = Util.DecimalToStringFormat(olstProducto[0].PrecioCatalogo, userData.CodigoISO),
                                    PrecioCatalogo = olstProducto[0].PrecioCatalogo,
                                    MarcaID = olstProducto[0].MarcaID,
                                    EstaEnRevista = olstProducto[0].EstaEnRevista,
                                    TieneStock = true,
                                    EsExpoOferta = olstProducto[0].EsExpoOferta,
                                    CUVRevista = olstProducto[0].CUVRevista.Trim(),
                                    CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                                    IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                                    TipoOfertaSisID = olstProducto[0].TipoOfertaSisID,
                                    ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID,
                                    MensajeCUV = "",
                                    DesactivaRevistaGana = -1,
                                    DescripcionMarca = olstProducto[0].DescripcionMarca,
                                    DescripcionEstrategia = olstProducto[0].DescripcionEstrategia,
                                    DescripcionCategoria = olstProducto[0].DescripcionCategoria,
                                    FlagNueva = olstProducto[0].FlagNueva,
                                    TipoEstrategiaID = olstProducto[0].TipoEstrategiaID,
                                    ImagenProductoSugerido = imagenUrl,
                                    CodigoProducto = olstProducto[0].CodigoProducto,
                                    TieneStockPROL = true,
                                    PrecioValorizado = olstProducto[0].PrecioValorizado,
                                    PrecioValorizadoString = Util.DecimalToStringFormat(olstProducto[0].PrecioValorizado, userData.CodigoISO),
                                    Simbolo = userData.Simbolo
                                });
                            }
                        }
                        else
                        {
                            listaProductoModel.Add(new ProductoModel()
                            {
                                CUV = olstProducto[0].CUV.Trim(),
                                Descripcion = producto.NombreComercial,
                                PrecioCatalogoString = Util.DecimalToStringFormat(olstProducto[0].PrecioCatalogo, userData.CodigoISO),
                                PrecioCatalogo = olstProducto[0].PrecioCatalogo,
                                MarcaID = olstProducto[0].MarcaID,
                                EstaEnRevista = olstProducto[0].EstaEnRevista,
                                TieneStock = true,
                                EsExpoOferta = olstProducto[0].EsExpoOferta,
                                CUVRevista = olstProducto[0].CUVRevista.Trim(),
                                CUVComplemento = olstProducto[0].CUVComplemento.Trim(),
                                IndicadorMontoMinimo = olstProducto[0].IndicadorMontoMinimo.ToString().Trim(),
                                TipoOfertaSisID = olstProducto[0].TipoOfertaSisID,
                                ConfiguracionOfertaID = olstProducto[0].ConfiguracionOfertaID,
                                MensajeCUV = "",
                                DesactivaRevistaGana = -1,
                                DescripcionMarca = olstProducto[0].DescripcionMarca,
                                DescripcionEstrategia = olstProducto[0].DescripcionEstrategia,
                                DescripcionCategoria = olstProducto[0].DescripcionCategoria,
                                FlagNueva = olstProducto[0].FlagNueva,
                                TipoEstrategiaID = olstProducto[0].TipoEstrategiaID,
                                ImagenProductoSugerido = producto.Imagen,
                                CodigoProducto = olstProducto[0].CodigoProducto,
                                TieneStockPROL = true,
                                PrecioValorizado = olstProducto[0].PrecioValorizado,
                                PrecioValorizadoString = Util.DecimalToStringFormat(olstProducto[0].PrecioValorizado, userData.CodigoISO),
                                Simbolo = userData.Simbolo
                            });
                        }
                    }                    
                }

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
                    data = ""
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
    }
}
