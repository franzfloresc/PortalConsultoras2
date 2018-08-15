using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web
{
    public class JwtModule : IHttpModule
    {
        static object locker = new object();
        static SemaphoreSlim semaphoreSlim = new SemaphoreSlim(1, 1);
        public void Dispose()
        {
           
        }

        public void Init(HttpApplication context)
        {

            EventHandlerTaskAsyncHelper asyncHelperObject = new EventHandlerTaskAsyncHelper(OnJwtRequestAsync);

            context.AddOnBeginRequestAsync(asyncHelperObject.BeginEventHandler, asyncHelperObject.EndEventHandler);
            context.AddOnPostAuthenticateRequestAsync(asyncHelperObject.BeginEventHandler, asyncHelperObject.EndEventHandler);
            context.AddOnPostMapRequestHandlerAsync(asyncHelperObject.BeginEventHandler, asyncHelperObject.EndEventHandler);

            //context.BeginRequest += new EventHandler(this.OnJwtRequest);
            //context.PostAuthenticateRequest += new EventHandler(this.OnJwtRequest);
            //context.PostMapRequestHandler += new EventHandler(this.OnJwtRequest);


        }
        private void OnJwtRequest(Object s, EventArgs e)
        {
            Monitor.Enter(locker);
            try

            {
                Globals.JwtToken = JwtAutentication.getWebToken();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                Monitor.Exit(locker);

            }

        }
       
        private async Task OnJwtRequestAsync(Object s, EventArgs e)
        {

            JwtToken jwtToken_ = JwtAutentication.getJsonToken();

            if (jwtToken_.FechaExpiracion == DateTime.MinValue || string.IsNullOrEmpty(jwtToken_.Token) || DateTime.UtcNow >= jwtToken_.FechaExpiracion.AddDays(-1.5))
            {
                await semaphoreSlim.WaitAsync();
                try
                {
                    Globals.JwtToken = await JwtAutentication.getWebTokenAsync();

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