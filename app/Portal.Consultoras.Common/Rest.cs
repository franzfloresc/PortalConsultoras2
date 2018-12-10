using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;

namespace Portal.Consultoras.Common
{
    public class Rest
    {
        private const string _mediaType = "application/json";
        private readonly string _serviceUrl = ConfigurationManager.AppSettings["UrlLogDynamo"].ToString();

        public Rest()
        {

        }

        public T GetAsync<T>(string path) where T : class, new()
        {
            try
            {
                string Token = string.Empty;
                if (HttpContext.Current != null && HttpContext.Current.Request != null)
                {
             
                    Token = (string)HttpContext.Current.Session[Constantes.ConstSession.JwtApiSomosBelcorp] ?? "";
                }
                var responseBody = string.Empty;

                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(_serviceUrl);
                    client.DefaultRequestHeaders.Add("Authorization", string.Format("Bearer {0}", Token));

                    var response = client.GetAsync(path).Result;

                    response.EnsureSuccessStatusCode();

                    responseBody = response.Content.ReadAsStringAsync().Result;
                }

                var list = JsonConvert.DeserializeObject<T>(responseBody);

                return list;
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
                throw new InvalidOperationException("RestClient.GetAsync error " + ex.Message);
            }
        }
    }
}
