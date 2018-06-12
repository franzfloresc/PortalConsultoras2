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
        [Column("CampaniaInicio")]
        public string CampaniaInicio { get; set; }
        [DataMember]
        [Column("CampaniaFin")]
        public string CampaniaFin { get; set; }
        [DataMember]
        [Column("IndExigVent")]
        public string IndExigVent { get; set; }
        [DataMember]
        [Column("IndProgObli")]
        public string IndProgObli { get; set; }
        [DataMember]
        [Column("CuponKit")]
        public string CuponKit { get; set; }
        [DataMember]
        [Column("CUVKit")]
        public string CUVKit { get; set; }
        [DataMember]
        [Column("CodigoZona")]
        public string CodigoZona { get; set; }
        [DataMember]
        [Column("CodigoRegion")]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
    }
}
