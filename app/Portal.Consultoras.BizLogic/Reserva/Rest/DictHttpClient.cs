using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;

namespace Portal.Consultoras.BizLogic.Reserva.Rest
{
    public class DictHttpClient
    {
        private readonly string mediaType;
        private readonly Dictionary<Enumeradores.RestService, HttpClient> dictClient;

        public DictHttpClient(string _mediaType)
        {
            mediaType = _mediaType;
            dictClient = new Dictionary<Enumeradores.RestService, HttpClient>();
        }

        private HttpClient Create(Enumeradores.RestService restServiceEnum)
        {
            string configKey;
            switch (restServiceEnum)
            {
                case Enumeradores.RestService.ReservaSicc: configKey = Constantes.ConfiguracionManager.UrlServiceSicc; break;
                default: configKey = ""; break;
            }

            var httpClient = new HttpClient();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(mediaType));
            httpClient.BaseAddress = new Uri(ConfigurationManager.AppSettings[configKey]);
            return httpClient;
        }

        public HttpClient Get(Enumeradores.RestService restServiceEnum)
        {
            if (!dictClient.ContainsKey(restServiceEnum)) dictClient.Add(restServiceEnum, Create(restServiceEnum));
            return dictClient[restServiceEnum];
        }
    }
}
