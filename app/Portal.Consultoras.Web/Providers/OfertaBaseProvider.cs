using Newtonsoft.Json;
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

        public async Task<List<BEEstrategia>> ObtenerOfertasDesdeApi(string paisIso, string tipoEstrategia, int campaniaId, string codigoConsultora, int diaInicio)
        {
            var estrategias = new List<BEEstrategia>();

            var path = string.Empty;

            switch (tipoEstrategia)
            {
                case Constantes.ConfiguracionPais.OfertaDelDia:
                    path = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerOfertasDelDia, paisIso, tipoEstrategia, campaniaId, codigoConsultora, diaInicio);
                    break;
                default:
                    break;
            }
            
            var httpResponse = await httpClient.GetAsync(path);

            if (httpResponse.IsSuccessStatusCode)
            {
                var jsonString = await httpResponse.Content.ReadAsStringAsync();

                var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

                estrategias.AddRange(list.Select(item => new BEEstrategia
                    {
                        EstrategiaID = Convert.ToInt32(item.estrategiaId), 
                        CodigoEstrategia = item.codigoEstrategia, 
                        CUV2 = item.cuV2, 
                        DescripcionCUV2 = item.descripcionCUV2, 
                        Precio = Convert.ToDecimal(item.precio), 
                        Precio2 = Convert.ToDecimal(item.precio2), 
                        FotoProducto01 = item.imagenURL, 
                        ImagenURL = item.imagenEstrategia, 
                        LimiteVenta = Convert.ToInt32(item.limiteVenta), 
                        TextoLibre = item.textoLibre, 
                        MarcaID = Convert.ToInt32(item.marcaId), 
                        DescripcionMarca = item.marcaDescripcion, 
                        IndicadorMontoMinimo = Convert.ToInt32(item.indicadorMontoMinimo), 
                        CodigoProducto = item.codigoProducto, 
                        DescripcionEstrategia = item.descripcionTipoEstrategia, 
                        Orden = Convert.ToInt32(item.orden), 
                        TipoEstrategiaID = Convert.ToInt32(item.tipoEstrategiaId), 
                        FlagNueva = 0, TipoEstrategiaImagenMostrar = 6
                    }));
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