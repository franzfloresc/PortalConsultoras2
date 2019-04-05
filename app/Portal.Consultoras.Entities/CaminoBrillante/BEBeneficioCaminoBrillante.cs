using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEBeneficioCaminoBrillante
    {
        [DataMember]
        [Column("CodigoNivel")]
        public string CodigoNivel { get; set; }

        [DataMember]
        [Column("CodigoBeneficio")]
        public string CodigoBeneficio { get; set; }

        [DataMember]
        [Column("NombreBeneficio")]
        public string NombreBeneficio { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        
        [DataMember]
        [Column("Icono")]
        public string Icono { get; set; }
    }
}
