using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.WebPages;

namespace Portal.Consultoras.Web.Areas.Mobile.Helpers
{
    public static class JavaScriptHelper
    {
        public static void AddScript(this HtmlHelper html, string key, HelperResult fn)
        {
            var http = html.ViewContext.HttpContext;
            var list = http.Items["_Scripts"] as Dictionary<string, HelperResult>;

            if (list == null)
                list = new Dictionary<string, HelperResult>();

            list[key] = fn;

            http.Items["_Scripts"] = list;
        }

        public static void PlaceScripts(this HtmlHelper html)
        {
            var http = html.ViewContext.HttpContext;
            var list = http.Items["_Scripts"] as Dictionary<string, HelperResult>;

            if (list == null)
                return;

            using (var writer = new HtmlTextWriter(html.ViewContext.Writer))
            {
                foreach (var entry in list)
                {
                    writer.WriteLine(entry.Value);
                }
            }
        }
    }
}