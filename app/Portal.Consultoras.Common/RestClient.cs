using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class RestClient
    {
        private const string _mediaType = "application/json";
        private readonly string _serviceUrl = ConfigurationManager.AppSettings["RutaService"] ?? "";

       
        public async static Task<T> GetTAsync<T>(string path) where T : class, new()
        {
            try
            {
                var http = new HttpClient();
                var response = await http.GetAsync(path);
                var result = await response.Content.ReadAsStringAsync();
                var serializer = new DataContractJsonSerializer(typeof(T));

                var ms = new MemoryStream(Encoding.UTF8.GetBytes(result));
                var data = (T)serializer.ReadObject(ms);
                return data;
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
                throw new InvalidOperationException("RestClient.GetTAsync error " + ex.Message);
            }
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
                //ErrorUtilities.AddLog(ex, "", "");
                ErrorUtilities.AddLog(ex);
                throw new InvalidOperationException("RestClient.GetAsync error " + ex.Message);
            }
        }

        public T PostAsync<T>(string path, object obj)
        {

            try
            {
                var responseBody = string.Empty;
                T item;
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(_serviceUrl);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(_mediaType));

                    var postBody = new StringContent(JsonConvert.SerializeObject(obj).ToString(),
                        Encoding.UTF8, "application/json");

                    var response = client.PostAsync(path, postBody).Result;

                    response.EnsureSuccessStatusCode();

                    responseBody = response.Content.ReadAsStringAsync().Result;
                }

                item = JsonConvert.DeserializeObject<T>(responseBody);
                return item;
            }
            catch (Exception ex)
            {
                //ErrorUtilities.AddLog(ex, "", "");
                ErrorUtilities.AddLog(ex);
                throw new InvalidOperationException("RestClient.PostAsync error " + ex.Message);
            }
        }

        public async Task<IEnumerable<T>> PostListAsync<T>(string path, object obj) where T : class, new()
        {
            try
            {
                var responseBody = string.Empty;

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

                var list = JsonConvert.DeserializeObject<IEnumerable<T>>(responseBody);

                return list;
            }
            catch (Exception ex)
            {
                //ErrorUtilities.AddLog(ex, "", "");
                ErrorUtilities.AddLog(ex);
                throw new InvalidOperationException("RestClient.PostListAsync error " + ex.Message);
            }
        }

    }
}
