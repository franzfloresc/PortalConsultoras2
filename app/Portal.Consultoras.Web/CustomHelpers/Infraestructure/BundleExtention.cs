using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace Portal.Consultoras.Web
{
    
    public class StyleIgnoreMinifyBundle : Bundle
    {

        public StyleIgnoreMinifyBundle(string virtualPath) : base(virtualPath , new CssNotMinify())
        {
        

        }

        public StyleIgnoreMinifyBundle(string virtualPath, string cdnPath) : base(virtualPath , cdnPath , new CssNotMinify())
        {

        }
    }
    public class ScriptIgnoreMinifyBundle : Bundle
    {

        public ScriptIgnoreMinifyBundle(string virtualPath) : base(virtualPath, new JsNotMinify())
        {


        }

        public ScriptIgnoreMinifyBundle(string virtualPath, string cdnPath) : base(virtualPath, cdnPath, new JsNotMinify())
        {

        }
    }
    public class CssNotMinify : IBundleTransform
    {

        public void Process(BundleContext context, BundleResponse response)
        {

            response.Content = response.Content;
            response.ContentType = "text/css";
            response.Cacheability = HttpCacheability.Public;
        }
    }
    public class JsNotMinify : IBundleTransform
    {

        public void Process(BundleContext context, BundleResponse response)
        {

            response.Content = response.Content;
            response.ContentType = "text/javascript";
            response.Cacheability = HttpCacheability.Public;
        }
    }
}