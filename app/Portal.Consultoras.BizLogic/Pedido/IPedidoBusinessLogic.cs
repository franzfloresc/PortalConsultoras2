using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;

using System.Threading.Tasks;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoBusinessLogic
    {
        BEPedidoProducto GetCUV(BEPedidoProductoBuscar productoBuscar);
        BEPedidoDetalleResult Insert(BEPedidoDetalle pedidoDetalle);
        BEPedidoWeb Get(BEUsuario usuario);
        bool InsertKitInicio(BEUsuario usuario);
        BEPedidoDetalleResult Update(BEPedidoDetalle pedidoDetalle);
        BEConfiguracionPedido GetConfiguracion(int paisID, string codigoUsuario);
        Task<BEPedidoDetalleResult> Delete(BEPedidoDetalle pedidoDetalle);
        Task<BEPedidoReservaAppResult> Reserva(BEUsuario usuario);
        BEPedidoDetalleResult ModificarReserva(BEUsuario usuario, BEPedidoWeb pedido = null);
        List<BEEstrategia> GetEstrategiaCarrusel(BEUsuario usuario);
        BEPedidoDetalleResult InsertEstrategiaCarrusel(BEPedidoDetalle pedidoDetalle);
        BEUsuario GetConfiguracionOfertaFinalCarrusel(BEUsuario usuario);
        BEPedidoDetalleResult InsertOfertaFinalCarrusel(BEPedidoDetalle pedidoDetalle);
        List<Entities.BEProducto> GetProductoSugerido(BEPedidoProductoBuscar productoBuscar);
        BEPedidoDetalleResult AceptarBackOrderPedidoDetalle(BEPedidoDetalle pedidoDetalle);
    }
}