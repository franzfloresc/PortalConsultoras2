using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorBaseProvider
    {
        public async Task<string> ObtenerPersonalizaciones(string path)
        {
            var personalizacion = "";
            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var httpResponse = await httpClient.GetAsync(path);

                if (!httpResponse.IsSuccessStatusCode) return personalizacion;
                var jsonString = await httpResponse.Content.ReadAsStringAsync();
                personalizacion = JsonConvert.DeserializeObject<string>(jsonString);
            }

            return personalizacion;
        }

        //Llamadas Post genérica
        public async Task<T> PostAsync<T>(string url, object data) where T : class, new()
        {
            var myContent = JsonConvert.SerializeObject(data);
            var buffer = System.Text.Encoding.UTF8.GetBytes(myContent);
            var byteContent = new ByteArrayContent(buffer);
            byteContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
                    var result = client.PostAsync(url, byteContent).Result;
                    if (!result.IsSuccessStatusCode) return new T();
                    var jsonString = await result.Content.ReadAsStringAsync();

                    return JsonConvert.DeserializeObject<T>(jsonString);
                }
            }
            catch (Exception ex)
            {
                return new T();
                throw;
            }
        }

        public async Task<List<BuscadorYFiltrosModel>> ObtenerBuscadorDesdeApi(string path)
        {
            var resultados = new List<BuscadorYFiltrosModel>();
            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var httpResponse = await httpClient.GetAsync(path);

                if (!httpResponse.IsSuccessStatusCode) return resultados;
                var jsonString = await httpResponse.Content.ReadAsStringAsync();

                var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

                /*resultados.AddRange(list.Select(item => new BuscadorYFiltrosModel
                {
                    CUV = item.CUV,
                    SAP = item.SAP,
                    Imagen = item.Imagen,
                    Descripcion = item.Descripcion,
                    Valorizado = item.Valorizado,
                    Precio = item.Precio,
                    MarcaId = item.MarcaId,
                    TipoPersonalizacion = item.TipoPersonalizacion,
                    CodigoEstrategia = item.CodigoEstrategia,
                    CodigoTipoEstrategia = item.CodigoTipoEstrategia,
                    TipoEstrategiaId = item.TipoEstrategiaId,
                    LimiteVenta = item.LimiteVenta,
                    Stock = item.Stock,
                    URLBsucador = path,
                    EstrategiaID = item.EstrategiaID
                }));*/
            }

            return resultados;
        }


    }
}