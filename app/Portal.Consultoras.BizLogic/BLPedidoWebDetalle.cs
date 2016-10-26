using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoWebDetalle
    {
        public IList<BEPedidoWebDetalle> GetClientesByCampania(int paisID, int campaniaID, long consultoraID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = DAPedidoWebDetalle.GetClientesByCampania(campaniaID, consultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader);
                    entidad.PaisID = paisID;
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        //EPD-1164
        public IList<BEPedidoWebDetalle> GetClientesByCampaniaByClienteID(int paisID, int campaniaID, long consultoraID, string ClienteID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = DAPedidoWebDetalle.GetClientesByCampaniaByClienteID(campaniaID, consultoraID, ClienteID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader);
                    entidad.PaisID = paisID;
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCliente(int paisID, int campaniaID, long consultoraID, int clienteID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = DAPedidoWebDetalle.GetPedidoWebDetalleByCliente(campaniaID, consultoraID, clienteID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader);
                    entidad.PaisID = paisID;
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public BEPedidoWebDetalle InsPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            var DAPedidoWeb = new DAPedidoWeb(pedidowebdetalle.PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle.PaisID);
            BEPedidoWebDetalle BEPedidoWebDetalle = null;
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (pedidowebdetalle.PedidoID == 0)
                    {
                        BEPedidoWeb oBEPedidoWeb = new BEPedidoWeb();
                        oBEPedidoWeb.CampaniaID = pedidowebdetalle.CampaniaID;
                        oBEPedidoWeb.ConsultoraID = pedidowebdetalle.ConsultoraID;
                        oBEPedidoWeb.PaisID = pedidowebdetalle.PaisID;
                        oBEPedidoWeb.IPUsuario = pedidowebdetalle.IPUsuario;
                        oBEPedidoWeb.CodigoUsuarioCreacion = pedidowebdetalle.CodigoUsuarioCreacion;
                        pedidowebdetalle.PedidoID = DAPedidoWeb.InsPedidoWeb(oBEPedidoWeb);
                    }
                    BEPedidoWebDetalle = DAPedidoWebDetalle.InsPedidoWebDetalle(pedidowebdetalle);
                    DAPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido, pedidowebdetalle.CodigoUsuarioModificacion);
                    
                    if (pedidowebdetalle.TipoOfertaSisID == Common.Constantes.ConfiguracionOferta.ShowRoom)
                        new DAShowRoomEvento(pedidowebdetalle.PaisID).UpdOfertaShowRoomStockAgregar(Common.Constantes.ConfiguracionOferta.ShowRoom, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    if (pedidowebdetalle.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockAgregar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    /* 2108 - Inicio */
                    if (pedidowebdetalle.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockAgregar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);
                    /* 2108 - Fin */

                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }

            return BEPedidoWebDetalle;
        }

        public void UpdPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            var DAPedidoWeb = new DAPedidoWeb(pedidowebdetalle.PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle.PaisID);

            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoWebDetalle.UpdPedidoWebDetalle(pedidowebdetalle);
                    DAPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido, pedidowebdetalle.CodigoUsuarioModificacion);
                    
                    if (pedidowebdetalle.TipoOfertaSisID == Common.Constantes.ConfiguracionOferta.ShowRoom)
                        new DAShowRoomEvento(pedidowebdetalle.PaisID).UpdOfertaShowRoomStockActualizar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV,pedidowebdetalle.Stock, pedidowebdetalle.Flag);

                    if (pedidowebdetalle.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockActualizar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Stock, pedidowebdetalle.Flag);

                    /* 2108 - Inicio */
                    if (pedidowebdetalle.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockActualizar(pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Stock, pedidowebdetalle.Flag);
                    /* 2108 - Fin */

                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }
        }

        public short UpdPedidoWebDetalleMasivo(List<BEPedidoWebDetalle> pedidowebdetalle)
        {
            short updated = 0;
            var DAPedidoWeb = new DAPedidoWeb(pedidowebdetalle[0].PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle[0].PaisID);
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    foreach (var item in pedidowebdetalle)
                    {
                        DAPedidoWebDetalle.UpdPedidoWebDetalle(item);
                    }
                    DAPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle[0].CampaniaID, pedidowebdetalle[0].PedidoID, pedidowebdetalle[0].Clientes, pedidowebdetalle[0].ImporteTotalPedido, pedidowebdetalle[0].CodigoUsuarioModificacion);
                    updated = 1;
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }

            return updated;
        }

        public void DelPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            var DAPedidoWeb = new DAPedidoWeb(pedidowebdetalle.PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(pedidowebdetalle.PaisID);

            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (pedidowebdetalle.PedidoDetalleID != 0)
                        DAPedidoWebDetalle.DelPedidoWebDetalle(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.PedidoDetalleID, pedidowebdetalle.TipoOfertaSisID, pedidowebdetalle.Mensaje);
                    else
                        DAPedidoWebDetalle.DelPedidoWebDetalleByCUV(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.CUV);
                    DAPedidoWeb.UpdPedidoWebTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido, pedidowebdetalle.CodigoUsuarioModificacion);
                    /*R20150905*/
                    if (pedidowebdetalle.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                        new DAOfertaProducto(pedidowebdetalle.PaisID).UpdOfertaProductoStockEliminar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    if (pedidowebdetalle.TipoOfertaSisID == Common.Constantes.ConfiguracionOferta.ShowRoom)
                        new DAShowRoomEvento(pedidowebdetalle.PaisID).UpdOfertaShowRoomStockEliminar(Common.Constantes.ConfiguracionOferta.ShowRoom, pedidowebdetalle.CampaniaID, pedidowebdetalle.CUV, pedidowebdetalle.Cantidad);

                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }
            }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCampania(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = DAPedidoWebDetalle.GetPedidoWebDetalleByCampania(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader, Consultora);
                    entidad.PaisID = paisID;
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public IList<BEPedidoDDWebDetalle> GetPedidosDDWebDetalleByCampaniaPedido(int paisID, int CampaniaID, int PedidoID)
        {
            var pedidoDDWebDetalle = new List<BEPedidoDDWebDetalle>();
            //var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            //using (IDataReader reader = DAPedidoWebDetalle.GetPedidosDDWebDetalleByCampaniaPedido(CampaniaID, PedidoID))
            //    while (reader.Read())
            //    {
            //        var entidad = new BEPedidoDDWebDetalle(reader);
            //        pedidoDDWebDetalle.Add(entidad);
            //    }

            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "00052", Descripcion = "Producto 1", Cantidad = 10, PrecioUnitario = 15, PrecioTotal = 150 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "00036", Descripcion = "Producto 2", Cantidad = 4, PrecioUnitario = 5, PrecioTotal = 20 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "00452", Descripcion = "Producto 3", Cantidad = 6, PrecioUnitario = 22, PrecioTotal = 132 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "00425", Descripcion = "Producto 4", Cantidad = 7, PrecioUnitario = 13, PrecioTotal = 91 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "05267", Descripcion = "Producto 5", Cantidad = 8, PrecioUnitario = 2, PrecioTotal = 16 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "04216", Descripcion = "Producto 6", Cantidad = 2, PrecioUnitario = 4, PrecioTotal = 8 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "75896", Descripcion = "Producto 7", Cantidad = 5, PrecioUnitario = 8, PrecioTotal = 40 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "10547", Descripcion = "Producto 8", Cantidad = 8, PrecioUnitario = 1, PrecioTotal = 8 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "13859", Descripcion = "Producto 9", Cantidad = 5, PrecioUnitario = 1, PrecioTotal = 5 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "25698", Descripcion = "Producto 10", Cantidad = 9, PrecioUnitario = 8, PrecioTotal = 72 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "26574", Descripcion = "Producto 11", Cantidad = 4, PrecioUnitario = 12, PrecioTotal = 48 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "25896", Descripcion = "Producto 12", Cantidad = 8, PrecioUnitario = 4, PrecioTotal = 32 });
            pedidoDDWebDetalle.Add(new BEPedidoDDWebDetalle { CUV = "24545", Descripcion = "Producto 13", Cantidad = 18, PrecioUnitario = 13, PrecioTotal = 234 });

            return pedidoDDWebDetalle;
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByOfertaWeb(int paisID, int CampaniaID, long ConsultoraID, bool OfertaWeb)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = DAPedidoWebDetalle.GetPedidoWebDetalleByOfertaWeb(CampaniaID, ConsultoraID, OfertaWeb))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader);
                    entidad.PaisID = paisID;
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        #region Consulta y Bloquedo de Pedido
        public IList<BEPedidoWebDetalle> SelectDetalleBloqueoPedidoByPedidoId(int paisID, int PedidoID)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = DAPedidoWebDetalle.SelectDetalleBloqueoPedidoByPedidoId(PedidoID))
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
            var DAPedidoWeb = new DAPedidoWeb(PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoWebDetalle.DelPedidoWebDetalleDesglosePedido(CampaniaID, PedidoID);
                    foreach (var item in olstPedidoWebDetalle)
                    {
                        if (!item.CUVNuevo)
                        {
                            switch (item.EstadoItem)
                            {
                                case 2:
                                    DAPedidoWebDetalle.UpdPedidoWebDetalle(item);
                                    if (item.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                                        new DAOfertaProducto(PaisID).UpdOfertaProductoStockActualizar(item.TipoOfertaSisID, item.CampaniaID, item.CUV, item.Stock, item.Flag);
                                    /* 2108 - Inicio */
                                    if (item.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate)
                                        new DAOfertaProducto(PaisID).UpdOfertaProductoStockActualizar(item.TipoOfertaSisID, item.CampaniaID, item.CUV, item.Stock, item.Flag);
                                    /* 2108 - Fin */
                                    break;
                                case 3:
                                    DAPedidoWebDetalle.DelPedidoWebDetalle(item.CampaniaID, item.PedidoID, item.PedidoDetalleID, item.TipoOfertaSisID, string.Empty);
                                    if (item.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                                        new DAOfertaProducto(PaisID).UpdOfertaProductoStockEliminar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion, item.CampaniaID, item.CUV, item.Cantidad);
                                    break;
                                default:
                                    if (item.CUVPadre == "0")
                                    {
                                        DAPedidoWebDetalle.InsPedidoWebDetallePROL(item);
                                        if (item.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                                            new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion, item.CampaniaID, item.CUV, item.Cantidad);
                                        /* 2108 - Inicio */
                                        if (item.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate)
                                            new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate, item.CampaniaID, item.CUV, item.Cantidad);
                                        /* 2108 - Fin */
                                    }
                                    break;
                            }
                        }
                        else
                        {
                            if (item.EstadoItem == 1 || item.EstadoItem == 2)
                            {
                                DAPedidoWebDetalle.InsPedidoWebDetalle(item);
                                if (item.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                                    new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion, item.CampaniaID, item.CUV, item.Cantidad);
                                /* 2108 - Inicio */
                                if (item.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate)
                                    new DAOfertaProducto(PaisID).UpdOfertaProductoStockAgregar(Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Accesorizate, item.CampaniaID, item.CUV, item.Cantidad);
                                /* 2108 - Fin */
                            }
                        }
                    }

                    if (ModificaPedido == 0)
                        DAPedidoWeb.UpdPedidoWebByEstado(CampaniaID, PedidoID, EstadoPedido, false, CodigoUsuario, MontoTotalProl, DescuentoProl);
                    else
                    {
                        int Clientes = olstPedidoWebDetalle.Where(p => p.EstadoItem != 3 && p.ClienteID != 0).Select(p => p.ClienteID).Distinct().Count();
                        decimal ImporteTotal = olstPedidoWebDetalle.Where(p => p.EstadoItem != 3).Sum(p => p.ImporteTotal);
                        DAPedidoWeb.UpdPedidoWebByEstadoConTotales(CampaniaID, PedidoID, EstadoPedido, false, Clientes, ImporteTotal, CodigoUsuario);
                    }
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }
            }

        //CCSS_JZ_PROL
        public void InsPedidoWebDetallePROLv2(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, bool ValidacionAbierta, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl)
        {
            var DAPedidoWeb = new DAPedidoWeb(PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (olstPedidoWebDetalle != null)
                    {
                        //Limpieza
                        foreach (var item in olstPedidoWebDetalle)
                        {
                            DAPedidoWebDetalle.UpdPedidoWebDetalleObsPROL(item, false);
                        }
                        //Insercion
                        foreach (var item in olstPedidoWebDetalle)
                        {
                            DAPedidoWebDetalle.UpdPedidoWebDetalleObsPROL(item, true);
                        }
                    }
                    DAPedidoWeb.UpdPedidoWebByEstado(CampaniaID, PedidoID, EstadoPedido, false, CodigoUsuario, MontoTotalProl, DescuentoProl);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }
        }

        //CCSS_JZ_PROL
        public void UpdPedidoWebByEstado(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, bool Eliminar, string CodigoUsuario, bool ValidacionAbierta)
        {
            var DAPedidoWeb = new DAPedidoWeb(PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (Eliminar)
                    {
                        DAPedidoWebDetalle.DelPedidoWebDetalleDesglosePedido(CampaniaID, PedidoID);
                        DAPedidoWeb.UpdPedidoWebDesReserva(CampaniaID, PedidoID, EstadoPedido, ModificaPedidoReservado, CodigoUsuario, ValidacionAbierta);
                    }
                    else if (ModificaPedidoReservado)
                        //Se reutiliza UpdPedidoWebDesReserva debido a que no actualiza la fecha de reserva. 
                        DAPedidoWeb.UpdPedidoWebDesReserva(CampaniaID, PedidoID, EstadoPedido, ModificaPedidoReservado, CodigoUsuario, ValidacionAbierta);
                    else DAPedidoWeb.UpdPedidoWebByEstado(CampaniaID, PedidoID, EstadoPedido, ModificaPedidoReservado, CodigoUsuario, 0, 0);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByPedidoValidado(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            var pedidoWebDetalle = new List<BEPedidoWebDetalle>();
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = DAPedidoWebDetalle.GetPedidoWebDetalleByPedidoValidado(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader, Consultora);
                    entidad.PaisID = paisID;
                    pedidoWebDetalle.Add(entidad);
                }

            return pedidoWebDetalle;
        }

        public bool DelPedidoWebDetalleMasivo(int PaisID, int CampaniaID, int PedidoID, string CodigoUsuario)
        {
            var DAPedidoWeb = new DAPedidoWeb(PaisID);
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            bool Success = true;
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoWebDetalle.DelPedidoWebDetalleMasivo(CampaniaID, PedidoID);
                    DAPedidoWeb.UpdPedidoWebByEstadoConTotalesMasivo(CampaniaID, PedidoID, 201, false, 0, 0, CodigoUsuario);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception)
            {
                Success = false;
            }

            return Success;
        }

        public bool DelPedidoWebDetallePackNueva(int PaisID, long ConsultoraID, int PedidoID)
        {
            var DAPedidoWebDetalle = new DAPedidoWebDetalle(PaisID);
            bool Success = true;
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoWebDetalle.DelPedidoWebDetallePackNueva(ConsultoraID, PedidoID);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception)
            {
                Success = false;
            }

            return Success;
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByPedidoID(int paisID, int campaniaID, int pedidoID)
        {
            IList<BEPedidoWebDetalle> listaBEPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            DAPedidoWebDetalle daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);

            using (IDataReader reader = daPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(campaniaID, pedidoID))
                while (reader.Read())
                {
                    BEPedidoWebDetalle bePedidoWebDetalle = new BEPedidoWebDetalle(reader);
                    listaBEPedidoWebDetalle.Add(bePedidoWebDetalle);
                }

            return listaBEPedidoWebDetalle;
        }

        public void InsPedidoWebAccionesPROL(List<BEPedidoWebDetalle> olstBEPedidoWebDetalle, int Tipo, int Accion)
        {
            try
            {
                var DAPedidoWebDetalle = new DAPedidoWebDetalle(olstBEPedidoWebDetalle[0].PaisID);
                foreach (var item in olstBEPedidoWebDetalle)
                {
                    DAPedidoWebDetalle.InsPedidoWebAccionesPROL(item, Tipo, Accion);
                }

            }
            catch
            {

            }

        }
    }
}
