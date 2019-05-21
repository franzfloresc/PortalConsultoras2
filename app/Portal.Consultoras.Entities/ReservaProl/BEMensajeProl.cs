using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ReservaProl
{
    [DataContract]
    public class BEMensajeProl
    {
        [DataMember]
        public string CodigoMensajeRxP { get; set; }
        [DataMember]
        public string MensajeRxP { get; set; }
    }
}
