using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.CustomAttributes
{
    public class CustomHandleErrorAttribute : HandleErrorAttribute
    {
        public CustomHandleErrorAttribute()
        {
        }

        public override void OnException(ExceptionContext filterContext)
        {
            if (filterContext.ExceptionHandled || !filterContext.HttpContext.IsCustomErrorEnabled)
            {
                return;
            }

            if (new HttpException(null, filterContext.Exception).GetHttpCode() != 500)
            {
                return;
            }

            if (!ExceptionType.IsInstanceOfType(filterContext.Exception))
            {
                return;
            }

            // se loggea el error
            UsuarioModel usuario = ((BaseController)filterContext.Controller).UserData();
            LogManager.LogManager.LogErrorWebServicesBus(filterContext.Exception, usuario.CodigoConsultora, usuario.CodigoISO);
            //_logger.Error(filterContext.Exception.Message, filterContext.Exception);

            //si el Request es de AJAX reemplaza el tipo de retorno por un JSON que contiene el mensaje de error en vez de toda una View dificil de manejar
            if (filterContext.HttpContext.Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                filterContext.Result = new JsonResult
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = new
                    {
                        error = true,
                        message = filterContext.Exception.Message
                    }
                };
            }
            else
            {
                var controllerName = (string)filterContext.RouteData.Values["controller"];
                var actionName = (string)filterContext.RouteData.Values["action"];
                var model = new HandleErrorInfo(filterContext.Exception, controllerName, actionName);

                filterContext.Result = new ViewResult
                {
                    ViewName = View,
                    MasterName = Master,
                    ViewData = new ViewDataDictionary<HandleErrorInfo>(model),
                    TempData = filterContext.Controller.TempData
                };
            }

            filterContext.ExceptionHandled = true;
            filterContext.HttpContext.Response.Clear();
            filterContext.HttpContext.Response.StatusCode = 500;

            filterContext.HttpContext.Response.TrySkipIisCustomErrors = true;
        }
    }
}