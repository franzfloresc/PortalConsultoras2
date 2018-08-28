using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web.UnitTest.Extensions
{
    public static class RedirectToRouteResultExtensions
    {
        public static string GetControllerName(this RedirectToRouteResult redirectToRouteResult)
        {
            return GetRouteValueBy(redirectToRouteResult.RouteValues,"controller");
        }

        public static string GetActionName(this RedirectToRouteResult redirectToRouteResult)
        {
            return GetRouteValueBy(redirectToRouteResult.RouteValues, "action");
        }

        public static string GetAreaName(this RedirectToRouteResult redirectToRouteResult)
        {
            return GetRouteValueBy(redirectToRouteResult.RouteValues, "area");
        }

        private static string GetRouteValueBy(RouteValueDictionary routeValues,  string key)
        {
            var value = routeValues[key];
            return value == null ? string.Empty : value.ToString();
        }
    }
}
