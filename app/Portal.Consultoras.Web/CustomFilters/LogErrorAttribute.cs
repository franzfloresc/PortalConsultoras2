using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class LogErrorAttribute : HandleErrorAttribute
    {
        public override void OnException(ExceptionContext filterContext)
        {
            if (filterContext.Exception != null)
            {
                var userData = new Models.UsuarioModel();
                if (HttpContext.Current != null && HttpContext.Current.Session != null)
                {
                    userData = SessionManager.SessionManager.Instance.GetUserData() ?? new Models.UsuarioModel();
                }

                LogManager.LogManager.LogErrorWebServicesBus(filterContext.Exception, userData.CodigoUsuario ?? "", userData.CodigoISO ?? "");
            }

            base.OnException(filterContext);
        }
    }
}