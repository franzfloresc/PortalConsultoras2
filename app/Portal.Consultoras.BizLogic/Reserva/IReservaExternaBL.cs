using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public interface IReservaExternaBL
    {
        BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle);
    }
}
