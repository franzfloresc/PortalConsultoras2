using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Rest
{
    public class RestClient
    {
        public async Task<IEnumerable<T>> GetAsync<T>(HttpClient client, string path) where T : class, new()
        {
            try
            {
                var response = await client.GetAsync(path);
                response.EnsureSuccessStatusCode();

                var responseBody = await response.Content.ReadAsStringAsync();
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

        public async Task<T> PostAsync<T>(HttpClient client, string path, object obj)
        {
            var responseBody = await PostAsync(client, path, obj);
            return JsonConvert.DeserializeObject<T>(responseBody);
        }

        public async Task<IEnumerable<T>> PostListAsync<T>(HttpClient client, string path, object obj) where T : class, new()
        {
            var responseBody = await PostAsync(client, path, obj);
            return JsonConvert.DeserializeObject<IEnumerable<T>>(responseBody);
        }

        private async Task<string> PostAsync(HttpClient client, string path, object obj)
        {
            var responseBody = string.Empty;
            try
            {
                var body = JsonConvert.SerializeObject(obj).ToString();
                var postBody = new StringContent(body, Encoding.UTF8, "application/json");
                var response = await client.PostAsync(path, postBody);
                response.EnsureSuccessStatusCode();

                responseBody = await response.Content.ReadAsStringAsync();
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
