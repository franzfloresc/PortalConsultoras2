using Portal.Consultoras.Common;
using Portal.Consultoras.Data.Rest.ServiceSicc;
using System;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Rest
{
    public static class DARSicc
    {
        private static HttpClient httpClient;
        private static RestClient restClient;

        private static RestClient RestClient
        {
            get
            {
                if (restClient != null) return restClient;

                restClient = new RestClient();
                return restClient;
            }
        }
        private static HttpClient HttpClient
        {
            get
            {
                if (httpClient != null) return httpClient;

                httpClient = new HttpClient();
                httpClient.BaseAddress = new Uri(ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.UrlServiceSicc]);
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                return httpClient;
            }
        }

        public static async Task<Pedido> EjecutarCuadreOfertas(Pedido inputPedido)
        {
            return await restClient.PostAsync<Pedido>(HttpClient, "/Service.svc/EjecutarCuadreOfertas", inputPedido);
        }
    }
}
