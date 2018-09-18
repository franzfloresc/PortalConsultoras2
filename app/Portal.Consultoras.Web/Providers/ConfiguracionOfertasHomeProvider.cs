using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using Portal.Consultoras.Web.LogManager;

namespace Portal.Consultoras.Web.Providers
{
    public class ConfiguracionOfertasHomeProvider
    {
        public virtual ISessionManager SessionManager { get; private set; }
        public virtual ILogManager LogManager { get; private set; }
        public virtual ConfiguracionPaisProvider ConfiguracionPais { get; private set; }
        public virtual GuiaNegocioProvider GuiaNegocio { get; private set; }
        public virtual ShowRoomProvider ShowRoom { get; private set; }

        private UsuarioModel userData
        {
            get
            {
                return SessionManager.GetUserData() ?? new UsuarioModel();
            }
        }

        private MenuContenedorModel menuActivo
        {
            get
            {
                return SessionManager.GetMenuContenedorActivo() ?? new MenuContenedorModel();
            }
        }

        public ConfiguracionOfertasHomeProvider()
            : this (Web.SessionManager.SessionManager.Instance,
                    Web.LogManager.LogManager.Instance,
                   new ConfiguracionPaisProvider(),
                   new GuiaNegocioProvider(),
                   new ShowRoomProvider())
        {
        }

        public ConfiguracionOfertasHomeProvider(ISessionManager sessionManager,
            ILogManager logManager,
            ConfiguracionPaisProvider configuracionPaisProvider,
            GuiaNegocioProvider guiaNegocio,
            ShowRoomProvider showRoom)
        {
            SessionManager = sessionManager;
            LogManager = logManager;
            ConfiguracionPais = configuracionPaisProvider;
            GuiaNegocio = guiaNegocio;
            ShowRoom = showRoom;
        }

        public virtual List<ConfiguracionSeccionHomeModel> ObtenerConfiguracionSeccion(RevistaDigitalModel revistaDigital, bool esMobile)
        {
            var seccionesContenedorModel = new List<ConfiguracionSeccionHomeModel>();

            try
            {
                if (userData == null || revistaDigital == null) return seccionesContenedorModel;
                if (menuActivo.CampaniaId <= 0) menuActivo.CampaniaId = userData.CampaniaID;

                var seccionesContenedor = GetSeccionesContenedor();
                seccionesContenedor = GetSeccionesContenedorByCampania(seccionesContenedor);

                var isMobile = esMobile;
                foreach (var beConfiguracionOfertasHome in seccionesContenedor)
                {
                    var entConf = beConfiguracionOfertasHome;
                    entConf.ConfiguracionPais.Codigo = Util.Trim(entConf.ConfiguracionPais.Codigo).ToUpper();

                    //string titulo = "", subTitulo = "";

                    #region Pre Validacion

                    if (!SeccionTieneConfiguracionPais(entConf.ConfiguracionPais)) continue;

                    if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                        || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigitalReducida
                        || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.OfertasParaTi)
                    {
                        //if (!RDObtenerTitulosSeccion(ref titulo, ref subTitulo, entConf.ConfiguracionPais.Codigo, userData.Sobrenombre))
                        //    continue;

                        //entConf.DesktopTitulo = titulo;
                        //entConf.DesktopSubTitulo = subTitulo;

                        //entConf.MobileTitulo = titulo;
                        //entConf.MobileSubTitulo = subTitulo;

                        if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                            && !revistaDigital.TieneRDC) continue;

                        if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.OfertasParaTi)
                        {
                            if (revistaDigital.TieneRDC) continue;

                            entConf.MobileCantidadProductos = 0;
                            entConf.DesktopCantidadProductos = 0;
                        }
                    }
                    else if (entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento)
                    {
                        if (!revistaDigital.TieneRevistaDigital()) continue;

                        if (menuActivo.CampaniaId != userData.CampaniaID) entConf.UrlSeccion = "Revisar/" + entConf.UrlSeccion;
                    }

                    #endregion

                    ConfiguracionPais.RemplazarTagNombreConfiguracionOferta(ref entConf, Constantes.TagCadenaRd.Nombre1, userData.Sobrenombre);

                    var seccion = new ConfiguracionSeccionHomeModel
                    {
                        CampaniaID = menuActivo.CampaniaId,
                        Codigo = entConf.ConfiguracionPais.Codigo ?? entConf.ConfiguracionOfertasHomeID.ToString().PadLeft(5, '0'),
                        Orden = revistaDigital.TieneRevistaDigital() ? isMobile ? entConf.MobileOrdenBpt : entConf.DesktopOrdenBpt : isMobile ? entConf.MobileOrden : entConf.DesktopOrden,
                        ColorFondo = isMobile ? (entConf.MobileColorFondo ?? "") : (entConf.DesktopColorFondo ?? ""),
                        UsarImagenFondo = isMobile ? entConf.MobileUsarImagenFondo : entConf.DesktopUsarImagenFondo,
                        ImagenFondo = isMobile ? (entConf.MobileImagenFondo ?? "") : (entConf.DesktopImagenFondo ?? ""),
                        ColorTexto = isMobile ? entConf.MobileColorTexto ?? "" : entConf.DesktopColorTexto ?? "",
                        Titulo = isMobile ? entConf.MobileTitulo : entConf.DesktopTitulo,
                        SubTitulo = isMobile ? entConf.MobileSubTitulo : entConf.DesktopSubTitulo,
                        TipoPresentacion = isMobile ? entConf.MobileTipoPresentacion : entConf.DesktopTipoPresentacion,
                        TipoEstrategia = isMobile ? entConf.MobileTipoEstrategia : entConf.DesktopTipoEstrategia,
                        CantidadMostrar = isMobile ? entConf.MobileCantidadProductos : entConf.DesktopCantidadProductos,
                        UrlLandig = "/" + (isMobile ? "Mobile/" : "") + entConf.UrlSeccion,
                        VerMas = true
                    };

                    seccion.TituloBtnAnalytics = seccion.Titulo.Replace("'", "");
                    seccion.ImagenFondo = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, seccion.ImagenFondo);

                    #region ConfiguracionPais.Codigo

                    switch (entConf.ConfiguracionPais.Codigo)
                    {
                        case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
                            var guiaNegocio = SessionManager.GetGuiaNegocio();
                            if (!GuiaNegocio.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                                continue;

                            seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + "GuiaNegocio";
                            seccion.UrlObtenerProductos = "";
                            break;
                        case Constantes.ConfiguracionPais.OfertasParaTi:
                            seccion.UrlObtenerProductos = "Estrategia/ConsultarEstrategiasOPT";
                            seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor : Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedor;
                            seccion.OrigenPedidoPopup = isMobile ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedorPopup : Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedorPopup;
                            seccion.VerMas = false;
                            break;
                        case Constantes.ConfiguracionPais.Lanzamiento:
                            seccion.UrlObtenerProductos = "Estrategia/RDObtenerProductosLan";
                            seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor : Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedor;
                            seccion.OrigenPedidoPopup = isMobile ? Constantes.OrigenPedidoWeb.LanzamientoMobileContenedorPopup : Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedorPopup;
                            seccion.VerMas = false;
                            break;
                        case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                        case Constantes.ConfiguracionPais.RevistaDigital:
                            seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + (menuActivo.CampaniaId > userData.CampaniaID ? "RevistaDigital/Revisar" : "RevistaDigital/Comprar");
                            seccion.UrlObtenerProductos = "Estrategia/RDObtenerProductos";
                            seccion.OrigenPedido = isMobile ? 0 : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedor;
                            seccion.OrigenPedidoPopup = isMobile ? 0 : Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedorPopup;
                            break;
                        case Constantes.ConfiguracionPais.ShowRoom:
                            ConfiguracionSeccionShowRoom(ref seccion, isMobile);
                            if (seccion.UrlLandig == "")
                                continue;

                            seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.ShowRoomMobileContenedor : Constantes.OrigenPedidoWeb.ShowRoomDesktopContenedor;
                            break;
                        case Constantes.ConfiguracionPais.OfertaDelDia:
                            var estrategiaODD = SessionManager.OfertaDelDia.Estrategia;
                            if (!estrategiaODD.TieneOfertaDelDia)
                                continue;

                            SessionManager.OfertaDelDia.Estrategia.ConfiguracionContenedor = seccion;

                            break;
                        case Constantes.ConfiguracionPais.HerramientasVenta:
                            seccion.UrlObtenerProductos = "Estrategia/HVObtenerProductos";
                            seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + (menuActivo.CampaniaId > userData.CampaniaID ? "HerramientasVenta/Revisar" : "HerramientasVenta/Comprar");
                            seccion.OrigenPedido = isMobile ? 0 : Constantes.OrigenPedidoWeb.HVDesktopContenedor;
                            seccion.OrigenPedidoPopup = isMobile ? 0 : Constantes.OrigenPedidoWeb.HVDesktopContenedorPopup;
                            break;
                    }
                    #endregion

                    #region TipoPresentacion

                    seccion.TemplatePresentacion = "";
                    seccion.TemplateProducto = "";
                    switch (seccion.TipoPresentacion)
                    {
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselSimple:
                            seccion.TemplatePresentacion = "seccion-simple-centrado";
                            seccion.TemplateProducto = "#producto-landing-template";
                            break;
                        //case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselPrevisuales:
                        //    seccion.TemplatePresentacion = "seccion-carrusel-previsuales";
                        //    seccion.TemplateProducto = "#lanzamiento-carrusel-template";
                        //    break;
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado:
                            seccion.TemplatePresentacion = "seccion-simple-centrado";
                            seccion.TemplateProducto = "#producto-landing-template";
                            seccion.CantidadMostrar = isMobile ? 1 : seccion.CantidadMostrar > 3 || seccion.CantidadMostrar <= 0 ? 3 : seccion.CantidadMostrar;
                            break;
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.Banners:
                            seccion.TemplatePresentacion = "seccion-banner";
                            seccion.CantidadMostrar = 0;
                            break;
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.ShowRoom:
                            seccion.TemplatePresentacion = isMobile ? "seccion-showroom" : "seccion-simple-centrado";
                            seccion.TemplateProducto = isMobile ? "" : "#producto-landing-template";
                            break;
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.OfertaDelDia:
                            seccion.TemplatePresentacion = "seccion-oferta-del-dia";
                            break;

                        case Constantes.ConfiguracionSeccion.TipoPresentacion.DescagablesNavidenos:
                            seccion.TemplatePresentacion = "seccion-descargables-navidenos";
                            break;
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselIndividuales:
                            seccion.TemplatePresentacion = "seccion-carrusel-individuales";
                            seccion.TemplateProducto = "#lanzamiento-carrusel-individual-template";
                            break;
                    }

                    if (seccion.TemplatePresentacion == "") continue;
                    #endregion

                    seccionesContenedorModel.Add(seccion);
                }

                seccionesContenedorModel = seccionesContenedorModel.OrderBy(s => s.Orden).ToList();
            }
            catch (Exception ex)
            {
                LogManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseController.ObtenerConfiguracionSeccion");
            }

            return seccionesContenedorModel;
        }

        private List<BEConfiguracionOfertasHome> GetSeccionesContenedor()
        {
            var seccionesContenedor = SessionManager.GetSeccionesContenedor(menuActivo.CampaniaId);

            if (seccionesContenedor == null)
            {
                seccionesContenedor = GetConfiguracionOfertasHome(userData.PaisID, menuActivo.CampaniaId);
                SessionManager.SetSeccionesContenedor(menuActivo.CampaniaId, seccionesContenedor);
            }

            return seccionesContenedor;
        }

        private List<BEConfiguracionOfertasHome> GetSeccionesContenedorByCampania(List<BEConfiguracionOfertasHome> seccionesContenedor)
        {
            if (seccionesContenedor != null && menuActivo.CampaniaId > userData.CampaniaID)
            {
                seccionesContenedor = seccionesContenedor.Where(entConf
                => entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento
                || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.InicioRD
                || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.HerramientasVenta).ToList();
            }

            return seccionesContenedor;
        }


        private bool SeccionTieneConfiguracionPais(ServiceSAC.BEConfiguracionPais configuracionPais)
        {
            var result = false;

            var configuracionesPais = SessionManager.GetConfiguracionesPaisModel();
            if (configuracionesPais != null)
            {
                var cp = configuracionesPais.FirstOrDefault(x => x.Codigo == configuracionPais.Codigo);
                result = cp != null && cp.ConfiguracionPaisID >= 0 && !string.IsNullOrWhiteSpace(cp.Codigo);

            }

            return result;
        }

        private List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
        {
            var  configuracionesOfertasHomes = new List<BEConfiguracionOfertasHome>();

            try
            {
                using (var sv = new SACServiceClient())
                {
                    configuracionesOfertasHomes = sv.ListarSeccionConfiguracionOfertasHome(paidId, campaniaId).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "OfertasController.Index");
            }
            
            return configuracionesOfertasHomes;
        }

        private void ConfiguracionSeccionShowRoom(ref ConfiguracionSeccionHomeModel seccion, bool esMobile)
        {
            seccion.UrlLandig = "";

            if (!SessionManager.GetEsShowRoom())
                return;

            if (SessionManager.GetMostrarShowRoomProductosExpiro())
                return;

            if (!SessionManager.GetMostrarShowRoomProductos())
            {

                seccion.UrlLandig = (esMobile ? "/Mobile/" : "/") + "ShowRoom/Intriga";
                seccion.UrlObtenerProductos = "ShowRoom/GetDataShowRoomIntriga";

                if (!esMobile)
                {
                    seccion.ImagenFondo =
                        ShowRoom.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomIntriga,
                                                            Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                }
                else
                {
                    seccion.ImagenFondo =
                        ShowRoom.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasIntriga,
                                                            Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                }
            }
            else
            {
                seccion.UrlLandig = (esMobile ? "/Mobile/" : "/") + "ShowRoom";
                seccion.UrlObtenerProductos = esMobile ? "" : "ShowRoom/CargarProductosShowRoomOferta";
                if (!esMobile)
                {
                    seccion.ImagenFondo =
                        ShowRoom.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomVenta,
                                                            Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                }
                else
                {
                    seccion.ImagenFondo =
                        ShowRoom.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasVenta,
                                                            Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                }

                var listaShowRoom = SessionManager.ShowRoom.Ofertas ?? new List<EstrategiaPersonalizadaProductoModel>();
                seccion.CantidadProductos = listaShowRoom.Count;
                seccion.CantidadMostrar = Math.Min(3, seccion.CantidadProductos);
            }
        }

        //private bool RDObtenerTitulosSeccion(ref string titulo, ref string subtitulo, string codigo, string sobreNombre)
        //{
        //    var revistaDigital = SessionManager.GetRevistaDigital();
        //    if (codigo == Constantes.ConfiguracionPais.RevistaDigital && !revistaDigital.TieneRDC) return false;

        //    titulo = revistaDigital.TieneRDC
        //        ? (revistaDigital.EsActiva || revistaDigital.EsSuscrita)
        //            ? "OFERTAS CLUB GANA+"
        //            : "OFERTAS GANA+"
        //        : "";

        //    subtitulo = sobreNombre.ToUpper() + ", PRUEBA LAS VENTAJAS DE COMPRAR OFERTAS PERSONALIZADAS";

        //    if (codigo == Constantes.ConfiguracionPais.OfertasParaTi)
        //    {
        //        if (revistaDigital.TieneRDC) return false;

        //        titulo = "MÁS OFERTAS PARA TI " + sobreNombre.ToUpper();
        //        subtitulo = "EXCLUSIVAS SÓLO POR WEB";
        //    }

        //    return true;
        //}

    }
}