using Newtonsoft.Json;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Reserva.Rest
{
    public static class RestClient
    {
        private const string MEDIA_TYPE = "application/json";
        private static readonly DictHttpClient dictClient = new DictHttpClient(MEDIA_TYPE);

        public static async Task<IEnumerable<T>> GetAsync<T>(Enumeradores.RestService restServiceEnum, string path) where T : class, new()
        {
            try
            {
                var _client = dictClient.Get(restServiceEnum);
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

        private static async Task<string> PostAsync(Enumeradores.RestService restServiceEnum, string path, object obj)
        {
            try
            {
                var _client = dictClient.Get(restServiceEnum);
                var postBody = new StringContent(JsonConvert.SerializeObject(obj).ToString(), Encoding.UTF8, MEDIA_TYPE);
                var response = await _client.PostAsync(path, postBody);
                response.EnsureSuccessStatusCode();

                return await response.Content.ReadAsStringAsync();
            }
            catch (WebException ex)
            {
                throw new WebException("RestClient.PostAsync error al invocar al servicio. " + ex.Message);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("RestClient.PostAsync error " + ex.Message);
            }
        }

        private static async Task<string> PutAsync(Enumeradores.RestService restServiceEnum, string path, object obj)
        {
            try
            {
                var _client = dictClient.Get(restServiceEnum);
                var postBody = new StringContent(JsonConvert.SerializeObject(obj).ToString(), Encoding.UTF8, MEDIA_TYPE);
                var response = await _client.PutAsync(path, postBody);
                response.EnsureSuccessStatusCode();

                return await response.Content.ReadAsStringAsync();
            }
            catch (WebException ex)
            {
                throw new WebException("RestClient.PutAsync error al invocar al servicio. " + ex.Message);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("RestClient.PutAsync error " + ex.Message);
            }
        }

        public static async Task<T> PutAsync<T>(Enumeradores.RestService restServiceEnum, string path, object obj)
        {
            var responseBody = await PutAsync(restServiceEnum, path, obj);
            return JsonConvert.DeserializeObject<T>(responseBody);
        }
    }
}
