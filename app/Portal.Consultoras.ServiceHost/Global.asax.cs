using Portal.Consultoras.Common;
using System;
using System.Web;

namespace Portal.Consultoras.ServiceHost
{
    public class Global : HttpApplication
    {
        protected void Application_Error(object sender, EventArgs e)
        {
            var exception = Server.GetLastError();

            LogManager.SaveLog(exception, "", "");
        }
    }
}