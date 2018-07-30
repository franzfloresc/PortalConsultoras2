using System.Web.Optimization;

namespace Portal.Consultoras.Web
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/JsLogin2").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/jquery.custom-scrollbar.js",
                "~/Scripts/PortalConsultoras/Shared/LoginLayout.js",
                "~/Scripts/LogError.js"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/CssMain").Include(
                "~/Content/Css/ui.jquery/jquery-ui.css",
                "~/Content/Css/Site/style.css",
                "~/Content/Css/Site/style-tismart.css",
                "~/Content/Css/ui.jqgrid/ui.jqgrid.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JQueryJs").Include(
               "~/Scripts/jquery-{version}.js",
               "~/Scripts/jquery-migrate-{version}.js",
               "~/Scripts/jquery.validate.js",
               "~/Scripts/jquery.validate.unobtrusive.js",
               "~/Scripts/jquery.unobtrusive-ajax.js",
               "~/Scripts/jquery-ui-1.9.2.custom.js",
               "~/Scripts/HojaInscripcion/validations.js",
               "~/Scripts/donetyping.js",
               "~/Scripts/jquery.lazy.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JQGridJs").Include(
               "~/Scripts/Jqgrid/grid.locale-sp*",
               "~/Scripts/Jqgrid/jquery.jqGrid*"
            ));

            bundles.Add(new ScriptBundle("~/Scripts/PortalConsultoras/ShowRoom/ShowRoomJs").Include(
                "~/Scripts/PortalConsultoras/ShowRoom/Index.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/ShowRoom/ShowRoom.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsPluginsHeaderSAC").Include(
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
                "~/Scripts/LogError.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsPluginsFooterSAC").Include(
               "~/Scripts/custom.js",
               "~/Scripts/jquery.flexnav.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JSTree").Include(
               "~/Scripts/jquery.jstree.js"
            ));

            bundles.Add(new ScriptBundle("~/Scripts/MobileLayout").Include(
                "~/Scripts/jquery-{version}.js",
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
                "~/Scripts/PortalConsultoras/Shared/MenuContenedor.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new ScriptBundle("~/Scripts/MobileLayoutContenedor").Include(
                "~/Scripts/jquery-{version}.js",
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
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/Shared/MenuContenedor.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js"
            ));

            bundles.Add(new ScriptBundle("~/Scripts/MobileLayoutEmpty").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/bootstrap.js",
                "~/Scripts/fingerprint2.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/General.js",
                "~/Scripts/LogError.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/CSSFuzemodal").Include(
                "~/Scripts/fuzemodal-1.3/fuzemodal-1.3.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/CSSHojaInscripcion").Include(
                "~/Content/HojaInscripcion/*.css",
                "~/Content/DatetimePicker/*.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JSHojaInscripcion").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/jquery.unobtrusive-ajax.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/jquery-labelauty.js",
                "~/Scripts/jquery-ui-{version}.js",
                "~/Scripts/donetyping.js",
                "~/Scripts/HojaInscripcion/*.js",
                "~/Scripts/DatetimePicker/*.js"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/Esika/CssSB2").Include(
               "~/Content/Css/Site/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Site/Esika/reset.css",
               "~/Content/Css/Site/Esika/style.css",
               "~/Content/Css/Site/Esika/styleDefault.css",
               "~/Content/Css/ui.jquery/Esika/jquery-ui.css",
               "~/Content/Css/Site/RevistaDigital/index.css",
               "~/Content/Css/Site/Esika/revistaDigital.css",
               "~/Content/Css/Site/Esika/seccion-descarga-imprime.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/AsesoraOnline").Include(
                "~/Content/Css/Site/asesora-online.css"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/Esika/Contenedor").Include(
                "~/Content/Css/Site/Contenedor/Index.css",
                "~/Content/Css/Site/Esika/Contenedor.css"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/Esika/Contenedor").Include(
                "~/Content/Css/Mobile/Contenedor/Index.css",
                "~/Content/Css/Mobile/Esika/Contenedor.css"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/Lbel/CssSB2").Include(
               "~/Content/Css/Site/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Site/Lbel/reset.css",
               "~/Content/Css/Site/Lbel/styleDefault.css",
               "~/Content/Css/Site/Lbel/style.css",
               "~/Content/Css/ui.jquery/Lbel/jquery-ui.css",
               "~/Content/Css/Site/RevistaDigital/index.css",
               "~/Content/Css/Site/Lbel/revistaDigital.css",
               "~/Content/Css/Site/Lbel/seccion-descarga-imprime.css"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/Lbel/Contenedor").Include(
                "~/Content/Css/Site/Contenedor/Index.css",
                "~/Content/Css/Site/Lbel/Contenedor.css"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/Lbel/Contenedor").Include(
                "~/Content/Css/Mobile/Contenedor/Index.css",
                "~/Content/Css/Mobile/Lbel/Contenedor.css"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/esika/CssSB2Mobile").Include(
               "~/Content/Css/Mobile/Esika/icomon.css",
               "~/Content/Css/Mobile/Esika/menu.css",
               "~/Content/Css/Mobile/Esika/style.css",
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
               "~/Content/Css/Mobile/calc.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/lbel/CssSB2Mobile").Include(
               "~/Content/Css/Mobile/lbel/icomon.css",
               "~/Content/Css/Mobile/lbel/menu.css",
               "~/Content/Css/Mobile/lbel/style.css",
               "~/Content/Css/Site/Lbel/styleDefault.css",
               "~/Content/Css/Mobile/lbel/theme.css",
               "~/Content/Css/Mobile/flexslider.css",
               "~/Content/Css/Mobile/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Mobile/lbel/misDatos.css",
               "~/Content/Css/Mobile/RevistaDigital/index.css",
               "~/Content/Css/Mobile/Lbel/revistaDigital.css",
               "~/Content/Css/Mobile/Lbel/seccion-descarga-imprime.css",
               "~/Content/Css/Mobile/calc.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/CssBienvenida").Include(
                "~/Content/Css/Mobile/Esika/bootstrap-slider.min.css",
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Site/flexslider.css",
                "~/Content/Css/Site/RevistaDigital/Bienvenido-Pedido-Catalogo.css",
                "~/Content/Css/Site/RevistaDigital/PopupSuscripcion.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2").Include(
                "~/Scripts/modernizr.custom.js",
                "~/Scripts/respond.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/General.js",
                "~/Scripts/JsonSupport.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/PortalConsultoras/Bienvenida/OfertaDelDia.js",
                "~/Scripts/PortalConsultoras/Shared/MainLayout.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Shared/Menu.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/Shared/MenuContenedor.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/LogError.js",
                "~/Scripts/flipclock.js",
                "~/Scripts/slick.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2-Bienvenida").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Index.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/ShowRoom/ShowRoom.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-SuscripcionPopup.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/TagManager/Liquidacion.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/jquery.rateyo.js",
                "~/Scripts/jquery.easy-pie-chart.js"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/CssPedido").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/style-pedido.css",
                "~/Content/Css/Site/RevistaDigital/Bienvenido-Pedido-Catalogo.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2-Pedido").Include(
                "~/Scripts/PortalConsultoras/Pedido/Index.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertafinal.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/js/OfertaDelDia").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/OfertaDelDia.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/Bienvenida").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/PortalConsultoras/Mobile/Bienvenida/Index.js",
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
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
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/jquery.rateyo.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/Css/Site/CcsBienvenida").Include(
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Mobile/RevistaDigital/Bienvenido-Pedido-Catalogo.css",
                "~/Content/Css/Mobile/RevistaDigital/PopupSuscripcion.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/Css/Site/MisCatalogoRevista").Include(
                "~/Content/Css/Site/jquery.tag-editor.css",
                "~/Content/Css/Site/RevistaDigital/Bienvenido-Pedido-Catalogo.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JS-Login").Include(
               "~/Scripts/General.js",
               "~/Scripts/PortalConsultoras/Login/Analytics.js",
               "~/Scripts/PortalConsultoras/Login/FormsSignIn.js"
            ));
            bundles.Add(new ScriptBundle("~/bundles/JS-Login-Header").Include(
               "~/Scripts/PortalConsultoras/Login/Analytics.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JS-Login-VerificaAutenticidad").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/General.js",
                "~/Scripts/PortalConsultoras/Login/VerificaAutenticidad.js"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Login").Include(
               "~/Content/Css/ui.jquery/jquery-ui.css",
               "~/Content/Css/Site/jquery.custom-scrollbar.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/Pedido").Include(
                "~/Scripts/PortalConsultoras/Mobile/Pedido/index.js",
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/PedidoDetalle").Include(
                "~/Scripts/PortalConsultoras/Mobile/Pedido/Detalle.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertaFinal.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
            ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/Login2/Esika").Include(
               "~/Content/Css/Site/Login2/style_esika.css"
            ));
            bundles.Add(new StyleBundle("~/Content/Css/Site/Login2/Lbel").Include(
               "~/Content/Css/Site/Login2/style_lbel.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/PedidoFICDetalle").Include(
                "~/Scripts/PortalConsultoras/Mobile/PedidoFIC/Detalle.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertaFinal.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
            ));
            bundles.Add(new ScriptBundle("~/bundles/JsMobile/PedidoFIC").Include(
                "~/Scripts/PortalConsultoras/Mobile/PedidoFIC/Index.js",
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js"
             ));

            bundles.Add(new ScriptBundle("~/bundles/ActualizarMatrizCampaniaModuleMin").Include(
                "~/Scripts/fileuploader.js",
                "~/Scripts/jquery.form.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/AdminContenido/ToastHelper.js",
                "~/Scripts/AdminContenido/Paginador.js",
                "~/Scripts/AdminContenido/Nemotecnico.js",
                "~/Scripts/AdminContenido/MatrizComercialFileUpload.js",
                "~/Scripts/PortalConsultoras/MatrizCampania/ActualizarMatrizCampaniaModule.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2-Ofertas").Include(
                "~/Scripts/jquery.flexslider.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
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
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Site/ccsOfertas").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/flexslider.css",
                "~/Content/Css/Site/Contenedor/carrusel.individual.css",
                "~/Content/Css/Site/Contenedor/producto.simple.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/JsSB2-Ofertas").Include(
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/Index.js",
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Site/ccsOfertasMobile").Include(
                "~/Content/Css/Site/slick.css",
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Mobile/Contenedor/carrusel.individual.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/Css/Mobile/Site/CssPedido").Include(
                "~/Content/Css/Mobile/RevistaDigital/Bienvenido-Pedido-Catalogo.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/Css/Mobile/Site/MisCatalogoRevista").Include(
                "~/Content/Css/Mobile/jquery.tag-editor.css",
                "~/Content/Css/Mobile/RevistaDigital/Bienvenido-Pedido-Catalogo.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/Css/Mobile/Site/OfertaParaTi-Detalle").Include(
                "~/Content/Css/Mobile/RevistaDigital/OfertaParaTi-Detalle.css"
            ));

            #region RevistaDigital
            bundles.Add(new ScriptBundle("~/bundles/RevistaDigital-Info").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/General.js",
                "~/Scripts/jquery.flexslider.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-ConfirmarDatos.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Site/RevistaDigital-Info").Include(
                "~/Content/Css/Site/RevistaDigital/PaginaInformativa.css",
                "~/Content/Css/Site/RevistaDigital/ConfirmarDatos.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/RevistaDigital-Landing").Include(
                "~/Scripts/jquery.flexslider.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Site/RevistaDigital-Landing").Include(
                "~/Content/Css/Site/ProductoListado/Landing.css",
                "~/Content/Css/Site/Landing/producto.landing.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/Lanzamientos-Detalle").Include(
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/implements/youtube.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/Lanzamientos/detalle-lanzamiento.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Site/Lanzamientos-Detalle").Include(
                "~/Content/Css/Site/Lanzamientos/Detalle.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Mobile/Lanzamientos-Detalle").Include(
                "~/Content/Css/Mobile/Lanzamientos/Detalle.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/Mobile/RevistaDigital-Info").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-ConfirmarDatos.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Mobile/Site/RevistaDigital-Info").Include(
                "~/Content/Css/Mobile/RevistaDigital/PaginaInformativa.css",
                "~/Content/Css/Mobile/RevistaDigital/ConfirmarDatos.css",
                "~/Content/Css/Mobile/RevistaDigital/PopupSuscripcion.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/Mobile/RevistaDigital-Landing").Include(
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/Mobile/GuiaNegocio-Landing").Include(
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/Mobile/GuiaNegocio/GuiaNegocio-Landing.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Mobile/Site/RevistaDigital-Landing").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/flexslider.css",
                "~/Content/Css/Mobile/RevistaDigital/RedimensionLandingRD.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/CDRWeb").Include(
                "~/Scripts/PortalConsultoras/Mobile/MisReclamos/Index.js"
            ));

            #endregion

            bundles.Add(new ScriptBundle("~/bundles/Mobile/OfertaParaTi-Detalle").Include(
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js"
            ));

            #region DetalleEstrategia
            bundles.Add(new ScriptBundle("~/bundles/js/EstrategiaAgregar").Include(
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js"
            ));
            
            bundles.Add(new ScriptBundle("~/bundles/js/Ficha").Include(
                "~/Scripts/implements/youtube.js",
                "~/Scripts/General.js",
                "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                "~/Scripts/PortalConsultoras/Shared/ConstantesModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/FichaModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/DetalleEstrategia/CarruselModule.js"
            ));
            bundles.Add(new ScriptBundle("~/bundles/mobile/js/Ficha").Include(
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/desktop/css/ficha").Include(
                "~/Content/Css/Site/Ficha/Ficha.css",
                "~/Content/Css/Site/Ficha/Carrusel.css",
                "~/Content/Css/Site/Ficha/RedesSociales.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/mobile/css/ficha").Include(
                "~/Content/Css/Mobile/Ficha/ficha.css",
                "~/Content/Css/Mobile/Ficha/Carrusel.css",
                "~/Content/Css/Mobile/Ficha/RedesSociales.css"
            ));

            #endregion

            #region MisCatalogosRevistas
            bundles.Add(new ScriptBundle("~/bundles/MisCatalogosRevistas").Include(
                 "~/Scripts/PortalConsultoras/Shared/General/RedesSociales.js",
                 "~/Scripts/Tag/jquery.tags.input.js",
                 "~/Scripts/PortalConsultoras/MisCatalogosRevistas/Index.js",
                 "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js"
                 //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                 //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                 //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
            ));
            #endregion

            #region GuiaNegocio

            bundles.Add(new ScriptBundle("~/bundles/GuiaNegocio-Landing").Include(
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/GuiaNegocio/GuiaNegocio-Landing.js"
            ));


            bundles.Add(new StyleBundle("~/bundles/css/Site/GuiaNegocio-Landing").Include(
                "~/Content/Css/Site/ProductoListado/Landing.css",
                "~/Content/Css/Site/RevistaDigital/Gnd-Flotante.css",
                "~/Content/Css/Site/Landing/producto.landing.css"
            ));

            bundles.Add(new StyleBundle("~/bundles/css/Mobile/Site/GuiaNegocio-Landing").Include(
                "~/Content/Css/Mobile/RevistaDigital/Gnd-Flotante.css",
                "~/Content/Css/Mobile/RevistaDigital/RedimensionLandingRD.css"
            ));

            #endregion

            #region HerramientasVenta

            bundles.Add(new ScriptBundle("~/bundles/HerramientasVenta-Landing").Include(
                //"~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                //"~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Landing.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js",
                "~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaUrls.js"
            ));
            
            bundles.Add(new ScriptBundle("~/bundles/Mobile/js/HerramientasVenta-Landing").Include(
                "~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js",
                "~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js"
            ));
            
            bundles.Add(new StyleBundle("~/bundles/css/Site/HerramientasVenta-Landing").Include(
                "~/Content/Css/Site/ProductoListado/Landing.css",
                "~/Content/Css/Site/Landing/producto.landing.css"
            ));

            #endregion

            #region Estrategias-UpSelling
            bundles.Add(new StyleBundle("~/bundles/estrategias-upselling-css")
                .Include("~/Content/Css/Site/Admin/Estrategias/UpSelling.css"));

            bundles.Add(new ScriptBundle("~/bundles/estrategias-upselling").Include(
                "~/Scripts/knockout-{version}.js",
                "~/Scripts/knockout.extensions.js"
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