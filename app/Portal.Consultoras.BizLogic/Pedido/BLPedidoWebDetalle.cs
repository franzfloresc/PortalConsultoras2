using Portal.Consultoras.BizLogic.Reserva;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.PublicService.Cryptography;

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public partial class BLPedidoWebDetalle : IPedidoWebDetalleBusinessLogic
    {
        public IList<BEPedidoWebDetalle> GetClientesByCampania(int paisID, int campaniaID, long consultoraID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.GetClientesByCampania(campaniaID, consultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader) { PaisID = paisID };
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public IList<BEPedidoWebDetalle> GetClientesByCampaniaByClienteID(int paisID, int campaniaID, long consultoraID, string ClienteID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.GetClientesByCampaniaByClienteID(campaniaID, consultoraID, ClienteID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader) { PaisID = paisID };
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCliente(int paisID, int campaniaID, long consultoraID, int clienteID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.GetPedidoWebDetalleByCliente(campaniaID, consultoraID, clienteID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader) { PaisID = paisID };
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public BEPedidoWebDetalle InsPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            var daPedidoWeb = new DAPedidoWeb(pedidowebdetalle.PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle.PaisID);
            BEPedidoWebDetalle bePedidoWebDetalle = null;
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            try
            {
                using (TransactionScope oTransactionScope =
                    new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (pedidowebdetalle.PedidoID == 0)
                    {
                        BEPedidoWeb obePedidoWeb = new BEPedidoWeb
                        {
                            CampaniaID = pedidowebdetalle.CampaniaID,
                            ConsultoraID = pedidowebdetalle.ConsultoraID,
                            PaisID = pedidowebdetalle.PaisID,
                            IPUsuario = pedidowebdetalle.IPUsuario,
                            CodigoUsuarioCreacion = pedidowebdetalle.CodigoUsuarioCreacion
                        };
                        pedidowebdetalle.PedidoID = daPedidoWeb.InsPedidoWeb(obePedidoWeb);
                    }

                    bePedidoWebDetalle = daPedidoWebDetalle.InsPedidoWebDetalle(pedidowebdetalle);
                    daPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID,
                        pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido,
                        pedidowebdetalle.CodigoUsuarioModificacion);

                    if (pedidowebdetalle.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
                        new DAShowRoomEvento(pedidowebdetalle.PaisID).UpdOfertaShowRoomStockAgregar(pedidowebdetalle.CampaniaID,
                            pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    if (pedidowebdetalle.TipoOfertaSisID ==
                        Constantes.ConfiguracionOferta.Liquidacion)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockAgregar(
                            Constantes.ConfiguracionOferta.Liquidacion,
                            pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    if (pedidowebdetalle.TipoOfertaSisID ==
                        Constantes.ConfiguracionOferta.Accesorizate)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockAgregar(
                            Constantes.ConfiguracionOferta.Accesorizate,
                            pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    if (pedidowebdetalle.IndicadorPedidoAutentico != null)
                    {
                        try
                        {
                            var indPedidoAutentico = pedidowebdetalle.IndicadorPedidoAutentico;
                            indPedidoAutentico.PedidoID = pedidowebdetalle.PedidoID;
                            indPedidoAutentico.PedidoDetalleID = bePedidoWebDetalle.PedidoDetalleID;
                            indPedidoAutentico.IndicadorToken = AESAlgorithm.Decrypt(indPedidoAutentico.IndicadorToken);

                            daPedidoWeb.InsIndicadorPedidoAutentico(indPedidoAutentico);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, pedidowebdetalle.CodigoUsuarioCreacion,
                                Util.GetPaisISO(pedidowebdetalle.PaisID));
                        }
                    }

                    oTransactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidowebdetalle.ConsultoraID, pedidowebdetalle.PaisID);
            }

            return bePedidoWebDetalle;
        }

        public void UpdPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            var daPedidoWeb = new DAPedidoWeb(pedidowebdetalle.PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle.PaisID);

            TransactionOptions oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    daPedidoWebDetalle.UpdPedidoWebDetalle(pedidowebdetalle);
                    daPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido, pedidowebdetalle.CodigoUsuarioModificacion);

                    switch (pedidowebdetalle.TipoOfertaSisID)
                    {
                        case Constantes.ConfiguracionOferta.ShowRoom:
                            new DAShowRoomEvento(pedidowebdetalle.PaisID).UpdOfertaShowRoomStockActualizar(pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Stock, pedidowebdetalle.Flag);
                            break;
                        case Constantes.ConfiguracionOferta.Liquidacion:
                        case Constantes.ConfiguracionOferta.Accesorizate:
                            new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockActualizar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Stock, pedidowebdetalle.Flag);
                            break;
                    }

                    if (pedidowebdetalle.IndicadorPedidoAutentico != null)
                    {
                        try
                        {
                            var indPedidoAutentico = pedidowebdetalle.IndicadorPedidoAutentico;
                            indPedidoAutentico.IndicadorToken = (string.IsNullOrEmpty(indPedidoAutentico.IndicadorToken) ? string.Empty : AESAlgorithm.Decrypt(indPedidoAutentico.IndicadorToken));
                            daPedidoWeb.UpdIndicadorPedidoAutentico(indPedidoAutentico);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, pedidowebdetalle.CodigoUsuarioModificacion, Util.GetPaisISO(pedidowebdetalle.PaisID));
                        }
                    }

                    oTransactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidowebdetalle.CodigoUsuarioModificacion, Util.GetPaisISO(pedidowebdetalle.PaisID));
                throw;
            }
        }

        public short UpdPedidoWebDetalleMasivo(List<BEPedidoWebDetalle> pedidowebdetalle)
        {
            short updated = 0;
            var daPedidoWeb = new DAPedidoWeb(pedidowebdetalle[0].PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle[0].PaisID);
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                foreach (var item in pedidowebdetalle)
                {
                    daPedidoWebDetalle.UpdPedidoWebDetalle(item);
                }
                daPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle[0].CampaniaID, pedidowebdetalle[0].PedidoID, pedidowebdetalle[0].Clientes, pedidowebdetalle[0].ImporteTotalPedido, pedidowebdetalle[0].CodigoUsuarioModificacion);
                updated = 1;
                oTransactionScope.Complete();
            }

            return updated;
        }

        public void AceptarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            new DAPedidoWebDetalle(pedidowebdetalle.PaisID).AceptarBackOrderPedidoWebDetalle(pedidowebdetalle);
        }

        public void UpdBackOrderListPedidoWebDetalle(int paisID, int campaniaID, int pedidoID, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            var dAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                dAPedidoWebDetalle.UpdListBackOrderPedidoWebDetalle(campaniaID, pedidoID, listPedidoWebDetalle);

                oTransactionScope.Complete();
            }
        }

        public void QuitarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            new DAPedidoWebDetalle(pedidowebdetalle.PaisID).QuitarBackOrderPedidoWebDetalle(pedidowebdetalle);
        }

        public void DelPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            var daPedidoWeb = new DAPedidoWeb(pedidowebdetalle.PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle.PaisID);
            BEPedidoWebDetalle detalleTemp = new BEPedidoWebDetalle { Cantidad = 0 };

            TransactionOptions oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (pedidowebdetalle.PedidoDetalleID != 0)
                    {
                        using (var reader = daPedidoWebDetalle.GetPedidoWebDetalleByPK(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.PedidoDetalleID))
                        {
                            if (reader.Read()) detalleTemp = new BEPedidoWebDetalle(reader);
                        }
                        daPedidoWebDetalle.DelPedidoWebDetalle(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.PedidoDetalleID, pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.Mensaje);
                    }
                    else
                    {
                        using (var reader = daPedidoWebDetalle.GetPedidoWebDetalleByPedidoAndCUV(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.CUV))
                        {
                            if (reader.Read()) detalleTemp = new BEPedidoWebDetalle(reader);
                        }
                        daPedidoWebDetalle.DelPedidoWebDetalleByCUV(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.CUV);
                    }
                    pedidowebdetalle.Cantidad = detalleTemp.Cantidad;

                    daPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido, pedidowebdetalle.CodigoUsuarioModificacion);

                    if (pedidowebdetalle.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockEliminar(Constantes.ConfiguracionOferta.Liquidacion, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);
                    if (pedidowebdetalle.TipoOfertaSisID == Constantes.ConfiguracionOferta.ShowRoom)
                        new DAShowRoomEvento(pedidowebdetalle.PaisID).UpdOfertaShowRoomStockEliminar(pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    if (pedidowebdetalle.IndicadorPedidoAutentico != null)
                    {
                        try
                        {
                            daPedidoWeb.DelIndicadorPedidoAutentico(pedidowebdetalle.IndicadorPedidoAutentico);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, pedidowebdetalle.CodigoUsuarioModificacion, Util.GetPaisISO(pedidowebdetalle.PaisID));
                        }
                    }

                    oTransactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, pedidowebdetalle.CodigoUsuarioModificacion, Util.GetPaisISO(pedidowebdetalle.PaisID));
                throw;
            }
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCampania(BEPedidoWebDetalleParametros bePedidoWebDetalleParametros, 
            bool consultoraOnLine = true)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var daPedidoWebDetalle = new DAPedidoWebDetalle(bePedidoWebDetalleParametros.PaisId);

            using (IDataReader reader = daPedidoWebDetalle.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader, bePedidoWebDetalleParametros.Consultora);
                    entidad.PaisID = bePedidoWebDetalleParametros.PaisId;
                    pedidoWebDetalle.Add(entidad);
                }

            #region ConsultoraOnline
            if (consultoraOnLine)
            {
                var daConsultoraOnline = new DAConsultoraOnline(bePedidoWebDetalleParametros.PaisId);
                var listaProductosConsultoraOnline = new List<BESolicitudClienteDetalle>();

                using (IDataReader reader = daConsultoraOnline.GetProductoByCampaniaByConsultoraId(bePedidoWebDetalleParametros.CampaniaId, bePedidoWebDetalleParametros.ConsultoraId))
                    while (reader.Read())
                    {
                        var entidad = new BESolicitudClienteDetalle(reader);
                        listaProductosConsultoraOnline.Add(entidad);
                    }

                if (listaProductosConsultoraOnline.Count > 0)
                {
                    foreach (var item in pedidoWebDetalle)
                    {
                        var itemConsultoraOnline = listaProductosConsultoraOnline.FirstOrDefault(p => p.PedidoWebID == item.PedidoID && p.PedidoWebDetalleID == item.PedidoDetalleID);
                        if (itemConsultoraOnline != null)
                        {
                            item.FlagConsultoraOnline = true;
                        }
                    }
                }
            }
            #endregion

            return pedidoWebDetalle;
        }

        public IList<BEPedidoDDWebDetalle> GetPedidosDDWebDetalleByCampaniaPedido(int paisID, int CampaniaID, int PedidoID)
        {
            var pedidoDdWebDetalle = new List<BEPedidoDDWebDetalle>
            {
                new BEPedidoDDWebDetalle { CUV = "00052", Descripcion = "Producto 1", Cantidad = 10, PrecioUnitario = 15, PrecioTotal = 150 },
                new BEPedidoDDWebDetalle { CUV = "00036", Descripcion = "Producto 2", Cantidad = 4, PrecioUnitario = 5, PrecioTotal = 20 },
                new BEPedidoDDWebDetalle { CUV = "00452", Descripcion = "Producto 3", Cantidad = 6, PrecioUnitario = 22, PrecioTotal = 132 },
                new BEPedidoDDWebDetalle { CUV = "00425", Descripcion = "Producto 4", Cantidad = 7, PrecioUnitario = 13, PrecioTotal = 91 },
                new BEPedidoDDWebDetalle { CUV = "05267", Descripcion = "Producto 5", Cantidad = 8, PrecioUnitario = 2, PrecioTotal = 16 },
                new BEPedidoDDWebDetalle { CUV = "04216", Descripcion = "Producto 6", Cantidad = 2, PrecioUnitario = 4, PrecioTotal = 8 },
                new BEPedidoDDWebDetalle { CUV = "75896", Descripcion = "Producto 7", Cantidad = 5, PrecioUnitario = 8, PrecioTotal = 40 },
                new BEPedidoDDWebDetalle { CUV = "10547", Descripcion = "Producto 8", Cantidad = 8, PrecioUnitario = 1, PrecioTotal = 8 },
                new BEPedidoDDWebDetalle { CUV = "13859", Descripcion = "Producto 9", Cantidad = 5, PrecioUnitario = 1, PrecioTotal = 5 },
                new BEPedidoDDWebDetalle { CUV = "25698", Descripcion = "Producto 10", Cantidad = 9, PrecioUnitario = 8, PrecioTotal = 72 },
                new BEPedidoDDWebDetalle { CUV = "26574", Descripcion = "Producto 11", Cantidad = 4, PrecioUnitario = 12, PrecioTotal = 48 },
                new BEPedidoDDWebDetalle { CUV = "25896", Descripcion = "Producto 12", Cantidad = 8, PrecioUnitario = 4, PrecioTotal = 32 },
                new BEPedidoDDWebDetalle { CUV = "24545", Descripcion = "Producto 13", Cantidad = 18, PrecioUnitario = 13, PrecioTotal = 234 }
            };
            return pedidoDdWebDetalle;
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByOfertaWeb(int paisID, int CampaniaID, long ConsultoraID, bool OfertaWeb)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.GetPedidoWebDetalleByOfertaWeb(CampaniaID, ConsultoraID, OfertaWeb))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader) { PaisID = paisID };
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        #region Consulta y Bloquedo de Pedido
        public IList<BEPedidoWebDetalle> SelectDetalleBloqueoPedidoByPedidoId(int paisID, int PedidoID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.SelectDetalleBloqueoPedidoByPedidoId(PedidoID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader);
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }
        #endregion

        public void InsPedidoWebDetallePROL(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, int ModificaPedido, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl)
        {
            var daPedidoWeb = new DAPedidoWeb(PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                daPedidoWebDetalle.DelPedidoWebDetalleDesglosePedido(CampaniaID, PedidoID);
                foreach (var item in olstPedidoWebDetalle)
                {
                    if (!item.CUVNuevo)
                    {
                        switch (item.EstadoItem)
                        {
                            case 2:
                                daPedidoWebDetalle.UpdPedidoWebDetalle(item);
                                if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                                    new DAOfertaProducto(PaisID).UpdOfertaProductoStockActualizar(item.TipoOfertaSisID, item.CampaniaID, item.CUV, item.Stock, item.Flag);
                                if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.Accesorizate)
                                    new DAOfertaProducto(PaisID).UpdOfertaProductoStockActualizar(item.TipoOfertaSisID, item.CampaniaID, item.CUV, item.Stock, item.Flag);
                                break;
                            case 3:
                                daPedidoWebDetalle.DelPedidoWebDetalle(item.CampaniaID, item.PedidoID, item.PedidoDetalleID, item.TipoOfertaSisID, string.Empty);
                                if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                                    new DAOfertaProducto(PaisID).UpdOfertaProductoStockEliminar(Constantes.ConfiguracionOferta.Liquidacion, item.CampaniaID, item.CUV, item.Cantidad);
                                break;
                            default:
                                if (item.CUVPadre == "0")
                                {
                                    daPedidoWebDetalle.InsPedidoWebDetallePROL(item);
                                    if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                                        new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Constantes.ConfiguracionOferta.Liquidacion, item.CampaniaID, item.CUV, item.Cantidad);
                                    if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.Accesorizate)
                                        new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Constantes.ConfiguracionOferta.Accesorizate, item.CampaniaID, item.CUV, item.Cantidad);
                                }
                                break;
                        }
                    }
                    else
                    {
                        if (item.EstadoItem == 1 || item.EstadoItem == 2)
                        {
                            daPedidoWebDetalle.InsPedidoWebDetalle(item);
                            if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.Liquidacion)
                                new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Constantes.ConfiguracionOferta.Liquidacion, item.CampaniaID, item.CUV, item.Cantidad);
                            if (item.TipoOfertaSisID == Constantes.ConfiguracionOferta.Accesorizate)
                                new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Constantes.ConfiguracionOferta.Accesorizate, item.CampaniaID, item.CUV, item.Cantidad);
                        }
                    }
                }

                if (ModificaPedido == 0)
                    daPedidoWeb.UpdPedidoWebByEstado(CampaniaID, PedidoID, EstadoPedido, false, CodigoUsuario, MontoTotalProl, DescuentoProl);
                else
                {
                    int clientes = olstPedidoWebDetalle.Where(p => p.EstadoItem != 3 && p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
                    decimal importeTotal = olstPedidoWebDetalle.Where(p => p.EstadoItem != 3).Sum(p => p.ImporteTotal);
                    daPedidoWeb.UpdPedidoWebByEstadoConTotales(CampaniaID, PedidoID, EstadoPedido, false, clientes, importeTotal, CodigoUsuario);
                }
                oTransactionScope.Complete();
            }
        }

        public void InsPedidoWebDetallePROLv2(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl)
        {
            var daPedidoWeb = new DAPedidoWeb(PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                if (olstPedidoWebDetalle != null) daPedidoWebDetalle.UpdListPedidoWebDetalleObsPROL(olstPedidoWebDetalle);

                daPedidoWeb.UpdPedidoWebByEstado(CampaniaID, PedidoID, EstadoPedido, false, CodigoUsuario, MontoTotalProl, DescuentoProl);
                oTransactionScope.Complete();
            }

        }

        public void UpdPedidoWebByEstado(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, bool Eliminar, string CodigoUsuario, bool ValidacionAbierta)
        {
            var daPedidoWeb = new DAPedidoWeb(PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                if (Eliminar)
                {
                    daPedidoWebDetalle.DelPedidoWebDetalleDesglosePedido(CampaniaID, PedidoID);
                    daPedidoWeb.UpdPedidoWebDesReserva(CampaniaID, PedidoID, EstadoPedido, ModificaPedidoReservado, CodigoUsuario, ValidacionAbierta);
                }
                else if (ModificaPedidoReservado)
                    daPedidoWeb.UpdPedidoWebDesReserva(CampaniaID, PedidoID, EstadoPedido, ModificaPedidoReservado, CodigoUsuario, ValidacionAbierta);
                else daPedidoWeb.UpdPedidoWebByEstado(CampaniaID, PedidoID, EstadoPedido, ModificaPedidoReservado, CodigoUsuario, 0, 0);
                oTransactionScope.Complete();
            }
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByPedidoValidado(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.GetPedidoWebDetalleByPedidoValidado(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader, Consultora);
                    entidad.PaisID = paisID;
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public async Task<bool> DelPedidoWebDetalleMasivo(BEUsuario usuario, int pedidoId)
        {
            var daPedidoWeb = new DAPedidoWeb(usuario.PaisID);
            var daPedidoWebDetalle = new DAPedidoWebDetalle(usuario.PaisID);
            var blReserva= new BLReserva();

            TransactionOptions oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    daPedidoWebDetalle.DelPedidoWebDetalleMasivo(usuario.CampaniaID, pedidoId);
                    daPedidoWeb.UpdPedidoWebByEstadoConTotalesMasivo(usuario.CampaniaID, pedidoId, 201, false, 0, 0, usuario.CodigoUsuario);
                    daPedidoWeb.DelIndicadorPedidoAutenticoCompleto(new BEIndicadorPedidoAutentico { PedidoID = pedidoId, CampaniaID = usuario.CampaniaID });
                    
                    oTransactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID);
                return false;
            }

            try { if (usuario.ZonaValida) await blReserva.DeshacerReservaPedido(usuario, pedidoId); }
            catch (Exception ex) { LogManager.SaveLog(ex, usuario.CodigoUsuario, usuario.PaisID); }

            return true;
        }

        public bool DelPedidoWebDetallePackNueva(int PaisID, long ConsultoraID, int PedidoID)
        {
            var daPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            bool success = true;
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    daPedidoWebDetalle.DelPedidoWebDetallePackNueva(ConsultoraID, PedidoID);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception)
            {
                success = false;
            }

            return success;
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByPedidoID(int paisID, int campaniaID, int pedidoID)
        {
            IList<BEPedidoWebDetalle> listaBePedidoWebDetalle = new List<BEPedidoWebDetalle>();
            DAPedidoWebDetalle daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(campaniaID, pedidoID))
                while (reader.Read())
                {
                    BEPedidoWebDetalle bePedidoWebDetalle = new BEPedidoWebDetalle(reader);
                    listaBePedidoWebDetalle.Add(bePedidoWebDetalle);
                }

            return listaBePedidoWebDetalle;
        }

        public void InsPedidoWebAccionesPROL(List<BEPedidoWebDetalle> olstBEPedidoWebDetalle, int Tipo, int Accion)
        {
            var daPedidoWebDetalle = new DAPedidoWebDetalle(olstBEPedidoWebDetalle[0].PaisID);
            foreach (var item in olstBEPedidoWebDetalle)
            {
                daPedidoWebDetalle.InsPedidoWebAccionesPROL(item, Tipo, Accion);
            }
        }

        public bool InsertPedidoWebSet(int paisID, int Campaniaid, int PedidoID, int CantidadSet, string CuvSet, long ConsultoraId, string CodigoUsuario, string CuvsStringList, int EstrategiaId)
        {
            var daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            var result = daPedidoWebDetalle.InsertPedidoWebSet(Campaniaid, PedidoID, CantidadSet, CuvSet, ConsultoraId, CodigoUsuario, CuvsStringList, EstrategiaId);
            
            return result;
        }

        public bool UpdCantidadPedidoWebSet(int paisId, int setId, int cantidad)
        {
            DAPedidoWebDetalle daPedidoWebDetalle = new DAPedidoWebDetalle(paisId);
            return daPedidoWebDetalle.UpdCantidadPedidoWebSet(setId, cantidad);
        }

        public List<BEPedidoWebSetDetalle> GetPedidoWebSetDetalle(int paisID, int campania, long consultoraId)
        {
            DAPedidoWebDetalle daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);
            using (IDataReader reader = daPedidoWebDetalle.GetPedidoWebSetDetalle(campania, consultoraId))
                return reader.MapToCollection<BEPedidoWebSetDetalle>(closeReaderFinishing: true);
        }
    }
}