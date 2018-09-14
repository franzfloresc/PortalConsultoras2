using   Newtonsoft.Json;
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

        public static async Task<List<ServiceOferta.BEEstrategia>> ObtenerOfertasDesdeApi(string path, string codigoISO)
        {
            var estrategias = new List<ServiceOferta.BEEstrategia>();
            var httpResponse = await httpClient.GetAsync(path);

            if (httpResponse.IsSuccessStatusCode)
            {
                var jsonString = await httpResponse.Content.ReadAsStringAsync();

                var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);
                var listaCuvPrecio0 = new List<string>();
                string codTipoEstrategia = "", codCampania = "";

                foreach (var item in list)
                {
                    try
                    {
                        ServiceOferta.BEEstrategia estrategia = new ServiceOferta.BEEstrategia
                        {
                            CampaniaID = item.codigoCampania,
                            CodigoEstrategia = item.codigoEstrategia,
                            CodigoProducto = item.codigoProducto,
                            CUV2 = item.cuV2,
                            DescripcionCUV2 = item.descripcionCUV2,
                            DescripcionEstrategia = item.descripcionTipoEstrategia,
                            DescripcionMarca = item.marcaDescripcion,
                            EstrategiaID = Convert.ToInt32(item.estrategiaId),
                            FlagNueva = Convert.ToBoolean(item.flagNueva) ? 1 : 0,
                            FlagRevista = Convert.ToBoolean(item.flagRevista) ? 1 : 0,
                            FotoProducto01 = item.imagenURL,
                            ImagenURL = item.imagenEstrategia,
                            IndicadorMontoMinimo = Convert.ToInt32(item.indicadorMontoMinimo),
                            LimiteVenta = Convert.ToInt32(item.limiteVenta),
                            MarcaID = Convert.ToInt32(item.marcaId),
                            Orden = Convert.ToInt32(item.orden),
                            Precio = Convert.ToDecimal(item.precio),
                            Precio2 = Convert.ToDecimal(item.precio2),
                            PrecioString = Util.DecimalToStringFormat((decimal)item.precio2, codigoISO),
                            PrecioTachado = Util.DecimalToStringFormat((decimal)item.precio, codigoISO),
                            GananciaString = Util.DecimalToStringFormat((decimal)item.ganancia, codigoISO),
                            Ganancia = Convert.ToDecimal(item.ganancia),
                            TextoLibre = item.textoLibre,
                            TieneVariedad = Convert.ToBoolean(item.tieneVariedad) ? 1 : 0,
                            TipoEstrategiaID = Convert.ToInt32(item.tipoEstrategiaId),
                            TipoEstrategiaImagenMostrar = 6,
                        };

                        estrategia.TipoEstrategia = new ServiceOferta.BETipoEstrategia { Codigo = item.codigoTipoEstrategia };
                        if (estrategia.Precio2 > 0)
                        {
                            estrategias.Add(estrategia);
                        }
                        else
                        {
                            listaCuvPrecio0.Add(estrategia.CUV2);
                            codTipoEstrategia = estrategia.CodigoTipoEstrategia;
                            codCampania = estrategia.CampaniaID.ToString();
                        }
                    }
                    catch (Exception ex)
                    {
                        Common.LogManager.SaveLog(ex, "", codigoISO);
                    }
                }

                if (listaCuvPrecio0.Any())
                {
                    try
                    {
                        string logPrecio0 = string.Format("Log Precios0 => Fecha:{0} /Palanca:{1} /CodCampania:{2} /CUV(s):{3} /Referencia:{4}", DateTime.Now, codTipoEstrategia, codCampania, string.Join("|", listaCuvPrecio0), path);
                        Common.LogManager.SaveLog(new Exception(logPrecio0), "", codigoISO);
                    }
                    catch(Exception ex) { throw ex; }
                }
                
            }
            return estrategias;
        }

        public async Task<List<BEEstrategiaProducto>> ObtenerComponenteDesdeApi(string path)
        {
            var estrategias = new List<BEEstrategiaProducto>();
            var httpResponse = await httpClient.GetAsync(path);

            if (httpResponse.IsSuccessStatusCode)
            {
                var jsonString = await httpResponse.Content.ReadAsStringAsync();

                var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

                foreach (var item in list)
                {
                    BEEstrategiaProducto estrategiaProducto = new BEEstrategiaProducto
                    {
                        Grupo = item.grupo,
                        CUV = item.cuv,
                        SAP = item.codigoSap,
                        Orden = item.orden,
                        Precio = item.precioUnitario,
                        Digitable = Convert.ToBoolean(item.indicadorDigitable) ? 1 : 0,
                        Cantidad = item.cantidad,
                        FactorCuadre = item.factorCuadre,
                        IdMarca= item.marcaId
                    };
                    estrategias.Add(estrategiaProducto);
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

        public bool UsarMsPersonalizacion(string pais, string tipoEstrategia)
        {
            bool paisHabilitado = WebConfig.PaisesMicroservicioPersonalizacion.Contains(pais);
            bool tipoEstrategiaHabilitado = WebConfig.EstrategiaDisponibleMicroservicioPersonalizacion.Contains(tipoEstrategia);
            return paisHabilitado && tipoEstrategiaHabilitado;
        }
    }
}