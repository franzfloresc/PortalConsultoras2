using Portal.Consultoras.Web.CustomFilters;
using System.Web.Mvc;

namespace Portal.Consultoras.Web
{
    public static class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new LogErrorAttribute());
        }
    }
}