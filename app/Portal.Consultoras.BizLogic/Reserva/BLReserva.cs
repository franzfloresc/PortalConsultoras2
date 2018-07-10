using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServicePROL;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReserva : IReservaBusinessLogic
    {
        #region Public Functions

        public string CargarSesionAndDeshacerPedidoValidado(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, string tipo)
        {
            int paisId = Util.GetPaisID(paisISO);
            try
            {
                BEUsuario usuario = null;
                using (IDataReader reader = (new DAConfiguracionCampania(paisId)).GetConfiguracionByUsuarioAndCampania(paisId, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
                {
                    if (reader.Read())
                        usuario = new BEUsuario(reader, true);
                }
                usuario = usuario ?? new BEUsuario();
                BEConfiguracionCampania configuracion = null;
                using (IDataReader reader = new DAPedidoWeb(paisId).GetEstadoPedido(campania, usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
                {
                    if (reader.Read())
                        configuracion = new BEConfiguracionCampania(reader);
                }
                usuario.IndicadorGPRSB = configuracion == null ? 0 : configuracion.IndicadorGPRSB;

                usuario.PaisID = paisId;
                usuario.ConsultoraID = consultoraID;
                usuario.CampaniaID = campania;
                usuario.AceptacionConsultoraDA = aceptacionConsultoraDA;

                #region Consultora Programa Nuevas

                BEConsultorasProgramaNuevas beConsultoraProgramaNuevas = null;
                var daConsultoraProgramaNuevas = new DAConsultorasProgramaNuevas(paisId);

                using (IDataReader reader = daConsultoraProgramaNuevas.GetConsultorasProgramaNuevasByConsultoraId(usuario.ConsultoraID))
                {
                    if (reader.Read())
                        beConsultoraProgramaNuevas = new BEConsultorasProgramaNuevas(reader);
                }

                if (beConsultoraProgramaNuevas != null)
                {
                    usuario.ConsecutivoNueva = beConsultoraProgramaNuevas.ConsecutivoNueva;
                    usuario.CodigoPrograma = beConsultoraProgramaNuevas.CodigoPrograma ?? "";
                }

                #endregion                

                return DeshacerPedidoValidado(usuario, tipo);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraID.ToString(), paisISO);
                throw;
            }
        }
        
        public string DeshacerPedidoValidado(BEUsuario usuario, string tipo)
        {
            if (usuario.IndicadorGPRSB == 1) return string.Format("En este momento nos encontramos facturando tu pedido de C{0}, inténtalo más tarde", usuario.CampaniaID.Substring(4, 2));
            
            var codigoUsuario = usuario.UsuarioPrueba == 1 ? usuario.ConsultoraAsociada : usuario.CodigoUsuario;
            bool validacionAbierta = tipo == "PV";
            short estado = validacionAbierta ? Constantes.EstadoPedido.Procesado : Constantes.EstadoPedido.Pendiente;
            int pedidoId;

            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = usuario.PaisID,
                CampaniaId = usuario.CampaniaID,
                ConsultoraId = usuario.ConsultoraID,
                Consultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                NumeroPedido = usuario.ConsecutivoNueva
            };

            var listPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();
            if (listPedidoWebDetalle.Count == 0)
            {
                pedidoId = new BLPedidoWeb().GetPedidoWebID(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                estado = Constantes.EstadoPedido.Pendiente;
            }
            else pedidoId = listPedidoWebDetalle[0].PedidoID;

            var daPedidoWeb = new DAPedidoWeb(usuario.PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(usuario.PaisID);

            TransactionOptions transOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            using (TransactionScope transScope = new TransactionScope(TransactionScopeOption.Required, transOptions))
            {
                daPedidoWebDetalle.DelPedidoWebDetalleDesglosePedido(usuario.CampaniaID, pedidoId);
                daPedidoWeb.UpdPedidoWebDesReserva(usuario.CampaniaID, pedidoId, estado, false, codigoUsuario, validacionAbierta);

                if (tipo == "PI")
                {
                    List<BEPedidoWebDetalle> listReemplazo = listPedidoWebDetalle.Where(p => !string.IsNullOrEmpty(p.Mensaje)).ToList();
                    foreach (var item in listReemplazo)
                    {
                        daPedidoWebDetalle.InsPedidoWebAccionesPROL(item, 100, 103);
                    }
                }
                transScope.Complete();
            }

            return "";
        }

        public async Task<BEResultadoReservaProl> CargarSesionAndEjecutarReserva(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, bool esMovil, bool enviarCorreo)
        {
            int paisId = Util.GetPaisID(paisISO);
            try
            {
                BEUsuario usuario = null;
                using (IDataReader reader = (new DAConfiguracionCampania(paisId)).GetConfiguracionByUsuarioAndCampania(paisId, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
                {
                    if (reader.Read()) usuario = new BEUsuario(reader, true);
                }

                if (usuario == null)
                    return null;

                BEConfiguracionCampania configuracion = null;

                using (IDataReader reader = new DAPedidoWeb(paisId).GetEstadoPedido(campania, usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
                {
                    if (reader.Read()) configuracion = new BEConfiguracionCampania(reader);
                }
                UpdateDiaPROLAndEsHoraReserva(usuario);

                #region Consultora Programa Nuevas

                BEConsultorasProgramaNuevas beConsultoraProgramaNuevas = null;
                var daConsultoraProgramaNuevas = new DAConsultorasProgramaNuevas(paisId);

                using (IDataReader reader = daConsultoraProgramaNuevas.GetConsultorasProgramaNuevasByConsultoraId(usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
                {
                    if (reader.Read()) beConsultoraProgramaNuevas = new BEConsultorasProgramaNuevas(reader);
                }

                if (beConsultoraProgramaNuevas != null)
                {
                    usuario.ConsecutivoNueva = beConsultoraProgramaNuevas.ConsecutivoNueva;
                    usuario.CodigoPrograma = beConsultoraProgramaNuevas.CodigoPrograma ?? "";
                }

                #endregion

                var input = new BEInputReservaProl
                {
                    PaisISO = paisISO,
                    PaisID = paisId,
                    Simbolo = usuario.Simbolo,
                    EstadoSimplificacionCUV = usuario.EstadoSimplificacionCUV,
                    CampaniaID = campania,
                    ConsultoraID = consultoraID,
                    CodigoUsuario = usuario.CodigoUsuario,
                    CodigoConsultora = usuario.CodigoConsultora,
                    NombreConsultora = usuario.Nombre,
                    PrimerNombre = usuario.PrimerNombre,
                    Email = usuario.EMail,
                    CodigoZona = usuario.CodigoZona,
                    FechaInicioCampania = usuario.FechaInicioFacturacion,
                    ZonaHoraria = usuario.ZonaHoraria,
                    ConsultoraNueva = usuario.ConsultoraNueva,
                    FechaHoraReserva = usuario.DiaPROL && usuario.EsHoraReserva,
                    ZonaValida = usuario.ZonaValida,
                    ValidacionInteractiva = usuario.ValidacionInteractiva,
                    ValidacionAbierta = configuracion != null && configuracion.ValidacionAbierta,
                    FechaFacturacion = usuario.DiaPROL ? usuario.FechaFinFacturacion : usuario.FechaInicioFacturacion.AddDays(-usuario.DiasAntes),
                    EnviarCorreo = enviarCorreo,
                    SegmentoInternoID = (usuario.SegmentoInternoID == null ? 0 : Convert.ToInt32(usuario.SegmentoInternoID)),
                    CodigoPrograma = usuario.CodigoPrograma,
                    ConsecutivoNueva = usuario.ConsecutivoNueva
                };

                if (usuario.TieneHana == 1)
                {
                    var datosConsultoraHana = new BLUsuario().GetDatosConsultoraHana(paisId, usuario.CodigoUsuario, campania);
                    if (datosConsultoraHana != null)
                    {
                        input.MontoMinimo = datosConsultoraHana.MontoMinimoPedido;
                        input.MontoMaximo = datosConsultoraHana.MontoMaximoPedido;
                    }
                }
                else
                {
                    input.MontoMinimo = usuario.MontoMinimoPedido;
                    input.MontoMaximo = usuario.MontoMaximoPedido;
                }

                var resultado = await EjecutarReserva(input);
                resultado.Simbolo = input.Simbolo;
                resultado.MontoMinimo = input.MontoMinimo;
                resultado.MontoMaximo = input.MontoMaximo;
                resultado.FacturaHoy = (DateTime.Now.AddHours(input.ZonaHoraria).Date >= input.FechaInicioCampania.Date);
                if (!resultado.FacturaHoy) resultado.FechaFacturacion = input.FechaInicioCampania;
                return resultado;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraID.ToString(), paisISO);
                throw;
            }
        }

        public async Task<BEResultadoReservaProl> EjecutarReserva(BEInputReservaProl input)
        {
            if (!input.ZonaValida) return new BEResultadoReservaProl { Reserva = true, ResultadoReservaEnum = Enumeradores.ResultadoReserva.ReservaNoDisponible };
            if (!input.ValidacionInteractiva) return new BEResultadoReservaProl { ResultadoReservaEnum = Enumeradores.ResultadoReserva.ReservaNoDisponible };
            try
            {
                var listDetalle = GetPedidoWebDetalleReserva(input);
                var listDetalleSinBackOrder = listDetalle.Where(d => !d.AceptoBackOrder).ToList();
                if (!listDetalleSinBackOrder.Any()) return new BEResultadoReservaProl(Constantes.MensajesError.Reserva_SinDetalle, true);

                input.PedidoID = listDetalle[0].PedidoID;
                input.VersionProl = GetVersionProl(input.PaisID);
                var reservaExternaBL = NewReservaExternaBL(input.VersionProl);
                BEResultadoReservaProl resultado = await reservaExternaBL.ReservarPedido(input, listDetalleSinBackOrder);
                if (resultado.Error) return resultado;

                resultado.MontoGanancia = resultado.MontoAhorroCatalogo + resultado.MontoAhorroRevista;
                resultado.MontoTotal = listDetalle.Sum(pd => pd.ImporteTotal) - resultado.MontoDescuento;
                resultado.UnidadesAgregadas = listDetalle.Sum(pd => pd.Cantidad);

                RegistrarObservacionesHuerfanas(input, resultado, listDetalleSinBackOrder);
                UpdatePedidoWebReservado(input, resultado, listDetalleSinBackOrder);
                resultado.RefreshPedido = true;
                resultado.RefreshMontosProl = true;
                resultado.PedidoID = input.PedidoID;
                resultado.EnviarCorreo = DebeEnviarCorreoReservaProl(input, resultado);

                if (input.EnviarCorreo && resultado.EnviarCorreo)
                {
                    try { EnviarCorreoReservaProl(input, listDetalle); }
                    catch (Exception ex) { LogManager.SaveLog(ex, input.CodigoUsuario, input.PaisISO); }                    
                }
                return resultado;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO);
                return new BEResultadoReservaProl(Constantes.MensajesError.Pedido_Reserva, false);
            }
        }

        public async Task<bool> DeshacerReservaPedido(BEUsuario usuario, int pedidoId)
        {
            UpdateDiaPROLAndEsHoraReserva(usuario);
            if (!usuario.DiaPROL || !usuario.EsHoraReserva) return true;

            var reservaExternaBL = NewReservaExternaBL(GetVersionProl(usuario.PaisID));
            return await reservaExternaBL.DeshacerReservaPedido(usuario, pedidoId);
        }

        public bool EnviarCorreoReservaProl(BEInputReservaProl input)
        {
            try
            {
                var listPedidoWebDetalle = GetPedidoWebDetalleReserva(input);
                if (!listPedidoWebDetalle.Any()) return false;

                input.PedidoID = listPedidoWebDetalle[0].PedidoID;
                EnviarCorreoReservaProl(input, listPedidoWebDetalle);
                return true;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO);
                return false;
            }
        }

        public int InsertarDesglose(BEInputReservaProl input)
        {
            try
            {
                TransferirDatos datos;
                using (var sv = new ServiceStockSsic())
                {
                    sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                    datos = sv.ObtenerExplotado(input.CodigoConsultora, input.CampaniaID.ToString(), input.PaisISO, input.CodigoZona);
                }
                if (datos == null) return -1;

                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                {
                    PaisId = input.PaisID,
                    CampaniaId = input.CampaniaID,
                    ConsultoraId = input.ConsultoraID,
                    Consultora = input.NombreConsultora,
                    EsBpt = input.EsOpt == 1,
                    CodigoPrograma = input.CodigoPrograma,
                    NumeroPedido = input.ConsecutivoNueva
                };
                var listPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();
                if (listPedidoWebDetalle.Count == 0) return 0;

                var listPedidoReserva = GetPedidoReserva(datos.data.Tables[0], listPedidoWebDetalle, input.CodigoUsuario);
                EjecutarReservaPortal(input, listPedidoReserva, listPedidoWebDetalle);
                return listPedidoWebDetalle[0].PedidoID;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO);
                return -1;
            }
        }

        #endregion

        #region Private Functions

        private void UpdateDiaPROL(BEUsuario usuario)
        {
            DateTime fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            usuario.DiaPROL = EsDiaProl(usuario, fechaHoraActual);
        }

        private void UpdateDiaPROLAndEsHoraReserva(BEUsuario usuario)
        {
            DateTime fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            usuario.DiaPROL = EsDiaProl(usuario, fechaHoraActual);
            usuario.EsHoraReserva = EsHoraReserva(usuario, fechaHoraActual);
        }

        private bool EsDiaProl(BEUsuario usuario, DateTime fechaHoraActual)
        {
            return usuario.FechaInicioFacturacion.AddDays(-usuario.DiasAntes) < fechaHoraActual
                && fechaHoraActual < usuario.FechaFinFacturacion.AddDays(1);
        }

        private bool EsHoraReserva(BEUsuario usuario, DateTime fechaHoraActual)
        {
            if (!usuario.DiaPROL) return false;

            TimeSpan horaNow = new TimeSpan(fechaHoraActual.Hour, fechaHoraActual.Minute, 0);
            bool esHorarioReserva = (fechaHoraActual < usuario.FechaInicioFacturacion) ?
                (horaNow > usuario.HoraInicioNoFacturable && horaNow < usuario.HoraCierreNoFacturable) :
                (horaNow > usuario.HoraInicio && horaNow < usuario.HoraFin);
            if (!esHorarioReserva) return false;

            if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
            {
                return (new BLPedidoWeb().GetFechaNoHabilFacturacion(usuario.PaisID, usuario.CodigoZona, DateTime.Today) == 0);
            }
            return true;
        }

        public List<BEPedidoWebDetalle> GetPedidoWebDetalleReserva(BEInputReservaProl input)
        {
            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = input.PaisID,
                CampaniaId = input.CampaniaID,
                ConsultoraId = input.ConsultoraID,
                Consultora = input.NombreConsultora,
                EsBpt = input.EsOpt == 1,
                CodigoPrograma = input.CodigoPrograma,
                NumeroPedido = input.ConsecutivoNueva
            };
            var listPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();

            var producto = new BECUVAutomatico { CampaniaID = input.CampaniaID };
            var lst = new BLCuv().GetProductoCuvAutomatico(input.PaisID, producto, "CUV", "asc", 1, 1, 100).ToList();
            if (lst.Count > 0) listPedidoWebDetalle = listPedidoWebDetalle.Where(x => !lst.Select(y => y.CUV).Contains(x.CUV)).ToList();

            return listPedidoWebDetalle;
        }

        private byte GetVersionProl(int paisId)
        {
            return (byte)(new BLConfiguracionValidacion().EstaActivoProl3(paisId) ? 3 : 2);
        }

        private IReservaExternaBL NewReservaExternaBL(byte versionProl)
        {
            return versionProl == 3 ? new BLReservaSicc() as IReservaExternaBL : new BLReservaProl2() as IReservaExternaBL;
        }

        private void RegistrarObservacionesHuerfanas(BEInputReservaProl input, BEResultadoReservaProl resultado, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            try
            {
                if (resultado.ListPedidoObservacion.Count == 0) return;

                var cuvCab = resultado.ResultadoReservaEnum == Enumeradores.ResultadoReserva.NoReservadoDeuda ? Constantes.ProlCodigoRechazo.Deuda :
                    resultado.ResultadoReservaEnum == Enumeradores.ResultadoReserva.NoReservadoMontoMaximo ? Constantes.ProlCodigoRechazo.MontoMaximo :
                    resultado.ResultadoReservaEnum == Enumeradores.ResultadoReserva.NoReservadoMontoMinimo ? Constantes.ProlCodigoRechazo.MontoMinimo : null;
                var listObsHuerfanas = resultado.ListPedidoObservacion.Where(po => !listPedidoWebDetalle.Any(pd => pd.CUV == po.CUV)).ToList();
                if (cuvCab != null) listObsHuerfanas = listObsHuerfanas.Where(oh => oh.CUV != cuvCab).ToList();
                if (listObsHuerfanas.Count == 0) return;

                var exMessage = Constantes.MensajesError.Reserva_ObsHuerfanas;
                var exTrace = string.Join(Environment.NewLine, listObsHuerfanas.Select(oh => oh.Caso + "|" + oh.CUV + "|" + oh.Descripcion).ToArray());
                LogManager.SaveLog(new CustomTraceException(exMessage, exTrace), input.CodigoConsultora, input.PaisISO);
            }
            catch (Exception ex) { LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO); }
        }

        private void UpdatePedidoWebReservado(BEInputReservaProl input, BEResultadoReservaProl resultado, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var pedidoWeb = CreatePedidoWeb(resultado, input);
            decimal gananciaEstimada = 0;
            List<BEPedidoWebDetalle> listDetalleObservacion = null;

            if (input.FechaHoraReserva)
            {
                pedidoWeb.VersionProl = input.VersionProl;
                pedidoWeb.PedidoSapId = resultado.PedidoSapId;
            }
            if (resultado.Reserva)
            {
                pedidoWeb.CodigoUsuarioModificacion = input.CodigoUsuario;
                pedidoWeb.MontoTotalProl = resultado.MontoTotalProl;
                pedidoWeb.EstadoPedido = Constantes.EstadoPedido.Procesado;
                pedidoWeb.VersionProl = input.VersionProl;

                gananciaEstimada = CalcularGananciaEstimada(input.PaisID, input.CampaniaID, input.PedidoID, listPedidoWebDetalle.Sum(p => p.ImporteTotal));
                listDetalleObservacion = listPedidoWebDetalle.Join(resultado.ListPedidoObservacion, d => d.CUV, o => o.CUV, (d, o) => CreatePedidoWebDetalle(d, o)).ToList();
            }

            var daPedidoWeb = new DAPedidoWeb(input.PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(input.PaisID);
            var daConcurso = new DAConcurso(input.PaisID);

            TransactionOptions transOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            using (TransactionScope transScope = new TransactionScope(TransactionScopeOption.Required, transOptions))
            {
                daPedidoWeb.UpdateMontosPedidoWeb(pedidoWeb);
                if (resultado.Reserva)
                {
                    if (listDetalleObservacion.Any()) daPedidoWebDetalle.UpdListPedidoWebDetalleObsPROL(listDetalleObservacion);
                    daPedidoWeb.UpdPedidoWebReserva(pedidoWeb, gananciaEstimada);
                }
                else if (input.ValidacionAbierta && resultado.ResultadoReservaEnum == Enumeradores.ResultadoReserva.NoReservadoMontoMinimo)
                {
                    daPedidoWebDetalle.DelPedidoWebDetalleDesglosePedido(input.CampaniaID, input.PedidoID);
                    daPedidoWeb.UpdPedidoWebDesReserva(input.CampaniaID, input.PedidoID, Constantes.EstadoPedido.Pendiente, false, input.CodigoUsuario, false);
                }
                daPedidoWebDetalle.UpdListBackOrderPedidoWebDetalle(input.CampaniaID, input.PedidoID, resultado.ListDetalleBackOrder);
                
                if (!string.IsNullOrEmpty(resultado.ListaConcursosCodigos))
                {
                    daConcurso.ActualizarInsertarPuntosConcurso(input.CodigoConsultora, input.CampaniaID.ToString(), resultado.ListaConcursosCodigos, resultado.ListaConcursosPuntaje, resultado.ListaConcursosPuntajeExigido);
                }
                transScope.Complete();
            }
        }

        private BEPedidoWeb CreatePedidoWeb(BEResultadoReservaProl resultado, BEInputReservaProl input)
        {
            return new BEPedidoWeb
            {
                PaisID = input.PaisID,
                CampaniaID = input.CampaniaID,
                PedidoID = input.PedidoID,
                ConsultoraID = input.ConsultoraID,
                MontoAhorroCatalogo = resultado.MontoAhorroCatalogo,
                MontoAhorroRevista = resultado.MontoAhorroRevista,
                DescuentoProl = resultado.MontoDescuento,
                MontoEscala = resultado.MontoEscala
            };
        }

        private BEPedidoWebDetalle CreatePedidoWebDetalle(BEPedidoWebDetalle detalle, BEPedidoObservacion observacion)
        {
            return new BEPedidoWebDetalle
            {
                CampaniaID = detalle.CampaniaID,
                PedidoID = detalle.PedidoID,
                PedidoDetalleID = detalle.PedidoDetalleID,
                ObservacionPROL = observacion.Descripcion
            };
        }

        private void EjecutarReservaPortal(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoReserva, List<BEPedidoWebDetalle> listPedidoWebDetalle, decimal montoTotalProl = 0, decimal descuentoProl = 0)
        {
            var bLPedidoWebDetalle = new BLPedidoWebDetalle();
            var estadoPedido = Constantes.EstadoPedido.Procesado;
            bLPedidoWebDetalle.InsPedidoWebDetallePROL(input.PaisID, input.CampaniaID, input.PedidoID, estadoPedido, listPedidoReserva, 0, input.CodigoUsuario, montoTotalProl, descuentoProl);

            decimal totalPedido = listPedidoWebDetalle.Sum(p => p.ImporteTotal);
            decimal gananciaEstimada = CalcularGananciaEstimada(input.PaisID, input.CampaniaID, input.PedidoID, totalPedido);
            new BLFactorGanancia().UpdatePedidoWebEstimadoGanancia(input.PaisID, input.CampaniaID, input.PedidoID, gananciaEstimada);
        }

        private decimal CalcularGananciaEstimada(int paisId, int campaniaId, int pedidoId, decimal totalPedido)
        {
            var bLFactorGanancia = new BLFactorGanancia();
            decimal indicadorNumero;

            BEFactorGanancia factorGanancia = null;
            try
            {
                factorGanancia = bLFactorGanancia.GetFactorGananciaEscalaDescuento(totalPedido, paisId);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
            }
            decimal porcentajeGanancia = factorGanancia == null ? 0 : (factorGanancia.Porcentaje / 100);

            var productosIndicadorDscto = bLFactorGanancia.GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(paisId, campaniaId, pedidoId).ToList();
            productosIndicadorDscto.ForEach(pid =>
            {
                string indicador = pid.IndicadorDscto.ToLower();

                if (indicador == " ") pid.MontoDscto = (pid.PrecioUnidad - pid.PrecioCatalogo2) * pid.Cantidad;
                else if (indicador == "c") pid.MontoDscto = (pid.PrecioUnidad * porcentajeGanancia) * pid.Cantidad;
                else if (decimal.TryParse(indicador, out indicadorNumero) && indicadorNumero.Between(0, 100))
                {
                    pid.MontoDscto = (pid.PrecioUnidad * (indicadorNumero / 100)) * pid.Cantidad;
                }
            });
            return productosIndicadorDscto.Sum(p => p.MontoDscto);
        }

        private List<BEPedidoWebDetalle> GetPedidoReserva(DataTable dtr, List<BEPedidoWebDetalle> listPedidoWebDetalle, string codigoUsuario)
        {
            var listPedidoReserva = new List<BEPedidoWebDetalle>();
            foreach (DataRow row in dtr.Rows)
            {
                var temp = listPedidoWebDetalle.Where(p => p.CUV == Convert.ToString(row.ItemArray.GetValue(0)));
                if (!temp.Any())
                {
                    listPedidoReserva.Add(new BEPedidoWebDetalle()
                    {
                        CampaniaID = listPedidoWebDetalle[0].CampaniaID,
                        PedidoID = listPedidoWebDetalle[0].PedidoID,
                        PedidoDetalleID = 0,
                        MarcaID = listPedidoWebDetalle[0].MarcaID,
                        ConsultoraID = listPedidoWebDetalle[0].ConsultoraID,
                        ClienteID = 0,
                        Cantidad = Convert.ToInt32(row.ItemArray.GetValue(3)),
                        PrecioUnidad = 0,
                        ImporteTotal = 0,
                        CUV = Convert.ToString(row.ItemArray.GetValue(0)),
                        OfertaWeb = false,
                        CUVPadre = "0",
                        CodigoUsuarioCreacion = codigoUsuario,
                        CodigoUsuarioModificacion = codigoUsuario
                    });
                }
            }
            return listPedidoReserva;
        }

        private bool DebeEnviarCorreoReservaProl(BEInputReservaProl input, BEResultadoReservaProl resultado)
        {
            if (!resultado.Reserva || input.Email.IsNullOrEmptyTrim()) return false;
            try
            {
                var lstLogicaDatos = new BLTablaLogicaDatos().GetTablaLogicaDatos(input.PaisID, 54).ToList();
                bool activoEnvioMail = Int32.Parse(lstLogicaDatos.First().Codigo.Trim()) > 0;
                if (!activoEnvioMail) return false;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoUsuario, input.PaisISO);
                return false;
            }
            return true;
        }

        private void EnviarCorreoReservaProl(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var envio = EnviarPorCorreoPedidoValidado(input, listPedidoWebDetalle);
            if (envio) InsLogEnvioCorreoPedidoValidado(input, listPedidoWebDetalle);
        }

        private bool EnviarPorCorreoPedidoValidado(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            bool esEsika = (ConfigurationManager.AppSettings.Get("PaisesEsika") ?? "").Contains(input.PaisISO);
            String colorStyle = esEsika ? "#e81c36" : "#613c87";
            bool indicadorOfertaCuv = false;
            decimal montoTotal = olstPedidoWebDetalle.Sum(c => c.ImporteTotal) - olstPedidoWebDetalle[0].DescuentoProl;
            decimal gananciaEstimada = (olstPedidoWebDetalle[0].MontoAhorroCatalogo + olstPedidoWebDetalle[0].MontoAhorroRevista);
            decimal totalSinDescuento = olstPedidoWebDetalle.Sum(c => c.ImporteTotal);
            decimal descuento = olstPedidoWebDetalle[0].DescuentoProl;
            string simbolo = input.Simbolo;

            string _montoTotal = Util.DecimalToStringFormat(montoTotal, input.PaisISO);
            string _gananciaEstimada = Util.DecimalToStringFormat(gananciaEstimada, input.PaisISO);
            string _totalSinDescuento = Util.DecimalToStringFormat(totalSinDescuento, input.PaisISO);
            string _descuento = Util.DecimalToStringFormat(descuento, input.PaisISO);

            StringBuilder mailBody = new StringBuilder();
            mailBody.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
            mailBody.Append("<html xmlns='http://www.w3.org/1999/xhtml'>");
            mailBody.Append("<head>");
            mailBody.Append("<style> *{ box - sizing: border - box;} .wrapper { width: 100 %; table - layout: fixed;");
            mailBody.Append("-webkit - text - size - adjust: 100 %; -ms - text - size - adjust: 100 %; } .webkit {max - width: 600px; Margin: 0 auto;}");
            mailBody.Append("@-ms - viewport { width: device - width;} @media(max - width: 599px){ .main {width: 95 %;} </style> </head>");
            mailBody.Append("<body> <div class='wrapper'> <div class='webkit'>");
            mailBody.Append("<table width='600' align='center' border='0' cellspacing='0' cellpadding='0' align='center' style='max - width: 600px; ' class='main'>");
            mailBody.Append("<tr> <td colspan = '2' style = 'width: 100%; height: 50px; border-bottom: 1px solid #000; padding: 12px 0px; text-align: center; background: #fff' > ");
            if (esEsika) mailBody.Append("<img src='http://www.genesis-peru.com/mailing-belcorp/logo.png' alt='Logo Esika'/>");
            else mailBody.Append("<img src='https://s3.amazonaws.com/uploads.hipchat.com/583104/4578891/jG6i4d6VUyIaUwi/logod.png' alt='Logo Lbel'/>");
            mailBody.Append("</td></tr> ");
            mailBody.AppendFormat(" <tr> <td colspan = '2' style = 'font-family: Arial; font-size: 15px; text-align: center; font-weight: 500; color: #000; padding: 20px 0 10px 0;' > Hola {0}, </td></tr> ", input.NombreConsultora);
            mailBody.Append("<tr> <td colspan = '2' style = 'text-align: center; font-family: Arial; font-size: 23px; font-weight: 700; color: #000; padding-bottom: 15px; padding-left: 10px; padding-right: 10px;' > RESERVASTE TU PEDIDO CON ÉXITO </td></tr>");
            mailBody.Append("<tr><td colspan = '2' style = 'text-align: center; font-family: Arial; font-size: 15px; color: #000; padding-bottom: 15px;' > Aquí el resumen de tu pedido:</td></tr>");

            mailBody.Append("<tr> <td style = 'width: 50%; font-family: Arial; font-size: 13px; color: #000; padding-left: 14%; text-align:left;' > MONTO TOTAL: </td>");
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 16px; font-weight: 700; color: #000;padding-right:14%; text-align:right;' > {1} {0} </td></tr> ", _montoTotal, simbolo);

            mailBody.AppendFormat("<tr> <td style = 'width: 50%; font-family: Arial; font-size: 13px; color: {0}; font-weight:700; padding-left: 14%; text-align:left; padding-bottom: 20px; padding-top: 5px' > GANANCIA ESTIMADA: </td>", colorStyle);
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 13px; font-weight: 700; color: {0}; padding-right:14%; text-align:right;padding-bottom: 20px; padding-top: 5px' > {2} {1} </td></tr>", colorStyle, _gananciaEstimada, simbolo);

            mailBody.Append("<tr> <td colspan = '2' style = 'text-align: center; color: #000; font-family: Arial; font-size: 15px; font-weight: 700; border-top:1px solid #000; border-bottom: 1px solid #000; padding-top: 8px; padding-bottom: 8px; letter-spacing: 0.5px;' > DETALLE </td></tr> ");

            mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; font-weight: 700; padding-top: 15px; padding-left: 10px; padding-right: 10px;' > DESCRIPCIÓN </td>");
            mailBody.Append("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; font-weight: 700; padding-top: 15px; padding-left: 10px; padding-right: 10px;' > SUBTOTAL </td></tr>");

            mailBody.Append("<tr><td colspan = '2' style = 'padding-top: 15px; padding-left: 10px; padding-right: 10px; border-bottom:2px solid #9E9E9E' >");

            foreach (BEPedidoWebDetalle pedidoDetalle in olstPedidoWebDetalle)
            {
                mailBody.Append("<table width = '100%' align = 'center' border = '0' cellspacing = '0' cellpadding = '0' align = 'center' style = 'padding-bottom: 1px;' >");
                mailBody.AppendFormat(" <tr> <td style = 'width: 50%; text-align: left; color: #000; font-family: Arial; font-size: 13px; ' > Cód.Venta: {0} </td> <td style = 'width: 50%;'> &nbsp;</td></tr>", pedidoDetalle.CUV);

                mailBody.AppendFormat("<tr> <td style = 'width: 50%; text-align: left; color: #000; font-family: Arial; font-size: 14px; font-weight:700;' > {0} </td>", pedidoDetalle.DescripcionProd);
                string rowPrecioUnitario;
                if (input.PaisID == 4)
                {
                    mailBody.AppendFormat("<td style = 'width: 50%; text-align: right; color: #000; font-family: Arial; font-size: 14px; font-weight:700;' > {1} {0} </td></tr> ", Util.DecimalToStringFormat(pedidoDetalle.ImporteTotal, input.PaisISO), simbolo);
                    rowPrecioUnitario = String.Format("<tr style='padding-bottom:25px;'> <td colspan = '2' style = 'width: 100%;text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px;' > Precio Unit.: {1} {0}</td></tr>", Util.DecimalToStringFormat(pedidoDetalle.PrecioUnidad, input.PaisISO), simbolo);
                }
                else
                {
                    mailBody.AppendFormat("<td style = 'width: 50%; text-align: right; color: #000; font-family: Arial; font-size: 14px; font-weight:700;' > {1} {0} </td></tr> ", Util.DecimalToStringFormat(pedidoDetalle.ImporteTotal, input.PaisISO), simbolo);
                    rowPrecioUnitario = String.Format("<tr> <td colspan = '2' style = 'width: 100%;text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px; padding-bottom:30px;' > Precio Unit.: {1} {0} </td></tr>", Util.DecimalToStringFormat(pedidoDetalle.PrecioUnidad, input.PaisISO), simbolo);
                }

                mailBody.AppendFormat("<tr> <td colspan = '2' style = 'width: 100%; text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px;' > Cliente: {0} </td></tr>", !string.IsNullOrEmpty(pedidoDetalle.NombreCliente) ? CultureInfo.InvariantCulture.TextInfo.ToTitleCase(pedidoDetalle.NombreCliente.ToLower()) : CultureInfo.InvariantCulture.TextInfo.ToTitleCase(input.Sobrenombre.ToLower()));
                mailBody.AppendFormat("<tr><td colspan = '2' style = 'width: 100%; text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px;' > Cantidad: {0} </td></tr>", pedidoDetalle.Cantidad);
                mailBody.Append(rowPrecioUnitario);

                if (input.EstadoSimplificacionCUV && pedidoDetalle.IndicadorOfertaCUV)
                {
                    indicadorOfertaCuv = true;
                }
                mailBody.Append("</table>");
            }
            mailBody.Append("</tr></td></tr>");

            if (indicadorOfertaCuv)
            {
                if (input.PaisID == 4)
                {
                    mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; padding-top: 15px; padding-left: 10px;' > TOTAL SIN DSCTO.</td>");
                    mailBody.AppendFormat("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; padding-top: 15px; padding-right: 10px; font-weight: 700;' > {1}{0} </td></tr> ", String.Format("{0:#,##0}", _totalSinDescuento).Replace(',', '.'), simbolo);

                    mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; padding-top:3px; padding-left: 10px; border-bottom: 1px solid #000; padding-bottom: 13px;' > DSCTO.OFERTAS POR NIVELES</td>");
                    mailBody.AppendFormat("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; padding-top:3px; padding-right: 10px; font-weight: 700; padding-bottom: 13px; border-bottom: 1px solid #000;' > {1}{0}</td></tr>", String.Format("{0:#,##0}", _descuento).Replace(',', '.'), simbolo);
                }
                else
                {
                    mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; padding-top: 15px; padding-left: 10px;' > TOTAL SIN DSCTO.</td>");
                    mailBody.AppendFormat("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; padding-top: 15px; padding-right: 10px; font-weight: 700;' > {1}{0} </td></tr> ", _totalSinDescuento, simbolo);

                    mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; padding-top:3px; padding-left: 10px; border-bottom: 1px solid #000; padding-bottom: 13px;' > DSCTO.OFERTAS POR NIVELES</td>");
                    mailBody.AppendFormat("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; padding-top:3px; padding-right: 10px; font-weight: 700; padding-bottom: 13px; border-bottom: 1px solid #000;' > {1}{0}</td></tr>", _descuento, simbolo);
                }
            }

            mailBody.Append("<tr> <td style = 'width: 50%; font-family: Arial; font-size: 13px; color: #000; padding-left: 10px; text-align:left; padding-top: 15px;' > MONTO TOTAL:</td>");
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 16px; font-weight: 700; color: #000;padding-right:10px; padding-top: 15px; text-align:right;' > {1}{0} </td> </tr>", _montoTotal, simbolo);

            mailBody.AppendFormat("<tr><td style = 'width: 50%; font-family: Arial; font-size: 13px; color: {0}; font-weight:700; padding-left: 10px; text-align:left; padding-bottom: 13px; padding-top: 5px;' > GANANCIA ESTIMADA:</td>", colorStyle);
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 13px; font-weight: 700; color: {0}; padding-right:10px; text-align:right; padding-bottom: 13px; padding-top: 5px;' > {2}{1}</td></tr>", colorStyle, _gananciaEstimada, simbolo);

            mailBody.Append("<tr><td colspan = '2' style = 'font-family: Arial; font-size: 12px; color: #000; padding-top: 25px; padding-bottom: 13px; text-align: center; padding-left: 10px; padding-right: 10px;' > IMPORTANTE <BR/>");
            mailBody.Append("Tu pedido será enviado a Belcorp el día de hoy, siempre y cuando cumplas con el monto mínimo y no tengas deuda pendiente. </td ></tr> ");

            mailBody.Append(" <tr> <td colspan = '2' style = 'background: #000; height: 62px;' > <table align = 'center' style = 'text-align:center; padding:0 13px; width:100%;' >  <tr> ");
            mailBody.Append(" <td style='width: 11 %; text - align:left; vertical - align:top; '> <a href = 'http://belcorp.biz/' ><img src = 'http://www.genesis-peru.com/mailing-belcorp/logo-belcorp.png' alt = 'Logo Belcorp' /></a></td> ");
            mailBody.Append(" <td style='width: 8 %; text - align:left; '> <a href = 'http://www.esika.com/' > <img src = 'https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/G9GQryrWRTreo75/logo-esika.png' alt = 'Logo Esika' /> </a></td> ");
            mailBody.Append(" <td style='width: 8 %; text - align:left; '> <a href = 'http://www.lbel.com/' > <img src = 'https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/T3o8rSPUKtKpe4g/logo-lbel.png' alt = 'Logo L'bel' /></a></td> ");
            mailBody.Append(" <td style='width: 15 %; text - align:left; border - right:1px solid #FFF;'><a href = 'http://www.cyzone.com/' ><img src = 'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Correo/logo-cyzone.png' alt = 'Logo Cyzone' /> </a></td>");
            mailBody.Append(" <td style='width: 15 %; font - family:Calibri; font - weight:400; font - size:13px; color:#FFF; vertical-align:middle;'><a href = 'https://www.facebook.com/SomosBelcorpOficial?fref=ts' style = 'text-decoration: none' >");
            mailBody.Append(" <table align = 'center' style = 'text-align:center; width:100%;' ><tbody> <tr> <td style = 'text-align: right; font-family: Calibri; font-weight: 400; font-size: 13px; vertical-align: middle; width: 69%; color: white; text-decoration: none;' > SÍGUENOS </td> ");
            mailBody.Append(" <td style = 'text-align: right; position: relative; top: 2px; left: 10px; width: 20%; vertical-align: top;' > <img src = 'http://www.genesis-peru.com/mailing-belcorp/logo-facebook.png' alt = 'Logo Facebook' /> </td></tr></tbody></table ></td> </tr></table> </td> </tr> ");
            mailBody.Append("<tr> <td colspan = '2' style = 'text-align: center; background: #fff' > <table align = 'center' style = 'text-align:center; width:220px;' > <tbody> ");
            mailBody.Append("<tr><td colspan = '2' style = 'height:6px;' ></td ></tr><tr><td style = 'text-align:center; width:49%; border-right:1px solid #000; padding-right: 13px;' >");
            mailBody.Append("<span style = 'font-family:Calibri; font-size:12px; color:#000;' >¿Tienes dudas ?</span ></td ><td style = 'text-align:center; width:49%;' >");
            mailBody.Append("<span style = 'font-family:Calibri; font-size:12px; color:#000;' > <a href = 'http://belcorpresponde.somosbelcorp.com/' style = 'text-decoration: none; color: #000;' >");
            mailBody.Append("Contáctanos </a> </span></td></tr> </tbody></table></td ></tr> ");
            mailBody.Append("</table></div> </div> </body>");

            try
            {
                return Util.EnviarMail("no-responder@somosbelcorp.com", input.Email, string.Empty, string.Format("({0}) Confirmación pedido Belcorp", input.PaisISO), mailBody.ToString(), true, null, false);
            }
            catch (Exception) { return false; }
        }

        private bool InsLogEnvioCorreoPedidoValidado(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            BELogCabeceraEnvioCorreo beLogCabecera = new BELogCabeceraEnvioCorreo
            {
                CodigoConsultora = input.CodigoConsultora,
                ConsultoraID = input.ConsultoraID,
                Email = input.Email,
                FechaFacturacion = input.FechaFacturacion,
                Asunto = string.Format("({0}) Confirmación pedido Belcorp", input.PaisISO),
                FechaEnvio = DateTime.Now
            };

            var listLogDetalleEnvioCorreo = listPedidoWebDetalle.Select(detalle => new BELogDetalleEnvioCorreo
            {
                CUV = detalle.CUV,
                Cantidad = detalle.Cantidad,
                PrecioUnitario = detalle.PrecioUnidad
            }).ToList();

            return new BLLogEnvioCorreo().InsLogEnvioCorreoPedidoValidado(input.PaisID, beLogCabecera, listLogDetalleEnvioCorreo);
        }

        #endregion
    }
}
