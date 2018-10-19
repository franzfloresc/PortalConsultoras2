using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServiceCalculoPROL;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public partial class BLPedidoWebDetalle
    {
        private readonly IConsultoraConcursoBusinessLogic _consultoraConcursoBusinessLogic;

        private readonly BLPedidoWeb _blPedidoWeb;
        private readonly BLProducto _blProducto;
        private readonly BLUsuario _blUsuario;
        private readonly BLEstrategia _blEstrategia;
        private readonly BLOfertaProducto _blOfertaProducto;
        private const string SUCCESS = "OK";

        public BLPedidoWebDetalle() : this(new BLConsultoraConcurso())
        { }

        public BLPedidoWebDetalle(IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic)
        {
            _consultoraConcursoBusinessLogic = consultoraConcursoBusinessLogic;

            _blPedidoWeb = new BLPedidoWeb();
            _blProducto = new BLProducto();
            _blUsuario = new BLUsuario();
            _blEstrategia = new BLEstrategia();
            _blOfertaProducto = new BLOfertaProducto();
        }

        /// <summary>
        /// Inserta un pedido considerando el horario, stock y liquidacion
        /// </summary>
        /// <param name="model">Modelo a ingresar</param>
        /// <returns>Resultado:bool, codigo:string y mensaje:string de la operacion</returns>
        public BEPedidoWebResult InsertPedido(BEPedidoWebDetalleInvariant model)
        {
            var usuario = _blUsuario.GetSesionUsuario(model.PaisID, model.CodigoUsuario);

            //validar horario
            var validacionHorario = _blPedidoWeb.ValidacionModificarPedido(model.PaisID, usuario.ConsultoraID, model.CampaniaID, model.UsuarioPrueba, model.AceptacionConsultoraDA);
            if (!ResolverMotivoPedidoLock(validacionHorario.MotivoPedidoLock))
                return BEPedidoWebResult.BuildError(code: validacionHorario.MotivoPedidoLock.ToString(), message: validacionHorario.Mensaje);

            var producto = _blProducto.SelectProductoByCodigoDescripcionSearchRegionZona(model.PaisID, model.CampaniaID, model.CUV,
                usuario.RegionID, usuario.ZonaID, usuario.CodigorRegion, usuario.CodigoZona, 1, 5, true).FirstOrDefault();
            if (producto == null)
                return BEPedidoWebResult.BuildError(code: ResponseCode.ERROR_PRODUCTO_NO_ENCONTRADO, message: Resources.PedidoInsertMessages.ValidacionProductoByCUVNoEncontrado);

            int tipoEstrategia;
            //validar stock estrategia
            var estrategia = new BEEstrategia()
            {
                PaisID = model.PaisID,
                Cantidad = model.Cantidad,
                CUV2 = model.CUV,
                CampaniaID = model.CampaniaID,
                ConsultoraID = usuario.ConsultoraID.ToString(),
                FlagCantidad = int.TryParse(producto.TipoEstrategiaID, out tipoEstrategia) ? tipoEstrategia : 0
            };

            var codigoValidacionStockEstrategia = _blEstrategia.ValidarStockEstrategia(estrategia);
            if (codigoValidacionStockEstrategia != SUCCESS)
                return BEPedidoWebResult.BuildError(code: codigoValidacionStockEstrategia, message: codigoValidacionStockEstrategia);

            //Liquidaciones
            if (producto.GetOrigen(OrigenResolver) == ProductoOrigenEnum.Liquidaciones)
            {
                var resultStockLiquidaciones = ProcesarValidarStockLiquidaciones(model, producto, usuario);
                if (!resultStockLiquidaciones.Item1)
                {
                    return BEPedidoWebResult.BuildError(code: ResponseCode.ERROR_PRODUCTO_STOCK_INVALIDO, message: resultStockLiquidaciones.Item2);
                }

                return BEPedidoWebResult.BuildOk();
            }

            //Insertar
            AdministradorPedido(model.PaisID, "I", model.CUV, model.Cantidad, producto.PrecioCatalogo, usuario, model.OrigenPedidoWeb);
            return BEPedidoWebResult.BuildOk();
        }

        public static class ResponseCode
        {
            public const string ERROR_PRODUCTO_NO_ENCONTRADO = "05";
            public const string ERROR_PRODUCTO_STOCK_INVALIDO = "06";
        }

        #region Privates
        private static bool ResolverMotivoPedidoLock(Enumeradores.MotivoPedidoLock validacion)
        {
            if (validacion == Enumeradores.MotivoPedidoLock.GPR ||
            validacion == Enumeradores.MotivoPedidoLock.Reservado ||
            validacion == Enumeradores.MotivoPedidoLock.HorarioRestringido) return false;

            return true;
        }

        private static ProductoOrigenEnum OrigenResolver(BEProducto producto)
        {
            if (producto.TipoOfertaSisID == 1702) return ProductoOrigenEnum.Liquidaciones;
            if (producto.EsExpoOferta) return ProductoOrigenEnum.ExpoOfertas;

            producto.CatalogoDescripcion = producto.CatalogoDescripcion ?? string.Empty;
            if (producto.CatalogoDescripcion.ToLower().Contains("catalogo")) return ProductoOrigenEnum.Catalogo;
            if (producto.CatalogoDescripcion.ToLower().Contains("revista")) return ProductoOrigenEnum.Revista;

            return ProductoOrigenEnum.Otros;
        }

        private Tuple<bool, string> ProcesarValidarStockLiquidaciones(BEPedidoWebDetalleInvariant model, BEProducto producto, BEUsuario usuario)
        {
            string errorMessage;
            bool result = true;
            int unidadesPermitidas = 0;
            int saldo = 0;
            int cantidadPedida = 0;

            ValidarUnidadesPermitidasPedidoProducto(model.CUV, model.PaisID, model.CampaniaID, usuario.ConsultoraID, out unidadesPermitidas, out saldo, out cantidadPedida);

            if (saldo < model.Cantidad)
            {
                if (saldo == unidadesPermitidas)
                {
                    errorMessage = string.Format(Resources.PedidoInsertMessages.ValidacionUnidadesPermitidas, unidadesPermitidas);
                    result = false;
                    return new Tuple<bool, string>(result, errorMessage);
                }

                if (saldo == 0)
                {
                    errorMessage = string.Format(Resources.PedidoInsertMessages.ValidacionUnidadesPermitidasSaldoCero, unidadesPermitidas);
                }
                else
                {
                    errorMessage = string.Format(Resources.PedidoInsertMessages.ValidacionUnidadesPermitidasSaldoPermitido, saldo, unidadesPermitidas);
                }

                result = false;
                return new Tuple<bool, string>(result, errorMessage);
            }

            int stockOfertaLiquidacion = ValidarStockOfertaProductoLiquidacion(model.PaisID, model.CampaniaID, model.CUV);
            if (stockOfertaLiquidacion < model.Cantidad)
            {
                errorMessage = string.Format(Resources.PedidoInsertMessages.ValidacionUnidadesPermitidasStockSobrepasado, stockOfertaLiquidacion);
                result = false;
                return new Tuple<bool, string>(result, errorMessage);
            }

            var detalle = new BEPedidoWebDetalle()
            {
                CUV = model.CUV,
                PaisID = model.PaisID,
                ConsultoraID = usuario.ConsultoraID,
                MarcaID = Convert.ToByte(producto.MarcaID),
                PrecioUnidad = producto.PrecioCatalogo,
                ConfiguracionOfertaID = producto.ConfiguracionOfertaID,
                Cantidad = model.Cantidad,
                CampaniaID = model.CampaniaID,
                TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion,
                IPUsuario = model.IPUsuario,
                CodigoUsuarioCreacion = usuario.CodigoUsuario,
                CodigoUsuarioModificacion = usuario.CodigoUsuario,
                OrigenPedidoWeb = model.OrigenPedidoWeb
            };

            _blOfertaProducto.InsPedidoWebDetalleOferta(detalle);

            errorMessage = string.Empty;

            return new Tuple<bool, string>(result, errorMessage);
        }

        private void ValidarUnidadesPermitidasPedidoProducto(string CUV, int paisId, int campanaId, long consultoraId, out int unidadesPermitidas, out int saldo, out int cantidadPedida)
        {
            var entidad = new BEOfertaProducto
            {
                PaisID = paisId,
                CampaniaID = campanaId,
                CUV = CUV,
                ConsultoraID = (int)consultoraId
            };

            unidadesPermitidas = _blOfertaProducto.GetUnidadesPermitidasByCuv(paisId, campanaId, CUV);
            saldo = _blOfertaProducto.ValidarUnidadesPermitidasEnPedido(paisId, campanaId, CUV, consultoraId);
            cantidadPedida = _blOfertaProducto.CantidadPedidoByConsultora(entidad);
        }

        private int ValidarStockOfertaProductoLiquidacion(int paisID, int campanaID, string cuv)
        {
            return _blOfertaProducto.GetStockOfertaProductoLiquidacion(paisID, campanaID, cuv);
        }

        private void AdministradorPedido(int paisID, string tipoAccion, string cuv, int cantidad, decimal precio, BEUsuario usuario,
            int origenPedidoWeb)
        {
            BEPedidoWeb bePEdidoWeb = _blPedidoWeb.GetPedidoWebByCampaniaConsultora(paisID, usuario.CampaniaID, usuario.ConsultoraID);

            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = usuario.PaisID,
                CampaniaId = usuario.CampaniaID,
                ConsultoraId = usuario.ConsultoraID,
                Consultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                NumeroPedido = usuario.ConsecutivoNueva
            };

            List<BEPedidoWebDetalle> olstTempListado = GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();

            var item = new BEPedidoWebDetalle
            {
                PaisID = usuario.PaisID,
                ConsultoraID = usuario.ConsultoraID,
                PedidoID = bePEdidoWeb == null ? 0 : bePEdidoWeb.PedidoID,
                CampaniaID = usuario.CampaniaID,
                CUV = cuv,
                Cantidad = cantidad,
                ClienteID = 0,
                TipoOfertaSisID = 0,
                ConfiguracionOfertaID = 0,
                OfertaWeb = false,
                EsSugerido = false,
                EsKitNueva = false,
                MarcaID = 1,
                PrecioUnidad = precio,
                OrigenPedidoWeb = origenPedidoWeb,
                DescripcionProd = "",
                Nombre = usuario.Nombre,
                Clientes = 0,
            };

            if (tipoAccion == "I")
            {
                int itemCantidad;
                short pedidoDetalleId = ValidarInsercion(olstTempListado, item, out itemCantidad);
                if (pedidoDetalleId != 0)
                {
                    tipoAccion = "U";
                    item.Stock = item.Cantidad;
                    item.Cantidad += itemCantidad;
                    item.ImporteTotal = item.Cantidad * item.PrecioUnidad;
                    item.PedidoDetalleID = pedidoDetalleId;
                    item.Flag = 2;
                    item.OrdenPedidoWD = 1;
                }
            }

            int totalClientes = CalcularTotalCliente(olstTempListado, item, tipoAccion == "D" ? item.PedidoDetalleID : (short)0, tipoAccion);
            decimal totalImporte = CalcularTotalImporte(olstTempListado, item, tipoAccion == "I" ? (short)0 : item.PedidoDetalleID, tipoAccion);

            item.ImporteTotalPedido = totalImporte;
            item.Clientes = totalClientes;
            item.CodigoUsuarioCreacion = usuario.CodigoUsuario;
            item.CodigoUsuarioModificacion = usuario.CodigoUsuario;

            switch (tipoAccion)
            {
                case "I":
                    InsPedidoWebDetalle(item);
                    break;
                case "U":
                    UpdPedidoWebDetalle(item);
                    break;
                case "D":
                    DelPedidoWebDetalle(item);
                    break;
            }

            ActualizarPedidoWebMontosPROL(usuario);
        }

        private static short ValidarInsercion(List<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, out int cantidad)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            var obe = temp.FirstOrDefault(p => p.ClienteID == itemPedido.ClienteID && p.CUV == itemPedido.CUV);
            cantidad = obe != null ? obe.Cantidad : 0;
            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        private static int CalcularTotalCliente(IEnumerable<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string tipoAccion)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            if (pedidoDetalleId == 0)
            {
                if (tipoAccion == "I") temp.Add(itemPedido);
                else temp.Where(p => p.PedidoDetalleID == itemPedido.PedidoDetalleID).ToList().ForEach(p => p.ClienteID = itemPedido.ClienteID);
            }
            else temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();

            return temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private static decimal CalcularTotalImporte(IEnumerable<BEPedidoWebDetalle> pedido, BEPedidoWebDetalle itemPedido, short pedidoDetalleId, string tipoAccion)
        {
            var temp = new List<BEPedidoWebDetalle>(pedido);
            if (pedidoDetalleId == 0) temp.Add(itemPedido);
            else temp = temp.Where(p => p.PedidoDetalleID != pedidoDetalleId).ToList();
            return temp.Sum(p => p.ImporteTotal) + (tipoAccion == "U" ? itemPedido.ImporteTotal : 0);
        }

        private void ActualizarPedidoWebMontosPROL(BEUsuario usuario)
        {
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;
            string codigosConcursos = string.Empty, puntajes = string.Empty, puntajesExigidos = string.Empty;

            var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
            {
                PaisId = usuario.PaisID,
                CampaniaId = usuario.CampaniaID,
                ConsultoraId = usuario.ConsultoraID,
                Consultora = usuario.Nombre,
                CodigoPrograma = usuario.CodigoPrograma,
                NumeroPedido = usuario.ConsecutivoNueva
            };
            var listProducto = GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros).ToList();

            if (listProducto.Any())
            {
                var consultoraNuevas = new BEConsultoraProgramaNuevas
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    CodigoConsultora = usuario.CodigoConsultora,
                    EsConsultoraNueva = usuario.EsConsultoraNueva,
                    ConsecutivoNueva = usuario.ConsecutivoNueva,
                    CodigoPrograma = usuario.CodigoPrograma
                };
                var result = _consultoraConcursoBusinessLogic.ObtenerConcursosXConsultora(consultoraNuevas, usuario.CodigorRegion, usuario.CodigoZona);
                var arrCalculoPuntos = Constantes.Incentivo.CalculoPuntos.Split(';');
                var concursos = result.Where(x => arrCalculoPuntos.Contains(x.TipoConcurso)).ToList();
                if (concursos.Any()) codigosConcursos = string.Join("|", concursos.Select(c => c.CodigoConcurso));

                var lista = ServicioProl_CalculoMontosProl(usuario, listProducto, codigosConcursos);
                if (lista != null && lista.Count > 0)
                {
                    var datos = lista[0];

                    decimal.TryParse(datos.AhorroCatalogo, out montoAhorroCatalogo);
                    decimal.TryParse(datos.AhorroRevista, out montoAhorroRevista);
                    decimal.TryParse(datos.MontoTotalDescuento, out montoDescuento);
                    decimal.TryParse(datos.MontoEscala, out montoEscala);

                    if (datos.ListaConcursoIncentivos != null)
                    {
                        puntajes = string.Join("|", datos.ListaConcursoIncentivos.Select(c => c.puntajeconcurso.Split('|')[0]));
                        puntajesExigidos = string.Join("|", datos.ListaConcursoIncentivos.Select(c => (c.puntajeconcurso.IndexOf('|') > -1 ? c.puntajeconcurso.Split('|')[1] : "0")));
                    }

                }

                var bePedidoWeb = new BEPedidoWeb
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConsultoraID = usuario.ConsultoraID,
                    CodigoConsultora = usuario.CodigoConsultora,
                    MontoAhorroCatalogo = montoAhorroCatalogo,
                    MontoAhorroRevista = montoAhorroRevista,
                    DescuentoProl = montoDescuento,
                    MontoEscala = montoEscala
                };

                _blPedidoWeb.UpdateMontosPedidoWeb(bePedidoWeb);

                if (!string.IsNullOrEmpty(codigosConcursos))
                    _consultoraConcursoBusinessLogic.ActualizarInsertarPuntosConcurso(usuario.PaisID, usuario.CodigoConsultora, usuario.CampaniaID.ToString(), codigosConcursos, puntajes, puntajesExigidos);
            }
        }

        private static List<ObjMontosProl> ServicioProl_CalculoMontosProl(BEUsuario usuario, List<BEPedidoWebDetalle> pedido, string CodigosConcursos)
        {
            string listaCuvs = string.Join("|", pedido.Select(p => p.CUV));
            string listaCantidades = string.Join("|", pedido.Select(p => p.Cantidad));

            var ambiente = ConfigurationManager.AppSettings["Ambiente"] ?? "";
            var keyWeb = ambiente.ToUpper() == "QA" ? "QA_Prol_ServicesCalculos" : "PR_Prol_ServicesCalculos";

            var result = new DACalculoPROL(ConfigurationManager.AppSettings[keyWeb]).CalculoMontosProl(usuario.CodigoISO, usuario.CampaniaID.ToString(), usuario.CodigoConsultora, usuario.CodigoZona, listaCuvs, listaCantidades, CodigosConcursos).ToList();
            return result;
        }

        #endregion
    }
}
