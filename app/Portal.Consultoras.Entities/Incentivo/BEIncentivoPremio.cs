using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

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
        [DataMember]
        [Column("ImagenPremio")]
        public string ImagenPremio { get; set; }

        public BEIncentivoPremio()
        {

        }
    }
}
