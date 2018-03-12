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

            var bloqueoProductoCatalogo = BloqueoProductosCatalogo(producto, productoFiltro);
            if(!bloqueoProductoCatalogo) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

            var bloqueoProductoDigitales = BloqueoProductosDigitales(producto, productoFiltro);
            if (!bloqueoProductoDigitales) return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

            return ProductoMensajeRespuesta(Constantes.ProductoValidacion.Code.SUCCESS, producto);
        }

        private bool BloqueoProductosCatalogo(BEProducto producto, BEProductoFiltro productoFiltro)
        {
            if (producto == null) return true;

            var revistaDigital = productoFiltro.RevistaDigital ?? new BERevistaDigital();

            if (!(revistaDigital.TieneRDC || revistaDigital.TieneRDR)) return true;

            if (!revistaDigital.EsActiva) return true;

            if (revistaDigital.BloquearRevistaImpresaGeneral != null)
            {
                if (revistaDigital.BloquearRevistaImpresaGeneral == 1)
                {
                    return !productoFiltro.CodigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
                }
            }
            else
            {
                if (revistaDigital.BloqueoRevistaImpresa)
                {
                    return !productoFiltro.CodigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
                }
            }

            return true;
        }

        private bool BloqueoProductosDigitales(BEProducto producto, BEProductoFiltro productoFiltro)
        {
            if (producto == null) return true;

            var revistaDigital = productoFiltro.RevistaDigital ?? new BERevistaDigital();

            if (revistaDigital.BloqueoProductoDigital)
            {
                return !(
                            producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                        );
            }

            if (productoFiltro.OfertaDelDiaModel != null && productoFiltro.OfertaDelDiaModel.BloqueoProductoDigital)
            {
                return (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaDelDia);
            }

            if (productoFiltro.GuiaNegocio != null && productoFiltro.GuiaNegocio.BloqueoProductoDigital)
            {
                return (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
            }

            if (productoFiltro.OptBloqueoProductoDigital)
            {
                return (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaParaTi);
            }

            return true;
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
