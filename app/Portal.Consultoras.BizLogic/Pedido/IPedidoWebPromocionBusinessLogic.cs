using System.Collections.Generic;
using System.Threading.Tasks;

using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;

namespace Portal.Consultoras.BizLogic
{
    public interface IPedidoWebPromocionBusinessLogic
    {
        BEPedidoDetalleResult ValidarPromocionesEnAgregar(List<BEPedidoWebDetalle> lstDetalleAgrupado, BEPedidoDetalle pedidoDetalle, BEUsuario usuario, bool modificar = false);
        BEPedidoDetalleResult ValidarPromocionesEnModificar(List<BEPedidoWebDetalle> lstDetalleAgrupado, BEUsuario usuario, int cantidadmodificada, string cuvmodificado);
    }
}