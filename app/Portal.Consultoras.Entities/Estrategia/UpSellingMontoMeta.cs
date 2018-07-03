using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Estrategia
{
    public class UpSellingMontoMeta
    {
        [DataMember]
        [Column("Campania")]
        public int Campania { get; set; }

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
        [Column("MontoInicial")]
        public decimal MontoInicial { get; set; }

        [DataMember]
        [Column("RangoInicial")]
        public decimal RangoInicial { get; set; }

        [DataMember]
        [Column("RangoFinal")]
        public decimal RangoFinal { get; set; }

        [DataMember]
        [Column("MontoAgregar")]
        public decimal MontoAgregar { get; set; }

        [DataMember]
        [Column("MontoMeta")]
        public decimal MontoMeta { get; set; }

        [DataMember]
        [Column("MontoGanador")]
        public decimal MontoGanador { get; set; }

        [DataMember]
        [Column("FechaRegistro")]
        public DateTime? FechaRegistro { get; set; }

        [DataMember]
        [Column("ImporteReal")]
        public decimal ImporteReal { get; set; }
    }
}
