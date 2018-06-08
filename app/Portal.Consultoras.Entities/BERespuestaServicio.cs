using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BERespuestaServicio
    {
        [DataMember]
        public bool Succcess { get; set; }
        [DataMember]
        public string Message { get; set; }
    }
}
