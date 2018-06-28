using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseShowRoomController : BaseEstrategiaController
    {
        protected string CodigoProceso
        {
            get { return ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.EmailCodigoProceso]; }
        }

        protected void ActionExecutingMobile()
        {
            if (sessionManager.GetUserData() == null) return;

            var userData = UserData();
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
                    ViewBag.MostrarShowRoomBannerLateral = sessionManager.GetEsShowRoom() &&
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

                    EstrategiaPedidoModel ofertaDelDia = GetOfertaDelDiaModel();
                    ViewBag.OfertaDelDia = ofertaDelDia;

                    ViewBag.MostrarOfertaDelDia =
                        !userData.CloseOfertaDelDia
                        && userData.TieneOfertaDelDia
                        && ofertaDelDia != null
                        && ofertaDelDia.TeQuedan.TotalSeconds > 0;

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
            var esShowRoom = sessionManager.GetEsShowRoom();
            var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
            var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

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
                //showRoomEventoModel.ListaShowRoomOferta = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion);
                var listaShowRoomOfertas = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
                showRoomEventoModel.TieneOfertasAMostrar = listaShowRoomOfertas.Any();
                //showRoomEventoModel.ListaShowRoomCompraPorCompra = GetProductosCompraPorCompra(userData.EsDiasFacturacion, showRoomEventoModel.EventoID, showRoomEventoModel.CampaniaID);
                //showRoomEventoModel.ListaCategoria = GetCategoriasProductoShowRoom(showRoomEventoModel);
                showRoomEventoModel.ListaCategoria = configEstrategiaSR.ListaCategoria;
                showRoomEventoModel.PrecioMinFiltro = listaShowRoomOfertas.Min(p => p.Precio2);
                showRoomEventoModel.PrecioMaxFiltro = listaShowRoomOfertas.Max(p => p.Precio2);
                showRoomEventoModel.FiltersBySorting = _tablaLogicaProvider.ObtenerConfiguracion(userData.PaisID, Constantes.TablaLogica.OrdenamientoShowRoom);

                var tipoAplicacion = Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;
                if (GetIsMobileDevice()) tipoAplicacion = Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile;

                showRoomEventoModel.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones, tipoAplicacion);
                showRoomEventoModel.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
                showRoomEventoModel.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);
                if (GetIsMobileDevice())
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                    //showRoomEventoModel.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
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
                    //showRoomEventoModel.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
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
            //modelo.CodigoISO = userData.CodigoISO;
            //modelo.ListaOfertaShowRoom = GetOfertaListadoExcepto(id);
            //var listaDetalle = ObtenerPedidoWebDetalle();
            //modelo.ListaOfertaShowRoom.Update(o => o.Agregado = (listaDetalle.Find(p => p.CUV == o.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none");
            //modelo.FBMensaje = "";

            var tipoAplicacion = GetIsMobileDevice() ? Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                    : Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;

            //modelo.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
            //modelo.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);

            return modelo;
        }

        public EstrategiaPersonalizadaProductoModel GetOfertaConDetalle(int idOferta)
        {
            var ofertaShowRoomModelo = new EstrategiaPersonalizadaProductoModel();
            if (idOferta <= 0) return ofertaShowRoomModelo;

            //var listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, false);
            //ofertaShowRoomModelo = listadoOfertasTodasModel.Find(o => o.EstrategiaID == idOferta) ?? new EstrategiaPedidoModel();

            ofertaShowRoomModelo = sessionManager.ShowRoom.Ofertas.Find(o => o.EstrategiaID == idOferta) ?? new EstrategiaPersonalizadaProductoModel();

            if (ofertaShowRoomModelo.EstrategiaID <= 0) return ofertaShowRoomModelo;

            //ofertaShowRoomModelo.ImagenProducto = Util.Trim(ofertaShowRoomModelo.ImagenProducto);
            ofertaShowRoomModelo.FotoProducto01 = Util.Trim(ofertaShowRoomModelo.FotoProducto01) == "" ?
                "/Content/Images/showroom/no_disponible.png" :
                ofertaShowRoomModelo.FotoProducto01;

            var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
            {
                EstrategiaID = idOferta,
                CampaniaID = userData.CampaniaID,
                CodigoVariante = ofertaShowRoomModelo.CodigoEstrategia
            };

            ofertaShowRoomModelo.Hermanos = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, Constantes.TipoEstrategiaCodigo.ShowRoom);

            return ofertaShowRoomModelo;
        }

        public List<EstrategiaPersonalizadaProductoModel> GetOfertaListadoExcepto(int idOferta)
        {
            var listaOferta = new List<EstrategiaPersonalizadaProductoModel>();
            if (idOferta <= 0) return listaOferta;

            var listaOfertasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
            listaOferta = listaOfertasModel.Where(o => o.EstrategiaID != idOferta).ToList();
            return listaOferta;
        }

        public List<EstrategiaPersonalizadaProductoModel> ObtenerListaProductoShowRoom(int campaniaId, string codigoConsultora, bool esFacturacion = false, int tipoOferta = 1)
        {
            var listaProductoRetorno = new List<EstrategiaPersonalizadaProductoModel>();

            if (tipoOferta == 1 && sessionManager.ShowRoom.Ofertas != null)
                listaProductoRetorno = sessionManager.ShowRoom.Ofertas;
            else if (tipoOferta == 2 && sessionManager.ShowRoom.OfertasSubCampania != null)
                listaProductoRetorno = sessionManager.ShowRoom.OfertasSubCampania;
            else if (tipoOferta == 3 && sessionManager.ShowRoom.OfertasPerdio != null)
                listaProductoRetorno = sessionManager.ShowRoom.OfertasPerdio;

            if (listaProductoRetorno.Any())
            {
                var listaPedidoDetalle = ObtenerPedidoWebDetalle();
                listaProductoRetorno.Update(x =>
                {
                    x.IsAgregado = tipoOferta != 3 && listaPedidoDetalle.Any(p => p.CUV == x.CUV2);
                });
                return listaProductoRetorno;
            }

            //var listaShowRoomOfertas = _ofertaPersonalizadaProvider.GetShowRoomOfertasConsultora(userData);
            var listaProducto = _ofertaPersonalizadaProvider.GetShowRoomOfertasConsultora(userData);
            var listaProductoModel = ConsultarEstrategiasModelFormato(listaProducto);
            //var listaShowRoomOfertasModel = ObtenerListaShowRoomOfertasFormato(listaShowRoomOfertas, userData.EsDiasFacturacion);

            //SetShowRoomOfertasInSession(listaShowRoomOfertasModel);
            SetShowRoomOfertasInSession(listaProductoModel);

            if (tipoOferta == 1) return sessionManager.ShowRoom.Ofertas;
            else if (tipoOferta == 2) return sessionManager.ShowRoom.OfertasSubCampania;
            else if (tipoOferta == 3) return sessionManager.ShowRoom.OfertasPerdio;
            else return sessionManager.ShowRoom.Ofertas;
        }

        //[Obsolete("Por ahora no se usa")]
        //public List<EstrategiaPedidoModel> GetProductosCompraPorCompra(bool esFacturacion, int eventoId, int campaniaId)
        //{
        //    try
        //    {
        //        if (sessionManager.ShowRoom.OfertasCompraPorCompra != null)
        //        {
        //            var listadoOfertasTodasModel = sessionManager.ShowRoom.OfertasCompraPorCompra;
        //            listadoOfertasTodasModel.Update(x =>
        //            {
        //                x.DescripcionMarca = Util.GetDescripcionMarca(x.MarcaID);
        //                x.CodigoISO = userData.CodigoISO;
        //                x.Simbolo = userData.Simbolo;
        //            });
        //            return listadoOfertasTodasModel;
        //        }

        //        var listaShowRoomCpc = _ofertaPersonalizadaProvider.GetProductosCompraPorCompra(userData, eventoId);
        //        listaShowRoomCpc = ObtenerListaShowRoomOfertasMdo(listaShowRoomCpc);

        //        var listaTieneStock = new List<Lista>();
        //        var txtBuil = new StringBuilder();
        //        string codigoSap;

        //        if (esFacturacion)
        //        {
        //            foreach (var beProducto in listaShowRoomCpc)
        //            {
        //                if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
        //                {
        //                    txtBuil.Append(beProducto.CodigoProducto + "|");
        //                }
        //            }

        //            codigoSap = txtBuil.ToString();
        //            codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

        //            try
        //            {
        //                if (!string.IsNullOrEmpty(codigoSap))
        //                {
        //                    using (var sv = new wsConsulta())
        //                    {
        //                        sv.Url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
        //                        listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
        //                    }
        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

        //                listaTieneStock = new List<Lista>();
        //            }
        //        }

        //        var listaShowRoomCpcFinal = new List<EstrategiaPedidoModel>();
        //        txtBuil.Clear();

        //        foreach (var beShowRoomOferta in listaShowRoomCpc)
        //        {
        //            bool tieneStockProl = true;
        //            if (esFacturacion)
        //            {
        //                var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
        //                if (itemStockProl != null)
        //                    tieneStockProl = itemStockProl.estado == 1;
        //            }

        //            if (tieneStockProl)
        //            {
        //                txtBuil.Append(beShowRoomOferta.CodigoProducto + "|");
        //                listaShowRoomCpcFinal.Add(beShowRoomOferta);
        //            }
        //        }

        //        List<Producto> listaShowRoomProductoCatalogo;
        //        var numeroCampanias = Convert.ToInt32(_configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.NumeroCampanias));

        //        codigoSap = txtBuil.ToString();
        //        codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

        //        using (ProductoServiceClient sv = new ProductoServiceClient())
        //        {
        //            listaShowRoomProductoCatalogo = sv.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, campaniaId, codigoSap, numeroCampanias).ToList();
        //        }

        //        foreach (var item in listaShowRoomCpcFinal)
        //        {
        //            var beCatalogoPro = listaShowRoomProductoCatalogo.FirstOrDefault(p => p.CodigoSap == item.CodigoProducto);
        //            if (beCatalogoPro != null)
        //            {
        //                item.ImagenProducto = beCatalogoPro.Imagen;
        //                item.Descripcion = beCatalogoPro.NombreComercial;
        //                item.DescripcionLegal = beCatalogoPro.Descripcion;
        //            }
        //        }

        //        listaShowRoomCpcFinal.Update(x =>
        //        {
        //            x.DescripcionMarca = Util.GetDescripcionMarca(x.MarcaID);
        //            x.CodigoISO = userData.CodigoISO;
        //            x.Simbolo = userData.Simbolo;
        //        });
        //        sessionManager.ShowRoom.OfertasCompraPorCompra = listaShowRoomCpcFinal;

        //        return listaShowRoomCpcFinal;
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return null;
        //    }
        //}

        protected EstrategiaPersonalizadaProductoModel ObtenerPrimeraOfertaShowRoom()
        {
            //var ofertasShowRoom = _ofertaPersonalizadaProvider.GetShowRoomOfertasConsultora(userData);
            var ofertasShowRoom = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);

            //ofertasShowRoom = ObtenerListaShowRoomOfertasMdo(ofertasShowRoom);
            //ActualizarUrlImagenes(ofertasShowRoom);
            ofertasShowRoom.Update(x => x.DescripcionMarca = Util.GetDescripcionMarca(x.MarcaID));

            return ofertasShowRoom.FirstOrDefault() ?? new EstrategiaPersonalizadaProductoModel();
        }

        #region Metodos Privados

        private List<ShowRoomCategoriaModel> GetCategoriasProductoShowRoom(List<EstrategiaPedidoModel> listaShowRoomOferta)
        {
            var categorias = listaShowRoomOferta.GroupBy(p => p.CodigoCategoria).Select(p => p.First());
            var listaCategoria = categorias
                .Where(x => !string.IsNullOrEmpty(x.DescripcionCategoria))
                .Select(x => new ShowRoomCategoriaModel
                {
                    Codigo = x.CodigoCategoria,
                    Descripcion = x.DescripcionCategoria,
                    //EventoID = showRoomEventoModel.EventoID
                })
                .OrderBy(p => p.Descripcion).ToList();

            return listaCategoria;
        }

        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (sessionManager.GetUserData() != null)
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

        private void ActualizarUrlImagenes(List<EstrategiaPedidoModel> ofertasShowRoom)
        {
            ofertasShowRoom.Update(x =>
            {
                x.ImagenProducto = string.Empty;
                x.ImagenMini = string.Empty;
                if (string.IsNullOrEmpty(x.ImagenProducto))
                {
                    x.ImagenProducto = ConfigS3.GetUrlFileS3(ObtenerCarpetaPais(), x.ImagenProducto, ObtenerCarpetaPais());
                }
                if (string.IsNullOrEmpty(x.ImagenMini))
                {
                    x.ImagenProducto = ConfigS3.GetUrlFileS3(ObtenerCarpetaPais(), x.ImagenMini, ObtenerCarpetaPais());
                }
            });
        }

        private List<EstrategiaPedidoModel> ObtenerListaShowRoomOfertasMdo(List<EstrategiaPedidoModel> listaShowRoomOfertas, int flagRevistaValor = 0)
        {
            if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
            {
                listaShowRoomOfertas = listaShowRoomOfertas.Where(p => p.FlagRevista == (flagRevistaValor == 0 ? Constantes.FlagRevista.Valor0 : flagRevistaValor)).ToList();
            }
            return listaShowRoomOfertas;
        }

        private List<EstrategiaPedidoModel> ObtenerListaShowRoomOfertasFormato(List<EstrategiaPedidoModel> listaShowRoomOfertas, bool esFacturacion)
        {
            var listaTieneStock = new List<Lista>();
            if (esFacturacion)
            {
                try
                {
                    var codigoSap = string.Join("|", listaShowRoomOfertas.Where(x => (x.CodigoProducto ?? "") != "")
                        .Select(x => x.CodigoProducto).ToArray());
                    
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new wsConsulta())
                        {
                            sv.Url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
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

            var listaShowRoomOfertasFinal = new List<EstrategiaPedidoModel>();
            foreach (var itemShowRoom in listaShowRoomOfertas)
            {
                bool tieneStockProl = true;
                if (esFacturacion)
                {
                    var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == itemShowRoom.CodigoProducto);
                    if (itemStockProl != null)
                        tieneStockProl = itemStockProl.estado == 1;
                }
                if (tieneStockProl)
                {
                    listaShowRoomOfertasFinal.Add(itemShowRoom);
                }
            }

            ActualizarUrlImagenes(listaShowRoomOfertasFinal);
            var listaPedidoDetalle = ObtenerPedidoWebDetalle();

            listaShowRoomOfertasFinal.Update(x =>
            {
                x.DescripcionMarca = Util.GetDescripcionMarca(x.MarcaID);
                x.CodigoISO = userData.CodigoISO;
                x.Simbolo = userData.Simbolo;
                x.Agregado = (listaPedidoDetalle.Find(p => p.CUV == x.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none";
                string CodigoEstrategia = listaShowRoomOfertasFinal.Where(f => f.CUV == x.CUV).Select(o => o.CodigoEstrategia).FirstOrDefault();
                var bloqueado = revistaDigital.ActivoMdo && !x.EsSubCampania && x.FlagRevista != Constantes.FlagRevista.Valor0;
                x.TipoAccionAgregar = _ofertaPersonalizadaProvider.TipoAccionAgregar(0, Constantes.TipoEstrategiaCodigo.ShowRoom, false, bloqueado, CodigoEstrategia);
            });

            return listaShowRoomOfertasFinal;
        }

        private void SetShowRoomOfertasInSession(List<EstrategiaPedidoModel> listaProductoModel)
        {
            var flagRevistaTodos = new List<int>() { Constantes.FlagRevista.Valor0, Constantes.FlagRevista.Valor1, Constantes.FlagRevista.Valor2 };
            var listaOfertas = new List<EstrategiaPedidoModel>();
            var listaSubCampania = new List<EstrategiaPedidoModel>();
            var listaOfertasPerdio = new List<EstrategiaPedidoModel>();

            if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
            {
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                listaOfertasPerdio = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista != Constantes.FlagRevista.Valor0).ToList();
            }
            else if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && revistaDigital.EsActiva)
            {
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && flagRevistaTodos.Contains(x.FlagRevista)).ToList();
            }
            else if (revistaDigital.EsActiva && revistaDigital.ActivoMdo)
            {
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && flagRevistaTodos.Contains(x.FlagRevista)).ToList();
            }
            else if (!revistaDigital.ActivoMdo)
            {
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania).ToList();
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania).ToList();
            }
            else
            {
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
            }

            //configEstrategiaSR.ListaCategoria = GetCategoriasProductoShowRoom(listaOfertas);
            configEstrategiaSR.ListaCategoria = new List<ShowRoomCategoriaModel>();
            sessionManager.ShowRoom.Ofertas = ConsultarEstrategiasFormatearModelo(listaOfertas, 2);
            sessionManager.ShowRoom.OfertasSubCampania = ConsultarEstrategiasFormatearModelo(listaSubCampania, 2);
            sessionManager.ShowRoom.OfertasPerdio = ConsultarEstrategiasFormatearModelo(listaOfertasPerdio, 1);
        }

        #endregion
    }
}