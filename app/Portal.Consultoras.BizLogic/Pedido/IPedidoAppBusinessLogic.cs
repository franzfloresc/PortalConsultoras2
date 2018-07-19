using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Pedido.App;

using System.Threading.Tasks;
using System.Collections.Generic;

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
        Task<BEPedidoDetalleAppResult> Delete(BEPedidoDetalleApp pedidoDetalle);
        Task<BEPedidoReservaAppResult> Reserva(BEUsuario usuario);
        BEPedidoDetalleAppResult DeshacerReserva(BEUsuario usuario, BEPedidoWeb pedido = null);
        List<BEEstrategia> GetEstrategiaCarrusel(BEUsuario usuario);
        BEPedidoDetalleAppResult InsertEstrategiaCarrusel(BEPedidoDetalleApp pedidoDetalle);
        BEUsuario GetConfiguracionOfertaFinalCarrusel(BEUsuario usuario);
        BEPedidoDetalleAppResult InsertOfertaFinalCarrusel(BEPedidoDetalleApp pedidoDetalle);
        List<BEProducto> GetProductoSugerido(BEProductoAppBuscar productoBuscar);
    }
}