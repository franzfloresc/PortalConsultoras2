﻿using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Pedido.App;
using Portal.Consultoras.Data.ServiceCalculoPROL;
using Portal.Consultoras.Data.ServicePROL;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;
using Portal.Consultoras.BizLogic.Reserva;

using System;
using System.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

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
        private readonly IReservaBusinessLogic _reservaBusinessLogic;
        private readonly ITipoEstrategiaBusinessLogic _tipoEstrategiaBusinessLogic;

        private string nombreServicio = string.Empty;

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
                                    new BLReserva(),
                                    new BLTipoEstrategia())
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
                            IReservaBusinessLogic reservaBusinessLogic,
                            ITipoEstrategiaBusinessLogic tipoEstrategiaBusinessLogic)
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
        }

        #region Publicos
        public BEProductoApp GetCUV(BEProductoAppBuscar productoBuscar)
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
                if (producto == null) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validación producto en catalogos
                var bloqueoProductoCatalogo = BloqueoProductosCatalogo(usuario.RevistaDigital, usuario.CodigosRevistaImpresa, producto, productoBuscar);
                if (!bloqueoProductoCatalogo) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

                //Validacion Tipo Estrategia
                var validacionTipoEstrategia = BloqueoTipoEstrategia(productoBuscar.PaisID, producto.TipoEstrategiaID);
                if (!string.IsNullOrEmpty(validacionTipoEstrategia)) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_PRODUCTO_ESTRATEGIA, validacionTipoEstrategia);

                //Validación producto agotado
                if (!producto.TieneStock) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_PRODUCTO_AGOTADO, null, producto);

                //Validación producto liquidaciones
                if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_PRODUCTO_LIQUIDACION, null, producto);

                //Información de producto con oferta en revista
                if (usuario.RevistaDigital != null)
                {
                    var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(productoBuscar.PaisID,
                                                    usuario.CampaniaID,
                                                    usuario.CodigoZona);
                    var tieneRDC = usuario.RevistaDigital.TieneRDC && usuario.RevistaDigital.EsActiva;
                    if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
                    {
                        if (WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoBuscar.PaisID))) return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA, null, producto);
                        else return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL, null, producto);
                    }
                }

                return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.SUCCESS, null, producto);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, productoBuscar.Usuario.CodigoUsuario, productoBuscar.PaisID);
                return ProductoBuscarRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        private void LogPerformance(string mensaje)
        {
            //var pathFile = AppDomain.CurrentDomain.BaseDirectory + "Log\\";
            //if (!System.IO.Directory.Exists(pathFile)) System.IO.Directory.CreateDirectory(pathFile);
            //string path = string.Format("{0}LogPerformance_{1}_{2}.portal", pathFile, DateTime.Now.ToString("yyyy-MM-dd"), nombreServicio);
            //using (var stream = new System.IO.StreamWriter(path, true))
            //{
            //    if (string.IsNullOrEmpty(mensaje))
            //    {
            //        stream.WriteLine(string.Empty);
            //    }
            //    else
            //    {
            //        if(string.IsNullOrEmpty(cuvBuscar))
            //            stream.WriteLine(string.Format("{0} => {1}", DateTime.Now.ToString("HH:mm:ss.fff"), mensaje));
            //        else
            //            stream.WriteLine(string.Format("{0} => {1} => {2}", DateTime.Now.ToString("HH:mm:ss.fff"), cuvBuscar, mensaje));
            //    }
            //}
        }

        public BEPedidoDetalleAppResult Insert(BEPedidoDetalleApp pedidoDetalle)
        {
            var mensaje = string.Empty;

            try
            {
                nombreServicio = "Insert";
                LogPerformance("Inicio");

                //Informacion de usuario
                var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);
                LogPerformance("Informacion de palancas");
                usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);
                LogPerformance("EsConsultoraNueva");

                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                    usuario.ConsultoraID,
                                                                    usuario.CampaniaID,
                                                                    usuario.UsuarioPrueba == 1,
                                                                    usuario.AceptacionConsultoraDA);
                LogPerformance("ValidacionModificarPedido");
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Obtener Detalle
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
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                LogPerformance("ObtenerPedidoWebDetalle");
                pedidoDetalle.PedidoID = pedidoID;

                //Validar stock
                var result = ValidarStockEstrategia(usuario, pedidoDetalle, lstDetalle, out mensaje);
                LogPerformance("ValidarStockEstrategia");
                if (!result) return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                if (pedidoDetalle.Producto.TipoOfertaSisID == 0)
                {
                    var tipoEstrategiaID = 0;
                    int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);
                    pedidoDetalle.Producto.TipoOfertaSisID = tipoEstrategiaID;
                }

                var esOfertaNueva = (pedidoDetalle.Producto.FlagNueva == "1");
                if (esOfertaNueva) AgregarProductoZE(usuario, pedidoDetalle, lstDetalle);
                LogPerformance("AgregarProductoZE");

                var codeResult = PedidoInsertar(usuario, pedidoDetalle, lstDetalle);
                LogPerformance("PedidoInsertar");
                if (codeResult != Constantes.PedidoAppValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(codeResult);

                //Actualizar Prol
                var existe = lstDetalle.Where(x => x.ClienteID == pedidoDetalle.ClienteID && x.CUV == pedidoDetalle.Producto.CUV).FirstOrDefault();
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
                LogPerformance("UpdateProl");

                return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoWeb Get(BEUsuario usuario)
        {
            //Inicio método 
            var pedido = new BEPedidoWeb();

            try
            {
                nombreServicio = "GET";

                //Obtener  Cabecera 
                LogPerformance("Inicio");
                pedido = _pedidoWebBusinessLogic.GetPedidoWebByCampaniaConsultora(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                LogPerformance("GetPedidoWebByCampaniaConsultora");

                if (pedido == null) return pedido;

                //Obtener Detalle
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
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoBuscar, out pedidoID);
                LogPerformance("ObtenerPedidoWebDetalle");
                if (lstDetalle.Any())
                {
                    lstDetalle.Where(x => x.ClienteID == 0).Update(x => x.NombreCliente = usuario.Nombre);
                    pedido.olstBEPedidoWebDetalle = lstDetalle;

                    pedido.CantidadProductos = lstDetalle.Sum(p => p.Cantidad);
                    pedido.CantidadCuv = lstDetalle.Count;
                }

                //Programa nuevas
                if (usuario.MontoMaximoPedido > 0)
                {
                    var tp = GetConfiguracionProgramaNuevas(usuario);

                    if (tp.IndExigVent == "1")
                    {
                        var obeConsultorasProgramaNuevas = GetConsultorasProgramaNuevas(usuario, tp.CodigoPrograma);
                        if (obeConsultorasProgramaNuevas != null) pedido.TippingPoint = obeConsultorasProgramaNuevas.MontoVentaExigido;
                    }
                    LogPerformance("GetConfiguracionProgramaNuevas");
                }

                LogPerformance("Fin");
                LogPerformance(string.Empty);
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
                nombreServicio = "InsertKitInicio";

                LogPerformance("Inicio");
                //Informacion de usuario
                usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);
                LogPerformance("EsConsultoraNueva");

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
                LogPerformance("GetConfiguracionProgramaNuevas");
                if (obeConfiguracionProgramaNuevas == null) return false;
                if (!flagkit && obeConfiguracionProgramaNuevas.IndProgObli != "1") return false;

                //Obtener Detalle
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
                var lstDetalle = ObtenerPedidoWebDetalle(bePedidoWebDetalleParametros, out PedidoID);
                LogPerformance("ObtenerPedidoWebDetalle");
                var det = lstDetalle.FirstOrDefault(d => d.CUV == obeConfiguracionProgramaNuevas.CUVKit) ?? new BEPedidoWebDetalle();
                if (det.PedidoDetalleID > 0) return false;

                var olstProducto = _productoBusinessLogic.SelectProductoToKitInicio(usuario.PaisID, usuario.CampaniaID, obeConfiguracionProgramaNuevas.CUVKit);
                LogPerformance("SelectProductoToKitInicio");
                var producto = olstProducto.FirstOrDefault();
                if (producto != null)
                {
                    var tipoEstrategiaID = 0;
                    int.TryParse(producto.TipoEstrategiaID, out tipoEstrategiaID);

                    var detalle = new BEPedidoDetalleApp()
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

                    var result = PedidoInsertar(usuario, detalle, lstDetalle);
                    LogPerformance("PedidoInsertar");
                    if (result != Constantes.PedidoAppValidacion.Code.SUCCESS) return false;

                    return true;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
            }

            return false;
        }

        public BEPedidoDetalleAppResult Update(BEPedidoDetalleApp pedidoDetalle)
        {
            var mensaje = string.Empty;
            try
            {
                nombreServicio = "Update";

                //Informacion de usuario y palancas
                LogPerformance("Inicio");
                var usuario = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);
                LogPerformance("Informacion palancas");

                //Validacion reserve u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                                          usuario.ConsultoraID,
                                                                                          usuario.CampaniaID,
                                                                                          usuario.UsuarioPrueba == 1,
                                                                                          usuario.AceptacionConsultoraDA);
                LogPerformance("Validacion horario");
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

                //Obtener Detalle
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
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                LogPerformance("ObtenerPedidoWebDetalle");
                pedidoDetalle.PedidoID = pedidoID;

                //Validar stock
                var result = ValidarStockEstrategia(usuario, pedidoDetalle, lstDetalle, out mensaje);
                LogPerformance("ValidarStockEstrategia");
                if (!result) return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                //accion actualizar
                var accionActualizar = PedidoActualizar(usuario, pedidoDetalle, lstDetalle);
                LogPerformance("PedidoActualizar");
                if (accionActualizar != Constantes.PedidoAppValidacion.Code.SUCCESS) return PedidoDetalleRespuesta(accionActualizar);

                //actualizar PROL
                var item = lstDetalle.Where(x => x.PedidoDetalleID == pedidoDetalle.PedidoDetalleID).FirstOrDefault();
                if (item != null)
                {
                    item.Cantidad = pedidoDetalle.Cantidad;
                    item.ClienteID = pedidoDetalle.ClienteID;
                }

                UpdateProl(usuario, lstDetalle);
                LogPerformance("UpdateProl");

                return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_INTERNO, ex.Message);
            }
            
        }

        public BEConfiguracionPedido GetConfiguracion(int paisID, string codigoUsuario)
        {
            var config = new BEConfiguracionPedido();

            try
            {
                nombreServicio = "GetConfiguracion";
                LogPerformance("Inicio");
                config.Barra = GetDataBarra(paisID);
                LogPerformance("Fin");
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
            }

            return config;
        }

        public async Task<BEPedidoDetalleAppResult> Delete(BEPedidoDetalleApp pedidoDetalle)
        {
            try
            {
                nombreServicio = "Delete";
                LogPerformance("Inicio");

                //Informacion de usuario
                var usuario = pedidoDetalle.Usuario;
                usuario.PaisID = pedidoDetalle.PaisID;

                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(pedidoDetalle.PaisID,
                                                                usuario.ConsultoraID,
                                                                usuario.CampaniaID,
                                                                usuario.UsuarioPrueba == 1,
                                                                usuario.AceptacionConsultoraDA);
                LogPerformance("ValidacionModificarPedido");
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);


                //Obtener Detalle
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
                var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                LogPerformance("ObtenerPedidoWebDetalle");

                //Eliminar Detalle
                var responseCode = Constantes.PedidoAppValidacion.Code.SUCCESS;
                if (pedidoDetalle.Producto == null) responseCode = await DeleteAll(usuario, pedidoDetalle);
                else responseCode = DeleteCUV(usuario, pedidoDetalle, lstDetalle);
                LogPerformance("Delete");

                //Actualizar Prol
                if (pedidoDetalle.Producto != null)
                {
                    var item = lstDetalle.Where(x => x.PedidoDetalleID == pedidoDetalle.PedidoDetalleID).FirstOrDefault();
                    if (item != null) lstDetalle.Remove(item);
                }
                else
                {
                    lstDetalle = new List<BEPedidoWebDetalle>();
                }
                UpdateProl(usuario, lstDetalle);
                LogPerformance("UpdateProl");

                //Desreservar pedido PROL
                if (!lstDetalle.Any() && pedidoDetalle.Producto != null && usuario.ZonaValida)
                {
                    using (var sv = new ServiceStockSsic())
                    {
                        sv.Url = ConfigurarUrlServiceProl(usuario.CodigoISO);
                        sv.wsDesReservarPedido(usuario.CodigoConsultora, usuario.CodigoISO);
                        LogPerformance("wsDesReservarPedido");
                    }
                }

                return PedidoDetalleRespuesta(responseCode);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public async Task<BEPedidoReservaAppResult> Reserva(BEUsuario usuario)
        {
            try
            {
                nombreServicio = "Reserva";
                LogPerformance("Inicio");

                //Validacion reserva u horario restringido
                var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(usuario.PaisID,
                                                                    usuario.ConsultoraID,
                                                                    usuario.CampaniaID,
                                                                    usuario.UsuarioPrueba == 1,
                                                                    usuario.AceptacionConsultoraDA);
                LogPerformance("ValidacionModificarPedido");
                if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                    return PedidoReservaRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

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
                    PROLSinStock = usuario.PROLSinStock,
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
                var resultadoReserva = await _reservaBusinessLogic.EjecutarReserva(input);
                LogPerformance("EjecutarReserva");
                var code = string.Empty;
                var enumReserva = (int)resultadoReserva.ResultadoReservaEnum;
                if (usuario.DiaPROL) code = (enumReserva + 2010).ToString();
                else code = (enumReserva + 2020).ToString();

                var obsPedido = ObtenerMensajePROLAnalytics(resultadoReserva.ListPedidoObservacion);
                var obsByCuv = ObtenerMensajePROLByCuv(resultadoReserva.ListPedidoObservacion);

                return PedidoReservaRespuesta(code, obsPedido, obsByCuv);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
                return PedidoReservaRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoDetalleAppResult DeshacerReserva(BEUsuario usuario)
        {
            var mensaje = string.Empty;
            var pedido = new BEPedidoWeb();

            try
            {
                nombreServicio = "DeshacerReserva";
                LogPerformance("Inicio");
 
                //Obtener pedido
                pedido = _pedidoWebBusinessLogic.GetPedidoWebByCampaniaConsultora(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                LogPerformance("GetPedidoWebByCampaniaConsultora");

                //verificapedidoValidado
                if (!(pedido.EstadoPedido == Constantes.EstadoPedido.Procesado && !pedido.ModificaPedidoReservado && !pedido.ValidacionAbierta))
                    return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_DESHACER_PEDIDO_ESTADO);

                //Deshacer Pedido 
                mensaje = _reservaBusinessLogic.DeshacerPedidoValidado(usuario, Constantes.EstadoPedido.PedidoValidado);
                LogPerformance("DeshacerPedidoValidado");
                if (mensaje != string.Empty) return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_DESHACER_PEDIDO, mensaje);
                 
                return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoAppValidacion.Code.ERROR_INTERNO, ex.Message);
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

                lstEstrategia = ConsultarEstrategiasHomePedido(string.Empty, codAgrupa, usuario);

                ListaModelo = (from estrategia in lstEstrategia
                               select new BEEstrategia
                               {
                                   CUV = estrategia.CUV2,
                                   DescripcionProducto = Util.SubStrCortarNombre(estrategia.DescripcionCUV2, 40),
                                   MarcaID = estrategia.MarcaID,
                                   DescripcionMarca = estrategia.DescripcionMarca,
                                   Ganancia = estrategia.Ganancia,
                                   PrecioValorizado = estrategia.Precio,
                                   ImagenURL = estrategia.FotoProductoSmall
                               }).ToList();
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.PaisID, usuario.CodigoUsuario);
            }

            return lstEstrategia ?? new List<BEEstrategia>();
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

        private BEProductoApp ProductoBuscarRespuesta(string codigoRespuesta, string mensajeRespuesta = null, BEProducto producto = null)
        {
            LogPerformance("Fin");
            LogPerformance(string.Empty);

            return new BEProductoApp()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.Message[codigoRespuesta] : mensajeRespuesta,
                Producto = producto
            };
        }
        #endregion

        #region Insert
        private BEPedidoDetalleAppResult PedidoDetalleRespuesta(string codigoRespuesta, string mensajeRespuesta = null)
        {
            LogPerformance("Fin");
            LogPerformance(string.Empty);

            return new BEPedidoDetalleAppResult()
            {
                CodigoRespuesta = (codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_RESERVA ||
                                    codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_RESERVA_OBS ||
                                    codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_GUARDAR ||
                                    codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_GUARDAR_OBS ?
                                    Constantes.PedidoAppValidacion.Code.SUCCESS : codigoRespuesta),
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.Message[codigoRespuesta] : mensajeRespuesta
            };
        }

        private bool ValidarStockEstrategia(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle, 
            out string mensaje)
        {
            var resultado = false;
            mensaje = string.Empty;

            mensaje = ValidarMontoMaximo(usuario, pedidoDetalle, lstDetalle, out resultado);

            if (mensaje == string.Empty || resultado)
                mensaje = ValidarStockEstrategiaMensaje(usuario, pedidoDetalle);

            return mensaje == string.Empty || resultado;
        }

        private string ValidarMontoMaximo(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle, 
            out bool resul)
        {
            var mensaje = string.Empty;
            resul = false;

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

        private string ValidarStockEstrategiaMensaje(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle)
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

        private string PedidoInsertar(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var result = InsertarValidarKitInicio(usuario, pedidoDetalle, lstDetalle);
            if (!result) return Constantes.PedidoAppValidacion.Code.ERROR_KIT_INICIO;

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

            result = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, lstDetalle, Constantes.PedidoAccion.INSERT);
            if (!result) return Constantes.PedidoAppValidacion.Code.ERROR_GRABAR;

            return Constantes.PedidoAppValidacion.Code.SUCCESS;
        }

        private bool InsertarValidarKitInicio(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var resultado = true;

            if (usuario.EsConsultoraNueva)
            {
                var detCuv = lstDetalle.FirstOrDefault(d => d.CUV == pedidoDetalle.Producto.CUV) ?? new BEPedidoWebDetalle();
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

            return obeConfiguracionProgramaNuevas ?? new BEConfiguracionProgramaNuevas();
        }

        private bool AdministradorPedido(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, BEPedidoWebDetalle obePedidoWebDetalle, 
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

            return temp.Sum(p => p.ImporteTotal) + (adm == "U" ? itemPedido.ImporteTotal : 0);
        }

        private void AgregarProductoZE(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var tipoEstrategiaID = 0;
            int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);

            pedidoDetalle.Producto.TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID > 0 ? pedidoDetalle.Producto.TipoOfertaSisID : tipoEstrategiaID;
            pedidoDetalle.Producto.ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID > 0 ? pedidoDetalle.Producto.ConfiguracionOfertaID : pedidoDetalle.Producto.TipoOfertaSisID;

            EliminarDetallePackNueva(usuario, pedidoDetalle, lstDetalle);
        }

        private void EliminarDetallePackNueva(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var packNuevas = lstDetalle.Where(x => x.FlagNueva && !x.EsOfertaIndependiente);

            foreach (var item in packNuevas)
            {
                AdministradorPedido(usuario, pedidoDetalle, item, lstDetalle, Constantes.PedidoAccion.DELETE);
            }
        }
        #endregion  

        #region Get
        private List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle(BEPedidoAppBuscar pedidoDetalle, out int pedidoID)
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
        private string PedidoActualizar(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle) {

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
                ImporteTotal = pedidoDetalle.Cantidad * pedidoDetalle.Producto.PrecioCatalogo,
                Nombre = pedidoDetalle.ClienteID == 0 ? usuario.Nombre : pedidoDetalle.ClienteDescripcion
            };

            var result = AdministradorPedido(usuario, pedidoDetalle, obePedidoWebDetalle, lstDetalle, Constantes.PedidoAccion.UPDATE);
            if (!result) return Constantes.PedidoAppValidacion.Code.ERROR_ACTUALIZAR;

            return Constantes.PedidoAppValidacion.Code.SUCCESS;
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
            LogPerformance("GetEscalaDescuento");

            var entity = new BEMensajeMetaConsultora() { TipoMensaje = string.Empty };
            objR.ListaMensajeMeta = _mensajeMetaConsultoraBusinessLogic.GetMensajeMetaConsultora(paisID, entity) ?? new List<BEMensajeMetaConsultora>();
            LogPerformance("GetMensajeMetaConsultora");

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

        private List<BEPedidoObservacion> ObtenerMensajePROLByCuv(List<BEPedidoObservacion> lista)
        {
            var result = lista.Where(x => Regex.IsMatch(Util.SubStr(x.CUV, 0), @"^\d+$")).ToList();
            return result.Any() ? result : null;
        }

        private BEPedidoReservaAppResult PedidoReservaRespuesta(string codigoRespuesta, string mensajeRespuesta = null,
            List<BEPedidoObservacion> observaciones = null)
        {
            LogPerformance("Fin");
            LogPerformance(string.Empty);

            return new BEPedidoReservaAppResult()
            {
                CodigoRespuesta = (codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_RESERVA ||
                                    codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_RESERVA_OBS ||
                                    codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_GUARDAR ||
                                    codigoRespuesta == Constantes.PedidoAppValidacion.Code.SUCCESS_GUARDAR_OBS ?
                                    Constantes.PedidoAppValidacion.Code.SUCCESS : codigoRespuesta),
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoAppValidacion.Message[codigoRespuesta] : mensajeRespuesta,
                Observaciones = observaciones
            };
        }
        #endregion

        #region Delete
        private async Task<string> DeleteAll(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle)
        {
            var result = await _pedidoWebDetalleBusinessLogic.DelPedidoWebDetalleMasivo(usuario, pedidoDetalle.PedidoID);
            if (!result) return Constantes.PedidoAppValidacion.Code.ERROR_ELIMINAR_TODO;

            return Constantes.PedidoAppValidacion.Code.SUCCESS;
        }

        private string DeleteCUV(BEUsuario usuario, BEPedidoDetalleApp pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
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
            if (!result) return Constantes.PedidoAppValidacion.Code.ERROR_ELIMINAR;

            return Constantes.PedidoAppValidacion.Code.SUCCESS;
        }
        #endregion

        #region EstrategiaCarrusel
        private List<BEEstrategia> ConsultarEstrategiasHomePedido(string cuv, string codAgrupacion, BEUsuario usuario)
        {
            var revistaDigital = usuario.RevistaDigital;
            var listModel = ConsultarEstrategias(cuv, 0, codAgrupacion, usuario);

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

        public List<BEEstrategia> ConsultarEstrategias(string cuv, int campaniaId, string codAgrupacion, BEUsuario usuario)
        {
            codAgrupacion = Util.Trim(codAgrupacion);
            var listEstrategia = new List<BEEstrategia>();

            if (codAgrupacion != Constantes.TipoEstrategiaCodigo.Lanzamiento
                && codAgrupacion != Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada
                && codAgrupacion != Constantes.TipoEstrategiaCodigo.HerramientasVenta)
            {
                listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, usuario));
                listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, usuario));
            }

            switch (codAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.RevistaDigital, usuario));
                    break;
                default:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaParaTi, usuario));
                    break;
            }

            return listEstrategia;
        }

        public List<BEEstrategia> ConsultarEstrategiasPorTipo(string tipo, BEUsuario usuario)
        {
            var listEstrategia = new List<BEEstrategia>();
            tipo = Util.Trim(tipo);

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

            listEstrategia = _estrategiaBusinessLogic.GetEstrategiasPedido(entidad);

            if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
                listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia, usuario);

            return listEstrategia;
        }

        private List<BEEstrategia> ConsultarEstrategiasFiltrarPackNuevasPedido(List<BEEstrategia> listEstrategia, BEUsuario usuario)
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

            var pedidoWebDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            listEstrategia = listEstrategia.Where(e => !pedidoWebDetalle.Any(d => d.CUV == e.CUV2)).ToList();

            return listEstrategia;
        }
        #endregion
    }
}
