using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Incentivo
{
    [DataContract]
    public class BEIncentivoProgramaNuevasPremio
    {
        [DataMember]
        [Column("CodigoConcurso")]
        public string CodigoConcurso { get; set; }
        [DataMember]
        [Column("CodigoNivel")]
        public string CodigoNivel { get; set; }
        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }
        [DataMember]
        [Column("DescripcionProducto")]
        public string DescripcionProducto { get; set; }
        [DataMember]
        [Column("IndicadorKitNuevas")]
        public bool IndicadorKitNuevas { get; set; }
        [DataMember]
        [Column("PrecioUnitario")]
        public decimal PrecioUnitario { get; set; }

        public BEIncentivoProgramaNuevasPremio()
        {
        }
    }
}
