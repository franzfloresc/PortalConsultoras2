using System;
using System.Web.Routing;

namespace Portal.Consultoras.Web.Helpers
{
    public static class RouteExtensions
    {
        public static string GetUniqueRoute(this RouteData routeData, string identifier)
        {
            return routeData != null && routeData.Values[identifier] != null ? routeData.Values[identifier].ToString() : null;
        }

        /// <summary>
        /// Set to route a guid
        /// </summary>
        /// <param name="routeData">This</param>
        /// <param name="routeIdentifier">Route Param</param>
        /// <param name="guid">Guid</param>
        /// <returns>Guid String</returns>
        public static string SetUniqueKeyAvoiding(this RouteData routeData, string routeIdentifier, Guid guid)
        {
            if (!routeData.Values.ContainsKey(routeIdentifier))
                routeData.Values.Add(routeIdentifier, guid.ToString());

            return routeData.Values[routeIdentifier].ToString();
        }

    }
}
