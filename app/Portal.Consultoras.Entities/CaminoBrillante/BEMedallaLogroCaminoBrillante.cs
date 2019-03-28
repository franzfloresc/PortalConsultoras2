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
        [Column("Valor")]
        public string Valor { get; set; }
        [DataMember]
        [Column("SubTitulo")]
        public string SubTitulo { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

    }
}