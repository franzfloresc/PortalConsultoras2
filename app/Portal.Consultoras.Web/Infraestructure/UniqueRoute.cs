using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web.Infraestructure
{
    /// <summary>
    /// Provee rutas unicas basadas en System.Guid
    /// </summary>
    public class UniqueRoute : Route
    {
        public const string IdentifierKey = "guid";

        private readonly bool _isGuidRoute;

        public UniqueRoute(string uri, object defaults, RouteValueDictionary dataTokens)
            : base(uri, new RouteValueDictionary(defaults), new MvcRouteHandler())
        {
            _isGuidRoute = uri.Contains(IdentifierKey);
            DataTokens = dataTokens;
        }

        public override RouteData GetRouteData(HttpContextBase httpContext)
        {
            var routeData = base.GetRouteData(httpContext);
            if (routeData == null)
                return null;
            if (!routeData.Values.ContainsKey(IdentifierKey) || routeData.Values[IdentifierKey].ToString() == "")
                routeData.Values[IdentifierKey] = Guid.NewGuid().ToString();
            return routeData;
        }

        public override VirtualPathData GetVirtualPath(RequestContext requestContext, RouteValueDictionary values)
        {
            var virtualPathData = base.GetVirtualPath(requestContext, values);

            virtualPathData.VirtualPath = virtualPathData.VirtualPath.Replace("%23", "#");

            return !_isGuidRoute ? null : virtualPathData;
        }
    }
}
