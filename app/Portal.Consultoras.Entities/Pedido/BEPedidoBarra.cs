using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoBarra
    {
        [DataMember]
        public List<BEEscalaDescuento> ListaEscalaDescuento { get; set; }
        [DataMember]
        public List<BEMensajeMetaConsultora> ListaMensajeMeta { get; set; }
    }
}
