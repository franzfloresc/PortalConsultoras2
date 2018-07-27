using System;
using System.Linq.Expressions;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;
using System.Web.Mvc.Html;

namespace Portal.Consultoras.Web.Helpers
{
    public static class ViewExtensions
    {
        /// <summary>
        /// Obtiene la configuracion mobile basada en session unica
        /// </summary>
        /// <param name="htmlHelper"></param>
        /// <returns></returns>
        public static MobileAppConfiguracionModel MobileAppConfiguracion(this HtmlHelper htmlHelper)
        {
            return GetUniqueSession<MobileAppConfiguracionModel>(htmlHelper.ViewContext, "MobileAppConfiguracion");
        }

        /// <summary>
        /// Calcula si es un pais Esika basado en ViewBag.PaisAnalytics
        /// </summary>
        /// <param name="viewContext"></param>
        /// <returns></returns>
        public static bool EsPaisEsika(this ViewContext viewContext)
        {
            return Settings.Instance.PaisesEsika.Contains(viewContext.ViewBag.PaisAnalytics);
        }

        /// <summary>
        /// Calcula el nombre del Layout en base a la Session Unica IngresoExterno
        /// </summary>
        /// <param name="viewContext">Current context</param>
        /// <returns>_MobileLayout or _MobileLayoutEmpty</returns>
        public static string MobileLayout(this ViewContext viewContext)
        {
            return viewContext.EsIngresoUnico() ? "_MobileLayoutEmpty" : "_MobileLayout";
        }

        public static string MobilePedidoLayout(this ViewContext viewContext)
        {
            return viewContext.EsIngresoUnico() ? "_MobileLayoutPedidoEmpty" : "_MobileLayout";
        }

        /// <summary>
        /// Determina si es un ingreso unico
        /// </summary>
        /// <param name="viewContext">Current context</param>
        /// <returns>true or false</returns>
        public static bool EsIngresoUnico(this ViewContext viewContext)
        {
            var ingresoExterno = viewContext.GetUniqueSession("IngresoExterno");
            return ingresoExterno != null;
        }

        public static string GetUniqueKey(this ViewContext viewContext)
        {
            if (viewContext.RequestContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey) ||
                viewContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey) ||
                viewContext.HttpContext.Request.QueryString[UniqueRoute.IdentifierKey] != null)
            {
                return viewContext.RequestContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey)
                  ? viewContext.RequestContext.RouteData.GetUniqueRoute(UniqueRoute.IdentifierKey)
                  : viewContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey) ? viewContext.RouteData.GetUniqueRoute(UniqueRoute.IdentifierKey)
                  : viewContext.HttpContext.Request.QueryString[UniqueRoute.IdentifierKey];
            }

            return null;
        }

        public static object GetUniqueSession(this ViewContext viewContext, string name)
        {
            return viewContext.HttpContext.Session.GetUniqueSession(viewContext.GetUniqueKey(), name);
        }

        /// <summary>
        /// Obtiene y castea si no es null
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="viewContext"></param>
        /// <param name="name"></param>
        /// <param name="newInstance">Nueva instancia o null por defecto</param>
        /// <returns></returns>
        public static T GetUniqueSession<T>(this ViewContext viewContext, string name, bool newInstance = true) where T : class, new()
        {
            var getUniqueSession = GetUniqueSession(viewContext, name);
            return getUniqueSession == null ? newInstance ? new T() : default(T) : (T)getUniqueSession;
        }

        public static MvcHtmlString PagoValidationMessageFor<TModel, TProperty>(this HtmlHelper<TModel> helper, Expression<Func<TModel, TProperty>> expression)
        {
            var containerDivBuilder = new TagBuilder("div");
            containerDivBuilder.AddCssClass("mensaje_validacion text-center w-100");

            var topDivBuilder = new TagBuilder("span");
            topDivBuilder.AddCssClass("icono_validacion_incorrecta");
            
            var validationContent = helper.ValidationMessageFor(expression).ToString();

            containerDivBuilder.InnerHtml += topDivBuilder.ToString(TagRenderMode.Normal);
            containerDivBuilder.InnerHtml += validationContent;

            return MvcHtmlString.Create(containerDivBuilder.ToString(TagRenderMode.Normal));
        }
    }
}
