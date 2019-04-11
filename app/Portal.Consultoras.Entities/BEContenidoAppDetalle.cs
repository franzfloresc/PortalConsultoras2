using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppDetalle
    {
        [DataMember]
        [Column("IdContenidoDeta")]
        public int IdContenidoDeta { get; set; }

        [Column("IdContenido")]
        public int IdContenido { get; set; }

        [DataMember]
        [Column("CodigoDetalle")]
        public string CodigoDetalle { get; set; }

        [DataMember]
        [Column("RutaContenido")]
        public string RutaContenido { get; set; }

        [DataMember]
        [Column("Accion")]
        public string Accion { get; set; }

        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }

        [DataMember]
        [Column("Tipo")]
        public string Tipo { get; set; }

        [DataMember]
        [Column ("EstadoDetalle")]
        public bool EstadoDetalle { get; set; }

        [DataMember]
        [Column("ContenidoVisto")]
        public bool ContenidoVisto { get; set; }

        public BEContenidoAppDetalle() { }
    }
}