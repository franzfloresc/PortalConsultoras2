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
        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (listPedidoWebDetalle.Count == 0) return resultado;

            var listCuponNueva = new List<BECuponNueva>();

            var inputPedido = new Data.ServiceSicc.Pedido
            {
                codigoPais = Util.GetPaisIsoSicc(input.PaisID), //?
                codigoPeriodo = input.CampaniaID.ToString(),
                codigoCliente = input.CodigoConsultora,
                montoPedMontoMax = input.MontoMaximo.ToString(),
                montoPedMontoMin = input.MontoMinimo.ToString(),
                indValiProl = input.FechaHoraReserva ? "1" : "0",  //?
                indEnvioSap = "0",
                posiciones = listPedidoWebDetalle.Select(d => new Detalle { CUV = d.CUV, unidadesDemandadas = d.Cantidad.ToString() }).ToArray()
            };
            foreach (var detalle in inputPedido.posiciones)
            {
                var cuponNueva = listCuponNueva.FirstOrDefault(c => c.CodigoCupon == detalle.CUV);
                if (cuponNueva != null) detalle.CUV = cuponNueva.CUV;
            }
            //¿Que pasa si el CUV de cuponNueva ya existe en el detalle?
            //Como hacer que los CUV devueltos por el servicio vuelvan a CodigoCupon, si habia ya un detalle con el mismo CUV de cuponNueva. 

            Data.ServiceSicc.Pedido outputPedido;
            using (var sv = new ServiceClient())
            {             
                outputPedido = sv.EjecutarCuadreOfertas(inputPedido);
            }
            if (outputPedido == null) return resultado;

            foreach (var detalle in outputPedido.posiciones)
            {
                var cuponNueva = listCuponNueva.FirstOrDefault(c => c.CUV == detalle.CUV);
                if (cuponNueva != null) detalle.CUV = cuponNueva.CodigoCupon;
            }

            //outputPedido.estadoPedMontoMax;
            //outputPedido.estadoPedMontoMax;
            //outputPedido.posiciones[0].

            return resultado;
        }
    }
}
