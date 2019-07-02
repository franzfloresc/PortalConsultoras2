using Portal.Consultoras.Common.Exceptions;
using System.Web.Routing;
namespace Portal.Consultoras.Web
{
    public static class RouteExtensions
    {


        public static SBRoute Redirect(this RouteCollection routes, string url)
        {
            if (routes == null)
            {
                throw new ClientInformationException("routes");
            }
            if (url == null)
            {
                throw new ClientInformationException("url");
            }
            var route = new SBRoute(url);
            routes.Add(route);
            return route;

        }

        public static SBRoute ToUrl(this SBRoute route, string target, bool isPermanent = false)
        {
            if (target == null)
            {
                throw new ClientInformationException("target");
            }

            var source = new RedirectRoute(route.Pattern, target, isPermanent);
            route.Route = source;
            return route;
        }
    }
}

