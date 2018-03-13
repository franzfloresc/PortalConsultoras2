using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPaisDatos : BaseEntidad
    {
        [DataMember]
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
        public string Codigo { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string Componente { get; set; }
        [DataMember]
        public string Valor1 { get; set; }
        [DataMember]
        public string Valor2 { get; set; }
        [DataMember]
        public string Valor3 { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public bool Estado { get; set; }
    }
}
