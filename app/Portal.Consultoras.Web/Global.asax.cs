using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Models.AutoMapper;
using System;
using System.Configuration;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Portal.Consultoras.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            Globals.RutaTemporales = HttpContext.Current.Server.MapPath("~/Content/Temporales");
            Globals.RutaImagenesTemp = HttpContext.Current.Server.MapPath("~/Content/Images/temp");
            Globals.RutaImagenesTempOfertas = HttpContext.Current.Server.MapPath("~/Content/TemporalesOfertas");
            Globals.RutaImagenesFondoLogin = HttpContext.Current.Server.MapPath("~/Content/Images/login");
            Globals.RutaImagenesFondoPortal = HttpContext.Current.Server.MapPath("~/Content/Images/fondo");
            Globals.RutaImagenesLogoPortal = HttpContext.Current.Server.MapPath("~/Content/Images/logo");
            Globals.RutaImagenesOfertasWeb = HttpContext.Current.Server.MapPath("~/Content/Ofertas");
            Globals.RutaImagenesOfertasLiquidacion = HttpContext.Current.Server.MapPath("~/Content/OfertasLiquidacion");
            Globals.RutaImagenesMatriz = "/Content/Matriz";
            Globals.RutaImagenesTempMatriz = HttpContext.Current.Server.MapPath("~/Content/TemporalesMatriz");
            Globals.RutaImagenesBanners = HttpContext.Current.Server.MapPath("~/Content/Banners");
            Globals.RutaImagenesTempBanners = HttpContext.Current.Server.MapPath("~/Content/TemporalesBanners");
            Globals.RutaImagenesTempLugaresPago = HttpContext.Current.Server.MapPath("~/Content/TemporalesLugaresPago");
            Globals.RutaImagenesLugaresPago = "/Content/LugaresPago";
            Globals.RutaImagenesTempIncentivos = HttpContext.Current.Server.MapPath("~/Content/TemporalesIncentivos");
            Globals.RutaImagenesIncentivos = "/Content/Incentivos";
            Globals.RutaImagenesOfertasNuevas = "/Content/OfertasNuevas";

            Globals.UrlBanner = ConfigurationManager.AppSettings["Banners"];
            Globals.UrlFileConsultoras = ConfigurationManager.AppSettings["FileConsultoras"];
            Globals.UrlIncentivos = ConfigurationManager.AppSettings["Incentivos"];
            Globals.UrlLugaresPago = ConfigurationManager.AppSettings["LugaresPago"];
            Globals.UrlMatriz = ConfigurationManager.AppSettings["Matriz"];
            Globals.UrlOfertasNuevas = ConfigurationManager.AppSettings["OfertasNuevas"];
            Globals.UrlRevistaGana = ConfigurationManager.AppSettings["RevistaGana"];
            Globals.UrlEscalaDescuentos = ConfigurationManager.AppSettings["EscalaDescuentos"];
            Globals.UrlOfertasFic = ConfigurationManager.AppSettings["OfertasFic"];
            Globals.UrlNavidadConsultora = ConfigurationManager.AppSettings["NavidadConsultora"];

            AutoMapperConfiguration.Configure();
        }


        protected void Application_EndRequest()
        {
            //var context = new HttpContextWrapper(Context);

            //if (Context.Response.StatusCode == 302 && context.Request.IsAjaxRequest())
            //{
            //    Context.Response.Clear();
            //    Context.Response.StatusCode = 401;
            //}
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        private void Application_BeginRequest(object sender, EventArgs e)
        {
            if (String.Compare(Request.Path, Request.ApplicationPath, StringComparison.InvariantCultureIgnoreCase) == 0
                && !(Request.Path.EndsWith("/")))
                Response.Redirect(Request.Path + "/");
        }

    }
}
