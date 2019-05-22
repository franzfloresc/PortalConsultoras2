﻿using System.Web.Optimization;

namespace Portal.Consultoras.Web
{
    public static class BundleConfig
    {
        /// <summary>
        /// [~/Bundle]/[Js|Css]/[Desktop|Mobile|Mixto|Responsive]/[Funcionalidad|Página]
        /// </summary>
        /// <param name="bundles"></param>
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/Login2").Include(
                "~/Scripts/jquery-1.11.2.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/jquery.custom-scrollbar.js",
                "~/Scripts/PortalConsultoras/Shared/LoginLayout.js",
                "~/Scripts/LogError.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Site-Contenedor").Include(
                "~/Content/Css/Site/flipclock.css",
                "~/Content/Css/Site/slick.css",
               "~/Content/Css/Site/Menu/MenuGeneral.css",
               "~/Content/Css/Site/Menu/MenuContenedor.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Site-CssMain").Include(
                "~/Content/Css/ui.jquery/jquery-ui.css",
                "~/Content/Css/Site/style.css",
                "~/Content/Css/Site/style-tismart.css",
                "~/Content/Css/ui.jqgrid/ui.jqgrid.css"

            ));


            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/JQueryJs").Include(
               "~/Scripts/jquery-1.11.2.js",
               "~/Scripts/jquery-migrate-1.2.1.js",
               "~/Scripts/jquery.validate.js",
               "~/Scripts/jquery.validate.unobtrusive.js",
               "~/Scripts/jquery.unobtrusive-ajax.js",
               "~/Scripts/jquery-ui-1.9.2.custom.js",
               "~/Scripts/HojaInscripcion/validations.js",
               "~/Scripts/donetyping.js",
               "~/Scripts/jquery.lazy.js"
            ));
            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/JQuery3Js").Include(
                "~/Scripts/jquery-3.3.1.js",
                "~/Scripts/jquery-migrate-1.2.1.js",
                "~/Scripts/jquery-migrate-3.0.0.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/jquery.unobtrusive-ajax.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/HojaInscripcion/validations.js",
                "~/Scripts/donetyping.js",
                "~/Scripts/jquery.lazy.js"
            ));
            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/JQGridJs").Include(
               "~/Scripts/Jqgrid/grid.locale-sp*",
               "~/Scripts/Jqgrid/jquery.jqGrid*"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/ShowRoom-Index").Include(
                "~/Scripts/nieve.js",
                "~/Scripts/ion.rangeSlider/ion.rangeSlider.js",
                "~/Scripts/PortalConsultoras/ShowRoom/Index.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/ShowRoom/ShowRoom.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-SeccionDorada.js"
                ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/PluginsHeaderSAC").Include(
                "~/Scripts/maskedinput.js",
                "~/Scripts/General.js",
                "~/Scripts/JsonSupport.js",
                "~/Scripts/modernizr.custom.js",
                "~/Scripts/jquery.index.js",
                "~/Scripts/jqueryslidemenu.js",
                "~/Scripts/jquery.easing.1.3.js",
                "~/Scripts/jquery.touchSwipe.min.js",
                "~/Scripts/jquery.cycle.all.min.js",
                "~/Scripts/respond.min.js",
                "~/Scripts/trans-banner.js",
                "~/Scripts/jquery.tmpl.js",
                "~/Scripts/LogError.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/AdminContenido/General.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/PluginsFooterSAC").Include(
               "~/Scripts/custom.js",
               "~/Scripts/jquery.flexnav.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/JSTree").Include(
               "~/Scripts/jquery.jstree.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/MobileLayout").Include(
                "~/Scripts/jquery-1.11.2.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/bootstrap.js",
                "~/Scripts/accordion.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/flipclock.js",
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/slick.js",
                "~/Scripts/jquery.lazy.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/LogError.js",
                "~/Scripts/menu.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/General.js",
                "~/Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js",
                "~/Scripts/PortalConsultoras/Shared/MenuPortal.js",
                "~/Scripts/PortalConsultoras/Shared/idle.js",
                "~/Scripts/PortalConsultoras/Shared/cierre-session.js",
                "~/Scripts/PortalConsultoras/Shared/MenuContenedor.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/Buscador/BuscadorProvider.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/MobileLayoutContenedor").Include(
                "~/Scripts/jquery-1.11.2.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/bootstrap.js",
                "~/Scripts/accordion.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/flipclock.js",
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/slick.js",
                "~/Scripts/jquery.lazy.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/LogError.js",
                "~/Scripts/menu.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/General.js",
                "~/Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js",
                "~/Scripts/PortalConsultoras/Shared/idle.js",
                "~/Scripts/PortalConsultoras/Shared/cierre-session.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/Shared/MenuPortal.js",
                "~/Scripts/PortalConsultoras/Shared/MenuContenedor.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/BannerInteractivo.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/LayoutEmpty").Include(
                "~/Scripts/jquery-1.11.2.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/bootstrap.js",
                "~/Scripts/fingerprint2.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/General.js",
                "~/Scripts/LogError.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/PageResponsive").Include(
                "~/Scripts/handlebars.js",
                "~/Scripts/LogError.js",
                "~/Scripts/General.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/PortalConsultoras/Shared/Menu.js",
                "~/Scripts/PortalConsultoras/Shared/MainLayoutResponsive.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/Bienvenida/OfertaDelDia.js",
                "~/Scripts/PortalConsultoras/Shared/MainLayout.js",
                "~/Scripts/PortalConsultoras/Shared/idle.js",
                "~/Scripts/PortalConsultoras/Shared/cierre-session.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/Buscador/BuscadorProvider.js",
                "~/Scripts/PortalConsultoras/Buscador/BuscadorModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/PedidoRegistro.js",
                "~/Scripts/PortalConsultoras/Shared/MenuPortal.js",
                "~/Scripts/PortalConsultoras/Shared/MenuContenedor.js",
                "~/Scripts/slick.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/BannerInteractivo.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/BusquedaProducto").Include(
                "~/Scripts/PortalConsultoras/Buscador/BusquedaProductoModule.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Fuzemodal").Include(
                "~/Scripts/fuzemodal-1.3/fuzemodal-1.3.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/HojaInscripcion").Include(
                "~/Content/HojaInscripcion/*.css",
                "~/Content/DatetimePicker/*.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/JS/Desktop/HojaInscripcion").Include(
                "~/Scripts/jquery-1.11.2.js",
                "~/Scripts/jquery.unobtrusive-ajax.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/jquery-labelauty.js",
                "~/Scripts/jquery-ui-{version}.js",
                "~/Scripts/donetyping.js",
                "~/Scripts/HojaInscripcion/*.js",
                "~/Scripts/DatetimePicker/*.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/Site-Esika-CssSB2").Include(
               "~/Content/Css/Site/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Site/Esika/reset.css",
               "~/Content/Css/Site/Esika/styleDefault.css",
               "~/Content/Css/Site/Esika/style.css",
               "~/Content/Css/Site/Menu/MenuPrincipal.css",
               "~/Content/Css/ui.jquery/Esika/jquery-ui.css",
               "~/Content/Css/Site/RevistaDigital/index.css",
               "~/Content/Css/Site/Esika/revistaDigital.css",
               "~/Content/Css/Site/Esika/seccion-descarga-imprime.css",
               "~/Content/Css/Site/Esika/buscador-filtros.css",
               "~/Content/Css/Site/ProductoListado/CajaProducto.css",
               "~/Content/Css/Site/Pedido/PedidoInfo.css",
               "~/Content/Css/Site/Pedido/EditarProductoFicha.css"
               ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Site-AsesoraOnline").Include(
                "~/Content/Css/Site/asesora-online.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/Site-Esika-Contenedor").Include(
                "~/Content/Css/Site/Contenedor/Index.css",
                "~/Content/Css/Site/Esika/Contenedor.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Esika-Contenedor").Include(
                "~/Content/Css/Mobile/Contenedor/Index.css",
                "~/Content/Css/Site/Menu/MenuGeneral.css",
                "~/Content/Css/Mobile/Contenedor/MenuContenedor.css",
                "~/Content/Css/Mobile/Esika/Contenedor.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/Site-Lbel-CssSB2").Include(
               "~/Content/Css/Site/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Site/Lbel/reset.css",
               "~/Content/Css/Site/Lbel/styleDefault.css",
               "~/Content/Css/Site/Lbel/style.css",
               "~/Content/Css/Site/Menu/MenuPrincipal.css",
               "~/Content/Css/ui.jquery/Lbel/jquery-ui.css",
               "~/Content/Css/Site/RevistaDigital/index.css",
               "~/Content/Css/Site/Lbel/revistaDigital.css",
               "~/Content/Css/Site/Lbel/seccion-descarga-imprime.css",
               "~/Content/Css/Site/Lbel/buscador-filtros.css",
               "~/Content/Css/Site/Pedido/PedidoInfo.css",
               "~/Content/Css/Site/Pedido/EditarProductoFicha.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/Site-Lbel-Contenedor").Include(
                "~/Content/Css/Site/Contenedor/Index.css",
                "~/Content/Css/Site/Lbel/Contenedor.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Lbel-Contenedor").Include(
                "~/Content/Css/Mobile/Contenedor/Index.css",
               "~/Content/Css/Site/Menu/MenuGeneral.css",
                "~/Content/Css/Mobile/Contenedor/MenuContenedor.css",
                "~/Content/Css/Mobile/Lbel/Contenedor.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/esika-CssSB2Mobile").Include(
               "~/Content/Css/Mobile/Esika/icomon.css",
               "~/Content/Css/Mobile/Esika/menu.css",
               "~/Content/Css/Mobile/Esika/style.css",
               "~/Content/Css/Site/Menu/MenuPrincipal.css",
               "~/Content/Css/Site/Esika/styleDefault.css",
               "~/Content/Css/Mobile/Esika/theme.css",
               "~/Content/Css/Mobile/flexslider.css",
               "~/Content/Css/Mobile/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Site/asesora-online.css",
               "~/Content/Css/Mobile/Esika/misDatos.css",
               "~/Content/Css/Mobile/RevistaDigital/index.css",
               "~/Content/Css/Mobile/Esika/revistaDigital.css",
               "~/Content/Css/Mobile/Esika/seccion-descarga-imprime.css",
               "~/Content/Css/Mobile/calc.css",
               "~/Content/Css/Site/ProductosRecomendados/productos-recomendados.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/lbel-CssSB2Mobile").Include(
               "~/Content/Css/Mobile/lbel/icomon.css",
               "~/Content/Css/Mobile/lbel/menu.css",
               "~/Content/Css/Mobile/lbel/style.css",
               "~/Content/Css/Site/Menu/MenuPrincipal.css",
               "~/Content/Css/Site/Lbel/styleDefault.css",
               "~/Content/Css/Mobile/lbel/theme.css",
               "~/Content/Css/Mobile/flexslider.css",
               "~/Content/Css/Mobile/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Mobile/lbel/misDatos.css",
               "~/Content/Css/Mobile/RevistaDigital/index.css",
               "~/Content/Css/Mobile/Lbel/revistaDigital.css",
               "~/Content/Css/Mobile/Lbel/seccion-descarga-imprime.css",
               "~/Content/Css/Mobile/calc.css",
               "~/Content/Css/Site/ProductosRecomendados/productos-recomendados.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/CssBienvenida").Include(
                "~/Content/Css/Mobile/Esika/bootstrap-slider.min.css",
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Site/flexslider.css",
                "~/Content/Css/Site/RevistaDigital/Bienvenido-Pedido-Catalogo.css",
                "~/Content/Css/Site/RevistaDigital/PopupSuscripcion.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css",
                "~/Content/Css/Site/jquery.custom-scrollbar.css",
                "~/Content/Css/Site/Landing/producto.landing.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/SB2").Include(
                "~/Scripts/modernizr.custom.js",
                "~/Scripts/respond.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/General.js",
                "~/Scripts/JsonSupport.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/PortalConsultoras/Bienvenida/OfertaDelDia.js",
                "~/Scripts/PortalConsultoras/Shared/MainLayout.js",
                "~/Scripts/PortalConsultoras/Shared/idle.js",
                "~/Scripts/PortalConsultoras/Shared/cierre-session.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Shared/Menu.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/Shared/MenuPortal.js",
                "~/Scripts/PortalConsultoras/Shared/MenuContenedor.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/LogError.js",
                "~/Scripts/flipclock.js",
                "~/Scripts/slick.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/Buscador/BuscadorProvider.js",
                "~/Scripts/PortalConsultoras/Buscador/BuscadorModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/PedidoRegistro.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/BannerInteractivo.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/SB2-Bienvenida").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Index.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/CarruselModule.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/ShowRoom/ShowRoom.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-SuscripcionPopup.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/TagManager/Liquidacion.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/jquery.rateyo.js",
                "~/Scripts/jquery.easy-pie-chart.js",
                "~/Scripts/jquery.custom-scrollbar.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Site-CssPedido").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/style-pedido.css",
                "~/Content/Css/Site/RevistaDigital/Bienvenido-Pedido-Catalogo.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css",
                "~/Content/Css/Site/ProductosRecomendados/productos-recomendados.css",
                "~/Content/Css/Site/Pedido/PedidoGrilla.css",
                "~/Content/Css/Site/Pedido/PedidoTooltip.css",
                "~/Content/Css/Site/Landing/producto.landing.css"
            ));

            //Tener en cuenta : se esta usando en pedidoFic.
            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/PedidoValidado").Include(
                "~/Content/Css/Site/style-pedido.css",
                "~/Content/Css/Site/Pedido/PedidoGrilla.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/SB2-Pedido").Include(
                "~/Scripts/PortalConsultoras/Pedido/PedidoProvider.js",
                "~/Scripts/PortalConsultoras/Pedido/Index.js",
                 "~/Scripts/PortalConsultoras/Pedido/barra.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/CarruselModule.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertafinal.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/Pedido/tooltip.js",
                "~/Scripts/PortalConsultoras/ProductoRecomendado/ProductoRecomendadoModule.js",
                "~/Scripts/PortalConsultoras/Pedido/KitNuevas.js",
                //INI HD-4200
                "~/Scripts/PortalConsultoras/Pedido/SuscripcionSE.js"
                //FIN HD-4200
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/PedidoValidado").Include(
               "~/Scripts/PortalConsultoras/Pedido/Validado.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/OfertaDelDia").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/OfertaDelDia.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/Bienvenida").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/CarruselModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/PortalConsultoras/Mobile/Bienvenida/Index.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-SuscripcionPopup.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/jquery.rateyo.js",
                "~/Scripts/jquery.custom-scrollbar.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/CcsBienvenida").Include(
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Mobile/RevistaDigital/Bienvenido-Pedido-Catalogo.css",
                "~/Content/Css/Mobile/RevistaDigital/PopupSuscripcion.css",
                "~/Content/Css/Site/jquery.custom-scrollbar.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/MisCatalogoRevista").Include(
                "~/Content/Css/Site/jquery.tag-editor.css",
                "~/Content/Css/Site/RevistaDigital/Bienvenido-Pedido-Catalogo.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/Js-Login").Include(
               "~/Scripts/General.js",
               "~/Scripts/PortalConsultoras/Login/Analytics.js",
               "~/Scripts/PortalConsultoras/Login/FormsSignIn.js",
               "~/Scripts/CryptoJS/aes.js",
               "~/Scripts/CryptoJS/pbkdf2.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/Login-Header").Include(
               "~/Scripts/PortalConsultoras/Login/Analytics.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/Login-VerificaAutenticidad").Include(
                "~/Scripts/jquery-1.11.2.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/General.js",
                "~/Scripts/PortalConsultoras/Login/VerificaAutenticidad.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/Content-Login").Include(
               "~/Content/Css/ui.jquery/jquery-ui.css",
               "~/Content/Css/Site/jquery.custom-scrollbar.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/Pedido").Include(
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/CarruselModule.js",
                "~/Scripts/PortalConsultoras/Pedido/PedidoProvider.js",
                "~/Scripts/PortalConsultoras/Mobile/Pedido/index.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/ProductoRecomendado/ProductoRecomendadoModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/PedidoRegistro.js",
                "~/Scripts/PortalConsultoras/Pedido/KitNuevas.js",
                //INI HD-4200
                "~/Scripts/PortalConsultoras/Pedido/SuscripcionSE.js"
               //FIN HD-4200
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/PedidoDetalle").Include(
                "~/Scripts/PortalConsultoras/Pedido/PedidoProvider.js",
                "~/Scripts/PortalConsultoras/Mobile/Pedido/Detalle.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertaFinal.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Pedido/tooltip.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/PedidoRegistro.js",
                "~/Scripts/PortalConsultoras/Pedido/KitNuevas.js",
                //INI HD-4200
                "~/Scripts/PortalConsultoras/Pedido/SuscripcionSE.js",
                //FIN HD-4200
                "~/Scripts/PortalConsultoras/Pedido/barra.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/_LoginLayout-Esika").Include(
               "~/Content/Css/Site/Login2/style_esika.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/_LoginLayout-Lbel").Include(
               "~/Content/Css/Site/Login2/style_lbel.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/PedidoFIC-Detalle").Include(
                "~/Scripts/PortalConsultoras/Mobile/PedidoFIC/Detalle.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertaFinal.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/PedidoFIC").Include(
                "~/Scripts/PortalConsultoras/Mobile/PedidoFIC/Index.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js"
             ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/ActualizarMatrizCampania").Include(
                "~/Scripts/fileuploader.js",
                "~/Scripts/jquery.form.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/AdminContenido/ToastHelper.js",
                "~/Scripts/AdminContenido/Paginador.js",
                "~/Scripts/AdminContenido/Nemotecnico.js",
                "~/Scripts/AdminContenido/MatrizComercialFileUpload.js",
                "~/Scripts/PortalConsultoras/MatrizCampania/ActualizarMatrizCampaniaModule.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/Ofertas").Include(
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/CarruselModule.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/Index.js",
                "~/Scripts/PortalConsultoras/ShowRoom/ShowRoom.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/Bienvenida/OfertaDelDia.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/Descargables.js"
            //"~/Scripts/PortalConsultoras/EstrategiaPersonalizada/BannerInteractivo.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Ofertas").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/flexslider.css",
                "~/Content/Css/Site/Contenedor/carrusel.individual.css",
                "~/Content/Css/Site/Contenedor/producto.simple.css",
                "~/Content/Css/Site/Contenedor/OfertaDelDia.css",
                "~/Content/Css/Site/Contenedor/BannerInteractivo.css",
                "~/Content/Css/Site/MasGanadoras/banner_ofertas_masGanadoras.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css",
                "~/Content/Css/Site/Ficha/Ficha.css",
                "~/Content/Css/Site/Ficha/Carrusel.css",
                "~/Content/Css/Site/Ficha/RedesSociales.css"
            ));


            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/Ofertas").Include(
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/CarruselModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/Index.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/CajaProducto.js"
            //"~/Scripts/PortalConsultoras/EstrategiaPersonalizada/BannerInteractivo.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Ofertas").Include(
                "~/Content/Css/Site/slick.css",
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Mobile/Contenedor/carrusel.individual.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css",
                "~/Content/Css/Mobile/LasMasGanadoras/presentacion-seccion-carrusel.css",
                "~/Content/Css/Mobile/LasMasGanadoras/banner_ofertas_masGanadoras.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProductoV2.css",
                "~/Content/Css/Site/Contenedor/BannerInteractivo.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Pedido").Include(
                "~/Content/Css/Mobile/RevistaDigital/Bienvenido-Pedido-Catalogo.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css",
                "~/Content/Css/Mobile/Pedido/PedidoGrilla.css",
                "~/Content/Css/Mobile/Pedido/EditarProductoFicha.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/PedidoDetalle").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Mobile/Pedido/PedidoGrilla.css",
                "~/Content/Css/Mobile/Pedido/EditarProductoFicha.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Catalogo").Include(
                "~/Content/Css/Mobile/jquery.tag-editor.css",
                "~/Content/Css/Mobile/RevistaDigital/Bienvenido-Pedido-Catalogo.css"
            ));


            #region RevistaDigital

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/RevistaDigital-Informativa").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/General.js",
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-ConfirmarDatos.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/RevistaDigital-Informativa").Include(
                "~/Content/Css/Site/RevistaDigital/PaginaInformativa.css",
                "~/Content/Css/Site/RevistaDigital/ConfirmarDatos.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/RevistaDigital-Landing").Include(
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-SeccionDorada.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/RevistaDigital-Landing").Include(
                "~/Content/Css/Site/ProductoListado/Landing.css",
                "~/Content/Css/Site/Landing/producto.landing.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/RevistaDigital-Informativa").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-ConfirmarDatos.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/RevistaDigital-Informativa").Include(
                "~/Content/Css/Mobile/RevistaDigital/PaginaInformativa.css",
                "~/Content/Css/Mobile/RevistaDigital/ConfirmarDatos.css",
                "~/Content/Css/Mobile/RevistaDigital/PopupSuscripcion.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/RevistaDigital-Landing").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-SeccionDorada.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/GuiaNegocio").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/Mobile/GuiaNegocio/GuiaNegocio-Landing.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/RevistaDigital-Landing").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/flexslider.css",
                "~/Content/Css/Mobile/RevistaDigital/RedimensionLandingRD.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/MisReclamos").Include(
                "~/Scripts/PortalConsultoras/Mobile/MisReclamos/Index.js"
            ));

            #endregion

            #region Cliente
            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/TusClientes").Include(
                "~/Scripts/PortalConsultoras/TusClientes/TusClientesProvider.js",
                "~/Scripts/PortalConsultoras/TusClientes/PanelListaModule.js",
                "~/Scripts/PortalConsultoras/TusClientes/PanelMantenerModule.js",
                "~/Scripts/PortalConsultoras/TusClientes/ClientePanelModule.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/TusClientesIndex").Include(
                "~/Scripts/PortalConsultoras/TusClientes/TusClientesProvider.js",
                "~/Scripts/PortalConsultoras/TusClientes/TusClientesModule.js",
                "~/Scripts/PortalConsultoras/TusClientes/PanelMantenerModule.js"
            ));
            #endregion

            #region DetalleEstrategia
            
            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/EstrategiaAgregar").Include(
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/Ficha").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/General.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/ListaOpcionesModule.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/ComponentesModule.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/OpcionesSeleccionadasModule.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/TituloOpcionesSeleccionadasModule.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/ResumenOpcionesModule.js",
                
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/CarruselModule.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/DetalleEstrategiaProvider.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/ComponenteDetalleModule.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/Ficha/FichaModule.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Ficha").Include(
                "~/Content/Css/Site/Ficha/Ficha.css",
                "~/Content/Css/Site/Ficha/Carrusel.css",
                "~/Content/Css/Site/Ficha/RedesSociales.css",
                "~/Content/Css/Site/Ficha/PopoverTooltip.css",
                "~/Content/Css/Site/Ficha/SeleccionarTipo.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Ficha-Esika").Include(
                "~/Content/Css/Site/Ficha/Esika/FichaEsika.css",
                "~/Content/Css/Site/MasGanadoras/banner_ofertas_masGanadoras_Esika.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Ficha-Lbel").Include(
                "~/Content/Css/Site/Ficha/Lbel/FichaLbel.css",
                "~/Content/Css/Site/MasGanadoras/banner_ofertas_masGanadoras_Lbel.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Ficha").Include(
                "~/Content/Css/Mobile/Ficha/ficha.css",
                "~/Content/Css/Mobile/Ficha/Carrusel.css",
                "~/Content/Css/Mobile/Ficha/RedesSociales.css",
                "~/Content/Css/Mobile/Ficha/PopoverTooltip.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css",
                "~/Content/Css/Mobile/Ficha/SeleccionarTipo.css",
                "~/Content/Css/Mobile/Clientes/Asignarcliente.css",
                "~/Content/Css/Mobile/Ficha/FichaEnriquecida.css"

            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Ficha-Esika").Include(
                "~/Content/Css/Mobile/Ficha/Esika/FichaEsika.css",
                "~/Content/Css/Site/MasGanadoras/banner_ofertas_masGanadoras_Esika.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/Ficha-Lbel").Include(
                "~/Content/Css/Mobile/Ficha/Lbel/FichaLbel.css",
                "~/Content/Css/Site/MasGanadoras/banner_ofertas_masGanadoras_Lbel.css"
            ));

            #endregion

            #region MisCatalogosRevistas

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/MisCatalogosRevistas").Include(
                 "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                 "~/Scripts/Tag/jquery.tags.input.js",
                 "~/Scripts/PortalConsultoras/MisCatalogosRevistas/Index.js",
                 "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                 "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js"
            ));

            #endregion

            #region GuiaNegocio

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/GuiaNegocio").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/GuiaNegocio/GuiaNegocio-Landing.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/GuiaNegocio").Include(
                "~/Content/Css/Site/ProductoListado/Landing.css",
                "~/Content/Css/Site/RevistaDigital/Gnd-Flotante.css",
                "~/Content/Css/Site/Landing/producto.landing.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/GuiaNegocio").Include(
                "~/Content/Css/Mobile/RevistaDigital/Gnd-Flotante.css",
                "~/Content/Css/Mobile/RevistaDigital/RedimensionLandingRD.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css"
            ));

            #endregion

            #region HerramientasVenta

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/HerramientaVenta-Landing").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/HerramientaVenta-Landing").Include(
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/HerramientaVenta-Landing").Include(
                "~/Content/Css/Site/ProductoListado/Landing.css",
                "~/Content/Css/Site/Landing/producto.landing.css",
                "~/Content/Css/Site/ProductoListado/CajaProducto.css"

            ));

            #endregion

            #region Estrategias-UpSelling

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/Upselling")
                .Include("~/Content/Css/Site/Admin/Estrategias/UpSelling.css"));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/Upselling").Include(
                "~/Scripts/knockout-{version}.js",
                "~/Scripts/knockout.extensions.js",
                "~/Scripts/PortalConsultoras/Estrategia/UpSelling/api.js",
                "~/Scripts/PortalConsultoras/Estrategia/UpSelling/Index.js",
                "~/Scripts/fileuploader.js"
            ));

            #endregion

            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/EstrategiaProducto-DetalleProducto").Include(
               "~/Scripts/jquery.flexslider.js",
               "~/Scripts/jquery.rateyo.js",
               "~/Scripts/PortalConsultoras/BestSeller/BestSellerCommentModule.js",
               "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
               "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
               "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
               "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
               "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarPovider.js",
               "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
               "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
               "~/Scripts/PortalConsultoras/Pedido/barra.js"
           ));


            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/EstrategiaProducto-DetalleProducto").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Mobile/esika/bootstrap-slider.min.css"
           ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/ShowRoom-Intriga").Include(
                "~/Scripts/PortalConsultoras/ShowRoom/Intriga.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
              ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/OfertaDelDia-EstrategiaAgregar").Include(
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
             ));



            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/ShowRoom-index").Include(
                "~/Scripts/PortalConsultoras/Mobile/ShowRoom/Index.js",
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/ShowRoom/ShowRoom.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-SeccionDorada.js",
                "~/Scripts/PortalConsultoras/Shared/CodigoUbigeoPortal.js",
                "~/Scripts/PortalConsultoras/Shared/AnalyticsPortal.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js"
           ));


            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/ShowRoom-Index").Include(
                "~/Content/Css/Site/ion.rangeSlider/normalize.css",
                "~/Content/Css/Site/ion.rangeSlider/ion.rangeSlider.css",
                "~/Content/Css/Site/ion.rangeSlider/ion.rangeSlider.skinHTML5.css",
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/Landing/producto.landing.css"
            ));



            bundles.Add(new StyleBundle("~/Bundle/Css/Mobile/ShowRoom-Index").Include(
                "~/Content/Css/Mobile/esika/slick.css",
                "~/Content/Css/Mobile/esika/bootstrap-slider.min.css",
                "~/Content/Css/Mobile/RevistaDigital/RedimensionLandingRD.css",
                "~/Content/Css/Mobile/ProductoListado/CajaProducto.css",
                "~/Content/Css/Mobile/Ficha/ficha.css"
            ));

            //Se aisló el css de bootstrap de los otros css de Bundle/Css/Mixto, porque generaba errores de minificación
            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/Bootstrap").Include(
                "~/Content/Css/Site/bootstrap/bootstrap.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/LayoutResponsive").Include(
                "~/Content/Css/ui.jquery/jquery-ui.css",
                "~/Content/Css/Site/Shared/general.css",
                "~/Content/Css/Site/Shared/header-responsive.css",
                "~/Content/Css/Site/Shared/menu-principal-responsive.css",
                "~/Content/Css/Site/Shared/buscador-responsive.css",
                "~/Content/Css/Site/Shared/menu-secundario-responsive.css",
                "~/Content/Css/Site/Shared/footer-responsive.css",
                "~/Content/Css/Site/Menu/MenuContenedorResponsive.css",
                "~/Content/Css/Site/slick.css",
                "~/Content/Css/Site/Ficha/PopoverTooltip.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/EsikaPageResponsive").Include(
                "~/Content/Css/Site/Esika/marca-pais-responsive.css",
                "~/Content/Css/Site/Esika/styleDefault.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/LebelPageResponsive").Include(
                "~/Content/Css/Site/Lbel/marca-pais-responsive.css",
                "~/Content/Css/Site/Lbel/styleDefault.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Responsive/TusClientes").Include(
                "~/Content/Css/Site/Pedido/PedidoTooltip.css",
                "~/Content/Css/Mobile/Clientes/Asignarcliente.css",
                "~/Content/Css/Site/TusClientes/TusClientes_Responsive.css"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Mixto/SugerenciaPendientes").Include(
                "~/Content/Css/Site/slick.css",
                "~/Content/Css/Mobile/ConsultoraOnline/Pendientes.css"
            ));
            bundles.Add(new ScriptBundle("~/Bundle/Js/Mobile/SugerenciaPendientes").Include(
                "~/Scripts/PortalConsultoras/Mobile/ConsultoraOnline/PedidoPendienteMedioCompra.js",
                "~/Scripts/PortalConsultoras/Mobile/ConsultoraOnline/Pendientes.js",
               "~/Scripts/slick.js"
            ));

            bundles.Add(new StyleBundle("~/Bundle/Css/Desktop/SugerenciaPendientes").Include(
                "~/Content/Css/Site/slick.css",
                "~/Content/Css/Site/ConsultoraOnline/Pendientes.css",
                "~/Content/Css/Site/ConsultoraOnline/Pendientes.rewrite.css"
            ));
            bundles.Add(new ScriptBundle("~/Bundle/Js/Desktop/SugerenciaPendientes").Include(
               "~/Scripts/PortalConsultoras/ConsultoraOnline/DetallePedidoPendiente.js",
               "~/Scripts/PortalConsultoras/ConsultoraOnline/Pendientes.js",
                "~/Scripts/General.js"
            ));


            #region CaminoBrillante
            bundles.Add(new StyleBundle("~/Bundle/Css/CaminoBrillante").Include(
                "~/Content/Css/ui.jquery/jquery-ui.css",
                "~/Content/CaminoBrillante/css/estilos.css",
                "~/Scripts/owl.carousel.2.0.0-beta.2.4/assets/owl.carousel.css"));


            bundles.Add(new ScriptBundle("~/Bundle/Js/CaminoBrillante").Include(
                "~/Scripts/jquery-1.11.2.min.js",
                "~/Scripts/bootstrap.min.js",
                "~/Scripts/owl.carousel.js",
                "~/Scripts/PortalConsultoras/CaminoBrillante/index.js"));

            #endregion
            #region ArmaTuPack
            
            bundles.Add(new StyleBundle("~/Bundle/Css/Responsive/ArmaTuPack").Include(
                "~/Content/Css/Site/ArmaTuPack/ArmaTuPack_Responsive.css",
                "~/Content/Css/Site/ficha/SeleccionarTipo.css"
            ));

            bundles.Add(new ScriptBundle("~/Bundle/Js/Mixto/ArmaTuPack").Include(
                 "~/Scripts/PortalConsultoras/ArmaTuPack/ArmaTuPackProvider.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/Cabecera/CabeceraView.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/Cabecera/CabeceraPresenter.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/Grupos/GruposView.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/Grupos/GruposPresenter.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosView.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosPresenter.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/ArmaTuPackDetalleEvents.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/DetallePresenter.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/Detalle/Detalle.js",
                 "~/Scripts/PortalConsultoras/ArmaTuPack/ArmaTuPack.js"
              ));


            bundles.Add(new ScriptBundle("~/Bundle/Js/Pedido/ArmaTuPack").Include(
                "~/Scripts/PortalConsultoras/ArmaTuPack/ArmaTuPack.js"
             ));
            #endregion


#if DEBUG
            BundleTable.EnableOptimizations = false;
#else
            BundleTable.EnableOptimizations = true;
#endif
        }
    }
}