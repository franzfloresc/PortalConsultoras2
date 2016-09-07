using System.Web.Script.Serialization;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.ServiceCatalogoPersonalizado.Data;
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
using Portal.Consultoras.ServiceCatalogoPersonalizado.Utils;

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
            
            var listaFinal = new List<Producto>();

            if (tipoOfertaFinal == 1)
            {
                try
                {
                    var blProducto = new BLProducto();
                    listaCuvMostrar = blProducto.ObtenerProductosMostrar(codigoIso, campaniaId, codigoConsultora, zonaId, codigoRegion, codigoZona);
                    
                    listaFinal = GetListaFinal(codigoIso, listaCuvMostrar, tipoProductoMostrar, campaniaId, codigoConsultora, tipoOfertaFinal, true);                 
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

                    listaCuvMostrar = ObtenerProductosJetlore(codigoIso, codigoConsultora, campaniaId);

                    #endregion

                    listaFinal = GetListaFinal(codigoIso, listaCuvMostrar, tipoProductoMostrar, campaniaId, codigoConsultora, tipoOfertaFinal, true);
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

                    listaCuvMostrar = ObtenerProductosJetlore(codigoIso, codigoConsultora, campaniaId);

                    listaFinal = GetListaFinal(codigoIso, listaCuvMostrar, tipoProductoMostrar, campaniaId, codigoConsultora, tipoOfertaFinal, false);

                    #endregion
                }
            }
            catch (Exception ex)
            {
                listaFinal = new List<Producto>();
            }            

            return listaFinal;
        }

        public List<Producto> ObtenerProductosJetlore(string codigoIso, string codigoConsultora, int campaniaId)
        {
            var listaCuvMostrar = new List<Producto>();
            //Datos de Prueba para Jetlore

            //listaCuvMostrar.Add(new Producto { CampaniaId = 201613, CodigoIso = "PE", CodigoSap = "200067349", Cuv = "00724" });
            //listaCuvMostrar.Add(new Producto { CampaniaId = 201613, CodigoIso = "PE", CodigoSap = "200064582", Cuv = "00777" });
            //listaCuvMostrar.Add(new Producto { CampaniaId = 201613, CodigoIso = "PE", CodigoSap = "210077626", Cuv = "00834" });
            //listaCuvMostrar.Add(new Producto { CampaniaId = 201613, CodigoIso = "PE", CodigoSap = "210077627", Cuv = "00836" });

            var url = ConfigurationManager.AppSettings.Get("RutaProductosJetlore") ?? "";
            var bpais = "BELCORP_" + codigoIso;
            var hash = ConfigurationManager.AppSettings.Get("ClientHashJetlore") ?? "";

            var limiteProductos = ConfigurationManager.AppSettings.Get("LimiteProductosJetlore") ?? "";

            url += "?cid=" + hash;
            url += "&id=" + codigoConsultora;
            url += "&limit=" + limiteProductos;
            url += "&feed=" + bpais;
            url += "&div=" + campaniaId;
            //url += "&campaign=201612";

            string rtpaJson;
            using (WebClient sv = new WebClient())
            {
                rtpaJson = sv.DownloadString(url);
            }

            var listaProductosJetlore = new JavaScriptSerializer().Deserialize<ProductoJetlore>(rtpaJson);

            foreach (var producto in listaProductosJetlore.deals)
            {
                if (!string.IsNullOrEmpty(producto.id))
                {
                    var productoMostrar = new Producto();
                    productoMostrar.Cuv = producto.id;
                    productoMostrar.NombreComercial = producto.title;
                    productoMostrar.Imagen = producto.img;
                    productoMostrar.CodigoSap = ObtenerSap(codigoIso, campaniaId, productoMostrar.Cuv);

                    listaCuvMostrar.Add(productoMostrar);
                }
            }

            return listaCuvMostrar;
        } 

        private List<Producto> GetListaFinal(string codigoIso, List<Producto> listaCuvMostrar, int tipoProductoMostrar, int campaniaId, 
            string codigoConsultora, int tipoOfertaFinal, bool tieneValidacionPedido)
        {
            //codigoIso: PE,CL,CO, etc.
            //listaCuvMostrar: lista de cuv disponibles para mostrar
            //tipoProductoMostrar: 1 -> App Catalogo; 2 -> PCM
            //campaniaId: 201612,201613, etc.
            //codigoConsultora: 000758833
            //tipoOfertaFinal: 1 -> ARP; 2 -> Jetlore  
            //tieneValidacionPedido: true->valida que no exista en pedido; false: no valida con pedido                             

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

            //Jetlore
            if (tieneValidacionPedido && tipoOfertaFinal == 2)
                listaCuvMostrarConStock = ObtenerProductosMostrarSinPedido(codigoIso, listaCuvMostrarConStock, campaniaId, codigoConsultora);

            listaFinal = ObtenerProductosFinalesMostrar(listaCuvMostrarConStock, listaProductosHistorial);

            if (tipoProductoMostrar == 1)
            {
                var rutaImagenAppCatalogo = ConfigurationManager.AppSettings.Get("RutaImagenesAppCatalogo");
                listaFinal.Update(x => x.Imagen = string.Format(rutaImagenAppCatalogo, codigoIso, campaniaId, x.CodigoMarca, x.Imagen));
            }   

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

        public List<Producto> ObtenerProductosMostrarSinPedido(string codigoIso, List<Producto> listaCuvMostrar, int campaniaId, string codigoConsultora)
        {
            var listaCuvMostrarSinPedido = new List<Producto>();
            var listaCuvPedido = new List<Producto>();
            var blProducto = new BLProducto();

            listaCuvPedido = blProducto.ObtenerProductosPedido(codigoIso, campaniaId, codigoConsultora);

            foreach (var producto in listaCuvMostrar)
            {
                var item = listaCuvPedido.FirstOrDefault(p => p.Cuv == producto.Cuv);

                if (item == null)
                {
                    listaCuvMostrarSinPedido.Add(producto);
                }
            }

            return listaCuvMostrarSinPedido;
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
            string urlAuthorizationServer = "https://10.12.6.218:9002";
            string urlAuthorizationPath = "/authorizationserver/oauth";
            string urlService = "https://10.12.6.218:9002/belcorpstorewebservices/v1/belcorpsitePE/belcorpstore/products/export/full";

            var auth = new AuthConnection();
            auth.UrlAuthorizationServer = urlAuthorizationServer;
            auth.ClientId = clientId;
            auth.ClientSecret = clientSecret;

            auth.AuthorizationPath = urlAuthorizationPath;
            const string formatoTokenPath = "{0}/token?client_id={1}&client_secret={2}&grant_type={3}";
            //string formatoTokenPath = "/authorizationserver/oauth/token?client_id=ws_pe_lbel&client_secret=peru1234&grant_type=client_credentials";
            string tokenPath = string.Format(formatoTokenPath, urlAuthorizationPath, clientId, clientSecret, grantType);
            auth.TokenPath = tokenPath;            

            var productos = auth.GetResultFromWebService(urlService);

            var listaProductoPcm = new JavaScriptSerializer().Deserialize<ProductoPcm>(productos);
            string rutaInicialImagenPcm = ConfigurationManager.AppSettings.Get("RutaInicialImagenPcm") ?? "";

            listaProductoPcm.products[0].code = "200067349";
            listaProductoPcm.products[1].code = "200064582";
            listaProductoPcm.products[2].code = "210077626";
            listaProductoPcm.products[3].code = "210077627";

            foreach (var item in listaProductoPcm.products)
            {
                var productoMostrar = new Producto();

                productoMostrar.CodigoSap = item.code;
                string cuv = ObtenerCuv(codigoIso, campaniaId, item.code);

                if (!string.IsNullOrEmpty(cuv))
                {                  
                    string rutaImagen = "";

                    foreach (var imagen in item.images)
                    {
                        if (imagen.format == "product")
                        {
                            rutaImagen = imagen.url;
                            break;
                        }                        
                    }

                    if (!string.IsNullOrEmpty(rutaImagen))
                    {
                        productoMostrar.NombreComercial = item.name;
                        productoMostrar.Cuv = cuv;
                        productoMostrar.Imagen = rutaInicialImagenPcm + rutaImagen;

                        lista.Add(productoMostrar);   
                    }                    
                }                
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

        public string ObtenerCuv(string codigoIso, int campaniaId, string codigoSap)
        {
            string resultado = "";

            var BLProducto = new BLProducto();

            resultado = BLProducto.ObtenerCuvByCodigoSap(codigoIso, campaniaId, codigoSap);

            return resultado;
        }

        public string ObtenerSap(string codigoIso, int campaniaId, string cuv)
        {
            string resultado = "";

            var BLProducto = new BLProducto();

            resultado = BLProducto.ObtenerSapByCuv(codigoIso, campaniaId, cuv);

            return resultado;
        }
    }
}
