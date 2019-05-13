using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEProductoCaminoBrillante
    {
        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }
        [DataMember]
        [Column("Nivel")]
        public int? Nivel { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("IndicadorDigitable")]
        public int? IndicadorDigitable { get; set; }
        [DataMember]
        [Column("Tipo")]
        public int Tipo { get; set; }
    }
}
