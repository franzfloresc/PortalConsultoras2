using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionProgramaNuevas
    {
        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; }
        [DataMember]
        [Column("IndExigVent")]
        public string IndExigVent { get; set; }
        [DataMember]
        [Column("IndProgObli")]
        public string IndProgObli { get; set; }
        [DataMember]
        [Column("CUVKit")]
        public string CUVKit { get; set; }

        public string Campania { get; set; }
        public string CodigoConsultora { get; set; }
        public string CodigoNivel { get; set; }
    }
}
