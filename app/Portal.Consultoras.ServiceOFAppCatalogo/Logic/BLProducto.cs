using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Portal.Consultoras.ServiceOFAppCatalogo.Data;
using Portal.Consultoras.ServiceOFAppCatalogo.Entities;

namespace Portal.Consultoras.ServiceOFAppCatalogo.Logic
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

        public List<Producto> ObtenerProductosHistorialCatalogoPersonalizado(string codigoIso, int campaniaId)
        {
            var listaProducto = new List<Producto>();
            var daProducto = new DAProducto("");

            using (IDataReader reader = daProducto.ObtenerProductosHistorialCatalogoPersonalizado(codigoIso, campaniaId))
                while (reader.Read())
                {
                    var entidad = new Producto(reader);
                    listaProducto.Add(entidad);
                }

            return listaProducto;
        }        
    }
}