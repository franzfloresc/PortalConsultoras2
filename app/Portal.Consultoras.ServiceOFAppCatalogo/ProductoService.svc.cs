using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.ServiceCatalogoPersonalizado.Entities;
using Portal.Consultoras.ServiceCatalogoPersonalizado.Logic;
using Portal.Consultoras.ServiceCatalogoPersonalizado.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;

namespace Portal.Consultoras.ServiceCatalogoPersonalizado
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "ProductoService" en el código, en svc y en el archivo de configuración a la vez.
    // NOTA: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione ProductoService.svc o ProductoService.svc.cs en el Explorador de soluciones e inicie la depuración.
    public class ProductoService : IProductoService
    {
        public List<Producto> ObtenerProductos(int tipoOfertaFinal, string codigoIso, int campaniaId, string codigoConsultora, int zonaId,
            string codigoRegion, string codigoZona, int tipoProductoMostrar)
        {
            //tipoOfertaFinal: 1 -> ARP; 2 -> Jetlore
            //codigoIso: PE,CL,CO, etc.
            //campaniaId: 201612,201613, etc.
            //codigoConsultora: 000758833
            //tipoProductoMostrar: 1 -> App Catalogo; 2 -> PCM

            var listaCuvMostrar = new List<Producto>();
            var listaCuvMostrarConStock = new List<Producto>();
            var listaFinal = new List<Producto>();

            if (tipoOfertaFinal == 1)
            {
                try
                {
                    var blProducto = new BLProducto();
                    listaCuvMostrar = blProducto.ObtenerProductosMostrar(codigoIso, campaniaId, codigoConsultora, zonaId, codigoRegion, codigoZona);
                    
                    listaFinal = GetListaFinal(codigoIso, listaCuvMostrar, tipoProductoMostrar, campaniaId);

                    var rutaImagenAppCatalogo = ConfigurationManager.AppSettings.Get("RutaImagenesAppCatalogo");
                    listaFinal.Update(x => x.Imagen = string.Format(rutaImagenAppCatalogo, codigoIso, campaniaId, x.CodigoMarca, x.Imagen));
                }
                catch (Exception ex)
                {
                    listaFinal = new List<Producto>();
                }
            }
            else
            {
                try
                {
                    #region Obtener Listado de CUV de Jetlore
                    // listaCuvMostrar => mantener las mismas variable para la funccion GetListaFinal
                    listaCuvMostrar = new List<Producto>();
                    #endregion
                    
                    listaFinal = GetListaFinal(codigoIso, listaCuvMostrar, tipoProductoMostrar, campaniaId);
                }
                catch (Exception ex)
                {
                    listaFinal = new List<Producto>();
                }                          
            }

            return listaFinal;
        }

        public List<Producto> ObtenerTodosProductos(int tipoOfertaFinal, string codigoIso, int campaniaId, string codigoConsultora, int zonaId,
            string codigoRegion, string codigoZona, int tipoProductoMostrar, int limimte = 100)
        {
            //tipoOfertaFinal: 1 -> ARP; 2 -> Jetlore
            //codigoIso: PE,CL,CO, etc.
            //campaniaId: 201612,201613, etc.
            //codigoConsultora: 000758833
            //tipoProductoMostrar: 1 -> App Catalogo; 2 -> PCM

            var listaCuvMostrar = new List<Producto>();
            var listaCuvMostrarConStock = new List<Producto>();
            var listaFinal = new List<Producto>();

            try
            {
                if (tipoOfertaFinal == 1)
                {
                    #region Obtener Listado de CUV de ARP

                    //var blProducto = new BLProducto();
                    //listaCuvMostrar = blProducto.ObtenerProductosMostrar(codigoIso, campaniaId, codigoConsultora, zonaId, codigoRegion, codigoZona);

                    #endregion
                }
                else
                {
                    #region Obtener Listado de CUV de Jetlore

                    var url = ConfigurationManager.AppSettings["jetlore_CatalogoPersonalizado_url"] ?? "";
                    var bpais = "BELCORP_" + codigoIso;
                    var hash = ConfigurationManager.AppSettings["jetlore_CLIENT_HASH"] ?? "";

                    url += "?cid=" + hash;
                    url += "&id=" + codigoConsultora;
                    url += "&limit=" + limimte;
                    url += "&feed=" + bpais;
                    url += "&div=" + campaniaId;

                    //dynamic rtpaJson;
                    //using (WebClient sv = new WebClient())
                    //{
                    //    rtpaJson = sv.DownloadString(url);
                    //}
                    listaCuvMostrar = ObtenerProductosHistorial(tipoProductoMostrar, codigoIso, campaniaId);
                    #endregion
                }
            }
            catch (Exception ex)
            {
                listaFinal = new List<Producto>();
            }            
            
            listaFinal = GetListaFinal(codigoIso, listaCuvMostrar, tipoProductoMostrar, campaniaId);

            return listaFinal;
        }

        private List<Producto> GetListaFinal(string codigoIso, List<Producto> listaCuvMostrar, int tipoProductoMostrar, int campaniaId)
        {
            var listaFinal = new List<Producto>();

            var listaCuvMostrarConStock = ObtenerProductosMostrarConStock(codigoIso, listaCuvMostrar);

            List<Producto> listaProductosHistorial = tipoProductoMostrar == 1
                ? (List<Producto>)CacheManager<Producto>.GetData(codigoIso, campaniaId, ECacheItem.ListaProductoCatalogo)
                : (List<Producto>)CacheManager<Producto>.GetData(codigoIso, campaniaId, ECacheItem.ListaProductoCatalogoPcm);

            if (listaProductosHistorial == null || listaProductosHistorial.Count == 0)
            {
                listaProductosHistorial = ObtenerProductosHistorial(tipoProductoMostrar, codigoIso, campaniaId);
                if (tipoProductoMostrar == 1)
                    CacheManager<Producto>.AddData(codigoIso, campaniaId, ECacheItem.ListaProductoCatalogo, listaProductosHistorial);
                else
                    CacheManager<Producto>.AddData(codigoIso, campaniaId, ECacheItem.ListaProductoCatalogoPcm, listaProductosHistorial);
            }

            listaFinal = ObtenerProductosFinalesMostrar(listaCuvMostrarConStock, listaProductosHistorial);

            var rutaImagenAppCatalogo = ConfigurationManager.AppSettings.Get("RutaImagenesAppCatalogo");
            listaFinal.Update(x => x.Imagen = string.Format(rutaImagenAppCatalogo, codigoIso, campaniaId, x.CodigoMarca, x.Imagen));

            return listaFinal;
        }

        public List<Producto> ObtenerProductosMostrarConStock(string codigoIso, List<Producto> listaCuvMostrar)
        {
            var listaCuvMostrarConStock = new List<Producto>();

            /*Obtener si tiene stock de PROL por CodigoSAP*/
            string codigoSap = "";
            foreach (var beProducto in listaCuvMostrar)
                codigoSap += beProducto.CodigoSap + "|";

            var listaTieneStock = new List<Lista>();

            using (var sv = new wsConsulta())
            {
                sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                listaTieneStock = sv.ConsultaStock(codigoSap, codigoIso).ToList();
            }

            //para obtener los productos a mostrar con stock
            foreach (var beProducto in listaCuvMostrar)
            {
                var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beProducto.CodigoSap);

                if (itemStockProl != null)
                {
                    listaCuvMostrarConStock.Add(beProducto);
                }
            }

            return listaCuvMostrarConStock;
        }

        public List<Producto> ObtenerProductosHistorial(int tipoProductoMostrar, string codigoIso, int campaniaId)
        {
            var lista = new List<Producto>();

            lista = tipoProductoMostrar == 1 
                ? ObtenerProductosHistorialAppCatalogo(codigoIso, campaniaId)
                : ObtenerProductosHistorialPcm(codigoIso, campaniaId);

            return lista;
        }

        public List<Producto> ObtenerProductosHistorialAppCatalogo(string codigoIso, int campaniaId)
        {
            var lista = new List<Producto>();

            var blProducto = new BLProducto();

            lista = blProducto.ObtenerProductosHistorialAppCatalogo(codigoIso, campaniaId);

            return lista;
        }

        public List<Producto> ObtenerProductosHistorialPcm(string codigoIso, int campaniaId)
        {
            var lista = new List<Producto>();

            #region Obtener Listado Productos PCM

            string clientId = "ws_pe_lbel";
            string clientSecret = "peru1234";
            string grantType = "client_credentials";
            string urlAuth = "https://10.12.6.218:9002/authorizationserver/oauth";
            string urlService = "https://10.12.6.218:9002/belcorpstorewebservices/v1/belcorpsitePE/belcorpstore/products/export/full";

            string responseStringToken = string.Empty;
            string responseStringService = string.Empty;
 
            List<KeyValuePair<string, string>> postData = new List<KeyValuePair<string, string>>();
            postData.Add(new KeyValuePair<string, string>("client_id", clientId));
            postData.Add(new KeyValuePair<string, string>("client_secret", clientSecret));
            postData.Add(new KeyValuePair<string, string>("grant_type", grantType));

            HttpContent content = new FormUrlEncodedContent(postData);
            content.Headers.ContentType = new MediaTypeHeaderValue("application/x-www-form-urlencoded");

            using (HttpClient client = new HttpClient())
            {
                //Obtener el Token
                HttpResponseMessage responseResultToeken = client.PostAsync(urlAuth, content).Result;
                string result = responseResultToeken.Content.ReadAsStringAsync().Result;
                JObject obj = JObject.Parse(result);
                
                responseStringToken = (string)obj["access_token"];
            }

            using (HttpClient client = new HttpClient())
            {
                //Consumir el Servicio
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.Add("Authorization", "Bearer " + responseStringToken);

                HttpResponseMessage responseResultService = client.GetAsync(urlService).Result;
                string result = responseResultService.Content.ReadAsStringAsync().Result;
                JObject obj = JObject.Parse(result);

                responseStringService = (string)obj["products"];
            }

            #endregion

            return lista;
        }

        public List<Producto> ObtenerProductosFinalesMostrar(List<Producto> listaProductosMostrar, List<Producto> listaProductosHistorial)
        {
            var lista = new List<Producto>();

            foreach (var producto in listaProductosMostrar)
            {
                var item = listaProductosHistorial.FirstOrDefault(p => p.Cuv == producto.Cuv);

                if (item != null)
                    lista.Add(item);
            }

            return lista;
        }
    }
}
