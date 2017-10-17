using System.Web.Mvc;
using Portal.Consultoras.Web.Infraestructure;

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
            //todo: should evaluate rest of RouteData a queryString?
            if (controller.RouteData.Values[UniqueRoute.IdentifierKey] != null)
                return controller.RouteData.Values[UniqueRoute.IdentifierKey].ToString();

            return null;
        }

        public static void SetUniqueSession(this Controller controller, string name, object value)
        {
            controller.Session[controller.GetUniqueKey() + "_" + name] = value;
        }

        public static object GetUniqueSession(this Controller controller, string name)
        {
            return controller.Session[controller.GetUniqueKey() + "_" + name];
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
