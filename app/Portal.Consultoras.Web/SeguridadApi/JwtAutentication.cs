using Newtonsoft.Json;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web
{
    public class JwtAutentication
    {
        private static string PathFile
        {
            get { return Path.Combine(Globals.JwtTokenPath, "JwtToken.json"); }

        }
        private static string urlApi   { get { return ConfigurationManager.AppSettings.Get("UrlLogDynamo");} }
        private static string usuario  { get { return ConfigurationManager.AppSettings.Get("JwtUsuario");  } }
        private static string password { get { return ConfigurationManager.AppSettings.Get("JwtPassword"); } }
        private  static JwtToken Token
        {
            get {

                    try
                    {
                         return getJsonToken();
                    }
                    catch( Exception ex)
                    {
                        return  new JwtToken();
                    }
                }
        }
   

        [SecuritySafeCritical]
        public static string getWebToken()
        {
            string sToken = Token.Token;
            if (string.IsNullOrEmpty(urlApi)) return sToken ;
            string responseBody = null;
            

            if (Token.FechaExpiracion.AddDays(2).Equals(DateTime.UtcNow.ToShortDateString()) || string.IsNullOrEmpty(Token.Token))
            {
                try
                {
                    using (HttpClient httpClient = new HttpClient())
                    {

                        httpClient.BaseAddress = new Uri("http://localhost:6777/");
                        httpClient.DefaultRequestHeaders.Accept.Clear();
                        httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                        var dataString = JsonConvert.SerializeObject(new { Nombre = usuario, Password = password });
                        HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                        HttpResponseMessage response = httpClient.PostAsync("api/Seguridad", contentPost).GetAwaiter().GetResult();
                        responseBody = response.Content.ReadAsStringAsync().Result;
                        JwtToken JwtToken = JsonConvert.DeserializeObject<JwtToken>(responseBody);
                        if (!string.IsNullOrWhiteSpace(JwtToken.Token))
                        {
                            writeJsonToken(responseBody);
                            sToken =JwtToken.Token;
                        }
                      
                    }

                }
                catch (Exception ex)
                {
                   
                }

            }
            return sToken;


        }

        private static JwtToken getJsonToken()
        {
            using (StreamReader r = new StreamReader(PathFile))
            {
                return JsonConvert.DeserializeObject<JwtToken>(r.ReadToEnd(), new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
            }
        }

        

        private static void writeJsonToken(string json)
        {
            using (StreamWriter stream = new StreamWriter(PathFile))
            {
                stream.Write(json);
            }

        }
        #region Async Metodos
        public async  static Task<string>  getWebTokenAsync()
        {
            string sToken = Token.Token;
            if (string.IsNullOrEmpty(urlApi)) return sToken;
            string responseBody = null;

            if (Token.FechaExpiracion.AddDays(2).Equals(DateTime.UtcNow.ToShortDateString()) || string.IsNullOrEmpty(Token.Token))
            {
                try
                {
                    using (HttpClient httpClient = new HttpClient())
                    {

                        httpClient.BaseAddress = new Uri("http://localhost:6777/");
                        httpClient.DefaultRequestHeaders.Accept.Clear();
                        httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                        var dataString = JsonConvert.SerializeObject(new { Nombre = usuario, Password = password });
                        HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                        HttpResponseMessage response = await httpClient.PostAsync("api/Seguridad", contentPost);
                        responseBody = await response.Content.ReadAsStringAsync();
                        JwtToken JwtToken = JsonConvert.DeserializeObject<JwtToken>(responseBody);
                        if(!string.IsNullOrWhiteSpace(JwtToken.Token))
                        {
                            await writeJsonTokenAsync(responseBody);
                            sToken = JwtToken.Token;
                        }
                            
                    }

                }
                catch (Exception ex)
                {
                   
                }

            }
            return sToken;
        }
        private async Task<JwtToken> getJsonTokenAsync()
        {
            using (StreamReader r = new StreamReader(PathFile))
            {

                string outputJson = await r.ReadToEndAsync();
                return JsonConvert.DeserializeObject<JwtToken>(outputJson, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
            }
        }
        private static async Task writeJsonTokenAsync(string json)
        {

            using (StreamWriter stream = new StreamWriter(PathFile))
            {
                await stream.WriteAsync(json);
            }
        }


    }
    #endregion
}
