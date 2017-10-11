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
            //todo:
            //controller.Session[controller.GetUniqueKey() + "_" + name] = value;
            controller.Session[name] = value;
        }

        public static object GetUniqueSession(this Controller controller, string name)
        {
            //todo:
            //return controller.Session[controller.GetUniqueKey() + "_" + name];
            return controller.Session[name];
        }
    }
}
