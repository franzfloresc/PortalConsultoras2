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
    public class BLReservaProl2 : IReservaExternaBL
    {
        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (listPedidoWebDetalle.Count == 0) return resultado;

            RespuestaProl respuestaProl = ConsumirServicioProl(input, listPedidoWebDetalle);
            if (respuestaProl == null) return resultado;

            resultado.MontoAhorroCatalogo = respuestaProl.montoAhorroCatalogo.ToDecimalSecure();
            resultado.MontoAhorroRevista = respuestaProl.montoAhorroRevista.ToDecimalSecure();
            resultado.MontoGanancia = resultado.MontoAhorroCatalogo + resultado.MontoAhorroRevista;
            resultado.MontoDescuento = respuestaProl.montoDescuento.ToDecimalSecure();
            resultado.MontoEscala = respuestaProl.montoEscala.ToDecimalSecure();
            resultado.MontoTotalProl = respuestaProl.montototal.ToDecimalSecure();
            resultado.MontoTotal = listPedidoWebDetalle.Sum(pd => pd.ImporteTotal) - resultado.MontoDescuento;
            resultado.UnidadesAgregadas = listPedidoWebDetalle.Sum(pd => pd.Cantidad);
            resultado.CodigoMensaje = respuestaProl.codigoMensaje;

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

            bool reservo = respuestaProl.ListaObservaciones.All(o => o.cod_observacion == "00");
            resultado.Restrictivas = respuestaProl.ListaObservaciones.Any();
            resultado.Reserva = input.FechaHoraReserva && reservo;
            resultado.ResultadoReservaEnum = respuestaProl.codigoMensaje.Equals("00") ? Enumeradores.ResultadoReserva.Reservado :
                reservo ? Enumeradores.ResultadoReserva.ReservadoObservaciones :
                codNoReservaPedido == "XXXXX" ? Enumeradores.ResultadoReserva.NoReservadoMontoMinimo :
                codNoReservaPedido == "YYYYY" ? Enumeradores.ResultadoReserva.NoReservadoMontoMaximo :
                Enumeradores.ResultadoReserva.NoReservadoObservaciones;
            
            return resultado;
        }

        private RespuestaProl ConsumirServicioProl(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            string listaProductos = string.Join("|", listPedidoWebDetalle.Select(x => x.CUV).ToArray());
            string listaCantidades = string.Join("|", listPedidoWebDetalle.Select(x => x.Cantidad).ToArray());
            string listaRecuperacion = string.Join("|", listPedidoWebDetalle.Select(x => Convert.ToInt32(x.AceptoBackOrder)).ToArray());

            RespuestaProl respuestaProl;
            using (var sv = new ServiceStockSsic())
            {
                sv.Url = ConfigurationManager.AppSettings["Prol_" + input.PaisISO];
                if (input.FechaHoraReserva) respuestaProl = sv.wsValidacionInteractiva(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, input.MontoMinimo, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos, input.SegmentoInternoID.ToString());
                else respuestaProl = sv.wsValidacionEstrategia(listaProductos, listaCantidades, listaRecuperacion, input.CodigoConsultora, input.MontoMinimo, input.CodigoZona, input.PaisISO, input.CampaniaID.ToString(), input.ConsultoraNueva, input.MontoMaximo, input.CodigosConcursos);
            }
            if (respuestaProl.codigoMensaje.Equals("00")) respuestaProl.ListaObservaciones = new ObservacionProl[0];
            else respuestaProl.ListaObservaciones = respuestaProl.ListaObservaciones ?? new ObservacionProl[0];

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
