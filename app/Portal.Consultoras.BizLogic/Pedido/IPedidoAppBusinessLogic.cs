using Portal.Consultoras.Entities.Pedido.App;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoAppBusinessLogic
    {
        BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar);
        BEPedidoAppInsertarResult Insert(BEPedidoAppInsertar pedidoInsertar);
    }
}