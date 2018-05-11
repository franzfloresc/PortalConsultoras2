using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEConfiguracionPedido
    {
        [DataMember]
        public BEPedidoBarra Barra { get; set; }
    }
}
