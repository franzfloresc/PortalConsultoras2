using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Producto;
using Portal.Consultoras.Common;

using System.Linq;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedidoApp
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
            var productos = _productoBusinessLogic.SelectProductoByCodigoDescripcionSearchRegionZona(
                                productoFiltro.paisID, 
                                productoFiltro.campaniaID, 
                                productoFiltro.codigoDescripcion, 
                                productoFiltro.RegionID, 
                                productoFiltro.ZonaID, 
                                productoFiltro.CodigoRegion, 
                                productoFiltro.CodigoZona, 
                                productoFiltro.criterio, 
                                productoFiltro.rowCount, 
                                productoFiltro.validarOpt);

            if(!productos.Any()) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

            return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.SUCCESS, productos.FirstOrDefault());
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
