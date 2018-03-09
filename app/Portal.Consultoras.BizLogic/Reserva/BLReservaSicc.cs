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

            //¿8SE DEBE ENVIAR KIT DE NUEVAS?
            //==================================================================
            //==================================================================
            ServSicc.Pedido respuestaSicc = ConsumirServicioSicc(input, listPedidoWebDetalle);
            if (respuestaSicc == null) return resultado;

            var listDetExp = NewListPedidoWebDetalleExplotado(input, respuestaSicc.posiciones);
            GuardarExplotado(input, listDetExp);
            var listMensajeProl = new Dictionary<string, string> {
                { Constantes.ProlObsCod.Deuda, "Su pedido no pasa por tener una deuda de {0}."},
                { Constantes.ProlObsCod.MontoMaximo, "Su pedido no pasa por sobrepasar el monto máximo."},
                { Constantes.ProlObsCod.MontoMinimo, "Su pedido no pasa por no superar el monto mínimo."},
                { Constantes.ProlObsCod.LimiteVenta0, "El producto {0} está agotado."},
                { Constantes.ProlObsCod.LimiteVenta, "El producto {0} sobrepasa el límite de venta {1}."},
                { Constantes.ProlObsCod.LimiteVenta0Pack, "El producto {0} del pack {2} está agotado."},
                { Constantes.ProlObsCod.LimiteVentaPack, "El producto {0} del pack {2} sobrepasa el límite de venta {1}."},
                { Constantes.ProlObsCod.LimiteVentaPack, "El producto {0} del pack {2} sobrepasa el límite de venta {1}."},
                { Constantes.ProlObsCod.Promocion0, "El producto {0} no cumple con la promoción del catálogo." },
                { Constantes.ProlObsCod.Promocion, "{1} producto(s) {0} no cumple(n) con la promoción del catálogo." },
                { Constantes.ProlObsCod.Reemplazo, "El producto {0} ha sido reemplazado por el producto {1}." },
                { Constantes.ProlObsCod.ReemplazoPack, "El producto {0} del pack {2} ha sido reemplazado por el producto {1}." },
                { Constantes.ProlObsCod.SinStock0, "El producto {0} no tiene stock." },
                { Constantes.ProlObsCod.SinStock, "El producto {0} sólo tiene {1} en stock." },
                { Constantes.ProlObsCod.SinStock0Pack, "El producto {0} del pack {2} no tiene stock." },
                { Constantes.ProlObsCod.SinStockPack, "El producto {0} del pack {2} sólo tiene {1} en stock." }
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
            foreach (var detExp in listDetExp)
            {
                if (detExp.IndRecuperacion) resultado.ListDetalleBackOrder.AddRange(listPedidoWebDetalle.Where(d => d.CUV == detExp.CUV));
                else
                {
                    var pedidoObservacion = CreatePedidoObservacion(detExp, listDetExp, listPedidoWebDetalle, listMensajeProl);
                    if (pedidoObservacion != null) resultado.ListPedidoObservacion.Add(pedidoObservacion);
                }
            }

            bool reservo = !resultado.ListDetalleBackOrder.Any() && resultado.ListPedidoObservacion.All(o => o.Caso == 0);
            resultado.Restrictivas = resultado.ListDetalleBackOrder.Any() || resultado.ListPedidoObservacion.Any();
            resultado.Reserva = input.FechaHoraReserva && reservo;
            resultado.ResultadoReservaEnum = respuestaSicc.indDeuda == "1" ? Enumeradores.ResultadoReserva.NoReservadoDeuda :
                respuestaSicc.estadoPedidoMontoMinimo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMinimo :
                respuestaSicc.estadoPedidoMontoMaximo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMaximo :
                !resultado.Restrictivas ? Enumeradores.ResultadoReserva.Reservado :
                reservo ? Enumeradores.ResultadoReserva.ReservadoObservaciones :
                Enumeradores.ResultadoReserva.NoReservadoObservaciones;

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

        private List<BEPedidoWebDetalleExplotado> NewListPedidoWebDetalleExplotado(BEInputReservaProl input, ServSicc.Detalle[] arrayDetalle)
        {
            return arrayDetalle.Select(d => new BEPedidoWebDetalleExplotado
            {
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
                Observaciones = d.observaciones,
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
                ValCodiOrig = d.valCodiOrig,
                OportunidadAhorro = d.oportunidadAhorro.ToDecimalSecure(),
                UnidadesReservadasSap = d.unidadesReservadasSap.ToInt32Secure()
            }).ToList();
        }

        private void GuardarExplotado(BEInputReservaProl input, List<BEPedidoWebDetalleExplotado> listDetalleExp)
        {
            var daPedidoWebDetalleExplotado = new DAPedidoWebDetalleExplotado(input.PaisID);
            daPedidoWebDetalleExplotado.DeleteByPedidoID(input.CampaniaID, input.PedidoID);
            daPedidoWebDetalleExplotado.InsertList(listDetalleExp);
        }

        private BEPedidoObservacion CreatePedidoObservacion(BEPedidoWebDetalleExplotado detalle, List<BEPedidoWebDetalleExplotado> listDetalle, List<BEPedidoWebDetalle> listPedidoWebDetalle, Dictionary<string, string> listMensajeProl)
        {
            if (detalle.PrecioUnitario == 0) return null;

            //¿PUEDE TENER MÁS DE UN PADRE?
            BEPedidoWebDetalleExplotado padre = null, reemplazo = null;
            bool esHijo = detalle.UnidadesDemandadas == 0;
            if (esHijo) padre = listDetalle.FirstOrDefault(d => d.IdOferta == detalle.IdOferta && d.UnidadesDemandadas > 0);
            if (esHijo && padre == null) return null; //Gratis o ¿posiblemente Kit de Nuevas?;

            //¿DEBO RECONOCER EL KIT DE NUEVAS?
            //===========================================
            //===========================================
            var pedidoObservacion = new BEPedidoObservacion();
            if (detalle.IndLimiteVenta)
            {
                pedidoObservacion.Caso = 0; //04 o 05, dependiendo de si unidadesPorAtender == 0
                pedidoObservacion.Descripcion = esHijo ?
                    (detalle.UnidadesPorAtender == 0 ? Constantes.ProlObsCod.LimiteVenta0Pack : Constantes.ProlObsCod.LimiteVentaPack) :
                    (detalle.UnidadesPorAtender == 0 ? Constantes.ProlObsCod.LimiteVenta0 : Constantes.ProlObsCod.LimiteVenta);
                pedidoObservacion.Descripcion = string.Format(pedidoObservacion.Descripcion, detalle.CUV, detalle.UnidadesPorAtender, esHijo ? padre.CUV : "");
            }
            else if (detalle.Observaciones == "PROMOCION NO CUMPLE")
            {
                if (esHijo) return null;

                pedidoObservacion.Caso = 0;
                pedidoObservacion.Descripcion = detalle.UnidadesPorAtender == 0 ? Constantes.ProlObsCod.Promocion0 : Constantes.ProlObsCod.Promocion;
                pedidoObservacion.Descripcion = string.Format(pedidoObservacion.Descripcion, detalle.CUV, detalle.UnidadesDemandadas - detalle.UnidadesPorAtender);
            }
            else if (detalle.IdSubTipoPosicion == 2030)
            {
                //VALIDAR SI EL CAMPO ValCodiOrig PERTENECE AL PADRE
                reemplazo = listDetalle.FirstOrDefault(d => d.IdSubTipoPosicion == 2029 && d.ValCodiOrig == detalle.CUV);
                if (reemplazo == null) return null;

                pedidoObservacion.Caso = 0;
                pedidoObservacion.Descripcion = esHijo ? Constantes.ProlObsCod.ReemplazoPack : Constantes.ProlObsCod.Reemplazo;
                pedidoObservacion.Descripcion = string.Format(Constantes.ProlObsCod.Reemplazo, detalle.CUV, reemplazo.CUV, esHijo ? padre.CUV : "");
            }
            else if (detalle.UnidadesReservadasSap < detalle.UnidadesPorAtender)
            {
                pedidoObservacion.Caso = 0;
                pedidoObservacion.Descripcion = esHijo ?
                    (detalle.UnidadesReservadasSap == 0 ? Constantes.ProlObsCod.SinStock0Pack : Constantes.ProlObsCod.SinStockPack) :
                    (detalle.UnidadesReservadasSap == 0 ? Constantes.ProlObsCod.SinStock0 : Constantes.ProlObsCod.SinStock);
                pedidoObservacion.Descripcion = string.Format(pedidoObservacion.Descripcion, detalle.CUV, detalle.UnidadesReservadasSap, esHijo ? padre.CUV : "");
            }
            else return null;
            
            pedidoObservacion.CUV = esHijo ? padre.CUV : detalle.CUV;
            pedidoObservacion.Tipo = 2;
            return pedidoObservacion;
        }
    }
}
