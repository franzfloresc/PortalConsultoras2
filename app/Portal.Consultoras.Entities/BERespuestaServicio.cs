using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BERespuestaServicio
    {
        public BERespuestaServicio() {}

        public BERespuestaServicio(string message)
        {
            Message = message;
        }

        [DataMember]
        public bool Succcess { get; set; }
        [DataMember]
        public string Code { get; set; }
        [DataMember]
        public string Message { get; set; }
    }
}
