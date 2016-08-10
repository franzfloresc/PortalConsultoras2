using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Optimization;


namespace Portal.Consultoras.Web
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            //ITG - 1869 Empaquetado y minificacion de archivos css y js - Inicio
            bundles.Add(new StyleBundle("~/Content/Css/Site/CssLogin").Include(
                "~/Content/Css/ui.jquery/jquery-ui.css",
                "~/Content/Css/Site/style.css"));

            bundles.Add(new ScriptBundle("~/bundles/JsLogin").Include(
                "~/Scripts/General.js",
                "~/Scripts/JsonSupport.js"));

            bundles.Add(new StyleBundle("~/Content/Css/Site/CssMain").Include(
                "~/Content/Css/ui.jquery/jquery-ui.css",
                "~/Content/Css/Site/style.css",
                "~/Content/Css/Site/style-tismart.css", //Cambios_Landing_Comunidad
                "~/Content/Css/ui.jqgrid/ui.jqgrid.css"
                ));
            //ITG - 1869 Empaquetado y minificacion de archivos css y js - Fin

            bundles.Add(new ScriptBundle("~/bundles/JQueryJs").Include(
               "~/Scripts/jquery-*", 
               "~/Scripts/jquery-migrate-*", 
               "~/Scripts/jquery.validate*", 
               "~/Scripts/jquery.validate.unobtrusive*",
               "~/Scripts/jquery.unobtrusive-ajax*",
               "~/Scripts/jquery-ui-1.9.2.custom*"));

            bundles.Add(new ScriptBundle("~/bundles/JQGridJs").Include(
               "~/Scripts/Jqgrid/grid.locale-sp*",
               "~/Scripts/Jqgrid/jquery.jqGrid*"));

            bundles.Add(new ScriptBundle("~/bundles/JsPluginsHeader").Include(
               "~/Scripts/jquery.preloadify.min.js",
               "~/Scripts/modernizr.custom.js",
               "~/Scripts/jquery.cycle.all.min.js",
               "~/Scripts/respond.min.js",
               "~/Scripts/General.js",
               "~/Scripts/JsonSupport.js",
               "~/Scripts/jquery.index.js" //Cambios_Landing_Comunidad
               ));

            bundles.Add(new ScriptBundle("~/bundles/JsPluginsFooter").Include(
                                       "~/Scripts/jqueryslidemenu.js",
                                       "~/Scripts/jquery.easing.1.3.js",
                                       "~/Scripts/trans-banner.js",
                                       "~/Scripts/jquery.touchSwipe.min.js",
                                       "~/Scripts/custom.js",
                                       "~/Scripts/cycle-plugin.js",
                                       "~/Scripts/jquery.tinyscrollbar.min.js"));


            bundles.Add(new ScriptBundle("~/bundles/JsPluginsHeaderSAC").Include(
                           "~/Scripts/maskedinput.js",
                           "~/Scripts/General.js",
                           "~/Scripts/JsonSupport.js",
                           "~/Scripts/modernizr.custom.js",
                           "~/Scripts/jquery.index.js", //Cambios_Landing_Comunidad
                           "~/Scripts/jqueryslidemenu.js",
                           "~/Scripts/jquery.easing.1.3.js",
                           "~/Scripts/jquery.touchSwipe.min.js",
                           "~/Scripts/jquery.cycle.all.min.js",
                           "~/Scripts/respond.min.js",
                           "~/Scripts/trans-banner.js"));

            bundles.Add(new ScriptBundle("~/bundles/JsPluginsFooterSAC").Include(
               "~/Scripts/custom.js",
               "~/Scripts/jquery.flexnav.js"));

            bundles.Add(new ScriptBundle("~/bundles/JSTree").Include(
               "~/Scripts/jquery.jstree.js"));

            bundles.Add(new ScriptBundle("~/bundles/Templates").Include(
              "~/Scripts/jquery.tmpl.min.js"));

            #region Bundles para Web Mobile

            bundles.Add(new ScriptBundle("~/Scripts/Mobile").Include(
                "~/Scripts/jquery-*",
                "~/Scripts/jquery-ui-*",
                "~/Scripts/jquery.validate*",
                "~/Scripts/jquery.validate.unobtrusive*",
                "~/Scripts/bootstrap.*",
                "~/Scripts/menu.js",
                "~/Scripts/accordion.js",
                "~/Scripts/General.js"));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/Site").Include(
                "~/Content/Css/Mobile/theme*",
                "~/Content/Css/Mobile/icomon.css",
                "~/Content/Css/Mobile/menu.css",
                "~/Content/Css/Mobile/style.css"));

            #endregion

            bundles.Add(new StyleBundle("~/bundles/HVRhover").Include(
                "~/Content/Css/Site/hover.css"));

            bundles.Add(new StyleBundle("~/bundles/CSSFuzemodal").Include(
              "~/Scripts/fuzemodal-1.3/fuzemodal-1.3.css"));

            bundles.Add(new ScriptBundle("~/bundles/JSFuzemodal").Include(
               "~/Scripts/fuzemodal-1.3/fuzemodal-1.3.2.min.js"));

            // Bundles para hoja de inscripción (Cambios Unete)
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
            // Bundles para hoja de inscripción (Cambios Unete)

            #region SB2

            bundles.Add(new StyleBundle("~/Content/Css/Site/Esika/CssSB2").Include(
               "~/Content/Css/Site/Esika/reset.css",
               "~/Content/Css/Site/Esika/style.css",
               "~/Content/Css/ui.jquery/Esika/jquery-ui.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Site/Lbel/CssSB2").Include(
               "~/Content/Css/Site/Lbel/reset.css",
               "~/Content/Css/Site/Lbel/style.css",
               "~/Content/Css/ui.jquery/Lbel/jquery-ui.css"
               ));

            #region SB2 MOBILE

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/esika/CssSB2Mobile").Include(
               "~/Content/Css/Mobile/esika/icomon.css",
               "~/Content/Css/Mobile/esika/menu.css",
               
               "~/Content/Css/Mobile/esika/style.css",
               "~/Content/Css/Mobile/esika/theme.css",
               "~/Content/Css/Mobile/esika/theme.min.css"
               ));

            bundles.Add(new StyleBundle("~/Content/Css/Mobile/lbel/CssSB2Mobile").Include(
               "~/Content/Css/Mobile/lbel/icomon.css",
               "~/Content/Css/Mobile/lbel/menu.css",
               
               "~/Content/Css/Mobile/lbel/style.css",
               "~/Content/Css/Mobile/lbel/theme.css",
               "~/Content/Css/Mobile/lbel/theme.min.css"
               ));

            #endregion

            bundles.Add(new ScriptBundle("~/bundles/JsSB2").Include(
                "~/Scripts/modernizr.custom.js",
                "~/Scripts/respond.min.js",
                "~/Scripts/General.js",
                "~/Scripts/JsonSupport.js",
                "~/Scripts/PortalConsultoras/Shared/MainLayout.js",
                "~/Scripts/PortalConsultoras/Shared/Menu.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2-Bienvenida").Include(
                "~/Scripts/PortalConsultoras/Bienvenida/Index.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/JsSB2-Pedido").Include(
                "~/Scripts/PortalConsultoras/Pedido/Index.js"
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