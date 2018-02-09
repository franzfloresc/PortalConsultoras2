﻿using System;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web.CustomHelpers
{
    public static class ConsultoraOnlineHelper
    {
        private const string FDir_AppData = "/App_Data/";

        public static string IsSelected(this HtmlHelper html, string controllers = "", string actions = "", string cssClass = "active")
        {
            ViewContext viewContext = html.ViewContext;
            bool isChildAction = viewContext.Controller.ControllerContext.IsChildAction;

            if (isChildAction)
                viewContext = html.ViewContext.ParentActionViewContext;

            RouteValueDictionary routeValues = viewContext.RouteData.Values;
            string currentAction = routeValues["action"].ToString();
            string currentController = routeValues["controller"].ToString();

            if (String.IsNullOrEmpty(actions))
                actions = currentAction;

            if (String.IsNullOrEmpty(controllers))
                controllers = currentController;

            string[] acceptedActions = actions.Trim().Split(',').Distinct().ToArray();
            string[] acceptedControllers = controllers.Trim().Split(',').Distinct().ToArray();

            return acceptedActions.Contains(currentAction) && acceptedControllers.Contains(currentController) ?
                cssClass : String.Empty;
        }

        public static MvcHtmlString File(this HtmlHelper helper, string name)
        {
            return MvcHtmlString.Create(Path.Combine(FDir_AppData, name));
        }
    }
}