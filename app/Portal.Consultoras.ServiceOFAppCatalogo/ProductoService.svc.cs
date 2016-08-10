using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using Portal.Consultoras.ServiceOFAppCatalogo.Entities;
using Portal.Consultoras.ServiceOFAppCatalogo.Logic;
using Portal.Consultoras.ServiceOFAppCatalogo.ServicePROLConsultas;

namespace Portal.Consultoras.ServiceOFAppCatalogo
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
            //tipoProductoMostrar: 1 -> Catalogo Personalizado; 2 -> PCM

            var listaCuvMostrar = new List<Producto>();
            var listaCuvMostrarConStock = new List<Producto>();

            if (tipoOfertaFinal == 1)
            {
                try
                {
                    var blProducto = new BLProducto();
                    listaCuvMostrar = blProducto.ObtenerProductosMostrar(codigoIso, campaniaId, codigoConsultora, zonaId, codigoRegion, codigoZona);

                    listaCuvMostrarConStock = ObtenerProductosMostrarConStock(codigoIso, listaCuvMostrar);                    

                    var listaProductosHistorial = ObtenerProductosHistorial(tipoProductoMostrar, codigoIso, campaniaId);

                }
                catch (Exception ex)
                {
                    listaCuvMostrarConStock = new List<Producto>();
                }
            }
            else
            {
                try
                {
                    #region Obtener Listado de CUV de Jetlore


                    #endregion
                    
                    listaCuvMostrarConStock = ObtenerProductosMostrarConStock(codigoIso, listaCuvMostrar);

                    var listaProductosHistorial = ObtenerProductosHistorial(tipoProductoMostrar, codigoIso, campaniaId);
                }
                catch (Exception ex)
                {
                    listaCuvMostrarConStock = new List<Producto>();
                }                          
            }

            return listaCuvMostrarConStock;
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
                ? ObtenerProductosHistorialCatalogoPersonalizado(codigoIso, campaniaId)
                : ObtenerProductosHistorialPcm(codigoIso, campaniaId);

            return lista;
        }

        public List<Producto> ObtenerProductosHistorialCatalogoPersonalizado(string codigoIso, int campaniaId)
        {
            var lista = new List<Producto>();

            var blProducto = new BLProducto();

            lista = blProducto.ObtenerProductosHistorialCatalogoPersonalizado(codigoIso, campaniaId);

            return lista;
        }

        public List<Producto> ObtenerProductosHistorialPcm(string codigoIso, int campaniaId)
        {
            var lista = new List<Producto>();

            #region Obtener Listado Productos PCM



            #endregion

            return lista;
        }
    }
}
