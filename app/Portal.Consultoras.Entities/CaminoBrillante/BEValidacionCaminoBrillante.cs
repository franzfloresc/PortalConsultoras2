using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEValidacionCaminoBrillante
    {
        [DataMember]
        public Enumeradores.ValidacionCaminoBrillante Validacion { get; set; }
        [DataMember]
        public string Code { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
    }
}
