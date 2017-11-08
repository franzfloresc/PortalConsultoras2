using Portal.Consultoras.Common;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEValidacionModificacionPedido
    {
        [DataMember]
        public Enumeradores.MotivoPedidoLock MotivoPedidoLock { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
    }
}
