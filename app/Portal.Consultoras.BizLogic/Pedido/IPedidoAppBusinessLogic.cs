using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Pedido.App;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoAppBusinessLogic
    {
        BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar);
        BEPedidoDetalleAppInsertarResult Insert(BEPedidoDetalleAppInsertar pedidoDetalle);
        BEPedidoWeb Get(BEUsuario usuario);
        bool InsertKitInicio(BEUsuario usuario);
        BEConfiguracionPedido GetConfiguracion(int paisID, string codigoUsuario);
    }
}