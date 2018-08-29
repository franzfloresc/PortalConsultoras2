using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Common
{
    
    public class JwtModule : IHttpModule
    {
        static SemaphoreSlim semaphoreSlim = new SemaphoreSlim(1, 1);
        public void Dispose()
        {

        }

        public void Init(HttpApplication context)
        {
            EventHandlerTaskAsyncHelper asyncHelperObject = new EventHandlerTaskAsyncHelper(OnJwtRequestAsync);
            context.AddOnPreRequestHandlerExecuteAsync(asyncHelperObject.BeginEventHandler, asyncHelperObject.EndEventHandler);
        }
        private async Task OnJwtRequestAsync(Object s, EventArgs e)
        {
           
            if ( HttpContext.Current.Session["UserData"] != null &&  string.IsNullOrEmpty((string)HttpContext.Current.Session[Constantes.ConstSession.JwtApiSomosBelcorp]))
            {
                await semaphoreSlim.WaitAsync();
                try
                {
                    HttpContext.Current.Session[Constantes.ConstSession.JwtApiSomosBelcorp] = await JwtAutentication.getWebTokenAsync(JwtContext.Instance);

                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                finally
                {
                    semaphoreSlim.Release();

                }
            }
            
        }
    }
}
