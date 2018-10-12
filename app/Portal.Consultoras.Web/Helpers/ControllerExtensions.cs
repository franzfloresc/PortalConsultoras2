using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Infraestructure;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Helpers
{
    public static class ControllerExtensions
    {
        /// <summary>
        /// Obtiene la key unica de la ruta basada en UniqueRoute.IdentifierKey
        /// </summary>
        /// <param name="controller"></param>
        /// <returns>Guid or Null</returns>
        public static string GetUniqueKey(this Controller controller)
        {
            var uniqueKey = string.Empty;

            if (controller.Request != null)
            {
                uniqueKey = controller.Request.Headers[UniqueRoute.IdentifierKey];
                if (uniqueKey.IsGuid())
                    return uniqueKey;

                if (controller.Request.UrlReferrer != null)
                {
                    var indexOfUnique = controller.Request.UrlReferrer.AbsolutePath.IndexOf("/g/");
                    var uniqueKeyReferrer = indexOfUnique > 0 ? controller.Request.UrlReferrer.AbsolutePath.Substring(indexOfUnique, 39) : string.Empty;
                    if (uniqueKeyReferrer.IsGuid())
                        return uniqueKeyReferrer;
                }
            }

            return controller.RouteData.GetUniqueRoute(UniqueRoute.IdentifierKey);
        }

        /// <summary>
        /// Set unique key (Guid)
        /// </summary>
        /// <param name="controller">This</param>
        /// <param name="guid">Guid</param>
        /// <returns></returns>
        public static string SetUniqueKeyAvoiding(this Controller controller, Guid guid)
        {
            return controller.RouteData.SetUniqueKeyAvoiding(UniqueRoute.IdentifierKey, guid);
        }

        public static void SetUniqueSession(this Controller controller, string name, object value)
        {
            controller.Session.SetUniqueSession(controller.GetUniqueKey(), name, value);
        }

        public static object GetUniqueSession(this Controller controller, string name)
        {
            return controller.Session.GetUniqueSession(controller.GetUniqueKey(), name);
        }

        /// <summary>
        /// Obtiene y castea si no es null
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="controller"></param>
        /// <param name="name"></param>
        /// <param name="newInstance">Nueva instancia o null por defecto</param>
        /// <returns></returns>
        public static T GetUniqueSession<T>(this Controller controller, string name, bool newInstance = true) where T : class, new()
        {
            var getUniqueSession = GetUniqueSession(controller, name);
            return getUniqueSession == null ? newInstance ? new T() : default(T) : (T)getUniqueSession;
        }
    }
}
