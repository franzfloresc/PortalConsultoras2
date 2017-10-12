using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Incentivo
{
    [DataContract]
    public class BEIncentivoProgramaNuevasCupon
    {
        [DataMember]
        [Column("CodigoConcurso")]
        public string CodigoConcurso { get; set; }
        [DataMember]
        [Column("CodigoNivel")]
        public string CodigoNivel { get; set; }
        [DataMember]
        [Column("CodigoCupon")]
        public string CodigoCupon { get; set; }
        [DataMember]
        [Column("CodigoVenta")]
        public string CodigoVenta { get; set; }
        [DataMember]
        [Column("DescripcionProducto")]
        public string DescripcionProducto { get; set; }
        [DataMember]
        [Column("UnidadesMaximas")]
        public int UnidadesMaximas { get; set; }
        [DataMember]
        [Column("IndicadorKit")]
        public bool IndicadorKit { get; set; }
        [DataMember]
        [Column("IndicadorCuponIndependiente")]
        public bool IndicadorCuponIndependiente { get; set; }
        [DataMember]
        [Column("PrecioUnitario")]
        public decimal PrecioUnitario { get; set; }
        [DataMember]
        [Column("NumeroCampanasVigentes")]
        public int NumeroCampanasVigentes { get; set; }

        public BEIncentivoProgramaNuevasCupon()
        {
        }
    }
}
