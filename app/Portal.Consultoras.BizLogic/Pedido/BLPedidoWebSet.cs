﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Pedido;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using System;
using System.Linq;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedidoWebSet : IPedidoWebSetBusinessLogic
    {
        public BEPedidoWebSet Obtener(int paisId, int id)
        {
            var da = new DAPedidoWebSet(paisId);
            var set = da.Obtener(id);

            if (set != null)
                set.Detalles = da.ObtenerDetalles(id);

            return set;
        }

        public bool EliminarTransaction(int paisId, int id, BEPedidoWebDetalleParametros bePedidoWebDetalleParametros)
        {

            try
            {
                if (bePedidoWebDetalleParametros == null)
                {
                    return false;
                }

                var da = new DAPedidoWebSet(paisId);
                var result = da.Eliminar(id);

                var blPedidoWebDetalle = new BLPedidoWebDetalle();
                var daPedidoWebDetalle = new DAPedidoWebDetalle(paisId);
                var listaDetalle = blPedidoWebDetalle.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros);
                var importeTotal = listaDetalle.Sum(p => p.ImporteTotal);

                daPedidoWebDetalle.UpdateImporteTotalPedidoWeb(bePedidoWebDetalleParametros.CampaniaId, bePedidoWebDetalleParametros.ConsultoraId, importeTotal);

                return result > 0;

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, bePedidoWebDetalleParametros.ConsultoraId, paisId);
                return false;
            }
        }

        public bool Eliminar(int paisId, int id, BEPedidoWebDetalleParametros bePedidoWebDetalleParametros)
        {
            TransactionOptions oTransactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
          
            try
            {
                var result = 0;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    var da = new DAPedidoWebSet(paisId);
                    var bLPedidoWebDetalle = new BLPedidoWebDetalle();
                    var daPedidoWebDetalle = new DAPedidoWebDetalle(paisId);

                    result = da.Eliminar(id);
                    
                    var listaDetalle = bLPedidoWebDetalle.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros);
                    var importeTotal = listaDetalle.Sum(p => p.ImporteTotal);

                    daPedidoWebDetalle.UpdateImporteTotalPedidoWeb(bePedidoWebDetalleParametros.CampaniaId, bePedidoWebDetalleParametros.ConsultoraId, importeTotal);

                    oTransactionScope.Complete();

                    return result > 0;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public DateTime? ObtenerFechaInicioSets(int paisId)
        {
            DateTime? response = null;
            var da = new DAPedidoWebSet(paisId);
            response = da.ObtenerFechaInicioSets();

            return response;
        }
    }
}
