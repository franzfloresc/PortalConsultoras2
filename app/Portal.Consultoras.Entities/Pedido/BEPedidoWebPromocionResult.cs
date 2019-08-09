using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoWebPromocionResult
    {
        [DataMember]
        public List<BEPedidoWebPromocion> PedidoWebPromociones { get; set; }
    }
}
