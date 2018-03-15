using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido.App;
using Portal.Consultoras.Common;

using System;
using System.Linq;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedidoApp : IPedidoAppBusinessLogic
    {
        private readonly IProductoBusinessLogic _productoBusinessLogic;
        private readonly IPedidoWebBusinessLogic _pedidoWebBusinessLogic;
        private readonly IPedidoWebDetalleBusinessLogic _pedidoWebDetalleBusinessLogic;

        public BLPedidoApp() : this(new BLProducto(), 
                                    new BLPedidoWeb(),
                                    new BLPedidoWebDetalle())
        { }

        public BLPedidoApp(IProductoBusinessLogic productoBusinessLogic, 
                            IPedidoWebBusinessLogic pedidoWebBusinessLogic,
                            IPedidoWebDetalleBusinessLogic pedidoWebDetalleBusinessLogic)
        {
            _productoBusinessLogic = productoBusinessLogic;
            _pedidoWebBusinessLogic = pedidoWebBusinessLogic;
            _pedidoWebDetalleBusinessLogic = pedidoWebDetalleBusinessLogic;
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

        public BEPedidoAppInsertarResult Insert(BEPedidoAppInsertar pedidoInsertar)
        {
            var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoInsertar.PaisID,
                                                                pedidoInsertar.ConsultoraID,
                                                                pedidoInsertar.CampaniaID,
                                                                pedidoInsertar.UsuarioPrueba,
                                                                pedidoInsertar.AceptacionConsultoraDA);

            if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

            var mensaje = string.Empty;
            var result = ValidarStockEstrategia(pedidoInsertar, out mensaje);
            if (!result) return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

            return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS);
        }

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

        #region Insert
        private BEPedidoAppInsertarResult PedidoInsertarRespuesta(string codigoRespuesta, string mensajeRespuesta = null)
        {
            return new BEPedidoAppInsertarResult()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.PedidoInsertar.Message[codigoRespuesta] : mensajeRespuesta
            };
        }

        private bool ValidarStockEstrategia(BEPedidoAppInsertar pedidoInsertar, out string mensaje)
        {
            var resultado = false;
            mensaje = string.Empty;

            //var entidad = new BEEstrategia
            //{
            //    PaisID = pedidoInsertar.PaisID,
            //    CUV2 = pedidoInsertar.CUV,
            //    CampaniaID = pedidoInsertar.CampaniaID,
            //    ConsultoraID = pedidoInsertar.ConsultoraID.ToString(),
            //    Cantidad = pedidoInsertar.Cantidad,
            //    FlagCantidad = pedidoInsertar.TipoOferta
            //};

            mensaje = ValidarMontoMaximo(pedidoInsertar, out resultado);

            //if (mensaje == string.Empty || resultado)
            //    mensaje = ValidarStockEstrategiaMensaje(entidad.CUV2, entidad.Cantidad, entidad.FlagCantidad);

            return mensaje == string.Empty || resultado;
        }

        private string ValidarMontoMaximo(BEPedidoAppInsertar pedidoInsertar, out bool resul)
        {
            var mensaje = string.Empty;
            resul = false;

            try
            {
                if (!pedidoInsertar.TieneValidacionMontoMaximo)
                    return mensaje;

                if (pedidoInsertar.MontoMaximoPedido == Convert.ToDecimal(9999999999.00))
                    return mensaje;

                var listaProducto = ObtenerPedidoWebDetalle(pedidoInsertar);

                var totalPedido = listaProducto.Sum(p => p.ImporteTotal);
                var dTotalPedido = Convert.ToDecimal(totalPedido);
                decimal descuentoProl = 0;

                if (dTotalPedido > pedidoInsertar.MontoMaximoPedido && pedidoInsertar.Cantidad < 0)
                {
                    resul = true;
                }

                if (listaProducto.Any())
                    descuentoProl = listaProducto[0].DescuentoProl;

                var montoActual = (pedidoInsertar.PrecioUnidad * pedidoInsertar.Cantidad) + (dTotalPedido - descuentoProl);
                if (montoActual > pedidoInsertar.MontoMaximoPedido)
                {
                    var FechaHoy = DateTime.Now.AddHours(pedidoInsertar.ZonaHoraria).Date;
                    var EsDiasFacturacion = FechaHoy >= pedidoInsertar.FechaInicioFacturacion.Date && FechaHoy <= pedidoInsertar.FechaFinFacturacion.Date;

                    var strmen = (EsDiasFacturacion ? "VALIDADO" : "GUARDADO");
                    mensaje = string.Format("Haz superado el límite de tu línea de crédito de {0}{1}. Por favor modifica tu pedido para que sea {2} con éxito.", pedidoInsertar.Simbolo, pedidoInsertar.MontoMaximoPedido, strmen);
                }
            }
            catch { }

            return mensaje;
        }

        private List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle(BEPedidoAppInsertar pedidoInsertar)
        {
            var detallesPedidoWeb = new List<BEPedidoWebDetalle>();

            //try
            //{
            //    var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            //    {
            //        PaisId = pedidoInsertar.PaisID,
            //        CampaniaId = pedidoInsertar.CampaniaID,
            //        ConsultoraId = pedidoInsertar.ConsultoraID,
            //        Consultora = pedidoInsertar.NombreConsultora,
            //        EsBpt = EsOpt(pedidoInsertar.RevistaDigital ?? new BERevistaDigital()) == 1,
            //        CodigoPrograma = pedidoInsertar.CodigoPrograma,
            //        NumeroPedido = pedidoInsertar.ConsecutivoNueva
            //    };

            //    detallesPedidoWeb = _pedidoWebDetalleBusinessLogic.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();

            //    if (detallesPedidoWeb.Any())
            //    {
            //        foreach (var item in detallesPedidoWeb)
            //        {
            //            item.ClienteID = string.IsNullOrEmpty(item.Nombre) ? (short)0 : Convert.ToInt16(item.ClienteID);
            //            item.Nombre = string.IsNullOrEmpty(item.Nombre) ? pedidoInsertar.Usuario.Nombre : item.Nombre;
            //        }
            //        var observacionesProl = sessionManager.GetObservacionesProl();
            //        if (detallesPedidoWeb.Count > 0 && observacionesProl != null)
            //        {
            //            detallesPedidoWeb = PedidoConObservaciones(detallesPedidoWeb, observacionesProl);
            //        }
            //    }
            //}
            //catch { }

            return detallesPedidoWeb;
        }

        private int EsOpt(BERevistaDigital revistaDigital)
        {
            var esOpt = revistaDigital.TieneRevistaDigital() && revistaDigital.EsActiva
                    ? 1 : 2;
            return esOpt;
        }
        #endregion
    }
}
