using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Portal.Consultoras.ServiceCatalogoPersonalizado.Data;
using Portal.Consultoras.ServiceCatalogoPersonalizado.Entities;

namespace Portal.Consultoras.ServiceCatalogoPersonalizado.Logic
{
    public class BLProducto
    {
        public List<Producto> ObtenerProductosMostrar(string codigoIso, int campaniaId, string codigoConsultora,
            int zonaId, string codigoRegion, string codigoZona)
        {
            var listaProducto = new List<Producto>();
            var daProducto = new DAProducto(codigoIso);

            using (IDataReader reader = daProducto.ObtenerProductosMostrar(campaniaId, codigoConsultora, zonaId, codigoRegion, codigoZona))
                while (reader.Read())
                {
                    var entidad = new Producto(reader);
                    listaProducto.Add(entidad);
                }

            return listaProducto;
        }

        public List<Producto> ObtenerProductosHistorialAppCatalogo(string codigoIso, int campaniaId)
        {
            var listaProducto = new List<Producto>();
            var daProducto = new DAProducto("");

            using (IDataReader reader = daProducto.ObtenerProductosHistorialAppCatalogo(codigoIso, campaniaId))
                while (reader.Read())
                {
                    var entidad = new Producto(reader);
                    listaProducto.Add(entidad);
                }

            return listaProducto;
        }

        public string ObtenerCuvByCodigoSap(string codigoIso, int campaniaId, string codigoSap)
        {
            var DAProducto = new DAProducto(codigoIso);

            return DAProducto.ObtenerCuvByCodigoSap(campaniaId, codigoSap);
        }
        
    }
}