using Portal.Consultoras.BizLogic.CaminoBrillante;
using Portal.Consultoras.BizLogic.Pedido;
using Portal.Consultoras.BizLogic.Reserva;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Exceptions;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Pedido;
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
    public partial class BLPedidoWebPromocion : IPedidoWebPromocionBusinessLogic
    {
        public IList<BEPedidoWebPromocion> GetCondicionesByPromocion(BEPedidoWebPromocion BEPedidoWebPromocion, int paisID)
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

        public IList<BEPedidoWebPromocion> GetPromocionesByCondicion(BEPedidoWebPromocion BEPedidoWebPromocion, int paisID)
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

        public bool InsertPedidoWebPromocion(List<BEPedidoWebPromocion> pedidoWebPromociones, int paisID)
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
    }
}