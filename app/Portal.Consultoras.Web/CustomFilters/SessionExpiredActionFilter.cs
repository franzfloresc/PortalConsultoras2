using System;
using System.Collections.Generic;
using System.Configuration;
//using System.IdentityModel.Services;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class SessionExpiredActionFilter : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session != null)
            {
                if (filterContext.HttpContext.Session.IsNewSession)
                {
                    var sessionCookie = filterContext.HttpContext.Request.Headers["Cookie"];
                    if ((sessionCookie != null) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0))
                    {
                        /*EPD-180*/
                        // if exists UserData in Session
                        if (filterContext.HttpContext.Session["UserData"] != null)
                        {
                            // loggear datos de variable de sesion clave
                            UsuarioModel usuario = (UsuarioModel)filterContext.HttpContext.Session["UserData"];
                            if (usuario != null)
                            {
                                LogManager.LogManager.LogErrorWebServicesBus(new ApplicationException("Si existe Session[UserData]"), usuario.CodigoConsultora, usuario.CodigoISO);
                            }
                            else
                            {
                                LogManager.LogManager.LogErrorWebServicesBus(new ApplicationException("No existe Session[UserData]"), string.Empty, string.Empty);
                            }
                            // loggear datos de variable de sesion clave
                        }
                        /*EPD-180*/
                        CerrarSesion(filterContext);

                        // version 2
                        if (filterContext.HttpContext.Request.IsAjaxRequest())
                        {
                            // Para requests de AJAX, sobreescribimos el resultado JSON retornado con una cadena simple,
                            // la cual indique al JavaScript invocador que una redirección debería ser realizada
                            filterContext.Result = new JsonResult { Data = "_Logon_" };
                        }
                        else
                        {
                            // Para posts clasicos, estamos forzando una redirección a /Login/Timeout, la cual
                            // simplemente muestra una notificación durante 5 segundos que indique que ha habido un timeout
                            // y, a su vez, redireccione a la vista de login
                            //filterContext.Result = new RedirectToRouteResult(
                            //    new RouteValueDictionary {
                            //        { "Controller", "Login" },
                            //        { "Action", "Timeout" }
                            //});

                            //string URLSignOut = "https://stsqa.somosbelcorp.com/adfs/ls/?wa=wsignout1.0";
                            //string URLSignOut = "/SesionExpirada.html";
                            string URLSignOut = "/Login/SesionExpirada";
                            filterContext.Result = new RedirectResult(URLSignOut);
                        }
                        // version 2
                    }
                }
            }
            base.OnActionExecuting(filterContext);
        }

        private void CerrarSesion(ActionExecutingContext filterContext)
        {
            filterContext.HttpContext.Session["UserData"] = null;
            filterContext.HttpContext.Session.Abandon();

            //FederatedAuthentication.WSFederationAuthenticationModule.SignOut(false);
            //FederatedAuthentication.SessionAuthenticationModule.SignOut();
            //FederatedAuthentication.SessionAuthenticationModule.CookieHandler.Delete();
            //FederatedAuthentication.SessionAuthenticationModule.DeleteSessionTokenCookie();

            //FormsAuthentication.SignOut();

            // TODO: resolver url para hacer signout
            //string URLSignOut = string.Empty;
            //switch (Tipo)
            //{
            //    case 0:
            //        URLSignOut = ConfigurationManager.AppSettings.Get("URLSignOut"); // https://10.12.6.208/adfs/ls/?wa=wsignout1.0
            //        break;
            //    case 1:
            //        URLSignOut = ConfigurationManager.AppSettings.Get("URLSignOut");
            //        break;
            //    case 2:
            //        URLSignOut = ConfigurationManager.AppSettings.Get("URLSignOutPartner"); // https://adfsqa.belcorp.biz/adfs/ls/?wa=wsignout1.0
            //        break;
            //}

            //return Redirect(URLSignOut);

            string URLSignOut = "/Login/SesionExpirada";
            filterContext.Result = new RedirectResult(URLSignOut);
        }
    }

}