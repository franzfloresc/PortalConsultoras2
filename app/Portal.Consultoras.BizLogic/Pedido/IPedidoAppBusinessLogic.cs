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
        BEPedidoDetalleAppResult DeshacerReserva(BEUsuario usuario);
        List<BEEstrategia> GetEstrategiaCarrusel(BEUsuario usuario);
        BEUsuario GetConfiguracionOfertaFinal(BEUsuario usuario);
    }
}