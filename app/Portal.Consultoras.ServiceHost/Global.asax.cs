using Portal.Consultoras.Common;
using System;
using System.Net;
using System.Web;

namespace Portal.Consultoras.ServiceHost
{
    public class Global : HttpApplication
    {
        protected void Application_Start()
        {
            ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;
        }
       

        protected void Application_Error(object sender, EventArgs e)
            {
                var exception = Server.GetLastError();

                LogManager.SaveLog(exception, "", "");
            }
        }
}