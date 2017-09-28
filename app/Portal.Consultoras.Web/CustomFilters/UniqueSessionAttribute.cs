using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.Routing;
using Org.BouncyCastle.Asn1.Ocsp;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class UniqueSessionAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            //como no perder el guid?
            if (filterContext.RouteData.Values.ContainsKey("guid"))
            {
                //filterContext.HttpContext.Request.QueryString["guid"] != null &&
                //filterContext.Result = new RedirectToRouteResult("SystemLogin", routeValues);
            }

            base.OnActionExecuting(filterContext);
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            var hasGuid = filterContext.RouteData.Values.ContainsKey("guid");

            base.OnActionExecuted(filterContext);
        }
    }
}
