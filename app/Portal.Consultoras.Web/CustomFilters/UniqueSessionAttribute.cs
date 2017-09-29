using System;
using System.Web;
using System.Web.Mvc;

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
                    if (originalString.IndexOf(_routePrefix, StringComparison.OrdinalIgnoreCase) > 0)
                    {
                        //36 is guid length
                        var urlGuid = originalString.Substring(originalString.IndexOf(_routePrefix, StringComparison.OrdinalIgnoreCase) + _routePrefix.Length, 36);
                        guid = string.IsNullOrEmpty(guid) ? urlGuid : guid;
                    }

                    Guid validatedGuid;
                    if (!Guid.TryParse(guid, out validatedGuid))
                        return;

                    if (!string.IsNullOrEmpty(guid) && !filterContext.RouteData.Values.ContainsKey(_identifierKey))
                    {
                        filterContext.RouteData.Values.Add(_identifierKey, validatedGuid.ToString());
                        filterContext.Result = new RedirectToRouteResult(_routeName, filterContext.RouteData.Values);
                        return;
                    }
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}
