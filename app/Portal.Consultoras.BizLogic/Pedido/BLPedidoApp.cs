using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Producto;
using Portal.Consultoras.Common;

using System.Linq;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedidoApp : IPedidoAppBusinessLogic
    {
        private readonly IProductoBusinessLogic _productoBusinessLogic;
        private readonly IPedidoWebBusinessLogic _pedidoWebBusinessLogic;

        public BLPedidoApp() : this(new BLProducto(), new BLPedidoWeb())
        { }

        public BLPedidoApp(IProductoBusinessLogic productoBusinessLogic, IPedidoWebBusinessLogic pedidoWebBusinessLogic)
        {
            _productoBusinessLogic = productoBusinessLogic;
            _pedidoWebBusinessLogic = pedidoWebBusinessLogic;
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

            if(producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_LIQUIDACION);

            if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_SHOWROOM);

            //var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(
            //                                productoFiltro.paisID, 
            //                                productoFiltro.campaniaID, 
            //                                productoFiltro.CodigoZona);
            //var tieneRDC = false; //revistaDigital.TieneRDC && revistaDigital.EsActiva;
            //if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
            //{
            //    if(WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoFiltro.paisID))) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA);
            //    else return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL);
            //}

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
