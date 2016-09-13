using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Helpers
{
    public static class HtmlsHelper
    {
        public static bool IsDebug(this HtmlHelper htmlHelper)
        {
#if DEBUG
            return true;
#else
      return false;
#endif
        }
    }
}