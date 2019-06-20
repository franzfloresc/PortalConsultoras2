using Portal.Consultoras.Entities.Pedido;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IDireccionEntregaBusinessLogic
    {
        BEDireccionEntrega Editar(BEDireccionEntrega Direccion);
        BEDireccionEntrega Insertar(BEDireccionEntrega Direccion);
        BEDireccionEntrega ObtenerDireccionPorConsultora(BEDireccionEntrega direccion);
    }
}