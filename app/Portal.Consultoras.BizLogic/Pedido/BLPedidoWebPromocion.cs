using Newtonsoft.Json;
using Portal.Consultoras.BizLogic.CaminoBrillante;
using Portal.Consultoras.BizLogic.Pedido;
using Portal.Consultoras.BizLogic.Reserva;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Exceptions;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Pedido;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.ProlApi.Promocion;
using Portal.Consultoras.PublicService.Cryptography;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public partial class BLPedidoWebPromocion : IPedidoWebPromocionBusinessLogic
    {
        private IList<BEPedidoWebPromocion> GetCondicionesByPromocion(BEPedidoWebPromocion BEPedidoWebPromocion, int paisID)
        {
            var pedidoWebPromocion = new List<BEPedidoWebPromocion>();
            var dAPedidoWebPromocion = new DAPedidoWebPromocion(paisID);

            using (IDataReader reader = dAPedidoWebPromocion.GetCondicionesByPromocion(BEPedidoWebPromocion))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebPromocion(reader);
                    pedidoWebPromocion.Add(entidad);
                }

            return pedidoWebPromocion;
        }

        private IList<BEPedidoWebPromocion> GetPromocionesByCondicion(BEPedidoWebPromocion BEPedidoWebPromocion, int paisID)
        {
            var pedidoWebPromocion = new List<BEPedidoWebPromocion>();
            var dAPedidoWebPromocion = new DAPedidoWebPromocion(paisID);

            using (IDataReader reader = dAPedidoWebPromocion.GetPromocionesByCondicion(BEPedidoWebPromocion))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebPromocion(reader);
                    pedidoWebPromocion.Add(entidad);
                }

            return pedidoWebPromocion;
        }

        private bool InsertPedidoWebPromocion(List<BEPedidoWebPromocion> pedidoWebPromociones, int paisID)
        {
            var daPedidoWebPromocion = new DAPedidoWebPromocion(paisID);

            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            try
            {
                var result = false;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    foreach (var item in pedidoWebPromociones)
                    {
                        result = daPedidoWebPromocion.InsertPedidoWebPromocion(item);

                        if (!result)
                        {
                            return result;
                        }
                    }

                    oTransactionScope.Complete();
                }

                return result;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, 0, paisID);
                return false;
            }
        }

        private List<PromocionResponse> BuscarApoyadosApiProl(PromocionRequest PromocionRequest)
        {


            var httpClient = new HttpClient { BaseAddress = new Uri(System.Configuration.ConfigurationManager.AppSettings["RutaServicePROLApi"]) };
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var dataString = JsonConvert.SerializeObject(PromocionRequest);
            HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
            var response = httpClient.PostAsync("Validacion/BuscarApoyados", contentPost).GetAwaiter().GetResult();
            var jsonString = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();

            var respuesta = JsonConvert.DeserializeObject<List<PromocionResponse>>(jsonString);

            return respuesta;
        }

        private List<BEPedidoWebPromocion> GetPedidoWebPromociones(BEPedidoDetalle pedidoDetalle)
        {
            var PromocionRequest = new PromocionRequest();
            PromocionRequest.Pais = Util.GetPaisISO(pedidoDetalle.Usuario.PaisID);
            PromocionRequest.codPeriodo = pedidoDetalle.Usuario.CampaniaID.ToString();
            PromocionRequest.cuv = pedidoDetalle.Estrategia.CUV2;

            var promocionesResponse = BuscarApoyadosApiProl(PromocionRequest);

            var PedidoWebPromociones = new List<BEPedidoWebPromocion>();
            BEPedidoWebPromocion pedidoWebPromocion;
            foreach (var item in promocionesResponse)
            {
                pedidoWebPromocion = new BEPedidoWebPromocion();
                pedidoWebPromocion.CuvPromocion = item.cod_venta_promo;
                pedidoWebPromocion.CuvCondicion = item.cod_venta;

                PedidoWebPromociones.Add(pedidoWebPromocion);
            }

            return PedidoWebPromociones;
        }

        private List<Condicion> ObtenerCondicionesAgregadas(List<BEPedidoWebDetalle> lstDetalleAgrupado, BEUsuario usuario)
        {

            var codigosPromocion = Util.GetCodigosPromocion();

            lstDetalleAgrupado.ForEach(x =>
            {
                x.CodigoTipoOferta = x.CodigoTipoOferta.Trim();
            });

            var promocionesAgregadas = lstDetalleAgrupado.Where(x => codigosPromocion.Contains(x.CodigoTipoOferta)).ToList() ?? new List<BEPedidoWebDetalle>();

            var condicionesporPromocionesAgregadas = CondicionesporPromocionesAgregadas(promocionesAgregadas, usuario);
            //foreach (var item in promocionesAgregadas)
            //{
            //    var promocion = new BEPedidoWebPromocion
            //    {
            //        CampaniaID = usuario.CampaniaID,
            //        CuvPromocion = item.CUV
            //    };

            //    var condicionesporpromocion = _bLPedidoWebPromocion.GetCondicionesByPromocion(promocion, usuario.PaisID);

            //    if (condicionesporpromocion == null || !condicionesporpromocion.Any()) continue;

            //    condicionesporPromocionesAgregadas = condicionesporPromocionesAgregadas.Concat(condicionesporpromocion).ToList();
            //}

            var condicionesAgregadas = lstDetalleAgrupado
                .Where(x => condicionesporPromocionesAgregadas.Select(y => y.CuvCondicion).Distinct().ToList().Contains(x.CUV))
                .Select(x => new Condicion
                {
                    CuvCondicion = x.CUV,
                    Cantidad = x.Cantidad
                }).ToList();

            var condiciones = condicionesporPromocionesAgregadas.GroupBy(
                                p => p.CuvCondicion,
                                p => p.CuvPromocion,
                                (key, g) => new Condicion { CuvCondicion = key, Promociones = g.ToList() }).ToList();

            condicionesAgregadas = (from ca in condicionesAgregadas
                                    join c in condiciones on ca.CuvCondicion equals c.CuvCondicion
                                    select new Condicion
                                    {
                                        CuvCondicion = ca.CuvCondicion,
                                        Promociones = c.Promociones,
                                        Cantidad = ca.Cantidad
                                    }).ToList();

            var promociones = condicionesporPromocionesAgregadas.GroupBy(
                                p => p.CuvPromocion,
                                p => p.CuvCondicion,
                                (key, g) => new Promocion { CuvPromocion = key, Condiciones = g.ToList() }).ToList();

            promociones = (from p in promociones
                           join d in promocionesAgregadas on p.CuvPromocion equals d.CUV
                           select new Promocion
                           {
                               CuvPromocion = p.CuvPromocion,
                               Condiciones = p.Condiciones,
                               Cantidad = d.Cantidad
                           }).ToList();


            condicionesAgregadas = CondicionesAgregadasActualizarCantidad(promociones, condicionesAgregadas);

            //foreach (var promocion in promociones)
            //{
            //    var CondicionesAgregadasParaEstaPromocion = condicionesAgregadas.Where(x => promocion.Condiciones.Contains(x.CuvCondicion)).Where(x => !x.EstaAsignada)
            //        .Select(x => new Condicion
            //        {
            //            Cantidad = x.Cantidad - x.CantidadAsignada,
            //            CuvCondicion = x.CuvCondicion,
            //            EstaAsignada = x.EstaAsignada
            //        }).ToList();

            //    var CantidadPromocion = promocion.Cantidad;

            //    foreach (var condicion in CondicionesAgregadasParaEstaPromocion)
            //    {
            //        if (CantidadPromocion > 0)
            //        {
            //            if (promocion.Cantidad < condicion.Cantidad)
            //            {
            //                condicionesAgregadas.Where(x => x.CuvCondicion == condicion.CuvCondicion).Update(x => { x.CantidadAsignada = x.CantidadAsignada + promocion.Cantidad; });
            //                CantidadPromocion = 0;
            //            }
            //            else if (promocion.Cantidad == condicion.Cantidad)
            //            {
            //                condicionesAgregadas.Where(x => x.CuvCondicion == condicion.CuvCondicion).Update(x => { x.CantidadAsignada = x.CantidadAsignada + condicion.Cantidad; x.EstaAsignada = true; });
            //                CantidadPromocion = 0;
            //            }
            //            else if (promocion.Cantidad > condicion.Cantidad)
            //            {
            //                condicionesAgregadas.Where(x => x.CuvCondicion == condicion.CuvCondicion).Update(x => { x.CantidadAsignada = x.CantidadAsignada + condicion.Cantidad; x.EstaAsignada = true; });
            //                CantidadPromocion = CantidadPromocion - condicion.Cantidad;
            //            }
            //        }                    
            //    }
            //}

            return condicionesAgregadas.ToList();
        }

        private List<BEPedidoWebPromocion> CondicionesporPromocionesAgregadas(List<BEPedidoWebDetalle> promocionesAgregadas, BEUsuario usuario)
        {
            var condicionesPromocionesAgregadas = new List<BEPedidoWebPromocion>();
            promocionesAgregadas = promocionesAgregadas ?? new List<BEPedidoWebDetalle>();
            foreach (var item in promocionesAgregadas)
            {
                var promocion = new BEPedidoWebPromocion
                {
                    CampaniaID = usuario.CampaniaID,
                    CuvPromocion = item.CUV
                };

                var condicionesporpromocion = GetCondicionesByPromocion(promocion, usuario.PaisID);

                if (condicionesporpromocion == null || !condicionesporpromocion.Any()) continue;

                condicionesPromocionesAgregadas = condicionesPromocionesAgregadas.Concat(condicionesporpromocion).ToList();
            }
            return condicionesPromocionesAgregadas;
        }

        private List<Condicion> CondicionesAgregadasActualizarCantidad(List<Promocion> promociones, List<Condicion> condicionesAgregadas)
        {
            promociones = promociones ?? new List<Promocion>();
            condicionesAgregadas = condicionesAgregadas ?? new List<Condicion>();

            foreach (var promocion in promociones)
            {
                var CondicionesAgregadasParaEstaPromocion = condicionesAgregadas.Where(x => promocion.Condiciones.Contains(x.CuvCondicion)).Where(x => !x.EstaAsignada)
                    .Select(x => new Condicion
                    {
                        Cantidad = x.Cantidad - x.CantidadAsignada,
                        CuvCondicion = x.CuvCondicion,
                        EstaAsignada = x.EstaAsignada
                    }).ToList();

                var CantidadPromocion = promocion.Cantidad;

                foreach (var condicion in CondicionesAgregadasParaEstaPromocion)
                {
                    if (CantidadPromocion <= 0)
                    {
                        continue;
                    }

                    if (CantidadPromocion < condicion.Cantidad)
                    {
                        condicionesAgregadas.Where(x => x.CuvCondicion == condicion.CuvCondicion).Update(x => { x.CantidadAsignada = x.CantidadAsignada + CantidadPromocion; });
                        CantidadPromocion = 0;
                    }
                    else if (CantidadPromocion == condicion.Cantidad)
                    {
                        condicionesAgregadas.Where(x => x.CuvCondicion == condicion.CuvCondicion).Update(x => { x.CantidadAsignada = x.CantidadAsignada + condicion.Cantidad; x.EstaAsignada = true; });
                        CantidadPromocion = 0;
                    }
                    else if (CantidadPromocion > condicion.Cantidad)
                    {
                        condicionesAgregadas.Where(x => x.CuvCondicion == condicion.CuvCondicion).Update(x => { x.CantidadAsignada = x.CantidadAsignada + condicion.Cantidad; x.EstaAsignada = true; });
                        CantidadPromocion = CantidadPromocion - condicion.Cantidad;
                    }

                }
            }

            return condicionesAgregadas;
        }

        private BEPedidoDetalleResult GuardarPedidoWebPromocion(BEPedidoDetalle pedidoDetalle)
        {
            if (pedidoDetalle.PedidoWebPromociones == null || !pedidoDetalle.PedidoWebPromociones.Any())
            {
                pedidoDetalle.PedidoWebPromociones = GetPedidoWebPromociones(pedidoDetalle);
            }

            var lstPedidoWebPromociones = pedidoDetalle.PedidoWebPromociones;
            var usuario = pedidoDetalle.Usuario;

            lstPedidoWebPromociones.ForEach(x => x.CampaniaID = usuario.CampaniaID);

            var promocionnueva = new BEPedidoWebPromocion();
            promocionnueva.CuvPromocion = lstPedidoWebPromociones[0].CuvPromocion;
            promocionnueva.CampaniaID = usuario.CampaniaID;
            var promociones = GetCondicionesByPromocion(promocionnueva, usuario.PaisID);
            var seguardolascondiciones = true;
            if (promociones == null || !promociones.Any())
            {
                seguardolascondiciones = InsertPedidoWebPromocion(lstPedidoWebPromociones, usuario.PaisID);
            }

            if (seguardolascondiciones)
            {
                return new BEPedidoDetalleResult() { CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS };
            }
            else
            {
                return new BEPedidoDetalleResult() { CodigoRespuesta = Constantes.PedidoValidacion.Code.ERROR_GUARDAR_CONDICION_REGLAS, MensajeRespuesta = "Ocurrió un error al guardar la promoción." };
            }
        }

        public BEPedidoDetalleResult ValidarPromocionesEnAgregar(List<BEPedidoWebDetalle> lstDetalleAgrupado, BEPedidoDetalle pedidoDetalle, BEUsuario usuario, bool modificar = false)
        {
            var codigosPromocion = Util.GetCodigosPromocion();
            if (!pedidoDetalle.EsPromocion && !modificar)
            {
                return new BEPedidoDetalleResult() { CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS };
            }

            if (!modificar)
            {
                var guardarPedidoWebPromocion = GuardarPedidoWebPromocion(pedidoDetalle);
                if (!guardarPedidoWebPromocion.CodigoRespuesta.Equals(Constantes.PedidoValidacion.Code.SUCCESS))
                {
                    return guardarPedidoWebPromocion;
                }
            }

            var promocionnueva = new BEPedidoWebPromocion();
            promocionnueva.CuvPromocion = modificar ? pedidoDetalle.Producto.CUV : pedidoDetalle.Estrategia.CUV2;
            promocionnueva.CampaniaID = usuario.CampaniaID;
            var lstPedidoWebPromociones = GetCondicionesByPromocion(promocionnueva, usuario.PaisID);

            if (lstPedidoWebPromociones == null || !lstPedidoWebPromociones.Any())
            {
                return new BEPedidoDetalleResult() { CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS };
            }

            var CondicionesSolicitadas = lstDetalleAgrupado.Where(x => lstPedidoWebPromociones.Select(y => y.CuvCondicion).Distinct().ToList().Contains(x.CUV)).Select(x => new Condicion
            {
                CuvCondicion = x.CUV,
                Cantidad = x.Cantidad
            }).ToList();

            var CondicionesAgregadas = ObtenerCondicionesAgregadas(lstDetalleAgrupado, usuario);

            var CondicionesNoContempladas = CondicionesSolicitadas.Where(x => !CondicionesAgregadas.Select(y => y.CuvCondicion).Contains(x.CuvCondicion)).ToList();

            CondicionesAgregadas = CondicionesAgregadas.Concat(CondicionesNoContempladas).ToList();

            var CantidadCondicionesDisponibles = CondicionesAgregadas.Where(x => CondicionesSolicitadas.Select(y => y.CuvCondicion).Contains(x.CuvCondicion)).Where(x => !x.EstaAsignada).Sum(x => x.Cantidad - x.CantidadAsignada);

            if (pedidoDetalle.Cantidad > CantidadCondicionesDisponibles)
            {
                int CantidadFaltante = pedidoDetalle.Cantidad - CantidadCondicionesDisponibles;
                var texto = (CantidadFaltante == 1) ? "condicional" : "condicionales";
                return new BEPedidoDetalleResult()
                {
                    CodigoRespuesta = Constantes.PedidoValidacion.Code.ERROR_AGREGAR_PROMOCION,
                    MensajeRespuesta = String.Format("Te falta(n) {0} producto(s) {1} para poder llevarte la cantidad de promociones que deseas", CantidadFaltante, texto)
                };
            }

            return new BEPedidoDetalleResult() { CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS };
        }

        public BEPedidoDetalleResult ValidarPromocionesEnModificar(List<BEPedidoWebDetalle> lstDetalleAgrupado, BEUsuario usuario, int cantidadmodificada, string cuvmodificado)
        {
            var CondicionesAgregadas = ObtenerCondicionesAgregadas(lstDetalleAgrupado, usuario);

            if (!CondicionesAgregadas.Exists(x => x.CuvCondicion == cuvmodificado))
            {
                return new BEPedidoDetalleResult() { CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS };
            }
            else
            {
                var Condicion = CondicionesAgregadas.First(x => x.CuvCondicion == cuvmodificado);
                var Cantidaddisponible = (Condicion.Cantidad - Condicion.CantidadAsignada);

                if (cantidadmodificada > Cantidaddisponible)
                {
                    var promocionesVinculadas = lstDetalleAgrupado.Where(x => Condicion.Promociones.Contains(x.CUV));
                    var cuvspromocion = String.Join(",", promocionesVinculadas.Select(p => p.CUV));
                    var cantidafaltante = (cantidadmodificada - Cantidaddisponible);
                    var texto = cantidafaltante == 1 ? "promoción" : "promociones";

                    return new BEPedidoDetalleResult()
                    {
                        CodigoRespuesta = Constantes.PedidoValidacion.Code.ERROR_MODIFICAR_CONDICION,
                        MensajeRespuesta = String.Format("Debes eliminar {0} {1} ({2}) para completar esta acción", cantidafaltante, texto, cuvspromocion)
                    };
                }
            }

            return new BEPedidoDetalleResult() { CodigoRespuesta = Constantes.PedidoValidacion.Code.SUCCESS };
        }
    }
}