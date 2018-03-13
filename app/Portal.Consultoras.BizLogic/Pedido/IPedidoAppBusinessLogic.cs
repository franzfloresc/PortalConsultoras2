using Portal.Consultoras.Entities.Producto;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoAppBusinessLogic
    {
        BEProductoApp GetCUV(BEProductoFiltro productoFiltro);
    }
}