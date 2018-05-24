using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.RevistaDigital
{
    [DataContract]
    public class BERevistaDigitalSuscripcion : BaseEntidad
    {
        [DataMember]
        [Column("RevistaDigitalSuscripcionID")]
        public int RevistaDigitalSuscripcionID { get; set; }
        [DataMember]
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        [DataMember]
        [Column("FechaSuscripcion")]
        public DateTime FechaSuscripcion { get; set; }
        [DataMember]
        [Column("FechaDesuscripcion")]
        public DateTime FechaDesuscripcion { get; set; }
        [DataMember]
        [Column("EstadoRegistro")]
        public int EstadoRegistro { get; set; }
        [DataMember]
        [Column("EstadoEnvio")]
        public int EstadoEnvio { get; set; }
        [DataMember]
        public string IsoPais { get; set; }
        [DataMember]
        [Column("CodigoZona")]
        public string CodigoZona { get; set; }
        [DataMember]
        [Column("EMail")]
        public string EMail { get; set; }
        [DataMember]
        [Column("CampaniaEfectiva")]
        public int CampaniaEfectiva { get; set; }
        [DataMember]
        [Column("Origen")]
        public string Origen { get; set; }

        public BERevistaDigitalSuscripcion() { }
    }
}
