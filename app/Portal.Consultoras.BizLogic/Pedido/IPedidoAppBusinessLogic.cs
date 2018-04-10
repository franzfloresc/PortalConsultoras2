using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido.App;

using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoAppBusinessLogic
    {
        BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar);
        BEPedidoDetalleAppResult Insert(BEPedidoDetalleApp pedidoDetalle);
        void UpdateProl(BEPedidoDetalleApp pedidoDetalle);
        List<BEPedidoWebDetalle> GetDetalle(BEPedidoDetalleApp pedidoDetalle);
    }
}