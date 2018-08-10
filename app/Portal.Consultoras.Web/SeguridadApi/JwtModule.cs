using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web
{
    public class JwtModule : IHttpModule
    {
        public void Dispose()
        {
           
        }

        public void Init(HttpApplication context)
        {

            EventHandlerTaskAsyncHelper asyncHelperObject = new EventHandlerTaskAsyncHelper(OnJwtRequestAsync);
            context.AddOnBeginRequestAsync(asyncHelperObject.BeginEventHandler, asyncHelperObject.EndEventHandler);
            context.AddOnPostAuthenticateRequestAsync(asyncHelperObject.BeginEventHandler, asyncHelperObject.EndEventHandler);
            context.AddOnPostMapRequestHandlerAsync(asyncHelperObject.BeginEventHandler, asyncHelperObject.EndEventHandler);

        }

        private async Task OnJwtRequestAsync(Object s, EventArgs e)
        {

            Globals.JwtToken = await JwtAutentication.getWebTokenAsync();

        }
    }
}