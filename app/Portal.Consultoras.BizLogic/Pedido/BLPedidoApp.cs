using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido.App;
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

        public BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar)
        {
            //Validación producto no existe
            var producto = _productoBusinessLogic.SelectProductoByCodigoDescripcionSearchRegionZona(
                                productoBuscar.PaisID,
                                productoBuscar.CampaniaID,
                                productoBuscar.CodigoDescripcion,
                                productoBuscar.RegionID,
                                productoBuscar.ZonaID,
                                productoBuscar.CodigoRegion,
                                productoBuscar.CodigoZona,
                                productoBuscar.Criterio,
                                productoBuscar.RowCount,
                                productoBuscar.ValidarOpt).FirstOrDefault();
            if(producto == null) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

            //Validación producto agotado
            if (!producto.TieneStock) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_AGOTADO);

            //Validación producto liquidaciones
            if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_LIQUIDACION);

            //Validación producto showroom
            if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
            {
                if(productoBuscar.EsShowRoom) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_SHOWROOM);
                else return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_SHOWROOM_NODISPONIBLE);
            }

            //Información de producto con oferta en revista
            if (productoBuscar.RevistaDigital != null)
            {
                var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(
                                                productoBuscar.PaisID,
                                                productoBuscar.CampaniaID,
                                                productoBuscar.CodigoZona);
                var tieneRDC = productoBuscar.RevistaDigital.TieneRDC && productoBuscar.RevistaDigital.EsActiva;
                if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
                {
                    if (WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoBuscar.PaisID))) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA);
                    else return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL);
                }
            }

            var bloqueoProductoCatalogo = BloqueoProductosCatalogo(producto, productoBuscar);
            if(!bloqueoProductoCatalogo) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

            //Validación Gana +
            var bloqueoProductoDigitales = BloqueoProductosDigitales(producto, productoBuscar);
            if (!bloqueoProductoDigitales) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

            return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.SUCCESS, producto);
        }

        //public InsertCUV()
        //{

        //}

        #region GetCUV
        private bool BloqueoProductosCatalogo(BEProducto producto, BEProductoAppBuscar productoBuscar)
        {
            if (producto == null) return true;

            var revistaDigital = productoBuscar.RevistaDigital ?? new BERevistaDigital();

            if (!(revistaDigital.TieneRDC || revistaDigital.TieneRDR)) return true;

            if (!revistaDigital.EsActiva) return true;

            if (revistaDigital.BloquearRevistaImpresaGeneral != null)
            {
                if (revistaDigital.BloquearRevistaImpresaGeneral == 1)
                {
                    return !productoBuscar.CodigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
                }
            }
            else
            {
                if (revistaDigital.BloqueoRevistaImpresa)
                {
                    return !productoBuscar.CodigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
                }
            }

            return true;
        }

        private bool BloqueoProductosDigitales(BEProducto producto, BEProductoAppBuscar productoBuscar)
        {
            if (producto == null) return true;

            var revistaDigital = productoBuscar.RevistaDigital ?? new BERevistaDigital();

            if (revistaDigital.BloqueoProductoDigital)
            {
                return !(
                            producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                        );
            }

            if (productoBuscar.OfertaDelDiaModel != null && productoBuscar.OfertaDelDiaModel.BloqueoProductoDigital)
            {
                return (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaDelDia);
            }

            if (productoBuscar.GuiaNegocio != null && productoBuscar.GuiaNegocio.BloqueoProductoDigital)
            {
                return (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
            }

            if (productoBuscar.OptBloqueoProductoDigital)
            {
                return (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaParaTi);
            }

            return true;
        }

        private BEProductoApp ProductoBuscarRespuesta(string codigoRespuesta, BEProducto producto = null)
        {
            return new BEProductoApp()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = Constantes.PedidoAppValidacion.ProductoBuscar.Message[codigoRespuesta],
                Producto = producto
            };
        }
        #endregion
    }
}
