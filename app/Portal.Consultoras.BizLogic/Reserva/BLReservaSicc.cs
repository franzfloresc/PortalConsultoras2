using Microsoft.Practices.EnterpriseLibrary.Common.Utility;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ReservaProl;
using System;
using System.Collections.Generic;
using System.Linq;
using ServSicc = Portal.Consultoras.Data.ServiceSicc;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaSicc : IReservaExternaBL
    {
        private readonly RestClient restClient;
        ITablaLogicaDatosBusinessLogic blTablaLogicaDatos;

        public BLReservaSicc()
        {
            restClient = new RestClient();
            blTablaLogicaDatos = new BLTablaLogicaDatos();
        }

        public BEResultadoReservaProl ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var resultado = new BEResultadoReservaProl();
            if (listPedidoWebDetalle.Count == 0) return resultado;

            ServSicc.Pedido respuestaSicc = ConsumirServicioSicc(input, listPedidoWebDetalle);
            if (respuestaSicc == null) return resultado;

            var listDetExp = NewListPedidoWebDetalleExplotado(input, respuestaSicc.posiciones);
            GuardarExplotado(input, GetExplotadoSinKitNueva(listDetExp, listPedidoWebDetalle));

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

            var listMensajeObs = blTablaLogicaDatos.GetTablaLogicaDatosCache(input.PaisID, Constantes.TablaLogica.ProlObsCod);
            var pedidoObservacion = CreatePedidoObservacion(input, respuestaSicc, listMensajeObs);
            if (pedidoObservacion != null) resultado.ListPedidoObservacion.Add(pedidoObservacion);
            
            foreach (var detExp in listDetExp)
            {
                if (detExp.IndRecuperacion) resultado.ListDetalleBackOrder.AddRange(listPedidoWebDetalle.Where(d => d.CUV == detExp.CUV));
                else
                {
                    var listpedidoObservacion = CreateListPedidoObservacion(detExp, listDetExp, listMensajeObs);
                    if (listpedidoObservacion != null) resultado.ListPedidoObservacion.AddRange(listpedidoObservacion);
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

        private List<BEPedidoWebDetalleExplotado> GetExplotadoSinKitNueva(List<BEPedidoWebDetalleExplotado> listDetalleExp, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var detKitNueva = listPedidoWebDetalle.FirstOrDefault(det => det.EsKitNueva);
            if (detKitNueva == null) return listDetalleExp;
            
            //NUNCA DEBERÍA RETORNAR NULL, YA  QUE EL EXPLOTADO SIEMPRE DEVUELVE EL DETALLE MÁS OTROS PRODUCTOS
            var detExpKit = listDetalleExp.First(detExp => detExp.CUV == detKitNueva.CUV);

            Func<BEPedidoWebDetalleExplotado, bool> fnEsKit, fnEsKitHijo;
            fnEsKit = (detExp => detExp.CUV == detKitNueva.CUV);
            fnEsKitHijo = (detExp => detExp.IdOferta == detExpKit.IdOferta && detExp.UnidadesDemandadas == 0);

            if (detExpKit.IdOferta == 0) return listDetalleExp.Where(detExp => !fnEsKit(detExp)).ToList();
            return listDetalleExp.Where(detExp => !(fnEsKit(detExp) || fnEsKitHijo(detExp))).ToList();
        }

        private BEPedidoObservacion CreatePedidoObservacion(BEInputReservaProl input, ServSicc.Pedido respuestaSicc, List<BETablaLogicaDatos> listMensajeObs)
        {
            var dictToken = new Dictionary<string, string>();
            string descKey, cuv;

            if (respuestaSicc.indDeuda == "1")
            {
                cuv = Constantes.ProlCodigoRechazo.Deuda;
                descKey = Constantes.ProlObsCod.Deuda;
                dictToken.Add(Constantes.ProlObsToken.DeudaMonto, Util.DecimalToStringFormat(respuestaSicc.montoDeuda.ToDecimalSecure(), input.PaisISO));
            }
            else if (respuestaSicc.estadoPedidoMontoMaximo == "1")
            {
                cuv = Constantes.ProlCodigoRechazo.MontoMaximo;
                descKey = Constantes.ProlObsCod.MontoMaximo;
                dictToken.Add(Constantes.ProlObsToken.MaximoMonto, Util.DecimalToStringFormat(input.MontoMaximo, input.PaisISO));
            }
            else if (respuestaSicc.estadoPedidoMontoMinimo == "1")
            {
                cuv = Constantes.ProlCodigoRechazo.MontoMinimo;
                descKey = input.FechaHoraReserva ? Constantes.ProlObsCod.MontoMinimoFact : Constantes.ProlObsCod.MontoMinimoVenta;
                dictToken.Add(Constantes.ProlObsToken.MinimoMonto, Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO));
            }
            else return null;

            dictToken.Add(Constantes.ProlObsToken.Simbolo, input.Simbolo);
            return new BEPedidoObservacion(95, cuv, ReplaceTokens(listMensajeObs, descKey, dictToken));
        }

        private List<BEPedidoObservacion> CreateListPedidoObservacion(BEPedidoWebDetalleExplotado detalle, List<BEPedidoWebDetalleExplotado> listDetalle, List<BETablaLogicaDatos> listMensajeObs)
        {
            if (detalle.Observaciones != Constantes.ProlSiccObs.Promocion && detalle.PrecioUnitario == 0) return null;

            List<string> listCuvPadre = null;
            bool esHijo = detalle.UnidadesDemandadas == 0;
            if (esHijo)
            {
                listCuvPadre = listDetalle.Where(d => d.IdOferta == detalle.IdOferta && d.UnidadesDemandadas > 0).Select(d => d.CUV).ToList();
                if (!listCuvPadre.Any()) return null;
            }

            var dictToken = new Dictionary<string, string>();
            int caso;
            string descKey;

            if (detalle.IndLimiteVenta)
            {
                descKey = detalle.UnidadesPorAtender == 0 ? Constantes.ProlObsCod.LimiteVenta0 : Constantes.ProlObsCod.LimiteVenta;
                caso = detalle.UnidadesPorAtender == 0 ? 5 : 4;
                dictToken.Add(Constantes.ProlObsToken.LimiteVenta, detalle.UnidadesPorAtender.ToString());                
            }
            else if (detalle.Observaciones == Constantes.ProlSiccObs.Promocion)
            {
                if (esHijo) return null;
                
                descKey = detalle.IdEstrategia == 2003 ? Constantes.ProlObsCod.Promocion2003 : Constantes.ProlObsCod.Promocion;
                caso = detalle.IdEstrategia == 2003 ? 1 : 7;
            }
            else if (detalle.IdSubTipoPosicion == 2030)
            {
                var reemplazo = listDetalle.FirstOrDefault(d => d.IdSubTipoPosicion == 2029 && d.ValCodiOrig == detalle.CUV);
                if (reemplazo == null) return null;

                descKey = Constantes.ProlObsCod.Reemplazo;
                caso = 0;
                dictToken.Add(Constantes.ProlObsToken.ReemplazoCuv, reemplazo.CUV);
                //AGREGAR DESCRIPCION DE REEMPLAZO EN DATABASE
                dictToken.Add(Constantes.ProlObsToken.ReemplazoDesc, "");
            }
            else if (detalle.UnidadesReservadasSap < detalle.UnidadesPorAtender)
            {
                descKey = detalle.UnidadesReservadasSap == 0 ? Constantes.ProlObsCod.SinStock0 : Constantes.ProlObsCod.SinStock;
                //VALIDAR PROMOCION (CASO 0)
                caso = detalle.UnidadesReservadasSap == 0 ? 5 : 6;
                dictToken.Add(Constantes.ProlObsToken.Stock, detalle.UnidadesReservadasSap.ToString());
            }
            else return null;

            dictToken.Add(Constantes.ProlObsToken.DetalleCuv, detalle.CUV);
            var pedidoObservacion = new BEPedidoObservacion(caso, ReplaceTokens(listMensajeObs, descKey, dictToken));

            if (esHijo) return CreateListPedidoObservacionHijo(pedidoObservacion, listCuvPadre);
            return CreateListPedidoObservacionPadre(pedidoObservacion, detalle);
        }

        private List<BEPedidoObservacion> CreateListPedidoObservacionHijo(BEPedidoObservacion pedidoObservacion, List<string> listCuvPadre)
        {
            return listCuvPadre.Select(cuv => new BEPedidoObservacion(0, cuv, pedidoObservacion.Descripcion)).ToList();
        }

        private List<BEPedidoObservacion> CreateListPedidoObservacionPadre(BEPedidoObservacion pedidoObservacion, BEPedidoWebDetalleExplotado detalle)
        {
            pedidoObservacion.Tipo = 2;
            pedidoObservacion.CUV = detalle.CUV;
            return new List<BEPedidoObservacion>{ pedidoObservacion };
        }

        private string ReplaceTokens(List<BETablaLogicaDatos> listMensajeObs, string mensajeObsCod, Dictionary<string, string> dictToken)
        {
            var mensajeObs = listMensajeObs.FirstOrDefault(mo => mo.Codigo == mensajeObsCod);
            var mensaje = mensajeObs == null ? "" : (mensajeObs.Descripcion ?? "");
            
            dictToken.ForEach(entry => mensaje = mensaje.Replace(entry.Key, entry.Value));
            return mensaje;
        }
    }
}
