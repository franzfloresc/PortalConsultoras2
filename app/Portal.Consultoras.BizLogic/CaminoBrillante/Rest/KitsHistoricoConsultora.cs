using System.Runtime.Serialization;

namespace Portal.Consultoras.BizLogic.CaminoBrillante.Rest
{
    [DataContract]
    public class KitsHistoricoConsultora
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }
        [DataMember(Name = "CODIGOKIT")]
        public string CodigoKit { get; set; }
        [DataMember(Name = "CAMPANAATENCION")]
        public string CampaniaAtencion { get; set; }

    }
}
