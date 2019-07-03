using System.Collections.Generic;
using System.Threading.Tasks;

using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;

namespace Portal.Consultoras.BizLogic
{
    public interface IPedidoWebPromocionBusinessLogic
    {
        IList<BEPedidoWebPromocion> GetCondicionesByPromocion(BEPedidoWebPromocion BEPedidoWebPromocion);
        IList<BEPedidoWebPromocion> GetPromocionesByCondicion(BEPedidoWebPromocion BEPedidoWebPromocion);
        bool InsertPedidoWebPromocion(List<BEPedidoWebPromocion> pedidoWebPromociones, int paisID);
    }
}