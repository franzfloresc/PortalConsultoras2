using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Helpers
{
    public static class ControllerExtensions
    {
        public static string GetUniqueKey(this Controller controller)
        {
            return controller.RouteData.Values["guid"].ToString();
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
