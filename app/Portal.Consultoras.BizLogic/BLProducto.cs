using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

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
        public IList<BEProductoDescripcion> GetProductoComercialByPaisAndCampania(int campaniaID, string codigo, int paisID, int rowCount)
        {
            var productos = new List<BEProductoDescripcion>();
            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoComercialByCampaniaAndCuv(campaniaID, codigo, rowCount))
            {
                while (reader.Read())
                {
                    var prod = new BEProductoDescripcion(reader);
                    prod.PaisID = paisID;
                    prod.CampaniaID = campaniaID;
                    productos.Add(prod);
                }
            }
            return productos;
        }

        public IList<BEProducto> SelectProductoByCodigoDescripcion(int paisID, int campaniaID, string codigoDescripcion, int criterio, int rowCount)
        {
            IList<BEProducto> productos = new List<BEProducto>();

            var DAProducto = new DAProducto(paisID);

            using (IDataReader reader = DAProducto.GetProductoComercialByCampania(campaniaID))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
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

        public IList<BEProducto> SearchListProductoChatbotByCampaniaRegionZona(string paisISO, int campaniaID,
            int regionID, int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int criterio, int rowCount)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            BEProducto producto = null;
            var dAProducto = new DAProducto(Util.GetPaisID(paisISO));
            var esEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(paisISO);

            using (IDataReader reader = dAProducto.SearchListProductoChatbotByCampaniaRegionZona(campaniaID,
                regionID, zonaID, codigoRegion, codigoZona, textoBusqueda, criterio, rowCount))
            {
                while (reader.Read())
                {
                    producto = new BEProducto(reader);
                    if((producto.CUVRevista ?? "").Trim() != "")
                    {
                        producto.MensajeEstaEnRevista1 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaWeb : Constantes.MensajeEstaEnRevista.LbelWeb;
                        producto.MensajeEstaEnRevista2 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaMobile : Constantes.MensajeEstaEnRevista.LbelMobile;
                    }
                    productos.Add(producto);
                }
            }
            return productos.OrderBy(p => criterio == 1 ? p.CUV : p.Descripcion).ToList();
        }

        public IList<BEProducto> SearchSmartListProductoByCampaniaRegionZonaDescripcion(string paisISO, int campaniaID,
            int zonaID, string codigoRegion, string codigoZona, string textoBusqueda, int rowCount)
        {
            IList<BEProducto> listProducto = new List<BEProducto>();
            var bLProductoPalabra = new BLProductoPalabra();            
            var listTextoCandidato = bLProductoPalabra.GetListCandidatoFromTexto(paisISO, campaniaID, textoBusqueda, 2, 1);
            if (listTextoCandidato.Count == 0) return listProducto;
            
            var paisID = Util.GetPaisID(paisISO);
            var dAProducto = new DAProducto(paisID);
            var esEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(paisISO);
            var listPalabra = bLProductoPalabra.GetListPalabraFromTexto(listTextoCandidato[0]).Select(p => p.ToLower()).ToList();

            listProducto = CacheManager<BEProducto>.GetData(paisID, ECacheItem.Producto, campaniaID.ToString());
            if (listProducto != null && listProducto.Count > 0)
            {
                listProducto = listProducto.Select(producto => new {
                    Producto = producto,
                    Repeticion = listPalabra.Count(palabra => producto.TextoBusqueda.ToLower().Contains(palabra))
                })
                    .Where(pp => pp.Repeticion > 0).OrderByDescending(pp => pp.Repeticion).ThenBy(pp => pp.Producto.CUV)
                    .Select(pp => pp.Producto).Take(rowCount).ToList();

                dAProducto.SetTieneStockByCampaniaAndZonaAndProductos(campaniaID, zonaID, codigoRegion, codigoZona, listProducto.ToList());
            }
            else
            {
                listProducto = new List<BEProducto>();
                using (IDataReader reader = dAProducto.GetByCampaniaAndZonaAndPalabras(campaniaID, zonaID, codigoRegion, codigoZona, rowCount, listPalabra))
                {
                    while (reader.Read()) listProducto.Add(new BEProducto(reader));
                }
            }

            listProducto.ToList().ForEach(p =>
            {
                if ((p.CUVRevista ?? "").Trim() != "")
                {
                    p.MensajeEstaEnRevista1 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaWeb : Constantes.MensajeEstaEnRevista.LbelWeb;
                    p.MensajeEstaEnRevista2 = esEsika ? Constantes.MensajeEstaEnRevista.EsikaMobile : Constantes.MensajeEstaEnRevista.LbelMobile;
                }
            });
            return listProducto;
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
