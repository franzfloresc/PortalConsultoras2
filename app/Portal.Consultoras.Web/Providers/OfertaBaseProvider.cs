﻿using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaBaseProvider
    {
        private readonly static HttpClient httpClient = new HttpClient();

        static OfertaBaseProvider()
        {
            httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionSearch);
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public async Task<List<BEEstrategia>> ObtenerOfertasDesdeApi(string path)
        {
            var estrategias = new List<BEEstrategia>();
            var httpResponse = await httpClient.GetAsync(path);

            if (httpResponse.IsSuccessStatusCode)
            {
                var jsonString = await httpResponse.Content.ReadAsStringAsync();

                var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

                foreach (var item in list)
                {

                    BEEstrategia estrategia = new BEEstrategia
                    {
                        CodigoEstrategia = item.codigoEstrategia,
                        CodigoProducto = item.codigoProducto,
                        CUV2 = item.cuV2,
                        DescripcionCUV2 = item.descripcionCUV2,
                        DescripcionEstrategia = item.descripcionTipoEstrategia,
                        DescripcionMarca = item.marcaDescripcion,
                        EstrategiaID = Convert.ToInt32(item.estrategiaId),
                        FlagNueva = 0,
                        FotoProducto01 = item.imagenURL,
                        ImagenURL = item.imagenEstrategia,
                        IndicadorMontoMinimo = Convert.ToInt32(item.indicadorMontoMinimo),
                        LimiteVenta = Convert.ToInt32(item.limiteVenta),
                        MarcaID = Convert.ToInt32(item.marcaId),
                        Orden = Convert.ToInt32(item.orden),
                        Precio = Convert.ToDecimal(item.precio),
                        Precio2 = Convert.ToDecimal(item.precio2),
                        PrecioString = item.precio2,
                        PrecioTachado = item.precio,
                        TextoLibre = item.textoLibre,
                        TieneVariedad = Convert.ToBoolean(item.tieneVariedad) ? 1 : 0,
                        TipoEstrategiaID = Convert.ToInt32(item.tipoEstrategiaId),
                        TipoEstrategiaImagenMostrar = 6,
                    };
                    estrategia.TipoEstrategia = new BETipoEstrategia { Codigo = item.codigoTipoEstrategia };
                    estrategias.Add(estrategia);
                }
            }
            return estrategias;
        }

        public string ObtenerDescripcionOferta(string descripcionCuv2)
        {
            var descripcionOdd = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                var temp = descripcionCuv2.Split('|').ToList();
                temp = temp.Skip(1).ToList();

                var txtBuil = new StringBuilder();
                foreach (var item in temp.Where(item => !string.IsNullOrEmpty(item)))
                {
                    txtBuil.Append(item.Trim() + "|");
                }

                descripcionOdd = txtBuil.ToString();
                descripcionOdd = descripcionOdd == string.Empty
                    ? string.Empty
                    : descripcionOdd.Substring(0, descripcionOdd.Length - 1);
                descripcionOdd = descripcionOdd.Replace("|", " +<br />");
                descripcionOdd = descripcionOdd.Replace("\\", "");
                descripcionOdd = descripcionOdd.Replace("(GRATIS)", "<b>GRATIS</b>");
            }
            return descripcionOdd;
        }

        public string ObtenerNombreOferta(string descripcionCuv2)
        {
            var nombreOferta = string.Empty;

            if (!string.IsNullOrWhiteSpace(descripcionCuv2))
            {
                nombreOferta = descripcionCuv2.Split('|').First();
            }
            return nombreOferta;
        }
    }
}