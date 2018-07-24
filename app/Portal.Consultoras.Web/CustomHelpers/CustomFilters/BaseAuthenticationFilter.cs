using Portal.Consultoras.Web.SessionManager;
using System.Web.Mvc;
using System.Web.Mvc.Filters;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class BaseAuthenticationFilter : ActionFilterAttribute, IAuthenticationFilter
    {
        ISessionManager sessionManager;
        public BaseAuthenticationFilter()
        {
            sessionManager = new SessionManager.SessionManager();
        }

        public void OnAuthentication(AuthenticationContext filterContext)
        {
        }

        public void OnAuthenticationChallenge(AuthenticationChallengeContext filterContext)
        {
            if (filterContext.HttpContext.User.Identity.IsAuthenticated && string.IsNullOrEmpty(sessionManager.GetUserData().CodigoUsuario))
            {
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    filterContext.Result = new HttpUnauthorizedResult();
                }
                else
                {
                    filterContext.RouteData.Values.Remove("action");
                    filterContext.RouteData.Values.Remove("controller");

                    filterContext.RouteData.Values.Add("action", "LogOut");
                    filterContext.RouteData.Values.Add("controller", "login");

                    filterContext.Result = new RedirectToRouteResult("Default", filterContext.RouteData.Values);
                }
            }
        }
    }
}
