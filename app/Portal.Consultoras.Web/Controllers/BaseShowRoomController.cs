using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.Areas.Mobile.Controllers;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseShowRoomController : BaseMobileController
    {
        protected void ActionExecutingMobile()
        {
            if (Session["UserData"] == null) return;
            
            var userData = UserData();
            ViewBag.CodigoCampania = userData.CampaniaID.ToString();

            try
            {
                ViewBag.EsMobile = 2;
                BuildMenuMobile(userData);
                CargarValoresGenerales(userData);

                ShowRoomModel ShowRoom = new ShowRoomModel();

                /*INICIO: PL20-1289*/
                bool mostrarBanner, permitirCerrarBanner = false;
                if (SiempreMostrarBannerPL20()) mostrarBanner = true;
                else if (NuncaMostrarBannerPL20()) mostrarBanner = false;
                else
                {
                    mostrarBanner = true;
                    permitirCerrarBanner = true;

                    if (userData.CloseBannerPL20) mostrarBanner = false;
                    else
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            var result = sv.ValidacionModificarPedidoSelectiva(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA, false, true, false);
                            if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado) mostrarBanner = false;
                        }
                    }
                }

                bool mostrarBannerTop = NuncaMostrarBannerTopPL20() ? false : true;
                ViewBag.MostrarBannerTopPL20 = mostrarBannerTop;
                
                if (mostrarBanner || mostrarBannerTop)
                {
                    ViewBag.PermitirCerrarBannerPL20 = permitirCerrarBanner;
                    ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                    ViewBag.ShowRoomBannerLateral = showRoomBannerLateral;
                    ViewBag.MostrarShowRoomBannerLateral = Session["EsShowRoom"].ToString() != "0" &&
                        !showRoomBannerLateral.ConsultoraNoEncontrada && !showRoomBannerLateral.ConsultoraNoEncontrada &&
                        showRoomBannerLateral.BEShowRoomConsultora.EventoConsultoraID != 0 && showRoomBannerLateral.EstaActivoLateral;
                    
                    if (showRoomBannerLateral.DiasFalta < 1)
                    {
                        ViewBag.MostrarShowRoomBannerLateral = false;
                    }

                    if (showRoomBannerLateral.DiasFalta > 0)
                    {
                        if (showRoomBannerLateral.DiasFalta > 1)
                        {
                            showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍAS";
                        }
                        else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍA"; }
                    }

                    ViewBag.ImagenPopupShowroomIntriga = showRoomBannerLateral.ImagenPopupShowroomIntriga;
                    ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                    ViewBag.ImagenPopupShowroomVenta = showRoomBannerLateral.ImagenPopupShowroomVenta;
                    ViewBag.ImagenBannerShowroomVenta = showRoomBannerLateral.ImagenBannerShowroomVenta;
                    ViewBag.DiasFaltantesLetras = showRoomBannerLateral.LetrasDias;
                    
                    OfertaDelDiaModel ofertaDelDia = GetOfertaDelDiaModel();
                    ViewBag.OfertaDelDia = ofertaDelDia;

                    ViewBag.MostrarOfertaDelDia =
                         userData.CloseOfertaDelDia 
                         ? false 
                         : (userData.TieneOfertaDelDia && ofertaDelDia != null && ofertaDelDia.TeQuedan.TotalSeconds > 0);

                    showRoomBannerLateral.EstadoActivo = mostrarBannerTop ? "0" : "1";
                }
                ViewBag.MostrarBannerPL20 = mostrarBanner;
                ViewBag.MostrarBannerOtros = mostrarBannerTop;

                ViewBag.EstadoActivo = mostrarBannerTop ? "0" : "1";

                if (mostrarBanner)
                {
                    if (!(
                        (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2)
                        || userData.IndicadorGPRSB == 0)
                    )
                    {
                        ViewBag.MostrarBannerPL20 = false;
                        ViewBag.MostrarOfertaDelDia = false;
                    }
                }

                /*FIN: PL20-1289*/
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }
        
        private bool SiempreMostrarBannerPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            return false;
        }

        private bool NuncaMostrarBannerPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            //if (controllerName == "CatalogoPersonalizado" && actionName == "Index") return true;
            //if (controllerName == "CatalogoPersonalizado" && actionName == "Producto") return true;
            //if (controllerName == "ShowRoom") return true;
            if (controllerName == "Pedido") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            if (controllerName == "ShowRoom") return true;
            if (controllerName == "SeguimientoPedido") return true;
            if (controllerName == "PedidosFacturados") return true;
            if (controllerName == "EstadoCuenta") return true;
            if (controllerName == "Cliente") return true;
            if (controllerName == "OfertaLiquidacion") return true;
            if (controllerName == "ConsultoraOnline") return true;
            if (controllerName == "ProductosAgotados") return true;
            if (controllerName == "Catalogo") return true;
            if (controllerName == "MiAsesorBelleza") return true;
            if (controllerName == "Notificaciones") return true;
            return false;
        }

        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (Session["UserData"] != null)
            {
                ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
                int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
                if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim(); 

                ViewBag.NumeroCampania = userData.NombreCorto.Substring(4);
                ViewBag.EsUsuarioComunidad = userData.EsUsuarioComunidad ? 1 : 0;
                ViewBag.AnalyticsCampania = userData.CampaniaID;
                ViewBag.AnalyticsSegmento = string.IsNullOrEmpty(userData.Segmento) ? "(not available)" : userData.Segmento.Trim();
                ViewBag.AnalyticsEdad = Util.Edad(userData.FechaNacimiento);
                ViewBag.AnalyticsZona = userData.CodigoZona;
                ViewBag.AnalyticsPais = userData.CodigoISO;
                ViewBag.AnalyticsRol = "Consultora";
                ViewBag.AnalyticsRegion = userData.CodigorRegion;
                ViewBag.AnalyticsSeccion = string.IsNullOrEmpty(userData.SeccionAnalytics) ? "(not available)" : userData.SeccionAnalytics;
                ViewBag.AnalyticsCodigoConsultora = string.IsNullOrEmpty(userData.CodigoConsultora) ? "(not available)" : userData.CodigoConsultora;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                if (fechaHoy >= userData.FechaInicioCampania.Date && fechaHoy <= userData.FechaFinCampania.Date)
                    ViewBag.AnalyticsPeriodo = "Facturacion";
                else
                    ViewBag.AnalyticsPeriodo = "Venta";

                ViewBag.AnalyticsSegmentoConstancia = string.IsNullOrEmpty(userData.SegmentoConstancia) ? "(not available)" : userData.SegmentoConstancia.Trim();
                ViewBag.AnalyticsSociaNivel = string.IsNullOrEmpty(userData.DescripcionNivel) ? "(not available)" : userData.DescripcionNivel;
            }
        }

        private bool NuncaMostrarBannerTopPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            //if (controllerName == "CatalogoPersonalizado" && actionName == "Index") return true;
            //if (controllerName == "CatalogoPersonalizado" && actionName == "Producto") return true;
            //if (controllerName == "ShowRoom") return true;
            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            if (controllerName == "Pedido") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            if (controllerName == "ShowRoom") return true;
            if (controllerName == "SeguimientoPedido") return true;
            if (controllerName == "PedidosFacturados") return true;
            if (controllerName == "OfertaLiquidacion") return true;
            return false;
        }

        public bool ValidarIngresoShowRoom(bool esIntriga)
        {
            if (!userData.CargoEntidadesShowRoom) return false; // throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");

            bool resultado = false;
            var showRoomEvento = new BEShowRoomEvento();
            var showRoomEventoConsultora = new BEShowRoomEventoConsultora();

            showRoomEventoConsultora = userData.BeShowRoomConsultora;
            showRoomEvento = userData.BeShowRoom;

            if (showRoomEvento != null && showRoomEvento.Estado == 1 && showRoomEventoConsultora != null)
            {
                int diasAntes = showRoomEvento.DiasAntes;
                int diasDespues = showRoomEvento.DiasDespues;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                if (esIntriga)
                {
                    if (!(fechaHoy >= userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Date
                    && fechaHoy <= userData.FechaInicioCampania.AddDays(showRoomEvento.DiasDespues).Date))
                    {
                        TimeSpan ts = userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes) - fechaHoy;

                        ViewBag.DiasFaltan = ts.Days; //userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Day - fechaHoy.Day;
                        if (ViewBag.DiasFaltan > 0)
                        {
                            resultado = true;
                        }
                    }
                }
                else
                {
                    if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date &&
                     fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date))
                    {
                        resultado = true;
                    }
                }
            }

            return resultado;
        }

        public List<ShowRoomOfertaModel> ObtenerListaProductoShowRoom(int campaniaId, string codigoConsultora, bool esFacturacion = false)
        {
            var listaShowRoomOferta = new List<BEShowRoomOferta>();
            //var listaShowRoomOfertaModel = new List<ShowRoomOfertaModel>();
            var listaShowRoomOfertaFinal = new List<BEShowRoomOferta>();

            var listaDetalle = ObtenerPedidoWebDetalle();

            if (Session[Constantes.ConstSession.ListaProductoShowRoom] != null)
            {
                var listadoOfertasTodas = (List<BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoom];
                var listadoOfertasTodasModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listadoOfertasTodas);
                listadoOfertasTodasModel.Update(x =>
                {
                    x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                    x.CodigoISO = userData.CodigoISO;
                    x.Simbolo = userData.Simbolo;
                    x.Agregado = (listaDetalle.Find(p => p.CUV == x.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none";
                });
                return listadoOfertasTodasModel;
            }

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, campaniaId, codigoConsultora).ToList();
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                if (listaShowRoomOferta != null)
                {
                    listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                    listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));
                }
            }

            var listaTieneStock = new List<Lista>();
            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                string codigoSap = "";
                foreach (var beProducto in listaShowRoomOferta)
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
                            sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
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

            foreach (var beShowRoomOferta in listaShowRoomOferta)
            {
                bool tieneStockProl = true;
                if (esFacturacion)
                {
                    var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
                    if (itemStockProl != null)
                        tieneStockProl = itemStockProl.estado == 1;
                }

                if (tieneStockProl)
                {
                    listaShowRoomOfertaFinal.Add(beShowRoomOferta);
                }
            }

            //Session[Constantes.ConstSession.ListaProductoShowRoom] = null;
            Session[Constantes.ConstSession.ListaProductoShowRoom] = listaShowRoomOfertaFinal;            

            var listadoOfertasTodasModel1 = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOfertaFinal);
            listadoOfertasTodasModel1.Update(x =>
            {
                x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                x.CodigoISO = userData.CodigoISO;
                x.Simbolo = userData.Simbolo;
                x.Agregado = (listaDetalle.Find(p => p.CUV == x.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none";
                x.UrlCompartir = GetUrlCompartirFB();
            });
            return listadoOfertasTodasModel1;
        }

        public List<ShowRoomOfertaModel> GetProductosCompraPorCompra(bool esFacturacion, int eventoId, int campaniaId)
        {
            try
            {
                var listaShowRoomCPC = new List<BEShowRoomOferta>();
                var listaShowRoomCPCFinal = new List<BEShowRoomOferta>();

                if (Session[Constantes.ConstSession.ListaProductoShowRoomCpc] != null)
                {
                    var listadoOfertasTodas = (List<BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoomCpc];
                    var listadoOfertasTodasModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listadoOfertasTodas);
                    listadoOfertasTodasModel.Update(x =>
                    {
                        x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                        x.CodigoISO = userData.CodigoISO;
                        x.Simbolo = userData.Simbolo;
                    });
                    return listadoOfertasTodasModel;
                }

                var NumeroCampanias = Convert.ToInt32(ConfigurationManager.AppSettings["NumeroCampanias"]);
                var listaShowRoomProductoCatalogo = new List<Producto>();

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaShowRoomCPC = sv.GetProductosCompraPorCompra(userData.PaisID, eventoId, campaniaId).ToList();
                }

                string codigoSap = "";
                var listaTieneStock = new List<Lista>();
                if (esFacturacion)
                {
                    foreach (var beProducto in listaShowRoomCPC)
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
                                sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
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

                codigoSap = "";
                foreach (var beShowRoomOferta in listaShowRoomCPC)
                {
                    bool tieneStockProl = true;
                    if (esFacturacion)
                    {
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
                        if (itemStockProl != null)
                            tieneStockProl = itemStockProl.estado == 1;
                    }

                    if (tieneStockProl)
                    {
                        codigoSap += beShowRoomOferta.CodigoProducto + "|";
                        listaShowRoomCPCFinal.Add(beShowRoomOferta);
                    }
                }

                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);
                using (ProductoServiceClient sv = new ProductoServiceClient())
                {
                    listaShowRoomProductoCatalogo = sv.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, campaniaId, codigoSap, NumeroCampanias).ToList();
                }

                foreach (var item in listaShowRoomCPCFinal)
                {
                    var beCatalogoPro = listaShowRoomProductoCatalogo.FirstOrDefault(p => p.CodigoSap == item.CodigoProducto);
                    if (beCatalogoPro != null)
                    {
                        item.ImagenProducto = beCatalogoPro.Imagen;
                        item.Descripcion = beCatalogoPro.NombreComercial;
                        item.DescripcionLegal = beCatalogoPro.Descripcion;
                        //item.PrecioOferta = beCatalogoPro.PrecioValorizado;
                    }
                }

                Session[Constantes.ConstSession.ListaProductoShowRoomCpc] = listaShowRoomCPCFinal;
                var listadoProductosCPCModel1 = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomCPCFinal);
                listadoProductosCPCModel1.Update(x =>
                {
                    x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                    x.CodigoISO = userData.CodigoISO;
                    x.Simbolo = userData.Simbolo;
                });

                return listadoProductosCPCModel1;
            }
            catch (Exception)
            {
                return null;
                throw;

            }
        }

        public string GetDescripcionMarca(int marcaId)
        {
            string result = string.Empty;

            switch (marcaId)
            {
                case 1:
                    result = "Lbel";
                    break;
                case 2:
                    result = "Esika";
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
                    result = "NO DISPONIBLE";
                    break;
            }

            return result;
        }

        public ShowRoomOfertaModel ViewDetalleOferta(int id)
        {
            var modelo = GetOfertaConDetalle(id);
            modelo.CodigoISO = userData.CodigoISO;
            modelo.ListaOfertaShowRoom = GetOfertaListadoExcepto(id);
            var listaDetalle = ObtenerPedidoWebDetalle();
            modelo.ListaOfertaShowRoom.Update(o => o.Agregado = (listaDetalle.Find(p => p.CUV == o.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none");

            // redes sociales
            modelo.FBRuta = GetUrlCompartirFB();
            //var mensaje = "";
            //modelo.ListaDetalleOfertaShowRoom.ToList().ForEach(d => mensaje += d.NombreProducto + " + ");
            //mensaje = Util.Trim(mensaje);
            //mensaje = mensaje.EndsWith("+") ? mensaje.Substring(0, mensaje.Length - 1) : mensaje;
            modelo.FBMensaje = ""; //modelo.Descripcion + ": " + Util.Trim(mensaje);

            // agrupar por marca
            modelo.ListaDetalleOfertaShowRoom = modelo.ListaDetalleOfertaShowRoom.OrderBy(d => d.MarcaProducto).ToList();
            var nombreMarca = "";
            modelo.ListaDetalleOfertaShowRoom.Update(d =>
            {
                d.MarcaProducto = d.MarcaProducto == nombreMarca 
                    ? "" : 
                    d.MarcaProducto;
                nombreMarca = d.MarcaProducto == ""
                    ? nombreMarca
                    : d.MarcaProducto == nombreMarca
                        ? nombreMarca
                        : d.MarcaProducto;
            });

            bool esMovil = Request.Browser.IsMobileDevice;
            var tipoAplicacion = esMovil
                    ? Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                    : Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;
            
            modelo.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
            modelo.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);            

            return modelo;
        }

        public ShowRoomOfertaModel GetOfertaConDetalle(int idOferta)
        {
            var ofertaShowRoomModelo = new ShowRoomOfertaModel();
            //var modelo = new ShowRoomOfertaModel();
            ofertaShowRoomModelo.ListaDetalleOfertaShowRoom = new List<ShowRoomOfertaDetalleModel>();

            if (idOferta <= 0) return ofertaShowRoomModelo;

            var listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);

            ofertaShowRoomModelo = listadoOfertasTodasModel.Find(o => o.OfertaShowRoomID == idOferta) ?? new ShowRoomOfertaModel();

            //modelo = (ShowRoomOfertaModel) ofertaShowRoomModelo.Clone();            

            if (ofertaShowRoomModelo.OfertaShowRoomID <= 0) return ofertaShowRoomModelo;

            ofertaShowRoomModelo.ImagenProducto = Util.Trim(ofertaShowRoomModelo.ImagenProducto);
            ofertaShowRoomModelo.ImagenProducto = ofertaShowRoomModelo.ImagenProducto == "" ? "/Content/Images/showroom/no_disponible.png" : ofertaShowRoomModelo.ImagenProducto;

            var listaDetalle = new List<BEShowRoomOfertaDetalle>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaDetalle = sv.GetProductosShowRoomDetalle(userData.PaisID, userData.CampaniaID, ofertaShowRoomModelo.CUV).ToList();
            }

            ofertaShowRoomModelo.ListaDetalleOfertaShowRoom = Mapper.Map<List<BEShowRoomOfertaDetalle>, List<ShowRoomOfertaDetalleModel>>(listaDetalle);

            ofertaShowRoomModelo.ListaDetalleOfertaShowRoom = ofertaShowRoomModelo.ListaDetalleOfertaShowRoom ?? new List<ShowRoomOfertaDetalleModel>();

            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            ofertaShowRoomModelo.ListaDetalleOfertaShowRoom.Update(p =>
            {
                p.Imagen = string.IsNullOrEmpty(p.Imagen)
                    ? "/Content/Images/showroom/no_disponible.png"
                    : ConfigS3.GetUrlFileS3(carpetaPais, p.Imagen, Globals.UrlMatriz + "/" + userData.CodigoISO);
            });

            return ofertaShowRoomModelo;

        }

        public List<ShowRoomOfertaModel> GetOfertaListadoExcepto(int idOferta)
        {
            var listaOferta = new List<ShowRoomOfertaModel>();
            if (idOferta <= 0) return listaOferta;

            var listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);
            listaOferta = listadoOfertasTodasModel.Where(o => o.OfertaShowRoomID != idOferta).ToList();
            return listaOferta;
        }

        public ShowRoomEventoModel CargarValoresModel()
        {
            ShowRoomEventoModel showRoomEventoModel;

            try
            {
                var showRoomEvento = userData.BeShowRoom;
                var codigoConsultora = userData.CodigoConsultora;

                Mapper.CreateMap<BEShowRoomEvento, ShowRoomEventoModel>()
                    .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Tema, f => f.MapFrom(c => c.Tema))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                    .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                    .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento))
                    .ForMember(t => t.TieneCategoria, f => f.MapFrom(c => c.TieneCategoria))
                    .ForMember(t => t.TieneCompraXcompra, f => f.MapFrom(c => c.TieneCompraXcompra))
                    .ForMember(t => t.TieneSubCampania, f => f.MapFrom(c => c.TieneSubCampania));

                showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                showRoomEventoModel.Simbolo = userData.Simbolo;
                showRoomEventoModel.CodigoIso = userData.CodigoISO;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                var listaShowRoomOferta = ObtenerListaProductoShowRoom(userData.CampaniaID, codigoConsultora, esFacturacion);
                showRoomEventoModel.ListaShowRoomOferta = listaShowRoomOferta;

                //var listaDetalle = ObtenerPedidoWebDetalle();
                //showRoomEventoModel.ListaShowRoomOferta.Update(o => o.Agregado = (listaDetalle.Find(p => p.CUV == o.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none");

                var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, showRoomEventoModel.EventoID,
                    showRoomEventoModel.CampaniaID);
                showRoomEventoModel.ListaShowRoomCompraPorCompra = listaCompraPorCompra;

                var listaCategoria = new List<ShowRoomCategoriaModel>();
                var categorias = listaShowRoomOferta.GroupBy(p => p.CodigoCategoria).Select(p => p.First());
                foreach (var item in categorias)
                {
                    var beCategoria = new ShowRoomCategoriaModel();
                    beCategoria.Codigo = item.CodigoCategoria;
                    beCategoria.Descripcion = item.DescripcionCategoria;
                    beCategoria.EventoID = showRoomEventoModel.EventoID;
                    listaCategoria.Add(beCategoria);
                }

                listaCategoria = listaCategoria.OrderBy(p => p.Descripcion).ToList();

                showRoomEventoModel.ListaCategoria = listaCategoria;

                bool esMovil = Request.Browser.IsMobileDevice;
                var tipoAplicacion = esMovil
                    ? Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                    : Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;      
                
                showRoomEventoModel.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones, tipoAplicacion);
                showRoomEventoModel.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
                showRoomEventoModel.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);

                if (esMovil)
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                }
                else
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ImagenFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoContenidoOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoContenidoOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoBotonVerMasOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoBotonVerMasOfertaSubCampania, tipoAplicacion);
                    
                }                                
            }
            catch (Exception ex)
            {
                showRoomEventoModel = new ShowRoomEventoModel();
            }            

            return showRoomEventoModel;
        }

    }
}