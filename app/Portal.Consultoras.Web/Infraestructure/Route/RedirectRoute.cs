using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace Portal.Consultoras.Web
{
    public class RedirectRoute : Route
    {


        public RedirectRoute(string url,
                             string urlDestino,
                             bool isPermanent)
        : base(url, new RedirectHttpHandler(urlDestino, isPermanent))
        {

        }
        public override VirtualPathData GetVirtualPath(RequestContext requestContext, RouteValueDictionary values)
        {
            return null;
        }
    }
    public class RedirectHttpHandler : IHttpHandler, IRouteHandler
    {
        public RedirectHttpHandler(string targetUrl, bool isPermanent)
        {


            UrlDestino = targetUrl;
            IsPermanent = isPermanent;
            IsReusable = false;

        }

        public string UrlDestino { get; set; }

        public bool IsPermanent { get; private set; }

        public bool IsReusable { get; private set; }

        public IHttpHandler GetHttpHandler(RequestContext requestContext)
        {
            string virtualPath = null;
            if (UrlDestino.StartsWith("~/"))
                virtualPath = UrlDestino.Substring(2);
            else
                virtualPath = UrlDestino;

            Route route = new Route(virtualPath, null);
            var vpd = route.GetVirtualPath(requestContext, requestContext.RouteData.Values);
            if (vpd != null)
            {
                UrlDestino = "~/" + vpd.VirtualPath;
            }

            return this;

        }
        public void ProcessRequest(HttpContext context)
        {

            Redirect(context.Response, UrlDestino, IsPermanent);
        }
        private static void Redirect(HttpResponse response, string url, bool isPermanent)
        {

            if (isPermanent)
                response.RedirectPermanent(url, true);
            else
               response.Redirect(url, false);
            
        }
    }
    public class SBRoute : RouteBase
    {
        public string Pattern { get; set; }
        public SBRoute(string pattern)
        {
            Pattern = pattern;
        }

        public RouteBase Route { get; set; }

        public override RouteData GetRouteData(HttpContextBase httpContext)
        {
            return Route.GetRouteData(httpContext);
        }

        public override VirtualPathData GetVirtualPath(RequestContext requestContext, RouteValueDictionary values)
        {
            return Route.GetVirtualPath(requestContext, values);
        }
    }
}