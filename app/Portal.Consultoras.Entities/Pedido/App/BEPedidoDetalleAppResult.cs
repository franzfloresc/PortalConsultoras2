using System.Runtime.Serialization;
using System.Collections.Generic;

using Portal.Consultoras.Entities.ReservaProl;

namespace Portal.Consultoras.Entities.Pedido.App
{
    [DataContract]
    public class BEPedidoDetalleAppResult
    {
        [DataMember]
        public string CodigoRespuesta { get; set; }
        [DataMember]
        public string MensajeRespuesta { get; set; }
    }

    [DataContract]
    public class BEPedidoReservaAppResult
    {
        [DataMember]
        public string CodigoRespuesta { get; set; }
        [DataMember]
        public string MensajeRespuesta { get; set; }
        [DataMember]
        public List<BEPedidoObservacion> Observaciones { get; set; }
        [DataMember]
        public BEResultadoReservaProl ResultadoReserva { get; set; }
        [DataMember]
        public BEUsuario Usuario { get; set; }
        [DataMember]
        public List<BEPedidoWebDetalle> PedidoDetalle { get; set; }
    }
}
