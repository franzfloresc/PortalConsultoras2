using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Org.BouncyCastle.Asn1.Ocsp;
using Portal.Consultoras.Web.Infraestructure;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class UniqueSessionAttribute : ActionFilterAttribute
    {
        private readonly string _routeName;
        private readonly string _identifierKey;
        private readonly string _routePrefix;

        public UniqueSessionAttribute(string routeName, string identifierKey, string routePrefix)
        {
            _routeName = routeName;
            _identifierKey = identifierKey;
            _routePrefix = routePrefix;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (!filterContext.HttpContext.Request.IsAjaxRequest())
            {
                if (filterContext.RequestContext.HttpContext.Request.UrlReferrer != null)
                {
                    var guid = HttpUtility.ParseQueryString(filterContext.RequestContext.HttpContext.Request.UrlReferrer.Query).Get(_identifierKey);
                    var originalString = filterContext.RequestContext.HttpContext.Request.UrlReferrer.OriginalString;
                    if (originalString.IndexOf(_routePrefix) > 0)
                    {
                        var urlGuid = originalString.Substring(originalString.IndexOf(_routePrefix) + _routePrefix.Length, 36);
                        guid = string.IsNullOrEmpty(guid) ? urlGuid : guid;
                    }

                    if (!string.IsNullOrEmpty(guid) && !filterContext.RouteData.Values.ContainsKey(_identifierKey))
                    {
                        filterContext.RouteData.Values.Add(_identifierKey, guid);
                        filterContext.Result = new RedirectToRouteResult(_routeName, filterContext.RouteData.Values);
                        return;
                    }
                }
            }
            base.OnActionExecuting(filterContext);
        }
    }
}
