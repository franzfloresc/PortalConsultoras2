using Portal.Consultoras.Web.Models;
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
                if (HttpContext.Current != null && HttpContext.Current.Session != null)
                {
                    var userData = (UsuarioModel)HttpContext.Current.Session["UserData"];

                    LogManager.LogManager.LogErrorWebServicesBus(filterContext.Exception, userData.CodigoUsuario, userData.CodigoISO);
                }
                else
                {
                    LogManager.LogManager.LogErrorWebServicesBus(filterContext.Exception, "", "");
                }
            }

            base.OnException(filterContext);
        }
    }
}