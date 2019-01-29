using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Producto
{
    [DataContract]
    public class BEProductoRecomendado
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string FotoProductoSmall { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        public decimal PrecioCatalogo { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string DescripcionMarca { get; set; }
        [DataMember]
        public string TipoPersonalizacion { get; set; }
        [DataMember]
        public int CodigoEstrategia { get; set; }
        [DataMember]
        public string CodigoTipoEstrategia { get; set; }
        [DataMember]
        public int TipoEstrategiaID { get; set; }
        [DataMember]
        public int LimiteVenta { get; set; }
        [DataMember]
        public bool Stock { get; set; }
        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }
        [DataMember]
        public int OrigenPedidoWeb { get; set; }
    }
}
