using System;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContrato
    {
        [Column("ConsultoraId")]
        public long ConsultoraId { get; set; }
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }
        [Column("AceptoContrato")]
        public int AceptoContrato { get; set; }
        [Column("FechaAceptacion")]
        public DateTime FechaAceptacion { get; set; }
        [Column("Origen")]
        public string Origen { get; set; }
        [Column("DireccionIP")]
        public string DireccionIP { get; set; }
        [Column("InformacionSOMobile")]
        public string InformacionSOMobile { get; set; }
    }
}