
namespace Portal.Consultoras.Entities.Producto
{
    public class BEBuscadorResponse
    {
        public string CUV { get; set; }
        public string SAP { get; set; }
        public string FotoProductoSmall { get; set; }
        public string Descripcion { get; set; }
        public double PrecioValorizado { get; set; }
        public double PrecioCatalogo { get; set; }
        public int MarcaID { get; set; }
        public string TipoPersonalizacion { get; set; }
        public int CodigoEstrategia { get; set; }
        public string CodigoTipoEstrategia { get; set; }
        public int TipoEstrategiaID { get; set; }
        public int LimiteVenta { get; set; }
        public bool Stock { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string OrigenPedidoWeb { get; set; }
        public int EstrategiaID { get; set; }
        public string OrigenPedidoWebFicha { get; set; }
    }
}
