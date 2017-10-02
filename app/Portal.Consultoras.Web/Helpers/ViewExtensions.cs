using System.Web.Mvc;
using Portal.Consultoras.Web.Infraestructure;

namespace Portal.Consultoras.Web.Helpers
{
    public static class ViewExtensions
    {
        /// <summary>
        /// Calcula el nombre del Layout en base a la Session Unica IngresoExterno
        /// </summary>
        /// <param name="viewContext">Current context</param>
        /// <returns>_MobileLayout or _MobileLayoutEmpty</returns>
        public static string MobileLayout(this ViewContext viewContext)
        {
            var ingresoExterno = viewContext.GetUniqueSession("IngresoExterno");
            return ingresoExterno == null ? "_MobileLayout" : "_MobileLayoutEmpty";
        }

        public static string GetUniqueKey(this ViewContext viewContext)
        {
            if (viewContext.RequestContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey) ||
                viewContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey) ||
                viewContext.HttpContext.Request.QueryString[UniqueRoute.IdentifierKey] != null)

            {
                return viewContext.RequestContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey)
                  ? viewContext.RequestContext.RouteData.Values[UniqueRoute.IdentifierKey].ToString()
                  : viewContext.RouteData.Values.ContainsKey(UniqueRoute.IdentifierKey) ? viewContext.RouteData.Values[UniqueRoute.IdentifierKey].ToString()
                  : viewContext.HttpContext.Request.QueryString[UniqueRoute.IdentifierKey];
            }

            return null;
        }

        public static object GetUniqueSession(this ViewContext viewContext, string name)
        {
            return viewContext.HttpContext.Session[viewContext.GetUniqueKey() + "_" + name];
        }
    }
}
