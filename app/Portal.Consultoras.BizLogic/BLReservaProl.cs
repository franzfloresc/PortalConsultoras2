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
            int paisID = Util.GetPaisID(paisISO);
            try
            {
                BEUsuario usuario = null;
                using (IDataReader reader = (new DAConfiguracionCampania(paisID)).GetConfiguracionByUsuarioAndCampania(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
                {
                    if (reader.Read()) usuario = new BEUsuario(reader, true);
                }
                BEConfiguracionCampania configuracion = null;
                using (IDataReader reader = new DAPedidoWeb(paisID).GetEstadoPedido(campania, usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
                {
                    if (reader.Read()) configuracion = new BEConfiguracionCampania(reader);
                }
                usuario.IndicadorGPRSB = configuracion == null ? 0 : configuracion.IndicadorGPRSB;

                usuario.PaisID = paisID;
                usuario.ConsultoraID = consultoraID;
                usuario.CampaniaID = campania;
                usuario.AceptacionConsultoraDA = aceptacionConsultoraDA;

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
            if(usuario.IndicadorGPRSB == 1) return string.Format("En este momento nos encontramos facturando tu pedido de C{0}, inténtalo más tarde", usuario.CampaniaID.Substring(4, 2));

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
            int pedidoID = 0;

            var listPedidoWebDetalle = bLPedidoWebDetalle.GetPedidoWebDetalleByCampania(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID, usuario.Nombre).ToList();
            if (listPedidoWebDetalle.Count == 0)
            {
                pedidoID = new BLPedidoWeb().GetPedidoWebID(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID);
                estado = Constantes.EstadoPedido.Pendiente;
            }
            else pedidoID = listPedidoWebDetalle[0].PedidoID;

            var codigoUsuario = usuario.UsuarioPrueba == 1 ? usuario.ConsultoraAsociada : usuario.CodigoUsuario;
            bLPedidoWebDetalle.UpdPedidoWebByEstado(usuario.PaisID, usuario.CampaniaID, pedidoID, estado, false, true, codigoUsuario, validacionAbierta);

            if (tipo == "PI")
            {
                List<BEPedidoWebDetalle> listReemplazo = listPedidoWebDetalle.Where(p => !string.IsNullOrEmpty(p.Mensaje)).ToList();
                if (listReemplazo.Count != 0) bLPedidoWebDetalle.InsPedidoWebAccionesPROL(listReemplazo, 100, 103);
            }

            return "";
        }

        public BEResultadoReservaProl CargarSesionAndEjecutarReservaProl(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, bool esMovil, bool enviarCorreo)
        {
            int paisID = Util.GetPaisID(paisISO);
            try
            {
                BEUsuario usuario = null;
                using (IDataReader reader = (new DAConfiguracionCampania(paisID)).GetConfiguracionByUsuarioAndCampania(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
                {
                    if (reader.Read()) usuario = new BEUsuario(reader, true);
                }
                BEConfiguracionCampania configuracion = null;
                using (IDataReader reader = new DAPedidoWeb(paisID).GetEstadoPedido(campania, usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
                {
                    if (reader.Read()) configuracion = new BEConfiguracionCampania(reader);
                }
                UpdateDiaPROLAndEsHoraReserva(usuario);

                var input = new BEInputReservaProl {
                    PaisISO = paisISO,
                    PaisID = paisID,
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
                    EsMovil = esMovil,
                    EnviarCorreo = enviarCorreo
                };

                if (usuario.TieneHana == 1)
                {
                    var datosConsultoraHana = new BLUsuario().GetDatosConsultoraHana(paisID, usuario.CodigoUsuario, campania);
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
                
                return EjecutarReservaProl(input);
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

            TimeSpan HoraNow = new TimeSpan(fechaHoraActual.Hour, fechaHoraActual.Minute, 0);
            bool esHorarioReserva = (fechaHoraActual < usuario.FechaInicioFacturacion) ?
                (HoraNow > usuario.HoraInicioNoFacturable && HoraNow < usuario.HoraCierreNoFacturable) :
                (HoraNow > usuario.HoraInicio && HoraNow < usuario.HoraFin);
            if (!esHorarioReserva) return false;

            if (usuario.CodigoISO != Constantes.CodigosISOPais.Peru)
            {
                return (new BLPedidoWeb().GetFechaNoHabilFacturacion(usuario.PaisID, usuario.CodigoZona, DateTime.Today) == 0);
            }
            return true;
        }

        public BEResultadoReservaProl EjecutarReservaProl(BEInputReservaProl input)
        {
            if (!input.ZonaValida) return new BEResultadoReservaProl { Reserva = true };
            if (!input.ValidacionInteractiva) return new BEResultadoReservaProl();
            try
            {
                var listPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(input.PaisID, input.CampaniaID, input.ConsultoraID, input.NombreConsultora).ToList();
                if (listPedidoWebDetalle.Count > 0) input.PedidoID = listPedidoWebDetalle[0].PedidoID;
                
                BECUVAutomatico producto = new BECUVAutomatico { CampaniaID = input.CampaniaID };
                var lst = new BLCuv().GetProductoCuvAutomatico(input.PaisID, producto, "CUV", "asc", 1, 1, 100).ToList();
                if (lst.Count > 0) listPedidoWebDetalle = listPedidoWebDetalle.Where(x => !lst.Select(y => y.CUV).Contains(x.CUV)).ToList();
                
                BEResultadoReservaProl resultado;
                if (input.ProlV2) resultado = GetObservacionesPROLv2(input, listPedidoWebDetalle);
                else resultado = GetObservacionesPROL(input, listPedidoWebDetalle);
                resultado.PedidoID = input.PedidoID;

                resultado.EnviarCorreo = DebeEnviarCorreoReservaProl(input, resultado, listPedidoWebDetalle);
                if(resultado.EnviarCorreo) EnviarCorreoReservaProl(input, listPedidoWebDetalle);
                return resultado;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, input.CodigoConsultora, input.PaisISO);
                return new BEResultadoReservaProl {
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
                var listPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(input.PaisID, input.CampaniaID, input.ConsultoraID, input.NombreConsultora).ToList();
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
                TransferirDatos datos = null;
                using (var sv = new ServiceStockSsic())
                {
                    sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                    datos = sv.ObtenerExplotado(input.CodigoConsultora, input.CampaniaID.ToString(), input.PaisISO, input.CodigoZona);
                }
                if (datos == null) return -1;

                var listPedidoWebDetalle = new BLPedidoWebDetalle().GetPedidoWebDetalleByCampania(input.PaisID, input.CampaniaID, input.ConsultoraID, input.NombreConsultora).ToList();
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
            DataSet ds = DataSetPedidoDetalleParaProl(olstPedidoWebDetalle, input.CodigoConsultora);
            if (ds.Tables[0].Rows.Count == 0) return resultado;

            decimal montoenviar = GetMontoEnviar(input);
            TransferirDatos datos = null;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                if (input.FechaHoraReserva)
                {
                    bool valida = sv.wsDesReservarPedido(input.CodigoConsultora, input.PaisISO);
                    datos = sv.wsValidarPedidoEX(ds, montoenviar, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo);
                }
                else datos = sv.wsValidarEstrategia(ds, montoenviar, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo);
            }
            if (datos == null) return resultado;

            resultado.MontoAhorroCatalogo = datos.montoAhorroCatalogo.ToDecimalSecure();
            resultado.MontoAhorroRevista = datos.montoAhorroRevista.ToDecimalSecure();
            resultado.MontoDescuento = datos.montoDescuento.ToDecimalSecure();
            resultado.MontoEscala = datos.montoEscala.ToDecimalSecure();
            resultado.CodigoMensaje = datos.codigoMensaje;
            this.UpdateMontosPedidoWeb(resultado, input);
            resultado.RefreshPedido = true;
            resultado.RefreshMontosProl = true;

            DataTable dtr = datos.data.Tables[0];
            if (datos.codigoMensaje != "00")
            {
                foreach (DataRow row in dtr.Rows)
                {
                    int TipoObs = Convert.ToInt32(row.ItemArray.GetValue(0));
                    switch (TipoObs)
                    {
                        case 0:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 0, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 1, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Informativas = true;
                            break;
                        case 1:
                        case 7:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 7, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true;
                            break;
                        case 2:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 2, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("PRODUCTO {0} - {1} {2}", Convert.ToString(row.ItemArray.GetValue(1)), Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true;
                            break;
                        case 5:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 5, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true;
                            break;
                        case 8:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 8, CUV = string.Empty, Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true;
                            break;
                        case 9:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 9, CUV = string.Empty, Tipo = 3, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true; //R2004
                            break;
                        case 10:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 10, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true;
                            break;
                        case 11:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 11, CUV = string.Empty, Tipo = 3, Descripcion = string.Empty });
                            resultado.Error = true;
                            break;
                        case 16:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 16, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("PRODUCTO {0} - {1} {2}", Convert.ToString(row.ItemArray.GetValue(1)), Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true;
                            break;
                        case 95:
                            string value = Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "");
                            string Observacion = Regex.Replace(value, "(\\#.*\\#)", input.MontoMinimo.ToString());
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = 95, CUV = string.Empty, Tipo = 2, Descripcion = Observacion });
                            resultado.Restrictivas = true;
                            break;
                        default:
                            resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = TipoObs, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                            resultado.Restrictivas = true;
                            break;
                    }
                }
                resultado.Reserva = input.FechaHoraReserva && resultado.Informativas && !resultado.Restrictivas;
            }
            else resultado.Reserva = input.FechaHoraReserva;

            if (resultado.Reserva)
            {
                decimal montoTotalPROL = datos.montototal.ToDecimalSecure();
                decimal descuentoPROL = datos.montoDescuento.ToDecimalSecure();
                var listPedidoReserva = GetPedidoReserva(dtr, olstPedidoWebDetalle, input.CodigoUsuario);
                EjecutarReservaPortal(input, listPedidoReserva, olstPedidoWebDetalle, false, montoTotalPROL, descuentoPROL);
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

            RespuestaProl RespuestaPROL = null;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                if (input.FechaHoraReserva) RespuestaPROL = sv.wsValidacionInteractiva(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, montoEnviar, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo);
                else RespuestaPROL = sv.wsValidacionEstrategia(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, montoEnviar, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo);
            }
            if (RespuestaPROL == null) return resultado;

            resultado.MontoAhorroCatalogo = RespuestaPROL.montoAhorroCatalogo.ToDecimalSecure();
            resultado.MontoAhorroRevista = RespuestaPROL.montoAhorroRevista.ToDecimalSecure();
            resultado.MontoDescuento = RespuestaPROL.montoDescuento.ToDecimalSecure();
            resultado.MontoEscala = RespuestaPROL.montoEscala.ToDecimalSecure();
            resultado.CodigoMensaje = RespuestaPROL.codigoMensaje;
            this.UpdateMontosPedidoWeb(resultado, input);
            resultado.RefreshPedido = true;
            resultado.RefreshMontosProl = true;

            List<BEPedidoWebDetalle> lstPedidoWebDetalleBackOrder = new List<BEPedidoWebDetalle>();
            bool ValidacionPROLMM = false;
            string CUV_Val = string.Empty;
            int ValidacionReemplazo = 0;
            if (!RespuestaPROL.codigoMensaje.Equals("00"))
            {
                foreach (var item in RespuestaPROL.ListaObservaciones)
                {
                    int TipoObs = Convert.ToInt32(item.cod_observacion);
                    string CUV = item.codvta;
                    string Observacion = item.observacion.Replace("+", "");

                    if (TipoObs == 8) lstPedidoWebDetalleBackOrder.AddRange(olstPedidoWebDetalle.Where(d => d.CUV == CUV));
                    else
                    {
                        if (TipoObs == 0) ValidacionReemplazo += 1;
                        else if (TipoObs == 95)
                        {
                            ValidacionPROLMM = true;
                            CUV_Val = CUV;
                            Observacion = Regex.Replace(Observacion, "(\\#.*\\#)", Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO));
                        }
                        resultado.ListPedidoObservacion.Add(new BEPedidoObservacion() { Caso = TipoObs, CUV = CUV, Tipo = 2, Descripcion = Observacion });
                    }
                }
                resultado.Restrictivas = (RespuestaPROL.ListaObservaciones.Count() > 0);
                resultado.Reserva = input.FechaHoraReserva && (RespuestaPROL.ListaObservaciones.Count() == ValidacionReemplazo);

                var bLPedidoWebDetalle = new BLPedidoWebDetalle();
                if (input.ValidacionAbierta && ValidacionPROLMM && CUV_Val == "XXXXX")
                {
                    bLPedidoWebDetalle.UpdPedidoWebByEstado(input.PaisID, input.CampaniaID, input.PedidoID, Constantes.EstadoPedido.Pendiente, false, true, input.CodigoUsuario, false);
                }
                bLPedidoWebDetalle.UpdBackOrderListPedidoWebDetalle(input.PaisID, input.CampaniaID, input.PedidoID, lstPedidoWebDetalleBackOrder);
            }
            else resultado.Reserva = input.FechaHoraReserva;

            if (resultado.Reserva)
            {
                decimal montoTotalPROL = RespuestaPROL.montototal.ToDecimalSecure();
                decimal descuentoPROL = RespuestaPROL.montoDescuento.ToDecimalSecure();
                var listPedidoReserva = GetPedidoReservaV2(RespuestaPROL, olstPedidoWebDetalle);
                EjecutarReservaPortal(input, listPedidoReserva, olstPedidoWebDetalle, true, montoTotalPROL, descuentoPROL);
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
                if (temp.Count() == 0)
                {
                    listPedidoReserva.Add(new BEPedidoWebDetalle()
                    {
                        CampaniaID = listPedidoWebDetalle[0].CampaniaID,
                        PedidoID = listPedidoWebDetalle[0].PedidoID,
                        //PedidoDetalleID = PedidoDetalleIDPadre, //Desactivado porque no existe Jerarquia
                        PedidoDetalleID = 0,
                        MarcaID = listPedidoWebDetalle[0].MarcaID,
                        ConsultoraID = listPedidoWebDetalle[0].ConsultoraID,
                        ClienteID = 0,
                        Cantidad = Convert.ToInt32(row.ItemArray.GetValue(3)),
                        //PrecioUnidad = Convert.ToDecimal(row.ItemArray.GetValue(2)), //Precio Unidad deberia ser cero pero lo envían
                        PrecioUnidad = 0,
                        //ImporteTotal = Convert.ToDecimal(row.ItemArray.GetValue(4)),
                        ImporteTotal = 0,
                        CUV = Convert.ToString(row.ItemArray.GetValue(0)),
                        OfertaWeb = false,
                        //CUVPadre = CUVPadre //Desactivado porque no existe Jerarquia
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
            try { factorGanancia = bLFactorGanancia.GetFactorGananciaEscalaDescuento(totalPedido, paisId); }
            catch { }
            decimal porcentajeGanancia = factorGanancia == null ? 0 : (factorGanancia.Porcentaje / 100);

            // se recorren los productos del pedido y se evalua su indicador de descuento aplicando la logica siguiente:
            var ProductosIndicadorDscto = bLFactorGanancia.GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(paisId, campaniaId, pedidoId).ToList();
            ProductosIndicadorDscto.ForEach(pid => {
                string indicador = pid.IndicadorDscto.ToLower();

                if (indicador == " ") pid.MontoDscto = (pid.PrecioUnidad - pid.PrecioCatalogo2) * pid.Cantidad;
                else if (indicador == "c") pid.MontoDscto = (pid.PrecioUnidad * porcentajeGanancia) * pid.Cantidad;
                else if (decimal.TryParse(indicador, out indicadorNumero) && indicadorNumero.Between(0, 100))
                {
                    pid.MontoDscto = (pid.PrecioUnidad * (indicadorNumero / 100)) * pid.Cantidad;
                }
            });
            return ProductosIndicadorDscto.Sum(p => p.MontoDscto);
        }
        
        private void UpdateMontosPedidoWeb(BEResultadoReservaProl resultado, BEInputReservaProl input)
        {
            BEPedidoWeb BePedidoWeb = new BEPedidoWeb
            {
                PaisID = input.PaisID,
                CampaniaID = input.CampaniaID,
                ConsultoraID = input.ConsultoraID,
                MontoAhorroCatalogo = resultado.MontoAhorroCatalogo,
                MontoAhorroRevista = resultado.MontoAhorroRevista,
                DescuentoProl = resultado.MontoDescuento,
                MontoEscala = resultado.MontoEscala
            };
            new BLPedidoWeb().UpdateMontosPedidoWeb(BePedidoWeb);
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

        private bool DebeEnviarCorreoReservaProl(BEInputReservaProl input, BEResultadoReservaProl resultado, List<BEPedidoWebDetalle> listPedidoWebDetalle)
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
                LogManager.SaveLog(ex, input.CodigoUsuario, (input.EsMovil ? "SB Mobile - " : "") + input.PaisISO);
                return false;
            }
            return true;
        }

        private void EnviarCorreoReservaProl(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var envio = input.EsMovil ? EnviarPorCorreoPedidoValidadoMobile(input, listPedidoWebDetalle) : EnviarPorCorreoPedidoValidado(input, listPedidoWebDetalle);
            if (envio) InsLogEnvioCorreoPedidoValidado(input, listPedidoWebDetalle);
        }

        //private bool EnviarPorCorreoPedidoValidado(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        //{
        //    bool IndicadorOfertaCUV = false;
        //    string fechaEnvio = DateTime.Now.AddHours(input.ZonaHoraria).Date < input.FechaInicioCampania.Date ?
        //        input.FechaInicioCampania.ToString(@"dd \de MMMM", new CultureInfo("es-PE")) :
        //        "de hoy";

        //    StringBuilder mailBody = new StringBuilder();
        //    mailBody.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
        //    mailBody.Append("<meta http-equiv='Content-Type' content='Type=text/html; charset=utf-8'>");
        //    mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
        //    mailBody.AppendFormat("<tr><td><div style='font-size:12px;font-family: calibri;'>Hola {0},</div></td></tr>", input.NombreConsultora);
        //    mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
        //    mailBody.Append("<tr><td><div style='font-size:12px;font-family: calibri;'>¡Lo lograste!</div ></td></tr>");
        //    mailBody.Append("<tr><td><div style='font-size:12px;font-family: calibri;'>Tu pedido ha sido reservado con éxito.</div></td></tr>");
        //    mailBody.AppendFormat("<tr><td><div style='font-size:12px;font-family: calibri;'>Será enviado a Belcorp el día {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda pendiente.</div></div></td></tr>", fechaEnvio);
        //    mailBody.Append("<tr style='height:12px;'><td></td></tr><tr><td><div style='font-size:12px;font-family: calibri;margin-left: 10px;'>Detalle de pedido:</div ></td></tr>");
        //    mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
        //    mailBody.Append("</table>");

        //    mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 90%; margin-left: 10px;'>");
        //    mailBody.Append("<tr style='color: #FFFFFF'>");
        //    mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 70px; background-color: #6c217f;'>");
        //    mailBody.Append("Cód.<br />Venta</td>");
        //    mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #6c217f; padding-left:5px; padding-right:5px;'>");
        //    mailBody.Append("Descripción</td>");
        //    mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #6c217f;'>");
        //    mailBody.Append("Cantidad</td>");
        //    mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #6c217f;'>");
        //    mailBody.Append("Precio Unit.</td>");
        //    mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
        //    mailBody.Append("Precio Total</td>");
        //    mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
        //    mailBody.Append("Cliente</td></tr>");
        //    foreach (BEPedidoWebDetalle pedidoDetalle in olstPedidoWebDetalle)
        //    {
        //        mailBody.Append("<tr>");
        //        mailBody.Append("<td style='font-size:11px; width: 56px; text-align: center; border-bottom: 1px solid #6c217f;  border-left: 1px solid #6c217f;'>");
        //        mailBody.AppendFormat("{0}</td>", pedidoDetalle.CUV);
        //        mailBody.Append("<td style='font-size:11px; width: 347px; text-align: left; border-bottom: 1px solid #6c217f;'>");
        //        mailBody.AppendFormat("{0}</td>", pedidoDetalle.DescripcionProd);
        //        mailBody.Append("<td style='font-size:11px; width: 124px; text-align: center; border-bottom: 1px solid #6c217f;'>");
        //        mailBody.AppendFormat("{0}</td>", pedidoDetalle.Cantidad);
        //        mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");
        //        mailBody.Append(input.Simbolo);
        //        mailBody.Append(Util.DecimalToStringFormat(pedidoDetalle.PrecioUnidad, input.PaisISO));
        //        mailBody.Append("</td>");
        //        mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
        //        mailBody.Append(input.Simbolo);
        //        mailBody.Append(Util.DecimalToStringFormat(pedidoDetalle.ImporteTotal, input.PaisISO));

        //        if (input.EstadoSimplificacionCUV && pedidoDetalle.IndicadorOfertaCUV)
        //        {
        //            IndicadorOfertaCUV = true;
        //            mailBody.Append("<img id='IndicadorOfercarCUVImage' height='13' width='13' src=\"cid:IconoIndicador\" />");
        //        }
        //        mailBody.Append("</td>");
        //        mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;border-right: 1px solid #6c217f;'>");
        //        mailBody.AppendFormat("{0}</td>", pedidoDetalle.Nombre);
        //    }
        //    mailBody.Append("</tr></table>");

        //    if (IndicadorOfertaCUV)
        //    {
        //        mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 90%; margin-left: 15px; margin-top:3px;'>");
        //        mailBody.Append("<tr><td>");
        //        mailBody.Append("<div id='LeyendaIndicadorCUV' style='font-family: arial; font-size: 11px; color: #722789; padding-right:10px; '>");
        //        mailBody.Append("<div><img src=\"cid:IconoIndicador\" height='13' width='13'/>El precio total no incluye el descuento para ofertas con más de un precio (1x, 2x). Al validar tu pedido, el sistema elegirá la mejor combinación de precios posibles para ti.</div>");
        //        mailBody.Append("</div>");
        //        mailBody.Append("</td></tr>");
        //        mailBody.Append("</table>");
        //    }
        //    mailBody.Append("<br />");
        //    mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
        //    mailBody.Append("<tr><td><div style='font-size:12px;'></div></td></tr>");
        //    mailBody.Append("<tr><td><div style='font-size:12px;font-family: calibri;'>Gracias,</div></td></tr><tr><td>&nbsp;</td></tr>");
        //    mailBody.Append("<tr><td><img src='cid:Logo' border='0' /></td></tr>");
        //    mailBody.Append("</table>");

        //    try
        //    {
        //        return Util.EnviarMail("no-responder@somosbelcorp.com", input.Email, string.Empty, string.Format("({0}) Confirmación pedido Belcorp", input.PaisISO), mailBody.ToString(), true, null, IndicadorOfertaCUV);
        //    }
        //    catch { return false; }
        //}

        private bool EnviarPorCorreoPedidoValidado(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            bool esEsika = (ConfigurationManager.AppSettings.Get("PaisesEsika") ?? "").Contains(input.PaisISO);
            String colorStyle = esEsika ? "#e81c36" : "#613c87";
            bool IndicadorOfertaCUV = false;
            decimal montoTotal2 = olstPedidoWebDetalle.Sum(c => c.ImporteTotal) - olstPedidoWebDetalle.Sum(c => c.DescuentoProl);
            decimal gananciaEstimada2 = olstPedidoWebDetalle.Sum(c => c.MontoAhorroCatalogo) + olstPedidoWebDetalle.Sum(c => c.MontoAhorroRevista);
            decimal totalSinDescuento2 = olstPedidoWebDetalle.Sum(c => c.ImporteTotal);
            decimal descuento2 = olstPedidoWebDetalle.Sum(c => c.DescuentoProl);
            string montoTotalString = Util.DecimalToStringFormat(montoTotal2, input.PaisISO);
            string gananciaEstimadaString = Util.DecimalToStringFormat(gananciaEstimada2, input.PaisISO);
            string totalSinDescuentoString = Util.DecimalToStringFormat(totalSinDescuento2, input.PaisISO);
            string descuentoString = Util.DecimalToStringFormat(descuento2, input.PaisISO);

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
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 16px; font-weight: 700; color: #000;padding-right:14%; text-align:right;' > {0}{1} </td></tr> ", input.Simbolo, montoTotalString);
            mailBody.AppendFormat("<tr> <td style = 'width: 50%; font-family: Arial; font-size: 13px; color: {0}; font-weight:700; padding-left: 14%; text-align:left; padding-bottom: 20px; padding-top: 5px' > GANANCIA ESTIMADA: </td>", colorStyle);
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 13px; font-weight: 700; color: {0}; padding-right:14%; text-align:right;padding-bottom: 20px; padding-top: 5px' > {1}{2} </td></tr>", colorStyle, olstPedidoWebDetalle.Select(c => c.Simbolo).FirstOrDefault(), gananciaEstimadaString);

            mailBody.Append("<tr> <td colspan = '2' style = 'text-align: center; color: #000; font-family: Arial; font-size: 15px; font-weight: 700; border-top:1px solid #000; border-bottom: 1px solid #000; padding-top: 8px; padding-bottom: 8px; letter-spacing: 0.5px;' > DETALLE </td></tr> ");
            mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; font-weight: 700; padding-top: 15px; padding-left: 10px; padding-right: 10px;' > DESCRIPCIÓN </td>");
            mailBody.Append("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; font-weight: 700; padding-top: 15px; padding-left: 10px; padding-right: 10px;' > SUBTOTAL </td></tr>");
            mailBody.Append("<tr><td colspan = '2' style = 'padding-top: 15px; padding-left: 10px; padding-right: 10px; border-bottom:2px solid #9E9E9E' >");

            foreach (BEPedidoWebDetalle pedidoDetalle in olstPedidoWebDetalle)
            {
                mailBody.Append("<table width = '100%' align = 'center' border = '0' cellspacing = '0' cellpadding = '0' align = 'center' style = 'padding-bottom: 30px;' >");
                mailBody.AppendFormat(" <tr> <td style = 'width: 50%; text-align: left; color: #000; font-family: Arial; font-size: 13px; ' > Cód.Venta: {0} </td> <td> &nbsp;</td></tr>", pedidoDetalle.CUV);
                mailBody.AppendFormat("<tr> <td style = 'text-align: left; color: #000; font-family: Arial; font-size: 14px; font-weight:700;' > {0} </td>", pedidoDetalle.DescripcionProd);
                mailBody.AppendFormat("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 14px; font-weight:700;' > {0}{1} </td></tr> ", input.Simbolo, Util.DecimalToStringFormat(pedidoDetalle.ImporteTotal, input.PaisISO));
                mailBody.AppendFormat("<tr> <td colspan = '2' style = 'text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px;' > Cliente: {0} </td></tr>", pedidoDetalle.NombreCliente);
                mailBody.AppendFormat("<tr><td colspan = '2' style = 'text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px;' > Cantidad:{0} </td></tr> ", pedidoDetalle.Cantidad);
                mailBody.AppendFormat("<tr> <td colspan = '2' style = 'text-align: left; color: #4d4d4e; font-family: Arial; font-size: 13px; padding-top: 2px;' > Precio Unit.: {0}{1} </td></tr>", input.Simbolo, Util.DecimalToStringFormat(pedidoDetalle.ImporteTotal, input.PaisISO));
                mailBody.Append("</table>");

                if (input.EstadoSimplificacionCUV && pedidoDetalle.IndicadorOfertaCUV) IndicadorOfertaCUV = true;
            }
            mailBody.Append("</tr></td></tr>");

            if (IndicadorOfertaCUV)
            {
                mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; padding-top: 15px; padding-left: 10px;' > TOTAL SIN DSCTO.</td>");
                mailBody.AppendFormat("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; padding-top: 15px; padding-right: 10px; font-weight: 700;' > {0}{1} </td></tr> ", input.Simbolo, totalSinDescuentoString);
                mailBody.Append("<tr><td style = 'text-align: left; color: #000; font-family: Arial; font-size: 13px; padding-top:3px; padding-left: 10px; border-bottom: 1px solid #000; padding-bottom: 13px;' > DSCTO.OFERTAS POR NIVELES</td>");
                mailBody.AppendFormat("<td style = 'text-align: right; color: #000; font-family: Arial; font-size: 13px; padding-top:3px; padding-right: 10px; font-weight: 700; padding-bottom: 13px; border-bottom: 1px solid #000;'> {0}{1}</td></tr>", input.Simbolo, descuentoString);
            }
            mailBody.Append("<tr> <td style = 'width: 50%; font-family: Arial; font-size: 13px; color: #000; padding-left: 10px; text-align:left; padding-top: 15px;' > MONTO TOTAL:</td>");
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 16px; font-weight: 700; color: #000;padding-right:10px; padding-top: 15px; text-align:right;' > {0}{1} </td></tr>", input.Simbolo, montoTotalString);
            mailBody.AppendFormat("<tr><td style = 'width: 50%; font-family: Arial; font-size: 13px; color: {0}; font-weight:700; padding-left: 10px; text-align:left; padding-bottom: 13px; padding-top: 5px;' > GANANCIA ESTIMADA:</td>", colorStyle);
            mailBody.AppendFormat("<td style = 'width: 50%; font-family: Arial; font-size: 13px; font-weight: 700; color: {0}; padding-right:10px; text-align:right; padding-bottom: 13px; padding-top: 5px;'> {1}{2}</td></tr>", colorStyle, input.Simbolo, gananciaEstimadaString);

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

        private bool EnviarPorCorreoPedidoValidadoMobile(BEInputReservaProl input, List<BEPedidoWebDetalle> lstPedidoWebDetalle)
        {
            string fechaEnvio = DateTime.Now.AddHours(input.ZonaHoraria).Date < input.FechaInicioCampania.Date ?
                "el " + input.FechaInicioCampania.ToString(@"dd \de MMMM", new CultureInfo("es-PE")) :
                "hoy";

            var mailBody = new StringBuilder();
            mailBody.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
            mailBody.Append("<meta http-equiv='Content-Type' content='Type=text/html; charset=utf-8'>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Hola {0},</div></td></tr>", input.PrimerNombre);
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>¡Felicitaciones!</div ></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>Tu pedido ha sido reservado con éxito.</div></td></tr>");
            mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Será enviado a Belcorp {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda.</div></div></td></tr>", fechaEnvio);
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("</table>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 90%; margin-left: 10px;'>");
            mailBody.Append("<tr style='color: #FFFFFF'>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 70px; background-color: #6c217f;'>");
            mailBody.Append("Cód.<br />Venta</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #6c217f; padding-left:5px; padding-right:5px;'>");
            mailBody.Append("Descripción</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #6c217f;'>");
            mailBody.Append("Cantidad</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #6c217f;'>");
            mailBody.Append("Precio Unit.</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Precio Total</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Cliente</td></tr>");

            foreach (var pedidoDetalle in lstPedidoWebDetalle)
            {
                mailBody.Append("<tr>");
                mailBody.Append("<td style='font-size:11px; width: 56px; text-align: center; border-bottom: 1px solid #6c217f;  border-left: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.CUV);
                mailBody.Append("<td style='font-size:11px; width: 347px; text-align: left; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.DescripcionProd);
                mailBody.Append("<td style='font-size:11px; width: 124px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Cantidad);
                mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");                    
                mailBody.Append(input.Simbolo);
                mailBody.Append(Util.DecimalToStringFormat(pedidoDetalle.PrecioUnidad, input.PaisISO));
                mailBody.Append("</td>");
                mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                mailBody.Append(input.Simbolo);
                mailBody.Append(Util.DecimalToStringFormat(pedidoDetalle.ImporteTotal, input.PaisISO));
                mailBody.Append("</td>");
                mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;border-right: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Nombre);
            }
            mailBody.Append("</tr></table><br />");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.Append("<tr><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>Gracias,</div><tr><td><tr><td><div style='font-size:12px;'>Equipo Belcorp.</div></tr></td>");
            mailBody.Append("</table>");

            try
            {
                return Util.EnviarMailMobile("no-responder@somosbelcorp.com", input.Email, string.Format("({0}) Confirmación pedido Belcorp", input.PaisISO), mailBody.ToString(), true, null);
            }
            catch { return false; }
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
