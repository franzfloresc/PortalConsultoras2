using System.Web.Mvc;
using Portal.Consultoras.Web.Infraestructure;

namespace Portal.Consultoras.Web.Helpers
{
    public static class ControllerExtensions
    {
        public static string GetUniqueKey(this Controller controller)
        {
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
    }
}
