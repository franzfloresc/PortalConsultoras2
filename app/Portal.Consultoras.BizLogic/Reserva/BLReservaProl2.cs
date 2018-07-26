using Portal.Consultoras.Common;
using Portal.Consultoras.Data.ServicePROL;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaProl2 : IReservaExternaBL
    {
        public async Task<BEResultadoReservaProl> ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            RespuestaProl respuestaProl = await ConsumirServicioProl(input, listPedidoWebDetalle);
            if (respuestaProl == null)
            {
                LogManager.SaveLog(new CustomTraceException(Constantes.MensajesError.Reserva_Prol2, ""), input.CodigoConsultora, input.PaisISO);
                return new BEResultadoReservaProl(Constantes.MensajesError.Pedido_Reserva, false);
            }

            var resultado = new BEResultadoReservaProl
            {
                MontoAhorroCatalogo = respuestaProl.montoAhorroCatalogo.ToDecimalSecure(),
                MontoAhorroRevista = respuestaProl.montoAhorroRevista.ToDecimalSecure(),
                MontoDescuento = respuestaProl.montoDescuento.ToDecimalSecure(),
                MontoEscala = respuestaProl.montoEscala.ToDecimalSecure(),
                MontoTotalProl = respuestaProl.montototal.ToDecimalSecure(),
                CodigoMensaje = respuestaProl.codigoMensaje
            };

            if (respuestaProl.ListaConcursoIncentivos != null)
            {
                resultado.ListaConcursosCodigos = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.codigoconcurso).ToArray());
                resultado.ListaConcursosPuntaje = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.puntajeconcurso.Split('|')[0]).ToArray());
                resultado.ListaConcursosPuntajeExigido = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => (i.puntajeconcurso.IndexOf('|') > -1 ? i.puntajeconcurso.Split('|')[1] : "0")).ToArray());
            }

            foreach (var o in respuestaProl.ListaObservaciones)
            {
                if (o.cod_observacion == "08") resultado.ListDetalleBackOrder.AddRange(listPedidoWebDetalle.Where(d => d.CUV == o.codvta));
                else resultado.ListPedidoObservacion.Add(CreatePedidoObservacion(o));
            }
            var obsPedido = resultado.ListPedidoObservacion.FirstOrDefault(o => o.Caso == 95);
            if (obsPedido != null) obsPedido.Descripcion = Regex.Replace(obsPedido.Descripcion, "(\\#.*\\#)", Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO));
            string codNoReservaPedido = obsPedido != null ? obsPedido.CUV : "";
            
            bool reservo = !resultado.ListDetalleBackOrder.Any() && resultado.ListPedidoObservacion.All(o => o.Caso == 0);
            resultado.Restrictivas = respuestaProl.ListaObservaciones.Any(); //respuestaProl.codigoMensaje.Equals("00")
            resultado.Reserva = input.FechaHoraReserva && reservo;
            resultado.ResultadoReservaEnum =
                codNoReservaPedido == "XXXXX" ? Enumeradores.ResultadoReserva.NoReservadoMontoMinimo :
                codNoReservaPedido == "YYYYY" ? Enumeradores.ResultadoReserva.NoReservadoMontoMaximo : 
                respuestaProl.codigoMensaje.Equals("00") ? Enumeradores.ResultadoReserva.Reservado :
                reservo ? Enumeradores.ResultadoReserva.ReservadoObservaciones :
                Enumeradores.ResultadoReserva.NoReservadoObservaciones;
            
            return resultado;
        }

        public async Task<bool> DeshacerReservaPedido(BEUsuario usuario, int pedidoId)
        {
            string codigoIso = Util.GetPaisISO(usuario.PaisID);
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + codigoIso];
                return await Task.Run(() => sv.wsDesReservarPedido(usuario.CodigoConsultora, codigoIso));
            }
        }

        private async Task<RespuestaProl> ConsumirServicioProl(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            string listaProductos = string.Join("|", listPedidoWebDetalle.Select(x => x.CUV).ToArray());
            string listaCantidades = string.Join("|", listPedidoWebDetalle.Select(x => x.Cantidad).ToArray());
            string listaRecuperacion = string.Join("|", listPedidoWebDetalle.Select(x => Convert.ToInt32(x.AceptoBackOrder)).ToArray());

            RespuestaProl respuestaProl;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                
                if (!input.FechaHoraReserva) respuestaProl = await Task.Run(() => sv.wsValidacionEstrategia(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, input.MontoMinimo, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos));
                else respuestaProl = await Task.Run(() => sv.wsValidacionInteractiva(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, input.MontoMinimo, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos, input.SegmentoInternoID.ToString()));
            }

            if (respuestaProl != null)
            {
                if (respuestaProl.codigoMensaje.Equals("00")) respuestaProl.ListaObservaciones = new ObservacionProl[0];
                else respuestaProl.ListaObservaciones = respuestaProl.ListaObservaciones ?? new ObservacionProl[0];
            }
            return respuestaProl;
        }

        private BEPedidoObservacion CreatePedidoObservacion(ObservacionProl observacion) {
            return new BEPedidoObservacion
            {
                Caso = Convert.ToInt32(observacion.cod_observacion),
                CUV = observacion.codvta,
                Tipo = 2,
                Descripcion = observacion.observacion.Replace("+", "")
            };
        }
    }
}
