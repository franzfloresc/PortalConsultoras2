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
    public class RestClient
    {
        private const string _mediaType = "application/json";
        private readonly string _serviceUrl = ConfigurationManager.AppSettings["UrlServiceSicc"];

        public async Task<IEnumerable<T>> GetAsync<T>(string path) where T : class, new()
        {
            try
            {
                var responseBody = string.Empty;

                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(_serviceUrl);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(_mediaType));

                    var response = await client.GetAsync(path);

                    response.EnsureSuccessStatusCode();

                    responseBody = await response.Content.ReadAsStringAsync();
                }

                var list = JsonConvert.DeserializeObject<IEnumerable<T>>(responseBody);

                return list;
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

        public async Task<T> PostAsync<T>(string path, object obj)
        {
            var responseBody = await PostAsync(path, obj);

            var item = JsonConvert.DeserializeObject<T>(responseBody);

            return item;
        }

        public async Task<IEnumerable<T>> PostListAsync<T>(string path, object obj) where T : class, new()
        {
            var responseBody = await PostAsync(path, obj);

            var list = JsonConvert.DeserializeObject<IEnumerable<T>>(responseBody);

            return list;
        }

        private async Task<string> PostAsync(string path, object obj)
        {
            var responseBody = string.Empty;

            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(_serviceUrl);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(_mediaType));

                    var postBody = new StringContent(JsonConvert.SerializeObject(obj).ToString(),
                        Encoding.UTF8, "application/json");

                    var response = await client.PostAsync(path, postBody);

                    response.EnsureSuccessStatusCode();

                    responseBody = await response.Content.ReadAsStringAsync();
                }
            }
            catch (WebException ex)
            {
                throw new WebException("RestClient.PostListAsync error al invocar al servicio. " + ex.Message);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("RestClient.PostListAsync error " + ex.Message);
            }

            return responseBody;
        }
    }
}
