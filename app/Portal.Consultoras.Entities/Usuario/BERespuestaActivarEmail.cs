using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BERespuestaActivarEmail : BERespuestaServicio
    {
        public BERespuestaActivarEmail() : base() { }
        public BERespuestaActivarEmail(string message) : base(message) { }

        [DataMember]
        public BEUsuario Usuario { get; set; }
    }
}
