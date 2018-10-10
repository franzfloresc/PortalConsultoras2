using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;


namespace Portal.Consultoras.Web.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]

    public class BaseShowRoomController: BaseController
    {

        public BaseShowRoomController():base() { }

        protected string CodigoProceso
        {
            get { return ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.EmailCodigoProceso]; }
        }

        protected void ActionExecutingMobile()
        {
            if (SessionManager.GetUserData() == null) return;

            //var userData = UserData();
            ViewBag.CodigoCampania = userData.CampaniaID.ToString();

            try
            {
                ViewBag.EsMobile = 2;
                BuildMenuMobile(userData, revistaDigital);
                CargarValoresGenerales(userData);

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
                            var result = sv.ValidacionModificarPedidoSelectiva(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, 
                                userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA, false, true, false);
                            if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado) mostrarBanner = false;
                        }
                    }
                }

                bool mostrarBannerTop = !NuncaMostrarBannerTopPL20();
                ViewBag.MostrarBannerTopPL20 = mostrarBannerTop;

                if (mostrarBanner || mostrarBannerTop)
                {
                    ViewBag.PermitirCerrarBannerPL20 = permitirCerrarBanner;
                    ShowRoomBannerLateralModel showRoomBannerLateral = _showRoomProvider.GetShowRoomBannerLateral(userData.CodigoISO, userData.ZonaHoraria, userData.FechaInicioCampania);
                    ViewBag.ShowRoomBannerLateral = showRoomBannerLateral;
                    ViewBag.MostrarShowRoomBannerLateral = SessionManager.GetEsShowRoom() &&
                        !showRoomBannerLateral.ConsultoraNoEncontrada && !showRoomBannerLateral.ConsultoraNoEncontrada &&
                        showRoomBannerLateral.BEShowRoomConsultora.EventoConsultoraID != 0 && showRoomBannerLateral.EstaActivoLateral;

                    if (showRoomBannerLateral.DiasFalta < 1)
                    {
                        ViewBag.MostrarShowRoomBannerLateral = false;
                    }

                    ViewBag.ImagenPopupShowroomIntriga = showRoomBannerLateral.ImagenPopupShowroomIntriga;
                    ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                    ViewBag.ImagenPopupShowroomVenta = showRoomBannerLateral.ImagenPopupShowroomVenta;
                    ViewBag.ImagenBannerShowroomVenta = showRoomBannerLateral.ImagenBannerShowroomVenta;
                    ViewBag.DiasFaltantesLetras = showRoomBannerLateral.LetrasDias;
                    
                    ViewBag.MostrarOfertaDelDia = _ofertaDelDiaProvider.MostrarOfertaDelDia(userData);

                    showRoomBannerLateral.EstadoActivo = mostrarBannerTop ? "0" : "1";
                }

                ViewBag.MostrarBannerPL20 = mostrarBanner;
                ViewBag.MostrarBannerOtros = mostrarBannerTop;
                ViewBag.EstadoActivo = mostrarBannerTop ? "0" : "1";

                if (mostrarBanner
                    && !(
                            (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2)
                            || userData.IndicadorGPRSB == 0
                        )
                )
                {
                    ViewBag.MostrarBannerPL20 = false;
                    ViewBag.MostrarOfertaDelDia = false;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        public bool ValidarIngresoShowRoom(bool esIntriga)
        {
            if (!configEstrategiaSR.CargoEntidadesShowRoom)
                return false;

            var resultado = false;
            var esShowRoom = SessionManager.GetEsShowRoom();
            var mostrarShowRoomProductos = SessionManager.GetMostrarShowRoomProductos();
            var mostrarShowRoomProductosExpiro = SessionManager.GetMostrarShowRoomProductosExpiro();

            if (esIntriga)
            {
                resultado = esShowRoom && !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }

            if (!esIntriga)
            {
                resultado = esShowRoom && mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }

            return resultado;
        }

        public ShowRoomEventoModel CargarValoresModel()
        {
            ShowRoomEventoModel showRoomEventoModel;

            try
            {
                showRoomEventoModel = configEstrategiaSR.BeShowRoom;
                showRoomEventoModel.Simbolo = userData.Simbolo;
                showRoomEventoModel.CodigoIso = userData.CodigoISO;

                var listaShowRoomOfertas = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
                showRoomEventoModel.TieneOfertasAMostrar = listaShowRoomOfertas.Any();

                showRoomEventoModel.ListaCategoria = configEstrategiaSR.ListaCategoria;
                if (listaShowRoomOfertas.Any())
                {
                    showRoomEventoModel.PrecioMinFiltro = listaShowRoomOfertas.Min(p => p.Precio2);
                    showRoomEventoModel.PrecioMaxFiltro = listaShowRoomOfertas.Max(p => p.Precio2);
                }
                showRoomEventoModel.FiltersBySorting = _tablaLogicaProvider.ObtenerConfiguracion(userData.PaisID, Constantes.TablaLogica.OrdenamientoShowRoom);

                var tipoAplicacion = Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;
                if (GetIsMobileDevice()) tipoAplicacion = Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile;

                List<ShowRoomPersonalizacionModel> listaPersonalizacion = new List<ShowRoomPersonalizacionModel>();

                if (_showRoomProvider.UsarMsPersonalizacion(userData.CodigoISO, Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    UsuarioModel model = new UsuarioModel
                    {
                        CodigoISO = userData.CodigoISO,
                        CampaniaID = userData.CampaniaID
                    };
                    listaPersonalizacion= _showRoomProvider.GetShowRoomPersonalizacion(model);
                    listaPersonalizacion.ForEach(item => item.Valor = item.TipoAtributo == "IMAGEN" ? ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + model.CodigoISO, item.Valor) : item.Valor);
                }
                else
                {
                    listaPersonalizacion = SessionManager.GetEstrategiaSR().ListaPersonalizacionConsultora;
                }

                showRoomEventoModel.UrlTerminosCondiciones = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones, tipoAplicacion);
                showRoomEventoModel.TextoCondicionCompraCpc = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
                showRoomEventoModel.TextoDescripcionLegalCpc = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);
                if (GetIsMobileDevice())
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Mobile.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                }
                else
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoTituloOfertaSubCampania, tipoAplicacion);

                    showRoomEventoModel.ImagenFondoTituloOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoContenidoOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoContenidoOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoBotonVerMasOfertaSubCampania = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(listaPersonalizacion, Constantes.ShowRoomPersonalizacion.Desktop.TextoBotonVerMasOfertaSubCampania, tipoAplicacion);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                showRoomEventoModel = new ShowRoomEventoModel();
            }

            return showRoomEventoModel;
        }

        protected virtual bool GetIsMobileDevice()
        {
            return Request.Browser.IsMobileDevice;
        }

        protected class ShowRoomQueryStringValidator
        {
            private readonly int CODIGO_PROCESO_INDEX = 0;
            private readonly int CODIGO_ISO_INDEX = 1;
            private readonly int CODIGO_CONSULTORA_INDEX = 2;
            private readonly int CAMPANIA_ID_INDEX = 3;
            private readonly int OFERTA_ID_INDEX = 5;
            private readonly char SEPARATOR = ';';
            private string QueryString { get; set; }

            public ShowRoomQueryStringValidator(string queryString)
            {
                if (!string.IsNullOrEmpty(queryString))
                {
                    LoadParameterValuesFromQueryString(queryString);
                }
            }

            private void LoadParameterValuesFromQueryString(string queryString)
            {
                QueryString = Util.Decrypt(queryString);
                var paramValues = QueryString.Split(SEPARATOR);
                if (CODIGO_PROCESO_INDEX < paramValues.Length) CodigoProceso = paramValues[CODIGO_PROCESO_INDEX];
                if (CODIGO_ISO_INDEX < paramValues.Length) CodigoIso = paramValues[CODIGO_ISO_INDEX];
                if (CODIGO_CONSULTORA_INDEX < paramValues.Length) CodigoConsultora = paramValues[CODIGO_CONSULTORA_INDEX];
                if (CAMPANIA_ID_INDEX < paramValues.Length && !string.IsNullOrEmpty(paramValues[CAMPANIA_ID_INDEX]))
                    CampanaId = Convert.ToInt32(paramValues[CAMPANIA_ID_INDEX]);

                if (OFERTA_ID_INDEX < paramValues.Length &&
                    !string.IsNullOrEmpty(paramValues[OFERTA_ID_INDEX]))
                    OfertaId = Convert.ToInt32(paramValues[OFERTA_ID_INDEX]);
            }

            public string CodigoProceso { get; private set; }
            public string CodigoIso { get; private set; }
            public string CodigoConsultora { get; private set; }
            public int CampanaId { get; private set; }
            public int OfertaId { get; private set; }
        }

        protected virtual string ObtenerCarpetaPais()
        {
            return Globals.UrlMatriz + "/" + userData.CodigoISO;
        }

        public EstrategiaPersonalizadaProductoModel ViewDetalleOferta(int id)
        {
            var modelo = GetOfertaConDetalle(id);
            return modelo;
        }

        public EstrategiaPersonalizadaProductoModel GetOfertaConDetalle(int idOferta)
        {
            var ofertaShowRoomModelo = new EstrategiaPersonalizadaProductoModel();
            if (idOferta <= 0) return ofertaShowRoomModelo;
            
            ofertaShowRoomModelo = SessionManager.ShowRoom.Ofertas.Find(o => o.EstrategiaID == idOferta) ?? new EstrategiaPersonalizadaProductoModel();

            if (ofertaShowRoomModelo.EstrategiaID <= 0) return ofertaShowRoomModelo;
            
            ofertaShowRoomModelo.FotoProducto01 = Util.Trim(ofertaShowRoomModelo.FotoProducto01) == "" ?
                "/Content/Images/showroom/no_disponible.png" :
                ofertaShowRoomModelo.FotoProducto01;

            var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
            {
                EstrategiaID = idOferta,
                CampaniaID = userData.CampaniaID,
                CodigoVariante = ofertaShowRoomModelo.CodigoEstrategia
            };

            bool esMultimarca = false;
            string mensaje = "";
            ofertaShowRoomModelo.Hermanos = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, Constantes.TipoEstrategiaCodigo.ShowRoom, out esMultimarca, out mensaje);

            return ofertaShowRoomModelo;
        }

        public List<EstrategiaPersonalizadaProductoModel> GetOfertaListadoExcepto(int idOferta)
        {
            var listaOferta = new List<EstrategiaPersonalizadaProductoModel>();

            if (idOferta <= 0) return listaOferta;

            var listaOfertasModel = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
            listaOferta = listaOfertasModel.Where(o => o.EstrategiaID != idOferta).ToList();
            return listaOferta;
        }

        protected EstrategiaPersonalizadaProductoModel ObtenerPrimeraOfertaShowRoom()
        {
            var ofertasShowRoom = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
            
            ofertasShowRoom.Update(x => x.DescripcionMarca = Util.GetDescripcionMarca(x.MarcaID));

            return ofertasShowRoom.FirstOrDefault() ?? new EstrategiaPersonalizadaProductoModel();
        }

        #region Metodos Privados

        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (SessionManager.GetUserData() != null)
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

            return controllerName == "Pedido"
                || controllerName == "CatalogoPersonalizado"
                || controllerName == "ShowRoom"
                || controllerName == "SeguimientoPedido"
                || controllerName == "PedidosFacturados"
                || controllerName == "EstadoCuenta"
                || controllerName == "Cliente"
                || controllerName == "OfertaLiquidacion"
                || controllerName == "ConsultoraOnline"
                || controllerName == "ProductosAgotados"
                || controllerName == "Catalogo"
                || controllerName == "MiAsesorBelleza"
                || controllerName == "Notificaciones";
        }

        private bool NuncaMostrarBannerTopPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            return (controllerName == "Bienvenida" && actionName == "Index")
                   || controllerName == "Pedido"
                   || controllerName == "CatalogoPersonalizado"
                   || controllerName == "ShowRoom"
                   || controllerName == "SeguimientoPedido"
                   || controllerName == "PedidosFacturados"
                   || controllerName == "OfertaLiquidacion";

        }

        #endregion
    }
}