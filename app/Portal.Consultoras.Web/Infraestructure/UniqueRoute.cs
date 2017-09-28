using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
        private readonly bool _isGuidRoute;
        public UniqueRoute(string uri, object defaults, RouteValueDictionary dataTokens)
            : base(uri, new RouteValueDictionary(defaults), new MvcRouteHandler())
        {
            _isGuidRoute = uri.Contains("guid");
            DataTokens = dataTokens;
        }
        public override RouteData GetRouteData(HttpContextBase httpContext)
        {
            var routeData = base.GetRouteData(httpContext);
            if (routeData == null)
                return null;
            if (!routeData.Values.ContainsKey("guid") || routeData.Values["guid"].ToString() == "")
                routeData.Values["guid"] = Guid.NewGuid().ToString("N");
            return routeData;
        }
        public override VirtualPathData GetVirtualPath(RequestContext requestContext, RouteValueDictionary values)
        {
            //invert?
            return !_isGuidRoute ? null : base.GetVirtualPath(requestContext, values);
        }
    }
}
