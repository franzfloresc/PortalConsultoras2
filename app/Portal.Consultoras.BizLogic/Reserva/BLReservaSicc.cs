using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using ServSicc = Portal.Consultoras.Data.ServiceSicc;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaSicc : IReservaExternaBL
    {
        private readonly RestClient restClient = new RestClient();

        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (listPedidoWebDetalle.Count == 0) return resultado;

            ServSicc.Pedido respuestaSicc = ConsumirServicioSicc(input, listPedidoWebDetalle);
            if (respuestaSicc == null) return resultado;

            GuardarExplotado(input, respuestaSicc.posiciones);
            var listMensajeProl = new Dictionary<string, string> {
                { Constantes.ProlObsCod.Deuda, "Su pedido no pasa por tener una deuda de {0}."},
                { Constantes.ProlObsCod.MontoMaximo, "Su pedido no pasa por sobrepasar el monto máximo."},
                { Constantes.ProlObsCod.MontoMinimo, "Su pedido no pasa por no superar el monto mínimo."},
                { Constantes.ProlObsCod.LimiteVentaPack, "El producto {0} del pack {2} sobrepasa el límite de venta {1}."}, //Limite venta > 0
                { Constantes.ProlObsCod.LimiteVenta0, "El producto {0} está agotado."}, //Limite venta = 0
                { Constantes.ProlObsCod.LimiteVenta, "El producto {0} sobrepasa el límite de venta {1}."}, //Limite venta > 0
                { Constantes.ProlObsCod.LimiteVenta0Pack, "El producto {0} del pack {2} está agotado."}, //Limite venta = 0
                { Constantes.ProlObsCod.LimiteVentaPack, "El producto {0} del pack {2} sobrepasa el límite de venta {1}."}, //Limite venta > 0
                { Constantes.ProlObsCod.Promocion0, "El producto {0} no cumple con la promoción del catálogo." },
                { Constantes.ProlObsCod.Promocion, "{1} producto(s) {0} no cumple(n) con la promoción del catálogo." }, //Falta cantidad que no cumple
                { Constantes.ProlObsCod.Reemplazo, "El producto {0} ha sido reemplazado por el producto {1}." },
                { Constantes.ProlObsCod.SinStock, "El producto {0} no tiene stock." }
            };

            resultado.MontoTotalProl = respuestaSicc.montoPedidoMontoMaximo.ToDecimalSecure(); //montoPedidoMontoMinimo devuelve lo mismo.
            resultado.MontoDescuento = respuestaSicc.montoTotalDcto.ToDecimalSecure();
            resultado.MontoAhorroCatalogo = respuestaSicc.montoTotalOporAhorro.ToDecimalSecure();
            resultado.MontoAhorroRevista = 0;
            resultado.MontoEscala = respuestaSicc.montoBaseDcto.ToDecimalSecure();

            //if (respuestaProl.ListaConcursoIncentivos != null)
            //{
            //    resultado.ListaConcursosCodigos = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.codigoconcurso).ToArray());
            //    resultado.ListaConcursosPuntaje = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => i.puntajeconcurso.Split('|')[0]).ToArray());
            //    resultado.ListaConcursosPuntajeExigido = string.Join("|", respuestaProl.ListaConcursoIncentivos.Select(i => (i.puntajeconcurso.IndexOf('|') > -1 ? i.puntajeconcurso.Split('|')[1] : "0")).ToArray());
            //}

            //REVISAR LAS CONSECUENCIAS DE MANDAR "ZZZZZ" a la capa web
            if (respuestaSicc.indDeuda == "1")
            {
                resultado.ListPedidoObservacion.Add(new BEPedidoObservacion
                {
                    Caso = 95,
                    CUV = Constantes.ProlCodigoRechazo.Deuda,
                    Tipo = 2,
                    Descripcion = string.Format(listMensajeProl[Constantes.ProlObsCod.Deuda], respuestaSicc.montoDeuda.ToDecimalSecure())
                });
            }
            else if (respuestaSicc.estadoPedidoMontoMinimo == "1" || respuestaSicc.estadoPedidoMontoMaximo == "1")
            {
                bool esMin = respuestaSicc.estadoPedidoMontoMinimo == "1";
                resultado.ListPedidoObservacion.Add(new BEPedidoObservacion
                {
                    Caso = 95,
                    CUV = esMin ? Constantes.ProlCodigoRechazo.MontoMinimo : Constantes.ProlCodigoRechazo.MontoMaximo,
                    Tipo = 2,
                    Descripcion = Regex.Replace(
                        listMensajeProl[esMin ? Constantes.ProlObsCod.MontoMinimo : Constantes.ProlObsCod.MontoMaximo],
                        "(\\#.*\\#)",
                        Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO)
                    )
                });
            }
            foreach (var p in respuestaSicc.posiciones)
            {
                if (p.indicadorRecuperacion == "1") resultado.ListDetalleBackOrder.AddRange(listPedidoWebDetalle.Where(d => d.CUV == p.CUV));
                else
                {
                    var pedidoObservacion = CreatePedidoObservacion(p, respuestaSicc.posiciones, listPedidoWebDetalle, listMensajeProl);
                    if (pedidoObservacion != null) resultado.ListPedidoObservacion.Add(pedidoObservacion);
                }
            }

            bool reservo = !TieneObservacionesBloqueantes(resultado.ListPedidoObservacion);
            resultado.ResultadoReservaEnum = respuestaSicc.indDeuda == "1" ? Enumeradores.ResultadoReserva.NoReservadoDeuda :
                respuestaSicc.estadoPedidoMontoMinimo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMinimo :
                respuestaSicc.estadoPedidoMontoMaximo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMaximo :
                !resultado.ListPedidoObservacion.Any() ? Enumeradores.ResultadoReserva.Reservado :
                reservo ? Enumeradores.ResultadoReserva.ReservadoObservaciones :
                Enumeradores.ResultadoReserva.NoReservadoObservaciones;

            resultado.Reserva = input.FechaHoraReserva && reservo;
            resultado.Restrictivas = resultado.ResultadoReservaEnum != Enumeradores.ResultadoReserva.Reservado;
            resultado.CodigoMensaje = resultado.ResultadoReservaEnum == Enumeradores.ResultadoReserva.Reservado ? "00" : "01";

            return resultado;
        }

        private ServSicc.Pedido ConsumirServicioSicc(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var inputPedido = new Data.ServiceSicc.Pedido
            {
                codigoPais = Util.GetPaisIsoSicc(input.PaisID),
                codigoPeriodo = input.CampaniaID.ToString(),
                codigoCliente = input.CodigoConsultora,
                indEnvioSap = input.FechaHoraReserva ? "1" : "0",
                indValiProl = "0",
                //FALTA CODIGO CONCURSOS
                posiciones = listPedidoWebDetalle.Select(d => new Data.ServiceSicc.Detalle
                {
                    CUV = d.CUV,
                    unidadesDemandadas = d.Cantidad.ToString()
                }).ToArray()
            };

            //var listCuponNueva = new List<BECuponNueva>();
            //foreach (var detalle in inputPedido.posiciones)
            //{
            //    var cuponNueva = listCuponNueva.FirstOrDefault(c => c.CodigoCupon == detalle.cuv);
            //    if (cuponNueva != null) detalle.cuv = cuponNueva.CUV;
            //}

            var respuestaSicc = restClient.PostAsync<Data.ServiceSicc.Pedido>("/Service.svc/EjecutarCuadreOfertas", inputPedido).Result;

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

        private void GuardarExplotado(BEInputReservaProl input, ServSicc.Detalle[] arrayDetalle)
        {
            var daPedidoWebDetalleExplotado = new DAPedidoWebDetalleExplotado(input.PaisID);
            daPedidoWebDetalleExplotado.DeleteByPedidoID(input.CampaniaID, input.PedidoID);
            daPedidoWebDetalleExplotado.InsertList(arrayDetalle.Select(d => new DEPedidoWebDetalleExplotado {
                CampaniaID = input.CampaniaID,
                PedidoID = input.PedidoID,
                CodigoSap = d.codigoSap,
                CUV = d.CUV,
                EscalaDescuento = d.escalaDescuento.ToDecimalSecure(),
                FactorCuadre = d.factorCuadre.ToDecimalSecure(),
                FactorRepeticion = d.factorRepeticion.ToInt32Secure(),
                GrupoDescuento = d.grupoDescuento,
                ImporteDescuento1 = d.importeDescuento1.ToDecimalSecure(),
                ImporteDescuento2 = d.importeDescuento2.ToDecimalSecure(),
                IndAccion = d.indAccion == "1",
                IndLimiteVenta = d.indLimiteVenta == "1",
                IndRecuperacion = d.indicadorRecuperacion == "1",
                NumUnidOrig = d.numUnidOrig.ToInt32Secure(),
                NumSeccionDetalle = d.numeroSeccionDetalle.ToInt32Secure(),
                Observaciones= d.observaciones,
                IdCatalogo = d.oidCatalogo.ToInt32Secure(),
                IdDetaOferta = d.oidDetaOferta.ToInt32Secure(),
                IdEstrategia = d.oidEstrategia.ToInt32Secure(),
                IdFormaPago = d.oidFormaPago.ToInt32Secure(),
                IdGrupoOferta = d.oidGrupoOferta.ToInt32Secure(),
                IdIndicadorCuadre = d.oidIndicadorCuadre.ToInt32Secure(),
                IdNiveOferta = d.oidNiveOferta.ToInt32Secure(),
                IdNiveOfertaGratis = d.oidNiveOfertaGratis.ToInt32Secure(),
                IdNiveOfertaRango = d.oidNiveOfertaRango.ToInt32Secure(),
                IdOferta = d.oidOferta.ToInt32Secure(),
                IdPosicion = d.oidPosicion.ToInt32Secure(),
                IdProducto = d.oidProducto.ToInt32Secure(),
                IdSubTipoPosicion = d.oidSubtipoPosicion.ToInt32Secure(),
                IdTipoPosicion = d.oidTipoPosicion.ToInt32Secure(),
                Pagina = d.pagina.ToInt32Secure(),
                PorcentajeDescuento = d.porcentajeDescuento.ToDecimalSecure(),
                PrecioCatalogo = d.precioCatalogo.ToDecimalSecure(),
                PrecioContable = d.precioContable.ToDecimalSecure(),
                PrecioPublico = d.precioPublico.ToDecimalSecure(),
                PrecioUnitario = d.precioUnitario.ToDecimalSecure(),
                Ranking = d.ranking,
                UnidadesDemandadas = d.unidadesDemandadas.ToInt32Secure(),
                UnidadesPorAtender = d.unidadesPorAtender.ToInt32Secure(),
                ValCodiOrig = d.valCodiOrig

            }).ToList());
        }

        private BEPedidoObservacion CreatePedidoObservacion(ServSicc.Detalle detalle, ServSicc.Detalle[] arrayDetalle, List<BEPedidoWebDetalle> listPedidoWebDetalle, Dictionary<string, string> listMensajeProl)
        {
            BEPedidoObservacion pedidoObservacion = null;
            int unidadesDemandadas = detalle.unidadesDemandadas.ToInt32Secure();
            int unidadesPorAtender = detalle.unidadesPorAtender.ToInt32Secure();
            int unidadesReservadasSap = detalle.unidadesReservadasSap.ToInt32Secure();

            if (detalle.indLimiteVenta == "1")
            {
                pedidoObservacion = new BEPedidoObservacion
                {
                    Caso = 0,
                    Descripcion = string.IsNullOrEmpty(detalle.valCodiOrig) ?
                        (unidadesDemandadas == 0 ? Constantes.ProlObsCod.LimiteVenta0 : Constantes.ProlObsCod.LimiteVenta) :
                        (unidadesPorAtender == 0 ? Constantes.ProlObsCod.LimiteVenta0Pack : Constantes.ProlObsCod.LimiteVentaPack)
                };
                pedidoObservacion.Descripcion = string.Format(pedidoObservacion.Descripcion, detalle.CUV, unidadesPorAtender, detalle.valCodiOrig);
            }
            else if (!string.IsNullOrEmpty(detalle.observaciones))
            {
                pedidoObservacion = new BEPedidoObservacion
                {
                    Caso = 0,
                    Descripcion = unidadesPorAtender == 0 ? Constantes.ProlObsCod.Promocion0 : Constantes.ProlObsCod.Promocion
                };
                pedidoObservacion.Descripcion = string.Format(pedidoObservacion.Descripcion, detalle.CUV, unidadesDemandadas - unidadesPorAtender);
            }
            else if(detalle.oidSubtipoPosicion == "2030")
            {
                var reemplazo = arrayDetalle.FirstOrDefault(d => d.oidSubtipoPosicion == "2029" && d.valCodiOrig == detalle.CUV);
                if(reemplazo != null)
                {
                    pedidoObservacion = new BEPedidoObservacion
                    {
                        Caso = 0,
                        Descripcion = string.Format(Constantes.ProlObsCod.Reemplazo, detalle.CUV)
                    };
                }
            }
            else if(unidadesReservadasSap == 0)
            {
                pedidoObservacion = new BEPedidoObservacion
                {
                    Caso = 0,
                    Descripcion = string.Format(Constantes.ProlObsCod.SinStock, detalle.CUV)
                };
            }

            if (pedidoObservacion != null)
            {
                pedidoObservacion.CUV = !string.IsNullOrEmpty(detalle.valCodiOrig) ? detalle.valCodiOrig : detalle.CUV;
                pedidoObservacion.Tipo = 2;
            }
            return pedidoObservacion;
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
