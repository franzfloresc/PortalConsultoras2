using Portal.Consultoras.BizLogic.ArmaTuPack;
using Portal.Consultoras.BizLogic.CaminoBrillante;
using Portal.Consultoras.BizLogic.LimiteVenta;
using Portal.Consultoras.BizLogic.ProgramaNuevas;
using Portal.Consultoras.BizLogic.Reserva;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.OrigenPedidoWeb;
using Portal.Consultoras.Common.Serializer;
using Portal.Consultoras.Data.ServiceCalculoPROL;
using Portal.Consultoras.Data.ServicePROL;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Producto;
using Portal.Consultoras.Entities.ProgramaNuevas;
using Portal.Consultoras.Entities.ReservaProl;
using Portal.Consultoras.PublicService.Cryptography;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Transactions;

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
        private readonly IProgramaNuevasBusinessLogic _programaNuevasBusinessLogic;
        private readonly ILimiteVentaBusinessLogic _limiteVentaBusinessLogic;
        private readonly IArmaTuPackBusinessLogic _BLArmaTuPack;
        private readonly IActivarPremioNuevasBusinessLogic _bLActivarPremioNuevas;
        private readonly ICaminoBrillanteBusinessLogic _bLCaminoBrillante;

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
                                    new BLOfertaProducto(),
                                    new BLProgramaNuevas(),
                                    new BLLimiteVenta(),
                                    new BLArmaTuPack(),
                                    new BLActivarPremioNuevas(),
                                    new BLCaminoBrillante())
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
                            IOfertaProductoBusinessLogic ofertaProductoBusinessLogic,
                            IProgramaNuevasBusinessLogic programaNuevasBusinessLogic,
                            ILimiteVentaBusinessLogic limiteVentaBusinessLogic,
                            IArmaTuPackBusinessLogic BLArmaTuPack,
                            IActivarPremioNuevasBusinessLogic bLActivarPremioNuevas,
                            ICaminoBrillanteBusinessLogic bLCaminoBrillante)
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
            _programaNuevasBusinessLogic = programaNuevasBusinessLogic;
            _limiteVentaBusinessLogic = limiteVentaBusinessLogic;
            _BLArmaTuPack = BLArmaTuPack;
            _bLActivarPremioNuevas = bLActivarPremioNuevas;
            _bLCaminoBrillante = bLCaminoBrillante;
        }

        #region Pedido Registro Insertar-Actualizar-Eliminar

        public BEPedidoDetalleResult Insert(BEPedidoDetalle pedidoDetalle)
        {
            TransactionOptions oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    #region HorarioRestringido

                    var reservado = false;
                    var modeloOrigenPedido = UtilOrigenPedidoWeb.GetModelo(pedidoDetalle.OrigenPedidoWeb);

                    if (modeloOrigenPedido.Palanca != ConsOrigenPedidoWeb.Palanca.OfertaFinal && 
                        !_bLCaminoBrillante.IsOrigenPedidoCaminoBrillante(pedidoDetalle.OrigenPedidoWeb))
                    {
                        var respuesta = RespuestaModificarPedido(pedidoDetalle.Usuario);
                        if (respuesta != null)
                        {
                            if (pedidoDetalle.ReservaProl != null)
                            {
                                reservado = (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA);
                            }

                            if (!reservado)
                            {
                                if (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA)
                                {
                                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, "Ya tienes un pedido reservado para esta campaña.");
                                }

                                return respuesta;
                            }
                            else
                            {
                                if (pedidoDetalle.Usuario.FechaFinFacturacion == Util.GetDiaActual(pedidoDetalle.Usuario.ZonaHoraria))
                                {
                                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVA_ULTIMO_DIA_FACTURACION);
                                }
                            }
                        }
                    }
                    #endregion

                    pedidoDetalle.Reservado = reservado;
                    var respuestaT = PedidoAgregarProductoTransaction(pedidoDetalle);

                    if (respuestaT.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS)
                    {
                        var error = false;

                        if (reservado)
                        {
                            pedidoDetalle.Producto.CUV = respuestaT.CUV;
                            var respuestaReserva = _reservaBusinessLogic.EjecutarReservaCrud(pedidoDetalle.ReservaProl, true);
                            respuestaT = GetPedidoDetalleResultFromResultadoReservaProl(respuestaReserva, respuestaT, pedidoDetalle, out error);

                            respuestaT = SetMontosTotalesProl(respuestaT, respuestaReserva, pedidoDetalle);
                        }

                        if (!error)
                        {
                            oTransactionScope.Complete();
                        }
                    }
                    return respuestaT;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        public BEPedidoDetalleResult Update(BEPedidoDetalle pedidoDetalle)
        {
            TransactionOptions oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    var reservado = false;
                    var respuesta = RespuestaModificarPedido(pedidoDetalle.Usuario);
                    if (respuesta != null)
                    {
                        if (pedidoDetalle.ReservaProl != null)
                        {
                            reservado = (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA);
                        }

                        if (!reservado)
                        {
                            if (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA)
                            {
                                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, "Ya tienes un pedido reservado para esta campaña.");
                            }

                            return respuesta;
                        }
                        else
                        {
                            if (pedidoDetalle.Usuario.FechaFinFacturacion == Util.GetDiaActual(pedidoDetalle.Usuario.ZonaHoraria))
                            {
                                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVA_ULTIMO_DIA_FACTURACION);
                            }
                        }
                    }
                    pedidoDetalle.Reservado = reservado;
                    respuesta = PedidoUpdateProductoTransaction(pedidoDetalle);

                    if (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS)
                    {
                        var error = false;

                        if (reservado)
                        {
                            var respuestaReserva = _reservaBusinessLogic.EjecutarReservaCrud(pedidoDetalle.ReservaProl, true);
                            respuesta = GetPedidoDetalleResultFromResultadoReservaProl(respuestaReserva, respuesta, pedidoDetalle, out error);
                            respuesta = SetMontosTotalesProl(respuesta, respuestaReserva, pedidoDetalle);
                        }

                        if (!error)
                        {
                            oTransactionScope.Complete();
                        }
                    }

                    return respuesta;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        private BEPedidoDetalleResult GetPedidoDetalleResultFromResultadoReservaProl(BEResultadoReservaProl resultadoReservaProl, BEPedidoDetalleResult respuestaT, BEPedidoDetalle pedidoDetalle, out bool error)
        {
            error = false;
            string mensajePersonalizado = null;
            var pedidoValidacionCode = Constantes.PedidoValidacion.Code.SUCCESS;

            if (resultadoReservaProl != null)
            {
                switch (resultadoReservaProl.ResultadoReservaEnum)
                {
                    case Enumeradores.ResultadoReserva.Reservado:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.SUCCESS;
                        break;
                    case Enumeradores.ResultadoReserva.ReservadoObservaciones:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.SUCCESS;
                        break;
                    case Enumeradores.ResultadoReserva.NoReservadoObservaciones:
                    case Enumeradores.ResultadoReserva.NoReservadoMontoPermitido:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.ERROR_RESERVA_OBS;
                        var ListPedidoObservacion = resultadoReservaProl.ListPedidoObservacion;
                        if (ListPedidoObservacion != null && ListPedidoObservacion.Any())
                        {
                            var observacion = ListPedidoObservacion.Find(x => x.CUV == pedidoDetalle.Producto.CUV);
                            if (observacion != null)
                            {
                                mensajePersonalizado = observacion.Descripcion;
                            }
                            else
                            {
                                if (pedidoDetalle.IngresoExternoOrigen != null && pedidoDetalle.IngresoExternoOrigen.Equals(Constantes.IngresoExternoOrigen.Portal))
                                {
                                    var txtBuilMsjPers = new StringBuilder();
                                    txtBuilMsjPers.Append("<ul> ");
                                    foreach (var item in ListPedidoObservacion)
                                    {
                                        txtBuilMsjPers.Append(string.Concat("<li>", " - ", item.Descripcion, "</li>"));
                                    }
                                    txtBuilMsjPers.Append("</ul>");

                                    mensajePersonalizado = txtBuilMsjPers.ToString();
                                }
                                else
                                {
                                    mensajePersonalizado = ListPedidoObservacion[0].Descripcion;
                                }
                            }
                        }
                        error = true;
                        break;
                    case Enumeradores.ResultadoReserva.NoReservadoMontoMinimo:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.ERROR_RESERVA_MONTO_MIN;
                        error = true;
                        mensajePersonalizado = "Si eliminas este producto no llegaras al monto mínimo y tendrás que modificar tu reservación.";
                        break;
                    case Enumeradores.ResultadoReserva.NoReservadoMontoMaximo:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.ERROR_RESERVA_MONTO_MAX;
                        error = true;
                        break;
                    case Enumeradores.ResultadoReserva.ReservaNoDisponible:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.ERORR_RESERVA_NO_DISP;
                        error = true;
                        break;
                    case Enumeradores.ResultadoReserva.NoReservadoDeuda:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.ERROR_RESERVA_DEUDA;
                        error = true;
                        break;
                    case Enumeradores.ResultadoReserva.Ninguno:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.ERROR_RESERVA_NINGUNO;
                        error = true;
                        break;
                    default:
                        pedidoValidacionCode = Constantes.PedidoValidacion.Code.ERROR_RESERVA_NINGUNO;
                        break;
                }
            }

            resultadoReservaProl = resultadoReservaProl ?? new BEResultadoReservaProl();
            var respuesta = PedidoDetalleRespuesta(pedidoValidacionCode, mensajePersonalizado);
            respuesta.MensajeRespuesta = respuesta.MensajeRespuesta.Replace("Pedido no reservado", "Pedido reservado");
            respuesta.ListPedidoObservacion = resultadoReservaProl.ListPedidoObservacion;
            if (!error)
            {
                respuesta.CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS_RESERVA_AGREGAR;
            }
            else
            {
                respuesta.CodigoRespuesta = Constantes.PedidoValidacion.Code.ERROR_RESERVA_AGREGAR;
            }

            if (respuestaT.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS)
            {
                respuesta.ListCuvEliminar = respuestaT.ListCuvEliminar;
                respuesta.PedidoWebDetalle = respuestaT.PedidoWebDetalle;
                respuesta.MensajeAviso = respuestaT.MensajeAviso;
                respuesta.TituloMensaje = respuestaT.TituloMensaje;
                respuesta.ListaMensajeCondicional = respuestaT.ListaMensajeCondicional;
            }

            return respuesta;
        }

        public async Task<BEPedidoDetalleResult> Delete(BEPedidoDetalle pedidoDetalle)
        {
            TransactionOptions oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    var reservado = false;
                    // solo por mantener la logica actual, se supone que PaisID ya viene dentro de Usuario
                    pedidoDetalle.Usuario.PaisID = pedidoDetalle.PaisID;
                    var respuesta = RespuestaModificarPedido(pedidoDetalle.Usuario);
                    if (respuesta != null)
                    {
                        if (pedidoDetalle.ReservaProl != null)
                        {
                            reservado = (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA);
                        }

                        if (!reservado)
                        {
                            if (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS_RESERVA)
                            {
                                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, "Ya tienes un pedido reservado para esta campaña.");
                            }

                            return respuesta;
                        }
                        else
                        {
                            if (pedidoDetalle.Usuario.FechaFinFacturacion == Util.GetDiaActual(pedidoDetalle.Usuario.ZonaHoraria))
                            {
                                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVA_ULTIMO_DIA_FACTURACION);
                            }
                        }
                    }

                    pedidoDetalle.Reservado = reservado;
                    respuesta = await PedidoDeleteProductoTransaction(pedidoDetalle);

                    if (respuesta.CodigoRespuesta == Constantes.PedidoValidacion.Code.SUCCESS)
                    {
                        var error = false;

                        if (reservado)
                        {
                            var respuestaReserva = _reservaBusinessLogic.EjecutarReservaCrud(pedidoDetalle.ReservaProl, true);
                            respuesta = GetPedidoDetalleResultFromResultadoReservaProl(respuestaReserva, respuesta, pedidoDetalle, out error);

                            respuesta = SetMontosTotalesProl(respuesta, respuestaReserva, pedidoDetalle);
                        }

                        if (!error)
                        {
                            oTransactionScope.Complete();
                        }
                    }
                    return respuesta;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }

        }

        public BEPedidoDetalleResult RespuestaModificarPedido(BEUsuario usuario)
        {
            var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(usuario.PaisID,
                                                                usuario.ConsultoraID,
                                                                usuario.CampaniaID,
                                                                usuario.UsuarioPrueba == 1,
                                                                usuario.AceptacionConsultoraDA);

            if (validacionHorario.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Bloqueado)
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_CONSULTORA_BLOQUEADA, validacionHorario.Mensaje);

            if (validacionHorario.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado)
                return new BEPedidoDetalleResult()
                {
                    CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS_RESERVA
                };

            if (validacionHorario.MotivoPedidoLock != Enumeradores.MotivoPedidoLock.Ninguno)
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVADO_HORARIO_RESTRINGIDO, validacionHorario.Mensaje);

            return null;
        }

        private bool ObtieneValorFlagDesactivacionNoDigitable()
        {
            var valorFlag = ConfigurationManager.AppSettings["DesactivarNoDigitablesPedido"];

            if (valorFlag == null) return false;

            return (valorFlag == "1");
        }

        private BEPedidoDetalleResult PedidoAgregarProductoTransaction(BEPedidoDetalle pedidoDetalle)
        {
            pedidoDetalle = PedidoAgregar_ObtenerEstrategia(pedidoDetalle);
            var usuario = pedidoDetalle.Usuario;

            var estrategia = PedidoAgregar_FiltrarEstrategiaPedido(pedidoDetalle, usuario.PaisID);

            if (string.IsNullOrEmpty(estrategia.CUV2))
            {
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_ESTRATEGIA, "El producto no fué encontrado.");
            }

            var mensaje = string.Empty;
            var cuvSet = estrategia.CUV2;
            int pedidoID;
            var lstDetalleAgrupado = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);

            usuario.PaisID = pedidoDetalle.PaisID;
            usuario.TieneValidacionMontoMaximo = _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo).TieneValidacionMontoMaximo;

            var tipoEstrategia = _tipoEstrategiaBusinessLogic.GetTipoEstrategiaById(usuario.PaisID, estrategia.TipoEstrategiaID);

            #region Reserva
            if (pedidoDetalle.Reservado && pedidoDetalle.EsDuoPerfecto)
            {
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVA_DUO_COMPLETO_COMPLETO);
            }

            if (pedidoDetalle.Reservado && (tipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack))
            {
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_RESERVA_ARMATUPACK_BLOQUEADO);
            }
            #endregion

            #region ArmaTuPack
            if (tipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack)
            {
                var packAgregado = lstDetalleAgrupado != null ? lstDetalleAgrupado.FirstOrDefault(x => x.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack) : null;

                if (packAgregado != null && packAgregado.CUV == estrategia.CUV2)
                {
                    pedidoDetalle.EsEditable = true;
                    pedidoDetalle.SetID = packAgregado.SetID;
                }
            }
            #endregion

            #region CaminoBrillante
            
            if (_bLCaminoBrillante.IsOrigenPedidoCaminoBrillante(pedidoDetalle.OrigenPedidoWeb))
            {
                if (_bLCaminoBrillante.UpdEstragiaCaminiBrillante(estrategia, usuario.PaisID, usuario.CampaniaID, usuario.NivelCaminoBrillante, pedidoDetalle.Producto.CUV))
                {
                    var codError = _bLCaminoBrillante.ValAgregarCaminiBrillante(estrategia, usuario, pedidoDetalle, lstDetalleAgrupado);
                    if (!string.IsNullOrEmpty(codError))
                    {
                        if (codError == Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE)
                            return PedidoDetalleRespuesta(codError, args: estrategia.LimiteVenta);
                        return PedidoDetalleRespuesta(codError);
                    }
                }
                else
                {
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);
                }
            }

            #endregion


            #region Editar Pedido con set

            if (pedidoDetalle.EsEditable)
            {
                var transactionDelete = PedidoDeleteProductoTransaction(new BEPedidoDetalle
                {
                    Usuario = usuario,
                    PaisID = pedidoDetalle.PaisID,
                    IPUsuario = pedidoDetalle.IPUsuario,
                    SetID = pedidoDetalle.SetID,
                    PedidoDetalleID = pedidoDetalle.PedidoDetalleID,
                    PedidoID = pedidoDetalle.PedidoID,
                    Producto = new BEProducto
                    {
                        TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                        CUV = cuvSet
                    },

                    ClienteID = pedidoDetalle.ClienteID,
                    Identifier = pedidoDetalle.Identifier,
                    Reservado = pedidoDetalle.Reservado
                }).Result;

                if (transactionDelete.CodigoRespuesta != Constantes.PedidoValidacion.Code.SUCCESS)
                {
                    return transactionDelete;
                }
            }

            #endregion

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

            #region UnidadesPermitidas

            estrategia.Cantidad = pedidoDetalle.Cantidad;

            if (pedidoDetalle.Producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
            {
                var unidadesPermitidas = _ofertaProductoBusinessLogic.GetUnidadesPermitidasByCuv(usuario.PaisID, usuario.CampaniaID, estrategia.CUV2);
                var saldo = _ofertaProductoBusinessLogic.ValidarUnidadesPermitidasEnPedido(usuario.PaisID, usuario.CampaniaID, estrategia.CUV2, usuario.ConsultoraID);
                var stock = _ofertaProductoBusinessLogic.GetStockOfertaProductoLiquidacion(usuario.PaisID, usuario.CampaniaID, estrategia.CUV2);

                if (saldo < estrategia.Cantidad)
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
                    if (stock < estrategia.Cantidad)
                    {
                        return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_UNIDAD_SOBREPASA_STOCK, null, stock);
                    }
                }
            }
            else
            {
                var validacionLimiteVenta = ValidarLimiteVenta(estrategia, lstDetalleAgrupado);
                if (validacionLimiteVenta != null) return validacionLimiteVenta;

                if (!pedidoDetalle.EsCuponNuevas)
                {
                    //Validar Stock limite de Venta
                    var pedidoDetalleStock = new BEPedidoDetalle();
                    pedidoDetalleStock.Producto = new BEProducto();
                    pedidoDetalleStock.Producto.CUV = estrategia.CUV2;
                    pedidoDetalleStock.Producto.Descripcion = pedidoDetalle.Producto.Descripcion;
                    pedidoDetalleStock.Cantidad = pedidoDetalle.Cantidad;
                    var resultStockLimite = ValidarStockLimiteVenta(usuario, pedidoDetalleStock, lstDetalle, out mensaje);
                    if (resultStockLimite) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_LIMITE_VENTA, mensaje);
                }

            }

            #endregion

            #region MontoMaximo

            pedidoDetalle.PedidoID = pedidoID;

            //Monto Máximo
            var ofertas = estrategia.DescripcionCUV2.Split('|');
            pedidoDetalle.Producto.Descripcion = ofertas[0];
            if (estrategia.FlagNueva == 1) { pedidoDetalle.Cantidad = estrategia.LimiteVenta; estrategia.Cantidad = estrategia.LimiteVenta; }
            else { pedidoDetalle.Producto.Descripcion = estrategia.DescripcionCUV2; }

            var resultado = false;
            pedidoDetalle.Producto.PrecioCatalogo = estrategia.Precio2;
            var mensajeMMax = ValidarMontoMaximo(usuario, pedidoDetalle, lstDetalle, out resultado);

            if (!(mensajeMMax == string.Empty || resultado))
            {
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_GUARDAR_MONTO_MAX, mensajeMMax);
            }
            #endregion


            #region PrepararPedidoDetalle
            //Preparar Pedido Detalle
            pedidoDetalle.Producto.TipoEstrategiaID = string.IsNullOrEmpty(pedidoDetalle.Producto.TipoEstrategiaID) ? "0" : pedidoDetalle.Producto.TipoEstrategiaID;
            pedidoDetalle.Producto.TipoEstrategiaID = Convert.ToInt32(pedidoDetalle.Producto.TipoEstrategiaID) == 0 ? estrategia.TipoEstrategiaID.ToString() : pedidoDetalle.Producto.TipoEstrategiaID;
            var tipoEstrategiaID = 0;
            int.TryParse(pedidoDetalle.Producto.TipoEstrategiaID, out tipoEstrategiaID);

            pedidoDetalle.Producto.TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID > 0 ? pedidoDetalle.Producto.TipoOfertaSisID : tipoEstrategiaID;
            pedidoDetalle.Producto.ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID > 0 ? pedidoDetalle.Producto.ConfiguracionOfertaID : pedidoDetalle.Producto.TipoOfertaSisID;
            #endregion

            List<BEPedidoWebDetalle> pedidowebdetalles = new List<BEPedidoWebDetalle>();

            var listCuvTonos = pedidoDetalle.Producto.CUV;
            if (string.IsNullOrEmpty(listCuvTonos))
            {
                listCuvTonos = estrategia.CUV2;
            }
            var tonos = listCuvTonos.Split('|');
            var ListaCuvsTemporal = new List<string>();
            var ListaComponentes = new List<BEEstrategiaProducto>();

            foreach (var tono in tonos)
            {
                var listSp = tono.Split(';');
                var CUV2 = listSp.Length > 0 ? listSp[0] : estrategia.CUV2;
                var MarcaID = (listSp.Length > 1 && !string.IsNullOrEmpty(listSp[1])) ? Convert.ToInt32(listSp[1]) : estrategia.MarcaID;
                var Precio2 = listSp.Length > 2 ? Convert.ToDecimal(listSp[2]) : estrategia.Precio2;
                var descTono = listSp.Length > 3 ? listSp[3] : pedidoDetalle.Producto.Descripcion;
                var digitable = listSp.Length > 4 ? listSp[4] : (estrategia.CodigoEstrategia == "2001" ? "1" : "0");
                var grupo = listSp.Length > 5 ? listSp[5] : "0";

                ListaComponentes.Add(new BEEstrategiaProducto
                {
                    CUV = CUV2,
                    Digitable = Convert.ToInt32(digitable),
                    Grupo = grupo
                });

                if ((listSp.Length > 4 && digitable == "0") && ObtieneValorFlagDesactivacionNoDigitable())
                {
                    continue;
                }

                if (!pedidoDetalle.EsKitNuevaAuto)
                {
                    var result = InsertarValidarKitInicio(usuario, pedidoDetalle);
                    if (!result) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_KIT_INICIO, "Kit de Inicio");
                }

                var pedidoWebDetalle = new BEPedidoWebDetalle
                {
                    PaisID = pedidoDetalle.PaisID,
                    IPUsuario = pedidoDetalle.IPUsuario,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    PedidoID = pedidoDetalle.PedidoID,
                    SubTipoOfertaSisID = 0,
                    TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                    CUV = CUV2,
                    Cantidad = pedidoDetalle.Cantidad,
                    PrecioUnidad = Precio2,
                    TipoEstrategiaID = Convert.ToInt32(pedidoDetalle.Producto.TipoEstrategiaID),
                    OrigenPedidoWeb = pedidoDetalle.OrigenPedidoWeb,
                    ConfiguracionOfertaID = pedidoDetalle.Producto.ConfiguracionOfertaID,
                    ClienteID = pedidoDetalle.ClienteID,
                    OfertaWeb = pedidoDetalle.OfertaWeb,
                    IndicadorMontoMinimo = pedidoDetalle.Producto.IndicadorMontoMinimo == 0 ? estrategia.IndicadorMontoMinimo : pedidoDetalle.Producto.IndicadorMontoMinimo,
                    EsSugerido = pedidoDetalle.EsSugerido,
                    EsKitNueva = pedidoDetalle.EsKitNueva,
                    MarcaID = Convert.ToByte(MarcaID),
                    DescripcionProd = descTono,
                    ImporteTotal = pedidoDetalle.Cantidad * Precio2,
                    Nombre = pedidoDetalle.ClienteID == 0 ? usuario.Nombre : pedidoDetalle.ClienteDescripcion,
                    TipoAdm = Constantes.PedidoAccion.INSERT,
                    OrigenSolicitud = pedidoDetalle.OrigenSolicitud
                };

                ListaCuvsTemporal.Add(CUV2);

                pedidowebdetalles.Add(pedidoWebDetalle);
            }

            #region StockComponente
            if (pedidoDetalle.Producto.TipoOfertaSisID != Constantes.ConfiguracionOferta.Liquidacion)
            {
                var tempPedidowebdetallesGroup = pedidowebdetalles.GroupBy(x => new { x.CUV, x.PaisID, x.TipoEstrategiaID }).Select(y => new BEPedidoWebDetalle
                {
                    CUV = y.First().CUV,
                    PaisID = y.First().PaisID,
                    TipoEstrategiaID = y.First().TipoEstrategiaID,
                    Cantidad = y.Sum(c => c.Cantidad)
                }).ToList();

                foreach (var pedidowebdetalle in tempPedidowebdetallesGroup)
                {
                    var message = ValidarStockEstrategia(usuario, pedidowebdetalle, lstDetalle);
                    if (!String.IsNullOrEmpty(message)) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, message);
                }
            }
            #endregion

            string Componentes = string.Empty;
            if (ListaComponentes.Any())
            {
                var listComponentes = ListaComponentes.GroupBy(x => new { x.CUV, x.Digitable, x.Grupo }).Select(group => new EstrategiaComponente
                {
                    CUV = group.Key.CUV,
                    Digitable = group.Key.Digitable,
                    Grupo = group.Key.Grupo,
                    Cantidad = group.Count()
                }).ToList();

                Componentes = listComponentes.Serialize();
            }

            List<string> listCuvEliminar;
            string mensajeObs = "";
            string TituloMensaje = "";
            var modificoBackOrder = false;
            List<BEMensajeProl> ListaMensajeCondicional;
            List<ObjMontosProl> listObjMontosProl;
            BEPedidoWeb pedidoWeb;

            var transactionExitosa = AdministradorPedido(usuario, pedidoDetalle, pedidowebdetalles, estrategia, Componentes, Constantes.PedidoAccion.INSERT, out mensajeObs, out listCuvEliminar, out TituloMensaje, out modificoBackOrder, out ListaMensajeCondicional, out listObjMontosProl, out pedidoWeb);

            var response = PedidoDetalleRespuesta(transactionExitosa ? Constantes.PedidoValidacion.Code.SUCCESS : Constantes.PedidoValidacion.Code.ERROR_GRABAR, mensajeObs);
            response.ListCuvEliminar = listCuvEliminar;
            response.PedidoWebDetalle = pedidowebdetalles[0];
            response.MensajeAviso = mensajeObs;
            response.TituloMensaje = TituloMensaje;
            response.ListaMensajeCondicional.AddRange(ListaMensajeCondicional);
            response.CUV = cuvSet;
            response.PedidoWeb = pedidoWeb;
            SetMontosTotalesProl(response, listObjMontosProl);
            return response;
        }

        public BEPedidoDetalleResult PedidoUpdateProductoTransaction(BEPedidoDetalle pedidoDetalle)
        {
            var mensaje = string.Empty;

            try
            {
                var usuario = pedidoDetalle.Usuario;
                //Informacion de usuario y palancas
                var usuarioValidacionMontoMaximo = _usuarioBusinessLogic.ConfiguracionPaisUsuario(pedidoDetalle.Usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo);
                usuario.TieneValidacionMontoMaximo = usuarioValidacionMontoMaximo.TieneValidacionMontoMaximo;

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

                #region MontoMaximo
                //Monto Máximo
                var resultado = false;
                var mensajeMMax = ValidarMontoMaximo(usuario, pedidoDetalle, lstDetalle, out resultado);

                if (!(mensajeMMax == string.Empty || resultado))
                {
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_GUARDAR_MONTO_MAX, mensajeMMax);
                }
                #endregion

                #region UnidadesPermitidas y Stock

                if (pedidoDetalle.Producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                {
                    var unidadesPermitidas = _ofertaProductoBusinessLogic.GetUnidadesPermitidasByCuv(usuario.PaisID, usuario.CampaniaID, pedidoDetalle.Producto.CUV);
                    var saldo = _ofertaProductoBusinessLogic.ValidarUnidadesPermitidasEnPedido(usuario.PaisID, usuario.CampaniaID, pedidoDetalle.Producto.CUV, usuario.ConsultoraID);
                    var stock = _ofertaProductoBusinessLogic.GetStockOfertaProductoLiquidacion(usuario.PaisID, usuario.CampaniaID, pedidoDetalle.Producto.CUV);

                    if (saldo < pedidoDetalle.StockNuevo)
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
                        if (stock < pedidoDetalle.StockNuevo)
                        {
                            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_UNIDAD_SOBREPASA_STOCK, null, stock);
                        }
                    }
                }
                else
                {
                    var pedidoAuxiliar = new BEPedidoDetalle()
                    {
                        Cantidad = pedidoDetalle.StockNuevo,
                        PaisID = pedidoDetalle.PaisID,
                        Producto = new Entities.BEProducto()
                        {
                            TipoEstrategiaID = pedidoDetalle.Producto.TipoEstrategiaID,
                            CUV = pedidoDetalle.Producto.CUV
                        }
                    };

                    var message = ValidarStockEstrategiaMensaje(usuario, pedidoAuxiliar);
                    if (!String.IsNullOrEmpty(message)) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, message);

                    //ValidarCantidadEnProgramaNuevas   

                    if (pedidoDetalle.EsCuponNuevas)
                    {
                        int cantidadEnPedido = lstDetalle.Where(a => a.CUV == pedidoDetalle.Producto.CUV).Sum(b => b.Cantidad);
                        var valor = _programaNuevasBusinessLogic.ValidarCantidadMaxima
                            (usuario.PaisID, usuario.CampaniaID, usuario.ConsecutivoNueva, usuario.CodigoPrograma, cantidadEnPedido, pedidoDetalle.Producto.CUV, pedidoDetalle.StockNuevo);

                        if (valor != 0)
                        {
                            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, string.Format(Constantes.ProgNuevas.Mensaje.ExcedeLimiteUnidades, valor.ToString()));
                        }

                        var pedidoAuxiliarStock = new BEPedidoDetalle()
                        {
                            Cantidad = pedidoDetalle.StockNuevo,
                            PaisID = pedidoDetalle.PaisID,
                            Producto = new Entities.BEProducto()
                            {
                                TipoEstrategiaID = pedidoDetalle.Producto.TipoEstrategiaID,
                                CUV = pedidoDetalle.Producto.CUV
                            }
                        };
                        //Validar Stock limite de Venta
                        var resultStockLimite = ValidarStockLimiteVenta(usuario, pedidoAuxiliarStock, lstDetalle.Where(x => x.PedidoDetalleID != pedidoDetalle.PedidoDetalleID).ToList(), out mensaje);
                        if (resultStockLimite) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_LIMITE_VENTA, mensaje);
                    }
                }

                #endregion

                if (pedidoDetalle.SetID > 0)
                {
                    var detallePedido = _pedidoWebDetalleBusinessLogic.GetPedidoWebSetDetalle(pedidoDetalle.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                    var xsets = detallePedido.Where(x => x.SetId != pedidoDetalle.SetID);
                    var ncant = pedidoDetalle.Cantidad;

                    var set = _pedidoWebSetBusinessLogic.Obtener(pedidoDetalle.PaisID, pedidoDetalle.SetID);

                    IEnumerable<BEPedidoWebSetDetalle> detallesSet = null;

                    if (ObtieneValorFlagDesactivacionNoDigitable())
                        detallesSet = set.Detalles.Where(x => x.Digitable == 1).ToList();
                    else
                        detallesSet = set.Detalles.ToList();


                    foreach (var detalleSet in detallesSet)
                    {
                        var ocant = 0;
                        if (xsets.Any())
                        {
                            var xset = xsets.Where(x => x.CuvProducto == detalleSet.CuvProducto);
                            ocant = xset.Any() ? xset.Sum(x => x.Cantidad) : 0;
                        }

                        var oBePedidoWebSetDetalle = new BEPedidoDetalle
                        {
                            PaisID = pedidoDetalle.PaisID,
                            PedidoID = pedidoDetalle.PedidoID,
                            PedidoDetalleID = Convert.ToInt16(detalleSet.PedidoDetalleId),
                            Cantidad = (ncant * detalleSet.FactorRepeticion) + ocant,
                            ClienteID = string.IsNullOrEmpty(usuario.Nombre) ? (short)0 : Convert.ToInt16(pedidoDetalle.ClienteID),
                            ClienteDescripcion = pedidoDetalle.ClienteDescripcion,
                            ImporteTotal = ((ncant * detalleSet.FactorRepeticion) + ocant) * detalleSet.PrecioUnidad,
                            Producto = new BEProducto()
                            {
                                PrecioCatalogo = detalleSet.PrecioUnidad,
                                CUV = detalleSet.CuvProducto,
                                TipoOfertaSisID = detalleSet.TipoOfertaSisId,
                                Descripcion = pedidoDetalle.Producto.Descripcion
                            },
                            IPUsuario = pedidoDetalle.IPUsuario,
                            Identifier = pedidoDetalle.Identifier
                        };
                        lstDetalleApp.Add(oBePedidoWebSetDetalle);
                    }
                }
                else
                {
                    pedidoDetalle.ImporteTotal = pedidoDetalle.Cantidad * pedidoDetalle.Producto.PrecioCatalogo;
                    lstDetalleApp.Add(pedidoDetalle);
                }

                //accion actualizar

                List<BEPedidoWebDetalle> pedidoWebDetalles = new List<BEPedidoWebDetalle>();
                foreach (BEPedidoDetalle detalle in lstDetalleApp)
                {
                    var obePedidoWebDetalle = new BEPedidoWebDetalle
                    {
                        PaisID = detalle.PaisID,
                        CampaniaID = usuario.CampaniaID,
                        PedidoID = detalle.PedidoID,
                        PedidoDetalleID = detalle.PedidoDetalleID,
                        Cantidad = Convert.ToInt32(detalle.Cantidad),
                        PrecioUnidad = detalle.Producto.PrecioCatalogo,
                        ClienteID = detalle.ClienteID,
                        CUV = detalle.Producto.CUV,
                        TipoOfertaSisID = detalle.Producto.TipoOfertaSisID,
                        DescripcionProd = detalle.Producto.Descripcion,
                        ImporteTotal = detalle.ImporteTotal,
                        Nombre = detalle.ClienteID == 0 ? usuario.Nombre : detalle.ClienteDescripcion,
                        Flag = 2,
                        Stock = pedidoDetalle.StockNuevo,
                        TipoAdm = Constantes.PedidoAccion.UPDATE,
                        OrigenSolicitud = pedidoDetalle.OrigenSolicitud
                    };

                    pedidoWebDetalles.Add(obePedidoWebDetalle);

                }

                List<string> listCuvEliminar;
                string mensajeObs = "";
                string TituloMensaje = "";
                var modificoBackOrder = false;
                List<BEMensajeProl> ListaMensajeCondicional;
                List<ObjMontosProl> listObjMontosProl;
                BEPedidoWeb pedidoWeb;

                var transactionExitosa = AdministradorPedido(usuario, pedidoDetalle, pedidoWebDetalles, null, "", Constantes.PedidoAccion.UPDATE, out mensajeObs, out listCuvEliminar, out TituloMensaje, out modificoBackOrder, out ListaMensajeCondicional, out listObjMontosProl, out pedidoWeb);

                var response = PedidoDetalleRespuesta(transactionExitosa ? Constantes.PedidoValidacion.Code.SUCCESS : Constantes.PedidoValidacion.Code.ERROR_GRABAR, mensajeObs);
                response.ModificoBackOrder = modificoBackOrder;
                response.ListaMensajeCondicional.AddRange(ListaMensajeCondicional);
                response.PedidoWeb = pedidoWeb;
                SetMontosTotalesProl(response, listObjMontosProl);
                return response;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }

        }

        public async Task<BEPedidoDetalleResult> PedidoDeleteProductoTransaction(BEPedidoDetalle pedidoDetalle)
        {
            try
            {
                var usuario = pedidoDetalle.Usuario;
                //Informacion de usuario
                usuario.PaisID = pedidoDetalle.PaisID;

                var lstDetalle = new List<BEPedidoWebDetalle>();

                //Eliminar Detalle
                var responseCode = Constantes.PedidoValidacion.Code.SUCCESS;
                var respuesta = new BEPedidoDetalleResult();
                BEPedidoWeb pedidoWeb = null;
                if (pedidoDetalle.Producto == null)
                {
                    responseCode = await DeleteAll(usuario, pedidoDetalle);
                    List<BEMensajeProl> listaMensajeCondicional;
                    UpdateProlCrud(usuario, lstDetalle, out listaMensajeCondicional, out pedidoWeb);
                }
                else
                {
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
                    lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                    respuesta = PedidoAgregar_EliminarUno(pedidoDetalle, lstDetalle);
                    if (respuesta.CodigoRespuesta != Constantes.PedidoValidacion.Code.SUCCESS)
                    {
                        return respuesta;
                    }
                }

                PedidoAgregar_DesReservarPedido(lstDetalle, pedidoDetalle.Producto, usuario);
                var request = PedidoDetalleRespuesta(responseCode);
                request.PedidoWeb = pedidoWeb ?? respuesta.PedidoWeb;

                return request;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoDetalle.Usuario.CodigoUsuario, pedidoDetalle.PaisID);
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        private void SetMontosTotalesProl(BEPedidoDetalleResult result, List<ObjMontosProl> listObjMontosProl)
        {
            if (listObjMontosProl.Any())
            {
                result.MontoAhorroCatalogo = listObjMontosProl[0].AhorroCatalogo;
                result.MontoAhorroRevista = listObjMontosProl[0].AhorroRevista;
                result.DescuentoProl = listObjMontosProl[0].MontoTotalDescuento;
                result.MontoEscala = listObjMontosProl[0].MontoEscala;
            }
            else
            {
                var cero = "0.00";
                result.MontoAhorroCatalogo = cero;
                result.MontoAhorroRevista = cero;
                result.DescuentoProl = cero;
                result.MontoEscala = cero;
            }
        }


        private BEPedidoDetalleResult SetMontosTotalesProl(BEPedidoDetalleResult result, BEResultadoReservaProl respuestaReserva, BEPedidoDetalle pedidoDetalle)
        {
            result.MontoAhorroCatalogo = respuestaReserva.MontoAhorroCatalogo.ToString("#.00");
            result.MontoAhorroRevista = respuestaReserva.MontoAhorroRevista.ToString("#.00");
            result.DescuentoProl = respuestaReserva.MontoDescuento.ToString("#.00");
            result.MontoEscala = respuestaReserva.MontoEscala.ToString("#.00");

            int pedidoId = 0;
            var pedidoWebAgrupado = _pedidoWebDetalleBusinessLogic.ObtenerPedidoWebSetDetalleAgrupado(pedidoDetalle.Usuario, out pedidoId);
            var pedidoWeb = _pedidoWebBusinessLogic.GetPedidoWebConCalculosGanancia(pedidoDetalle.Usuario, respuestaReserva.MontoAhorroCatalogo, respuestaReserva.MontoAhorroRevista, respuestaReserva.MontoDescuento, respuestaReserva.MontoEscala, pedidoWebAgrupado);
            if (pedidoWeb != null)
            {
                _pedidoWebBusinessLogic.UpdateMontosPedidoWeb(pedidoWeb);
            }
            result.PedidoWeb = pedidoWeb;
            return result;
        }


        private BEPedidoDetalle PedidoAgregar_ObtenerEstrategia(BEPedidoDetalle pedidoDetalle)
        {
            if (pedidoDetalle.Producto.EstrategiaID == 0 && pedidoDetalle.Estrategia == null)
            {
                pedidoDetalle.Estrategia = new BEEstrategia();
                pedidoDetalle.Estrategia.Cantidad = Convert.ToInt32(pedidoDetalle.Cantidad);
                pedidoDetalle.Estrategia.LimiteVenta = pedidoDetalle.LimiteVenta;
                pedidoDetalle.Estrategia.DescripcionCUV2 = Util.Trim(pedidoDetalle.Producto.DescripcionProducto);
                pedidoDetalle.Estrategia.FlagNueva = string.IsNullOrEmpty(pedidoDetalle.Producto.FlagNueva) ? 0 : Convert.ToInt32(pedidoDetalle.Producto.FlagNueva);
                pedidoDetalle.Estrategia.Precio2 = pedidoDetalle.Producto.PrecioCatalogo;
                pedidoDetalle.Estrategia.TipoEstrategiaID = string.IsNullOrEmpty(pedidoDetalle.Producto.TipoEstrategiaID) ? 0 : Convert.ToInt32(pedidoDetalle.Producto.TipoEstrategiaID);
                pedidoDetalle.Estrategia.IndicadorMontoMinimo = pedidoDetalle.Producto.IndicadorMontoMinimo;
                pedidoDetalle.Estrategia.CUV2 = pedidoDetalle.Producto.CUV;
                pedidoDetalle.Estrategia.MarcaID = pedidoDetalle.Producto.MarcaID;
            }

            return pedidoDetalle;
        }

        private BEEstrategia PedidoAgregar_FiltrarEstrategiaPedido(BEPedidoDetalle pedidoDetalle, int paisId)
        {
            int indFlagNueva;
            Int32.TryParse(pedidoDetalle.Producto.FlagNueva == "" ? "0" : pedidoDetalle.Producto.FlagNueva, out indFlagNueva);
            var estrategia = pedidoDetalle.Estrategia ?? FiltrarEstrategiaPedido(paisId, pedidoDetalle.Producto.EstrategiaID, indFlagNueva);
            return estrategia;
        }

        private BEPedidoDetalleResult PedidoAgregar_EliminarUno(BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var usuario = pedidoDetalle.Usuario;
            usuario.PaisID = pedidoDetalle.PaisID;

            string responseCode;

            var lista = new List<BEPedidoWebDetalle>();

            var pedidoID = lstDetalle.Any() ? lstDetalle.FirstOrDefault().PedidoID : 0;

            if (pedidoDetalle.SetID > 0)
            {
                var set = _pedidoWebSetBusinessLogic.Obtener(usuario.PaisID, pedidoDetalle.SetID);
                if (set == null) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_SET_NOENCONTRADO);

                foreach (var detalle in set.Detalles)
                {
                    var pedidoWebDetalle = lstDetalle.FirstOrDefault(p => p.CUV == detalle.CuvProducto);
                    if (pedidoWebDetalle == null) continue;

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
                            SetID = detalle.SetId,
                            TipoAdm = Constantes.PedidoAccion.UPDATE
                        };

                        lista.Add(obePedidoWebDetalle);
                    }
                    else
                    {
                        var cantidadAnterior = pedidoDetalle.Cantidad;
                        pedidoDetalle.Cantidad = set.Cantidad * detalle.FactorRepeticion;

                        var obePedidoWebDetalle = new BEPedidoWebDetalle
                        {
                            PaisID = pedidoDetalle.PaisID,
                            CampaniaID = usuario.CampaniaID,
                            PedidoID = pedidoDetalle.PedidoID,
                            PedidoDetalleID = pedidoDetalle.PedidoDetalleID,
                            TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                            CUV = pedidoDetalle.Producto.CUV,
                            Cantidad = pedidoDetalle.Cantidad,
                            Mensaje = pedidoDetalle.ObservacionPROL,
                            SetID = detalle.SetId,
                            TipoAdm = Constantes.PedidoAccion.DELETE
                        };
                        lista.Add(obePedidoWebDetalle);

                        pedidoDetalle.Cantidad = cantidadAnterior;
                    }
                }

                responseCode = Constantes.PedidoValidacion.Code.ERROR_ELIMINAR_SET;
            }
            else
            {
                var obePedidoWebDetalle = new BEPedidoWebDetalle
                {
                    PaisID = pedidoDetalle.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    PedidoID = pedidoDetalle.PedidoID,
                    PedidoDetalleID = pedidoDetalle.PedidoDetalleID,
                    TipoOfertaSisID = pedidoDetalle.Producto.TipoOfertaSisID,
                    CUV = pedidoDetalle.Producto.CUV,
                    Cantidad = pedidoDetalle.Cantidad,
                    Mensaje = pedidoDetalle.ObservacionPROL,
                    TipoAdm = Constantes.PedidoAccion.DELETE
                };
                lista.Add(obePedidoWebDetalle);
                responseCode = Constantes.PedidoValidacion.Code.ERROR_ELIMINAR;
            }

            List<string> listCuvEliminar;
            string mensajeObs = "";
            string TituloMensaje = "";
            var modificoBackOrder = false;
            List<BEMensajeProl> ListaMensajeCondicional;
            List<ObjMontosProl> listObjMontosProl;
            BEPedidoWeb pedidoWeb;

            var result = AdministradorPedido(usuario, pedidoDetalle, lista, null, null, Constantes.PedidoAccion.DELETE, out mensajeObs, out listCuvEliminar, out TituloMensaje, out modificoBackOrder, out ListaMensajeCondicional, out listObjMontosProl, out pedidoWeb);
            if (result) responseCode = Constantes.PedidoValidacion.Code.SUCCESS;
            var response = PedidoDetalleRespuesta(responseCode);
            ListaMensajeCondicional.AddRange(response.ListaMensajeCondicional);
            SetMontosTotalesProl(response, listObjMontosProl);
            response.PedidoWeb = pedidoWeb;
            return response;
        }

        private void PedidoAgregar_DesReservarPedido(List<BEPedidoWebDetalle> lstDetalle, BEProducto producto, BEUsuario usuario)
        {
            if (!lstDetalle.Any() && producto != null && usuario.ZonaValida)
            {
                using (var sv = new ServiceStockSsic())
                {
                    sv.Url = ConfigurarUrlServiceProl(usuario.CodigoISO);
                    sv.wsDesReservarPedido(usuario.CodigoConsultora, usuario.CodigoISO);
                }
            }

        }
        #endregion

        #region Publicos
        public BEPedidoProducto GetCUV(BEPedidoProductoBuscar productoBuscar)
        {
            var lstProductoFinal = new List<BEProducto>();
            var validacionTipoEstrategia = string.Empty;

            try
            {
                //Informacion de palancas
                var usuario = productoBuscar.Usuario;

                var lstConfiguracionPais = new List<string>();
                lstConfiguracionPais.Add(Constantes.ConfiguracionPais.RevistaDigital);
                lstConfiguracionPais.Add(Constantes.ConfiguracionPais.Recomendaciones);

                var configuracionPaisTask = Task.Run(() => _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, string.Join("|", lstConfiguracionPais)));
                var codigosRevistasTask = Task.Run(() => _usuarioBusinessLogic.ObtenerCodigoRevistaFisica(usuario.PaisID));
                if (Constantes.Inicializacion.EnteroInicial == usuario.ConsecutivoNueva)
                {
                    var upUsuarioProgramaNuevaTask = Task.Run(() => _usuarioBusinessLogic.UpdUsuarioProgramaNuevas(usuario));
                    Task.WaitAll(configuracionPaisTask, codigosRevistasTask, upUsuarioProgramaNuevaTask);
                }
                else
                {
                    Task.WaitAll(configuracionPaisTask, codigosRevistasTask);
                }

                usuario = configuracionPaisTask.Result;
                usuario.CodigosRevistaImpresa = codigosRevistasTask.Result;

                //Validación de cuvs en programa nuevas
                #region ValidarProgramaNuevas
                var num = ValidarProgramaNuevas(usuario, productoBuscar.CodigoDescripcion);
                var esCuponNuevas = false;
                switch (num)
                {
                    case Enumeradores.ValidacionProgramaNuevas.ProductoNoExiste:
                        return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);
                    case Enumeradores.ValidacionProgramaNuevas.ConsultoraNoNueva:
                        return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NONUEVA);
                    case Enumeradores.ValidacionProgramaNuevas.CuvNoPerteneceASuPrograma:
                        return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NUEVA_NOPERTENECE_TUPROGRAMA);
                    case Enumeradores.ValidacionProgramaNuevas.CuvPerteneceProgramaNuevas:
                        esCuponNuevas = true;
                        break;
                }
                #endregion

                #region Venta exclusiva
                if (!esCuponNuevas)
                {
                    Enumeradores.ValidacionVentaExclusiva numExclu = ValidarVentaExclusiva(usuario, productoBuscar.CodigoDescripcion);
                    if (numExclu != Enumeradores.ValidacionVentaExclusiva.ContinuaFlujo)
                        return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOPERTENECE_VENTAEXCLUSIVA);

                }
                #endregion

                //Validación de cuvs en Camino Brillante
                #region Camino Brillante
                var valCaminoBrillante = _bLCaminoBrillante.ValidarBusquedaCaminoBrillante(usuario, productoBuscar.CodigoDescripcion);
                if (valCaminoBrillante.Validacion != Enumeradores.ValidacionCaminoBrillante.ProductoNoExiste)
                {
                    return ProductoBuscarRespuesta(valCaminoBrillante.Code, valCaminoBrillante.Mensaje);
                }
                #endregion

                //Validación producto no existe
                BEProductoBusqueda busqueda = new BEProductoBusqueda
                {
                    PaisID = productoBuscar.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    CodigoDescripcion = productoBuscar.CodigoDescripcion,
                    RegionID = usuario.RegionID,
                    ZonaID = usuario.ZonaID,
                    CodigoRegion = usuario.CodigorRegion,
                    CodigoZona = usuario.CodigoZona,
                    Criterio = productoBuscar.Criterio,
                    RowCount = productoBuscar.RowCount,
                    ValidarOpt = productoBuscar.ValidarOpt,
                    CodigoPrograma = usuario.CodigoPrograma,
                    NumeroPedido = usuario.ConsecutivoNueva + 1
                };

                var lstProducto = _productoBusinessLogic.SelectProductoByCodigoDescripcionSearchRegionZona(busqueda);

                if (!lstProducto.Any()) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

                foreach (var item in lstProducto)
                {
                    if (!string.IsNullOrEmpty(item.TipoEstrategiaID))
                    {
                        validacionTipoEstrategia = BloqueoTipoEstrategia(productoBuscar.PaisID, item.TipoEstrategiaID);
                        if (string.IsNullOrEmpty(validacionTipoEstrategia))
                        {
                            lstProductoFinal.Add(item);
                            break;
                        }
                    }
                    else
                    {
                        lstProductoFinal.Add(item);
                        break;
                    }
                }

                if (!string.IsNullOrEmpty(validacionTipoEstrategia)) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_ESTRATEGIA, validacionTipoEstrategia);

                var producto = lstProductoFinal.FirstOrDefault();
                if (producto == null) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

                if (producto.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_SET);

                var bloqueoProductoCatalogo = BloqueoProductosCatalogo(usuario.RevistaDigital, usuario.CodigosRevistaImpresa, producto);
                if (!bloqueoProductoCatalogo) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_NOEXISTE);

                if (!producto.TieneStock) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_AGOTADO, null, producto);

                if (producto.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_LIQUIDACION, null, producto);

                if (producto.TieneSugerido > 0) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_SUGERIDO, null, producto);

                if (usuario.RevistaDigital != null)
                {
                    var desactivaRevistaGana = _pedidoWebBusinessLogic.ValidarDesactivaRevistaGana(productoBuscar.PaisID,
                                                    usuario.CampaniaID,
                                                    usuario.CodigoZona);
                    var tieneRDC = (usuario.RevistaDigital.TieneRDC && usuario.RevistaDigital.EsActiva) || usuario.RevistaDigital.TieneRDCR;
                    if (!producto.EsExpoOferta && producto.CUVRevista.Length != 0 && desactivaRevistaGana == 0 && !tieneRDC)
                    {
                        if (WebConfig.PaisesEsika.Contains(Util.GetPaisISO(productoBuscar.PaisID))) return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_ESIKA, null, producto);
                        else return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_OFERTAREVISTA_LBEL, null, producto);
                    }
                }

                producto.TieneOfertasRelacionadas = TieneOfertasRelacionadas(usuario, producto);

                return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.SUCCESS, null, producto);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, productoBuscar.Usuario.CodigoUsuario, productoBuscar.PaisID);
                return ProductoBuscarRespuesta(Constantes.PedidoValidacion.Code.ERROR_INTERNO, ex.Message);
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
                var suscritaActiva = (usuario.RevistaDigital.EsSuscrita && usuario.RevistaDigital.EsActiva);

                if (pedido == null) pedido = new BEPedidoWeb();

                //Obtener Detalle
                var pedidoID = 0;
                var lstDetalle = ObtenerPedidoWebSetDetalleAgrupado(usuario, true, out pedidoID);

                pedido.ImporteTotal = lstDetalle.Sum(x => x.ImporteTotal);

                if (lstDetalle.Any())
                {
                    lstDetalle.Where(x => x.ClienteID == 0).Update(x => x.Nombre = usuario.Nombre);

                    lstDetalle.Update(x =>
                    {
                        x.DescripcionEstrategia = Util.obtenerNuevaDescripcionProductoDetalle(
                                                        x.ConfiguracionOfertaID,
                                                        pedidoValidado,
                                                        x.FlagConsultoraOnline,
                                                        x.OrigenPedidoWeb,
                                                        lista,
                                                        suscritaActiva,
                                                        x.TipoEstrategiaCodigo,
                                                        x.MarcaID,
                                                        x.CodigoCatalago,
                                                        x.DescripcionOferta,
                                                        x.EsCuponNuevas,
                                                        x.EsElecMultipleNuevas,
                                                        x.EsPremioElectivo,
                                                        x.EsCuponIndependiente,
                                                        null,
                                                        x.EsKitCaminoBrillante || x.EsDemCaminoBrillante);

                        var lstCatalogos = Util.GetCodigosCatalogo();
                        var esCatalogo = lstCatalogos.Any(item => item == x.CodigoCatalago.ToString());
                        x.TipoPersonalizacion = esCatalogo ? Constantes.TipoPersonalizacion.Catalogo : Util.GetTipoPersonalizacionByCodigoEstrategia(x.TipoEstrategiaCodigo);
                    });

                    lstDetalle.Where(x => x.EsKitNueva).Update(x => x.DescripcionEstrategia = Constantes.PedidoDetalleApp.DescripcionKitInicio);
                    lstDetalle.Where(x => x.IndicadorOfertaCUV && x.TipoEstrategiaID == 0 && !x.EsKitCaminoBrillante && !x.EsDemCaminoBrillante)
                        .Update(x => x.DescripcionEstrategia = Constantes.PedidoDetalleApp.OfertaNiveles);

                    lstDetalle.Where(x => x.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack).Update(item => item.EsArmaTuPack = true);

                    pedido.CantidadProductos = lstDetalle.Sum(p => p.Cantidad);
                    pedido.CantidadCuv = lstDetalle.Count;
                    pedido.TieneArmaTuPack = lstDetalle.Any(x => x.EsArmaTuPack);
                }

                //Programa nuevas
                if (usuario.MontoMaximoPedido > 0)
                {
                    var consultoraNuevas = new BEConsultoraProgramaNuevas { PaisID = usuario.PaisID, CampaniaID = usuario.CampaniaID, CodigoConsultora = usuario.CodigoConsultora };
                    var tippingPoint = _configuracionProgramaNuevasBusinessLogic.Get(consultoraNuevas);
                    if (tippingPoint.IndExigVent == "1") pedido.TippingPoint = tippingPoint.MontoVentaExigido;
                }

                if ((usuario.ConsecutivoNueva + 1) > 0 && (usuario.ConsecutivoNueva + 1) < 7)
                {
                    var consultoraNuevas = new BEConsultoraProgramaNuevas { PaisID = usuario.PaisID, CampaniaID = usuario.CampaniaID, CodigoConsultora = usuario.CodigoConsultora };
                    var tippingPoint = _configuracionProgramaNuevasBusinessLogic.Get(consultoraNuevas);
                    var activaPremios = _bLActivarPremioNuevas.GetActivarPremioNuevas(usuario.PaisID, usuario.CodigoPrograma, usuario.CampaniaID, "0" + (usuario.ConsecutivoNueva + 1));
                    var config = _usuarioBusinessLogic.GetBasicSesionUsuario(usuario.PaisID, usuario.CodigoUsuario);

                    pedido.MuestraRegalo = (activaPremios.ActivePremioAuto || activaPremios.ActivePremioElectivo);

                    if (tippingPoint.IndExigVent == "0" || tippingPoint.MontoVentaExigido == 0) pedido.TippingPoint = config.MontoMinimoPedido;
                    else pedido.TippingPoint = tippingPoint.MontoVentaExigido;

                    var lstEstrategia = _estrategiaBusinessLogic.GetEstrategiaPremiosElectivos(usuario.PaisID, usuario.CodigoPrograma, usuario.CampaniaID, usuario.Nivel);
                    if (lstEstrategia.Any() && lstDetalle.Any()) lstDetalle.ForEach(p => p.EsPremioElectivo = lstEstrategia.Any(c => c.CUV2 == p.CUV));
                }

                //Duo Perfecto
                if (!string.IsNullOrEmpty(usuario.CodigoPrograma) && usuario.ConsecutivoNueva > 0)
                {
                    lstDetalle.Where(x => x.FlagNueva && x.EsCuponNuevas).Update(detalle =>
                    {
                        detalle.EsDuoPerfecto = _programaNuevasBusinessLogic.EsCuvElecMultiple(usuario.PaisID, usuario.CampaniaID, usuario.ConsecutivoNueva, usuario.CodigoPrograma, detalle.CUV);
                    });
                }

                //Web set y detalle
                lstDetalle.Where(filtro => filtro.SetID > 0).Update(detalle =>
                {
                    detalle.PedidoWebSet = _pedidoWebSetBusinessLogic.Obtener(usuario.PaisID, detalle.SetID);
                });

                pedido.olstBEPedidoWebDetalle = lstDetalle;
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

                usuario.EsConsultoraNueva = _usuarioBusinessLogic.EsConsultoraNueva(usuario);
                var consultoraNuevas = new BEConsultoraProgramaNuevas
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    CodigoConsultora = usuario.CodigoConsultora,
                    EsConsultoraNueva = usuario.EsConsultoraNueva,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };
                var confProgNuevas = _configuracionProgramaNuevasBusinessLogic.Get(consultoraNuevas);
                if (confProgNuevas.IndProgObli != "1") return false;

                string cuvKitNuevas = _configuracionProgramaNuevasBusinessLogic.GetCuvKitNuevas(consultoraNuevas, confProgNuevas);
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
                    List<BEMensajeProl> listMensajeCondicional;

                    UpdateProl(usuario, lstDetalle, out listMensajeCondicional);

                    return true;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
            }
            return false;
        }

        public BEConfiguracionPedido GetConfiguracion(int paisID, string codigoUsuario, int campaniaID, string region, string zona)
        {
            var config = new BEConfiguracionPedido();

            try
            {
                config.Barra = GetDataBarra(paisID, campaniaID, region, zona);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
            }

            return config;
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

                if (string.IsNullOrEmpty(usuario.CodigoZona))
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
                        Descripcion = Constantes.PedidoValidacion.Configuracion[Constantes.PedidoValidacion.Code.ERROR_RESERVA_BACK_ORDER].Mensaje,
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
                pedido = pedido ?? _pedidoWebBusinessLogic.GetPedidoWebByCampaniaConsultora(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);

                if (!(pedido.EstadoPedido == Constantes.EstadoPedido.Procesado && !pedido.ModificaPedidoReservado && !pedido.ValidacionAbierta))
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_DESHACER_PEDIDO_ESTADO);

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

                foreach (var item in lstEstrategia)
                {
                    item.PaisID = usuario.PaisID;
                    item.DescripcionCortaCUV2 = Util.SubStrCortarNombre(item.DescripcionCUV2, 40);
                    item.FotoProducto01 = ConfigCdn.GetUrlFileCdnMatriz(usuario.CodigoISO, item.FotoProducto01);
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
                var validacionLimiteVenta = ValidarLimiteVenta(estrategia, lstDetalleSets, x => x.CUV == estrategia.CUV2 && x.SetID != 0);
                if (validacionLimiteVenta != null) return validacionLimiteVenta;

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

                List<BEMensajeProl> ListaMensajeCondicional;

                UpdateProl(usuario, lstDetalle, out ListaMensajeCondicional);

                //Agregar sets agrupados
                var listCuvTonos = pedidoDetalle.Producto.CUV;
                if (string.IsNullOrEmpty(listCuvTonos)) listCuvTonos = estrategia.CUV2;
                var tonos = listCuvTonos.Split('|');
                var listaComponentes = new List<BEEstrategiaProducto>();

                foreach (var tono in tonos)
                {
                    var listSp = tono.Split(';');
                    var CUV2 = listSp.Length > 0 ? listSp[0] : estrategia.CUV2;
                    var digitable = listSp.Length > 4 ? listSp[4] : "0";
                    var grupo = listSp.Length > 5 ? listSp[5] : "0";

                    listaComponentes.Add(new BEEstrategiaProducto
                    {
                        CUV = CUV2,
                        Digitable = Convert.ToInt32(digitable),
                        Grupo = grupo
                    });
                }

                var componentes = string.Empty;
                if (listaComponentes.Any())
                {
                    var listComponentes = listaComponentes.GroupBy(x => new { x.CUV, x.Digitable, x.Grupo }).Select(group => new EstrategiaComponente
                    {
                        CUV = group.Key.CUV,
                        Digitable = group.Key.Digitable,
                        Grupo = group.Key.Grupo,
                        Cantidad = group.Count()
                    }).ToList();

                    componentes = listComponentes.Serialize();
                }
                _pedidoWebDetalleBusinessLogic.InsertPedidoWebSet(usuario.PaisID, usuario.CampaniaID, pedidoDetalle.PedidoID, pedidoDetalle.Cantidad, estrategia.CUV2, usuario.ConsultoraID, usuario.CodigoUsuario, componentes, estrategia.EstrategiaID, usuario.Nombre, usuario.CodigoPrograma, usuario.ConsecutivoNueva);
                var response = PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
                ListaMensajeCondicional.AddRange(response.ListaMensajeCondicional);

                return response;
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

        public BEProducto GetRegaloOfertaFinal(BEUsuario usuario)
        {
            var ProductoRegalo = new BEProducto();
            try
            {
                List<BEEstrategia> LstEstrategia = _estrategiaBusinessLogic.GetEstrategiaPremiosElectivos(usuario.PaisID, usuario.CodigoPrograma, usuario.CampaniaID, usuario.Nivel);
                if (LstEstrategia == null) LstEstrategia = new List<BEEstrategia>();
                BEPedidoWeb objPedidoDetalle = Get(usuario);

                if (objPedidoDetalle.olstBEPedidoWebDetalle == null) objPedidoDetalle.olstBEPedidoWebDetalle = new List<BEPedidoWebDetalle>();

                if (objPedidoDetalle.olstBEPedidoWebDetalle.Any(x => x.EsPremioElectivo))
                {
                    var prodRegalo = objPedidoDetalle.olstBEPedidoWebDetalle.FirstOrDefault(x => x.EsPremioElectivo);
                    ProductoRegalo.CUV = prodRegalo.CUV;
                    ProductoRegalo.DescripcionProducto = prodRegalo.DescripcionProd;
                }
                else
                {
                    var prodRegalo = LstEstrategia.FirstOrDefault(x => x.CuponElectivoDefault);
                    if (prodRegalo == null) prodRegalo = new BEEstrategia() { CUV2 = string.Empty, DescripcionCUV2 = string.Empty };
                    ProductoRegalo.CUV = prodRegalo.CUV2;
                    ProductoRegalo.DescripcionProducto = prodRegalo.DescripcionCUV2;
                }

                if (objPedidoDetalle.MuestraRegalo)
                {
                    ProductoRegalo.RestanteTippingPoint = objPedidoDetalle.TippingPoint - objPedidoDetalle.ImporteTotal;
                    ProductoRegalo.MensajeOfertaFinal = Constantes.Incentivo.OfertaFinalTippingPoint;
                }

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.PaisID, usuario.CodigoUsuario);
            }

            return ProductoRegalo;
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
                    var listCuvTonos = pedidoDetalle.Producto.CUV;
                    var tonos = listCuvTonos.Split('|');
                    var listaComponentes = new List<BEEstrategiaProducto>();

                    foreach (var tono in tonos)
                    {
                        var listSp = tono.Split(';');
                        var CUV2 = listSp[0];
                        var digitable = listSp.Length > 4 ? listSp[4] : "0";
                        var grupo = listSp.Length > 5 ? listSp[5] : "0";

                        listaComponentes.Add(new BEEstrategiaProducto
                        {
                            CUV = CUV2,
                            Digitable = Convert.ToInt32(digitable),
                            Grupo = grupo
                        });
                    }

                    var componentes = string.Empty;
                    if (listaComponentes.Any())
                    {
                        var listComponentes = listaComponentes.GroupBy(x => new { x.CUV, x.Digitable, x.Grupo }).Select(group => new EstrategiaComponente
                        {
                            CUV = group.Key.CUV,
                            Digitable = group.Key.Digitable,
                            Grupo = group.Key.Grupo,
                            Cantidad = group.Count()
                        }).ToList();

                        componentes = listComponentes.Serialize();
                    }
                    PedidoAgregarProductoAgrupado(usuario, pedido.PedidoID, pedidoDetalle.Cantidad, pedidoDetalle.Producto.CUV, componentes, 0);

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
                switch (pedidoDetalle.TipoPersonalizacion)
                {
                    case Constantes.TipoPersonalizacion.Liquidacion:
                        return RegistroLiquidacion(pedidoDetalle);
                    case Constantes.TipoPersonalizacion.Catalogo:
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

        public List<BEPedidoDetalleResult> InsertMasivo(List<BEPedidoDetalle> lstPedidoDetalle)
        {
            var tasksBuscar = lstPedidoDetalle.Select(pedidoDetalle => Task.Run(() =>
            {
                var productoBuscar = new BEPedidoProductoBuscar()
                {
                    PaisID = pedidoDetalle.PaisID,
                    CodigoDescripcion = pedidoDetalle.Producto.CUV,
                    Criterio = 1,
                    RowCount = 5,
                    ValidarOpt = true,
                    Usuario = pedidoDetalle.Usuario
                };

                var productoResult = GetCUV(productoBuscar);

                return new
                {
                    CodigoRespuesta = productoResult.CodigoRespuesta,
                    MensajeRespuesta = productoResult.MensajeRespuesta,
                    Producto = productoResult.Producto ?? pedidoDetalle.Producto,
                    ClienteID = pedidoDetalle.ClienteID
                };
            })).ToArray();

            Task.WaitAll(tasksBuscar);

            var lstResultBuscar = tasksBuscar.Select(x => x.Result);

            var lstResultInsertar = lstResultBuscar.Where(x => x.Producto.PermiteAgregarPedido).Select(y =>
            {
                var pedidoDetalle = lstPedidoDetalle.FirstOrDefault(z => z.ClienteID == y.ClienteID && z.Producto.CUV == y.Producto.CUV);

                pedidoDetalle.Producto = y.Producto;
                var result = Insert(pedidoDetalle);
                result.CUV = pedidoDetalle.Producto.CUV;
                result.ClienteID = pedidoDetalle.ClienteID;
                return result;
            }).ToList();

            return lstResultBuscar.Select(x =>
            {
                if (x.Producto.PermiteAgregarPedido)
                {
                    return lstResultInsertar.FirstOrDefault(y => y.ClienteID == x.ClienteID && y.CUV == x.Producto.CUV);
                }
                else
                {
                    return new BEPedidoDetalleResult()
                    {
                        CodigoRespuesta = x.CodigoRespuesta,
                        MensajeRespuesta = x.MensajeRespuesta,
                        CUV = x.Producto.CUV,
                        ClienteID = x.ClienteID
                    };
                }
            }).ToList();
        }

        public List<BEProductoRecomendado> GetProductoRecomendado(int paisID, bool RDEsSuscrita, bool RDEsActiva, List<BEProductoRecomendado> lst)
        {
            var listaDescripcionesDic = new Dictionary<string, string>();
            var suscripcionActiva = RDEsSuscrita && RDEsActiva;

            var listaDescripciones = _tablaLogicaDatosBusinessLogic.GetListCache(paisID, ConsTablaLogica.DescripcionProducto.TablaLogicaId);

            foreach (var item in listaDescripciones)
            {
                listaDescripcionesDic.Add(item.Codigo, item.Descripcion);
            }

            lst.ForEach(item =>
            {
                item.DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(listaDescripcionesDic, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaID, 0, true);
            });

            return lst;
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
            var pedidoMensajeConfig = Constantes.PedidoValidacion.Configuracion;
            if (producto != null && pedidoMensajeConfig.ContainsKey(codigoRespuesta)) producto.PermiteAgregarPedido = pedidoMensajeConfig[codigoRespuesta].PermiteAgregarPedido;

            return new BEPedidoProducto()
            {
                CodigoRespuesta = codigoRespuesta,
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoValidacion.Configuracion[codigoRespuesta].Mensaje : mensajeRespuesta,
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

        private Enumeradores.ValidacionProgramaNuevas ValidarProgramaNuevas(BEUsuario usuario, string cuv)
        {
            Enumeradores.ValidacionProgramaNuevas numero;
            try
            {
                numero = _programaNuevasBusinessLogic.ValidarBusquedaCuv(usuario.PaisID, usuario.CampaniaID, usuario.CodigoPrograma, usuario.ConsecutivoNueva, cuv);
            }
            catch (Exception)
            {
                numero = Enumeradores.ValidacionProgramaNuevas.ContinuaFlujo;
            }
            return numero;
        }

        private Enumeradores.ValidacionVentaExclusiva ValidarVentaExclusiva(BEUsuario usuario, string cuv)
        {
            try
            {
                return _productoBusinessLogic.ValidarVentaExclusiva(usuario.PaisID, usuario.CampaniaID, usuario.CodigoConsultora, cuv);
            }
            catch (Exception)
            {
                return Enumeradores.ValidacionVentaExclusiva.ContinuaFlujo;
            }
        }

        private bool TieneOfertasRelacionadas(BEUsuario usuario, BEProducto producto)
        {
            var activarRecomendaciones = usuario.RecomendacionesConfiguracion
                .Any(x => x.Codigo == Constantes.CodigoConfiguracionRecomendaciones.ActivarRecomendaciones && x.Valor1 == "1");

            var esCatalogo = false;
            var esIndividual = producto.EstrategiaIDSicc == 2001;

            var oCodigoCatalogo = usuario.RecomendacionesConfiguracion.FirstOrDefault(x => x.Codigo == Constantes.CodigoConfiguracionRecomendaciones.CodigoCatalogo);
            if (oCodigoCatalogo != null)
            {
                var lstCodigoCatalogo = oCodigoCatalogo.Valor1.Split(',');
                esCatalogo = lstCodigoCatalogo.Any(x => x == producto.CodigoCatalogo.ToString());
            }

            return activarRecomendaciones && esCatalogo && esIndividual && usuario.RevistaDigital.EsActiva;
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
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? string.Format(Constantes.PedidoValidacion.Configuracion[codigoRespuesta].Mensaje, args) : mensajeRespuesta
            };
        }

        private string ValidarStockEstrategia(BEUsuario usuario, BEPedidoWebDetalle pedidoWebDetalle, List<BEPedidoWebDetalle> lstDetalle)
        {
            var mensaje = string.Empty;

            var pedidoAuxiliar = new BEPedidoDetalle()
            {
                Cantidad = pedidoWebDetalle.Cantidad,
                PaisID = pedidoWebDetalle.PaisID,
                Producto = new BEProducto()
                {
                    TipoEstrategiaID = pedidoWebDetalle.TipoEstrategiaID.ToString(),
                    CUV = pedidoWebDetalle.CUV
                }
            };
            mensaje = ValidarStockEstrategiaMensaje(usuario, pedidoAuxiliar);

            if (mensaje == "")
            {

                var estaEnLimite = false;
                var cantidadActual = lstDetalle.Where(d => d.CUV == pedidoWebDetalle.CUV).Sum(d => d.Cantidad);

                estaEnLimite = _BLArmaTuPack.CuvEstaEnLimite(usuario.PaisID, usuario.CampaniaID, usuario.CodigoZona, pedidoWebDetalle.CUV, pedidoWebDetalle.Cantidad, cantidadActual);
                if (estaEnLimite) mensaje = string.Format(Constantes.MensajesError.ExcedioLimiteVenta, 1);
            }

            return mensaje;
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
            var consultoraNuevas = new BEConsultoraProgramaNuevas
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                CodigoConsultora = usuario.CodigoConsultora,
                EsConsultoraNueva = usuario.EsConsultoraNueva,
                ConsecutivoNueva = usuario.ConsecutivoNueva
            };

            var configProgNuevas = _configuracionProgramaNuevasBusinessLogic.Get(consultoraNuevas);
            if (configProgNuevas.IndProgObli != "1") return true;

            var cuvKitNuevas = _configuracionProgramaNuevasBusinessLogic.GetCuvKitNuevas(consultoraNuevas, configProgNuevas);
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
                IndicadorIPUsuario = pedidoDetalle.IPUsuario,
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

        private string CrearAvisoCuponElectivo(BERespValidarElectivos respElectivos)
        {
            var promocionNombre = Constantes.ProgNuevas.Mensaje.Electivo_PromocionNombre;
            if (respElectivos.LimNumElectivos == respElectivos.NumElectivosEnPedido)
            {
                return string.Format(Constantes.ProgNuevas.Mensaje.Electivo_CompletasteLimite, promocionNombre);
            }

            var numFaltantes = respElectivos.LimNumElectivos - respElectivos.NumElectivosEnPedido;
            return string.Format(Constantes.ProgNuevas.Mensaje.Electivo_TeFaltaPocoLimite, numFaltantes, promocionNombre);
        }

        private void EliminarDetallePackNueva(List<string> listCuv, List<BEPedidoWebDetalle> lstDetalle, BEUsuario usuario)
        {
            var packNuevas = lstDetalle.Where(x => listCuv.Contains(x.CUV)).ToList();
            foreach (var item in packNuevas)
            {
                _pedidoWebDetalleBusinessLogic.DelPedidoWebDetalleTransaction(item);
                _pedidoWebSetBusinessLogic.EliminarTransaction(usuario.PaisID, item.SetID, usuario.ConsultoraID);
            }
        }

        private bool ValidarProgramaNuevas(BEUsuario usuario, BEPedidoWebDetalle obePedidoWebDetalle, List<BEPedidoWebDetalle> lstDetalle, out string mensajeObs, out List<string> listCuvEliminar, out string TituloMensaje)
        {
            listCuvEliminar = new List<string>();
            mensajeObs = string.Empty;
            TituloMensaje = "";

            var perteneceProgramaNuevas = _programaNuevasBusinessLogic.ValidarBusquedaCuv
                            (usuario.PaisID, usuario.CampaniaID, usuario.CodigoPrograma, usuario.ConsecutivoNueva, obePedidoWebDetalle.CUV);
            if (perteneceProgramaNuevas.Equals(Enumeradores.ValidacionProgramaNuevas.CuvPerteneceProgramaNuevas))
            {
                //ValidarAgregarEnProgramaNuevas
                var lstCuvPedido = lstDetalle.Select(x => x.CUV).ToList();
                var respElectivos = _programaNuevasBusinessLogic.
                    ValidaCuvElectivo(usuario.PaisID, usuario.CampaniaID, obePedidoWebDetalle.CUV, usuario.ConsecutivoNueva, usuario.CodigoPrograma, lstCuvPedido);

                switch (respElectivos.Resultado)
                {
                    case Enumeradores.ValidarCuponesElectivos.AgregarYMostrarMensaje:
                        mensajeObs = CrearAvisoCuponElectivo(respElectivos);
                        TituloMensaje = !string.IsNullOrEmpty(mensajeObs) ? Constantes.ProgNuevas.Mensaje.Electivo_PromocionNombre.ToUpper() : "";
                        break;
                    case Enumeradores.ValidarCuponesElectivos.Reemplazar:
                        EliminarDetallePackNueva(respElectivos.ListCuvEliminar.ToList(), lstDetalle, usuario);
                        listCuvEliminar = respElectivos.ListCuvEliminar.ToList();
                        break;
                    case Enumeradores.ValidarCuponesElectivos.NoAgregarExcedioLimite:
                        mensajeObs = string.Format(Constantes.ProgNuevas.Mensaje.Electivo_NoAgregarPorLimite, Constantes.ProgNuevas.Mensaje.Electivo_PromocionNombre);
                        TituloMensaje = Constantes.ProgNuevas.Mensaje.Electivo_PromocionNombre.ToUpper();
                        return false;
                }


                //ValidarCantidadEnProgramaNuevas                        
                int cantidadEnPedido = lstDetalle.Where(a => a.CUV == obePedidoWebDetalle.CUV).Sum(b => b.Cantidad);
                var valor = _programaNuevasBusinessLogic.ValidarCantidadMaxima
                    (usuario.PaisID, usuario.CampaniaID, usuario.ConsecutivoNueva, usuario.CodigoPrograma, cantidadEnPedido, obePedidoWebDetalle.CUV, obePedidoWebDetalle.Cantidad);

                if (valor != 0)
                {
                    mensajeObs = string.Format(Constantes.ProgNuevas.Mensaje.ExcedeLimiteUnidades, valor.ToString());
                    return false;
                }
            }

            return true;
        }

        private void CrearLogProgNuevas(string message, string cuv, BEUsuario usuario)
        {
            if (WebConfig.Ambiente != "QA") return;

            var listConsultoraRegistro = new List<string> { "006926193", "043862731", "011971059", "030320840", "003706273", "009118330", "020466782", "011930654", "011410731", "035515321" };
            if (!listConsultoraRegistro.Contains(usuario.CodigoConsultora)) return;

            var exTrace = string.Format("ISO:{0};Consultora{1};Cuv:{2}", usuario.CodigoISO, usuario.CodigoConsultora, cuv);
            LogManager.SaveLog(new CustomTraceException(message, exTrace), usuario.CodigoConsultora, usuario.CodigoISO);
        }

        private bool AdministradorPedido(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> pedidoWebDetalles, BEEstrategia estrategia,
            string cuvlist, string TipoAdm, out string mensajeObs, out List<string> listCuvEliminar, out string TituloMensaje, out bool modificoBackOrder, out List<BEMensajeProl> ListMensajeCondicional, out List<ObjMontosProl> listObjMontosProl, out BEPedidoWeb pedidoWeb)
        {
            listCuvEliminar = new List<string>();
            mensajeObs = "";
            TituloMensaje = "";
            modificoBackOrder = false;
            ListMensajeCondicional = new List<BEMensajeProl>();
            listObjMontosProl = new List<ObjMontosProl>();
            pedidoWeb = new BEPedidoWeb();

            try
            {
                int totalClientes = 0;
                decimal totalImporte = 0;
                List<BEPedidoWebDetalle> lstDetalle = null;
                int pedidoID = 0;
                var SetIdList = new List<int>();

                var pedidoDetalleBuscar = new BEPedidoBuscar()
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    NombreConsultora = usuario.Nombre,
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };


                foreach (var obePedidoWebDetalle in pedidoWebDetalles)
                {

                    #region ProgramaNuevas
                    if (obePedidoWebDetalle.TipoAdm.Equals(Constantes.PedidoAccion.INSERT) &&
                        pedidoDetalle.EsCuponNuevas)
                    {
                        CrearLogProgNuevas("DuoPerfecto: PedidoInsertar", obePedidoWebDetalle.CUV, usuario);
                        var lstDetalleAgrupado = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);
                        var pasoProgramaNueva = ValidarProgramaNuevas(usuario, obePedidoWebDetalle, lstDetalleAgrupado, out mensajeObs, out listCuvEliminar, out TituloMensaje);
                        if (!pasoProgramaNueva) return false;
                    }
                    #endregion

                    //Obtener PedidoWebDetalle
                    lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
                    obePedidoWebDetalle.PedidoID = pedidoID;

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

                    if (obePedidoWebDetalle.TipoAdm == Constantes.PedidoAccion.INSERT)
                    {
                        var cantidad = 0;
                        var result = ValidarInsercion(lstDetalle, obePedidoWebDetalle, out cantidad);
                        if (result != 0)
                        {
                            obePedidoWebDetalle.TipoAdm = Constantes.PedidoAccion.UPDATE;
                            obePedidoWebDetalle.Stock = obePedidoWebDetalle.Cantidad;
                            obePedidoWebDetalle.Cantidad += cantidad;
                            obePedidoWebDetalle.ImporteTotal = obePedidoWebDetalle.Cantidad * obePedidoWebDetalle.PrecioUnidad;
                            obePedidoWebDetalle.PedidoDetalleID = result;
                            obePedidoWebDetalle.Flag = 2;
                            obePedidoWebDetalle.OrdenPedidoWD = 1;
                        }
                    }

                    totalClientes = CalcularTotalCliente(lstDetalle, obePedidoWebDetalle, obePedidoWebDetalle.TipoAdm == Constantes.PedidoAccion.DELETE ? obePedidoWebDetalle.PedidoDetalleID : (short)0, obePedidoWebDetalle.TipoAdm);
                    totalImporte = CalcularTotalImporte(lstDetalle, obePedidoWebDetalle, obePedidoWebDetalle.TipoAdm == Constantes.PedidoAccion.INSERT ? (short)0 : obePedidoWebDetalle.PedidoDetalleID, obePedidoWebDetalle.TipoAdm);

                    obePedidoWebDetalle.CodigoUsuarioCreacion = usuario.CodigoUsuario;
                    obePedidoWebDetalle.CodigoUsuarioModificacion = usuario.CodigoUsuario;

                    obePedidoWebDetalle.QuitoCantBackOrder = false;
                    if (obePedidoWebDetalle.TipoAdm == Constantes.PedidoAccion.UPDATE && obePedidoWebDetalle.PedidoDetalleID != 0)
                    {
                        var oldPedidoWebDetalle = lstDetalle.FirstOrDefault(x => x.PedidoDetalleID == obePedidoWebDetalle.PedidoDetalleID) ?? new BEPedidoWebDetalle();

                        if (oldPedidoWebDetalle.AceptoBackOrder && obePedidoWebDetalle.Cantidad < oldPedidoWebDetalle.Cantidad)
                        {
                            obePedidoWebDetalle.QuitoCantBackOrder = true;
                            modificoBackOrder = true;
                        }
                    }

                    if (pedidoDetalle != null)
                    {
                        var indPedidoAutentico = new BEIndicadorPedidoAutentico
                        {
                            PedidoID = obePedidoWebDetalle.PedidoID,
                            CampaniaID = obePedidoWebDetalle.CampaniaID,
                            PedidoDetalleID = obePedidoWebDetalle.PedidoDetalleID,
                            IndicadorIPUsuario = pedidoDetalle.IPUsuario,
                            IndicadorFingerprint = string.Empty,
                            IndicadorToken = string.IsNullOrEmpty(pedidoDetalle.Identifier) ? string.Empty : AESAlgorithm.Encrypt(pedidoDetalle.Identifier)
                        };
                        obePedidoWebDetalle.IndicadorPedidoAutentico = indPedidoAutentico;
                    }

                    switch (obePedidoWebDetalle.TipoAdm)
                    {
                        case Constantes.PedidoAccion.INSERT:
                            obePedidoWebDetalle.PedidoID = _pedidoWebDetalleBusinessLogic.InsPedidoWebDetalleTransaction(obePedidoWebDetalle).PedidoID;
                            break;
                        case Constantes.PedidoAccion.UPDATE:
                            _pedidoWebDetalleBusinessLogic.UpdPedidoWebDetalleTransaction(obePedidoWebDetalle);
                            break;
                        case Constantes.PedidoAccion.DELETE:
                            _pedidoWebDetalleBusinessLogic.DelPedidoWebDetalleTransaction(obePedidoWebDetalle);
                            if (obePedidoWebDetalle.SetID > 0)
                            {
                                SetIdList.Add(obePedidoWebDetalle.SetID);
                            }
                            break;
                    }

                    if (obePedidoWebDetalle.TipoAdm == Constantes.PedidoAccion.UPDATE && obePedidoWebDetalle.QuitoCantBackOrder)
                        _pedidoWebDetalleBusinessLogic.QuitarBackOrderPedidoWebDetalle(obePedidoWebDetalle);

                }

                _pedidoWebDetalleBusinessLogic.UpdPedidoWebTotalesTransaction(usuario, pedidoWebDetalles[0].PedidoID, totalClientes, totalImporte);

                switch (TipoAdm)
                {
                    case Constantes.PedidoAccion.INSERT:
                        {
                            _pedidoWebDetalleBusinessLogic.InsertPedidoWebSetTransaction(usuario.PaisID, usuario.CampaniaID, pedidoWebDetalles[0].PedidoID, estrategia.Cantidad, estrategia.CUV2
                                    , usuario.ConsultoraID, usuario.CodigoUsuario, cuvlist, estrategia.EstrategiaID, pedidoDetalle.ClienteID, pedidoWebDetalles[0].TipoEstrategiaID);

                        }
                        break;
                    case Constantes.PedidoAccion.UPDATE:
                        {
                            if (pedidoDetalle.SetID > 0)
                            {
                                _pedidoWebDetalleBusinessLogic.UpdatePedidoWebSetTransaction(pedidoDetalle, pedidoDetalle.PaisID, pedidoDetalle.SetID, pedidoDetalle.Cantidad);
                            }
                        }
                        break;
                    case Constantes.PedidoAccion.DELETE:
                        if (SetIdList.Any())
                        {
                            SetIdList.Distinct().ToList().ForEach(setidItem =>
                            {
                                _pedidoWebSetBusinessLogic.EliminarTransaction(usuario.PaisID, setidItem, usuario.ConsultoraID);
                            });
                        }

                        break;
                }

                lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);

                if (!pedidoDetalle.Reservado)
                {
                    listObjMontosProl = UpdateProlCrud(usuario, lstDetalle, out ListMensajeCondicional, out pedidoWeb);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidoWebDetalles[0].CodigoUsuarioModificacion, Util.GetPaisISO(usuario.PaisID));
                mensajeObs = "Ocurrió un error al ejecutar la operación.";
                return false;
            }
            return true;
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

        private bool ValidarStockLimiteVenta(BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> pedido, out string mensaje)
        {
            var cantidadActual = pedido.Where(d => d.CUV == pedidoDetalle.Producto.CUV).Sum(d => d.Cantidad);
            var respValidar = _limiteVentaBusinessLogic.CuvTieneLimiteVenta(usuario.PaisID, usuario.CampaniaID, usuario.CodigorRegion, usuario.CodigoZona, pedidoDetalle.Producto.CUV, pedidoDetalle.Cantidad, cantidadActual);
            if (respValidar.TieneLimite) mensaje = string.Format(Constantes.MensajesError.StockLimiteVenta, pedidoDetalle.Producto.CUV, pedidoDetalle.Producto.Descripcion, respValidar.UnidadesMaximas);
            else mensaje = null;
            return respValidar.TieneLimite;
        }

        public BEPedidoDetalleResult ValidaRegaloPedido(BEPedidoDetalle pedidoDetalle)
        {
            BEPedidoDetalleResult objRerun = new BEPedidoDetalleResult();

            if (pedidoDetalle.Estrategia == null && pedidoDetalle.Producto.EstrategiaID <= 0)
            {
                pedidoDetalle.Estrategia = new BEEstrategia()
                {
                    Cantidad = pedidoDetalle.Cantidad,
                    DescripcionCUV2 = Util.Trim(pedidoDetalle.Producto.Descripcion),
                    FlagNueva = 0,
                    Precio = pedidoDetalle.Producto.PrecioCatalogo,
                    TipoEstrategiaID = pedidoDetalle.Producto.TipoEstrategiaID.Trim() == string.Empty ? 0 : int.Parse(pedidoDetalle.Producto.TipoEstrategiaID.Trim()),
                    CUV2 = pedidoDetalle.Producto.CUV,
                    MarcaID = pedidoDetalle.Producto.MarcaID,
                    LimiteVenta = 1,
                    Precio2 = pedidoDetalle.Producto.PrecioCatalogo
                };
            }

            var LstRealo = _estrategiaBusinessLogic.GetEstrategiaPremiosElectivos(pedidoDetalle.Usuario.PaisID, pedidoDetalle.Usuario.CodigoPrograma, pedidoDetalle.Usuario.CampaniaID, pedidoDetalle.Usuario.Nivel).ToList();

            if (LstRealo == null) LstRealo = new List<BEEstrategia>();

            if (LstRealo.Any(x => x.CUV2 == pedidoDetalle.Producto.CUV))
            {
                var reqPedidoDetalle = Get(pedidoDetalle.Usuario);

                if (reqPedidoDetalle.olstBEPedidoWebDetalle == null)
                {
                    objRerun = Insert(pedidoDetalle);
                    if (objRerun.CodigoRespuesta != Constantes.PedidoValidacion.Code.SUCCESS) return objRerun;
                    objRerun.CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS_REGALO;
                    return objRerun;
                }

                reqPedidoDetalle.olstBEPedidoWebDetalle.ForEach(p =>
                {
                    p.EsRegalo = LstRealo.Any(c => c.CUV2 == p.CUV);
                });

                var regaloElegido = reqPedidoDetalle.olstBEPedidoWebDetalle.FirstOrDefault(x => x.EsRegalo);

                if (regaloElegido != null)
                {

                    BEPedidoDetalle ProdEliminar = new BEPedidoDetalle();
                    ProdEliminar.SetID = regaloElegido.SetID;
                    ProdEliminar.PedidoDetalleID = regaloElegido.PedidoDetalleID;
                    ProdEliminar.PedidoID = regaloElegido.PedidoID;
                    ProdEliminar.Producto = new BEProducto();
                    ProdEliminar.Producto.TipoOfertaSisID = regaloElegido.TipoOfertaSisID;
                    ProdEliminar.Producto.CUV = regaloElegido.CUV;
                    ProdEliminar.Usuario = pedidoDetalle.Usuario;
                    ProdEliminar.Cantidad = pedidoDetalle.Cantidad;
                    ProdEliminar.PaisID = pedidoDetalle.PaisID;
                    ProdEliminar.IPUsuario = pedidoDetalle.IPUsuario;
                    ProdEliminar.ClienteID = regaloElegido.ClienteID;
                    ProdEliminar.Identifier = pedidoDetalle.Identifier;
                    ProdEliminar.ObservacionPROL = regaloElegido.ObservacionPROL;

                    objRerun = Insert(pedidoDetalle);
                    if (objRerun.CodigoRespuesta != Constantes.PedidoValidacion.Code.SUCCESS) return objRerun;

                    objRerun = Delete(ProdEliminar).Result;
                    if (objRerun.CodigoRespuesta != Constantes.PedidoValidacion.Code.SUCCESS) return objRerun;

                    objRerun = new BEPedidoDetalleResult();
                    objRerun.CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS_REGALO;
                }
                else
                {
                    objRerun.CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS;
                }
            }
            else
            {
                objRerun.CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS;
            }

            objRerun.MensajeRespuesta = objRerun.MensajeRespuesta ?? Constantes.PedidoValidacion.Configuracion[Constantes.PedidoValidacion.Code.SUCCESS].Mensaje;

            return objRerun;
        }

        public BEPedidoDetalleResult AgregaRegaloDefault(BEPedidoDetalle pedidoDetalle)
        {
            BEPedidoDetalleResult objRerun = null;
            var lisRegalos = _estrategiaBusinessLogic.GetEstrategiaPremiosElectivos(pedidoDetalle.Usuario.PaisID, pedidoDetalle.Usuario.CodigoPrograma, pedidoDetalle.Usuario.CampaniaID, pedidoDetalle.Usuario.Nivel).ToList();
            if (lisRegalos == null) lisRegalos = new List<BEEstrategia>();

            if (lisRegalos.Count == 0)
            {
                objRerun = new BEPedidoDetalleResult();
                objRerun.CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS;

                return objRerun;
            }

            var reqPedidoDetalle = Get(pedidoDetalle.Usuario);

            if (reqPedidoDetalle.olstBEPedidoWebDetalle == null) reqPedidoDetalle.olstBEPedidoWebDetalle = new List<BEPedidoWebDetalle>();

            reqPedidoDetalle.olstBEPedidoWebDetalle.ForEach(p =>
            {
                p.EsRegalo = lisRegalos.Any(c => c.CUV2 == p.CUV);
            });

            if (!reqPedidoDetalle.olstBEPedidoWebDetalle.Any(x => x.EsRegalo))
            {
                var productRegalo = lisRegalos.FirstOrDefault(x => x.CuponElectivoDefault);
                pedidoDetalle.Producto = new BEProducto()
                {
                    CUV = productRegalo.CUV2,
                    PrecioCatalogo = productRegalo.Precio2 == 0 ? productRegalo.PrecioUnitario : productRegalo.Precio2,
                    PrecioValorizado = productRegalo.Precio2 == 0 ? productRegalo.PrecioUnitario : productRegalo.Precio2,
                    TipoEstrategiaID = productRegalo.TipoEstrategiaID.ToString(),
                    FlagNueva = productRegalo.FlagNueva.ToString(),
                    IndicadorMontoMinimo = productRegalo.IndicadorMontoMinimo,
                    MarcaID = productRegalo.MarcaID,
                    EstrategiaID = productRegalo.EstrategiaID
                };

                objRerun = Insert(pedidoDetalle);
            }
            else
            {
                objRerun = new BEPedidoDetalleResult();
                objRerun.CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS;
            }




            return objRerun;
        }

        public List<BEEstrategia> ListaRegalosApp(BEUsuario usuario)
        {
            List<BEEstrategia> lstReturn = null;

            lstReturn = _estrategiaBusinessLogic.GetEstrategiaPremiosElectivos(usuario.PaisID, usuario.CodigoPrograma, usuario.CampaniaID, usuario.Nivel);
            var objPedidoDetalle = Get(usuario);

            if (objPedidoDetalle.olstBEPedidoWebDetalle == null) objPedidoDetalle.olstBEPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            if (lstReturn == null) return new List<BEEstrategia>();

            lstReturn = lstReturn.Where(x => x.ImagenURL != null).ToList();

            lstReturn.ForEach(x =>
            {
                x.FlagSeleccionado = objPedidoDetalle.olstBEPedidoWebDetalle.Any(y => y.CUV == x.CUV2) ? 1 : 0;
                x.Precio2 = x.Precio2 == 0 ? x.PrecioUnitario : x.Precio2;
            });

            return lstReturn;
        }

        private BEPedidoDetalleResult ValidarLimiteVenta(BEEstrategia estrategia, List<BEPedidoWebDetalle> listDetalle)
        {
            return ValidarLimiteVenta(estrategia, listDetalle, d => d.CUV == estrategia.CUV2);
        }

        private BEPedidoDetalleResult ValidarLimiteVenta(BEEstrategia estrategia, List<BEPedidoWebDetalle> listDetalle, Func<BEPedidoWebDetalle, bool> filtro)
        {
            if (estrategia.LimiteVenta == 0) return null;

            var listDetalleFiltro = listDetalle.Where(filtro).ToList();
            int cantidadActual = listDetalleFiltro.Any() ? listDetalleFiltro.Sum(x => x.Cantidad) : 0;
            if (cantidadActual + estrategia.Cantidad <= estrategia.LimiteVenta) return null;

            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_CANTIDAD_LIMITE, null, estrategia.LimiteVenta);
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
            var detallesPedidoWeb = _pedidoWebDetalleBusinessLogic.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros, false, false).ToList();
            pedidoID = detallesPedidoWeb.Any() ? detallesPedidoWeb.FirstOrDefault().PedidoID : 0;

            return detallesPedidoWeb;
        }

        private Dictionary<string, string> getListaNuevasDescripciones(int PaisID)
        {
            var lista = new Dictionary<string, string>();

            var result = _tablaLogicaDatosBusinessLogic.GetList(PaisID, ConsTablaLogica.DescripcionProducto.TablaLogicaId);

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

        #region Configuracion
        private BEPedidoBarra GetDataBarra(int paisID, int campaniaID, string region, string zona)
        {
            var objR = new BEPedidoBarra
            {
                ListaEscalaDescuento = new List<BEEscalaDescuento>(),
                ListaMensajeMeta = new List<BEMensajeMetaConsultora>()
            };
            objR.ListaEscalaDescuento = _escalaDescuentoBusinessLogic.GetEscalaDescuento(paisID, campaniaID, region, zona) ?? new List<BEEscalaDescuento>();

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

        private List<ObjMontosProl> UpdateProlCrud(BEUsuario usuario, List<BEPedidoWebDetalle> lstDetalle, out List<BEMensajeProl> listMensajeCondicional, out BEPedidoWeb pedidoWeb)
        {
            listMensajeCondicional = new List<BEMensajeProl>();
            pedidoWeb = new BEPedidoWeb();
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

                if (oRespuestaProl.ListaMensajeCondicional != null)
                {
                    listMensajeCondicional.AddRange(oRespuestaProl.ListaMensajeCondicional.Select(item =>
                        new BEMensajeProl
                        {
                            CodigoMensajeRxP = item.CodigoMensaje,
                            MensajeRxP = item.Mensaje,
                        }));
                }
            }
            else
            {
                var lstConcursos = usuario.CodigosConcursos.Split('|');
                codigoConcursosProl = usuario.CodigosConcursos;
                puntajes = string.Join("|", lstConcursos.Select(c => 0));
                puntajesExigidos = string.Join("|", lstConcursos.Select(c => 0));
            }
            int pedidoId = 0;
            var pedidoWebDetalleAgrupado = _pedidoWebDetalleBusinessLogic.ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoId);
            pedidoWeb = _pedidoWebBusinessLogic.GetPedidoWebConCalculosGanancia(usuario, montoAhorroCatalogo, montoAhorroRevista, montoDescuento, montoEscala, pedidoWebDetalleAgrupado);

            //TODO: incluir campos y parametros en el metodo UpdateMontosPedidoWeb y en el sp
            _pedidoWebBusinessLogic.UpdateMontosPedidoWeb(pedidoWeb);

            if (!string.IsNullOrEmpty(codigoConcursosProl))
                _consultoraConcursoBusinessLogic.ActualizarInsertarPuntosConcursoTransaction(usuario.PaisID, usuario.CodigoConsultora, usuario.CampaniaID.ToString(), codigoConcursosProl, puntajes, puntajesExigidos);

            return lista;
        }

        private void UpdateProl(BEUsuario usuario, List<BEPedidoWebDetalle> lstDetalle, out List<BEMensajeProl> listMensajeCondicional)
        {
            BEPedidoWeb pedidoWeb;
            UpdateProlCrud(usuario, lstDetalle, out listMensajeCondicional, out pedidoWeb);
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
                MensajeRespuesta = string.IsNullOrEmpty(mensajeRespuesta) ? Constantes.PedidoValidacion.Configuracion[codigoRespuesta].Mensaje : mensajeRespuesta,
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
                var cantPack = listaPackNueva.Any().ToInt();
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
            return _pedidoWebDetalleBusinessLogic.ObtenerPedidoWebSetDetalleAgrupado(usuario, false, out pedidoID);
        }
        private List<BEPedidoWebDetalle> ObtenerPedidoWebSetDetalleAgrupado(BEUsuario usuario, bool updLabelNuevas, out int pedidoID)
        {
            return _pedidoWebDetalleBusinessLogic.ObtenerPedidoWebSetDetalleAgrupado(usuario, updLabelNuevas, out pedidoID);
        }

        private void PedidoAgregarProductoAgrupado(BEUsuario usuario, int pedidoID, int cantidad, string cuv, string cuvlist, int estrategiaId)
        {
            _pedidoWebDetalleBusinessLogic.InsertPedidoWebSet(usuario.PaisID, usuario.CampaniaID, pedidoID, cantidad, cuv
                    , usuario.ConsultoraID, usuario.CodigoUsuario, cuvlist, estrategiaId, usuario.Nombre, usuario.CodigoPrograma, usuario.ConsecutivoNueva);
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

            var mensaje = ValidarMontoMaximo(usuario, pedidoDetalle, lstDetalle, out result);
            if (!string.IsNullOrEmpty(mensaje)) return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

            var taskUnidadesPermitidas = Task.Run(() => _ofertaProductoBusinessLogic.GetUnidadesPermitidasByCuv(usuario.PaisID, usuario.CampaniaID, CUV));
            var taskSaldo = Task.Run(() => _ofertaProductoBusinessLogic.ValidarUnidadesPermitidasEnPedido(usuario.PaisID, usuario.CampaniaID, CUV, usuario.ConsultoraID));

            Task.WaitAll(taskUnidadesPermitidas, taskSaldo);

            var unidadesPermitidas = taskUnidadesPermitidas.Result;
            var saldo = taskSaldo.Result;

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

            InsertOfertaWebPortal(pedidoDetalle);

            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
        }

        private void InsertOfertaWebPortal(BEPedidoDetalle pedidoDetalle)
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
            var lstDetalle = ObtenerPedidoWebDetalle(pedidoDetalleBuscar, out pedidoID);
            pedidoDetalle.PedidoID = pedidoID;
            List<BEMensajeProl> listMensajeCondicional;

            UpdateProl(usuario, lstDetalle, out listMensajeCondicional);

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
            var listCuvTonos = pedidoDetalle.Producto.CUV;
            var tonos = listCuvTonos.Split('|');
            var listaComponentes = new List<BEEstrategiaProducto>();

            foreach (var tono in tonos)
            {
                var listSp = tono.Split(';');
                var CUV2 = listSp[0];
                var digitable = listSp.Length > 4 ? listSp[4] : "0";
                var grupo = listSp.Length > 5 ? listSp[5] : "0";

                listaComponentes.Add(new BEEstrategiaProducto
                {
                    CUV = CUV2,
                    Digitable = Convert.ToInt32(digitable),
                    Grupo = grupo
                });
            }

            var componentes = string.Empty;
            if (listaComponentes.Any())
            {
                var listComponentes = listaComponentes.GroupBy(x => new { x.CUV, x.Digitable, x.Grupo }).Select(group => new EstrategiaComponente
                {
                    CUV = group.Key.CUV,
                    Digitable = group.Key.Digitable,
                    Grupo = group.Key.Grupo,
                    Cantidad = group.Count()
                }).ToList();

                componentes = listComponentes.Serialize();
            }
            _pedidoWebDetalleBusinessLogic.InsertPedidoWebSet(usuario.PaisID, usuario.CampaniaID, pedidoID, pedidoDetalle.Cantidad, pedidoDetalle.Producto.CUV, usuario.ConsultoraID, usuario.CodigoUsuario, componentes, pedidoDetalle.Producto.EstrategiaID, usuario.Nombre, usuario.CodigoPrograma, usuario.ConsecutivoNueva);
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
            var estrategia = new BEEstrategia
            {
                CUV2 = pedidoDetalle.Producto.CUV,
                Cantidad = pedidoDetalle.Cantidad,
                LimiteVenta = pedidoDetalle.LimiteVenta
            };
            var validacionLimiteVenta = ValidarLimiteVenta(estrategia, lstDetalleGrp);
            if (validacionLimiteVenta != null) return validacionLimiteVenta;

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

            List<BEMensajeProl> listMensajeCondicional;

            UpdateProl(usuario, lstDetalle, out listMensajeCondicional);

            var response = PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
            listMensajeCondicional.ForEach(x => { response.ListaMensajeCondicional.Add(x); });

            return response;
        }

        private BEPedidoDetalleResult PedidoAgregarProducto(BEPedidoDetalle pedidoDetalle)
        {
            var pedidoID = 0;

            var usuario = pedidoDetalle.Usuario;

            var taskRevistaDigital = Task.Run(() => _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.RevistaDigital));
            var taskValidacionMontoMaximo = Task.Run(() => _usuarioBusinessLogic.ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.ValidacionMontoMaximo));

            Task.WaitAll(taskRevistaDigital, taskValidacionMontoMaximo);

            //Configuracion pais - RevistaDigital
            usuario.RevistaDigital = taskRevistaDigital.Result.RevistaDigital;

            //Configuracion pais - ValidacionMontoMaximo
            usuario.TieneValidacionMontoMaximo = taskValidacionMontoMaximo.Result.TieneValidacionMontoMaximo;

            //Validacion reserva u horario restringido
            var validacionHorario = _pedidoWebBusinessLogic.ValidacionModificarPedido(usuario.PaisID,
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

            //Valida que producto sea de duo perfecto
            var cntProd = 0;
            var esDuoPerfecto = _programaNuevasBusinessLogic.EsCuvElecMultiple(usuario.PaisID, usuario.CampaniaID, usuario.ConsecutivoNueva, usuario.CodigoPrograma, pedidoDetalle.Producto.CUV);


            //validacion duo perfecto
            if (esDuoPerfecto)
            {
                lstDetalle.Where(x => x.FlagNueva && x.EsCuponNuevas)
                       .Update(x => x.EsDuoPerfecto = _programaNuevasBusinessLogic.EsCuvElecMultiple(usuario.PaisID, usuario.CampaniaID, usuario.ConsecutivoNueva, usuario.CodigoPrograma, x.CUV));
                cntProd = lstDetalle.Count(x => x.EsDuoPerfecto);

                //El duo perfecto solo acepta dos productos.
                if (cntProd >= 2)
                    return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_PRODUCTO_DUO_COMPLETO_COMPLETO, string.Format(Constantes.ProgNuevas.Mensaje.Electivo_NoAgregarPorLimite, Constantes.ProgNuevas.Mensaje.Electivo_PromocionNombre));
            }

            //FiltrarEstrategiaPedido
            var estrategia = FiltrarEstrategiaPedido(usuario.PaisID, pedidoDetalle.Producto.EstrategiaID, 0);
            var cuvSet = estrategia.CUV2;

            //UnidadesPermitidas
            estrategia.Cantidad = pedidoDetalle.Cantidad;
            var lstDetalleAgrupado = ObtenerPedidoWebSetDetalleAgrupado(usuario, out pedidoID);
            var validacionLimiteVenta = ValidarLimiteVenta(estrategia, lstDetalleAgrupado);
            if (validacionLimiteVenta != null) return validacionLimiteVenta;

            var listCuvTonos = pedidoDetalle.Producto.CUV;
            if (string.IsNullOrEmpty(listCuvTonos)) listCuvTonos = estrategia.CUV2;
            var tonos = listCuvTonos.Split('|');
            var listaComponentes = new List<BEEstrategiaProducto>();

            foreach (var tono in tonos)
            {
                var listSp = tono.Split(';');
                estrategia.CUV2 = listSp.Length > 0 ? listSp[0] : estrategia.CUV2;
                estrategia.MarcaID = (listSp.Length > 1 && !string.IsNullOrEmpty(listSp[1])) ? Convert.ToInt32(listSp[1]) : estrategia.MarcaID;
                estrategia.Precio2 = listSp.Length > 2 ? Convert.ToDecimal(listSp[2]) : estrategia.Precio2;
                var digitable = listSp.Length > 4 ? listSp[4] : "0";
                var grupo = listSp.Length > 5 ? listSp[5] : "0";

                var mensaje = EstrategiaAgregarProducto(pedidoDetalle, usuario, estrategia, lstDetalle);
                if (!string.IsNullOrEmpty(mensaje)) PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.ERROR_STOCK_ESTRATEGIA, mensaje);

                listaComponentes.Add(new BEEstrategiaProducto
                {
                    CUV = estrategia.CUV2,
                    Digitable = Convert.ToInt32(digitable),
                    Grupo = grupo
                });
            }

            var componentes = string.Empty;
            if (listaComponentes.Any())
            {
                var listComponentes = listaComponentes.GroupBy(x => new { x.CUV, x.Digitable, x.Grupo }).Select(group => new EstrategiaComponente
                {
                    CUV = group.Key.CUV,
                    Digitable = group.Key.Digitable,
                    Grupo = group.Key.Grupo,
                    Cantidad = group.Count()
                }).ToList();

                componentes = listComponentes.Serialize();
            }
            PedidoAgregarProductoAgrupado(usuario, pedidoID, pedidoDetalle.Cantidad, cuvSet, componentes, estrategia.EstrategiaID);

            if (cntProd == 1 && esDuoPerfecto)
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS, string.Concat(Constantes.PedidoValidacion.Code.SUCCESS_DUOPERFECTO_AGREGADO_COMPLETADO, "|", string.Format(Constantes.ProgNuevas.Mensaje.Electivo_CompletasteLimite, Constantes.ProgNuevas.Mensaje.Electivo_PromocionNombre)));

            if (cntProd == 0 && esDuoPerfecto)
                return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS, string.Concat(Constantes.PedidoValidacion.Code.SUCCESS_DUOPERFECTO_AGREGADO_UNO, "|", string.Format(Constantes.ProgNuevas.Mensaje.Electivo_TeFaltaPocoLimite, cntProd + 1, Constantes.ProgNuevas.Mensaje.Electivo_PromocionNombre)));

            return PedidoDetalleRespuesta(Constantes.PedidoValidacion.Code.SUCCESS);
        }

        #endregion

        #region InserKitSE
        public bool InsertKitSE(BEUsuario usuario)
        {
            //Retorna Lista de Kits
            BEPedidoWeb bEPedidoWeb = new BEPedidoWeb()
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                CodigoConsultora = usuario.CodigoConsultora
            };

            var lstKitSE = _pedidoWebBusinessLogic.GetCuvSuscripcionSE(bEPedidoWeb);

            //Valida que se tenga kits para la consultora
            if (!lstKitSE.Any()) return true;

            //Validamos si ya exite en el pedido.
            var bePedidoWebDetalleParametros = new BEPedidoBuscar
            {
                PaisID = usuario.PaisID,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                NombreConsultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                ConsecutivoNueva = usuario.ConsecutivoNueva,
            };

            var PedidoID = 0;
            var lstDetalle = ObtenerPedidoWebDetalle(bePedidoWebDetalleParametros, out PedidoID);

            //Agrega los CUV del kit SC
            foreach (var item in lstKitSE)
            {
                var fndProd = lstDetalle == null ? false : lstDetalle.Any(x => x.CUV == item.CUV);
                if (!fndProd)
                {
                    var detalle = new BEPedidoDetalle()
                    {
                        PaisID = usuario.PaisID,
                        Cantidad = 1,
                        Producto = new BEProducto()
                        {
                            CUV = item.CUV,
                            PrecioCatalogo = item.PrecioCatalogo,
                            TipoEstrategiaID = item.TipoEstrategiaID.ToString(),
                            TipoOfertaSisID = 0,
                            ConfiguracionOfertaID = 0,
                            IndicadorMontoMinimo = item.IndicadorMontoMinimo,
                            MarcaID = item.MarcaID,
                        },
                        Usuario = usuario,
                        EsKitNueva = true
                    };

                    PedidoInsertar(usuario, detalle, lstDetalle, true);
                }
            }

            return true;
        }
        #endregion
    }
}
