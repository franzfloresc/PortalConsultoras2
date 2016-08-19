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
    public class BLPedidoFICDetalle
    {

        public IList<BEPedidoFICDetalle> GetPedidoFICDetalleByCampania(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            var pedidoFICDetalle = new List<BEPedidoFICDetalle>();
            var DAPedidoFICDetalle = new DAPedidoFICDetalle(paisID);

            using (IDataReader reader = DAPedidoFICDetalle.GetPedidoFICDetalleByCampania(CampaniaID, ConsultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoFICDetalle(reader, Consultora);
                    entidad.PaisID = paisID;
                    pedidoFICDetalle.Add(entidad);
                }

            return pedidoFICDetalle;
        }

        public BEPedidoFICDetalle InsPedidoFICDetalle(BEPedidoFICDetalle pedidowebdetalle)
        {
            var DAPedidoFIC = new DAPedidoFIC(pedidowebdetalle.PaisID);
            var DAPedidoFICDetalle = new DAPedidoFICDetalle(pedidowebdetalle.PaisID);
            BEPedidoFICDetalle BEPedidoFICDetalle = null;
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (pedidowebdetalle.PedidoID == 0)
                    {
                        BEPedidoFIC oBEPedidoFIC = new BEPedidoFIC();
                        oBEPedidoFIC.CampaniaID = pedidowebdetalle.CampaniaID;
                        oBEPedidoFIC.ConsultoraID = pedidowebdetalle.ConsultoraID;
                        oBEPedidoFIC.PaisID = pedidowebdetalle.PaisID;
                        oBEPedidoFIC.IPUsuario = pedidowebdetalle.IPUsuario;
                        pedidowebdetalle.PedidoID = DAPedidoFIC.InsPedidoFIC(oBEPedidoFIC);
                    }
                    BEPedidoFICDetalle = DAPedidoFICDetalle.InsPedidoFICDetalle(pedidowebdetalle);
                    DAPedidoFIC.UpdPedidoFICTotales(pedidowebdetalle.CampaniaID, pedidowebdetalle.PedidoID, pedidowebdetalle.Clientes, pedidowebdetalle.ImporteTotalPedido);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }

            return BEPedidoFICDetalle;
        }

        public void UpdPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            var DAPedidoFIC = new DAPedidoFIC(pedidoficdetalle.PaisID);
            var DAPedidoFICDetalle = new DAPedidoFICDetalle(pedidoficdetalle.PaisID);

            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoFICDetalle.UpdPedidoFICDetalle(pedidoficdetalle);
                    DAPedidoFIC.UpdPedidoFICTotales(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.Clientes, pedidoficdetalle.ImporteTotalPedido);
                    if (pedidoficdetalle.TipoOfertaSisID == Portal.Consultoras.Common.Constantes.ConfiguracionOferta.Liquidacion)
                        new DAOfertaProducto(pedidoficdetalle.PaisID).UpdOfertaProductoStockActualizar(pedidoficdetalle.TipoOfertaSisID, pedidoficdetalle.CampaniaID, pedidoficdetalle.CUV, pedidoficdetalle.Stock, pedidoficdetalle.Flag);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }

        }

        public void DelPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            var DAPedidoFIC = new DAPedidoFIC(pedidoficdetalle.PaisID);
            var DAPedidoFICDetalle = new DAPedidoFICDetalle(pedidoficdetalle.PaisID);

            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    if (pedidoficdetalle.PedidoDetalleID != 0)
                        DAPedidoFICDetalle.DelPedidoFICDetalle(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.PedidoDetalleID, pedidoficdetalle.TipoOfertaSisID);
                    else
                        DAPedidoFICDetalle.DelPedidoFICDetalleByCUV(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.CUV);
                    DAPedidoFIC.UpdPedidoFICTotales(pedidoficdetalle.CampaniaID, pedidoficdetalle.PedidoID, pedidoficdetalle.Clientes, pedidoficdetalle.ImporteTotalPedido);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }
        }

        public bool DelPedidoFICDetalleMasivo(int PaisID, int CampaniaID, int PedidoID)
        {
            var DAPedidoFIC = new DAPedidoFIC(PaisID);
            var DAPedidoFICDetalle = new DAPedidoFICDetalle(PaisID);
            bool Success = true;
            TransactionOptions oTransactionOptions = new TransactionOptions();
            oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

            try
            {
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoFICDetalle.DelPedidoFICDetalleMasivo(CampaniaID, PedidoID);
                    DAPedidoFIC.UpdPedidoFICByEstadoConTotalesMasivo(CampaniaID, PedidoID, 201, false, 0, 0);
                    oTransactionScope.Complete();
                }
            }
            catch (Exception) { throw; }

            return Success;
        }

        public void InsTempServiceProl(int PaisID, DataTable ServicePROL)
        {
            var DAPedidoFIC = new DAPedidoFIC(PaisID);

            DAPedidoFIC.InsTempServiceProl(ServicePROL);
        }

        public IList<BEServicePROLFIC> GetReportePedidoFIC(int paisID, string CodigoCampania, string CodigoRegion, string CodigoZona, string CodigoConsultora)
        {
            var pedidoDetalle = new List<BEServicePROLFIC>();
            var DAPedidoFIC = new DAPedidoFIC(paisID);

            using (IDataReader reader = DAPedidoFIC.GetReportePedidoFIC(CodigoCampania, CodigoRegion, CodigoZona, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEServicePROLFIC(reader);
                    pedidoDetalle.Add(entidad);
                }

            return pedidoDetalle;
        }
    }
}
