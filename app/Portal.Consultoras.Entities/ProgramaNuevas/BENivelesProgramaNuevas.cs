using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BENivelesProgramaNuevas
    {
        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; }

        [DataMember]
        [Column("Campania")]
        public string Campania { get; set; }

        [DataMember]
        [Column("CodigoNivel")]
        public string CodigoNivel { get; set; }

        [DataMember]
        [Column("UnidadesNivel")]
        public int UnidadesNivel { get; set; }

        [DataMember]
        [Column("UnidadesNivelElectivo")]
        public int UnidadesNivelElectivo { get; set; }
    }
}
