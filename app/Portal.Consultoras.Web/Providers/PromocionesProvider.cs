using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Search.ResponsePromociones;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class PromocionesProvider
    {
        private const string contentType = "application/json";
        private static readonly HttpClient httpClientMicroserviceSearch = new HttpClient();

        static PromocionesProvider()
        {
            if (!string.IsNullOrEmpty(WebConfig.UrlMicroservicioPersonalizacionSearch)) SetHttpClientMicroserviceSearch();
        }

        private static void SetHttpClientMicroserviceSearch()
        {
            httpClientMicroserviceSearch.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
            httpClientMicroserviceSearch.DefaultRequestHeaders.Accept.Clear();
            httpClientMicroserviceSearch.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(contentType));
        }

        public OutputPromociones GetPromociones(string codigoIsoPais, string campania, string cuv)
        {
            var estrategia = new OutputPromociones();
            var jsonString = string.Empty;

            var urlPromociones = string.Format(Constantes.PersonalizacionOfertasService.Promociones.UrlGetPromociones,
              codigoIsoPais,
              campania,
              cuv
              );

            using (var httpResponse =  httpClientMicroserviceSearch.GetAsync(urlPromociones).Result)
            {
                if (!httpResponse.IsSuccessStatusCode) return estrategia;
                jsonString =  httpResponse.Content.ReadAsStringAsync().Result;
                if (string.IsNullOrWhiteSpace(jsonString)) return estrategia;
            }

            estrategia = JsonConvert.DeserializeObject<OutputPromociones>(jsonString);
            estrategia = estrategia  ?? new OutputPromociones();

            return estrategia;
        }
    }
}