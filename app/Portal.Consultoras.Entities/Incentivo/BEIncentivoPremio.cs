using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoPremio
    {
        [Column("CodigoConcurso")]
        [DataMember]
        public string CodigoConcurso { get; set; }
        [Column("CodigoNivel")]
        [DataMember]
        public int CodigoNivel { get; set; }
        [Column("CodigoPremio")]
        [DataMember]
        public string CodigoPremio { get; set; }
        [Column("DescripcionPremio")]
        [DataMember]
        public string DescripcionPremio { get; set; }
        [Column("NumeroPremio")]
        [DataMember]
        public int NumeroPremio { get; set; }

        public BEIncentivoPremio()
        {

        }
    }
}
