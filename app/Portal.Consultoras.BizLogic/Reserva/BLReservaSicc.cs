using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServiceSicc;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaSicc : IReservaExternaBL
    {
        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (listPedidoWebDetalle.Count == 0) return resultado;

            PedidoConsolidadoWebService respuestaSicc = ConsumirServicioSicc(input, listPedidoWebDetalle);
            if (respuestaSicc == null) return resultado;

            GuardarExplotado(input, respuestaSicc.posiciones);
            var listMensajeProl = new Dictionary<string, string>();

            //resultado.MontoAhorroCatalogo = NO HAY
            //resultado.MontoAhorroRevista = NO HAY
            resultado.MontoGanancia =  respuestaSicc.posiciones.Sum(p => p.importeDescuento1.ToDecimalSecure());
            //resultado.MontoDescuento = FALTA
            resultado.MontoEscala = respuestaSicc.posiciones.Sum(p => p.escalaDescuento.ToDecimalSecure());
            //resultado.MontoTotalProl = SE DEBE DEJAR DE USAR
            resultado.MontoTotal = listPedidoWebDetalle.Sum(pd => pd.ImporteTotal) - resultado.MontoDescuento; // CANDIDATO A PASAR A BLRESERVA
            resultado.UnidadesAgregadas = listPedidoWebDetalle.Sum(pd => pd.Cantidad); // CANDIDATO A PASAR A BLRESERVA

            //if (respuestaProl.ListaConcursoIncentivos != null)
            //{
            //    resultado.ListaConcursosCodigos = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.codigoconcurso).ToArray());
            //    resultado.ListaConcursosPuntaje = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.puntajeconcurso.Split('|')[0]).ToArray());
            //    resultado.ListaConcursosPuntajeExigido = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => (i.puntajeconcurso.IndexOf('|') > -1 ? i.puntajeconcurso.Split('|')[1] : "0")).ToArray());
            //}

            if (respuestaSicc.estadoPedidoMontoMinimo == "1" || respuestaSicc.estadoPedidoMontoMaximo == "1")
            {
                bool esMin = respuestaSicc.estadoPedidoMontoMinimo == "1";
                resultado.ListPedidoObservacion.Add(new BEPedidoObservacion {
                    Caso = 95,
                    CUV = esMin ? Constantes.ProlCodigoRechazo.MontoMinimo : Constantes.ProlCodigoRechazo.MontoMaximo,
                    Tipo = 2,
                    Descripcion = Regex.Replace(listMensajeProl[esMin ? "montoMinimo" : "montoMaximo"], "(\\#.*\\#)", Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO))                    
                });
            }
            foreach (var p in respuestaSicc.posiciones)
            {
                if (p.indicadorRecuperacion == "1") resultado.ListDetalleBackOrder.AddRange(listPedidoWebDetalle.Where(d => d.CUV == p.cuv));
                else if(!string.IsNullOrEmpty(p.observaciones)) resultado.ListPedidoObservacion.Add(CreatePedidoObservacion(p, listPedidoWebDetalle, listMensajeProl));
            }

            bool reservo = !TieneObservacionesBloqueantes(resultado.ListPedidoObservacion);
            //FALTA DEUDA, CONFIRMAR CON LEO
            resultado.ResultadoReservaEnum = !resultado.ListPedidoObservacion.Any() ? Enumeradores.ResultadoReserva.Reservado :
                reservo ? Enumeradores.ResultadoReserva.ReservadoObservaciones :
                respuestaSicc.estadoPedidoMontoMinimo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMinimo :
                respuestaSicc.estadoPedidoMontoMaximo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMaximo :
                Enumeradores.ResultadoReserva.NoReservadoObservaciones;

            resultado.Reserva = input.FechaHoraReserva && reservo;
            resultado.Restrictivas = resultado.ResultadoReservaEnum != Enumeradores.ResultadoReserva.Reservado;
            resultado.CodigoMensaje = resultado.ResultadoReservaEnum == Enumeradores.ResultadoReserva.Reservado ? "00" : "01";

            return resultado;
        }

        private PedidoConsolidadoWebService ConsumirServicioSicc(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var inputPedido = new PedidoConsolidadoWebService
            {
                codigoPais = Util.GetPaisIsoSicc(input.PaisID),
                codigoPeriodo = input.CampaniaID.ToString(),
                codigoCliente = input.CodigoConsultora,
                //FALTA CODIGO CONCURSOS
                indValiProl = input.FechaHoraReserva ? "1" : "0",  //FECHA RESERVA O FACTURACION?
                posiciones = listPedidoWebDetalle.Select(d => new PosicionConsolidadoWebService
                {
                    cuv = d.CUV,
                    unidadesDemandadas = d.Cantidad.ToString()
                }).ToArray()
            };

            //var listCuponNueva = new List<BECuponNueva>();
            //foreach (var detalle in inputPedido.posiciones)
            //{
            //    var cuponNueva = listCuponNueva.FirstOrDefault(c => c.CodigoCupon == detalle.cuv);
            //    if (cuponNueva != null) detalle.cuv = cuponNueva.CUV;
            //}

            PedidoConsolidadoWebService respuestaSicc;
            using (var sv = new ProcesoPEDCuadreOfertasConsolidadoWebServiceImplClient())
            {
                respuestaSicc = sv.executeCuadreOfertasConsolidado(inputPedido);
            }

            //if(respuestaSicc != null && respuestaSicc.posiciones != null)
            //{
            //    foreach (var detalle in respuestaSicc.posiciones)
            //    {
            //        var cuponNueva = listCuponNueva.FirstOrDefault(c => c.CUV == detalle.cuv);
            //        if (cuponNueva != null) detalle.cuv = cuponNueva.CodigoCupon;
            //    }
            //}
            return respuestaSicc;
        }

        private void GuardarExplotado(BEInputReservaProl input, PosicionConsolidadoWebService[] arrayDetalle)
        {
            var daPedidoWebDetalleExplotado = new DAPedidoWebDetalleExplotado(input.PaisID);
            daPedidoWebDetalleExplotado.DeleteByPedidoID(input.CampaniaID, input.PedidoID);
            daPedidoWebDetalleExplotado.InsertList(arrayDetalle.Select(d => new DEPedidoWebDetalleExplotado {
                CampaniaID = input.CampaniaID,
                PedidoID = input.PedidoID,
                CodigoSap = d.codigoSap,
                CUV = d.cuv,
                EscalaDescuento = d.escalaDescuento.ToNullableDecimalSecure(),
                FactorCuadre = d.factorCuadre.ToNullableDecimalSecure(),
                FactorRepeticion = d.factorRepeticion.ToInt32Secure(),
                GrupoDescuento = d.grupoDescuento,
                ImporteDescuento1 = d.importeDescuento1.ToNullableDecimalSecure(),
                ImporteDescuento2 = d.importeDescuento2.ToNullableDecimalSecure(),
                IndAccion = d.indAccion == "1",
                IndLimiteVenta = d.indLimiteVenta == "1",
                IndRecuperacion = d.indicadorRecuperacion == "1",
                NumUnidOrig = d.numUnidOrig.ToNullableInt32Secure(),
                NumSeccionDetalle = d.numeroSeccionDetalle.ToNullableInt32Secure(),
                Observaciones= d.observaciones,
                IdCatalogo = d.oidCatalogo.ToInt32Secure(),
                IdDetaOferta = d.oidDetaOferta.ToInt32Secure(),
                IdEstrategia = d.oidEstrategia.ToInt32Secure(),
                IdFormaPago = d.oidFormaPago.ToNullableInt32Secure(),
                IdGrupoOferta = d.oidGrupoOferta.ToNullableInt32Secure(),
                IdIndicadorCuadre = d.oidIndicadorCuadre.ToNullableInt32Secure(),
                IdNiveOferta = d.oidNiveOferta.ToNullableInt32Secure(),
                IdNiveOfertaGratis = d.oidNiveOfertaGratis.ToNullableInt32Secure(),
                IdNiveOfertaRango = d.oidNiveOfertaRango.ToNullableInt32Secure(),
                IdOferta = d.oidOferta.ToNullableInt32Secure(),
                IdPosicion = d.oidPosicion.ToNullableInt32Secure(),
                IdProducto = d.oidProducto.ToInt32Secure(),
                IdSubTipoPosicion = d.oidSubtipoPosicion.ToNullableInt32Secure(),
                IdTipoPosicion = d.oidTipoPosicion.ToNullableInt32Secure(),
                Pagina = d.pagina.ToInt32Secure(),
                PorcentajeDescuento = d.porcentajeDescuento.ToNullableDecimalSecure(),
                PrecioCatalogo = d.precioCatalogo.ToNullableDecimalSecure(),
                PrecioContable = d.precioContable.ToNullableDecimalSecure(),
                PrecioPublico = d.precioPublico.ToNullableDecimalSecure(),
                PrecioUnitario = d.precioUnitario.ToNullableDecimalSecure(),
                Ranking = d.ranking,
                UnidadesDemandadas = d.unidadesDemandadas.ToInt32Secure(),
                UnidadesPorAtender = d.unidadesPorAtender.ToInt32Secure(),
                ValCodiOrig = d.valCodiOrig

            }).ToList());
        }

        private BEPedidoObservacion CreatePedidoObservacion(PosicionConsolidadoWebService detalle, List<BEPedidoWebDetalle> listPedidoWebDetalle, Dictionary<string, string> listMensajeProl)
        {
            return new BEPedidoObservacion();
        }

        private bool TieneObservacionesBloqueantes(List<BEPedidoObservacion> listObservaciones)
        {
            //Saber si es reservado:
            //Reemplazo
            //Pack con producto agotado

            return true;
        }
    }
}
