using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Common
{
    public class JwtAutentication
    {




 
 

        #region Async Metodos

        public static async Task<string> getWebTokenAsync(JwtContext request)
        {
            string JwtToken = string.Empty;
            try
            {
                if (string.IsNullOrEmpty((string)HttpContext.Current.Session[Constantes.ConstSession.JwtApiSomosBelcorp]))
                {
                    using (HttpClient httpClient = new HttpClient())
                    {

                        string responseBody = null;
                        httpClient.BaseAddress = new Uri(request.Url);
                        httpClient.DefaultRequestHeaders.Accept.Clear();
                        httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                        var dataString = JsonConvert.SerializeObject(new { request.Nombre, request.Password, Hilo = System.Threading.Thread.CurrentThread.ManagedThreadId });
                        HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                        HttpResponseMessage response = await httpClient.PostAsync("api/Seguridad", contentPost);
                        responseBody = await response.Content.ReadAsStringAsync();
                        JwtToken Token = JsonConvert.DeserializeObject<JwtToken>(responseBody);
                        if (Token != null) JwtToken = Token.Token;


                    }
                }
            }

            catch (Exception ex)
            {
                throw ex;
            }

            return JwtToken;
        }
       
     

    }
    #endregion
}

