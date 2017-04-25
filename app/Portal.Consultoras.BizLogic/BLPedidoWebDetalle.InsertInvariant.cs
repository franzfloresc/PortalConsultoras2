using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServiceCalculoPROL;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public partial class BLPedidoWebDetalle
    {
        private BLPedidoWeb _blPedidoWeb;
        private BLProducto _blProducto;
        private BLUsuario _blUsuario;
        private BLEstrategia _blEstrategia;
        private BLOfertaProducto _blOfertaProducto;
        private int OfertaLiquidacionID; //1702;
        public const string SUCCESS = "OK";

        public BLPedidoWebDetalle()
        {
            _blPedidoWeb = new BLPedidoWeb();
            _blProducto = new BLProducto();
            _blUsuario = new BLUsuario();
            _blEstrategia = new BLEstrategia();
            _blOfertaProducto = new BLOfertaProducto();

            var ofertaLiquidacion = 0;
            if (!int.TryParse(ConfigurationManager.AppSettings["OfertaLiquidacionID"], out ofertaLiquidacion))
                throw new ArgumentNullException("No existe la llave OfertaLiquidacionID");

            OfertaLiquidacionID = ofertaLiquidacion;
        }

        public BEPedidoWebResult InsPedidoDetalleInvariant(BEPedidoWebDetalleInvariant model)
        {
            var usuario = _blUsuario.GetSesionUsuario(model.PaisID, model.CodigoUsuario);

            //validar horario
            var validacionHorario = _blPedidoWeb.ValidacionModificarPedido(model.PaisID, usuario.ConsultoraID, model.CampaniaID, model.UsuarioPrueba, model.AceptacionConsultoraDA);
            if (!ResolverMotivoPedidoLock(validacionHorario.MotivoPedidoLock))
                return BEPedidoWebResult.BuildError(code: validacionHorario.MotivoPedidoLock.ToString(), message: validacionHorario.Mensaje);

            var producto = _blProducto.SelectProductoByCodigoDescripcionSearchRegionZona(model.PaisID, model.CampaniaID, model.CUV,
                usuario.RegionID, usuario.ZonaID, usuario.CodigorRegion, usuario.CodigoZona, 1, 5, true).FirstOrDefault();
            if (producto == null)
                return BEPedidoWebResult.BuildError(code: "0002", message: "Producto no Encontrado"); //TODO: Validar mensaje

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
                return BEPedidoWebResult.BuildError(code: codigoValidacionStockEstrategia, message: "Stock no valido"); //TODO: Validar mensaje

            //Liquidaciones
            if (producto.GetOrigen(OrigenResolver) == ProductoOrigenEnum.Liquidaciones)
            {
                var resultStockLiquidaciones = ProcesarValidarStockLiquidaciones(model, producto, usuario);
                if (!resultStockLiquidaciones.Item1)
                {
                    return BEPedidoWebResult.BuildError(code: "0002", message: resultStockLiquidaciones.Item2);
                }

                return BEPedidoWebResult.BuildOk();
            }

            //Insertar
            AdministradorPedido(model.PaisID, usuario.CodigoUsuario, "I", model.CUV, model.Cantidad, producto.PrecioCatalogo, usuario);
            return BEPedidoWebResult.BuildOk();
        }

        bool ResolverMotivoPedidoLock(Enumeradores.MotivoPedidoLock validacion)
        {
            if (validacion == Enumeradores.MotivoPedidoLock.GPR ||
            validacion == Enumeradores.MotivoPedidoLock.Reservado ||
            validacion == Enumeradores.MotivoPedidoLock.HorarioRestringido) return false;

            return true;
        }

        static ProductoOrigenEnum OrigenResolver(BEProducto producto)
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
                }

                if (saldo == 0)
                {
                    errorMessage = string.Format(Resources.PedidoInsertMessages.ValidacionUnidadesPermitidasSaldoCero, unidadesPermitidas);
                }
                else
                {
                    errorMessage = string.Format(Resources.PedidoInsertMessages.ValidacionUnidadesPermitidasSaldoPermitido, unidadesPermitidas, saldo);
                }

                result = false;
            }

            int stockOfertaLiquidacion = ValidarStockOfertaProductoLiquidacion(model.PaisID, model.CampaniaID, model.CUV);
            if (stockOfertaLiquidacion < model.Cantidad)
            {
                errorMessage = string.Format(Resources.PedidoInsertMessages.ValidacionUnidadesPermitidasStockSobrepasado, stockOfertaLiquidacion);
                result = false;
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
                TipoOfertaSisID = OfertaLiquidacionID, //Constante Oferta_Liquidacion
                IPUsuario = model.IPUsuario,
                CodigoUsuarioCreacion = usuario.CodigoUsuario,
                CodigoUsuarioModificacion = usuario.CodigoUsuario,
                OrigenPedidoWeb = model.OrigenPedidoWeb
            };

            _blOfertaProducto.InsPedidoWebDetalleOferta(detalle);
            errorMessage = string.Empty;

            return new Tuple<bool, string>(result, errorMessage);
        }

        void ValidarUnidadesPermitidasPedidoProducto(string CUV, int paisId, int campanaId, long consultoraId, out int unidadesPermitidas, out int saldo, out int cantidadPedida)
        {
            var entidad = new BEOfertaProducto();
            entidad.PaisID = paisId;
            entidad.CampaniaID = campanaId;
            entidad.CUV = CUV;
            entidad.ConsultoraID = (int)consultoraId;

            unidadesPermitidas = _blOfertaProducto.GetUnidadesPermitidasByCuv(paisId, campanaId, CUV);
            saldo = _blOfertaProducto.ValidarUnidadesPermitidasEnPedido(paisId, campanaId, CUV, consultoraId);
            cantidadPedida = _blOfertaProducto.CantidadPedidoByConsultora(entidad);
        }

        int ValidarStockOfertaProductoLiquidacion(int paisID, int campanaID, string cuv)
        {
            return _blOfertaProducto.GetStockOfertaProductoLiquidacion(paisID, campanaID, cuv);
        }

        private void AdministradorPedido(int paisID, string codigo, string tipoAccion, string cuv, int cantidad, decimal precio, BEUsuario usuario)
        {
            BEPedidoWeb bePEdidoWeb = _blPedidoWeb.GetPedidoWebByCampaniaConsultora(paisID, usuario.CampaniaID, usuario.ConsultoraID);
            List<BEPedidoWebDetalle> olstTempListado = GetPedidoWebDetalleByCampania(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID, usuario.Nombre).ToList();

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
                OrigenPedidoWeb = 0,
                DescripcionProd = "",
                Nombre = usuario.Nombre,
                Clientes = 0,
            };

            if (tipoAccion == "I")
            {
                int Cantidad;
                short pedidoDetalleID = ValidarInsercion(olstTempListado, item, out Cantidad);
                if (pedidoDetalleID != 0)
                {
                    tipoAccion = "U";
                    item.Stock = item.Cantidad;
                    item.Cantidad += Cantidad;
                    item.ImporteTotal = item.Cantidad * item.PrecioUnidad;
                    item.PedidoDetalleID = pedidoDetalleID;
                    item.Flag = 2;
                    item.OrdenPedidoWD = 1;
                }
            }

            int TotalClientes = CalcularTotalCliente(olstTempListado, item, tipoAccion == "D" ? item.PedidoDetalleID : (short)0, tipoAccion);
            decimal TotalImporte = CalcularTotalImporte(olstTempListado, item, tipoAccion == "I" ? (short)0 : item.PedidoDetalleID, tipoAccion);

            item.ImporteTotalPedido = TotalImporte;
            item.Clientes = TotalClientes;
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

            UpdPedidoWebMontosPROL(usuario);
        }

        short ValidarInsercion(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, out int Cantidad)
        {
            var Temp = new List<BEPedidoWebDetalle>(Pedido);
            var obe = Temp.FirstOrDefault(p => p.ClienteID == ItemPedido.ClienteID && p.CUV == ItemPedido.CUV);
            Cantidad = obe != null ? obe.Cantidad : 0;
            return obe != null ? obe.PedidoDetalleID : (short)0;
        }

        private int CalcularTotalCliente(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, short PedidoDetalleID, string tipoAccion)
        {
            var Temp = new List<BEPedidoWebDetalle>(Pedido);
            if (PedidoDetalleID == 0)
            {
                if (tipoAccion == "I") Temp.Add(ItemPedido);
                else Temp.Where(p => p.PedidoDetalleID == ItemPedido.PedidoDetalleID).ToList().ForEach(p => p.ClienteID = ItemPedido.ClienteID);
            }
            else Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();

            return Temp.Where(p => p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
        }

        private decimal CalcularTotalImporte(List<BEPedidoWebDetalle> Pedido, BEPedidoWebDetalle ItemPedido, short PedidoDetalleID, string tipoAccion)
        {
            var Temp = new List<BEPedidoWebDetalle>(Pedido);
            if (PedidoDetalleID == 0) Temp.Add(ItemPedido);
            else Temp = Temp.Where(p => p.PedidoDetalleID != PedidoDetalleID).ToList();
            return Temp.Sum(p => p.ImporteTotal) + (tipoAccion == "U" ? ItemPedido.ImporteTotal : 0);
        }

        private void UpdPedidoWebMontosPROL(BEUsuario usuario)
        {
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;

            List<BEPedidoWebDetalle> olstTempListado = null;

            olstTempListado = GetPedidoWebDetalleByCampania(usuario.PaisID, usuario.CampaniaID, usuario.ConsultoraID, usuario.Nombre).ToList();

            var lista = ServicioProl_CalculoMontosProl(usuario, olstTempListado);
            if (lista.Count > 0)
            {
                var datos = lista[0];
                Decimal.TryParse(datos.AhorroCatalogo, out montoAhorroCatalogo);
                Decimal.TryParse(datos.AhorroRevista, out montoAhorroRevista);
                Decimal.TryParse(datos.MontoTotalDescuento, out montoDescuento);
                Decimal.TryParse(datos.MontoEscala, out montoEscala);
            }


            BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
            bePedidoWeb.PaisID = usuario.PaisID;
            bePedidoWeb.CampaniaID = usuario.CampaniaID;
            bePedidoWeb.ConsultoraID = usuario.ConsultoraID;
            bePedidoWeb.CodigoConsultora = usuario.CodigoConsultora;
            bePedidoWeb.MontoAhorroCatalogo = montoAhorroCatalogo;
            bePedidoWeb.MontoAhorroRevista = montoAhorroRevista;
            bePedidoWeb.DescuentoProl = montoDescuento;
            bePedidoWeb.MontoEscala = montoEscala;

            _blPedidoWeb.UpdateMontosPedidoWeb(bePedidoWeb);
        }

        private List<ObjMontosProl> ServicioProl_CalculoMontosProl(BEUsuario usuario, List<BEPedidoWebDetalle> Pedido)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("cuv");
            dt.Columns.Add("cantidad");
            Pedido.ForEach(p =>
            {
                dt.Rows.Add(p.CUV, p.Cantidad);
            });

            ds.Tables.Add(dt);

            var ambiente = ConfigurationManager.AppSettings["Ambiente"] ?? "";
            var keyWeb = ambiente.ToUpper() == "QA" ? "QA_Prol_ServicesCalculos" : "PR_Prol_ServicesCalculos";

            var result = new DACalculoPROL(ConfigurationManager.AppSettings[keyWeb]).CalculoMontosProl(usuario.CodigoISO, usuario.CampaniaID.ToString(), usuario.CodigoConsultora, usuario.CodigoZona, ds.Tables[0]).ToList();
            return result;
        }
    }
}
