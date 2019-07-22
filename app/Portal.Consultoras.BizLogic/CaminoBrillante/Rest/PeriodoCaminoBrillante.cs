using System.Runtime.Serialization;

namespace Portal.Consultoras.BizLogic.CaminoBrillante.Rest
{
    [DataContract]
    public class PeriodoCaminoBrillante
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }
        [DataMember(Name = "PERIODO")]
        public string Periodo { get; set; }
        [DataMember(Name = "CAMPANAINICIAL")]
        public string CampanaInicial { get; set; }
        [DataMember(Name = "CAMPANAFINAL")]
        public string CampanaFinal { get; set; }
        [DataMember(Name = "NROCAMPANA")]
        public string NroCampana { get; set; }

    }
}
