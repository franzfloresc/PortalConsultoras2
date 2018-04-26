using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Pedido.App;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;
using Portal.Consultoras.Data.ServiceCalculoPROL;

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
        private readonly IConsultoraConcursoBusinessLogic _consultoraConcursoBusinessLogic;
        private readonly IUsuarioBusinessLogic _usuarioBusinessLogic;
        private readonly IConsultorasProgramaNuevasBusinessLogic _consultorasProgramaNuevasBusinessLogic;
        private readonly IEscalaDescuentoBusinessLogic _escalaDescuentoBusinessLogic;
        private readonly IMensajeMetaConsultoraBusinessLogic _mensajeMetaConsultoraBusinessLogic;
        private readonly IClienteBusinessLogic _clienteBusinessLogic;

        private List<ObjMontosProl> montosProl = new List<ObjMontosProl> { new ObjMontosProl() };

        public BLPedidoApp() : this(new BLProducto(), 
                                    new BLPedidoWeb(),
                                    new BLPedidoWebDetalle(),
                                    new BLEstrategia(),
                                    new BLConfiguracionProgramaNuevas(),
                                    new BLConsultoraConcurso(),
                                    new BLUsuario(),
                                    new BLConsultorasProgramaNuevas(),
                                    new BLEscalaDescuento(),
                                    new BLMensajeMetaConsultora(),
                                    new BLCliente())
        { }

        public BLPedidoApp(IProductoBusinessLogic productoBusinessLogic, 
                            IPedidoWebBusinessLogic pedidoWebBusinessLogic,
                            IPedidoWebDetalleBusinessLogic pedidoWebDetalleBusinessLogic,
                            IEstrategiaBusinessLogic estrategiaBusinessLogic,
                            IConfiguracionProgramaNuevasBusinessLogic configuracionProgramaNuevasBusinessLogic,
                            IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic,
                            IUsuarioBusinessLogic usuarioBusinessLogic,
                            IConsultorasProgramaNuevasBusinessLogic consultorasProgramaNuevasBusinessLogic,
                            IEscalaDescuentoBusinessLogic escalaDescuentoBusinessLogic,
                            IMensajeMetaConsultoraBusinessLogic mensajeMetaConsultoraBusinessLogic,
                            IClienteBusinessLogic clienteBusinessLogic)
        {
            _productoBusinessLogic = productoBusinessLogic;
            _pedidoWebBusinessLogic = pedidoWebBusinessLogic;
            _pedidoWebDetalleBusinessLogic = pedidoWebDetalleBusinessLogic;
            _estrategiaBusinessLogic = estrategiaBusinessLogic;
            _configuracionProgramaNuevasBusinessLogic = configuracionProgramaNuevasBusinessLogic;
            _consultoraConcursoBusinessLogic = consultoraConcursoBusinessLogic;
            _usuarioBusinessLogic = usuarioBusinessLogic;
            _consultorasProgramaNuevasBusinessLogic = consultorasProgramaNuevasBusinessLogic;
            _escalaDescuentoBusinessLogic = escalaDescuentoBusinessLogic;
            _mensajeMetaConsultoraBusinessLogic = mensajeMetaConsultoraBusinessLogic;
        }

        public BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar)
        {
            try
            {
                //Informacion de usuario y palancas
                var usuario = productoBuscar.Usuario;
                usuario = _usuarioBusinessLogic.GetSesionUsuarioPedidoApp(usuario);

                //Validación producto no existe
                var producto = _productoBusinessLogic.SelectProductoByCodigoDescripcionSearchRegionZona(
                                    productoBuscar.PaisID,
                                    usuario.CampaniaID,
                                    productoBuscar.CodigoDescripcion,
                                    usuario.RegionID,
                                    usuario.ZonaID,
                                    usuario.CodigorRegion,
                                    usuario.CodigoZona,
                                    productoBuscar.Criterio,
                                    productoBuscar.RowCount,
                                    productoBuscar.ValidarOpt).FirstOrDefault();
                if (producto == null) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validación producto en catalogos
                var bloqueoProductoCatalogo = BloqueoProductosCatalogo(usuario.RevistaDigital, usuario.CodigosRevistaImpresa, producto, productoBuscar);
                if (!bloqueoProductoCatalogo) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validación Gana +
                var bloqueoProductoDigitales = BloqueoProductosDigitales(usuario, producto, productoBuscar);
                if (!bloqueoProductoDigitales) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validación producto agotado
                if (!producto.TieneStock) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_AGOTADO, null, producto);

                //Validación producto liquidaciones
                if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_LIQUIDACION, null, producto);

                //Validación producto showroom
                if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
                {
                    if (usuario.EsShowRoom) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_SHOWROOM, null, producto);
                    else return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_SHOWROOM_NODISPONIBLE, null, producto);
                }

                //Información de producto con oferta en revista
                if (usuario.RevistaDigital != null)
                {
                    var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(productoBuscar.PaisID,
                                                    usuario.CampaniaID,
                                                    usuario.CodigoZona);
                    var tieneRDC = usuario.RevistaDigital.TieneRDC && usuario.RevistaDigital.EsActiva;
                    if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
                    {
                        if (WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoBuscar.PaisID))) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA, null, producto);
                        else return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL, null, producto);
                    }
                }

                return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.SUCCESS, null, producto);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, productoBuscar.Usuario.CodigoUsuario, productoBuscar.PaisID);
                return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.ProductoBuscar.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoDetalleAppInsertarResult Insert(BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            var mensaje = string.Empty;

            try
            {
                //Informacion de usuario
                var usuario = pedidoDetalle.Usuario;
                usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);

                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                    usuario.ConsultoraID,
                                                                    usuario.CampaniaID,
                                                                    usuario.UsuarioPrueba == 1,
                                                                    usuario.AceptacionConsultoraDA);

                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Validar stock
                var result = ValidarStockEstrategia(usuario, pedidoDetalle, out mensaje);
                if (!result) return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                if (pedidoDetalle.Producto.TipoOfertaSisID == 0)
                {
                    var tipoEstrategiaID = 0;
                    int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);
                    pedidoDetalle.Producto.TipoOfertaSisID = tipoEstrategiaID;
                }

                var esOfertaNueva = (pedidoDetalle.Producto.FlagNueva == "1");
                if (esOfertaNueva) AgregarProductoZE(usuario, pedidoDetalle);

                var codeResult = PedidoInsertar(usuario, pedidoDetalle);
                if (codeResult != Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS) return PedidoInsertarRespuesta(codeResult);

                UpdateProl(usuario, pedidoDetalle);

                return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoWeb Get(BEUsuario usuario)
        {
            var pedido = new BEPedidoWeb();

            try
            {
                pedido = _pedidoWebBusinessLogic.GetPedidoWebByCampaniaConsultora(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);

                var pedidoID = 0;
                var pedidoBuscar = new BEPedidoAppBuscar()
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var pedidos = ObtenerPedidoWebDetalle(pedidoBuscar, out pedidoID);
                pedidos.Where(x => x.ClienteID == 0).Update(x => x.NombreCliente = usuario.Nombre);
                pedido.olstBEPedidoWebDetalle = pedidos;

                pedido.CantidadProductos = pedidos.Sum(p => p.Cantidad);
                pedido.CantidadCuv = pedidos.Count;

                pedido.TippingPoint = 0;
                if (usuario.MontoMaximoPedido > 0)
                {
                    var tp = GetConfiguracionProgramaNuevas(usuario);

                    if (tp.IndExigVent == "1")
                    {
                        var obeConsultorasProgramaNuevas = GetConsultorasProgramaNuevas(usuario, tp.CodigoPrograma);
                        if (obeConsultorasProgramaNuevas != null) pedido.TippingPoint = obeConsultorasProgramaNuevas.MontoVentaExigido;
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.ConsultoraID, usuario.PaisID);
            }

            return pedido;
        }

        public bool InsertKitInicio(BEUsuario usuario)
        {
            var flagkit = false;

            try
            {
                //Informacion de usuario
                usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);

                if (!usuario.EsConsultoraNueva)
                {
                    //Kit de nuevas para segundo y tercer pedido
                    if (usuario.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
                        usuario.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
                        usuario.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
                    {
                        var PaisesFraccionKit = WebConfig.PaisesFraccionKitNuevas;
                        if (!PaisesFraccionKit.Contains(usuario.CodigoISO)) return false;
                        flagkit = true;
                    }

                    if (!flagkit) return false;
                }
                if (usuario.DiaPROL && !EsHoraReserva(usuario, DateTime.Now.AddHours(usuario.ZonaHoraria))) return false;

                var obeConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas(usuario);
                if (obeConfiguracionProgramaNuevas == null) return false;
                if (!flagkit && obeConfiguracionProgramaNuevas.IndProgObli != "1") return false;

                var bePedidoWebDetalleParametros = new BEPedidoAppBuscar
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var PedidoID = 0;
                var listaTempListado = ObtenerPedidoWebDetalle(bePedidoWebDetalleParametros, out PedidoID);
                var det = listaTempListado.FirstOrDefault(d => d.CUV == obeConfiguracionProgramaNuevas.CUVKit) ?? new BEPedidoWebDetalle();
                if (det.PedidoDetalleID > 0) return false;

                var olstProducto = _productoBusinessLogic.SelectProductoToKitInicio(usuario.PaisID, usuario.CampaniaID, obeConfiguracionProgramaNuevas.CUVKit);
                var producto = olstProducto.FirstOrDefault();
                if (producto != null)
                {
                    var tipoEstrategiaID = 0;
                    int.TryParse(producto.TipoEstrategiaID, out tipoEstrategiaID);

                    var detalle = new BEPedidoDetalleAppInsertar()
                    {
                        PaisID = usuario.PaisID,
                        Cantidad = 1,
                        Producto = new BEProducto()
                        {
                            CUV = obeConfiguracionProgramaNuevas.CUVKit,
                            PrecioCatalogo = producto.PrecioCatalogo,
                            TipoEstrategiaID = tipoEstrategiaID.ToString(),
                            TipoOfertaSisID = 0,
                            ConfiguracionOfertaID = 0,
                            IndicadorMontoMinimo = producto.IndicadorMontoMinimo,
                            MarcaID = producto.MarcaID,
                        },
                        Usuario = usuario,
                        EsKitNueva = true
                    };

                    var result = PedidoInsertar(usuario, detalle);
                    if (result != Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS) return false;

                    return true;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
            }

            return false;
        }

        public object Update(BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            var mensaje = string.Empty;
            try
            {
                //Informacion de usuario y palancas
                var usuario = _usuarioBusinessLogic.GetSesionUsuarioPedidoApp(pedidoDetalle.Usuario);

                //Validacion reserve u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                                          usuario.ConsultoraID,
                                                                                          usuario.CampaniaID,
                                                                                          usuario.UsuarioPrueba == 1,
                                                                                          usuario.AceptacionConsultoraDA);

                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Validar stock
                var result = ValidarStockEstrategia(usuario, pedidoDetalle, out mensaje);
                if (!result) return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                //validar datos cliente
                var validacionDatos = InsertarMensajeValidarDatos(pedidoDetalle.ClienteID.ToString(), pedidoDetalle.PaisID, usuario.ConsultoraID,out mensaje);
                if (!validacionDatos) return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_VALIDA_DATOS, mensaje);

                //accion actualizar
                var accionActualizar = PedidoActualizar(usuario, pedidoDetalle);
                if (accionActualizar != Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS) return PedidoInsertarRespuesta(accionActualizar);

                //actualiza PROL
                UpdateProl(usuario, pedidoDetalle);

                return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS);

            }
            catch (Exception ex)
            {

                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoInsertarRespuesta(Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_INTERNO, ex.Message);
            }
            
        }

        #region GetCUV
        private bool BloqueoProductosCatalogo(BERevistaDigital revistaDigital, string codigosRevistaImpresa, BEProducto producto, BEProductoAppBuscar productoBuscar)
        {
            if (producto == null) return true;

            revistaDigital = revistaDigital ?? new BERevistaDigital();

            if (!revistaDigital.TieneRDC) return true;

            if (!revistaDigital.EsActiva) return true;

            if (revistaDigital.BloquearRevistaImpresaGeneral != null)
            {
                if (revistaDigital.BloquearRevistaImpresaGeneral == 1) return !codigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
            }
            else
            {
                if (revistaDigital.BloqueoRevistaImpresa) return !codigosRevistaImpresa.Contains(producto.CodigoCatalogo.ToString());
            }

            return true;
        }

        private bool BloqueoProductosDigitales(BEUsuario usuario, BEProducto producto, BEProductoAppBuscar productoBuscar)
        {
            var result = true;

            if (producto == null) return true;

            if (usuario.RevistaDigital != null && usuario.RevistaDigital.BloqueoProductoDigital)
            {
                result = !(
                            producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                          || producto.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                        );
            }

            if (result && usuario.OfertaDelDiaModel != null && usuario.OfertaDelDiaModel.BloqueoProductoDigital)
            {
                result = (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaDelDia);
            }

            if (result && usuario.GuiaNegocio != null && usuario.GuiaNegocio.BloqueoProductoDigital)
            {
                result = (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
            }

            if (result && usuario.OptBloqueoProductoDigital)
            {
                result = (producto.TipoEstrategiaCodigo != Constantes.TipoEstrategiaCodigo.OfertaParaTi);
            }

            if (result && usuario.RevistaDigital.TieneRDCR)
            {
                var dato = usuario.GuiaNegocio.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RDR.BloquearProductoGnd) ?? new BEConfiguracionPaisDatos();
                dato.Valor1 = Util.Trim(dato.Valor1);
                if (dato.Estado && dato.Valor1 != string.Empty)
                {
                    result = (!dato.Valor1.Contains(producto.CUV));
                }
            }

            return result;
        }

        private BEProductoApp ProductoBuscarRespuesta(string codigoRespuesta, string mensajeRespuesta = null, BEProducto producto = null)
        {
            return new BEProductoApp()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.ProductoBuscar.Message[codigoRespuesta] : mensajeRespuesta,
                Producto = producto
            };
        }
        #endregion

        #region Insert
        private BEPedidoDetalleAppInsertarResult PedidoInsertarRespuesta(string codigoRespuesta, string mensajeRespuesta = null)
        {
            return new BEPedidoDetalleAppInsertarResult()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.PedidoInsertar.Message[codigoRespuesta] : mensajeRespuesta
            };
        }

        private bool ValidarStockEstrategia(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle, out string mensaje)
        {
            var resultado = false;
            mensaje = string.Empty;

            mensaje = ValidarMontoMaximo(usuario, pedidoDetalle, out resultado);

            if (mensaje == string.Empty || resultado)
                mensaje = ValidarStockEstrategiaMensaje(usuario, pedidoDetalle);

            return mensaje == string.Empty || resultado;
        }

        private string ValidarMontoMaximo(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle, out bool resul)
        {
            var mensaje = string.Empty;
            resul = false;

            if (!usuario.TieneValidacionMontoMaximo)
                return mensaje;

            if (usuario.MontoMaximoPedido == Convert.ToDecimal(9999999999.00))
                return mensaje;

            var pedidoDetalleBuscar = new BEPedidoAppBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            var pedidoID = 0;
            var listaProducto = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;

            var totalPedido = listaProducto.Sum(p => p.ImporteTotal);
            var descuentoProl = listaProducto.Any() ? listaProducto[0].DescuentoProl : 0;

            if (totalPedido > usuario.MontoMaximoPedido && pedidoDetalle.Cantidad < 0)
                resul = true;

            var montoActual = (pedidoDetalle.Producto.PrecioCatalogo * pedidoDetalle.Cantidad) + (totalPedido - descuentoProl);
            if (montoActual > usuario.MontoMaximoPedido)
            {
                var FechaHoy = DateTime.Now.AddHours(usuario.ZonaHoraria).Date;
                var EsDiasFacturacion = FechaHoy >= usuario.FechaInicioFacturacion.Date && FechaHoy <= usuario.FechaFinFacturacion.Date;

                var strmen = (EsDiasFacturacion ? "VALIDADO" : "GUARDADO");
                mensaje = string.Format("Haz superado el límite de tu línea de crédito de {0}{1}. Por favor modifica tu pedido para que sea {2} con éxito.", usuario.Simbolo, usuario.MontoMaximoPedido, strmen);
            }

            return mensaje;
        }

        private string ValidarStockEstrategiaMensaje(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            var mensaje = string.Empty;

            var tipoEstrategiaID = 0;
            int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);

            var entidad = new BEEstrategia
            {
                PaisID = pedidoDetalle.PaisID,
                Cantidad = pedidoDetalle.Cantidad,
                CUV2 = pedidoDetalle.Producto.CUV,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID.ToString(),
                FlagCantidad = tipoEstrategiaID
            };

            mensaje = _estrategiaBusinessLogic.ValidarStockEstrategia(entidad);

            mensaje = Util.Trim(mensaje);

            return mensaje == "OK" ? string.Empty : mensaje;
        }

        private string PedidoInsertar(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            var result = InsertarValidarKitInicio(usuario, pedidoDetalle);
            if (!result) return Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_KIT_INICIO;

            var tipoEstrategiaID = 0;
            int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);

            var obePedidoWebDetalle = new BEPedidoWebDetalle
            {
                PaisID = pedidoDetalle.PaisID,
                IPUsuario = pedidoDetalle.IPUsuario,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                PedidoID = pedidoDetalle.PedidoID,
                SubTipoOfertaSisID = 0,
                TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                CUV = pedidoDetalle.Producto.CUV,
                Cantidad = pedidoDetalle.Cantidad,
                PrecioUnidad = pedidoDetalle.Producto.PrecioCatalogo,
                TipoEstrategiaID = tipoEstrategiaID,
                OrigenPedidoWeb = Constantes.OrigenPedidoWeb.AppPedido,
                ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID,
                ClienteID = pedidoDetalle.ClienteID,
                OfertaWeb = false,
                IndicadorMontoMinimo = pedidoDetalle.Producto.IndicadorMontoMinimo,
                EsSugerido = false,
                EsKitNueva = pedidoDetalle.EsKitNueva,
                MarcaID = Convert.ToByte(pedidoDetalle.Producto.MarcaID),
                DescripcionProd = pedidoDetalle.Producto.Descripcion,
                ImporteTotal = pedidoDetalle.Cantidad * pedidoDetalle.Producto.PrecioCatalogo,
                Nombre = pedidoDetalle.ClienteID == 0 ? usuario.Nombre : pedidoDetalle.ClienteDescripcion
            };

            result = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, Constantes.PedidoAccion.INSERT);
            if (!result) return Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_GRABAR;

            return Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS;
        }

        private bool InsertarValidarKitInicio(BEUsuario usuario,BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            var resultado = true;

            if (usuario.EsConsultoraNueva)
            {
                var pedidoDetalleBuscar = new BEPedidoAppBuscar()
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var pedidoID = 0;
                var olstPedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                pedidoDetalle.PedidoID = pedidoID;
                var detCuv = olstPedidoWebDetalle.FirstOrDefault(d => d.CUV == pedidoDetalle.Producto.CUV) ?? new BEPedidoWebDetalle();
                detCuv.CUV = Util.Trim(detCuv.CUV);
                if (detCuv.CUV != string.Empty)
                {
                    var obeConfiguracionProgramaNuevas = GetConfiguracionProgramaNuevas(usuario);
                    if (obeConfiguracionProgramaNuevas.IndProgObli == "1" && obeConfiguracionProgramaNuevas.CUVKit == detCuv.CUV)
                        resultado = false;
                }
            }

            return resultado;
        }

        private BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(BEUsuario usuario)
        {
            var obeConfiguracionProgramaNuevas = new BEConfiguracionProgramaNuevas()
            {
                CampaniaInicio = usuario.CampaniaID.ToString(),
                CodigoRegion = usuario.CodigorRegion,
                CodigoZona = usuario.CodigoZona
            };

            if (usuario.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva ||
                    usuario.ConsultoraNueva == Constantes.EstadoActividadConsultora.Reactivada ||
                    usuario.ConsecutivoNueva == Constantes.ConsecutivoNuevaConsultora.Consecutivo3)
            {
                var PaisesFraccionKit = WebConfig.PaisesFraccionKitNuevas;
                if (PaisesFraccionKit.Contains(usuario.CodigoISO))
                {
                    obeConfiguracionProgramaNuevas.CodigoNivel = usuario.ConsecutivoNueva == 1 ? "02" : usuario.ConsecutivoNueva == 2 ? "03" : string.Empty;
                    obeConfiguracionProgramaNuevas = _configuracionProgramaNuevasBusinessLogic.GetConfiguracionProgramaDespuesPrimerPedido(usuario.PaisID, obeConfiguracionProgramaNuevas);
                }
            }
            else
            {
                obeConfiguracionProgramaNuevas = _configuracionProgramaNuevasBusinessLogic.GetConfiguracionProgramaNuevas(usuario.PaisID, obeConfiguracionProgramaNuevas);
            }

            return obeConfiguracionProgramaNuevas;
        }

        private bool AdministradorPedido(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle, BEPedidoWebDetalle obePedidoWebDetalle, 
            string tipoAdm)
        {
            var resultado = true;

            var pedidoDetalleBuscar = new BEPedidoAppBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            var pedidoID = 0;
            var olstTempListado = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;

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

            obePedidoWebDetalle.CodigoUsuarioCreacion = pedidoDetalle.Usuario.CodigoUsuario;
            obePedidoWebDetalle.CodigoUsuarioModificacion = pedidoDetalle.Usuario.CodigoUsuario;

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
                IndicadorToken = string.IsNullOrEmpty(pedidoDetalle.Identifier) ? string.Empty : AESAlgorithm.Encrypt(pedidoDetalle.Identifier)
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

        private void AgregarProductoZE(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            //pedidoDetalle.OrigenPedidoWeb = Constantes.OrigenPedidoWeb.AppPedido;
            var tipoEstrategiaID = 0;
            int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);
            pedidoDetalle.Producto.TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID > 0 ? pedidoDetalle.Producto.TipoOfertaSisID : tipoEstrategiaID;
            pedidoDetalle.Producto.ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID > 0 ? pedidoDetalle.Producto.ConfiguracionOfertaID : pedidoDetalle.Producto.TipoOfertaSisID;

            EliminarDetallePackNueva(usuario, pedidoDetalle);
        }

        private void EliminarDetallePackNueva(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            var pedidoDetalleBuscar = new BEPedidoAppBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            var pedidoID = 0;
            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;
            var packNuevas = lstPedidoWebDetalle.Where(x => x.FlagNueva && !x.EsOfertaIndependiente);

            foreach (var item in packNuevas)
            {
                DeletePedido(usuario, pedidoDetalle, item);
            }
        }

        private void DeletePedido(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle, BEPedidoWebDetalle obe)
        {
            AdministradorPedido(usuario, pedidoDetalle, obe, Constantes.PedidoAccion.DELETE);
        }

        private List<ObjMontosProl> ServicioProl_CalculoMontosProl(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            montosProl = new List<ObjMontosProl> { new ObjMontosProl() };

            var pedidoDetalleBuscar = new BEPedidoAppBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            var pedidoID = 0;
            var detallesPedidoWeb = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;

            if (detallesPedidoWeb.Any())
            {
                var cuvs = string.Join("|", detallesPedidoWeb.Select(p => p.CUV).ToArray());
                var cantidades = string.Join("|", detallesPedidoWeb.Select(p => p.Cantidad).ToArray());

                using (var sv = new ServicesCalculoPrecioNiveles())
                {
                    sv.Url = WebConfig.Ambiente.ToUpper() == "QA" ? WebConfig.QA_Prol_ServicesCalculos : WebConfig.PR_Prol_ServicesCalculos;
                    montosProl = sv.CalculoMontosProlxIncentivos(usuario.CodigoISO, usuario.CampaniaID.ToString(), usuario.CodigoConsultora, usuario.CodigoZona, cuvs, cantidades, pedidoDetalle.CodigosConcursos).ToList();
                    montosProl = montosProl ?? new List<ObjMontosProl>();
                }
            }

            return montosProl;
        }

        private void UpdateProl(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle)
        {
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;
            var puntajes = string.Empty;
            var puntajesExigidos = string.Empty;

            var lista = ServicioProl_CalculoMontosProl(usuario, pedidoDetalle);

            if (lista.Any())
            {
                var oRespuestaProl = lista[0];

                decimal.TryParse(oRespuestaProl.AhorroCatalogo, out montoAhorroCatalogo);
                decimal.TryParse(oRespuestaProl.AhorroRevista, out montoAhorroRevista);
                decimal.TryParse(oRespuestaProl.MontoTotalDescuento, out montoDescuento);
                decimal.TryParse(oRespuestaProl.MontoEscala, out montoEscala);

                if (oRespuestaProl.ListaConcursoIncentivos != null)
                {
                    puntajes = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => c.puntajeconcurso.Split('|')[0]).ToArray());
                    puntajesExigidos = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => (c.puntajeconcurso.IndexOf('|') > -1 ? c.puntajeconcurso.Split('|')[1] : "0")).ToArray());
                }
            }

            var bePedidoWeb = new BEPedidoWeb
            {
                PaisID = pedidoDetalle.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                CodigoConsultora = usuario.CodigoConsultora,
                MontoAhorroCatalogo = montoAhorroCatalogo,
                MontoAhorroRevista = montoAhorroRevista,
                DescuentoProl = montoDescuento,
                MontoEscala = montoEscala
            };

            _pedidoWebBusinessLogic.UpdateMontosPedidoWeb(bePedidoWeb);

            if (!string.IsNullOrEmpty(pedidoDetalle.CodigosConcursos))
                _consultoraConcursoBusinessLogic.ActualizarInsertarPuntosConcurso(pedidoDetalle.PaisID, usuario.CodigoConsultora, usuario.CampaniaID.ToString(), pedidoDetalle.CodigosConcursos, puntajes, puntajesExigidos);
        }
        #endregion  

        #region Get
        private List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle(BEPedidoAppBuscar pedidoDetalle, out int pedidoID)
        {
            var detallesPedidoWeb = new List<BEPedidoWebDetalle>();

            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = pedidoDetalle.PaisID,
                CampaniaId = pedidoDetalle.CampaniaID,
                ConsultoraId = pedidoDetalle.ConsultoraID,
                Consultora = pedidoDetalle.NombreConsultora,
                CodigoPrograma = pedidoDetalle.CodigoPrograma,
                NumeroPedido = pedidoDetalle.ConsecutivoNueva
            };

            detallesPedidoWeb = _pedidoWebDetalleBusinessLogic.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();

            pedidoID = detallesPedidoWeb.Any() ? detallesPedidoWeb.First().PedidoID : 0;

            return detallesPedidoWeb;
        }

        private BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(BEUsuario usuario, string codigoPrograma)
        {
            var obeConsultorasProgramaNuevas = new BEConsultorasProgramaNuevas
            {
                CodigoConsultora = usuario.CodigoConsultora,
                Campania = usuario.CampaniaID.ToString(),
                CodigoPrograma = codigoPrograma
            };

            return _consultorasProgramaNuevasBusinessLogic.GetConsultorasProgramaNuevas(usuario.PaisID, obeConsultorasProgramaNuevas);
        }
        #endregion

        #region InsertKitInicio
        private bool EsHoraReserva(BEUsuario usuario, DateTime fechaHora)
        {
            if (!usuario.DiaPROL) return false;

            var horaNow = new TimeSpan(fechaHora.Hour, fechaHora.Minute, 0);
            var esHorarioReserva = (fechaHora < usuario.FechaInicioFacturacion) ?
                (horaNow > usuario.HoraInicioNoFacturable && horaNow < usuario.HoraCierreNoFacturable) :
                (horaNow > usuario.HoraInicio && horaNow < usuario.HoraFin);

            if (!esHorarioReserva) return false;

            if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru) return (BuildFechaNoHabil(usuario) == 0);

            return true;
        }

        public int BuildFechaNoHabil(BEUsuario usuario)
        {
            var result = 0;

            if (usuario.RolID != 0) result = _pedidoWebBusinessLogic.GetFechaNoHabilFacturacion(usuario.PaisID, usuario.CodigoZona, DateTime.Today);

            return result;
        }
        #endregion

        #region Update
        private string PedidoActualizar(BEUsuario usuario, BEPedidoDetalleAppInsertar pedidoDetalle) {

            var obePedidoWebDetalle = new BEPedidoWebDetalle
            {
                PaisID = pedidoDetalle.PaisID,
                CampaniaID = usuario.CampaniaID,
                PedidoID = pedidoDetalle.PedidoID,
                PedidoDetalleID = Convert.ToInt16(pedidoDetalle.PedidoDetalleID),
                Cantidad = Convert.ToInt32(pedidoDetalle.Cantidad),
                PrecioUnidad = pedidoDetalle.Producto.PrecioCatalogo,
                ClienteID = pedidoDetalle.ClienteID,
                CUV = pedidoDetalle.Producto.CUV,
                TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                //Stock = model.Stock,
                //Flag = model.Flag,
                DescripcionProd = pedidoDetalle.Producto.Descripcion,
                ImporteTotal = pedidoDetalle.Cantidad * pedidoDetalle.Producto.PrecioCatalogo,
                Nombre = pedidoDetalle.ClienteID == 0 ? usuario.Nombre : pedidoDetalle.ClienteDescripcion
            };

            var result = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, Constantes.PedidoAccion.UPDATE);
            if (!result) return Constantes.PedidoAppValidacion.PedidoInsertar.Code.ERROR_ACTUALIZAR;

            return Constantes.PedidoAppValidacion.PedidoInsertar.Code.SUCCESS;
        }

        private bool InsertarMensajeValidarDatos(string clienteIdStr, int paisID, long consultoraID, out string mensaje)
        {
            var result = true;
            mensaje = string.Empty;
            if (string.IsNullOrEmpty(clienteIdStr))
                return mensaje == string.Empty || result;

            var clienteId = Convert.ToInt32(clienteIdStr);

            if (clienteId > 0)
            {
                var cliente = _clienteBusinessLogic.SelectByConsultoraByCodigo(paisID, consultoraID, clienteId, 0);
                if (cliente.TieneTelefono == 0){
                    result = false;
                    mensaje = "Debe actualizar los datos del cliente.";
                } 
            }

            return mensaje == string.Empty || result; ;
        }

        #endregion

        #region ConfiguracionPedido
        private BEPedidoBarra GetDataBarra(BEUsuario usuario)
        {
            var objR = new BEPedidoBarra
            {
                ListaEscalaDescuento = new List<BEEscalaDescuento>(),
                ListaMensajeMeta = new List<BEMensajeMetaConsultora>()
            };

            objR.ListaEscalaDescuento = _escalaDescuentoBusinessLogic.GetEscalaDescuento(usuario.PaisID) ?? new List<BEEscalaDescuento>();
            var entity = new BEMensajeMetaConsultora() { TipoMensaje = string.Empty };
            objR.ListaMensajeMeta = _mensajeMetaConsultoraBusinessLogic.GetMensajeMetaConsultora(usuario.PaisID, entity) ?? new List<BEMensajeMetaConsultora>();

            return objR;
        }
        #endregion
    }
}
