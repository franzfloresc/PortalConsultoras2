using System.Runtime.Serialization;

using Portal.Consultoras.Entities.ReservaProl;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoReservaResult
    {
        [DataMember]
        public string CodigoRespuesta { get; set; }
        [DataMember]
        public string MensajeRespuesta { get; set; }
        [DataMember]
        public BEResultadoReservaProl ResultadoReserva { get; set; }
    }
}
