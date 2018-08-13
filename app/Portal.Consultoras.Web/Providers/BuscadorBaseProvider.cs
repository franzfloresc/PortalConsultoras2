
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
        //private readonly static HttpClient httpClient = new HttpClient();

        //public BuscadorBaseProvider()
        //{
        //    httpClient.BaseAddress = new Uri(WebConfig.RutaServiceBuscadorAPI);
        //    httpClient.DefaultRequestHeaders.Accept.Clear();
        //    httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        //}

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
                                LimiteVenta = item.LimiteVenta,
                                Stock = item.Stock
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
            //var httpResponse = await httpClient.GetAsync(path);

            //if (httpResponse.IsSuccessStatusCode)
            //{
            //    var jsonString = await httpResponse.Content.ReadAsStringAsync();

            //    var list = JsonConvert.DeserializeObject<List<dynamic>>(jsonString);

            //    foreach (var item in list)
            //    {
            //        try
            //        {
            //            BuscadorYFiltrosModel buscador = new BuscadorYFiltrosModel
            //            {
            //                CUV = item.CUV,
            //                SAP = item.SAP,
            //                Imagen = item.Imagen,
            //                Descripcion = item.Descripcion,
            //                Valorizado = item.Valorizado,
            //                Precio = item.Precio,
            //                MarcaId = item.MarcaId,
            //                TipoPersonalizacion = item.TipoPersonalizacion,
            //                CodigoEstrategia = item.CodigoEstrategia,
            //                CodigoTipoEstrategia = item.CodigoTipoEstrategia,
            //                LimiteVenta = item.LimiteVenta,
            //                Stock = item.Stock                            
            //            };

            //            resultados.Add(buscador);
            //        }
            //        catch (Exception ex)
            //        {
            //            throw ex;
            //        }
            //    }
            //}
            return resultados;
        }

        //private readonly string _serviceUrl = Globals.RutaServiceBuscadorAPI;

        //public string urlClient(UsuarioModel userData, BuscadorModel buscadorModel)
        //{

        //    var urlClient = string.Format(
        //        "Buscador/{0}/{1}/{2}/{3}/{4}/{5}/{6}/{7}/{8}/{9}/{10}/{11}/{12}",
        //        userData.CodigoISO,
        //        userData.CampaniaID,
        //        userData.CodigoConsultora,
        //        userData.CodigoZona,
        //        buscadorModel.TextoBusqueda,
        //        buscadorModel.CantidadProductos,
        //        buscadorModel.SociaEmpresaria,
        //        buscadorModel.SuscripcionActiva,
        //        buscadorModel.MDO,
        //        buscadorModel.RD,
        //        buscadorModel.RDI,
        //        buscadorModel.RDR,
        //        buscadorModel.DiaFacturacion
        //        );

        //    urlClient = _serviceUrl + urlClient;
        //    return urlClient;
        //}
    }
}