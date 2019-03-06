using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Producto;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoBusinessLogic
    {
        #region Pedido Registro Insertar-Actualizar-Eliminar
        BEPedidoDetalleResult Insert(BEPedidoDetalle pedidoDetalle);
        BEPedidoDetalleResult Update(BEPedidoDetalle pedidoDetalle);
        Task<BEPedidoDetalleResult> Delete(BEPedidoDetalle pedidoDetalle);
        #endregion

        BEPedidoProducto GetCUV(BEPedidoProductoBuscar productoBuscar);
        BEPedidoWeb Get(BEUsuario usuario);
        bool InsertKitInicio(BEUsuario usuario);
        BEConfiguracionPedido GetConfiguracion(int paisID, string codigoUsuario, int campaniaID, string region, string zona);
        Task<BEPedidoReservaResult> Reserva(BEUsuario usuario);
        BEPedidoDetalleResult ModificarReserva(BEUsuario usuario, BEPedidoWeb pedido = null);
        List<BEEstrategia> GetEstrategiaCarrusel(BEUsuario usuario);
        BEPedidoDetalleResult InsertEstrategiaCarrusel(BEPedidoDetalle pedidoDetalle);
        BEUsuario GetConfiguracionOfertaFinalCarrusel(BEUsuario usuario);
        BEPedidoDetalleResult InsertOfertaFinalCarrusel(BEPedidoDetalle pedidoDetalle);
        BEPedidoDetalleResult AceptarBackOrderPedidoDetalle(BEPedidoDetalle pedidoDetalle);
        List<BEProducto> GetProductoSugerido(BEPedidoProductoBuscar productoBuscar);
        void InsertOfertaFinalLog(int paisID, int campaniaID, string codigoConsultora, decimal? montoInicial, List<BEOfertaFinalConsultoraLog> listaOfertaFinalLog);
        BEPedidoDetalleResult InsertProductoBuscador(BEPedidoDetalle pedidoDetalle);
        List<BEPedidoDetalleResult> InsertMasivo(List<BEPedidoDetalle> lstPedidoDetalle);
        List<BEProductoRecomendado> GetProductoRecomendado(int paisID, bool RDEsSuscrita, bool RDEsActiva, List<BEProductoRecomendado> lst);
        BEProducto GetRegaloOfertaFinal(BEUsuario usuario);
    }
}