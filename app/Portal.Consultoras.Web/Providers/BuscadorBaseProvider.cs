﻿using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorBaseProvider
    {
        private const string contentType = "application/json";
        private readonly static HttpClient httpClientBuscador = new HttpClient();

        static BuscadorBaseProvider()
        {
            if (!string.IsNullOrEmpty(WebConfig.RutaServiceBuscadorAPI))
            {
                httpClientBuscador.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
                httpClientBuscador.DefaultRequestHeaders.Accept.Clear();
                httpClientBuscador.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(contentType));
            }
        }

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
            try
            {
                var dataJson = JsonConvert.SerializeObject(data);
                var stringContent = new StringContent(dataJson, Encoding.UTF8, contentType);
                var httpResponse = await httpClientBuscador.PostAsync(url, stringContent);

                if (httpResponse != null && httpResponse.IsSuccessStatusCode)
                {
                    var httpContent = await httpResponse.Content.ReadAsStringAsync();

                    var dataObject = JsonConvert.DeserializeObject<T>(httpContent);

                    return dataObject;
                }

                return new T();
            }
            catch (Exception ex)
            {
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