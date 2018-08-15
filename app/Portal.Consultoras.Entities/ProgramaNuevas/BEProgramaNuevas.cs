using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BEProgramaNuevas
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; } 
        [DataMember]
        [Column("ConsecutivoNueva")]
        public int ConsecutivoNueva { get; set; }
        [DataMember]
        public bool EsConsultoraNueva { get; set; }
    }
}
