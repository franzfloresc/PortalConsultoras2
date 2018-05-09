using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Pedido.App;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoAppBusinessLogic
    {
        BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar);
        BEPedidoDetalleAppResult Insert(BEPedidoDetalleApp pedidoDetalle);
        BEPedidoWeb Get(BEUsuario usuario);
        bool InsertKitInicio(BEUsuario usuario);
        BEPedidoDetalleAppResult Update(BEPedidoDetalleApp pedidoDetalle);
        BEConfiguracionPedido GetConfiguracion(int paisID, string codigoUsuario);
        BEPedidoDetalleAppResult Delete(BEPedidoDetalleApp pedidoDetalle);
        BEPedidoDetalleAppResult DeshacerPedido(BEUsuario usuario);
    }
}