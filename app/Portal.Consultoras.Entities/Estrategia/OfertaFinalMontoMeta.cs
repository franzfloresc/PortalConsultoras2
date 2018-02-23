using System; 
using System.ComponentModel.DataAnnotations.Schema; 
using System.Runtime.Serialization; 

namespace Portal.Consultoras.Entities.Estrategia
{
    public class OfertaFinalMontoMeta
    {
        [DataMember]
        [Column("Campania")]
        public string Campania { get; set; }

        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }

        [DataMember]
        [Column("Nombre")]
        public string Nombre { get; set; }

        [DataMember]
        [Column("CuvRegalo")]
        public string CuvRegalo { get; set; }

        [DataMember]
        [Column("NombreRegalo")]
        public string NombreRegalo { get; set; }

        [DataMember]
        [Column("MontoMeta")]
        public decimal MontoMeta { get; set; }

        [DataMember]
        [Column("MontoPedido")]
        public decimal MontoPedido { get; set; }

        [DataMember]
        [Column("FechaRegistro")]
        public DateTime? FechaRegistro { get; set; }

    }
}
