using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public interface IReservaExternaBL
    {
        Task<BEResultadoReservaProl> ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle);
        Task<bool> DeshacerReservaPedido(BEUsuario usuario, int pedidoId);
    }
}
