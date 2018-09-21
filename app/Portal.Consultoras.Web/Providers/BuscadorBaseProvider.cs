
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorBaseProvider
    {
        public async Task<List<BuscadorYFiltrosModel>> ObtenerBuscadorDesdeApi(string path)
        {
            var resultados = new List<BuscadorYFiltrosModel>();
            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var httpResponse = await httpClient.GetAsync(path);

                if (httpResponse.IsSuccessStatusCode)
                {
                    var jsonString = await httpResponse.Content.ReadAsStringAsync();

                    var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

                    foreach (var item in list)
                    {
                        try
                        {
                            BuscadorYFiltrosModel buscador = new BuscadorYFiltrosModel
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
                            };

                            resultados.Add(buscador);
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                    }
                }
            }
          
            return resultados;
        }

     
    }
}