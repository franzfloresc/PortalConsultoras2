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
                                productoFiltro.PaisID, 
                                productoFiltro.CampaniaID, 
                                productoFiltro.CodigoDescripcion, 
                                productoFiltro.RegionID, 
                                productoFiltro.ZonaID, 
                                productoFiltro.CodigoRegion, 
                                productoFiltro.CodigoZona, 
                                productoFiltro.Criterio, 
                                productoFiltro.RowCount, 
                                productoFiltro.ValidarOpt).FirstOrDefault();

            if(producto == null) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

            if (!producto.TieneStock) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_AGOTADO);

            if(producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_LIQUIDACION);

            if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
            {
                if(productoFiltro.EsShowRoom) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_SHOWROOM);
                else return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_SHOWROOM_NODISPONIBLE);
            }

            if (productoFiltro.RevistaDigital != null)
            {
                var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(
                                                productoFiltro.PaisID,
                                                productoFiltro.CampaniaID,
                                                productoFiltro.CodigoZona);
                var tieneRDC = productoFiltro.RevistaDigital.TieneRDC && productoFiltro.RevistaDigital.EsActiva;
                if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
                {
                    if (WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoFiltro.PaisID))) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA);
                    else return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL);
                }
            }

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
