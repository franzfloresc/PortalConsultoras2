using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEInformacion
    {
        [DataMember]
        public int CodigoInformacion { get; set; }
        [DataMember]
        public string DetalleInformacion { get; set; }
    }
}
