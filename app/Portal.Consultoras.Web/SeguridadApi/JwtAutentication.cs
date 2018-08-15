using Newtonsoft.Json;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.CompilerServices;
using System.Security;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;

namespace Portal.Consultoras.Web
{
    public class JwtAutentication
    {
        private static string PathFile
        {
            get { return Path.Combine(Globals.JwtTokenPath, "JwtToken.json"); }

        }
        //return @"http://localhost:6777/";
        //return ConfigurationManager.AppSettings.Get("UrlLogDynamo");
        private static string urlApi   { get { return WebConfigurationManager.AppSettings["UrlLogDynamo"] ?? ""; } }
        private static string usuario  { get { return WebConfigurationManager.AppSettings["JwtUsuario"]   ?? ""; } }
        private static string password { get { return WebConfigurationManager.AppSettings["JwtPassword"]  ?? ""; } }
        private  static JwtToken Token
        {
            get {
                  
                    try
                    {
                         return getJsonToken();
                    }
                    catch( Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, "TokenUser", "", "Get propiedad Token.");
                        return  new JwtToken();
                    }
                }
        }


        #region Sync Metodos
        [SecuritySafeCritical]
        public static string getWebToken()
        {
            string sToken = Token.Token ?? "";
            if (string.IsNullOrEmpty(urlApi)) return sToken ;
            string responseBody = null;
            
            // valida  la fecha de caducidad del token con un día de anticipación : para obtener un nuevo token.
            if (Token.FechaExpiracion == DateTime.MinValue ||  DateTime.UtcNow >= Token.FechaExpiracion.AddDays(-1.5) || string.IsNullOrEmpty(Token.Token))
            {
                try
                {
                    using (HttpClient httpClient = new HttpClient())
                    {

                        httpClient.BaseAddress = new Uri(urlApi);
                        httpClient.DefaultRequestHeaders.Accept.Clear();
                        httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                        var dataString = JsonConvert.SerializeObject(new { Nombre = usuario, Password = password });
                        HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");

                        HttpResponseMessage response = httpClient.PostAsync("api/Seguridad", contentPost).GetAwaiter().GetResult();
                        responseBody = response.Content.ReadAsStringAsync().Result;
                        JwtToken JwtToken = JsonConvert.DeserializeObject<JwtToken>(responseBody);

                        if (JwtToken != null)
                        {
                            writeJsonToken(responseBody);
                            sToken = JwtToken.Token;
                        }

                     

                    }

                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, "TokenUser", "", "getWebToken.");
                }

            }
            return sToken;


        }
        private static void SaveKey(string token)
        {
            var configuration = WebConfigurationManager.OpenWebConfiguration("~");
            var section = (AppSettingsSection)configuration.GetSection("appSettings");
            section.Settings["JwtToken"].Value = token;
            configuration.Save();
        }
        public static JwtToken getJsonToken()
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
        private static void writeHilo()
        {
            using (StreamWriter stream = new StreamWriter(HttpContext.Current.Server.MapPath("~/SeguridadApi/log.txt"), true))
            {
                stream.WriteLine("metodo_sincrono" + "," + DateTime.Now + "," + System.Threading.Thread.CurrentThread.ManagedThreadId);
            }

        }
        #endregion
        #region Async Metodos

        public  static async Task<string>   getWebTokenAsync()
        {
            string sToken = string.Empty;
            try
            {

                JwtToken validateToken = await getJsonTokenAsync();
                sToken = validateToken.Token ?? "";
                if (string.IsNullOrEmpty(urlApi)) return sToken;
                
                if (validateToken.FechaExpiracion == DateTime.MinValue || string.IsNullOrEmpty(validateToken.Token) || DateTime.UtcNow >= validateToken.FechaExpiracion.AddDays(-1.5) )
                {
                   
                        using (HttpClient httpClient = new HttpClient())
                        {
                           
                                string responseBody = null;
                                httpClient.BaseAddress = new Uri(urlApi);
                                httpClient.DefaultRequestHeaders.Accept.Clear();
                                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                                var dataString = JsonConvert.SerializeObject(new { Nombre = usuario, Password = password, Hilo = System.Threading.Thread.CurrentThread.ManagedThreadId });
                                HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                                HttpResponseMessage response = await httpClient.PostAsync("api/Seguridad", contentPost);
                                responseBody = await response.Content.ReadAsStringAsync();
                                JwtToken JwtToken = JsonConvert.DeserializeObject<JwtToken>(responseBody);
                                if (JwtToken!=null)
                                {
                                    await writeJsonTokenAsync(responseBody);
                                    sToken = JwtToken.Token;
                                    //await  writeHiloAsync();
                                }
                           
                    }
                }

            }

            catch ( Exception ex )
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "TokenUser", "", "getWebTokenAsync.");
            }
           
            return sToken;
        }
        public  static async Task<JwtToken> getJsonTokenAsync()
        {
            JwtToken result = null;
            try
            {
                using (StreamReader r = new StreamReader(PathFile))
                {

                    string outputJson = await r.ReadToEndAsync();
                    result = JsonConvert.DeserializeObject<JwtToken>(outputJson, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                }
            }
            catch ( Exception ex)
            {
                
                result = new JwtToken();
                throw ex;
            }
            return result;
        }
        private static async Task writeJsonTokenAsync(string json)
        {

            using (StreamWriter stream = new StreamWriter(PathFile))
            {
                await stream.WriteAsync(json);
            }
        }
        private static async Task writeHiloAsync()
        {
            using (StreamWriter stream = new StreamWriter(HttpContext.Current.Server.MapPath("~/SeguridadApi/log.txt"), true))
            {
                await stream.WriteLineAsync("metodo_asincrono" + "," + DateTime.Now + "," + System.Threading.Thread.CurrentThread.ManagedThreadId);
            }

        }

    }
    #endregion
}
