using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido.App;

using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoAppBusinessLogic
    {
        BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar);
        BEPedidoDetalleAppInsertarResult Insert(BEPedidoDetalleAppInsertar pedidoDetalle);
        List<BEPedidoWebDetalle> GetDetalle(BEPedidoDetalleAppBuscar pedidoDetalle);
    }
}