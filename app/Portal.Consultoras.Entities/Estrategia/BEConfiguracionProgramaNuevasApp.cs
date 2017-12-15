using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Estrategia
{
    [DataContract]
    public class BEConfiguracionProgramaNuevasApp
    {
        [DataMember]
        [Column("ConfiguracionProgramaNuevasAppID")]
        public int ConfiguracionProgramaNuevasAppID { get; set; }
        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; }
        [DataMember]
        [Column("TextoCupon")]
        public string TextoCupon { get; set; }
        [DataMember]
        [Column("TextoCuponIndependiente")]
        public string TextoCuponIndependiente { get; set; }
    }
}
