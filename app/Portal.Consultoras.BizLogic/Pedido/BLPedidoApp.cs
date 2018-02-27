using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Producto;
using Portal.Consultoras.Common;

using System.Linq;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedidoApp : IPedidoAppBusinessLogic
    {
        private readonly IProductoBusinessLogic _productoBusinessLogic;

        public BLPedidoApp() : this(new BLProducto())
        { }

        public BLPedidoApp(IProductoBusinessLogic productoBusinessLogic)
        {
            _productoBusinessLogic = productoBusinessLogic;
        }

        public BEProductoApp GetCUV(BEProductoFiltro productoFiltro)
        {
            var producto = _productoBusinessLogic.SelectProductoByCodigoDescripcionSearchRegionZona(
                                productoFiltro.paisID, 
                                productoFiltro.campaniaID, 
                                productoFiltro.codigoDescripcion, 
                                productoFiltro.RegionID, 
                                productoFiltro.ZonaID, 
                                productoFiltro.CodigoRegion, 
                                productoFiltro.CodigoZona, 
                                productoFiltro.criterio, 
                                productoFiltro.rowCount, 
                                productoFiltro.validarOpt).FirstOrDefault();

            if(producto == null) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

            if (!producto.TieneStock) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_AGOTADO);

            return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.SUCCESS, producto);
        }

        private BEProductoApp ProductoMensajeRespuesta(string codigoRespuesta, BEProducto producto = null)
        {
            return new BEProductoApp()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = Constantes.ProductoValidacion.Message[codigoRespuesta],
                Producto = producto
            };
        }
    }
}
