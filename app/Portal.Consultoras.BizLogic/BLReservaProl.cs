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
using System.Text.RegularExpressions;

namespace Portal.Consultoras.BizLogic
{
    public class BLReservaProl
    {
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

            bool valida = true;
            if (!usuario.NuevoPROL && !usuario.ZonaNuevoPROL && tipo == "PV")
            {
                using (ServiceStockSsic sv = new ServiceStockSsic())
                {
                    sv.Url = ConfigurationManager.AppSettings["Prol_" + usuario.CodigoISO];
                    valida = sv.wsDesReservarPedido(usuario.CodigoConsultora, usuario.CodigoISO);
                }
            }
            if (!valida) return "";

            var bLPedidoWebDetalle = new BLPedidoWebDetalle();
            bool validacionAbierta = usuario.NuevoPROL && usuario.ZonaNuevoPROL && tipo == "PV";
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

            var listPedidoWebDetalle = bLPedidoWebDetalle.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();
            if (listPedidoWebDetalle.Count == 0)
            {
                pedidoId = new BLPedidoWeb().GetPedidoWebID(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                estado = Constantes.EstadoPedido.Pendiente;
            }
            else pedidoId = listPedidoWebDetalle[0].PedidoID;

            var codigoUsuario = usuario.UsuarioPrueba == 1 ? usuario.ConsultoraAsociada : usuario.CodigoUsuario;
            bLPedidoWebDetalle.UpdPedidoWebByEstado(usuario.PaisID, usuario.CampaniaID, pedidoId, estado, false, true, codigoUsuario, validacionAbierta);

            if (tipo == "PI")
            {
                List<BEPedidoWebDetalle> listReemplazo = listPedidoWebDetalle.Where(p => !string.IsNullOrEmpty(p.Mensaje)).ToList();
                if (listReemplazo.Count != 0) bLPedidoWebDetalle.InsPedidoWebAccionesPROL(listReemplazo, 100, 103);
            }

            return "";
        }

        public BEResultadoReservaProl CargarSesionAndEjecutarReservaProl(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, bool esMovil, bool enviarCorreo)
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

                if (usuario == null)
                    return null;

                BEConfiguracionCampania configuracion = null;

                using (IDataReader reader = new DAPedidoWeb(paisId).GetEstadoPedido(campania, usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
                {
                    if (reader.Read())
                        configuracion = new BEConfiguracionCampania(reader);
                }
                UpdateDiaPROLAndEsHoraReserva(usuario);

                #region Consultora Programa Nuevas

                BEConsultorasProgramaNuevas beConsultoraProgramaNuevas = null;
                var daConsultoraProgramaNuevas = new DAConsultorasProgramaNuevas(paisId);

                using (IDataReader reader = daConsultoraProgramaNuevas.GetConsultorasProgramaNuevasByConsultoraId(usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
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
                    PROLSinStock = usuario.PROLSinStock,
                    ConsultoraNueva = usuario.ConsultoraNueva,
                    FechaHoraReserva = usuario.DiaPROL && usuario.EsHoraReserva,
                    ProlV2 = usuario.NuevoPROL && usuario.ZonaNuevoPROL,
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

                var resultado = EjecutarReservaProl(input);
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

        private void UpdateDiaPROLAndEsHoraReserva(BEUsuario usuario)
        {
            DateTime fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            usuario.DiaPROL = usuario.FechaInicioFacturacion.AddDays(-usuario.DiasAntes) < fechaHoraActual
                && fechaHoraActual < usuario.FechaFinFacturacion.AddDays(1);
            usuario.EsHoraReserva = EsHoraReserva(usuario, fechaHoraActual);
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

        public BEResultadoReservaProl EjecutarReservaProl(BEInputReservaProl input)
        {
            if (!input.ZonaValida) return new BEResultadoReservaProl { Reserva = true, ResultadoReservaEnum = Enumeradores.ResultadoReserva.ReservaNoDisponible };
            if (!input.ValidacionInteractiva) return new BEResultadoReservaProl { ResultadoReservaEnum = Enumeradores.ResultadoReserva.ReservaNoDisponible };
            try
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
                if (listPedidoWebDetalle.Count > 0) input.PedidoID = listPedidoWebDetalle[0].PedidoID;

                BECUVAutomatico producto = new BECUVAutomatico { CampaniaID = input.CampaniaID };
                var lst = new BLCuv().GetProductoCuvAutomatico(input.PaisID, producto, "CUV", "asc", 1, 1, 100).ToList();
                if (lst.Count > 0) listPedidoWebDetalle = listPedidoWebDetalle.Where(x => !lst.Select(y => y.CUV).Contains(x.CUV)).ToList();

                BEResultadoReservaProl resultado;
                if (input.ProlV2) resultado = GetObservacionesPROLv2(input, listPedidoWebDetalle);
                else resultado = GetObservacionesPROL(input, listPedidoWebDetalle);
                resultado.PedidoID = input.PedidoID;

                resultado.EnviarCorreo = DebeEnviarCorreoReservaProl(input, resultado);
                if (input.EnviarCorreo && resultado.EnviarCorreo) EnviarCorreoReservaProl(input, listPedidoWebDetalle);
                return resultado;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO);
                return new BEResultadoReservaProl
                {
                    Error = true,
                    ListPedidoObservacion = new List<BEPedidoObservacion> {
                        new BEPedidoObservacion() { Descripcion = "Hubo un error al tratar de realizar la validación del pedido, por favor vuelva a intentarlo." }
                    }
                };
            }
        }

        public bool EnviarCorreoReservaProl(BEInputReservaProl input)
        {
            try
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
                if (listPedidoWebDetalle.Count > 0) input.PedidoID = listPedidoWebDetalle[0].PedidoID;

                BECUVAutomatico producto = new BECUVAutomatico { CampaniaID = input.CampaniaID };
                var lst = new BLCuv().GetProductoCuvAutomatico(input.PaisID, producto, "CUV", "asc", 1, 1, 100).ToList();
                if (lst.Count > 0) listPedidoWebDetalle = listPedidoWebDetalle.Where(x => !lst.Select(y => y.CUV).Contains(x.CUV)).ToList();

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
                EjecutarReservaPortal(input, listPedidoReserva, listPedidoWebDetalle, false);
                return listPedidoWebDetalle[0].PedidoID;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO);
                return -1;
            }
        }

        private BEResultadoReservaProl GetObservacionesPROL(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            string listaProductos = string.Join("|", olstPedidoWebDetalle.Select(x => x.CUV).ToArray());
            string listaCantidades = string.Join("|", olstPedidoWebDetalle.Select(x => x.Cantidad).ToArray());
            string listaRecuperacion = string.Join("|", olstPedidoWebDetalle.Select(x => Convert.ToInt32(x.AceptoBackOrder)).ToArray());

            decimal montoenviar = GetMontoEnviar(input);
            RespuestaProl datos;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                datos = sv.wsValidacionEstrategia(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, montoenviar, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos);
            }
            if (datos == null) return resultado;

            resultado.MontoAhorroCatalogo = datos.montoAhorroCatalogo.ToDecimalSecure();
            resultado.MontoAhorroRevista = datos.montoAhorroRevista.ToDecimalSecure();
            resultado.MontoGanancia = resultado.MontoAhorroCatalogo + resultado.MontoAhorroRevista;
            resultado.MontoDescuento = datos.montoDescuento.ToDecimalSecure();
            resultado.MontoEscala = datos.montoEscala.ToDecimalSecure();
            resultado.MontoTotal = olstPedidoWebDetalle.Sum(pd => pd.ImporteTotal) - resultado.MontoDescuento;
            resultado.UnidadesAgregadas = olstPedidoWebDetalle.Sum(pd => pd.Cantidad);
            resultado.CodigoMensaje = datos.codigoMensaje;
            this.UpdateMontosPedidoWeb(resultado, input);
            resultado.RefreshPedido = true;
            resultado.RefreshMontosProl = true;

            List<BEPedidoWebDetalle> lstPedidoWebDetalleBackOrder = new List<BEPedidoWebDetalle>();
            int validacionReemplazo = 0;

            if (!datos.codigoMensaje.Equals("00"))
            {
                foreach (var item in datos.ListaObservaciones)
                {
                    int tipoObs = Convert.ToInt32(item.cod_observacion);
                    string cuv = item.codvta;
                    string observacion = item.observacion.Replace("+", "");

                    if (tipoObs == 8)
                    {
                        lstPedidoWebDetalleBackOrder.AddRange(olstPedidoWebDetalle.Where(d => d.CUV == cuv));
                    }
                    else
                    {
                        if (tipoObs == 0)
                        {
                            validacionReemplazo += 1;
                        }
                        else if (tipoObs == 95)
                        {
                            observacion = Regex.Replace(observacion, "(\\#.*\\#)", Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO));
                        }
                        resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = tipoObs, CUV = cuv, Tipo = 2, Descripcion = observacion });
                    }
                }
                resultado.Reserva = input.FechaHoraReserva && resultado.Informativas && !resultado.Restrictivas;
            }
            else resultado.Reserva = input.FechaHoraReserva;

            if (resultado.Reserva)
            {
                decimal montoTotalProl = datos.montototal.ToDecimalSecure();
                decimal descuentoProl = datos.montoDescuento.ToDecimalSecure();
                var listPedidoReserva = GetPedidoReservaV2(datos, olstPedidoWebDetalle);

                EjecutarReservaPortal(input, listPedidoReserva, olstPedidoWebDetalle, false, montoTotalProl, descuentoProl);
            }

            if (datos.ListaConcursoIncentivos != null)
            {
                resultado.ListaConcursosCodigos = string.Join("|", datos.ListaConcursoIncentivos.Select(i => i.codigoconcurso).ToArray());
                resultado.ListaConcursosPuntaje = string.Join("|", datos.ListaConcursoIncentivos.Select(i => i.puntajeconcurso.Split('|')[0]).ToArray());
                resultado.ListaConcursosPuntajeExigido = string.Join("|", datos.ListaConcursoIncentivos.Select(i => (i.puntajeconcurso.IndexOf('|') > -1 ? i.puntajeconcurso.Split('|')[1] : "0")).ToArray());
            }

            return resultado;
        }

        private BEResultadoReservaProl GetObservacionesPROLv2(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (olstPedidoWebDetalle.Count == 0) return resultado;

            string listaProductos = string.Join("|", olstPedidoWebDetalle.Select(x => x.CUV).ToArray());
            string listaCantidades = string.Join("|", olstPedidoWebDetalle.Select(x => x.Cantidad).ToArray());
            string listaRecuperacion = string.Join("|", olstPedidoWebDetalle.Select(x => Convert.ToInt32(x.AceptoBackOrder)).ToArray());
            decimal montoEnviar = GetMontoEnviar(input);

            RespuestaProl respuestaProl;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                if (input.FechaHoraReserva) respuestaProl = sv.wsValidacionInteractiva(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, montoEnviar, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos, input.SegmentoInternoID.ToString());
                else respuestaProl = sv.wsValidacionEstrategia(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, montoEnviar, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos);
            }
            if (respuestaProl == null) return resultado;

            resultado.MontoAhorroCatalogo = respuestaProl.montoAhorroCatalogo.ToDecimalSecure();
            resultado.MontoAhorroRevista = respuestaProl.montoAhorroRevista.ToDecimalSecure();
            resultado.MontoGanancia = resultado.MontoAhorroCatalogo + resultado.MontoAhorroRevista;
            resultado.MontoDescuento = respuestaProl.montoDescuento.ToDecimalSecure();
            resultado.MontoEscala = respuestaProl.montoEscala.ToDecimalSecure();
            resultado.MontoTotal = olstPedidoWebDetalle.Sum(pd => pd.ImporteTotal) - resultado.MontoDescuento;
            resultado.UnidadesAgregadas = olstPedidoWebDetalle.Sum(pd => pd.Cantidad);
            resultado.CodigoMensaje = respuestaProl.codigoMensaje;
            this.UpdateMontosPedidoWeb(resultado, input);
            resultado.RefreshPedido = true;
            resultado.RefreshMontosProl = true;

            List<BEPedidoWebDetalle> lstPedidoWebDetalleBackOrder = new List<BEPedidoWebDetalle>();
            bool validacionProlmm = false;
            string cuvVal = string.Empty;
            int validacionReemplazo = 0;
            if (!respuestaProl.codigoMensaje.Equals("00"))
            {
                foreach (var item in respuestaProl.ListaObservaciones)
                {
                    int tipoObs = Convert.ToInt32(item.cod_observacion);
                    string cuv = item.codvta;
                    string observacion = item.observacion.Replace("+", "");

                    if (tipoObs == 8) lstPedidoWebDetalleBackOrder.AddRange(olstPedidoWebDetalle.Where(d => d.CUV == cuv));
                    else
                    {
                        if (tipoObs == 0) validacionReemplazo += 1;
                        else if (tipoObs == 95)
                        {
                            validacionProlmm = true;
                            cuvVal = cuv;
                            observacion = Regex.Replace(observacion, "(\\#.*\\#)", Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO));
                        }
                        resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = tipoObs, CUV = cuv, Tipo = 2, Descripcion = observacion });
                    }
                }
                resultado.Restrictivas = respuestaProl.ListaObservaciones.Any();
                resultado.Reserva = input.FechaHoraReserva && (respuestaProl.ListaObservaciones.Count() == validacionReemplazo);
                resultado.ResultadoReservaEnum =
                    respuestaProl.ListaObservaciones.Count() == validacionReemplazo ? Enumeradores.ResultadoReserva.ReservadoObservaciones :
                    cuvVal == "XXXXX" ? Enumeradores.ResultadoReserva.NoReservadoMontoMinimo :
                    cuvVal == "YYYYY" ? Enumeradores.ResultadoReserva.NoReservadoMontoMaximo :
                    Enumeradores.ResultadoReserva.NoReservadoObservaciones;

                var bLPedidoWebDetalle = new BLPedidoWebDetalle();
                if (input.ValidacionAbierta && validacionProlmm && cuvVal == "XXXXX")
                {
                    bLPedidoWebDetalle.UpdPedidoWebByEstado(input.PaisID, input.CampaniaID, input.PedidoID, Constantes.EstadoPedido.Pendiente, false, true, input.CodigoUsuario, false);
                }
                bLPedidoWebDetalle.UpdBackOrderListPedidoWebDetalle(input.PaisID, input.CampaniaID, input.PedidoID, lstPedidoWebDetalleBackOrder);
            }
            else
            {
                resultado.ResultadoReservaEnum = Enumeradores.ResultadoReserva.Reservado;
                resultado.Reserva = input.FechaHoraReserva;
            }
            if (resultado.Reserva)
            {
                decimal montoTotalProl = respuestaProl.montototal.ToDecimalSecure();
                decimal descuentoProl = respuestaProl.montoDescuento.ToDecimalSecure();
                var listPedidoReserva = GetPedidoReservaV2(respuestaProl, olstPedidoWebDetalle);
                EjecutarReservaPortal(input, listPedidoReserva, olstPedidoWebDetalle, true, montoTotalProl, descuentoProl);
            }

            if (respuestaProl.ListaConcursoIncentivos != null)
            {
                resultado.ListaConcursosCodigos = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.codigoconcurso).ToArray());
                resultado.ListaConcursosPuntaje = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.puntajeconcurso.Split('|')[0]).ToArray());
                resultado.ListaConcursosPuntajeExigido = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => (i.puntajeconcurso.IndexOf('|') > -1 ? i.puntajeconcurso.Split('|')[1] : "0")).ToArray());
            }

            return resultado;
        }

        private void EjecutarReservaPortal(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoReserva, List<BEPedidoWebDetalle> listPedidoWebDetalle, bool version2, decimal montoTotalProl = 0, decimal descuentoProl = 0)
        {
            var bLPedidoWebDetalle = new BLPedidoWebDetalle();
            var estadoPedido = input.PROLSinStock ? Constantes.EstadoPedido.Pendiente : Constantes.EstadoPedido.Procesado;
            if (version2) bLPedidoWebDetalle.InsPedidoWebDetallePROLv2(input.PaisID, input.CampaniaID, input.PedidoID, estadoPedido, listPedidoReserva, false, input.CodigoUsuario, montoTotalProl, descuentoProl);
            else bLPedidoWebDetalle.InsPedidoWebDetallePROL(input.PaisID, input.CampaniaID, input.PedidoID, estadoPedido, listPedidoReserva, 0, input.CodigoUsuario, montoTotalProl, descuentoProl);

            decimal totalPedido = listPedidoWebDetalle.Sum(p => p.ImporteTotal);
            decimal gananciaEstimada = CalcularGananciaEstimada(input.PaisID, input.CampaniaID, input.PedidoID, totalPedido);
            new BLFactorGanancia().UpdatePedidoWebEstimadoGanancia(input.PaisID, input.CampaniaID, input.PedidoID, gananciaEstimada);
        }

        private List<BEPedidoWebDetalle> GetPedidoReservaV2(RespuestaProl respuestaPROL, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var listPedidoReserva = new List<BEPedidoWebDetalle>();
            if (respuestaPROL.ListaObservaciones != null)
            {
                foreach (var item in respuestaPROL.ListaObservaciones)
                {
                    listPedidoReserva.AddRange(listPedidoWebDetalle.Where(p => p.CUV == item.codvta).Select(pd => new BEPedidoWebDetalle
                    {
                        CampaniaID = pd.CampaniaID,
                        PedidoID = pd.PedidoID,
                        PedidoDetalleID = pd.PedidoDetalleID,
                        ObservacionPROL = item.observacion
                    }));
                }
            }
            return listPedidoReserva;
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

        private decimal CalcularGananciaEstimada(int paisId, int campaniaId, int pedidoId, decimal totalPedido)
        {
            var bLFactorGanancia = new BLFactorGanancia();
            decimal indicadorNumero;

            BEFactorGanancia factorGanancia = null;
            try {
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

        private void UpdateMontosPedidoWeb(BEResultadoReservaProl resultado, BEInputReservaProl input)
        {
            BEPedidoWeb bePedidoWeb = new BEPedidoWeb
            {
                PaisID = input.PaisID,
                CampaniaID = input.CampaniaID,
                ConsultoraID = input.ConsultoraID,
                MontoAhorroCatalogo = resultado.MontoAhorroCatalogo,
                MontoAhorroRevista = resultado.MontoAhorroRevista,
                DescuentoProl = resultado.MontoDescuento,
                MontoEscala = resultado.MontoEscala
            };
            new BLPedidoWeb().UpdateMontosPedidoWeb(bePedidoWeb);
        }

        private DataSet DataSetPedidoDetalleParaProl(List<BEPedidoWebDetalle> listPedidoWebDetalle, string codigoConsultora)
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("CodConsultora");
            dataTable.Columns.Add("CodVta");
            dataTable.Columns.Add("Cantidad", Type.GetType("System.Int32"));
            dataTable.Columns.Add("TipoOfertaSisID", Type.GetType("System.Int32"));
            dataTable.Columns.Add("Recuperacion", Type.GetType("System.Int32"));

            listPedidoWebDetalle = listPedidoWebDetalle ?? new List<BEPedidoWebDetalle>();
            foreach (var item in listPedidoWebDetalle)
            {
                dataTable.Rows.Add(codigoConsultora, item.CUV, item.Cantidad, item.TipoOfertaSisID, item.AceptoBackOrder ? 1 : 0);
            }

            var dataSet = new DataSet();
            dataSet.Tables.Add(dataTable);
            return dataSet;
        }

        private decimal GetMontoEnviar(BEInputReservaProl input)
        {
            decimal montoDescontar = 0;
            decimal montoEnviar = input.MontoMinimo - montoDescontar;
            if (montoEnviar < 0) montoEnviar = 0;
            return montoEnviar;
        }

        private bool DebeEnviarCorreoReservaProl(BEInputReservaProl input, BEResultadoReservaProl resultado)
        {
            if (!resultado.Reserva || resultado.Informativas || input.Email.IsNullOrEmptyTrim()) return false;
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
                    mailBody.AppendFormat("<td style = 'width: 50%; text-align: right; color: #000; font-family: Arial; font-size: 14px; font-weight:700;' > {1} {0} </td></tr> ", String.Format("{0:#,##0}", pedidoDetalle.ImporteTotal).Replace(',', '.'), simbolo);
                    rowPrecioUnitario = String.Format("<tr style='padding-bottom:25px;'> <td colspan = '2' style = 'width: 100%;text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px;' > Precio Unit.: {1} {0}</td></tr>", String.Format("{0:#,##0}", pedidoDetalle.PrecioUnidad).Replace(',', '.'), simbolo);
                }
                else
                {
                    mailBody.AppendFormat("<td style = 'width: 50%; text-align: right; color: #000; font-family: Arial; font-size: 14px; font-weight:700;' > {1} {0:#0.00} </td></tr> ", pedidoDetalle.ImporteTotal, simbolo);
                    rowPrecioUnitario = String.Format("<tr> <td colspan = '2' style = 'width: 100%;text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px; padding-bottom:30px;' > Precio Unit.: {1} {0:#0.00} </td></tr>", pedidoDetalle.PrecioUnidad, simbolo);
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
            mailBody.Append(" <td style='width: 15 %; text - align:left; border - right:1px solid #FFF;'><a href = 'http://www.cyzone.com/' ><img src = 'https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/qZf6NJ5d9D75LCO/logo-cyzone.png' alt = 'Logo Cyzone' /> </a></td>");
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
    }
}
