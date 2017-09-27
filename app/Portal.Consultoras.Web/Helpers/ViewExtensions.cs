using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Helpers
{
    public static class ViewExtensions
    {
        /// <summary>
        /// Calcula el nombre del Layout en base a la key IngresoExterno
        /// </summary>
        /// <param name="viewContext">Current context</param>
        /// <returns>_MobileLayout or _MobileLayoutEmpty</returns>
        public static string Layout(this ViewContext viewContext)
        {
            var ingresoExterno = viewContext.GetUniqueSession("IngresoExterno");
            return ingresoExterno == null ? "_MobileLayout" : "_MobileLayoutEmpty";
        }

        public static string GetUniqueKey(this ViewContext viewContext)
        {
            if (viewContext.RequestContext.RouteData.Values.ContainsKey("guid") ||
                viewContext.RouteData.Values.ContainsKey("guid") ||
                viewContext.HttpContext.Request.QueryString["guid"] != null)

            {
                return viewContext.RequestContext.RouteData.Values.ContainsKey("guid")
                  ? viewContext.RequestContext.RouteData.Values["guid"].ToString()
                  : viewContext.RouteData.Values.ContainsKey("guid") ? viewContext.RouteData.Values["guid"].ToString()
                  : viewContext.HttpContext.Request.QueryString["guid"];
            }

            return null;
        }

        public static void SetUniqueSession(this ViewContext viewContext, string name, object value)
        {
            viewContext.HttpContext.Session[viewContext.GetUniqueKey() + "_" + name] = value;
        }

        public static object GetUniqueSession(this ViewContext viewContext, string name)
        {
            return viewContext.HttpContext.Session[viewContext.GetUniqueKey() + "_" + name];
        }
    }
}
