using Microsoft.Practices.EnterpriseLibrary.Common.Utility;
using Portal.Consultoras.BizLogic.Reserva.Rest;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Externos.ReservaSicc;
using Portal.Consultoras.Entities.ReservaProl;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.Reserva
{
    public class BLReservaSicc : IReservaExternaBL
    {
        private readonly ITablaLogicaDatosBusinessLogic blTablaLogicaDatos;
        private readonly BLPedidoWeb blPedidoWeb;

        private readonly int codReemplazoLength;
        private readonly int codReemplazoFullLength;

        public BLReservaSicc()
        {
            blTablaLogicaDatos = new BLTablaLogicaDatos();
            blPedidoWeb = new BLPedidoWeb();

            codReemplazoLength = Constantes.ProlObsCod.Reemplazo.Length;
            codReemplazoFullLength = codReemplazoLength + 5; //5 de tamaño del cuv
        }

        public async Task<BEResultadoReservaProl> ReservarPedido(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            BEPedidoSicc respuestaSicc = await ConsumirServExtReservar(input, listPedidoWebDetalle);
            if (respuestaSicc == null || respuestaSicc.exitCode == 1) return new BEResultadoReservaProl(Constantes.MensajesError.Reserva_Error, false);
                        
            var resultado = new BEResultadoReservaProl
            {
                MontoTotalProl = respuestaSicc.montoPedidoMontoMaximo.ToDecimalSecure(), //montoPedidoMontoMinimo devuelve lo mismo.
                MontoDescuento = respuestaSicc.montoTotalDcto.ToDecimalSecure(),
                MontoAhorroCatalogo = respuestaSicc.montoTotalOporAhorro.ToDecimalSecure(),
                MontoAhorroRevista = 0,
                MontoEscala = respuestaSicc.montoBaseDcto.ToDecimalSecure()
            };

            if (respuestaSicc.incentivos != null)
            {
                resultado.ListaConcursosCodigos = string.Join("|", respuestaSicc.incentivos.Select(i => i.codigoConcurso).ToArray());
                resultado.ListaConcursosPuntaje = string.Join("|", respuestaSicc.incentivos.Select(i => i.puntajeTotal).ToArray());
                resultado.ListaConcursosPuntajeExigido = string.Join("|", respuestaSicc.incentivos.Select(i => (i.puntajeExigido)).ToArray());
            }

            var listMensajeObs = blTablaLogicaDatos.GetTablaLogicaDatosCache(input.PaisID, Constantes.TablaLogica.ProlObsCod);
            var pedidoObservacion = CreateCabPedidoObs(input, respuestaSicc, listMensajeObs);
            if (pedidoObservacion != null) resultado.ListPedidoObservacion.Add(pedidoObservacion);

            bool validarSap = input.FechaHoraReserva && respuestaSicc.indDeuda != "2";
            var listDetExp = NewListPedidoWebDetalleExplotado(input, respuestaSicc.posiciones);
            SetOrigPedWebAndListCuvOrigen(listDetExp, listPedidoWebDetalle);
            foreach (var detExp in listDetExp)
            {
                if (detExp.IndRecuperacion) resultado.ListDetalleBackOrder.AddRange(listPedidoWebDetalle.Where(d => d.CUV == detExp.CUV));
                else
                {
                    var listpedidoObservacion = CreateDetListPedidoObs(detExp, listDetExp, listMensajeObs, validarSap);
                    if (listpedidoObservacion != null) resultado.ListPedidoObservacion.AddRange(listpedidoObservacion);
                }
            }
            resultado.ListPedidoObservacion = resultado.ListPedidoObservacion.GroupBy(d => new { d.CUV, d.CuvObs }).Select(g => g.First()).ToList();

            bool reservo = !resultado.ListDetalleBackOrder.Any() && resultado.ListPedidoObservacion.All(o => o.Caso == 0);
            resultado.Restrictivas = resultado.ListDetalleBackOrder.Any() || resultado.ListPedidoObservacion.Any();
            resultado.Reserva = input.FechaHoraReserva && reservo;
            resultado.ResultadoReservaEnum = respuestaSicc.indDeuda == "2" ? Enumeradores.ResultadoReserva.NoReservadoDeuda :
                respuestaSicc.estadoPedidoMontoMinimo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMinimo :
                respuestaSicc.estadoPedidoMontoMaximo == "1" ? Enumeradores.ResultadoReserva.NoReservadoMontoMaximo :
                !resultado.Restrictivas ? Enumeradores.ResultadoReserva.Reservado :
                reservo ? Enumeradores.ResultadoReserva.ReservadoObservaciones :
                Enumeradores.ResultadoReserva.NoReservadoObservaciones;
            resultado.CodigoMensaje = resultado.ResultadoReservaEnum == Enumeradores.ResultadoReserva.Reservado ? "00" : "01";
            resultado.PedidoSapId = respuestaSicc.oidPedidoSap.ToInt64Secure();

            if (resultado.Reserva)
            {
                var listDetExpDescarga = GetExplotadoSinKitNueva(listDetExp, listPedidoWebDetalle).Where(d => d.UnidadesReservadasSap > 0).ToList();
                GuardarExplotado(input, listDetExpDescarga);
            }

            return resultado;
        }

        public async Task<bool> DeshacerReservaPedido(BEUsuario usuario, int pedidoId)
        {
            var pedidoSapId = blPedidoWeb.GetPedidoSapId(usuario.PaisID, usuario.CampaniaID, pedidoId);
            if (pedidoSapId == 0) return true;

            blPedidoWeb.ClearPedidoSapId(usuario.PaisID, usuario.CampaniaID, pedidoId);
            var codigoPais = Util.GetPaisIsoSicc(usuario.PaisID);

            var output = await ConsumirDeExtCancelarReserva(codigoPais, pedidoSapId);
            return output == "0";
        }

        private async Task<BEPedidoSicc> ConsumirServExtReservar(BEInputReservaProl input, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var pedidoSapId = blPedidoWeb.GetPedidoSapId(input.PaisID, input.CampaniaID, input.PedidoID);
            var inputPedido = new BEPedidoSicc
            {
                codigoPais = Util.GetPaisIsoSicc(input.PaisID),
                codigoPeriodo = input.CampaniaID.ToString(),
                codigoCliente = input.CodigoConsultora,
                indValiProl = input.FechaHoraReserva ? "1" : "0",
                oidPedidoSap = pedidoSapId == 0 ? "" : pedidoSapId.ToString(),
                posiciones = listPedidoWebDetalle.GroupBy(d => d.CUV).Select(g => new BEDetalleSicc
                {
                    CUV = g.Key,
                    unidadesDemandadas = g.Sum(d => d.Cantidad).ToString()
                }).ToArray()
            };
            
            var path = "/Service.svc/EjecutarCuadreOfertas";
            return await RestClient.PostAsync<BEPedidoSicc>(Enumeradores.RestService.ReservaSicc, path, inputPedido);
        }

        private async Task<string> ConsumirDeExtCancelarReserva(string codigoPais, long pedidoSapId)
        {
            var path = string.Format("/Service.svc/CancelarReserva/{0}/{1}", codigoPais, pedidoSapId);
            return await RestClient.PutAsync<string>(Enumeradores.RestService.ReservaSicc, path, "");
        }

        private List<BEPedidoWebDetalleExplotado> NewListPedidoWebDetalleExplotado(BEInputReservaProl input, BEDetalleSicc[] arrayDetalle)
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
                DescripcionSap = d.descripcionSap,
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
                UnidadesReservadasSap = Convert.ToInt32(d.unidadesReservadasSap.ToDecimalSecure())
            }).ToList();
        }

        private void SetOrigPedWebAndListCuvOrigen(List<BEPedidoWebDetalleExplotado> listDetalleExp, List<BEPedidoWebDetalle> listDetalle)
        {
            var raizExp = GetRaizArbolExp(listDetalleExp, listDetalle);
            foreach (var nodoExp in raizExp.Hijos)
            {
                nodoExp.Actual.ListCuvOrigen.Add(nodoExp.Actual.CUV);
                SetHijosOrigPedWebAndListCuvOrigen(nodoExp, nodoExp.Actual.CUV, nodoExp.Actual.OrigenPedidoWeb);
            }
        }

        private void SetHijosOrigPedWebAndListCuvOrigen(Nodo<BEPedidoWebDetalleExplotado> nodoExp, string cuvOriginal, int origenPedidoWebOriginal)
        {
            if (!nodoExp.Hijos.Any()) return;

            foreach (var hijoExp in nodoExp.Hijos)
            {
                hijoExp.Actual.OrigenPedidoWeb = origenPedidoWebOriginal;
                hijoExp.Actual.ListCuvOrigen.Add(cuvOriginal);
                SetHijosOrigPedWebAndListCuvOrigen(hijoExp, cuvOriginal, origenPedidoWebOriginal);
            }
        }

        private Nodo<BEPedidoWebDetalleExplotado> GetRaizArbolExp(List<BEPedidoWebDetalleExplotado> listDetalleExp, List<BEPedidoWebDetalle> listDetalle)
        {
            var arbolExp = listDetalleExp.Select(dx => new Nodo<BEPedidoWebDetalleExplotado>(dx)).ToList();
            var listNodoOfertaNivel = new List<Nodo<BEPedidoWebDetalleExplotado>>();
            var raiz = new Nodo<BEPedidoWebDetalleExplotado>(null);
            List<Nodo<BEPedidoWebDetalleExplotado>> listNodo;
            Nodo<BEPedidoWebDetalleExplotado> nodo;
            BEPedidoWebDetalleExplotado detExp;
            BEPedidoWebDetalle original;
            string obsReemp;
            
            //Primero oferta de niveles por separado para agregar los CUV's originales que no fueron devueltos por el servicio.
            arbolExp.Where(nodExp => EsExpOfertaNivel(nodExp.Actual)).ForEach(nodExp => {
                nodo = arbolExp.FirstOrDefault(nx => nx.Actual.CUV == nodExp.Actual.ValCodiOrig);
                if (nodo == null)
                {
                    detExp = new BEPedidoWebDetalleExplotado { CUV = nodExp.Actual.ValCodiOrig, UnidadesDemandadas = nodExp.Actual.UnidadesDemandadas };
                    nodo = new Nodo<BEPedidoWebDetalleExplotado>(detExp);
                    listNodoOfertaNivel.Add(nodo);
                }
                nodExp.AddPadre(nodo);
            });
            arbolExp.AddRange(listNodoOfertaNivel);

            arbolExp.Where(nodExp => !EsExpOfertaNivel(nodExp.Actual)).ForEach(nodExp => {
                if (nodExp.Actual.UnidadesDemandadas == 0)
                {
                    listNodo = arbolExp.Where(d => d.Actual.IdOferta == nodExp.Actual.IdOferta && d.Actual.UnidadesDemandadas > 0).ToList();
                    listNodo.ForEach(n => nodExp.AddPadre(n));
                    return;
                }

                original = listDetalle.FirstOrDefault(d => d.CUV == nodExp.Actual.CUV);
                if (original != null)
                {
                    nodExp.Actual.OrigenPedidoWeb = original.OrigenPedidoWeb;
                    nodExp.AddPadre(raiz);
                    return;
                }

                if (nodExp.Actual.IdSubTipoPosicion == 2029)
                {
                    obsReemp = Constantes.ProlSiccObs.Reemplazo + nodExp.Actual.CUV;
                    nodo = arbolExp.FirstOrDefault(nx => nx.Actual.IdSubTipoPosicion == 2030 && nx.Actual.Observaciones == obsReemp);
                    if (nodo != null) nodExp.AddPadre(nodo);
                }
            });

            return raiz;
        }

        private bool EsExpOfertaNivel(BEPedidoWebDetalleExplotado detExp)
        {
            return !string.IsNullOrEmpty(detExp.ValCodiOrig) && detExp.ValCodiOrig != detExp.CUV;
        }

        private List<BEPedidoWebDetalleExplotado> GetExplotadoSinKitNueva(List<BEPedidoWebDetalleExplotado> listDetalleExp, List<BEPedidoWebDetalle> listDetalle)
        {
            var detKitNueva = listDetalle.FirstOrDefault(det => det.EsKitNueva);
            if (detKitNueva == null) return listDetalleExp;

            //NUNCA DEBERÍA RETORNAR NULL, YA  QUE EL EXPLOTADO SIEMPRE DEVUELVE EL DETALLE MÁS OTROS PRODUCTOS
            var detExpKit = listDetalleExp.First(detExp => detExp.CUV == detKitNueva.CUV);

            Func<BEPedidoWebDetalleExplotado, bool> fnEsKit, fnEsKitHijo;
            fnEsKit = (detExp => detExp.CUV == detKitNueva.CUV);
            fnEsKitHijo = (detExp => detExp.IdOferta == detExpKit.IdOferta && detExp.UnidadesDemandadas == 0);

            if (detExpKit.IdOferta == 0) return listDetalleExp.Where(detExp => !fnEsKit(detExp)).ToList();
            return listDetalleExp.Where(detExp => !(fnEsKit(detExp) || fnEsKitHijo(detExp))).ToList();
        }

        private void GuardarExplotado(BEInputReservaProl input, List<BEPedidoWebDetalleExplotado> listDetalleExp)
        {
            var daPedidoWebDetalleExplotado = new DAPedidoWebDetalleExplotado(input.PaisID);
            daPedidoWebDetalleExplotado.DeleteByPedidoID(input.CampaniaID, input.PedidoID);
            daPedidoWebDetalleExplotado.InsertList(listDetalleExp);
        }

        private BEPedidoObservacion CreateCabPedidoObs(BEInputReservaProl input, BEPedidoSicc respuestaSicc, List<BETablaLogicaDatos> listMensajeObs)
        {
            var dictToken = new Dictionary<string, string>();
            string descKey, cuv;

            if (respuestaSicc.indDeuda == "2")
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

                var desc = respuestaSicc.montoTotalDcto.ToDecimalSecure();
                descKey =
                    input.FechaHoraReserva ?
                    (desc > 0 ? Constantes.ProlObsCod.MontoMinFactDesc : Constantes.ProlObsCod.MontoMinFact) :
                    (desc > 0 ? Constantes.ProlObsCod.MontoMinVentaDesc : Constantes.ProlObsCod.MontoMinVenta);

                dictToken.Add(Constantes.ProlObsToken.MinimoMonto, Util.DecimalToStringFormat(input.MontoMinimo, input.PaisISO));
                if (desc > 0) dictToken.Add(Constantes.ProlObsToken.DescuentoMonto, Util.DecimalToStringFormat(desc, input.PaisISO));
            }
            else return null;

            dictToken.Add(Constantes.ProlObsToken.Simbolo, input.Simbolo);
            return new BEPedidoObservacion(2, 95, cuv, ReplaceTokens(listMensajeObs, descKey, dictToken), "");
        }

        private List<BEPedidoObservacion> CreateDetListPedidoObs(BEPedidoWebDetalleExplotado detExp, List<BEPedidoWebDetalleExplotado> listDetExp, List<BETablaLogicaDatos> listMensajeObs, bool validarSap)
        {
            if (detExp.Observaciones != Constantes.ProlSiccObs.Promocion && detExp.PrecioUnitario == 0) return null;
            
            var dictToken = new Dictionary<string, string>();
            int caso;
            string descKey;

            if (detExp.IndLimiteVenta)
            {
                descKey = detExp.UnidadesPorAtender == 0 ? Constantes.ProlObsCod.LimiteVenta0 : Constantes.ProlObsCod.LimiteVenta;
                caso = detExp.UnidadesPorAtender == 0 ? 5 : 4;
                dictToken.Add(Constantes.ProlObsToken.LimiteVenta, detExp.UnidadesPorAtender.ToString());                
            }
            else if (detExp.Observaciones == Constantes.ProlSiccObs.Promocion)
            {                
                descKey = detExp.IdEstrategia == 2003 ? Constantes.ProlObsCod.Promocion2003 : Constantes.ProlObsCod.Promocion;
                caso = detExp.IdEstrategia == 2003 ? 1 : 7;
            }
            else if (detExp.IdSubTipoPosicion == 2030)
            {
                if (string.IsNullOrEmpty(detExp.Observaciones) || detExp.Observaciones.Length != this.codReemplazoFullLength) return null;
                if (detExp.Observaciones.Substring(0, this.codReemplazoLength) != Constantes.ProlSiccObs.Reemplazo) return null;

                var reemplazoCuv = detExp.Observaciones.Substring(this.codReemplazoLength);
                var reemplazo = listDetExp.FirstOrDefault(d => d.IdSubTipoPosicion == 2029 && detExp.CUV == reemplazoCuv);
                if (reemplazo == null) return null;

                descKey = Constantes.ProlObsCod.Reemplazo;
                caso = 0;
                dictToken.Add(Constantes.ProlObsToken.ReemplazoCuv, reemplazo.CUV);
                dictToken.Add(Constantes.ProlObsToken.ReemplazoDesc, reemplazo.DescripcionSap);
            }
            else if (validarSap && detExp.UnidadesReservadasSap < detExp.UnidadesPorAtender)
            {
                descKey = detExp.UnidadesReservadasSap == 0 ? Constantes.ProlObsCod.SinStock0 : Constantes.ProlObsCod.SinStock;
                caso = detExp.UnidadesReservadasSap == 0 ? 5 : 6;
                dictToken.Add(Constantes.ProlObsToken.Stock, detExp.UnidadesReservadasSap.ToString());
            }
            else return null;

            dictToken.Add(Constantes.ProlObsToken.DetalleCuv, detExp.CUV);
            if (detExp.UnidadesPorAtender == 0 && detExp.IdEstrategia == 2002) caso = 0;
            var pedidoObs = new BEPedidoObservacion(2, caso, "", ReplaceTokens(listMensajeObs, descKey, dictToken), detExp.CUV);

            if (!detExp.ListCuvOrigen.Any()) return new List<BEPedidoObservacion> { pedidoObs };
            return detExp.ListCuvOrigen.Select(cuv => new BEPedidoObservacion(pedidoObs) { CUV = cuv }).ToList();
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
