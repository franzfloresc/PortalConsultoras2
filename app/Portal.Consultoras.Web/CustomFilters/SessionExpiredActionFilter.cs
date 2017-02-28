using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class SessionExpiredActionFilter : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            UsuarioModel userData = (UsuarioModel)filterContext.HttpContext.Session["UserData"];

            if (userData == null)
            {
                CerrarSesion(filterContext);
            }

            base.OnActionExecuting(filterContext);
        }

        private void CerrarSesion(ActionExecutingContext filterContext)
        {
            filterContext.HttpContext.Session["UserData"] = null;
            filterContext.HttpContext.Session.Clear();
            filterContext.HttpContext.Session.Abandon();

            string URLSignOut = string.Empty;

            if (filterContext.HttpContext.Request.IsAjaxRequest())
            {
                filterContext.Result = new JsonResult { Data = "_Logon_" };
            }
            else
            {
                if (filterContext.HttpContext.Request.UrlReferrer != null &&
                filterContext.HttpContext.Request.UrlReferrer.ToString().Contains(filterContext.HttpContext.Request.Url.Host))
                {
                    URLSignOut = "/Login/SesionExpirada";
                }
                else
                {
                    URLSignOut = "/Login/UserUnknown";
                }

                filterContext.Result = new RedirectResult(URLSignOut);
            }
        }
    }
}