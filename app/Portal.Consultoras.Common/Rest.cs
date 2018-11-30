using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;

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
                throw new InvalidOperationException("RestClient.GetAsync error " + ex.Message);
            }
        }
    }
}
