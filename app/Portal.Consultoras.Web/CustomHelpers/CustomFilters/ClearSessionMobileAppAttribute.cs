using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Helpers;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.CustomFilters
{
    /// <summary>
    /// Clean session based on MobileAppConfiguracionModel
    /// </summary>
    public class ClearSessionMobileAppAttribute : ActionFilterAttribute
    {
        /// <summary>
        /// Route identifier
        /// </summary>
        public string Identifier { get; set; }

        /// <summary>
        /// Session Key Name
        /// </summary>
        public string SessionName { get; set; }

        public string StartSessionName { get; set; }

        public ClearSessionMobileAppAttribute(string routeIdentifier, string sessionName, string startSessionName)
        {
            Identifier = routeIdentifier;
            SessionName = sessionName;
            StartSessionName = startSessionName;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var uniqueKey = filterContext.RouteData.GetUniqueRoute(Identifier);

            var configuracionApp = filterContext.HttpContext.Session.GetUniqueSession<MobileAppConfiguracionModel>(uniqueKey, SessionName);
            if (configuracionApp == null)
                return;

            if (filterContext.HttpContext.Session[StartSessionName] == null)
                return;

            var datetimeStartSession = (DateTime)filterContext.HttpContext.Session[StartSessionName];

            if (datetimeStartSession.AddMinutes(configuracionApp.TimeOutSession) < DateTime.Now)
            {
                var sessionKeysToDelete = (from object key in filterContext.HttpContext.Session.Keys
                                           where !key.ToString().Contains(uniqueKey)
                                           select key.ToString()).ToList();

                sessionKeysToDelete.ForEach(k => filterContext.HttpContext.Session.Remove(k));
                filterContext.HttpContext.Session[StartSessionName] = DateTime.Now;
            }

            base.OnActionExecuting(filterContext);
        }
    }
}
