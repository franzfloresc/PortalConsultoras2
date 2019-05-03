using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEConfiguracionMedallaCaminoBrillante
    {
        [DataMember]
        [Column("Logro")]
        public string Logro { get; set; }
        [DataMember]
        [Column("Indicador")]
        public string Indicador { get; set; }
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("Valor")]
        public string Valor { get; set; }
        [DataMember]
        [Column("ComoLograrlo_Estado")]
        public bool ComoLograrlo_Estado { get; set; }
        [DataMember]
        [Column("ComoLograrlo_Titulo")]
        public string ComoLograrlo_Titulo { get; set; }
        [DataMember]
        [Column("ComoLograrlo_Descripcion")]
        public string ComoLograrlo_Descripcion { get; set; }
    }
}