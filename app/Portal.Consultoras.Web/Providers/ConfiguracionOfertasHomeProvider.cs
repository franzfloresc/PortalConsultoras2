﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class ConfiguracionOfertasHomeProvider
    {
        public virtual ISessionManager SessionManager { get; private set; }

        public virtual ILogManager LogManager { get; private set; }

        public virtual ConfiguracionPaisProvider ConfiguracionPais { get; private set; }

        public virtual GuiaNegocioProvider GuiaNegocio { get; private set; }

        public virtual ShowRoomProvider ShowRoom { get; private set; }

        public virtual OfertaPersonalizadaProvider OfertaPersonalizada { get; private set; }

        public virtual ProgramaNuevasProvider ProgramaNuevas { get; private set; }

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
            : this(
                Web.SessionManager.SessionManager.Instance,
                Web.LogManager.LogManager.Instance,
                new ConfiguracionPaisProvider(),
                new GuiaNegocioProvider(),
                new ShowRoomProvider(),
                new OfertaPersonalizadaProvider(),
                new ProgramaNuevasProvider(Web.SessionManager.SessionManager.Instance))
        {
        }

        public ConfiguracionOfertasHomeProvider(
            ISessionManager sessionManager,
            ILogManager logManager,
            ConfiguracionPaisProvider configuracionPais,
            GuiaNegocioProvider guiaNegocio,
            ShowRoomProvider showRoom,
            OfertaPersonalizadaProvider ofertaPersonalizada,
            ProgramaNuevasProvider programaNuevasProvider)
        {
            SessionManager = sessionManager;
            LogManager = logManager;
            ConfiguracionPais = configuracionPais;
            GuiaNegocio = guiaNegocio;
            ShowRoom = showRoom;
            OfertaPersonalizada = ofertaPersonalizada;
            ProgramaNuevas = programaNuevasProvider;
        }

        public virtual List<ConfiguracionSeccionHomeModel> ObtenerConfiguracionSeccion(
            RevistaDigitalModel revistaDigital,
            bool esMobile)
        {
            var seccionesContenedorModel = new List<ConfiguracionSeccionHomeModel>();

            try
            {
                if (userData == null || revistaDigital == null) return seccionesContenedorModel;
                if (menuActivo.CampaniaId <= 0) menuActivo.CampaniaId = userData.CampaniaID;

                var seccionesContenedor = GetSeccionesContenedor();
                seccionesContenedor = GetSeccionesContenedorByCampania(seccionesContenedor);
                var isMobile = esMobile;
                var esElecMultiple = ProgramaNuevas.GetLimElectivos() > 1;
                List<ServiceOferta.BEEstrategia> listProgNuevas = null;

                foreach (var beConfiguracionOfertasHome in seccionesContenedor)
                {
                    var entConf = beConfiguracionOfertasHome;
                    entConf.ConfiguracionPais.Codigo = Util.Trim(entConf.ConfiguracionPais.Codigo).ToUpper();

                    #region Pre Validacion
                    var conforme = SeccionesPreValidar(ref entConf, revistaDigital);

                    if (!conforme)
                    {
                        continue;
                    }
                    #endregion

                    ConfiguracionPais.RemplazarTagNombreConfiguracionOferta(
                        ref entConf,
                        Constantes.TagCadenaRd.Nombre1,
                        userData.Sobrenombre);

                    var seccion = SeccionModelo(entConf, revistaDigital, isMobile);

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
                        case Constantes.ConfiguracionPais.ProgramaNuevas:
                            if (esElecMultiple) continue;

                            listProgNuevas = listProgNuevas ?? OfertaPersonalizada.ConsultarEstrategiasPorTipo(
                                                 esMobile,
                                                 Constantes.TipoEstrategiaCodigo.PackNuevas,
                                                 userData.CampaniaID,
                                                 false);
                            if (!listProgNuevas.Any()) continue;

                            seccion.UrlObtenerProductos = "";
                            break;
                        case Constantes.ConfiguracionPais.ElecMultiple:
                            if (!esElecMultiple) continue;

                            listProgNuevas = listProgNuevas ?? OfertaPersonalizada.ConsultarEstrategiasPorTipo(
                                                 esMobile,
                                                 Constantes.TipoEstrategiaCodigo.PackNuevas,
                                                 userData.CampaniaID,
                                                 false);
                            if (!listProgNuevas.Any()) continue;

                            seccion.UrlObtenerProductos = "";
                            break;
                        case Constantes.ConfiguracionPais.OfertasParaTi:
                            seccion.UrlObtenerProductos = "Estrategia/OPTObtenerProductos";
                            seccion.OrigenPedido =
                                isMobile
                                    ? Constantes.OrigenPedidoWeb.MobileContenedorOfertasParaTiCarrusel
                                    : Constantes.OrigenPedidoWeb.DesktopContenedorOfertasParaTiCarrusel;
                            seccion.OrigenPedidoPopup =
                                isMobile
                                    ? Constantes.OrigenPedidoWeb.MobileContenedorOfertasParaTiFicha
                                    : Constantes.OrigenPedidoWeb.DesktopContenedorOfertasParaTiFicha;
                            seccion.VerMas = false;
                            break;
                        case Constantes.ConfiguracionPais.Lanzamiento:
                            seccion.UrlObtenerProductos = "Estrategia/LANObtenerProductos";
                            seccion.OrigenPedido =
                                isMobile
                                    ? Constantes.OrigenPedidoWeb.MobileContenedorLanzamientosCarrusel
                                    : Constantes.OrigenPedidoWeb.DesktopContenedorLanzamientosCarrusel;
                            seccion.OrigenPedidoPopup =
                                isMobile
                                    ? Constantes.OrigenPedidoWeb.MobileContenedorLanzamientosFicha
                                    : Constantes.OrigenPedidoWeb.DesktopContenedorLanzamientosFicha;
                            seccion.VerMas = false;
                            break;
                        case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                        case Constantes.ConfiguracionPais.RevistaDigital:
                            seccion.UrlLandig = (isMobile ? "/Mobile/" : "/")
                                                + (menuActivo.CampaniaId > userData.CampaniaID
                                                       ? "RevistaDigital/Revisar"
                                                       : "RevistaDigital/Comprar");
                            seccion.UrlObtenerProductos = "Estrategia/RDObtenerProductos";
                            seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.MobileContenedorOfertasParaTiCarrusel : Constantes.OrigenPedidoWeb.DesktopContenedorOfertasParaTiCarrusel;
                            seccion.OrigenPedidoPopup = isMobile ? Constantes.OrigenPedidoWeb.MobileContenedorOfertasParaTiFicha : Constantes.OrigenPedidoWeb.DesktopContenedorOfertasParaTiFicha;
                            seccion.VerMas = SessionManager.GetRevistaDigital().TieneLanding;

                            break;
                        case Constantes.ConfiguracionPais.ShowRoom:
                            seccion = ConfiguracionSeccionShowRoom(seccion, isMobile);
                            if (seccion.UrlLandig == "")
                                continue;

                            break;
                        case Constantes.ConfiguracionPais.OfertaDelDia:
                            var estrategiaODD = SessionManager.OfertaDelDia.Estrategia;
                            if (!estrategiaODD.TieneOfertaDelDia)
                                continue;
                            seccion.OrigenPedido =
                                isMobile ? 0 : Constantes.OrigenPedidoWeb.DesktopContenedorOfertaDelDiaCarrusel;
                            seccion.OrigenPedidoPopup =
                                isMobile ? 0 : Constantes.OrigenPedidoWeb.DesktopContenedorOfertaDelDiaFicha;

                            SessionManager.OfertaDelDia.Estrategia.ConfiguracionContenedor = seccion;

                            break;
                        case Constantes.ConfiguracionPais.HerramientasVenta:
                            seccion.UrlObtenerProductos = "Estrategia/HVObtenerProductos";
                            seccion.UrlLandig = (isMobile ? "/Mobile/" : "/")
                                                + (menuActivo.CampaniaId > userData.CampaniaID
                                                       ? "HerramientasVenta/Revisar"
                                                       : "HerramientasVenta/Comprar");
                            seccion.OrigenPedido =
                                isMobile ? 0 : Constantes.OrigenPedidoWeb.DesktopContenedorHerramientasdeVentaCarrusel;
                            seccion.OrigenPedidoPopup =
                                isMobile ? 0 : Constantes.OrigenPedidoWeb.DesktopContenedorHerramientasdeVentaCarrusel;
                            break;
                        case Constantes.ConfiguracionPais.MasGanadoras:
                            if (!revistaDigital.EsActiva)
                            {
                                continue;
                            }

                            seccion.UrlObtenerProductos = "Estrategia/MGObtenerProductos";
                            seccion.UrlLandig = (isMobile ? "/Mobile/" : "/") + "MasGanadoras";
                            seccion.OrigenPedido =
                                isMobile
                                    ? Constantes.OrigenPedidoWeb.MobileContenedorGanadorasCarrusel
                                    : Constantes.OrigenPedidoWeb.DesktopContenedorGanadorasCarrusel;
                            seccion.OrigenPedidoPopup =
                                isMobile
                                    ? Constantes.OrigenPedidoWeb.MobileContenedorGanadorasFicha
                                    : Constantes.OrigenPedidoWeb.DesktopContenedorGanadorasFicha;
                            seccion.VerMas = SessionManager.MasGanadoras.GetModel().TieneLanding;
                            break;
                        case Constantes.ConfiguracionPais.ArmaTuPack:
                            seccion.UrlObtenerProductos = "Estrategia/ATPObtenerProductos";
                            seccion.UrlLandig = "ArmaTuPack";

                            seccion.OrigenPedido = isMobile ? Constantes.OrigenPedidoWeb.MobileContenedorArmaTuPack : Constantes.OrigenPedidoWeb.DesktopContenedorArmaTuPack;
                            seccion.VerMas = false;
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
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado:
                            seccion.TemplatePresentacion = "seccion-simple-centrado";
                            seccion.TemplateProducto = "#producto-landing-template";
                            seccion.CantidadMostrar =
                                isMobile ? 1 :
                                seccion.CantidadMostrar > 3 || seccion.CantidadMostrar <= 0 ? 3 :
                                seccion.CantidadMostrar;
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
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.CarruselIndividualesV2:
                            seccion.TemplatePresentacion =
                                isMobile ? "seccion-carrusel-individuales-v2" : "seccion-simple-centrado";
                            seccion.TemplateProducto =
                                isMobile ? "#template-producto-v2" : "#producto-landing-template";
                            break;
                        case Constantes.ConfiguracionSeccion.TipoPresentacion.BannerInteractivo:
                            seccion.TemplatePresentacion = isMobile ? "seccion-carrusel-individuales-v2" : "seccion-simple-centrado";
                            seccion.TemplateProducto = isMobile ? "#template-producto-v2" : "#producto-landing-template";
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
                LogManager.LogErrorWebServicesBusWrap(
                    ex,
                    userData.CodigoConsultora,
                    userData.CodigoISO,
                    "BaseController.ObtenerConfiguracionSeccion");
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

        private List<BEConfiguracionOfertasHome> GetSeccionesContenedorByCampania(
            List<BEConfiguracionOfertasHome> seccionesContenedor)
        {
            if (seccionesContenedor != null && menuActivo.CampaniaId > userData.CampaniaID)
            {
                seccionesContenedor = seccionesContenedor.Where(
                        entConf => entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.RevistaDigital
                                   || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.Lanzamiento
                                   || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.InicioRD
                                   || entConf.ConfiguracionPais.Codigo == Constantes.ConfiguracionPais.HerramientasVenta)
                    .ToList();
            }

            return seccionesContenedor;
        }

        private bool SeccionesPreValidar(ref BEConfiguracionOfertasHome entConf, RevistaDigitalModel revistaDigital)
        {
            if (!SeccionTieneConfiguracionPais(entConf.ConfiguracionPais)) return false;

            switch (entConf.ConfiguracionPais.Codigo)
            {
                case Constantes.ConfiguracionPais.RevistaDigital:
                    if (!revistaDigital.TieneRDC) return false;
                    break;
                case Constantes.ConfiguracionPais.OfertasParaTi:
                    if (revistaDigital.TieneRDC) return false;

                    entConf.MobileCantidadProductos = 0;
                    entConf.DesktopCantidadProductos = 0;
                    break;
                case Constantes.ConfiguracionPais.Lanzamiento:
                    if (!revistaDigital.TieneRDC) return false;

                    if (menuActivo.CampaniaId != userData.CampaniaID)
                        entConf.UrlSeccion = "Revisar/" + entConf.UrlSeccion;
                    break;
            }

            return true;
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

        private ConfiguracionSeccionHomeModel SeccionModelo(BEConfiguracionOfertasHome entConf, RevistaDigitalModel revistaDigital, bool isMobile)
        {
            var seccion = new ConfiguracionSeccionHomeModel
            {
                CampaniaID = menuActivo.CampaniaId,
                Codigo = entConf.ConfiguracionPais.Codigo ?? entConf.ConfiguracionOfertasHomeID.ToString().PadLeft(5, '0'),
                Orden = revistaDigital.TieneRevistaDigital()
                            ? isMobile ? entConf.MobileOrdenBpt : entConf.DesktopOrdenBpt
                            : isMobile ? entConf.MobileOrden : entConf.DesktopOrden,
                ColorFondo = isMobile
                            ? (entConf.MobileColorFondo ?? "")
                            : (entConf.DesktopColorFondo ?? ""),
                UsarImagenFondo = isMobile
                            ? entConf.MobileUsarImagenFondo
                            : entConf.DesktopUsarImagenFondo,
                ImagenFondo = isMobile
                            ? (entConf.MobileImagenFondo ?? "")
                            : (entConf.DesktopImagenFondo ?? ""),
                ColorTexto = isMobile
                            ? entConf.MobileColorTexto ?? ""
                            : entConf.DesktopColorTexto ?? "",
                Titulo = isMobile
                            ? entConf.MobileTitulo
                            : entConf.DesktopTitulo,
                SubTitulo = isMobile
                            ? entConf.MobileSubTitulo
                            : entConf.DesktopSubTitulo,
                TipoPresentacion = isMobile
                            ? entConf.MobileTipoPresentacion
                            : entConf.DesktopTipoPresentacion,
                TipoEstrategia = isMobile
                            ? entConf.MobileTipoEstrategia
                            : entConf.DesktopTipoEstrategia,
                CantidadMostrar = isMobile
                            ? entConf.MobileCantidadProductos
                            : entConf.DesktopCantidadProductos,
                UrlLandig = "/" + (isMobile ? "Mobile/" : "") + entConf.UrlSeccion,
                VerMas = true
            };

            seccion.TituloBtnAnalytics = seccion.Titulo.Replace("'", "");
            seccion.ImagenFondo = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, seccion.ImagenFondo);

            return seccion;
        }

        protected virtual List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
        {
            var configuracionesOfertasHomes = new List<BEConfiguracionOfertasHome>();

            try
            {
                using (var sv = new SACServiceClient())
                {
                    configuracionesOfertasHomes = sv.ListarSeccionConfiguracionOfertasHome(paidId, campaniaId).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogErrorWebServicesBusWrap(
                    ex,
                    userData.CodigoConsultora,
                    userData.CodigoISO,
                    "OfertasController.Index");
            }

            return configuracionesOfertasHomes;
        }

        private ConfiguracionSeccionHomeModel ConfiguracionSeccionShowRoom(ConfiguracionSeccionHomeModel seccion, bool esMobile)
        {
            seccion.UrlLandig = "";

            if (!ShowRoom.ValidarIngresoShowRoom(false))
                return seccion;

            seccion.UrlObtenerProductos = "Estrategia/SRObtenerProductos";
            seccion.OrigenPedido = esMobile ? Constantes.OrigenPedidoWeb.MobileContenedorShowroomCarrusel : Constantes.OrigenPedidoWeb.DesktopContenedorShowroomCarrusel;
            seccion.OrigenPedidoPopup = esMobile ? Constantes.OrigenPedidoWeb.MobileContenedorShowroomFicha : Constantes.OrigenPedidoWeb.DesktopContenedorShowroomFicha;
            seccion.VerMas = SessionManager.ShowRoom.TieneLanding;

            var urlMobiel = esMobile ? "/Mobile/" : "/";

            if (!SessionManager.GetMostrarShowRoomProductos())
            {
                seccion.UrlLandig = urlMobiel + "ShowRoom/Intriga";

                if (!esMobile)
                {
                    seccion.ImagenFondo = ShowRoom.ObtenerValorPersonalizacionShowRoom(
                        Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomIntriga,
                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                }
                else
                {
                    seccion.ImagenFondo = ShowRoom.ObtenerValorPersonalizacionShowRoom(
                        Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasIntriga,
                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                }
            }
            else
            {
                seccion.UrlLandig = urlMobiel + "ShowRoom";
                if (!esMobile)
                {
                    seccion.ImagenFondo = ShowRoom.ObtenerValorPersonalizacionShowRoom(
                        Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoContenedorOfertasShowRoomVenta,
                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                }
                else
                {
                    seccion.ImagenFondo = ShowRoom.ObtenerValorPersonalizacionShowRoom(
                        Constantes.ShowRoomPersonalizacion.Mobile.ImagenBannerContenedorOfertasVenta,
                        Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                }


                if (SessionManager.ShowRoom.Ofertas != null)
                {
                    var listaShowRoom = SessionManager.ShowRoom.Ofertas ?? new List<EstrategiaPersonalizadaProductoModel>();
                    seccion.CantidadProductos = listaShowRoom.Count;
                    seccion.CantidadMostrar = Math.Min(seccion.CantidadMostrar, seccion.CantidadProductos);
                }

            }

            return seccion;
        }
    }
}