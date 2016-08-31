using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            // TODO: se agrega el filtro personalizado para manejo de errores
            //filters.Add(new CustomHandleErrorAttribute());
            // se agrega el filtro personalizado de control de sesión expirada como filtro global
            //filters.Add(new SessionExpireAttribute());
        }
    }
}