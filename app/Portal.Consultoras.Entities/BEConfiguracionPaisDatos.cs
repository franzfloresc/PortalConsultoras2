using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPaisDatos : BaseEntidad
    {
        [DataMember]
        [Column("ConfiguracionPaisID")]
        public int ConfiguracionPaisID { get; set; }

        private BEConfiguracionPais privConfiguracionPais = new BEConfiguracionPais();
        [DataMember]
        public BEConfiguracionPais ConfiguracionPais
        {
            get
            {
                return privConfiguracionPais;
            }
            set
            {
                privConfiguracionPais = value;
            }
        }

        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        [DataMember]
        [Column("Componente")]
        public string Componente { get; set; }
        [DataMember]
        [Column("Valor1")]
        public string Valor1 { get; set; }
        [DataMember]
        [Column("Valor2")]
        public string Valor2 { get; set; }
        [DataMember]
        [Column("Valor3")]
        public string Valor3 { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("Estado")]
        public bool Estado { get; set; }
    }
}
