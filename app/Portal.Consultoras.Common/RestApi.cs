using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;

namespace Portal.Consultoras.Common
{
    public class RestApi
    {
        private const string _mediaType = "application/json";
        private string _serviceUrl = ConfigurationManager.AppSettings["RutaService"].ToString();
        public RestApi()
        {

        }

        public RestApi(string ruta)
        {
            _serviceUrl = ruta;
        }

        public T GetAsync<T>(string path) where T : class, new()
        {
            try
            {
                var responseBody = string.Empty;
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(_serviceUrl);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(_mediaType));
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
                throw new InvalidOperationException("RestApi.GetAsync error " + ex.Message);
            }
        }
    }
}
