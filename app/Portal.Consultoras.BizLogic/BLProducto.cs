using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLProducto
    {
        public List<BEProductoDescripcion> GetProductoDescripcionByCUVandCampania(int paisID, int campaniaID, string CUV)
        {
            List<BEProductoDescripcion> productoDescripcion = new List<BEProductoDescripcion>();
            var DAProductoDescripcion = new DAProductoDescripcion(paisID);

            using (IDataReader reader = DAProductoDescripcion.GetProductoDescripcionByCUVandCampania(CUV, campaniaID))
            {
                while (reader.Read())
                {
                    var prod = new BEProductoDescripcion(reader);
                    productoDescripcion.Add(prod);
                }
            }
            return productoDescripcion;
        }
        public IList<BEProductoDescripcion> GetProductoComercialByPaisAndCampania(int CampaniaID, string codigo, int PaisID, int rowCount)
        {
            var productos = new List<BEProductoDescripcion>();
            var DAProducto = new DAProducto(PaisID);

            using (IDataReader reader = DAProducto.GetProductoComercialByPaisAndCampania(CampaniaID, PaisID))
                while (reader.Read())
                {
                    var prod = new BEProductoDescripcion(reader);
                    prod.PaisID = PaisID;
                    productos.Add(prod);
                }

            return (from venta in productos
                    where venta.CUV.Contains(codigo)
                    select venta).Take(rowCount).ToList();
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcion(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount)
        {
            IList<BEProducto> productos;
            if (true) //TODO: Validar cache
            {
                productos = new List<BEProducto>();
                var DAProducto = new DAProducto(paisID);

                using (IDataReader reader = DAProducto.GetProductoComercialByCampania(campaniaID))
                {
                    while (reader.Read())
                    {
                        productos.Add(new BEProducto(reader));
                    }
                }
            }

            var productosSel = new List<BEProducto>();
            int count = 0;
            foreach (BEProducto producto in productos)
            {
                if (criterio == 1 && producto.CUV.Contains(codigoDescripcion)
                    || criterio == 2 && producto.Descripcion.ToUpper().Contains(codigoDescripcion.ToUpper()))
                {
                    productosSel.Add(producto);
                    count++;
                    if (count >= rowCount)
                        break;
                }
            }

            return (from producto in productosSel
                    orderby (criterio == 1 ? producto.CUV : producto.Descripcion)
                    select producto).ToList();
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcionSearch(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoComercialByCampaniaBySearch(campaniaID, rowCount, criterio, codigoDescripcion))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return (from producto in productos
                    orderby (criterio == 1 ? producto.CUV : producto.Descripcion)
                    select producto).ToList();
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcionSearchRegionZona(int paisID, int campaniaID, string codigoDescripcion, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona, int criterio, int rowCount, bool validarOpt)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoComercialByCampaniaBySearchRegionZona(campaniaID, rowCount, criterio, codigoDescripcion,RegionID,ZonaID, CodigoRegion, CodigoZona, validarOpt))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return (from producto in productos
                    orderby (criterio == 1 ? producto.CUV : producto.Descripcion)
                    select producto).ToList();
        }

        public IList<BEProducto> SelectProductoByListaCuvSearchRegionZona(int paisID, int campaniaID, string listaCuv, int regionID, int zonaID, string codigoRegion, string codigoZona, bool validarOpt)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoComercialByCampaniaBySearchRegionZonaListaCuv(campaniaID, listaCuv, regionID, zonaID, codigoRegion, codigoZona, validarOpt))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return (from producto in productos
                    orderby producto.CUV
                    select producto).ToList();
        }
        
        public IList<BEProducto> GetProductoComercialByListaCuv(int paisID, int campaniaID, int regionID, int zonaID, string codigoRegion, string codigoZona, string listaCuv)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoComercialByListaCuv(campaniaID, regionID, zonaID, codigoRegion, codigoZona, listaCuv))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }

        public int UpdProductoDescripcion(BEProductoDescripcion producto, string codigoUsuario)
        {
            var DAProductoDescripcion = new DAProductoDescripcion(producto.PaisID);
            return DAProductoDescripcion.UpdProductoDescripcion(producto, codigoUsuario);
        }

        public IList<BEProductoDescripcion> GetProductosByCampaniaCuv(int paisID, int anioCampania, string codigoVenta)
        {
            var productos = new List<BEProductoDescripcion>();
            var DAProductoComercial = new DAProductoDescripcion(paisID);

            using (IDataReader reader = DAProductoComercial.GetProductosByCampaniaCuv(anioCampania, codigoVenta))
                while (reader.Read())
                {
                    var producto = new BEProductoDescripcion(reader);
                    productos.Add(producto);
                }

            return productos;
        }

        public BEProductoDescripcion GetProductoByCampaniaCuv(int paisID, int anioCampania, string codigoZona, string codigoVenta)
        {
            BEProductoDescripcion beProductoDescripcion = null;
            var daProductoComercial = new DAProductoDescripcion(paisID);

            using (IDataReader reader = daProductoComercial.GetProductoByCampaniaCuv(anioCampania, codigoZona, codigoVenta))
                if (reader.Read())
                {
                    beProductoDescripcion = new BEProductoDescripcion(reader);
                }

            return beProductoDescripcion;
        }

        #region Producto Sugerido

        public IList<BEProducto> GetProductoSugeridoByCUV(int paisID, int campaniaID, int consultoraID, string cuv, int regionID, int zonaID, string codigoRegion, string codigoZona)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoSugeridoByCUV(campaniaID, consultoraID, cuv, regionID, zonaID, codigoRegion, codigoZona))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }

        #endregion
        
        public IList<BEProducto> SelectProductoToKitInicio(int paisID, int campaniaID, string cuv)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.SelectProductoToKitInicio(campaniaID, cuv))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }

        public string GetNombreProducto048ByCuv(int paisID, int campaniaID, string cuv)
        {
            var DAProducto = new DAProducto(paisID);
            return DAProducto.GetNombreProducto048ByCuv(campaniaID, cuv);
        }

        public IList<BEProductoAppCatalogo> GetNombreProducto048ByListaCUV(int paisID, int campaniaID, string listaCUV)
        {
            IList<BEProductoAppCatalogo> productos = new List<BEProductoAppCatalogo>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetNombreProducto048ByListaCUV(campaniaID, listaCUV))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProductoAppCatalogo(reader));
                }
            }

            return productos;
        }

        //PL20-1237
        public int InsProductoCompartido(BEProductoCompartido ProComp)
        {
            var DAProducto = new DAProducto(ProComp.PaisID);
            return DAProducto.InsProductoCompartido(ProComp);
        }

        public BEProductoCompartido GetProductoCompartido(int paisID, int ProCompID)
        {
            BEProductoCompartido ProComp = null;
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoCompartido(ProCompID))
            {
                if (reader.Read())
                {
                    ProComp = new BEProductoCompartido(reader);
                }
            }

            return ProComp;
        }

        public IList<BEProducto> GetListBrothersByCUV(int paisID, int codCampania, string cuv)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetListBrothersByCUV(codCampania, cuv))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }

            return productos;
        }
    }
}
