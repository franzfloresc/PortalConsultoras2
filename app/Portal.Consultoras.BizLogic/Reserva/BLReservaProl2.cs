using Portal.Consultoras.Common;
using Portal.Consultoras.Data.ServicePROL;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text.RegularExpressions;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaProl2 : BLReservaProl, IReservaExternaBL
    {
        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (olstPedidoWebDetalle.Count == 0) return resultado;

            string listaProductos = string.Join("|", olstPedidoWebDetalle.Select(x => x.CUV).ToArray());
            string listaCantidades = string.Join("|", olstPedidoWebDetalle.Select(x => x.Cantidad).ToArray());
            string listaRecuperacion = string.Join("|", olstPedidoWebDetalle.Select(x => Convert.ToInt32(x.AceptoBackOrder)).ToArray());

            RespuestaProl respuestaProl;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                if (input.FechaHoraReserva) respuestaProl = sv.wsValidacionInteractiva(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, input.MontoMinimo, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos, input.SegmentoInternoID.ToString());
                else respuestaProl = sv.wsValidacionEstrategia(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, input.MontoMinimo, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos);
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
                var listPedidoReserva = GetPedidoReserva(respuestaProl, olstPedidoWebDetalle);
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
    }
}
