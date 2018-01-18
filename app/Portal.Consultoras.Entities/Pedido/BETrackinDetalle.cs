using System;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BETrackingDetalle
    {
        [DataMember]
        [Column("Campana")]
        public int Campana { get; set; }
        [DataMember]
        [Column("Etapa")]
        public int Etapa { get; set; }
        [DataMember]
        [Column("Situacion")]
        public string Situacion { get; set; }
        [DataMember]
        [Column("Fecha")]
        public DateTime? Fecha { get; set; }
        [DataMember]
        public string FechaFormatted { get; set; }
        [DataMember]
        public bool Alcanzado { get; set; }
        [DataMember]
        [Column("Observacion")]
        public string Observacion { get; set; }
    }
}
