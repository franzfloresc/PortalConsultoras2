using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoDetalleResult
    {
        [DataMember]
        public string CodigoRespuesta { get; set; }
        [DataMember]
        public string MensajeRespuesta { get; set; }
        [DataMember]
        public string MensajeAviso { get; set; }
        [DataMember]
        public string TituloMensaje { get; set; }
        [DataMember]
        public List<string> ListCuvEliminar { get; set; }
        [DataMember]
        public BEPedidoWebDetalle PedidoWebDetalle { get; set; }
        [DataMember]
        public bool ModificoBackOrder { get; set; }
    }
}
