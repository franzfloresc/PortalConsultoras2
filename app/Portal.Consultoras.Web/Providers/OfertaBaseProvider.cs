﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaBaseProvider
    {
        private readonly static HttpClient httpClient = new HttpClient();

        public async Task<List<BEEstrategia>> ObtenerOfertasDesdeApi(string paisIso, int campaniaId, string codigoConsultora, string tipoEstrategia, DateTime fechaInicioCampania = default(DateTime))
        {
            var estrategias = new List<BEEstrategia>();

            var diaInicio = DateTime.Now.Date.Subtract(fechaInicioCampania.Date).Days;

            var path = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerOfertasDelDia, paisIso, tipoEstrategia, campaniaId, codigoConsultora, diaInicio);

            var httpResponse = await httpClient.GetAsync(path);

            if (httpResponse.IsSuccessStatusCode)
            {
                var jsonString = await httpResponse.Content.ReadAsStringAsync();

                var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

                foreach (var item in list)
                {
                    var estrategia = new BEEstrategia
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
                        FlagNueva = 0,
                        TipoEstrategiaImagenMostrar = 6
                    };

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
                foreach (var item in temp)
                {
                    if (!string.IsNullOrEmpty(item))
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