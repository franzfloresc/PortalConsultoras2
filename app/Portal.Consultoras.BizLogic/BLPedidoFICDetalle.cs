using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoFICDetalle
    {

        public IList<BEPedidoFICDetalle> GetPedidoFICDetalleByCampania(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            var pedidoFicDetalle = new List<BEPedidoFICDetalle>();
            var daPedidoFicDetalle = new DAPedidoFICDetalle(paisID);

            using (IDataReader reader = daPedidoFicDetalle.GetPedidoFICDetalleByCampania(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoFICDetalle(reader, Consultora);
                    entidad.PaisID = paisID;
                    pedidoFicDetalle.Add(entidad);
                }

            return pedidoFicDetalle;
        }

        public BEPedidoFICDetalle InsPedidoFICDetalle(BEPedidoFICDetalle pedidowebdetalle)
        {
            var daPedidoFic = new DAPedidoFIC(pedidowebdetalle.PaisID);
            var daPedidoFicDetalle = new DAPedidoFICDetalle(pedidowebdetalle.PaisID);
            BEPedidoFICDetalle bePedidoFicDetalle;
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                if (pedidowebdetalle.PedidoID == 0)
                {
                    BEPedidoFIC obePedidoFic = new BEPedidoFIC
                    {
                        CampaniaID = pedidowebdetalle.CampaniaID,
                        ConsultoraID = pedidowebdetalle.ConsultoraID,
                        PaisID = pedidowebdetalle.PaisID,
                        IPUsuario = pedidowebdetalle.IPUsuario
                    };
                    pedidowebdetalle.PedidoID = daPedidoFic.InsPedidoFIC(obePedidoFic);
                }
                bePedidoFicDetalle = daPedidoFicDetalle.InsPedidoFICDetalle(pedidowebdetalle);
                daPedidoFic.UpdPedidoFICTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido);
                oTransactionScope.Complete();
            }

            return bePedidoFicDetalle;
        }

        public void UpdPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            var daPedidoFic = new DAPedidoFIC(pedidoficdetalle.PaisID);
            var daPedidoFicDetalle = new DAPedidoFICDetalle(pedidoficdetalle.PaisID);

            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                daPedidoFicDetalle.UpdPedidoFICDetalle(pedidoficdetalle);
                daPedidoFic.UpdPedidoFICTotales(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.Clientes, pedidoficdetalle.ImporteTotalPedido);
                if (pedidoficdetalle.TipoOfertaSisID == Common.Constantes.ConfiguracionOferta.Liquidacion)
                    new DAOfertaProducto(pedidoficdetalle.PaisID).UpdOfertaProductoStockActualizar(pedidoficdetalle.TipoOfertaSisID, pedidoficdetalle.CampaniaID, pedidoficdetalle.CUV, pedidoficdetalle.Stock, pedidoficdetalle.Flag);
                oTransactionScope.Complete();
            }

        }

        public void DelPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            var daPedidoFic = new DAPedidoFIC(pedidoficdetalle.PaisID);
            var daPedidoFicDetalle = new DAPedidoFICDetalle(pedidoficdetalle.PaisID);

            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                if (pedidoficdetalle.PedidoDetalleID != 0)
                    daPedidoFicDetalle.DelPedidoFICDetalle(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.PedidoDetalleID, pedidoficdetalle.TipoOfertaSisID);
                else
                    daPedidoFicDetalle.DelPedidoFICDetalleByCUV(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.CUV);
                daPedidoFic.UpdPedidoFICTotales(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.Clientes, pedidoficdetalle.ImporteTotalPedido);
                oTransactionScope.Complete();
            }
        }

        public bool DelPedidoFICDetalleMasivo(int PaisID, int CampaniaID, int PedidoID)
        {
            var daPedidoFic = new DAPedidoFIC(PaisID);
            var daPedidoFicDetalle = new DAPedidoFICDetalle(PaisID);
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

            using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
            {
                daPedidoFicDetalle.DelPedidoFICDetalleMasivo(CampaniaID, PedidoID);
                daPedidoFic.UpdPedidoFICByEstadoConTotalesMasivo(CampaniaID, PedidoID, 201, false, 0, 0);
                oTransactionScope.Complete();
            }

            return true;
        }

        public void InsTempServiceProl(int PaisID, DataTable ServicePROL)
        {
            var daPedidoFic = new DAPedidoFIC(PaisID);

            daPedidoFic.InsTempServiceProl(ServicePROL);
        }

        public IList<BEServicePROLFIC> GetReportePedidoFIC(int paisID, string CodigoCampania, string CodigoRegion, string CodigoZona, string CodigoConsultora)
        {
            var pedidoDetalle = new List<BEServicePROLFIC>();
            var daPedidoFic = new DAPedidoFIC(paisID);

            using (IDataReader reader = daPedidoFic.GetReportePedidoFIC(CodigoCampania, CodigoRegion, CodigoZona, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEServicePROLFIC(reader);
                    pedidoDetalle.Add(entidad);
                }

            return pedidoDetalle;
        }
    }
}
