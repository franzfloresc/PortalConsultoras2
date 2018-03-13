using Portal.Consultoras.Web.Models;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class OfertaProductoPrincipalMobileModel
    {
        public string Simbolo { get; set; }
        public int OfertaProductoID { get; set; }
        public int CampaniaID { get; set; }
        public string CUV { get; set; }
        public int TipoOfertaSisID { get; set; }
        public int MarcaID { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioOferta { get; set; }
        public int Stock { get; set; }
        public string ImagenProducto { get; set; }
        public string ImagenProductoAnterior { get; set; }
        public int Orden { get; set; }
        public int UnidadesPermitidas { get; set; }
        public string CodigoCampania { get; set; }
        public int FlagHabilitarProducto { get; set; }
        public int FlagImagen { get; set; }
        public string DescripcionLegal { get; set; }
        public int PaisID { get; set; }
        public string ISOPais { get; set; }
        public string DescripcionMarca { get; set; }
        public string TallaColor { get; set; }
        public string DescripcionCategoria { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string CodigoTipoOferta { get; set; }
        public IEnumerable<AdministracionOfertaProductoModel> lstAdministracionOferta { get; set; }
        public IEnumerable<StockCargaLogModel> lstStockCarga { get; set; }
        public IEnumerable<ConfiguracionOfertaModel> lstConfiguracionOferta { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }
        public List<OfertaProductoMobilModel> listaProductosEnLiquidacion { get; set; }
    }
}