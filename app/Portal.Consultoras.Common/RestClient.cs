using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public static class RestClient
    {
        private const string _mediaType = "application/json";
        private static readonly Dictionary<Enumeradores.RestService, HttpClient> _dictClient;

        static RestClient()
        {
            _dictClient = new Dictionary<Enumeradores.RestService, HttpClient>();
            HttpClient httpClient;
            string configKey;
            
            foreach (Enumeradores.RestService restServiceEnum in Enum.GetValues(typeof(Enumeradores.RestService)))
            {
                switch (restServiceEnum)
                {
                    case Enumeradores.RestService.ReservaSicc: configKey = Constantes.ConfiguracionManager.UrlServiceSicc; break;
                    default: configKey = ""; break;
                }

                httpClient = new HttpClient();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(_mediaType));
                httpClient.BaseAddress = new Uri(ConfigurationManager.AppSettings[configKey]);

                _dictClient.Add(restServiceEnum, httpClient);
            }
        }

        public static async Task<IEnumerable<T>> GetAsync<T>(Enumeradores.RestService restServiceEnum, string path) where T : class, new()
        {
            try
            {
                var _client = _dictClient[restServiceEnum];
                var response = await _client.GetAsync(path);
                response.EnsureSuccessStatusCode();

                var responseBody = await response.Content.ReadAsStringAsync();
                return JsonConvert.DeserializeObject<IEnumerable<T>>(responseBody);
            }
            catch (WebException ex)
            {
                throw new WebException("RestClient.GetAsync error al invocar al servicio. " + ex.Message);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("RestClient.GetAsync error " + ex.Message);
            }
        }

        public static async Task<T> PostAsync<T>(Enumeradores.RestService restServiceEnum, string path, object obj)
        {
            var responseBody = await PostAsync(restServiceEnum, path, obj);
            return JsonConvert.DeserializeObject<T>(responseBody);
        }

        public static async Task<IEnumerable<T>> PostListAsync<T>(Enumeradores.RestService restServiceEnum, string path, object obj) where T : class, new()
        {
            var responseBody = await PostAsync(restServiceEnum, path, obj);
            return JsonConvert.DeserializeObject<IEnumerable<T>>(responseBody);
        }

        private static async Task<string> PostAsync(Enumeradores.RestService restServiceEnum, string path, object obj)
        {
            try
            {
                var _client = _dictClient[restServiceEnum];
                var postBody = new StringContent(JsonConvert.SerializeObject(obj).ToString(), Encoding.UTF8, _mediaType);
                var response = await _client.PostAsync(path, postBody);
                response.EnsureSuccessStatusCode();

                return await response.Content.ReadAsStringAsync();
            }
            catch (WebException ex)
            {
                throw new WebException("RestClient.PostListAsync error al invocar al servicio. " + ex.Message);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("RestClient.PostListAsync error " + ex.Message);
            }
        }
    }
}
