using Portal.Consultoras.BizLogic.Reserva;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data.ServiceCalculoPROL;
using Portal.Consultoras.Data.ServicePROL;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.ReservaProl;
using Portal.Consultoras.PublicService.Cryptography;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedido : IPedidoBusinessLogic
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
        private readonly IReservaBusinessLogic _reservaBusinessLogic;
        private readonly ITipoEstrategiaBusinessLogic _tipoEstrategiaBusinessLogic;
        private readonly IEstrategiaProductoBusinessLogic _estrategiaProductoBusinessLogic;
        private readonly IPedidoWebSetBusinessLogic _pedidoWebSetBusinessLogic;
        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;
        private readonly IOfertaProductoBusinessLogic _ofertaProductoBusinessLogic;

        public BLPedido() : this(new BLProducto(),
                                    new BLPedidoWeb(),
                                    new BLPedidoWebDetalle(),
                                    new BLEstrategia(),
                                    new BLConfiguracionProgramaNuevas(),
                                    new BLConsultoraConcurso(),
                                    new BLUsuario(),
                                    new BLConsultorasProgramaNuevas(),
                                    new BLEscalaDescuento(),
                                    new BLMensajeMetaConsultora(),
                                    new BLReserva(),
                                    new BLTipoEstrategia(),
                                    new BLEstrategiaProducto(),
                                    new BLPedidoWebSet(),
                                    new BLTablaLogicaDatos(),
                                    new BLOfertaProducto())
        { }

        public BLPedido(IProductoBusinessLogic productoBusinessLogic,
                            IPedidoWebBusinessLogic pedidoWebBusinessLogic,
                            IPedidoWebDetalleBusinessLogic pedidoWebDetalleBusinessLogic,
                            IEstrategiaBusinessLogic estrategiaBusinessLogic,
                            IConfiguracionProgramaNuevasBusinessLogic configuracionProgramaNuevasBusinessLogic,
                            IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic,
                            IUsuarioBusinessLogic usuarioBusinessLogic,
                            IConsultorasProgramaNuevasBusinessLogic consultorasProgramaNuevasBusinessLogic,
                            IEscalaDescuentoBusinessLogic escalaDescuentoBusinessLogic,
                            IMensajeMetaConsultoraBusinessLogic mensajeMetaConsultoraBusinessLogic,
                            IReservaBusinessLogic reservaBusinessLogic,
                            ITipoEstrategiaBusinessLogic tipoEstrategiaBusinessLogic,
                            IEstrategiaProductoBusinessLogic estrategiaProductoBusinessLogic,
                            IPedidoWebSetBusinessLogic pedidoWebSetBusinessLogic,
                            ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic,
                            IOfertaProductoBusinessLogic ofertaProductoBusinessLogic)
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
            _reservaBusinessLogic = reservaBusinessLogic;
            _tipoEstrategiaBusinessLogic = tipoEstrategiaBusinessLogic;
            _estrategiaProductoBusinessLogic = estrategiaProductoBusinessLogic;
            _pedidoWebSetBusinessLogic = pedidoWebSetBusinessLogic;
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
            _ofertaProductoBusinessLogic = ofertaProductoBusinessLogic;
        }

        #region Publicos
        public BEPedidoProducto GetCUV(BEPedidoProductoBuscar productoBuscar)
        {
            try
            {
                //Informacion de palancas
                var usuario = productoBuscar.Usuario;
                var configuracionPaisTask = Task.Run(() => _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.RevistaDigital));
                var codigosRevistasTask = Task.Run(() => _usuarioBusinessLogic.ObtenerCodigoRevistaFisica(usuario.PaisID));

                Task.WaitAll(configuracionPaisTask, codigosRevistasTask);

                usuario = configuracionPaisTask.Result;
                usuario.CodigosRevistaImpresa = codigosRevistasTask.Result;

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
                if (producto == null) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validación producto en catalogos
                var bloqueoProductoCatalogo = BloqueoProductosCatalogo(usuario.RevistaDigital, usuario.CodigosRevistaImpresa, producto);
                if (!bloqueoProductoCatalogo) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validacion Tipo Estrategia
                var validacionTipoEstrategia = BloqueoTipoEstrategia(productoBuscar.PaisID, producto.TipoEstrategiaID);
                if (!string.IsNullOrEmpty(validacionTipoEstrategia)) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_ESTRATEGIA, validacionTipoEstrategia);

                //Validación producto agotado
                if (!producto.TieneStock) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_AGOTADO, null, producto);

                //Validación producto liquidaciones
                if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_LIQUIDACION, null, producto);

                //Validacción producto sugerido
                if (producto.TieneSugerido > 0) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_SUGERIDO, null, producto);

                //Información de producto con oferta en revista
                if (usuario.RevistaDigital != null)
                {
                    var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(productoBuscar.PaisID,
                                                    usuario.CampaniaID,
                                                    usuario.CodigoZona);
                    var tieneRDC = usuario.RevistaDigital.TieneRDC && usuario.RevistaDigital.EsActiva;
                    if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
                    {
                        if (WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoBuscar.PaisID))) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA, null, producto);
                        else return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL, null, producto);
                    }
                }

                return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.SUCCESS, null, producto);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, productoBuscar.Usuario.CodigoUsuario, productoBuscar.PaisID);
                return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoDetalleResult Insert(BEPedidoDetalle pedidoDetalle)
        {
            var mensaje = string.Empty;

            try
            {
                //Informacion de usuario
                var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);
                usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);

                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                    usuario.ConsultoraID,
                                                                    usuario.CampaniaID,
                                                                    usuario.UsuarioPrueba == 1,
                                                                    usuario.AceptacionConsultoraDA);
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Obtener Detalle
                var pedidoDetalleBuscar = new BEPedidoBuscar()
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var pedidoID = 0;
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                pedidoDetalle.PedidoID = pedidoID;

                //Validar stock
                var result = ValidarStockEstrategia(usuario, pedidoDetalle, lstDetalle, out mensaje);
                if (!result) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                if (pedidoDetalle.Producto.TipoOfertaSisID == 0)
                {
                    var tipoEstrategiaID = 0;
                    int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);
                    pedidoDetalle.Producto.TipoOfertaSisID = tipoEstrategiaID;
                }

                var esOfertaNueva = (pedidoDetalle.Producto.FlagNueva == "1");
                if (esOfertaNueva)
                {
                    AgregarProductoZE(usuario, pedidoDetalle, lstDetalle);
                }
                else
                {
                    var codeResult = PedidoInsertar(usuario, pedidoDetalle, lstDetalle, false);
                    if (codeResult != Constantes.PedidoValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(codeResult);
                }

                //Actualizar Prol
                var existe = lstDetalle.FirstOrDefault(x => x.ClienteID == pedidoDetalle.ClienteID && x.CUV == pedidoDetalle.Producto.CUV);
                if (existe != null)
                {
                    existe.Cantidad += pedidoDetalle.Cantidad;
                }
                else
                {
                    lstDetalle.Add(new BEPedidoWebDetalle()
                    {
                        CUV = pedidoDetalle.Producto.CUV,
                        Cantidad = pedidoDetalle.Cantidad,
                        ClienteID = pedidoDetalle.ClienteID
                    });
                }

                UpdateProl(usuario, lstDetalle);

                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoWeb Get(BEUsuario usuario)
        {
            //Inicio método 
            var pedido = new BEPedidoWeb();
            var userData = usuario;

            try
            {
                usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.RevistaDigital);

                //Obtener  Cabecera 
                pedido = _pedidoWebBusinessLogic.GetPedidoWebByCampaniaConsultora(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);

                var lista = getListaNuevasDescripciones(userData.PaisID);
                var pedidoValidado = getPedidoValidado(userData);
                var suscritaActiva = (usuario.RevistaDigital.EsSuscrita == true && usuario.RevistaDigital.EsActiva == true);

                if (pedido == null) return pedido;

                //Obtener Detalle
                var pedidoID = 0;
                var lstDetalle = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);

                pedido.ImporteTotal = lstDetalle.Sum(x => x.ImporteTotal);

                if (lstDetalle.Any())
                {
                    lstDetalle.Where(x => x.ClienteID == 0).Update(x => x.Nombre = usuario.Nombre);

                    lstDetalle.Update(x => x.DescripcionEstrategia = Util.obtenerNuevaDescripcionProductoDetalle(
                        x.ConfiguracionOfertaID,
                        pedidoValidado,
                        x.FlagConsultoraOnline,
                        x.OrigenPedidoWeb,
                        lista,
                        suscritaActiva,
                        x.TipoEstrategiaCodigo,
                        x.MarcaID,
                        x.CodigoCatalago,
                        x.DescripcionOferta));

                    lstDetalle.Where(x => x.EsKitNueva).Update(x => x.DescripcionEstrategia = Constantes.PedidoDetalleApp.DescripcionKitInicio);
                    lstDetalle.Where(x => x.IndicadorOfertaCUV && x.TipoEstrategiaID == 0).Update
                                    (x => x.DescripcionEstrategia = Constantes.PedidoDetalleApp.OfertaNiveles);

                    pedido.olstBEPedidoWebDetalle = lstDetalle;

                    pedido.CantidadProductos = lstDetalle.Sum(p => p.Cantidad);
                    pedido.CantidadCuv = lstDetalle.Count;
                }

                //Programa nuevas
                if (usuario.MontoMaximoPedido > 0)
                {
                    var tippingPoint = _configuracionProgramaNuevasBusinessLogic.Get(usuario);
                    if (tippingPoint.IndExigVent == "1") pedido.TippingPoint = tippingPoint.MontoVentaExigido;
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
            try
            {
                if (usuario.EsConsultoraOficina) return false;
                if (usuario.DiaPROL && !EsHoraReserva(usuario, DateTime.Now.AddHours(usuario.ZonaHoraria))) return false;

                var confProgNuevas = _configuracionProgramaNuevasBusinessLogic.Get(usuario);
                if (confProgNuevas.IndProgObli != "1") return false;

                usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);
                string cuvKitNuevas = _configuracionProgramaNuevasBusinessLogic.GetCuvKitNuevas(usuario, confProgNuevas);
                if (string.IsNullOrEmpty(cuvKitNuevas)) return false;

                //Obtener Detalle
                var bePedidoWebDetalleParametros = new BEPedidoBuscar
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var PedidoID = 0;
                var lstDetalle = ObtenerPedidoWebDetalle(bePedidoWebDetalleParametros, out PedidoID);
                var det = lstDetalle.FirstOrDefault(d => d.CUV == cuvKitNuevas) ?? new BEPedidoWebDetalle();
                if (det.PedidoDetalleID > 0) return false;

                var olstProducto = _productoBusinessLogic.SelectProductoToKitInicio(usuario.PaisID, usuario.CampaniaID, cuvKitNuevas);
                var producto = olstProducto.FirstOrDefault();
                if (producto != null)
                {
                    var tipoEstrategiaID = 0;
                    int.TryParse(producto.TipoEstrategiaID, out tipoEstrategiaID);

                    var detalle = new BEPedidoDetalle()
                    {
                        PaisID = usuario.PaisID,
                        Cantidad = 1,
                        Producto = new BEProducto()
                        {
                            CUV = cuvKitNuevas,
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

                    var result = PedidoInsertar(usuario, detalle, lstDetalle, true);
                    if (result != Constantes.PedidoValidacion.Code.SUCCESS) return false;

                    lstDetalle.Add(new BEPedidoWebDetalle()
                    {
                        CUV = detalle.Producto.CUV,
                        Cantidad = 1,
                        ClienteID = 0
                    });

                    UpdateProl(usuario, lstDetalle);

                    return true;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
            }
            return false;
        }

        public BEPedidoDetalleResult Update(BEPedidoDetalle pedidoDetalle)
        {
            var mensaje = string.Empty;
            try
            {
                //Informacion de usuario y palancas
                var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);

                //Validacion reserve u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                                          usuario.ConsultoraID,
                                                                                          usuario.CampaniaID,
                                                                                          usuario.UsuarioPrueba == 1,
                                                                                          usuario.AceptacionConsultoraDA);

                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Obtener Detalle
                var pedidoDetalleBuscar = new BEPedidoBuscar()
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var pedidoID = 0;
                var lstDetalleApp = new List<BEPedidoDetalle>();
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                pedidoDetalle.PedidoID = pedidoID;

                if (pedidoDetalle.SetID > 0)
                {
                    var pedidoExiste = lstDetalle.FirstOrDefault(x => x.CUV == pedidoDetalle.Producto.CUV);
                    pedidoDetalle.PedidoDetalleID = pedidoExiste == null ? (short)0 : pedidoExiste.PedidoDetalleID;

                    var detallePedido = _pedidoWebDetalleBusinessLogic.GetPedidoWebSetDetalle(pedidoDetalle.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                    detallePedido.Where(p => p.SetId == pedidoDetalle.SetID).ToList().ForEach(p => p.Cantidad = pedidoDetalle.Cantidad * p.FactorRepeticion);

                    var set = _pedidoWebSetBusinessLogic.Obtener(pedidoDetalle.PaisID, pedidoDetalle.SetID);
                    foreach (var detalleSet in set.Detalles)
                    {

                        var oBePedidoWebSetDetalle = new BEPedidoDetalle
                        {
                            PaisID = pedidoDetalle.PaisID,
                            PedidoID = pedidoDetalle.PedidoID,
                            PedidoDetalleID = Convert.ToInt16(detalleSet.PedidoDetalleId),
                            Cantidad = detallePedido.Where(p => p.PedidoDetalleId == detalleSet.PedidoDetalleId).Sum(p => p.Cantidad * p.FactorRepeticion),
                            ClienteID = string.IsNullOrEmpty(usuario.Nombre) ? (short)0 : Convert.ToInt16(pedidoDetalle.ClienteID),
                            ClienteDescripcion = pedidoDetalle.ClienteDescripcion,
                            ImporteTotal = detallePedido.Where(p => p.PedidoDetalleId == detalleSet.PedidoDetalleId).Sum(p => p.Cantidad * p.FactorRepeticion) * detalleSet.FactorRepeticion * detalleSet.PrecioUnidad,
                            Producto = new BEProducto()
                            {
                                PrecioCatalogo = set.PrecioUnidad,
                                CUV = detalleSet.CuvProducto,
                                TipoOfertaSisID = detalleSet.TipoOfertaSisId,
                                Descripcion = pedidoDetalle.Producto.Descripcion
                            }
                        };
                        lstDetalleApp.Add(oBePedidoWebSetDetalle);
                    }
                }
                else
                {
                    pedidoDetalle.ImporteTotal = pedidoDetalle.Cantidad * pedidoDetalle.Producto.PrecioCatalogo;
                    lstDetalleApp.Add(pedidoDetalle);
                }

                // lista auxiliar para validar stock y cliente
                var lstDetalleAux = lstDetalle;
                lstDetalleAux.Where(x => x.PedidoDetalleID == pedidoDetalle.PedidoDetalleID).Update(x => x.ClienteID = pedidoDetalle.ClienteID);

                //Validar stock
                var result = ValidarStockEstrategia(usuario, pedidoDetalle, lstDetalle, out mensaje);
                if (!result) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                //accion actualizar
                foreach (BEPedidoDetalle detalle in lstDetalleApp)
                {
                    var accionActualizar = PedidoActualizar(usuario, detalle, lstDetalle);
                    if (accionActualizar != Constantes.PedidoValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(accionActualizar);
                }

                if (pedidoDetalle.SetID > 0)
                {
                    var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                    {
                        PaisId = usuario.PaisID,
                        CampaniaId = usuario.CampaniaID,
                        ConsultoraId = usuario.ConsultoraID,
                        Consultora = usuario.Nombre,
                        EsBpt = false,   //no se usa
                        CodigoPrograma = usuario.CodigoPrograma,
                        NumeroPedido = usuario.ConsecutivoNueva,
                        AgruparSet = true
                    };
                    _pedidoWebDetalleBusinessLogic.UpdCantidadPedidoWebSet(pedidoDetalle.PaisID, pedidoDetalle.SetID, pedidoDetalle.Cantidad, bePedidoWebDetalleParametros);
                }

                //actualizar PROL
                var item = lstDetalle.FirstOrDefault(x => x.CUV == pedidoDetalle.Producto.CUV && x.ClienteID == pedidoDetalle.ClienteID);
                if (item != null)
                {
                    item.Cantidad = pedidoDetalle.Cantidad;
                    item.ClienteID = pedidoDetalle.ClienteID;
                }

                UpdateProl(usuario, lstDetalle);

                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }

        }

        public BEConfiguracionPedido GetConfiguracion(int paisID, string codigoUsuario)
        {
            var config = new BEConfiguracionPedido();

            try
            {
                config.Barra = GetDataBarra(paisID);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
            }

            return config;
        }

        public async Task<BEPedidoDetalleResult> Delete(BEPedidoDetalle pedidoDetalle)
        {
            var lstPedidoDetalleIds = new List<short>();

            try
            {
                //Informacion de usuario
                var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.RevistaDigital);
                usuario.PaisID = pedidoDetalle.PaisID;

                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                usuario.ConsultoraID,
                                                                usuario.CampaniaID,
                                                                usuario.UsuarioPrueba == 1,
                                                                usuario.AceptacionConsultoraDA);
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);


                //Obtener Detalle
                var pedidoDetalleBuscar = new BEPedidoBuscar()
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var pedidoID = 0;
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);

                //Eliminar Detalle
                var responseCode = Constantes.PedidoValidacion.Code.SUCCESS;

                if (pedidoDetalle.Producto == null)
                {
                    responseCode = await DeleteAll(usuario, pedidoDetalle);
                }
                else
                {
                    if (pedidoDetalle.SetID > 0)
                    {
                        var set = _pedidoWebSetBusinessLogic.Obtener(usuario.PaisID, pedidoDetalle.SetID);
                        if (set == null) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_SET_NOENCONTRADO);

                        foreach (var detalle in set.Detalles)
                        {
                            var pedidoWebDetalle = lstDetalle.FirstOrDefault(p => p.CUV == detalle.CuvProducto);
                            if (pedidoWebDetalle == null) continue;

                            lstPedidoDetalleIds.Add(pedidoWebDetalle.PedidoDetalleID);
                            pedidoDetalle.PedidoDetalleID = pedidoWebDetalle.PedidoDetalleID;

                            var cantidad = pedidoWebDetalle.Cantidad - (set.Cantidad * detalle.FactorRepeticion);
                            if (cantidad > 0)
                            {
                                var obePedidoWebDetalle = new BEPedidoWebDetalle
                                {
                                    PaisID = usuario.PaisID,
                                    CampaniaID = usuario.CampaniaID,
                                    Nombre = pedidoWebDetalle.ClienteID == 0 ? usuario.Nombre : pedidoWebDetalle.Nombre,
                                    TipoOfertaSisID = pedidoWebDetalle.TipoOfertaSisID,
                                    DescripcionProd = pedidoWebDetalle.DescripcionProd,
                                    Stock = pedidoWebDetalle.Stock,
                                    Flag = pedidoWebDetalle.Flag,
                                    ClienteID = string.IsNullOrEmpty(pedidoWebDetalle.Nombre) ? (short)0 : Convert.ToInt16(pedidoWebDetalle.ClienteID),
                                    PedidoDetalleID = pedidoWebDetalle.PedidoDetalleID,
                                    PrecioUnidad = pedidoWebDetalle.PrecioUnidad,
                                    PedidoID = pedidoID,
                                    Cantidad = cantidad,
                                    CUV = detalle.CuvProducto,
                                    ImporteTotal = cantidad * pedidoWebDetalle.PrecioUnidad,
                                };

                                var resultUpd = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, lstDetalle, Constantes.PedidoAccion.UPDATE);
                                if (!resultUpd) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_ACTUALIZAR_SET);
                            }
                            else
                            {
                                var cantidadAnterior = pedidoDetalle.Cantidad;
                                pedidoDetalle.Cantidad = set.Cantidad * detalle.FactorRepeticion;
                                responseCode = DeletePedidoWeb(usuario, pedidoDetalle, lstDetalle);
                                if (responseCode != Constantes.PedidoValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(responseCode);
                                pedidoDetalle.Cantidad = cantidadAnterior;
                            }
                        }

                        var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                        {
                            PaisId = usuario.PaisID,
                            CampaniaId = usuario.CampaniaID,
                            ConsultoraId = usuario.ConsultoraID,
                            Consultora = usuario.Nombre,
                            EsBpt = false,   //no se usa
                            CodigoPrograma = usuario.CodigoPrograma,
                            NumeroPedido = usuario.ConsecutivoNueva,
                            AgruparSet = true
                        };
                        var result = _pedidoWebSetBusinessLogic.Eliminar(usuario.PaisID, pedidoDetalle.SetID, bePedidoWebDetalleParametros);
                        if (!result) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_ELIMINAR_SET);
                    }
                    else
                    {
                        lstPedidoDetalleIds.Add(pedidoDetalle.PedidoDetalleID);

                        responseCode = DeletePedidoWeb(usuario, pedidoDetalle, lstDetalle);
                        if (responseCode != Constantes.PedidoValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(responseCode);
                    }
                }

                //Actualizar Prol
                if (pedidoDetalle.Producto != null)
                {
                    var item = lstDetalle.FirstOrDefault(x => lstPedidoDetalleIds.Any(y => y == x.PedidoDetalleID));
                    if (item != null) lstDetalle.Remove(item);
                }
                else
                {
                    lstDetalle = new List<BEPedidoWebDetalle>();
                }
                UpdateProl(usuario, lstDetalle);

                //Desreservar pedido PROL
                if (!lstDetalle.Any() && pedidoDetalle.Producto != null && usuario.ZonaValida)
                {
                    using (var sv = new ServiceStockSsic())
                    {
                        sv.Url = ConfigurarUrlServiceProl(usuario.CodigoISO);
                        sv.wsDesReservarPedido(usuario.CodigoConsultora, usuario.CodigoISO);
                    }
                }

                return PedidoDetalleRespuesta(responseCode);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public async Task<BEPedidoReservaResult> Reserva(BEUsuario usuario)
        {
            BEResultadoReservaProl resultadoReserva;

            try
            {
                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(usuario.PaisID,
                                                                    usuario.ConsultoraID,
                                                                    usuario.CampaniaID,
                                                                    usuario.UsuarioPrueba == 1,
                                                                    usuario.AceptacionConsultoraDA);
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoReservaRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                ActualizarEsDiaPROLyMostrarBotonValidarPedido(usuario);

                var input = new BEInputReservaProl()
                {
                    PaisISO = usuario.CodigoISO,
                    FechaHoraReserva = usuario.DiaPROL && usuario.MostrarBotonValidar,
                    SegmentoInternoID = usuario.SegmentoInternoID == null ? 0 : Convert.ToInt32(usuario.SegmentoInternoID),
                    PaisID = usuario.PaisID,
                    Simbolo = usuario.Simbolo,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    CodigoUsuario = usuario.CodigoUsuario,
                    CodigoConsultora = usuario.CodigoConsultora,
                    NombreConsultora = usuario.Nombre,
                    CodigoZona = usuario.CodigoZona,
                    MontoMinimo = usuario.MontoMinimoPedido,
                    MontoMaximo = usuario.MontoMaximoPedido,
                    ConsultoraNueva = usuario.ConsultoraNueva,
                    ValidacionAbierta = usuario.ValidacionAbierta,
                    ZonaValida = usuario.ZonaValida,
                    ValidacionInteractiva = usuario.ValidacionInteractiva,
                    EnviarCorreo = false,
                    CodigosConcursos = usuario.CodigosConcursos,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };

                if(string.IsNullOrEmpty(usuario.CodigoZona))
                    resultadoReserva = await _reservaBusinessLogic.CargarSesionAndEjecutarReserva(usuario.CodigoISO, usuario.CampaniaID, usuario.ConsultoraID, usuario.usuarioPrueba, usuario.AceptacionConsultoraDA, true, false);
                else
                    resultadoReserva = await _reservaBusinessLogic.EjecutarReserva(input);

                var code = string.Empty;
                var enumReserva = (int)resultadoReserva.ResultadoReservaEnum;
                if (usuario.DiaPROL) code = (enumReserva + 2010).ToString();
                else code = (enumReserva + 2020).ToString();

                resultadoReserva.ListPedidoObservacion = resultadoReserva.ListPedidoObservacion ?? new List<BEPedidoObservacion>();
                resultadoReserva.ListDetalleBackOrder = resultadoReserva.ListDetalleBackOrder ?? new List<BEPedidoWebDetalle>();
                foreach (var item in resultadoReserva.ListDetalleBackOrder)
                {
                    resultadoReserva.ListPedidoObservacion.Add(new BEPedidoObservacion()
                    {
                        Caso = 8,
                        Descripcion = Constantes.PedidoValidacion.Message[Constantes.PedidoValidacion.Code.ERROR_RESERVA_BACK_ORDER],
                        CUV = item.CUV
                    });
                }

                if (resultadoReserva.ListPedidoObservacion.Count > 0)
                {
                    int pedidoID = 0;
                    var lstDetalle = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);
                    resultadoReserva.ListPedidoObservacion = ObtenerListPedidoObservacionPorDetalle(lstDetalle, resultadoReserva.ListPedidoObservacion,
                        usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID, pedidoID);
                }

                var obsPedido = ObtenerMensajePROLAnalytics(resultadoReserva.ListPedidoObservacion);

                return PedidoReservaRespuesta(code, obsPedido, resultadoReserva);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
                return PedidoReservaRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoDetalleResult ModificarReserva(BEUsuario usuario, BEPedidoWeb pedido = null)
        {
            var mensaje = string.Empty;

            try
            {
                //Obtener pedido
                pedido = pedido ?? _pedidoWebBusinessLogic.GetPedidoWebByCampaniaConsultora(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);

                //verificapedidoValidado
                if (!(pedido.EstadoPedido == Constantes.EstadoPedido.Procesado && !pedido.ModificaPedidoReservado && !pedido.ValidacionAbierta))
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_DESHACER_PEDIDO_ESTADO);

                //Deshacer Pedido 
                mensaje = _reservaBusinessLogic.DeshacerPedidoValidado(usuario, Constantes.EstadoPedido.PedidoValidado);
                if (mensaje != string.Empty) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_DESHACER_PEDIDO, mensaje);

                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public List<BEEstrategia> GetEstrategiaCarrusel(BEUsuario usuario)
        {
            var lstEstrategia = new List<BEEstrategia>();

            try
            {
                usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.RevistaDigital);
                var revistaDigital = usuario.RevistaDigital;

                var codAgrupa = (revistaDigital.TieneRDC && revistaDigital.EsActiva)
                    || (revistaDigital.TieneRDC && revistaDigital.ActivoMdo) ?
                    Constantes.TipoEstrategiaCodigo.RevistaDigital : string.Empty;

                lstEstrategia = ConsultarEstrategiasHomePedido(codAgrupa, usuario);

                lstEstrategia = lstEstrategia.Where(x => x.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();

                var carpetaPais = string.Format("{0}/{1}", Globals.UrlMatriz, usuario.CodigoISO);

                foreach (var item in lstEstrategia)
                {
                    item.PaisID = usuario.PaisID;
                    item.DescripcionCortaCUV2 = Util.SubStrCortarNombre(item.DescripcionCUV2, 40);
                    item.FotoProducto01 = ConfigCdn.GetUrlFileCdn(carpetaPais, item.FotoProducto01);
                    item.FotoProductoSmall = Util.GenerarRutaImagenResize(item.FotoProducto01, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall);
                    item.FotoProductoMedium = Util.GenerarRutaImagenResize(item.FotoProducto01, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium);
                    GetEstrategiaDetalleCarrusel(item);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.PaisID, usuario.CodigoUsuario);
            }

            return lstEstrategia ?? new List<BEEstrategia>();
        }

        public BEPedidoDetalleResult InsertEstrategiaCarrusel(BEPedidoDetalle pedidoDetalle)
        {
            try
            {
                var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);
                usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.RevistaDigital);

                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                    usuario.ConsultoraID,
                                                                    usuario.CampaniaID,
                                                                    usuario.UsuarioPrueba == 1,
                                                                    usuario.AceptacionConsultoraDA);
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Filtrar Estrategia Pedido
                var indFlagNueva = 0;
                int.TryParse(string.IsNullOrEmpty(pedidoDetalle.Producto.FlagNueva) ? "0" : pedidoDetalle.Producto.FlagNueva, out indFlagNueva);
                var estrategia = FiltrarEstrategiaPedido(pedidoDetalle.PaisID, pedidoDetalle.Producto.EstrategiaID, indFlagNueva);

                estrategia.Cantidad = pedidoDetalle.Cantidad;
                pedidoDetalle.Producto.PrecioCatalogo = estrategia.Precio2;

                var pedidoID = 0;
                var lstDetalleSets = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);
                lstDetalleSets = lstDetalleSets.Where(x => x.CUV == estrategia.CUV2 && x.SetID != 0).ToList();

                if (lstDetalleSets.Any())
                {
                    int CantidadActual = lstDetalleSets.Sum(x => x.Cantidad);

                    if (CantidadActual + pedidoDetalle.Cantidad > estrategia.LimiteVenta)
                    {
                        return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE, null, estrategia.LimiteVenta);
                    }
                }
                else
                {
                    if (estrategia.Cantidad > estrategia.LimiteVenta)
                    {
                        return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE, null, estrategia.LimiteVenta);
                    }
                }

                //Obtener Detalle
                var pedidoDetalleBuscar = new BEPedidoBuscar()
                {
                    PaisID = pedidoDetalle.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                pedidoDetalle.PedidoID = pedidoID;
                var mensaje = EstrategiaAgregarProducto(pedidoDetalle, usuario, estrategia, lstDetalle);
                if(!string.IsNullOrEmpty(mensaje)) PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                //Insertar pedido
                pedidoDetalle.OrigenPedidoWeb = usuario.RevistaDigital.TieneRevistaDigital() ?
                    Constantes.OrigenPedidoWeb.RevistaDigitalAppPedidoSeccion : Constantes.OrigenPedidoWeb.OfertasParaTiAppPedido;
                var codeResult = PedidoInsertar(usuario, pedidoDetalle, lstDetalle, false);
                if (codeResult != Constantes.PedidoValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(codeResult);

                //Actualizar Prol
                var existe = lstDetalle.FirstOrDefault(x => x.ClienteID == pedidoDetalle.ClienteID && x.CUV == pedidoDetalle.Producto.CUV);
                if (existe != null)
                {
                    existe.Cantidad += pedidoDetalle.Cantidad;
                }
                else
                {
                    lstDetalle.Add(new BEPedidoWebDetalle()
                    {
                        CUV = pedidoDetalle.Producto.CUV,
                        Cantidad = pedidoDetalle.Cantidad,
                        ClienteID = pedidoDetalle.ClienteID
                    });
                }
                UpdateProl(usuario, lstDetalle);

                //Agregar sets agrupados
                var strCuvs = string.Empty;
                var ListaCuvsTemporal = new List<string>();
                ListaCuvsTemporal.Add(estrategia.CUV2);
                if (ListaCuvsTemporal.Any())
                {
                    ListaCuvsTemporal.OrderByDescending(x => x).Distinct().ToList().ForEach(x =>
                    {
                        strCuvs = string.Format("{0}{1}:{2},", strCuvs, x, ListaCuvsTemporal.Count(a => a == x));
                    });
                }
                _pedidoWebDetalleBusinessLogic.InsertPedidoWebSet(usuario.PaisID, usuario.CampaniaID, pedidoDetalle.PedidoID, pedidoDetalle.Cantidad, estrategia.CUV2, usuario.ConsultoraID, string.Empty, strCuvs, estrategia.EstrategiaID, usuario.Nombre, usuario.CodigoPrograma, usuario.ConsecutivoNueva);

                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEUsuario GetConfiguracionOfertaFinalCarrusel(BEUsuario usuario)
        {
            try
            {
                //Obtener datos Oferta Final
                var lstCodigo = string.Format("{0}|{1}|{2}", Constantes.ConfiguracionPais.OfertaFinalTradicional,
                                                                Constantes.ConfiguracionPais.OfertaFinalCrossSelling,
                                                                Constantes.ConfiguracionPais.OfertaFinalRegaloSorpresa);
                usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, lstCodigo);
                //Obtener datos Revista Digital
                usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.RevistaDigital);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.PaisID, usuario.CodigoUsuario);
            }

            return usuario;
        }

        public BEPedidoDetalleResult InsertOfertaFinalCarrusel(BEPedidoDetalle pedidoDetalle)
        {
            try
            {
                var usuario = pedidoDetalle.Usuario;

                //Obtener  Cabecera 
                var pedido = _pedidoWebBusinessLogic.GetPedidoWebByCampaniaConsultora(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                var pedidoValidado = (pedido.EstadoPedido == Constantes.EstadoPedido.Procesado && !pedido.ModificaPedidoReservado && !pedido.ValidacionAbierta);
                if (pedidoValidado)
                {
                    var resultDR = ModificarReserva(usuario, pedido);
                    if (resultDR.CodigoRespuesta != Constantes.PedidoValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(resultDR.CodigoRespuesta);
                }

                var result = Insert(pedidoDetalle);
                if (result.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS)
                {
                    PedidoAgregarProductoAgrupado(usuario, pedido.PedidoID, pedidoDetalle.Cantidad, pedidoDetalle.Producto.CUV, pedidoDetalle.Producto.CUV, 0);

                    var tipoRegistro = Constantes.OfertaFinalLog.Code.PRODUCTO_AGREGADO;
                    var desTipoRegistro = Constantes.OfertaFinalLog.Message[tipoRegistro];

                    var entidad = new BEOfertaFinalConsultoraLog()
                    {
                        CampaniaID = pedidoDetalle.Usuario.CampaniaID,
                        CodigoConsultora = pedidoDetalle.Usuario.CodigoConsultora,
                        CUV = pedidoDetalle.Producto.CUV,
                        Cantidad = pedidoDetalle.Cantidad,
                        TipoOfertaFinal = "0",
                        GAP = 0,
                        TipoRegistro = tipoRegistro,
                        DesTipoRegistro = desTipoRegistro
                    };

                    _pedidoWebBusinessLogic.InsLogOfertaFinal(pedidoDetalle.PaisID, entidad);
                }

                return result;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public void InsertOfertaFinalLog(int paisID, int campaniaID, string codigoConsultora, decimal? montoInicial,
            List<BEOfertaFinalConsultoraLog> listaOfertaFinalLog)
        {
            var tipoOfertaFinal_Log = listaOfertaFinalLog.FirstOrDefault().TipoOfertaFinal;
            var tipoRegistro = Constantes.OfertaFinalLog.Code.POPUP_MOSTRADO;
            var desTipoRegistro = Constantes.OfertaFinalLog.Message[tipoRegistro];

            var entidad = new BEOfertaFinalConsultoraLog
            {
                CampaniaID = campaniaID,
                CodigoConsultora = codigoConsultora,
                CUV = string.Empty,
                Cantidad = 0,
                TipoOfertaFinal = tipoOfertaFinal_Log,
                GAP = 0,
                TipoRegistro = tipoRegistro,
                DesTipoRegistro = desTipoRegistro
            };
            if (tipoRegistro == 2)
            {
                entidad.MuestraPopup = false;
                entidad.MontoInicial = montoInicial;
            }

            tipoRegistro = Constantes.OfertaFinalLog.Code.PRODUCTO_EXPUESTO;
            desTipoRegistro = Constantes.OfertaFinalLog.Message[tipoRegistro];

            listaOfertaFinalLog.Update(x =>
            {
                x.TipoRegistro = tipoRegistro;
                x.DesTipoRegistro = desTipoRegistro;
            });

            _pedidoWebBusinessLogic.InsLogOfertaFinal(paisID, entidad);
            _pedidoWebBusinessLogic.InsLogOfertaFinalBulk(paisID, listaOfertaFinalLog);
        }

        public List<BEProducto> GetProductoSugerido(BEPedidoProductoBuscar productoBuscar)
        {
            var listaProductoSugerido = new List<BEProducto>();
            try
            {
                var usuario = productoBuscar.Usuario;
                var listaProductos = _productoBusinessLogic.GetProductoSugeridoByCUV(usuario.PaisID, usuario.CampaniaID, Convert.ToInt32(usuario.ConsultoraID), productoBuscar.CodigoDescripcion,
                                 usuario.RegionID, usuario.ZonaID, usuario.CodigorRegion, usuario.CodigoZona);

                var fechaHoy = DateTime.Now.AddHours(usuario.ZonaHoraria).Date;
                var esFacturacion = fechaHoy >= usuario.FechaInicioFacturacion.Date;

                var listaTieneStock = new List<Lista>();
                if (esFacturacion)
                {
                    var txtBuil = new StringBuilder();

                    foreach (var beProducto in listaProductos)
                    {
                        if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                        {
                            txtBuil.Append(string.Concat(beProducto.CodigoProducto, "|"));
                        }
                    }

                    var codigoSap = txtBuil.ToString();
                    codigoSap = codigoSap == string.Empty ? string.Empty : codigoSap.Substring(0, codigoSap.Length - 1);

                    try
                    {
                        if (!string.IsNullOrEmpty(codigoSap))
                        {
                            using (var sv = new wsConsulta())
                            {
                                sv.Url = WebConfig.PROL_Consultas;
                                listaTieneStock = sv.ConsultaStock(codigoSap, usuario.CodigoISO).ToList();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, productoBuscar.Usuario.CodigoUsuario, productoBuscar.PaisID);
                        listaTieneStock = new List<Lista>();
                    }

                }

                foreach (var producto in listaProductos)
                {
                    var tieneStockProl = true;
                    if (esFacturacion)
                    {
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == producto.CodigoProducto);
                        if (itemStockProl != null) tieneStockProl = itemStockProl.estado == 1;
                    }

                    if (producto.TieneStock && tieneStockProl)
                    {
                        listaProductoSugerido.Add(new BEProducto()
                        {
                            CUV = producto.CUV ?? string.Empty,
                            Descripcion = producto.Descripcion.Trim(),
                            PrecioCatalogo = producto.PrecioCatalogo,
                            MarcaID = producto.MarcaID,
                            EstaEnRevista = producto.EstaEnRevista,
                            TieneStock = true,
                            EsExpoOferta = producto.EsExpoOferta,
                            CUVRevista = producto.CUVRevista ?? string.Empty,
                            CUVComplemento = producto.CUVComplemento ?? string.Empty,
                            IndicadorMontoMinimo = producto.IndicadorMontoMinimo,
                            TipoOfertaSisID = producto.TipoOfertaSisID,
                            ConfiguracionOfertaID = producto.ConfiguracionOfertaID,
                            DescripcionMarca = producto.DescripcionMarca ?? string.Empty,
                            DescripcionEstrategia = producto.DescripcionEstrategia ?? string.Empty,
                            DescripcionCategoria = producto.DescripcionCategoria ?? string.Empty,
                            FlagNueva = producto.FlagNueva,
                            TipoEstrategiaID = producto.TipoEstrategiaID,
                            ImagenProductoSugerido = producto.ImagenProductoSugerido ?? string.Empty,
                            ImagenProductoSugeridoSmall = Util.ObtenerRutaImagenResize(producto.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall, productoBuscar.Usuario.CodigoISO),
                            ImagenProductoSugeridoMedium = Util.ObtenerRutaImagenResize(producto.ImagenProductoSugerido, Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium, productoBuscar.Usuario.CodigoISO),
                            CodigoProducto = producto.CodigoProducto
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, productoBuscar.Usuario.CodigoUsuario, productoBuscar.PaisID);
            }

            return listaProductoSugerido ?? new List<Entities.BEProducto>();
        }

        public BEPedidoDetalleResult AceptarBackOrderPedidoDetalle(BEPedidoDetalle pedidoDetalle)
        {
            //var mensaje = string.Empty;
            try
            {
                //Validación de Sets
                if (pedidoDetalle.PedidoDetalleID == 0 || pedidoDetalle.SetID != 0)
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_AGREGAR_BACKORDER_NO_PERMITIDO);

                //Informacion de usuario y palancas
                var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);

                //Validacion reserve u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                                          usuario.ConsultoraID,
                                                                                          usuario.CampaniaID,
                                                                                          usuario.UsuarioPrueba == 1,
                                                                                          usuario.AceptacionConsultoraDA);

                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Obtener Detalle
                var pedidoDetalleBuscar = new BEPedidoBuscar()
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var pedidoID = 0;
                //var lstDetalleApp = new List<BEPedidoDetalle>();
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                pedidoDetalle.PedidoID = pedidoID;

                //Seleccionamos el Detalle de Pedido a Aceptar
                var _pedidoDetalle = lstDetalle.FirstOrDefault(p => p.PedidoDetalleID == pedidoDetalle.PedidoDetalleID && p.EsBackOrder);

                if (_pedidoDetalle == null) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_AGREGAR_BACKORDER);

                _pedidoWebDetalleBusinessLogic.AceptarBackOrderPedidoWebDetalle(_pedidoDetalle);

                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoDetalleResult InsertProductoBuscador(BEPedidoDetalle pedidoDetalle)
        {
            try
            {
                switch(pedidoDetalle.TipoPersonalizacion)
                {
                    case Constantes.CodigoEstrategiaBuscador.Liquidacion:
                        return RegistroLiquidacion(pedidoDetalle);
                    case Constantes.CodigoEstrategiaBuscador.Catalogo:
                        return PedidoInsertarBuscador(pedidoDetalle);
                    default:
                        return PedidoAgregarProducto(pedidoDetalle);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }
        #endregion

        #region GetCUV
        private string BloqueoTipoEstrategia(int paisID, string tipoEstrategiaID)
        {
            if (string.IsNullOrEmpty(tipoEstrategiaID)) return string.Empty;

            var tipoEstrategiaRequest = new BETipoEstrategia()
            {
                PaisID = paisID,
                TipoEstrategiaID = Convert.ToInt32(tipoEstrategiaID)
            };
            var tipoEstrategiaResponse = _tipoEstrategiaBusinessLogic.GetTipoEstrategias(tipoEstrategiaRequest).FirstOrDefault();
            return (tipoEstrategiaResponse == null ? string.Empty : tipoEstrategiaResponse.MensajeValidacion);
        }

        private BEPedidoProducto ProductoBuscarRespuesta(string codigoRespuesta, string mensajeRespuesta = null, BEProducto producto = null)
        {
            return new BEPedidoProducto()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoValidacion.Message[codigoRespuesta] : mensajeRespuesta,
                Producto = producto
            };
        }

        private bool BloqueoProductosCatalogo(BERevistaDigital revistaDigital, string codigosRevistaImpresa, Entities.BEProducto producto)
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

        #endregion

        #region Insert
        private BEPedidoDetalleResult PedidoDetalleRespuesta(string codigoRespuesta, string mensajeRespuesta = null, params object[] args)
        {
            return new BEPedidoDetalleResult()
            {
                CodigoRespuesta = (codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA ||
                                    codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA_OBS ||
                                    codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_GUARDAR ||
                                    codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_GUARDAR_OBS ?
                                    Constantes.PedidoValidacion.Code.SUCCESS : codigoRespuesta),
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? string.Format(Constantes.PedidoValidacion.Message[codigoRespuesta], args) : mensajeRespuesta
            };
        }

        private bool ValidarStockEstrategia(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle,
            out string mensaje)
        {
            var resultado = false;
            mensaje = string.Empty;

            mensaje = ValidarMontoMaximo(usuario, pedidoDetalle, lstDetalle, out resultado);

            if (mensaje == string.Empty || resultado)
            {
                var item = lstDetalle.FirstOrDefault(x => x.CUV == pedidoDetalle.Producto.CUV && x.ClienteID == pedidoDetalle.ClienteID);
                var cantidadPedido = (item != null && (pedidoDetalle.PedidoDetalleID > 0 || pedidoDetalle.SetID > 0)) ? item.Cantidad : 0;
                var pedidoAuxiliar = new BEPedidoDetalle()
                {
                    Cantidad = pedidoDetalle.Cantidad - cantidadPedido,
                    PaisID = pedidoDetalle.PaisID,
                    Producto = new Entities.BEProducto()
                    {
                        TipoEstrategiaID = pedidoDetalle.Producto.TipoEstrategiaID,
                        CUV = pedidoDetalle.Producto.CUV
                    }
                };
                mensaje = ValidarStockEstrategiaMensaje(usuario, pedidoAuxiliar);
            }
            return mensaje == string.Empty || resultado;
        }

        private string ValidarMontoMaximo(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle,
            out bool resul)
        {
            resul = false;
            var mensaje = string.Empty;

            if (!usuario.TieneValidacionMontoMaximo)
                return mensaje;

            if (usuario.MontoMaximoPedido == Convert.ToDecimal(9999999999.00))
                return mensaje;

            var totalPedido = lstDetalle.Sum(p => p.ImporteTotal);
            var descuentoProl = lstDetalle.Any() ? lstDetalle.FirstOrDefault().DescuentoProl : 0;

            if (totalPedido > usuario.MontoMaximoPedido && pedidoDetalle.Cantidad < 0) resul = true;

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

        private string ValidarStockEstrategiaMensaje(BEUsuario usuario, BEPedidoDetalle pedidoDetalle)
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
        private string PedidoInsertar(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle, bool esKitNuevaAuto)
        {
            bool result;
            if (!esKitNuevaAuto)
            {
                result = InsertarValidarKitInicio(usuario, pedidoDetalle);
                if (!result) return Constantes.PedidoValidacion.Code.ERROR_KIT_INICIO;
            }

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
                OrigenPedidoWeb = pedidoDetalle.OrigenPedidoWeb,
                ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID,
                ClienteID = pedidoDetalle.ClienteID,
                OfertaWeb = false,
                IndicadorMontoMinimo = pedidoDetalle.Producto.IndicadorMontoMinimo,
                EsSugerido = pedidoDetalle.EsSugerido,
                EsKitNueva = pedidoDetalle.EsKitNueva,
                MarcaID = Convert.ToByte(pedidoDetalle.Producto.MarcaID),
                DescripcionProd = pedidoDetalle.Producto.Descripcion,
                ImporteTotal = pedidoDetalle.Cantidad * pedidoDetalle.Producto.PrecioCatalogo,
                Nombre = pedidoDetalle.ClienteID == 0 ? usuario.Nombre : pedidoDetalle.ClienteDescripcion
            };

            result = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, lstDetalle, Constantes.PedidoAccion.INSERT);
            if (!result) return Constantes.PedidoValidacion.Code.ERROR_GRABAR;

            return Constantes.PedidoValidacion.Code.SUCCESS;
        }

        private bool InsertarValidarKitInicio(BEUsuario usuario, BEPedidoDetalle pedidoDetalle)
        {
            var configProgNuevas = _configuracionProgramaNuevasBusinessLogic.Get(usuario);
            if (configProgNuevas.IndProgObli != "1") return true;

            var cuvKitNuevas = _configuracionProgramaNuevasBusinessLogic.GetCuvKitNuevas(usuario, configProgNuevas);
            if (string.IsNullOrEmpty(cuvKitNuevas)) return true;
            if (cuvKitNuevas != pedidoDetalle.Producto.CUV) return true;

            return false;
        }

        private bool AdministradorPedido(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, BEPedidoWebDetalle obePedidoWebDetalle,
            List<BEPedidoWebDetalle> lstDetalle, string tipoAdm)
        {
            var resultado = true;

            if (obePedidoWebDetalle.PedidoDetalleID == 0)
            {
                if (lstDetalle.Any(p => p.CUV == obePedidoWebDetalle.CUV))
                    obePedidoWebDetalle.TipoPedido = "X";
            }
            else
            {
                if (lstDetalle.Any(p => p.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID))
                    obePedidoWebDetalle.TipoPedido = "X";
            }

            if (tipoAdm == Constantes.PedidoAccion.INSERT)
            {
                var cantidad = 0;
                var result = ValidarInsercion(lstDetalle, obePedidoWebDetalle, out cantidad);
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

            var totalClientes = CalcularTotalCliente(lstDetalle, obePedidoWebDetalle, tipoAdm == Constantes.PedidoAccion.DELETE ? obePedidoWebDetalle.PedidoDetalleID : (short)0, tipoAdm);
            var totalImporte = CalcularTotalImporte(lstDetalle, obePedidoWebDetalle, tipoAdm == Constantes.PedidoAccion.INSERT ? (short)0 : obePedidoWebDetalle.PedidoDetalleID, tipoAdm);

            obePedidoWebDetalle.ImporteTotalPedido = totalImporte;
            obePedidoWebDetalle.Clientes = totalClientes;

            obePedidoWebDetalle.CodigoUsuarioCreacion = usuario.CodigoUsuario;
            obePedidoWebDetalle.CodigoUsuarioModificacion = usuario.CodigoUsuario;

            var quitoCantBackOrder = false;
            if (tipoAdm == Constantes.PedidoAccion.UPDATE && obePedidoWebDetalle.PedidoDetalleID != 0)
            {
                var oldPedidoWebDetalle = lstDetalle.FirstOrDefault(x => x.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID) ?? new BEPedidoWebDetalle();

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

            return temp.Sum(p => p.ImporteTotal) + (adm == Constantes.PedidoAccion.UPDATE ? itemPedido.ImporteTotal : 0);
        }

        private void AgregarProductoZE(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var tipoEstrategiaID = 0;
            int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);

            pedidoDetalle.Producto.TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID > 0 ? pedidoDetalle.Producto.TipoOfertaSisID : tipoEstrategiaID;
            pedidoDetalle.Producto.ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID > 0 ? pedidoDetalle.Producto.ConfiguracionOfertaID : pedidoDetalle.Producto.TipoOfertaSisID;

            PedidoInsertar(usuario, pedidoDetalle, lstDetalle, true);
        }
        #endregion  

        #region Get
        private List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle(BEPedidoBuscar pedidoDetalle, out int pedidoID)
        {
            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = pedidoDetalle.PaisID,
                CampaniaId = pedidoDetalle.CampaniaID,
                ConsultoraId = pedidoDetalle.ConsultoraID,
                Consultora = pedidoDetalle.NombreConsultora,
                CodigoPrograma = pedidoDetalle.CodigoPrograma,
                NumeroPedido = pedidoDetalle.ConsecutivoNueva
            };
            var detallesPedidoWeb = _pedidoWebDetalleBusinessLogic.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros, false).ToList();
            pedidoID = detallesPedidoWeb.Any() ? detallesPedidoWeb.FirstOrDefault().PedidoID : 0;

            return detallesPedidoWeb;
        }

        private Dictionary<string, string> getListaNuevasDescripciones(int PaisID)
        {
            var lista = new Dictionary<string, string>();

            var result = _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatos(PaisID, Constantes.TablaLogica.NuevaDescripcionProductos);

            foreach (var item in result)
            {
                lista.Add(item.Codigo.ToString(), item.Descripcion.ToString());
            }

            return lista;
        }

        private bool getPedidoValidado(BEUsuario usuario)
        {
            BEConfiguracionCampania configuracionCampania;
            if (usuario.TipoUsuario == Constantes.TipoUsuario.Consultora)
            {
                configuracionCampania = _pedidoWebBusinessLogic.GetEstadoPedido(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID, usuario.ZonaID, usuario.RegionID);
            }
            else
            {
                configuracionCampania = new BEConfiguracionCampania
                {
                    CampaniaID = usuario.CampaniaID,
                    EstadoPedido = Constantes.EstadoPedido.Pendiente,
                    ModificaPedidoReservado = false,
                    ZonaValida = false,
                    CampaniaDescripcion = Convert.ToString(usuario.CampaniaID)
                };
            }

            if (configuracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado &&
                    !configuracionCampania.ModificaPedidoReservado &&
                    !configuracionCampania.ValidacionAbierta)
            {
                return true;
            }
            else
            {
                return false;
            }
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
        private string PedidoActualizar(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {

            var obePedidoWebDetalle = new BEPedidoWebDetalle
            {
                PaisID = pedidoDetalle.PaisID,
                CampaniaID = usuario.CampaniaID,
                PedidoID = pedidoDetalle.PedidoID,
                PedidoDetalleID = pedidoDetalle.PedidoDetalleID,
                Cantidad = Convert.ToInt32(pedidoDetalle.Cantidad),
                PrecioUnidad = pedidoDetalle.Producto.PrecioCatalogo,
                ClienteID = pedidoDetalle.ClienteID,
                CUV = pedidoDetalle.Producto.CUV,
                TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                DescripcionProd = pedidoDetalle.Producto.Descripcion,
                ImporteTotal = pedidoDetalle.ImporteTotal,
                Nombre = pedidoDetalle.ClienteID == 0 ? usuario.Nombre : pedidoDetalle.ClienteDescripcion,
                Flag = 2

            };

            var result = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, lstDetalle, Constantes.PedidoAccion.UPDATE);
            if (!result) return Constantes.PedidoValidacion.Code.ERROR_ACTUALIZAR;

            return Constantes.PedidoValidacion.Code.SUCCESS;
        }
        #endregion

        #region Configuracion
        private BEPedidoBarra GetDataBarra(int paisID)
        {
            var objR = new BEPedidoBarra
            {
                ListaEscalaDescuento = new List<BEEscalaDescuento>(),
                ListaMensajeMeta = new List<BEMensajeMetaConsultora>()
            };
            objR.ListaEscalaDescuento = _escalaDescuentoBusinessLogic.GetEscalaDescuento(paisID) ?? new List<BEEscalaDescuento>();

            var entity = new BEMensajeMetaConsultora() { TipoMensaje = string.Empty };
            objR.ListaMensajeMeta = _mensajeMetaConsultoraBusinessLogic.GetMensajeMetaConsultora(paisID, entity) ?? new List<BEMensajeMetaConsultora>();

            return objR;
        }
        #endregion

        #region Prol
        private List<ObjMontosProl> ServicioProl_CalculoMontosProl(BEUsuario usuario, List<BEPedidoWebDetalle> lstDetalle)
        {
            var montosProl = new List<ObjMontosProl>();

            if (lstDetalle.Any())
            {
                var cuvs = string.Join("|", lstDetalle.Select(p => p.CUV).ToArray());
                var cantidades = string.Join("|", lstDetalle.Select(p => p.Cantidad).ToArray());

                using (var sv = new ServicesCalculoPrecioNiveles())
                {
                    sv.Url = WebConfig.Ambiente.ToUpper() == "QA" ? WebConfig.QA_Prol_ServicesCalculos : WebConfig.PR_Prol_ServicesCalculos;
                    montosProl = sv.CalculoMontosProlxIncentivos(usuario.CodigoISO, usuario.CampaniaID.ToString(), usuario.CodigoConsultora, usuario.CodigoZona, cuvs, cantidades, usuario.CodigosConcursos).ToList();
                    montosProl = montosProl ?? new List<ObjMontosProl>();
                }
            }

            return montosProl;
        }

        private void UpdateProl(BEUsuario usuario, List<BEPedidoWebDetalle> lstDetalle)
        {
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;
            string codigoConcursosProl = string.Empty, puntajes = string.Empty, puntajesExigidos = string.Empty;

            var lista = ServicioProl_CalculoMontosProl(usuario, lstDetalle);

            if (lista.Any())
            {
                var oRespuestaProl = lista[0];

                decimal.TryParse(oRespuestaProl.AhorroCatalogo, out montoAhorroCatalogo);
                decimal.TryParse(oRespuestaProl.AhorroRevista, out montoAhorroRevista);
                decimal.TryParse(oRespuestaProl.MontoTotalDescuento, out montoDescuento);
                decimal.TryParse(oRespuestaProl.MontoEscala, out montoEscala);

                if (oRespuestaProl.ListaConcursoIncentivos != null)
                {
                    codigoConcursosProl = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => c.codigoconcurso));
                    puntajes = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => c.puntajeconcurso.Split('|')[0]));
                    puntajesExigidos = string.Join("|", oRespuestaProl.ListaConcursoIncentivos.Select(c => (c.puntajeconcurso.IndexOf('|') > -1 ? c.puntajeconcurso.Split('|')[1] : "0")));
                }
            }
            else
            {
                var lstConcursos = usuario.CodigosConcursos.Split('|');
                codigoConcursosProl = usuario.CodigosConcursos;
                puntajes = string.Join("|", lstConcursos.Select(c => 0));
                puntajesExigidos = string.Join("|", lstConcursos.Select(c => 0));
            }

            var bePedidoWeb = new BEPedidoWeb
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                CodigoConsultora = usuario.CodigoConsultora,
                MontoAhorroCatalogo = montoAhorroCatalogo,
                MontoAhorroRevista = montoAhorroRevista,
                DescuentoProl = montoDescuento,
                MontoEscala = montoEscala
            };
            _pedidoWebBusinessLogic.UpdateMontosPedidoWeb(bePedidoWeb);

            if (!string.IsNullOrEmpty(codigoConcursosProl))
                _consultoraConcursoBusinessLogic.ActualizarInsertarPuntosConcurso(usuario.PaisID, usuario.CodigoConsultora, usuario.CampaniaID.ToString(), codigoConcursosProl, puntajes, puntajesExigidos);
        }

        private string ConfigurarUrlServiceProl(string codigoISO)
        {
            var key = string.Concat("Prol_", codigoISO.Trim().ToUpper());
            return WebConfig.GetByTagName(key);
        }
        #endregion

        #region Reserva
        private void ActualizarEsDiaPROLyMostrarBotonValidarPedido(BEUsuario usuario)
        {
            var fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);

            usuario.DiaPROL = (usuario.FechaInicioFacturacion.AddDays(-usuario.DiasAntes) < fechaHoraActual
                && fechaHoraActual < usuario.FechaFinFacturacion.AddDays(1));

            usuario.MostrarBotonValidar = EsHoraReserva(usuario, fechaHoraActual);
        }

        private string ObtenerMensajePROLAnalytics(List<BEPedidoObservacion> lista)
        {
            if (lista == null || lista.Count == 0) return string.Empty;

            foreach (var item in lista)
            {
                if (!Regex.IsMatch(Util.SubStr(item.CUV, 0), @"^\d+$")) return item.Descripcion;
            }
            return string.Empty;
        }

        private BEPedidoReservaResult PedidoReservaRespuesta(string codigoRespuesta, string mensajeRespuesta = null,
            BEResultadoReservaProl resultadoReserva = null)
        {
            return new BEPedidoReservaResult()
            {
                CodigoRespuesta = (codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA ||
                                    codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA_OBS ||
                                    codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_GUARDAR ||
                                    codigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_GUARDAR_OBS ?
                                    Constantes.PedidoValidacion.Code.SUCCESS : codigoRespuesta),
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoValidacion.Message[codigoRespuesta] : mensajeRespuesta,
                ResultadoReserva = resultadoReserva,
            };
        }

        private List<BEPedidoWebDetalle> TraerHijosFaltantesEnObsPROL(List<BEPedidoWebDetalle> pedido, int paisId, int campaniaId, long consultoraId, int pedidoId)
        {
            var idSetList = pedido.Where(x => x.SetID != 0).Select(x => x.SetID);
            var cuvHijos = new List<BEPedidoWebDetalle>();
            if (idSetList.Any())
            {
                cuvHijos = _pedidoWebDetalleBusinessLogic.ObtenerCuvSetDetalle(paisId, campaniaId, consultoraId, pedidoId, string.Join(",", idSetList));
            }
            return cuvHijos;
        }

        private List<BEPedidoObservacion> ObtenerListPedidoObservacionPorDetalle(List<BEPedidoWebDetalle> pedidoDetalle, List<BEPedidoObservacion> listPedidoObservacion, int paisId, int campaniaId, long consultoraId, int pedidoId)
        {
            List<BEPedidoObservacion> ListPedidoObservacion = listPedidoObservacion
                                        .GroupBy(e => new { e.Caso, e.CUV, e.CuvObs, e.Descripcion, e.PedidoDetalleID, e.SetID, e.Tipo })
                                        .Select(g => g.FirstOrDefault())
                                         .ToList();

            List<BEPedidoObservacion> obsSets = new List<BEPedidoObservacion>();
            var detallesSets = TraerHijosFaltantesEnObsPROL(pedidoDetalle, paisId, campaniaId, consultoraId, pedidoId);
            if (detallesSets.Count > 0)
            {
                var listaCUVsAEvaluar = detallesSets.Select(e => e.CUV).ToList();
                var obsDetSets = ListPedidoObservacion.Where(e => listaCUVsAEvaluar.Contains(e.CUV)).ToList();
                obsSets = detallesSets.Join(obsDetSets, d => d.CUV, o => o.CUV,
                    (d, o) => new BEPedidoObservacion()
                    {
                        CUV = pedidoDetalle.Where(e => e.SetID == d.SetID).Select(e => e.CUV).FirstOrDefault(),
                        Caso = o.Caso,
                        CuvObs = o.CUV,
                        Descripcion = o.Descripcion,
                        SetID = d.SetID
                    }).ToList();
                ListPedidoObservacion.RemoveAll(x => obsDetSets.Contains(x));
            }
            if (ListPedidoObservacion.Count > 0)
            {
                var listaObsAEvaluar = ListPedidoObservacion;
                var obsDet = pedidoDetalle.Join(listaObsAEvaluar, d => d.CUV, o => o.CUV,
                     (d, o) => new BEPedidoObservacion()
                     {
                         CUV = d.CUV,
                         Caso = o.Caso,
                         CuvObs = o.CUV,
                         Descripcion = o.Descripcion,
                         PedidoDetalleID = d.PedidoDetalleID
                     }).ToList();
                var listaCUVsAEvaluados = obsDet.Select(e => e.CUV).Distinct();
                ListPedidoObservacion.RemoveAll(x => listaCUVsAEvaluados.Contains(x.CUV));
                ListPedidoObservacion.AddRange(obsDet);
            }
            if (obsSets.Count > 0) ListPedidoObservacion.AddRange(obsSets);

            return ListPedidoObservacion.OrderBy(e => e.PedidoDetalleID).ToList();
        }
        #endregion

        #region Delete
        private async Task<string> DeleteAll(BEUsuario usuario, BEPedidoDetalle pedidoDetalle)
        {
            var pedidoID = 0;
            var lstAgrupados = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);

            var result = await _pedidoWebDetalleBusinessLogic.DelPedidoWebDetalleMasivo(usuario, pedidoDetalle.PedidoID);
            if (!result) return Constantes.PedidoValidacion.Code.ERROR_ELIMINAR_TODO;

            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = usuario.PaisID,
                CampaniaId = usuario.CampaniaID,
                ConsultoraId = usuario.ConsultoraID,
                Consultora = usuario.Nombre,
                EsBpt = false,   //no se usa
                CodigoPrograma = usuario.CodigoPrograma,
                NumeroPedido = usuario.ConsecutivoNueva,
                AgruparSet = true
            };

            foreach (var agrupado in lstAgrupados)
            {
                if (agrupado.SetID == 0) continue;

                result = _pedidoWebSetBusinessLogic.Eliminar(usuario.PaisID, agrupado.SetID, bePedidoWebDetalleParametros);
                if (!result) return Constantes.PedidoValidacion.Code.ERROR_ELIMINAR_TODO_SET;
            }

            return Constantes.PedidoValidacion.Code.SUCCESS;
        }

        private string DeletePedidoWeb(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            //Eliminar detalle pedido
            var obePedidoWebDetalle = new BEPedidoWebDetalle
            {
                PaisID = pedidoDetalle.PaisID,
                CampaniaID = usuario.CampaniaID,
                PedidoID = pedidoDetalle.PedidoID,
                PedidoDetalleID = pedidoDetalle.PedidoDetalleID,
                TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                CUV = pedidoDetalle.Producto.CUV,
                Cantidad = pedidoDetalle.Cantidad,
                Mensaje = pedidoDetalle.ObservacionPROL
            };

            var result = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, lstDetalle, Constantes.PedidoAccion.DELETE);
            if (!result) return Constantes.PedidoValidacion.Code.ERROR_ELIMINAR;

            return Constantes.PedidoValidacion.Code.SUCCESS;
        }
        #endregion

        #region EstrategiaCarrusel
        private List<BEEstrategia> ConsultarEstrategiasHomePedido(string codAgrupacion, BEUsuario usuario)
        {
            var revistaDigital = usuario.RevistaDigital;
            var listModel = ConsultarEstrategias(codAgrupacion, usuario);

            if (!listModel.Any()) return new List<BEEstrategia>();

            if (codAgrupacion == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            {
                var estrategiaLanzamiento = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento) ?? new BEEstrategia();

                listModel = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();

                if (!listModel.Any() && estrategiaLanzamiento.EstrategiaID <= 0) return new List<BEEstrategia>();

                var listaPackNueva = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas).ToList();

                var listaRevista = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi).ToList();

                if (revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
                    listaRevista = listaRevista.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor0).ToList();

                var cantMax = 8;
                var cantPack = listaPackNueva.Any() ? 1 : 0;
                var top = Math.Min(cantMax - cantPack, listaRevista.Count);

                if (listaRevista.Count > top)
                    listaRevista.RemoveRange(top, listaRevista.Count - top);

                if (listaPackNueva.Count > 0 && listaPackNueva.Count > cantMax - top)
                    listaPackNueva.RemoveRange(cantMax - top, listaPackNueva.Count - (cantMax - top));

                listModel = new List<BEEstrategia>();
                if (estrategiaLanzamiento.EstrategiaID > 0)
                    listModel.Add(estrategiaLanzamiento);

                listModel.AddRange(listaPackNueva);
                listModel.AddRange(listaRevista);
            }

            return listModel;
        }

        private List<BEEstrategia> ConsultarEstrategias(string codAgrupacion, BEUsuario usuario)
        {
            var listEstrategia = new List<BEEstrategia>();

            switch (codAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, usuario));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, usuario));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.RevistaDigital, usuario));
                    break;
                default:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, usuario));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, usuario));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaParaTi, usuario));
                    break;
            }

            return listEstrategia;
        }

        private List<BEEstrategia> ConsultarEstrategiasPorTipo(string tipo, BEUsuario usuario)
        {
            var entidad = new BEEstrategia
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.UsuarioPrueba == 1 ? usuario.ConsultoraAsociada : usuario.CodigoConsultora,
                Zona = usuario.ZonaID.ToString(),
                ZonaHoraria = usuario.ZonaHoraria,
                FechaInicioFacturacion = usuario.FechaFinFacturacion,
                ValidarPeriodoFacturacion = true,
                Simbolo = usuario.Simbolo,
                CodigoTipoEstrategia = tipo
            };

            var listEstrategia = _estrategiaBusinessLogic.GetEstrategiasPedido(entidad);
            if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
                listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia, usuario);

            return listEstrategia;
        }

        private List<BEEstrategia> ConsultarEstrategiasFiltrarPackNuevasPedido(List<BEEstrategia> listEstrategia, BEUsuario usuario)
        {
            var pedidoDetalleBuscar = new BEPedidoBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };

            var pedidoID = 0;
            var pedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            listEstrategia = listEstrategia.Where(e => !pedidoWebDetalle.Any(d => d.CUV == e.CUV2)).ToList();

            return listEstrategia;
        }

        private void GetEstrategiaDetalleCarrusel(BEEstrategia estrategia)
        {
            var joinCuv = string.Empty;

            var listaProducto = GetEstrategiaDetalleCodigoSAP(estrategia, out joinCuv);
            if (joinCuv == string.Empty) return;

            estrategia.EstrategiaProductoCodigoSAP = joinCuv;
            estrategia.EstrategiaProducto = listaProducto;
        }

        private List<BEEstrategiaProducto> GetEstrategiaDetalleCodigoSAP(BEEstrategia estrategia, out string codigoSap)
        {
            codigoSap = "";
            var separador = "|";

            var txtBuil = new StringBuilder();
            txtBuil.Append(separador);

            if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.IndividualConTonos)
            {
                var listaHermanosE = _productoBusinessLogic.GetListBrothersByCUV(estrategia.PaisID, estrategia.CampaniaID, estrategia.CUV2).ToList();

                foreach (var item in listaHermanosE)
                {
                    item.CodigoSAP = Util.Trim(item.CodigoSAP);
                    if (item.CodigoSAP != string.Empty && !txtBuil.ToString().Contains(separador + item.CodigoSAP + separador))
                        txtBuil.Append(item.CodigoSAP + separador);
                }
            }

            var listaProducto = new List<BEEstrategiaProducto>();
            if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaFija || estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
            {
                listaProducto = _estrategiaProductoBusinessLogic.GetEstrategiaProducto(estrategia);

                foreach (var item in listaProducto)
                {
                    item.SAP = Util.Trim(item.SAP);
                    if (item.SAP != "" && !txtBuil.ToString().Contains(separador + item.SAP + separador))
                        txtBuil.Append(item.SAP + separador);
                }
            }

            codigoSap = txtBuil.ToString();

            if (codigoSap == separador)
                codigoSap = string.Empty;
            else
                codigoSap = codigoSap.Substring(separador.Length, codigoSap.Length - separador.Length * 2);

            return listaProducto;
        }
        #endregion

        #region InsertEstrategiaCarrusel
        private BEEstrategia FiltrarEstrategiaPedido(int paisID, int estrategiaID, int flagNueva = 0)
        {
            var entidad = new BEEstrategia
            {
                PaisID = paisID,
                EstrategiaID = estrategiaID,
                FlagNueva = flagNueva
            };

            var lst = _estrategiaBusinessLogic.FiltrarEstrategiaPedido(entidad);

            return lst.FirstOrDefault() ?? new BEEstrategia();
        }

        private string EstrategiaAgregarProducto(BEPedidoDetalle pedidoDetalle, BEUsuario usuario, BEEstrategia estrategia, List<BEPedidoWebDetalle> lstDetalle)
        {
            //Validar Stock Estrategia
            var ofertas = estrategia.DescripcionCUV2.Split('|');
            pedidoDetalle.Producto.Descripcion = ofertas[0];
            if (estrategia.FlagNueva == 1) estrategia.Cantidad = estrategia.LimiteVenta;
            else pedidoDetalle.Producto.Descripcion = estrategia.DescripcionCUV2;

            var resultado = false;
            var mensaje = ValidarMontoMaximo(usuario, pedidoDetalle, lstDetalle, out resultado);

            //Agregar Producto ZE
            if (mensaje == string.Empty || resultado)
            {
                AgregarProductoZE(usuario, pedidoDetalle, lstDetalle);
            }

            return mensaje;
        }
        #endregion

        #region Sets
        private List<BEPedidoWebDetalle> ObtenerPedidoWebSetDetalleAgrupado(BEUsuario usuario, out int pedidoID)
        {
            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = usuario.PaisID,
                CampaniaId = usuario.CampaniaID,
                ConsultoraId = usuario.ConsultoraID,
                Consultora = usuario.Nombre,
                EsBpt = usuario.RevistaDigital.EsOpt() == 1,
                CodigoPrograma = usuario.CodigoPrograma,
                NumeroPedido = usuario.ConsecutivoNueva,
                AgruparSet = true
            };

            var detallesPedidoWeb = _pedidoWebDetalleBusinessLogic.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();
            pedidoID = detallesPedidoWeb.Any() ? detallesPedidoWeb.FirstOrDefault().PedidoID : 0;

            return detallesPedidoWeb;
        }

        private void PedidoAgregarProductoAgrupado(BEUsuario usuario, int pedidoID, int cantidad, string cuv, string cuvlist, int estrategiaId)
        {
            var formatoPedidoWebSet = string.Empty;

            if (cuvlist.IndexOf(":") < 0)
                formatoPedidoWebSet = string.Format("{0}:1", cuvlist);
            else
                formatoPedidoWebSet = cuvlist;

            _pedidoWebDetalleBusinessLogic.InsertPedidoWebSet(usuario.PaisID, usuario.CampaniaID, pedidoID, cantidad, cuv
                    , usuario.ConsultoraID, string.Empty, formatoPedidoWebSet, estrategiaId, usuario.Nombre, usuario.CodigoPrograma, usuario.ConsecutivoNueva);
        }
        #endregion

        #region InsertBuscador
        private BEPedidoDetalleResult RegistroLiquidacion(BEPedidoDetalle pedidoDetalle)
        {
            var result = false;
            var pedidoID = 0;
            var usuario = pedidoDetalle.Usuario;
            var CUV = pedidoDetalle.Producto.CUV;
            var cantidad = pedidoDetalle.Cantidad;

            //Validacion reserva u horario restringido
            var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                usuario.ConsultoraID,
                                                                usuario.CampaniaID,
                                                                usuario.UsuarioPrueba == 1,
                                                                usuario.AceptacionConsultoraDA);
            if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

            //Obtener Detalle
            var pedidoDetalleBuscar = new BEPedidoBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;

            //ValidarUnidadesPermitidasPedidoProducto
            var mensaje = ValidarMontoMaximo(usuario, pedidoDetalle, lstDetalle, out result);
            if (!string.IsNullOrEmpty(mensaje)) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

            var entidad = new BEOfertaProducto
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                CUV = CUV,
                ConsultoraID = Convert.ToInt32(usuario.ConsultoraID)
            };

            var taskUnidadesPermitidas = Task.Run(() => _ofertaProductoBusinessLogic.GetUnidadesPermitidasByCuv(usuario.PaisID, usuario.CampaniaID, CUV));
            var taskSaldo = Task.Run(() => _ofertaProductoBusinessLogic.ValidarUnidadesPermitidasEnPedido(usuario.PaisID, usuario.CampaniaID, CUV, usuario.ConsultoraID));
            var taskCantidadPedida = Task.Run(() => _ofertaProductoBusinessLogic.CantidadPedidoByConsultora(entidad));

            Task.WaitAll(taskUnidadesPermitidas, taskSaldo, taskCantidadPedida);

            var unidadesPermitidas = taskUnidadesPermitidas.Result;
            var saldo = taskSaldo.Result;
            var cantidadPedida = taskCantidadPedida.Result;

            if (saldo < cantidad)
            {
                if (saldo == unidadesPermitidas)
                {
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_UNIDAD_SOBREPASA_PERMITIDO, null, unidadesPermitidas);
                }
                else
                {
                    if (saldo == 0)
                    {
                        return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_UNIDAD_SINSALDO, null, unidadesPermitidas);
                    }
                    else
                    {
                        return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_UNIDAD_CONSALDO, null, unidadesPermitidas, saldo);
                    }
                }
            }
            else
            {
                var stock = _ofertaProductoBusinessLogic.GetStockOfertaProductoLiquidacion(usuario.PaisID, usuario.CampaniaID, CUV);
                if (stock < cantidad)
                {
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_UNIDAD_SOBREPASA_STOCK, null, stock);
                }
            }

            InsertOfertaWebPortal(pedidoDetalle, lstDetalle);

            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
        }

        private void InsertOfertaWebPortal(BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var pedidoID = 0;
            var usuario = pedidoDetalle.Usuario;

            //Insertar Oferta
            var entidad = new BEPedidoWebDetalle()
            {
                MarcaID = Convert.ToByte(pedidoDetalle.Producto.MarcaID),
                Cantidad = pedidoDetalle.Cantidad,
                PrecioUnidad = pedidoDetalle.Producto.PrecioCatalogo,
                CUV = pedidoDetalle.Producto.CUV,
                ConfiguracionOfertaID = 3,
                OrigenPedidoWeb = pedidoDetalle.OrigenPedidoWeb,
                PaisID = usuario.PaisID,
                ConsultoraID = usuario.ConsultoraID,
                CampaniaID = usuario.CampaniaID,
                TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion,
                IPUsuario = pedidoDetalle.IPUsuario,
                CodigoUsuarioCreacion = usuario.CodigoConsultora,
                CodigoUsuarioModificacion = usuario.CodigoConsultora
            };
            _ofertaProductoBusinessLogic.InsPedidoWebDetalleOferta(entidad);

            //Actualizar Prol
            var pedidoDetalleBuscar = new BEPedidoBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;
            UpdateProl(usuario, lstDetalle);

            //Indicador pedido autentico
            if (lstDetalle.Any())
            {
                var detallePedido = lstDetalle.FirstOrDefault(x => x.CUV == pedidoDetalle.Producto.CUV);
                if (detallePedido != null)
                {
                    var indPedidoAutentico = new BEIndicadorPedidoAutentico
                    {
                        CampaniaID = usuario.CampaniaID,
                        IndicadorIPUsuario = pedidoDetalle.IPUsuario,
                        IndicadorFingerprint = string.Empty,
                        IndicadorToken = string.IsNullOrEmpty(pedidoDetalle.Identifier) ? string.Empty : AESAlgorithm.Encrypt(pedidoDetalle.Identifier),
                        PedidoID = detallePedido.PedidoID,
                        PedidoDetalleID = detallePedido.PedidoDetalleID
                    };

                    _pedidoWebBusinessLogic.InsIndicadorPedidoAutentico(usuario.PaisID, indPedidoAutentico);
                }
            }

            //Insertar set agrupado
            _pedidoWebDetalleBusinessLogic.InsertPedidoWebSet(usuario.PaisID, usuario.CampaniaID, pedidoID, pedidoDetalle.Cantidad, pedidoDetalle.Producto.CUV
                        , usuario.ConsultoraID, string.Empty, string.Format("{0}:1", pedidoDetalle.Producto.CUV), 0, usuario.Nombre, usuario.CodigoPrograma, usuario.ConsecutivoNueva);
        }

        private BEPedidoDetalleResult PedidoInsertarBuscador(BEPedidoDetalle pedidoDetalle)
        {
            var pedidoID = 0;
            var mensaje = string.Empty;

            //Informacion de palancas - RD
            var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.RevistaDigital);

            //Informacion de la consultora
            usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);

            //Validacion reserva u horario restringido
            var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                usuario.ConsultoraID,
                                                                usuario.CampaniaID,
                                                                usuario.UsuarioPrueba == 1,
                                                                usuario.AceptacionConsultoraDA);
            if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

            //Validacion unidades permitidas
            var lstDetalleGrp = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);
            var pedidoAgregado = lstDetalleGrp.Where(x => x.CUV == pedidoDetalle.Producto.CUV);
            var cantidadesAgregadas = 0;

            if (pedidoDetalle.LimiteVenta > 0)
            {
                if (pedidoAgregado.Any()) cantidadesAgregadas = pedidoAgregado.FirstOrDefault().Cantidad;

                cantidadesAgregadas += pedidoDetalle.Cantidad;

                if (cantidadesAgregadas > pedidoDetalle.LimiteVenta)
                {
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE, null, pedidoDetalle.LimiteVenta);
                }
            }

            //Validar stock
            mensaje = ValidarStockEstrategiaMensaje(usuario, pedidoDetalle);
            if (!string.IsNullOrEmpty(mensaje)) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

            //Obtener Detalle
            var pedidoDetalleBuscar = new BEPedidoBuscar()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;
            PedidoInsertar(usuario, pedidoDetalle, lstDetalle, false);

            //Actualizar Prol
            var existe = lstDetalle.FirstOrDefault(x => x.ClienteID == pedidoDetalle.ClienteID && x.CUV == pedidoDetalle.Producto.CUV);
            if (existe != null)
            {
                existe.Cantidad += pedidoDetalle.Cantidad;
            }
            else
            {
                lstDetalle.Add(new BEPedidoWebDetalle()
                {
                    CUV = pedidoDetalle.Producto.CUV,
                    Cantidad = pedidoDetalle.Cantidad,
                    ClienteID = pedidoDetalle.ClienteID
                });
            }
            UpdateProl(usuario, lstDetalle);

            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
        }

        private BEPedidoDetalleResult PedidoAgregarProducto(BEPedidoDetalle pedidoDetalle)
        {
            var pedidoID = 0;

            //Configuracion pais - RevistaDigital
            var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.RevistaDigital);

            //Configuracion pais - ValidacionMontoMaximo
            usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);

            //Validacion reserva u horario restringido
            var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                usuario.ConsultoraID,
                                                                usuario.CampaniaID,
                                                                usuario.UsuarioPrueba == 1,
                                                                usuario.AceptacionConsultoraDA);
            if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

            //FiltrarEstrategiaPedido
            var estrategia = FiltrarEstrategiaPedido(pedidoDetalle.PaisID, pedidoDetalle.Producto.EstrategiaID, 0);
            var cuvSet = estrategia.CUV2;

            //UnidadesPermitidas
            estrategia.Cantidad = pedidoDetalle.Cantidad;
            var lstDetalleAgrupado = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);
            if (lstDetalleAgrupado.Any(x => x.CUV == estrategia.CUV2))
            {
                var cantidadActual = lstDetalleAgrupado.Where(x => x.CUV == estrategia.CUV2).Sum(x => x.Cantidad);
                if (cantidadActual + estrategia.Cantidad > estrategia.LimiteVenta)
                {
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE, null, estrategia.LimiteVenta);
                }
            }
            else
            {
                if (estrategia.Cantidad > estrategia.LimiteVenta)
                {
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE, null, estrategia.LimiteVenta);
                }
            }

            var listCuvTonos = estrategia.CUV2;
            var tonos = listCuvTonos.Split('|');
            var ListaCuvsTemporal = new List<string>();

            //Obtener Detalle
            var pedidoDetalleBuscar = new BEPedidoBuscar()
            {
                PaisID = pedidoDetalle.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };
            var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;

            foreach (var tono in tonos)
            {
                var listSp = tono.Split(';');
                estrategia.CUV2 = listSp.Length > 0 ? listSp[0] : estrategia.CUV2;
                estrategia.MarcaID = (listSp.Length > 1 && !string.IsNullOrEmpty(listSp[1])) ? Convert.ToInt32(listSp[1]) : estrategia.MarcaID;
                estrategia.Precio2 = listSp.Length > 2 ? Convert.ToDecimal(listSp[2]) : estrategia.Precio2;

                var mensaje = EstrategiaAgregarProducto(pedidoDetalle, usuario, estrategia, lstDetalle);
                if (!string.IsNullOrEmpty(mensaje)) PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                ListaCuvsTemporal.Add(listSp.Length > 0 ? listSp[0] : estrategia.CUV2);
            }

            var strCuvs = string.Empty;
            if (ListaCuvsTemporal.Any())
            {
                ListaCuvsTemporal.OrderByDescending(x => x).Distinct().All(x =>
                {
                    strCuvs = strCuvs + string.Format("{0}:{1},", x, ListaCuvsTemporal.Count(a => a == x));
                    return true;
                });
            }
            PedidoAgregarProductoAgrupado(usuario, pedidoID, pedidoDetalle.Cantidad, cuvSet, strCuvs, estrategia.EstrategiaID);

            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
        }
        #endregion
    }
}
