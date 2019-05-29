using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
namespace Portal.Consultoras.Web
{
    public static class RouteExtensions
    {


        public static SBRoute Redirect(this RouteCollection routes, string url)
        {
            if (routes == null)
            {
                throw new ArgumentNullException("routes");
            }
            if (url == null)
            {
                throw new ArgumentNullException("url");
            }
            var route = new SBRoute(url);
            routes.Add(route);
            return route;

        }

        public static SBRoute ToUrl(this SBRoute route, string target, bool isPermanent = false)
        {
            if (target == null)
            {
                throw new ArgumentNullException("target");
            }

            var source = new RedirectRoute(route.Pattern, target, isPermanent);
            route.Route = source;
            return route;
        }
    }
}

