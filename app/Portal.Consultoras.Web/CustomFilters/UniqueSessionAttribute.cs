using System;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class UniqueSessionAttribute : ActionFilterAttribute
    {
        /// <summary>
        /// Route Name
        /// </summary>
        public readonly string RouteName;

        /// <summary>
        /// Identifier (Dictionary key)
        /// </summary>
        public readonly string IdentifierKey;

        /// <summary>
        /// Route Prefix defined on url
        /// </summary>
        public readonly string RoutePrefix;

        public UniqueSessionAttribute(string routeName, string identifierKey, string routePrefix)
        {
            RouteName = routeName;
            IdentifierKey = identifierKey;
            RoutePrefix = routePrefix;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (!filterContext.HttpContext.Request.IsAjaxRequest() && filterContext.RequestContext.HttpContext.Request.UrlReferrer != null)
            {
                    var guid = HttpUtility.ParseQueryString(filterContext.RequestContext.HttpContext.Request.UrlReferrer.Query).Get(IdentifierKey);
                    var originalString = filterContext.RequestContext.HttpContext.Request.UrlReferrer.OriginalString;
                    var origiIndex = originalString.IndexOf(RoutePrefix, StringComparison.OrdinalIgnoreCase);
                    if (origiIndex > 0)
                    {
                        var urlGuid = originalString.Substring(origiIndex + RoutePrefix.Length, 36);
                        guid = string.IsNullOrEmpty(guid) ? urlGuid : guid;
                    }

                    Guid validatedGuid;
                    if (!Guid.TryParse(guid, out validatedGuid))
                        return;

                    if (!string.IsNullOrEmpty(guid) && !filterContext.RouteData.Values.ContainsKey(IdentifierKey))
                    {
                        filterContext.RouteData.Values.Add(IdentifierKey, validatedGuid.ToString());

                        foreach (var param in filterContext.ActionParameters)
                        {
                            if (filterContext.RouteData.Values.ContainsKey(param.Key)) continue;
                            filterContext.RouteData.Values.Add(param.Key, param.Value);
                        }

                        filterContext.Result = new RedirectToRouteResult(RouteName, filterContext.RouteData.Values);

                        return;
                    }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}
