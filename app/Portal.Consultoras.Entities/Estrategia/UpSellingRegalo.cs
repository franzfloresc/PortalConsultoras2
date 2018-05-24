
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Estrategia
{
    [DataContract]
    public class UpSellingRegalo
    {
        [DataMember]
        [Column("CampaniaId")]
        public int CampaniaId { get; set; }

        [DataMember]
        [Column("ConsultoraId")]
        public int ConsultoraId { get; set; }

        [DataMember]
        [Column("MontoPedido")]
        public decimal MontoPedido { get; set; }

        [DataMember]
        [Column("GapMinimo")]
        public decimal GapMinimo { get; set; }

        [DataMember]
        [Column("GapMaximo")]
        public decimal GapMaximo { get; set; }

        [DataMember]
        [Column("GapAgregar")]
        public decimal GapAgregar { get; set; }

        [DataMember]
        [Column("MontoMeta")]
        public decimal MontoMeta { get; set; }

        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }

        [DataMember]
        [Column("TipoRango")]
        public string TipoRango { get; set; }

        [DataMember]
        [Column("MontoPedidoFinal")]
        public decimal MontoPedidoFinal { get; set; }

        [DataMember]
        [Column("UpSellingDetalleId")]
        public int UpSellingDetalleId { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [DataMember]
        [Column("RegaloDescripcion")]
        public string RegaloDescripcion { get; set; }

        [DataMember]
        [Column("RegaloImagenUrl")]
        public string RegaloImagenUrl { get; set; }
    }
}
