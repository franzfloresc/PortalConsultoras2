using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class LogActionFilter : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            ErrorsLog logModel = new ErrorsLog()
            {
                Controller = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName,
                Action = filterContext.ActionDescriptor.ActionName,
                Ip = filterContext.HttpContext.Request.UserHostAddress,
                FechaHora = filterContext.HttpContext.Timestamp
            };
            LogManager.LogManager.LogActions(logModel);
            base.OnActionExecuting(filterContext);
        }
    }

    public class ErrorsLog
    {
        public string Controller { get; set; }
        public string Action { get; set; }
        public string Ip { get; set; }
        public DateTime FechaHora { get; set; }
    }
}