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
                "~/Scripts/PortalConsultoras/Shared/LoginLayout.js"));

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
               "~/Scripts/fingerprint2.js"
               ));

            bundles.Add(new ScriptBundle("~/bundles/JQGridJs").Include(
               "~/Scripts/Jqgrid/grid.locale-sp*",
               "~/Scripts/Jqgrid/jquery.jqGrid*"));

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
                            "~/Scripts/jquery.tmpl.js"));

            bundles.Add(new ScriptBundle("~/bundles/JsPluginsFooterSAC").Include(
               "~/Scripts/custom.js",
               "~/Scripts/jquery.flexnav.js"));

            bundles.Add(new ScriptBundle("~/bundles/JSTree").Include(
               "~/Scripts/jquery.jstree.js"));

            bundles.Add(new ScriptBundle("~/Scripts/Mobile").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/jquery-ui-1.9.2.custom.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/bootstrap.js",
                "~/Scripts/menu.js",
                "~/Scripts/accordion.js",
                "~/Scripts/fingerprint2.js",
                "~/Scripts/General.js"
            ));

            bundles.Add(new ScriptBundle("~/Scripts/MobileLayout").Include(
                "~/Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/flipclock.js",
                "~/Scripts/jquery.flexslider.js",
                "~/Scripts/slick.js"
            ));

            bundles.Add(new StyleBundle("~/bundles/CSSFuzemodal").Include(
              "~/Scripts/fuzemodal-1.3/fuzemodal-1.3.css"));

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
               "~/Content/Css/ui.jquery/Esika/jquery-ui.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/Lbel/CssSB2").Include(
               "~/Content/Css/Site/flipclock.css",
               "~/Content/Css/Site/slick.css",
               "~/Content/Css/Site/Lbel/reset.css",
               "~/Content/Css/Site/Lbel/style.css",
               "~/Content/Css/ui.jquery/Lbel/jquery-ui.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/esika/CssSB2Mobile").Include(
               "~/Content/Css/Mobile/esika/icomon.css",
               "~/Content/Css/Mobile/esika/menu.css",
               "~/Content/Css/Mobile/esika/style.css",
               "~/Content/Css/Mobile/esika/theme.css",
               "~/Content/Css/Mobile/flexslider.css",
               "~/Content/Css/Mobile/flipclock.css",
               "~/Content/Css/Site/slick.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/lbel/CssSB2Mobile").Include(
               "~/Content/Css/Mobile/lbel/icomon.css",
               "~/Content/Css/Mobile/lbel/menu.css",
               "~/Content/Css/Mobile/lbel/style.css",
               "~/Content/Css/Mobile/lbel/theme.css",
               "~/Content/Css/Mobile/flexslider.css",
               "~/Content/Css/Mobile/flipclock.css",
               "~/Content/Css/Site/slick.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/CssBienvenida").Include(
                "~/Content/Css/Mobile/esika/bootstrap-slider.min.css",
                "~/Content/Css/Site/jquery.rateyo.css",
                "~/Content/Css/Site/flexslider.css"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2").Include(
                "~/Scripts/modernizr.custom.js",
                "~/Scripts/respond.js",
                "~/Scripts/General.js",
                "~/Scripts/JsonSupport.js",
                "~/Scripts/handlebars.js",
                "~/Scripts/PortalConsultoras/Bienvenida/OfertaDelDia.js",
                "~/Scripts/PortalConsultoras/Shared/MainLayout.js",
                "~/Scripts/PortalConsultoras/Shared/Menu.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/flipclock.js",
                "~/Scripts/slick.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2-Bienvenida").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/Index.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js",
                "~/Scripts/PortalConsultoras/CatalogoPersonalizado/CatalogoPersonalizado.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/ShowRoom/ShowRoom.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/jquery.flexslider.js", 
                "~/Scripts/jquery.rateyo.js",
                "~/Scripts/jquery.easy-pie-chart.js",
                "~/Scripts/PortalConsultoras/Mobile/CatalogoPersonalizado/bootstrap-slider.min.js"
                ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/CssPedido").Include(
                "~/Content/Css/Site/slick-pedido.css",
                "~/Content/Css/Site/style-pedido.css"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2-Pedido").Include(
                "~/Scripts/PortalConsultoras/Pedido/Index.js",
                "~/Scripts/PortalConsultoras/Pedido/barra.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertafinal.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/Bienvenida").Include(
                "~/Scripts/jquery.rateyo.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/PortalConsultoras/Mobile/Bienvenida/Index.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js",
                "~/Scripts/PortalConsultoras/EstrategiaProducto/DetalleProducto.js",
                "~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-Suscripcion.js",
                "~/Scripts/PortalConsultoras/Shared/TrackingJetlore.js",
                "~/Scripts/jquery.rateyo.js" //FRZ-26
                ));

            bundles.Add(new StyleBundle("~/bundles/Css/Site/CcsBienvenida").Include(
                "~/Content/Css/Site/jquery.rateyo.css"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JS-Login").Include(
               "~/Scripts/General.js",
               "~/Scripts/PortalConsultoras/Login/FormsSignIn.js"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Login").Include(
               "~/Content/Css/ui.jquery/jquery-ui.css",
               "~/Content/Css/Site/jquery.custom-scrollbar.css"
               ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/Pedido").Include(
                "~/Scripts/PortalConsultoras/Mobile/Pedido/index.js",
                "~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsMobile/PedidoDetalle").Include(
                "~/Scripts/PortalConsultoras/Mobile/Pedido/Detalle.js",
                "~/Scripts/PortalConsultoras/Pedido/ofertaFinal.js",
                "~/Scripts/PortalConsultoras/Cupon/CuponModule.js",
                "~/Scripts/PortalConsultoras/Cupon/Cupon.js"
                ));

#if !DEBUG
            BundleTable.EnableOptimizations = false;
#else
            BundleTable.EnableOptimizations = true;
#endif
        }
    }
}