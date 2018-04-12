namespace Portal.Consultoras.Entities.Estrategia
{
    using System.Runtime.Serialization;
    using System.ComponentModel.DataAnnotations.Schema;
    public class EstrategiaProductoSet
    {
        [DataMember]
        [Column("TipoEstrategia")]
        public string TipoEstrategia { get; set; }
        [DataMember]
        [Column("Marca")]
        public string Marca { get; set; }
        [DataMember]
        [Column("CodigoProducto")]
        public int CodigoProducto { get; set; }
        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }
        [DataMember]
        [Column("NombreProducto")]
        public string NombreProducto { get; set; }
        [DataMember]
        [Column("Precio")]
        public decimal Precio { get; set; }
        [DataMember]
        [Column("PrecioOferta")]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        [Column("ImagenNormal")]
        public string ImagenNormal { get; set; }
        [DataMember]
        [Column("ImagenMiniatura")]
        public string ImagenMiniatura { get; set; }
    }
}
