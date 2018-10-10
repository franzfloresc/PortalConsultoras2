using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class MenuContenedorProvider
    {
        public MenuContenedorModel GetMenuActivo(UsuarioModel userData, RevistaDigitalModel revistaDigital, HerramientasVentaModel herramientasVenta, HttpRequestBase Request, GuiaNegocioModel guiaNegocio, ISessionManager sessionManager, ConfiguracionManagerProvider _configuracionManagerProvider, EventoFestivoProvider _eventoFestivoProvider, ConfiguracionPaisProvider _configuracionPaisProvider, GuiaNegocioProvider _guiaNegocioProvider, bool esMobile)
        {
            var Path = Request.Path;
            var contenedorPath = GetContenedorRequestPath(Path);

            var menuActivo = CreateMenuContenedorActivo(userData.CampaniaID);
            menuActivo = UpdateCampaniaIdFromQueryString(menuActivo, Request);
            menuActivo = UpdateCodigoCampaniaIdOrigenByContenedorPath(menuActivo, contenedorPath, revistaDigital, userData.CampaniaID, userData.NroCampanias, Request, userData.CodigoConsultora, userData.CodigoISO, sessionManager, esMobile);
            menuActivo = UpdateConfiguracionPais(menuActivo, userData, revistaDigital, guiaNegocio, sessionManager, _configuracionManagerProvider, _eventoFestivoProvider, _configuracionPaisProvider, _guiaNegocioProvider, esMobile);

            if (revistaDigital.TieneRDC || herramientasVenta.TieneHV)
            {
                menuActivo.CampaniaX0 = userData.CampaniaID;
                menuActivo.CampaniaX1 = Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);
            }
            if (revistaDigital.TieneRDI)
            {
                menuActivo.CampaniaX0 = userData.CampaniaID;
            }

            sessionManager.SetMenuContenedorActivo(menuActivo);

            return menuActivo;
        }

        public MenuContenedorModel UpdateConfiguracionPais(MenuContenedorModel menuActivo, UsuarioModel userData, RevistaDigitalModel revistaDigital, GuiaNegocioModel guiaNegocio, ISessionManager sessionManager, ConfiguracionManagerProvider _configuracionManagerProvider, EventoFestivoProvider _eventoFestivoProvider, ConfiguracionPaisProvider _configuracionPaisProvider, GuiaNegocioProvider _guiaNegocioProvider, bool esMobile)
        {
            var menuContenedor = BuildMenuContenedor(userData, revistaDigital, guiaNegocio, sessionManager, _configuracionManagerProvider, _eventoFestivoProvider, _configuracionPaisProvider, _guiaNegocioProvider, esMobile);
            menuActivo.ConfiguracionPais = GetConfiguracionPaisBy(menuContenedor, menuActivo, revistaDigital, userData.CampaniaID);
            return menuActivo;
        }

        public MenuContenedorModel UpdateCodigoCampaniaIdOrigenByContenedorPath(MenuContenedorModel menuActivo, string contenedorPath, RevistaDigitalModel revistaDigital, int CampaniaID, int NroCampanias, HttpRequestBase Request, string CodigoConsultora, string CodigoISO, ISessionManager sessionManager, bool esMobile)
        {
            menuActivo.MostrarMenuFlotante = true;
            switch (contenedorPath)
            {
                case Constantes.UrlMenuContenedor.Inicio:
                case Constantes.UrlMenuContenedor.InicioIndex:
                case Constantes.UrlMenuContenedor.RdInicio:
                case Constantes.UrlMenuContenedor.RdInicioIndex:
                    menuActivo.Codigo = revistaDigital.TieneRevistaDigital() ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MContenedorHome
                        : Constantes.OrigenPantallaWeb.DContenedorHome;
                    break;
                case Constantes.UrlMenuContenedor.InicioRevisar:
                    menuActivo.Codigo = revistaDigital.TieneRevistaDigital() ? Constantes.ConfiguracionPais.InicioRD : Constantes.ConfiguracionPais.Inicio;
                    menuActivo.CampaniaId = Util.AddCampaniaAndNumero(CampaniaID, 1, NroCampanias);
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MContenedorHomeRevisar
                        : Constantes.OrigenPantallaWeb.DContenedorHomeRevisar;
                    break;
                case Constantes.UrlMenuContenedor.RdComprar:
                    menuActivo.Codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MRevistaDigital
                        : Constantes.OrigenPantallaWeb.DRevistaDigital;
                    break;
                case Constantes.UrlMenuContenedor.RdRevisar:
                    menuActivo.Codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                    menuActivo.CampaniaId = Util.AddCampaniaAndNumero(CampaniaID, 1, NroCampanias);
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MRevistaDigitalRevisar
                        : Constantes.OrigenPantallaWeb.DRevistaDigitalRevisar;
                    break;
                case Constantes.UrlMenuContenedor.RdInformacion:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Informacion;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MRevistaDigitalInfo
                        : Constantes.OrigenPantallaWeb.DRevistaDigitalInfo;
                    break;
                case Constantes.UrlMenuContenedor.LanDetalle:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Lanzamiento;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MRevistaDigitalDetalle
                        : Constantes.OrigenPantallaWeb.DRevistaDigitalDetalle;
                    break;
                case Constantes.UrlMenuContenedor.SwInicio:
                case Constantes.UrlMenuContenedor.SwIntriga:
                case Constantes.UrlMenuContenedor.SwDetalle:
                case Constantes.UrlMenuContenedor.SwInicioIndex:
                case Constantes.UrlMenuContenedor.SwPersonalizado:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.ShowRoom;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MShowRoom
                        : Constantes.OrigenPantallaWeb.DShowRoom;
                    break;

                case Constantes.UrlMenuContenedor.OfertaDelDia:
                case Constantes.UrlMenuContenedor.OfertaDelDiaIndex:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.OfertaDelDia;
                    break;
                case Constantes.UrlMenuContenedor.GuiaDeNegocio:
                case Constantes.UrlMenuContenedor.GuiaDeNegocioIndex:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MGuiaNegocio
                        : Constantes.OrigenPantallaWeb.DGuiaNegocio;
                    break;
                case Constantes.UrlMenuContenedor.HerramientasVentaIndex:
                case Constantes.UrlMenuContenedor.HerramientasVentaComprar:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.HerramientasVenta;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MHerramientaVenta
                        : Constantes.OrigenPantallaWeb.DHerramientaVenta;
                    break;
                case Constantes.UrlMenuContenedor.HerramientasVentaRevisar:
                    menuActivo.CampaniaId = Util.AddCampaniaAndNumero(CampaniaID, 1, NroCampanias);
                    menuActivo.Codigo = Constantes.ConfiguracionPais.HerramientasVenta;
                    menuActivo.OrigenPantalla = esMobile
                        ? Constantes.OrigenPantallaWeb.MHerramientaVenta
                        : Constantes.OrigenPantallaWeb.DHerramientaVenta;
                    break;
                case Constantes.UrlMenuContenedor.DetalleOfertaParaTi:
                case Constantes.UrlMenuContenedor.DetalleOfertasParaMi:
                case Constantes.UrlMenuContenedor.DetallePackNuevas:
                    menuActivo.Codigo =
                        revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital
                        : revistaDigital.TieneRDI ? Constantes.ConfiguracionPais.OfertasParaTi
                        : Constantes.ConfiguracionPais.RevistaDigitalReducida;

                    menuActivo.MostrarMenuFlotante = false; 
                    break;
                case Constantes.UrlMenuContenedor.DetalleLanzamiento:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.Lanzamiento;
                    menuActivo.MostrarMenuFlotante = false;
                    break;
                case Constantes.UrlMenuContenedor.DetalleShowRoom:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.ShowRoom;
                    menuActivo.MostrarMenuFlotante = false;
                    break;
                case Constantes.UrlMenuContenedor.DetalleOfertaDelDia:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.OfertaDelDia;
                    menuActivo.MostrarMenuFlotante = false;
                    break;
                case Constantes.UrlMenuContenedor.DetalleGuiaDeNegocioDigitalizada:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada;
                    menuActivo.MostrarMenuFlotante = false;
                    break;
                case Constantes.UrlMenuContenedor.DetalleHerramientasVenta:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.HerramientasVenta;
                    menuActivo.MostrarMenuFlotante = false;
                    break;
                case Constantes.UrlMenuContenedor.MasGanadorasIndex:
                    menuActivo.Codigo = Constantes.ConfiguracionPais.MasGanadoras;
                    break;
            }

            return menuActivo;
        }

        public MenuContenedorModel UpdateCampaniaIdFromQueryString(MenuContenedorModel menuActivo, HttpRequestBase Request)
        {
            var qsCampaniaId = GetCampaniaIdFromQueryString(Request);
            int campaniaid;
            if (int.TryParse(Util.Trim(qsCampaniaId), out campaniaid))
            {
                menuActivo.CampaniaId = campaniaid;
            }
            
            return menuActivo;
        }

        public MenuContenedorModel CreateMenuContenedorActivo(int campaniaId)
        {
            return new MenuContenedorModel { CampaniaId = campaniaId };
        }

        public virtual string GetContenedorRequestPath(string Path)
        {
            var path = GetRequestPath(Path);
            path = path.ToLower().Replace("/mobile", "");
            if (path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) >= 0)
                path = path.Substring(path.IndexOf("/g/", StringComparison.OrdinalIgnoreCase) + 39);

            var pathStrings = path.Split('/');
            var newPath = "";
            newPath += "/" + (pathStrings.Length > 1 ? pathStrings[1] : "");
            newPath += "/" + (pathStrings.Length > 2 ? pathStrings[2] : "");
            newPath = newPath.EndsWith("/") ? newPath.Substring(0, newPath.Length - 1) : newPath;
            newPath = newPath.ToLower();

            return newPath;
        }

        public virtual string GetRequestPath(string Path)
        {
            return Path;
        }

        public virtual string GetCampaniaIdFromQueryString(HttpRequestBase Request)
        {
            const string qsCamapaniaId = "campaniaid";
            var campaniaIdStr = GetQueryStringValue(qsCamapaniaId, Request);
            if (!campaniaIdStr.IsNullOrEmptyTrim()) return campaniaIdStr;
            try
            {
                var listSegments =  Request.RawUrl.Split('/').ToList();
                if (listSegments.Count > 0 && listSegments[1].ToLower().Equals("detalle"))
                {
                    campaniaIdStr = listSegments[3];
                }
            }
            catch (Exception)
            {
                campaniaIdStr = "";
            }

            return campaniaIdStr;
        }

        public virtual string GetOrigenFromQueryString(HttpRequestBase Request)
        {
            const string qsOrigen = "origen";
            var pathOrigen = GetQueryStringValue(qsOrigen, Request);
            return pathOrigen;
        }

        public virtual string GetQueryStringValue(string key, HttpRequestBase Request)
        {
            return Util.Trim(Request.QueryString[key]);
        }

        public ConfiguracionPaisModel GetConfiguracionPaisBy(List<ConfiguracionPaisModel> menuContenedor, MenuContenedorModel menuActivo, RevistaDigitalModel revistaDigital, int CampaniaID)
        {
            var configuracionPaisMenu = menuContenedor.FirstOrDefault(m => m.Codigo == menuActivo.Codigo && m.CampaniaId == menuActivo.CampaniaId);

            if (menuActivo.Codigo == Constantes.ConfiguracionPais.Informacion && revistaDigital.TieneRevistaDigital())
                configuracionPaisMenu = menuContenedor.FirstOrDefault(m => m.Codigo == Constantes.ConfiguracionPais.InicioRD && m.CampaniaId == CampaniaID);
            else if (menuActivo.Codigo == Constantes.ConfiguracionPais.Informacion && !revistaDigital.TieneRevistaDigital())
                configuracionPaisMenu = menuContenedor.FirstOrDefault(m => m.Codigo == Constantes.ConfiguracionPais.Inicio && m.CampaniaId == CampaniaID);

            configuracionPaisMenu = configuracionPaisMenu ?? new ConfiguracionPaisModel() { Codigo = Constantes.ConfiguracionPais.Inicio, CampaniaId = CampaniaID };

            return configuracionPaisMenu;
        }

        public string GetMenuActivoOptCodigoSegunActivo(string pathOrigen, RevistaDigitalModel revistaDigital, string CodigoConsultora, string CodigoISO)
        {
            var codigo = "";
            try
            {
                var origrn = int.Parse(pathOrigen);
                switch (origrn)
                {
                    case Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor:
                        codigo = Constantes.ConfiguracionPais.Lanzamiento;
                        break;
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeLanzamiento:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoLanzamiento:
                        codigo = Constantes.ConfiguracionPais.Lanzamiento;
                        break;
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccionMasOfertas:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccionOfertas:
                    case Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion:
                        codigo = revistaDigital.TieneRDC ? Constantes.ConfiguracionPais.RevistaDigital : Constantes.ConfiguracionPais.RevistaDigitalReducida;
                        break;
                    case Constantes.OrigenPedidoWeb.OfertasParaTiMobileHome:
                    case Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido:
                        codigo = Constantes.ConfiguracionPais.OfertasParaTi;
                        break;
                }

            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, CodigoConsultora, CodigoISO);
            }
            return codigo;
        }

        public List<ConfiguracionPaisModel> GetMenuContenedorByMenuActivoCampania(int campaniaIdMenuActivo, int campaniaIdUsuario, UsuarioModel userData, RevistaDigitalModel revistaDigital, GuiaNegocioModel guiaNegocio, ISessionManager sessionManager, ConfiguracionManagerProvider _configuracionManagerProvider, EventoFestivoProvider _eventoFestivoProvider, ConfiguracionPaisProvider _configuracionPaisProvider, GuiaNegocioProvider _guiaNegocioProvider, bool esMobile)
        {
            var menuContenedor = BuildMenuContenedor(userData, revistaDigital, guiaNegocio, sessionManager, _configuracionManagerProvider, _eventoFestivoProvider, _configuracionPaisProvider, _guiaNegocioProvider, esMobile);

            menuContenedor = menuContenedor.Where(e => e.CampaniaId == campaniaIdMenuActivo).ToList();

            if (campaniaIdMenuActivo == campaniaIdUsuario && !sessionManager.GetTieneLan())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (campaniaIdMenuActivo != campaniaIdUsuario && !sessionManager.GetTieneLanX1())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.Lanzamiento).ToList();
            }
            if (!sessionManager.GetTieneOpt())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.OfertasParaTi).ToList();
            }
            if (campaniaIdMenuActivo == campaniaIdUsuario && !sessionManager.GetTieneOpm())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.RevistaDigital).ToList();
            }
            if (campaniaIdMenuActivo != campaniaIdUsuario && !sessionManager.GetTieneOpmX1())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.RevistaDigital).ToList();
            }
            if (campaniaIdMenuActivo == campaniaIdUsuario && !sessionManager.GetTieneHv())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.HerramientasVenta).ToList();
            }
            if (campaniaIdMenuActivo != campaniaIdUsuario && !sessionManager.GetTieneHvX1())
            {
                menuContenedor = menuContenedor.Where(e => e.Codigo != Constantes.ConfiguracionPais.HerramientasVenta).ToList();
            }

            return menuContenedor;
        }

        public List<ConfiguracionPaisModel> BuildMenuContenedor(UsuarioModel userData, RevistaDigitalModel revistaDigital, GuiaNegocioModel guiaNegocio, ISessionManager sessionManager, ConfiguracionManagerProvider _configuracionManagerProvider, EventoFestivoProvider _eventoFestivoProvider, ConfiguracionPaisProvider _configuracionPaisProvider, GuiaNegocioProvider _guiaNegocioProvider, bool esMobile)
        {
            var menuContenedor = sessionManager.GetMenuContenedor();
            var configuracionesPais = sessionManager.GetConfiguracionesPaisModel();

            if (menuContenedor.Any() || !configuracionesPais.Any())
                return menuContenedor;

            menuContenedor = new List<ConfiguracionPaisModel>();
            configuracionesPais = configuracionesPais.Where(c => c.TienePerfil).ToList();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var paisCarpeta = _configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO) ? "Esika" : "Lbel";
            foreach (var confiModel in configuracionesPais)
            {
                var config = confiModel;
                config.Codigo = Util.Trim(config.Codigo).ToUpper();
                config.CampaniaId = userData.CampaniaID;
                config.DesktopFondoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.DesktopFondoBanner);
                config.DesktopLogoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.DesktopLogoBanner);
                config.MobileFondoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.MobileFondoBanner);
                config.MobileLogoBanner = ConfigCdn.GetUrlFileCdn(carpetaPais, config.MobileLogoBanner);

                if (revistaDigital.TieneRDI)
                {
                    //config.DesktopFondoBanner = revistaDigital.BannerOfertasNoActivaNoSuscrita;
                    config.DesktopFondoBanner = ConfigCdn.GetUrlFileRDCdn(userData.CodigoISO, revistaDigital.BannerOfertasNoActivaNoSuscrita);
                    config.DesktopLogoBanner = revistaDigital.DLogoComercialFondoNoActiva;
                    config.MobileFondoBanner = string.Empty;
                    //config.MobileLogoBanner = revistaDigital.MLogoComercialFondoNoActiva;
                    config.MobileLogoBanner = ConfigCdn.GetUrlFileRDCdn(userData.CodigoISO, revistaDigital.MLogoComercialFondoNoActiva);
                }
                if (revistaDigital.TieneRevistaDigital())
                {
                    config.DesktopFondoBanner = revistaDigital.BannerOfertasNoActivaNoSuscrita;
                    config.DesktopLogoBanner = revistaDigital.DLogoComercialFondoNoActiva;
                    config.MobileFondoBanner = string.Empty;
                    config.MobileLogoBanner = revistaDigital.MLogoComercialFondoNoActiva;
                    if (revistaDigital.EsSuscrita)
                    {
                        config.DesktopFondoBanner = revistaDigital.BannerOfertasActivaSuscrita;
                        config.DesktopLogoBanner = revistaDigital.DLogoComercialFondoActiva;
                        config.MobileFondoBanner = string.Empty;
                        config.MobileLogoBanner = revistaDigital.MLogoComercialFondoActiva;
                    }
                }

                switch (config.Codigo)
                {
                    case Constantes.ConfiguracionPais.InicioRD:
                        if (!revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "Ofertas";
                        config.DesktopFondoBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_ImagenFondo, config.DesktopFondoBanner);
                        config.DesktopTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_TituloBanner, config.DesktopTituloBanner);
                        config.DesktopSubTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_D_SubTituloBanner, config.DesktopSubTituloBanner);

                        config.MobileFondoBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_ImagenFondo, config.MobileFondoBanner);
                        config.MobileTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_TituloBanner, config.MobileTituloBanner);
                        config.MobileSubTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_SI_M_SubTituloBanner, config.MobileSubTituloBanner);

                        

                        if (!revistaDigital.EsSuscrita && !string.IsNullOrEmpty(revistaDigital.DLogoMenuInicioNoActiva))
                        {
                            config.DesktopLogoMenu = revistaDigital.DLogoMenuInicioNoSuscrita;
                            config.DesktopLogoMenuNoActivo = revistaDigital.DLogoMenuInicioNoActivaNoSuscrita;
                        }
                        if (revistaDigital.EsSuscrita && !string.IsNullOrEmpty(revistaDigital.DLogoMenuInicioActiva))
                        {
                            config.DesktopLogoMenu = revistaDigital.DLogoMenuInicioActiva;
                            config.DesktopLogoMenuNoActivo = revistaDigital.DLogoMenuInicioNoActiva;
                        }
           
                        config.Descripcion = string.Empty;
                        config = _configuracionPaisProvider.ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;

                    case Constantes.ConfiguracionPais.Inicio:
                        if (revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "Ofertas";

                        config.DesktopFondoBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenFondo, config.DesktopFondoBanner);
                        config.DesktopLogoBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_ImagenLogo, config.DesktopLogoBanner);
                        config.DesktopTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_TituloBanner, config.DesktopTituloBanner);
                        config.DesktopSubTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_D_SubTituloBanner, config.DesktopSubTituloBanner);

                        config.MobileFondoBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenFondo, config.MobileFondoBanner);
                        config.MobileLogoBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_ImagenLogo, config.MobileLogoBanner);
                        config.MobileTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_TituloBanner, config.MobileTituloBanner);
                        config.MobileSubTituloBanner = _eventoFestivoProvider.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.RD_NO_M_SubTituloBanner, config.MobileSubTituloBanner);

         
                        config.DesktopLogoMenu = revistaDigital.DLogoMenuInicioActiva;
                        config.DesktopLogoMenuNoActivo = revistaDigital.DLogoMenuInicioNoActiva;
 
                        config.Descripcion = string.Empty;
                        config = _configuracionPaisProvider.ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;
                    case Constantes.ConfiguracionPais.ShowRoom:
                        if (!sessionManager.GetEsShowRoom())
                            continue;

                        config.UrlMenu = string.Empty;
                        if (!sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            config.UrlMenu = "ShowRoom/Intriga";
                        }

                        if (sessionManager.GetMostrarShowRoomProductos() &&
                            !sessionManager.GetMostrarShowRoomProductosExpiro())
                        {
                            config.UrlMenu = "ShowRoom";

                        }
                        if (config.UrlMenu == "")
                            continue;

                        break;
                    case Constantes.ConfiguracionPais.OfertaDelDia:
                        if (!sessionManager.OfertaDelDia.Estrategia.TieneOfertaDelDia)
                            continue;

                        config.UrlMenu = "#";
                        config.DesktopTituloBanner = (revistaDigital.TieneRDC&&!revistaDigital.EsSuscrita)? "TODAS TUS OFERTAS EN UN SOLO LUGAR" : config.DesktopTituloBanner;
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        if (!revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                        if (revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "RevistaDigital/Comprar";
                        config = _configuracionPaisProvider.ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        if (!revistaDigital.TieneRDC)
                            continue;

                        config.UrlMenu = "RevistaDigital/Comprar";
                        config = _configuracionPaisProvider.ActualizarTituloYSubtituloBanner(config, revistaDigital);
                        break;
                    case Constantes.ConfiguracionPais.OfertasParaTi:
                        if (revistaDigital.TieneRevistaDigital())
                            continue;

                        config.UrlMenu = "#";
                        break;
                    case Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada:
                        if (!_guiaNegocioProvider.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                            continue;

                        config.UrlMenu = "GuiaNegocio";
                        break;
                    case Constantes.ConfiguracionPais.HerramientasVenta:
                        confiModel.UrlMenu = "HerramientasVenta/Comprar";
                        break;

                    case Constantes.ConfiguracionPais.MasGanadoras:
                        confiModel.UrlMenu = "MasGanadoras/Index";
                        break;
                }

                config = _configuracionPaisProvider.ActualizarTituloYSubtituloMenu(config);
                config = _configuracionPaisProvider.RemplazarTagNombre(config, Constantes.TagCadenaRd.Nombre1, userData.Sobrenombre);

                menuContenedor.Add(config);
            }

            menuContenedor.AddRange(BuildMenuContenedorBloqueado(menuContenedor, userData.CampaniaID, userData.NroCampanias));
            menuContenedor = OrdenarMenuContenedor(menuContenedor, revistaDigital.TieneRevistaDigital(), esMobile);

            sessionManager.SetMenuContenedor(menuContenedor);
            SetMenuContenedorNoSuscrita(menuContenedor, revistaDigital.EsSuscrita);

            menuContenedor.Add(new ConfiguracionPaisModel() { DesktopTituloMenu="SABER MÁS", Codigo = "INFO", CampaniaId=userData.CampaniaID ,UrlMenu= "RevistaDigital/Informacion" , MobileTituloMenu =  "SABER MÁS" });
            return menuContenedor;
        }
        private void SetMenuContenedorNoSuscrita(List<ConfiguracionPaisModel> MenuContenedor, bool EsSuscrita)
        {
            if (EsSuscrita)
            {
                foreach (var menuContenedor in MenuContenedor)
                {
                    if (menuContenedor.Codigo == Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada)
                    {
                        menuContenedor.DesktopTituloBanner = "DISFRUTA DE TU GUIA DE NEGOCIO ONLINE EN";
                    }
                    if (menuContenedor.Codigo == Constantes.ConfiguracionPais.Lanzamiento)
                    {
                        menuContenedor.DesktopTituloBanner = "DISFRUTA DE LO NUEVO !NUEVO! SOLO CON";
                    }
                }
            }
            
        }
        public List<ConfiguracionPaisModel> BuildMenuContenedorBloqueado(List<ConfiguracionPaisModel> menuContenedor, int CampaniaID, int NroCampanias)
        {
            var menuContenedorBloqueado = new List<ConfiguracionPaisModel>();
            foreach (var configuracionPais in menuContenedor)
            {
                ConfiguracionPaisModel config;
                switch (configuracionPais.Codigo)
                {
                    case Constantes.ConfiguracionPais.InicioRD:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/Ofertas/Revisar";
                        config.CampaniaId = Util.AddCampaniaAndNumero(CampaniaID, 1, NroCampanias);
                        menuContenedorBloqueado.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.Lanzamiento:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "#";
                        config.CampaniaId = Util.AddCampaniaAndNumero(CampaniaID, 1, NroCampanias);
                        menuContenedorBloqueado.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/RevistaDigital/Revisar";
                        config.CampaniaId = Util.AddCampaniaAndNumero(CampaniaID, 1, NroCampanias);
                        menuContenedorBloqueado.Add(config);
                        break;
                    case Constantes.ConfiguracionPais.HerramientasVenta:
                        config = (ConfiguracionPaisModel)configuracionPais.Clone();
                        config.UrlMenu = "/HerramientasVenta/Revisar";
                        config.CampaniaId = Util.AddCampaniaAndNumero(CampaniaID, 1, NroCampanias);
                        menuContenedorBloqueado.Add(config);
                        break;
                }
            }
            return menuContenedorBloqueado;
        }

        public virtual List<ConfiguracionPaisModel> OrdenarMenuContenedor(List<ConfiguracionPaisModel> menuContenedor, bool tieneRevistaDigital, bool esMobile)
        {
            if (tieneRevistaDigital && esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.MobileOrdenBPT).ToList();
            }
            if (tieneRevistaDigital && !esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.OrdenBpt).ToList();
            }
            if (!tieneRevistaDigital && esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.MobileOrden).ToList();

            }
            if (!tieneRevistaDigital && !esMobile)
            {
                menuContenedor = menuContenedor.OrderBy(m => m.Orden).ToList();
            }

            return menuContenedor;
        }
    }
}