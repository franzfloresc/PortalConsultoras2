using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.CustomFilters
{
    public class SessionExpiredActionFilterProvider : IFilterProvider
    {
        private IList<ControllerAction> actions = new List<ControllerAction>();

        public void Add(string controllerName, string actionName)
        {
            actions.Add(new ControllerAction()
            {
                ControllerName = controllerName,
                ActionName = actionName
            });
        }

        public void Add(string controllerName, string actionName, string areaName)
        {
            actions.Add(new ControllerAction()
            {
                ControllerName = controllerName,
                ActionName = actionName,
                AreaName = areaName
            });
        }

        public IEnumerable<Filter> GetFilters(ControllerContext controllerContext, ActionDescriptor actionDescriptor)
        {
            var area = controllerContext.RouteData.DataTokens["area"] != null
                ? controllerContext.RouteData.DataTokens["area"].ToString()
                : string.Empty;

            foreach (ControllerAction action in actions)
            {
                if ((action.ControllerName == actionDescriptor.ControllerDescriptor.ControllerName || action.ControllerName == "*")
                    && (action.ActionName == actionDescriptor.ActionName || action.ActionName == "*")
                    && (action.AreaName == area))
                {
                    yield return new Filter(new SessionExpiredActionFilter(), FilterScope.First, null);
                    break;
                }
            }
            yield break;
        }

    }
}