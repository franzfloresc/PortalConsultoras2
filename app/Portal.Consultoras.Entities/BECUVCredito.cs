using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECUVCredito
    {
        [DataMember]
        public string CuvCredito { get; set; }

        [DataMember]
        public string CuvRegular { get; set; }

        [DataMember]
        public int IdMensaje { get; set; }

    }
}