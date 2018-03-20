using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido.App;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;

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
        private readonly IEstrategiaBusinessLogic _estrategiaBusinessLogic;
        private readonly IConfiguracionProgramaNuevasBusinessLogic _configuracionProgramaNuevasBusinessLogic;

        public BLPedidoApp() : this(new BLProducto(), 
                                    new BLPedidoWeb(),
                                    new BLPedidoWebDetalle(),
                                    new BLEstrategia(),
                                    new BLConfiguracionProgramaNuevas())
        { }

        public BLPedidoApp(IProductoBusinessLogic productoBusinessLogic, 
                            IPedidoWebBusinessLogic pedidoWebBusinessLogic,
                            IPedidoWebDetalleBusinessLogic pedidoWebDetalleBusinessLogic,
                            IEstrategiaBusinessLogic estrategiaBusinessLogic,
                            IConfiguracionProgramaNuevasBusinessLogic configuracionProgramaNuevasBusinessLogic)
        {
            _productoBusinessLogic = productoBusinessLogic;
            _pedidoWebBusinessLogic = pedidoWebBusinessLogic;
            _pedidoWebDetalleBusinessLogic = pedidoWebDetalleBusinessLogic;
            _estrategiaBusinessLogic = estrategiaBusinessLogic;
            _configuracionProgramaNuevasBusinessLogic = configuracionProgramaNuevasBusinessLogic;
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
            var mensaje = string.Empty;

            var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoInsertar.PaisID,
                                                                pedidoInsertar.ConsultoraID,
                                                                pedidoInsertar.CampaniaID,
                                                                pedidoInsertar.UsuarioPrueba,
                                                                pedidoInsertar.AceptacionConsultoraDA);

            if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

            var result = ValidarStockEstrategia(pedidoInsertar, out mensaje);
            if (!result) return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

            if (pedidoInsertar.Producto.TipoOfertaSisID == 0)
            {
                var tipoEstrategiaID = 0;
                int.TryParse(pedidoInsertar.Producto.TipoEstrategiaID, out tipoEstrategiaID);
                pedidoInsertar.Producto.TipoOfertaSisID = tipoEstrategiaID;
            }

            var esOfertaNueva = (pedidoInsertar.Producto.FlagNueva == "1");
            if (esOfertaNueva) AgregarProductoZE(pedidoInsertar);

            var codeResult = PedidoInsertar(pedidoInsertar);
            if (codeResult != Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS) return PedidoInsertarRespuesta(codeResult);

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

            mensaje = ValidarMontoMaximo(pedidoInsertar, out resultado);

            if (mensaje == string.Empty || resultado)
                mensaje = ValidarStockEstrategiaMensaje(pedidoInsertar);

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
                var descuentoProl = listaProducto.Any() ? listaProducto[0].DescuentoProl : 0;

                if (totalPedido > pedidoInsertar.MontoMaximoPedido && pedidoInsertar.Cantidad < 0)
                    resul = true;

                var montoActual = (pedidoInsertar.Producto.PrecioCatalogo * pedidoInsertar.Cantidad) + (totalPedido - descuentoProl);
                if (montoActual > pedidoInsertar.MontoMaximoPedido)
                {
                    var FechaHoy = DateTime.Now.AddHours(pedidoInsertar.ZonaHoraria).Date;
                    var EsDiasFacturacion = FechaHoy >= pedidoInsertar.FechaInicioFacturacion.Date && FechaHoy <= pedidoInsertar.FechaFinFacturacion.Date;

                    var strmen = (EsDiasFacturacion ? "VALIDADO" : "GUARDADO");
                    mensaje = string.Format("Haz superado el límite de tu línea de crédito de {0}{1}. Por favor modifica tu pedido para que sea {2} con éxito.", pedidoInsertar.Simbolo, pedidoInsertar.MontoMaximoPedido, strmen);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoInsertar.ConsultoraID, pedidoInsertar.PaisID);
            }

            return mensaje;
        }

        private List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle(BEPedidoAppInsertar pedidoInsertar)
        {
            var detallesPedidoWeb = new List<BEPedidoWebDetalle>();

            try
            {
                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                {
                    PaisId = pedidoInsertar.PaisID,
                    CampaniaId = pedidoInsertar.CampaniaID,
                    ConsultoraId = pedidoInsertar.ConsultoraID,
                    Consultora = pedidoInsertar.NombreConsultora,
                    EsBpt = EsOpt(pedidoInsertar.RevistaDigital) == 1,
                    CodigoPrograma = pedidoInsertar.CodigoPrograma,
                    NumeroPedido = pedidoInsertar.ConsecutivoNueva
                };

                detallesPedidoWeb = _pedidoWebDetalleBusinessLogic.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();

                pedidoInsertar.PedidoID = detallesPedidoWeb.Any() ? detallesPedidoWeb.First().PedidoID : 0;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoInsertar.ConsultoraID, pedidoInsertar.PaisID);
            }

            return detallesPedidoWeb;
        }

        private int EsOpt(BERevistaDigital revistaDigital)
        {
            var esOpt = revistaDigital.TieneRevistaDigital() && revistaDigital.EsActiva
                    ? 1 : 2;
            return esOpt;
        }

        private string ValidarStockEstrategiaMensaje(BEPedidoAppInsertar pedidoInsertar)
        {
            var mensaje = string.Empty;

            try
            {
                var tipoEstrategiaID = 0;
                int.TryParse(pedidoInsertar.Producto.TipoEstrategiaID, out tipoEstrategiaID);

                var entidad = new BEEstrategia
                {
                    PaisID = pedidoInsertar.PaisID,
                    Cantidad = pedidoInsertar.Cantidad,
                    CUV2 = pedidoInsertar.Producto.CUV,
                    CampaniaID = pedidoInsertar.CampaniaID,
                    ConsultoraID = pedidoInsertar.ConsultoraID.ToString(),
                    FlagCantidad = tipoEstrategiaID
                };

                mensaje = _estrategiaBusinessLogic.ValidarStockEstrategia(entidad);

                mensaje = Util.Trim(mensaje);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoInsertar.ConsultoraID, pedidoInsertar.PaisID);
            }

            return mensaje == "OK" ? string.Empty : mensaje;
        }

        private string PedidoInsertar(BEPedidoAppInsertar pedidoInsertar)
        {
            try
            {
                var result = InsertarValidarKitInicio(pedidoInsertar);
                if (!result) return Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_KIT_INICIO;

                var tipoEstrategiaID = 0;
                int.TryParse(pedidoInsertar.Producto.TipoEstrategiaID, out tipoEstrategiaID);

                var obePedidoWebDetalle = new BEPedidoWebDetalle
                {
                    PaisID = pedidoInsertar.PaisID,
                    IPUsuario = pedidoInsertar.IPUsuario,
                    CampaniaID = pedidoInsertar.CampaniaID,
                    ConsultoraID = pedidoInsertar.ConsultoraID,
                    PedidoID = pedidoInsertar.PedidoID,
                    SubTipoOfertaSisID = 0,
                    TipoOfertaSisID = pedidoInsertar.Producto.TipoOfertaSisID,
                    CUV = pedidoInsertar.Producto.CUV,
                    Cantidad = pedidoInsertar.Cantidad,
                    PrecioUnidad = pedidoInsertar.Producto.PrecioCatalogo,
                    TipoEstrategiaID = tipoEstrategiaID,
                    OrigenPedidoWeb = Constantes.OrigenPedidoWeb.AppPedido,
                    ConfiguracionOfertaID = pedidoInsertar.Producto.ConfiguracionOfertaID,
                    ClienteID = pedidoInsertar.ClienteID,
                    OfertaWeb = false,
                    IndicadorMontoMinimo = pedidoInsertar.Producto.IndicadorMontoMinimo,
                    EsSugerido = false,
                    EsKitNueva = false,
                    MarcaID = Convert.ToByte(pedidoInsertar.Producto.MarcaID),
                    DescripcionProd = pedidoInsertar.Producto.Descripcion,
                    ImporteTotal = pedidoInsertar.Cantidad * pedidoInsertar.Producto.PrecioCatalogo,
                    Nombre = pedidoInsertar.ClienteID == 0 ? pedidoInsertar.NombreConsultora : pedidoInsertar.ClienteDescripcion
                };

                result = AdministradorPedido(pedidoInsertar, obePedidoWebDetalle, Constantes.PedidoAccion.INSERT);
                if (!result) return Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_GRABAR;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoInsertar.ConsultoraID, pedidoInsertar.PaisID);
            }

            return Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS;
        }

        private bool InsertarValidarKitInicio(BEPedidoAppInsertar pedidoInsertar)
        {
            var resultado = true;

            if (pedidoInsertar.EsConsultoraNueva)
            {
                var olstPedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoInsertar);
                var detCuv = olstPedidoWebDetalle.FirstOrDefault(d => d.CUV == pedidoInsertar.Producto.CUV) ?? new BEPedidoWebDetalle();
                detCuv.CUV = Util.Trim(detCuv.CUV);
                if (detCuv.CUV != string.Empty)
                {
                    var obeConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas(pedidoInsertar);
                    if (obeConfiguracionProgramaNuevas.IndProgObli == "1" && obeConfiguracionProgramaNuevas.CUVKit == detCuv.CUV)
                        resultado = false;
                }
            }

            return resultado;
        }

        private BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(BEPedidoAppInsertar pedidoInsertar)
        {
            var configuracionProgramaNuevas = new BEConfiguracionProgramaNuevas();

            try
            {
                var obeConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas()
                {
                    CampaniaInicio = pedidoInsertar.CampaniaID.ToString(),
                    CodigoRegion = pedidoInsertar.CodigoRegion,
                    CodigoZona = pedidoInsertar.CodigoZona
                };

                if (pedidoInsertar.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
                        pedidoInsertar.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
                        pedidoInsertar.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
                {
                    var PaisesFraccionKit = WebConfig.PaisesFraccionKitNuevas;
                    if (PaisesFraccionKit.Contains(Util.GetPaisISO(pedidoInsertar.PaisID)))
                    {
                        obeConfiguracionProgramaNuevas.CodigoNivel = pedidoInsertar.ConsecutivoNueva == 1 ? "02" : pedidoInsertar.ConsecutivoNueva == 2 ? "03" : string.Empty;
                        obeConfiguracionProgramaNuevas = _configuracionProgramaNuevasBusinessLogic.GetConfiguracionProgramaDespuesPrimerPedido(pedidoInsertar.PaisID, obeConfiguracionProgramaNuevas);
                    }
                }
                else
                {
                    obeConfiguracionProgramaNuevas = _configuracionProgramaNuevasBusinessLogic.GetConfiguracionProgramaNuevas(pedidoInsertar.PaisID, obeConfiguracionProgramaNuevas);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoInsertar.ConsultoraID, pedidoInsertar.PaisID);
            }

            return configuracionProgramaNuevas;
        }

        private bool AdministradorPedido(BEPedidoAppInsertar pedidoInsertar, BEPedidoWebDetalle obePedidoWebDetalle, string tipoAdm)
        {
            var resultado = true;

            try
            {
                var olstTempListado = ObtenerPedidoWebDetalle(pedidoInsertar);

                if (obePedidoWebDetalle.PedidoDetalleID == 0)
                {
                    if (olstTempListado.Any(p => p.CUV == obePedidoWebDetalle.CUV))
                        obePedidoWebDetalle.TipoPedido = "X";
                }
                else
                {
                    if (olstTempListado.Any(p => p.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID))
                        obePedidoWebDetalle.TipoPedido = "X";
                }

                if (tipoAdm == Constantes.PedidoAccion.INSERT)
                {
                    var cantidad = 0;
                    var result = ValidarInsercion(olstTempListado, obePedidoWebDetalle, out cantidad);
                    if (result != 0)
                    {
                        tipoAdm = Constantes.PedidoAccion.UPDATE;
                        obePedidoWebDetalle.Stock = obePedidoWebDetalle.Cantidad;
                        obePedidoWebDetalle.Cantidad += cantidad;
                        obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;
                        obePedidoWebDetalle.PedidoDetalleID = result;
                        obePedidoWebDetalle.Flag = 2;
                        obePedidoWebDetalle.OrdenPedidoWD = 1;
                    }
                }

                var totalClientes = CalcularTotalCliente(olstTempListado, obePedidoWebDetalle, tipoAdm == "D" ? obePedidoWebDetalle.PedidoDetalleID : (short)0, tipoAdm);
                var totalImporte = CalcularTotalImporte(olstTempListado, obePedidoWebDetalle, tipoAdm == "I" ? (short)0 : obePedidoWebDetalle.PedidoDetalleID, tipoAdm);

                obePedidoWebDetalle.ImporteTotalPedido = totalImporte;
                obePedidoWebDetalle.Clientes = totalClientes;

                obePedidoWebDetalle.CodigoUsuarioCreacion = pedidoInsertar.CodigoUsuario;
                obePedidoWebDetalle.CodigoUsuarioModificacion = pedidoInsertar.CodigoUsuario;

                var quitoCantBackOrder = false;
                if (tipoAdm == Constantes.PedidoAccion.UPDATE && obePedidoWebDetalle.PedidoDetalleID != 0)
                {
                    var oldPedidoWebDetalle = olstTempListado.FirstOrDefault(x => x.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID) ?? new BEPedidoWebDetalle();

                    if (oldPedidoWebDetalle.AceptoBackOrder && obePedidoWebDetalle.Cantidad < oldPedidoWebDetalle.Cantidad)
                        quitoCantBackOrder = true;
                }

                var indPedidoAutentico = new BEIndicadorPedidoAutentico
                {
                    PedidoID = obePedidoWebDetalle.PedidoID,
                    CampaniaID = obePedidoWebDetalle.CampaniaID,
                    PedidoDetalleID = obePedidoWebDetalle.PedidoDetalleID,
                    IndicadorIPUsuario = obePedidoWebDetalle.IPUsuario,
                    IndicadorFingerprint = string.Empty,
                    IndicadorToken = string.IsNullOrEmpty(pedidoInsertar.Identifier) ? string.Empty : AESAlgorithm.Encrypt(pedidoInsertar.Identifier)
                };
                obePedidoWebDetalle.IndicadorPedidoAutentico = indPedidoAutentico;

                switch (tipoAdm)
                {
                    case Constantes.PedidoAccion.INSERT:
                        _pedidoWebDetalleBusinessLogic.InsPedidoWebDetalle(obePedidoWebDetalle);
                        break;
                    case Constantes.PedidoAccion.UPDATE:
                        _pedidoWebDetalleBusinessLogic.UpdPedidoWebDetalle(obePedidoWebDetalle);
                        break;
                    case Constantes.PedidoAccion.DELETE:
                        _pedidoWebDetalleBusinessLogic.DelPedidoWebDetalle(obePedidoWebDetalle);
                        break;
                }

                if (tipoAdm == Constantes.PedidoAccion.UPDATE && quitoCantBackOrder)
                    _pedidoWebDetalleBusinessLogic.QuitarBackOrderPedidoWebDetalle(obePedidoWebDetalle);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoInsertar.ConsultoraID, pedidoInsertar.PaisID);
                resultado = false;
            }

            return resultado;
        }

        private short ValidarInsercion(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, out int cantidad)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            var obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV) ?? new BEPedidoWebDetalle();
            cantidad = obe.Cantidad;
            return obe.PedidoDetalleID;
        }

        private int CalcularTotalCliente(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            if (pedidoDetalleId == 0)
            {
                if (adm == Constantes.PedidoAccion.INSERT) temp.Add(itemPedido);
                else temp.Where(p => p.PedidoDetalleID == itemPedido.PedidoDetalleID).Update(p => p.ClienteID = itemPedido.ClienteID);
            }
            else
            {
                temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();
            }

            return temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string adm)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            if (pedidoDetalleId == 0) temp.Add(itemPedido);
            else temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();

            return temp.Sum(p => p.ImporteTotal) + (adm == "U" ? itemPedido.ImporteTotal : 0);
        }

        private void AgregarProductoZE(BEPedidoAppInsertar pedidoInsertar)
        {
            pedidoInsertar.OrigenPedidoWeb = pedidoInsertar.OrigenPedidoWeb < 0 ? 0 : pedidoInsertar.OrigenPedidoWeb;
            var tipoEstrategiaID = 0;
            int.TryParse(pedidoInsertar.Producto.TipoEstrategiaID, out tipoEstrategiaID);
            pedidoInsertar.Producto.TipoOfertaSisID = pedidoInsertar.Producto.TipoOfertaSisID > 0 ? pedidoInsertar.Producto.TipoOfertaSisID : tipoEstrategiaID;
            pedidoInsertar.Producto.ConfiguracionOfertaID = pedidoInsertar.Producto.ConfiguracionOfertaID > 0 ? pedidoInsertar.Producto.ConfiguracionOfertaID : pedidoInsertar.Producto.TipoOfertaSisID;

            EliminarDetallePackNueva(pedidoInsertar);
        }

        private void EliminarDetallePackNueva(BEPedidoAppInsertar pedidoInsertar)
        {
            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoInsertar);
            var packNuevas = lstPedidoWebDetalle.Where(x => x.FlagNueva && !x.EsOfertaIndependiente);

            foreach (var item in packNuevas)
            {
                DeletePedido(pedidoInsertar, item);
            }
        }

        private void DeletePedido(BEPedidoAppInsertar pedidoInsertar, BEPedidoWebDetalle obe)
        {
            AdministradorPedido(pedidoInsertar, obe, Constantes.PedidoAccion.DELETE);
        }
        #endregion
    }
}
