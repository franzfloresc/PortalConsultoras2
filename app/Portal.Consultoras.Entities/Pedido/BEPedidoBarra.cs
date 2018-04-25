using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoBarra
    {
        [DataMember]
        public decimal TippingPoint { get; set; }
        [DataMember]
        public int CantidadProductos { get; set; }
        [DataMember]
        public int CantidadCuv { get; set; }

        [DataMember]
        public List<BEEscalaDescuento> ListaEscalaDescuento { get; set; }
        [DataMember]
        public List<BEMensajeMetaConsultora> ListaMensajeMeta { get; set; }
    }
}
