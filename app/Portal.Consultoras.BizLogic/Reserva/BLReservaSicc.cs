using Portal.Consultoras.Common;
using Portal.Consultoras.Data.ServiceSicc;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaSicc : IReservaExternaBL
    {
        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (olstPedidoWebDetalle.Count == 0) return resultado;

            var inputPedido = new Data.ServiceSicc.Pedido
            {
                codigoPais = Util.GetPaisIsoSicc(input.PaisID), //?
                codigoPeriodo = input.CampaniaID.ToString(),
                codigoCliente = input.CodigoConsultora,
                montoPedMontoMax = input.MontoMaximo.ToString(),
                montoPedMontoMin = input.MontoMinimo.ToString(),
                indValiProl = input.FechaHoraReserva ? "1" : "0",  //?
                indEnvioSap = "0",
                posiciones = olstPedidoWebDetalle.Select(d => new Detalle { CUV = d.CUV, unidadesDemandadas = d.Cantidad.ToString() }).ToArray()
            };

            Data.ServiceSicc.Pedido outputPedido;
            using (var sv = new ServiceClient())
            {             
                outputPedido = sv.EjecutarCuadreOfertas(inputPedido);
            }
            if (outputPedido == null) return resultado;

            //outputPedido.estadoPedMontoMax;
            //outputPedido.estadoPedMontoMax;
            //outputPedido.posiciones[0].

            return resultado;
        }
    }
}
