using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLCDRWebDetalle
    {
        public int InsCDRWebDetalle(int PaisID, BECDRWebDetalle entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWebDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWebDetalle.InsCDRWebDetalle(entity);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception)
            {
                return 0;
            }
        }

        public int DelCDRWebDetalle(int PaisID, BECDRWebDetalle entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWebDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWebDetalle.DelCDRWebDetalle(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public List<BECDRWebDetalle> GetCDRWebDetalle(int PaisID, BECDRWebDetalle entity, int pedidoId)
        {
            var listaEntity = new List<BECDRWebDetalle>();

            try
            {
                var DACDRWebDetalle = new DACDRWebDetalle(PaisID);
                using (IDataReader reader = DACDRWebDetalle.GetCDRWebDetalle(entity, pedidoId))
                {
                    while (reader.Read())
                    {
                        listaEntity.Add(new BECDRWebDetalle(reader));
                    }
                }
                return listaEntity;

            }
            catch (Exception)
            {
                return listaEntity;
            }
        }

        public List<BECDRWebDetalle> GetCDRWebDetalleLog(int PaisID, BELogCDRWeb entity)
        {
            var listaEntity = new List<BECDRWebDetalle>();

            try
            {
                var DACDRWebDetalle = new DACDRWebDetalle(PaisID);
                using (IDataReader reader = DACDRWebDetalle.GetCDRWebDetalleLog(entity))
                {
                    while (reader.Read())
                    {
                        listaEntity.Add(new BECDRWebDetalle(reader));
                    }
                }
                return listaEntity;

            }
            catch (Exception)
            {
                return listaEntity;
            }
        }

        public bool DetalleActualizarObservado(int paisId, List<BECDRWebDetalle> lista)
        {
            var resultado = false;

            try
            {
                var DACDRWebDetalle = new DACDRWebDetalle(paisId);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    foreach (var becdrWebDetalle in lista)
                    {
                        DACDRWebDetalle.UpdCdrWebDetalleCantidadObservado(becdrWebDetalle);
                    }
                    
                    oTransactionScope.Complete();
                }
                resultado = true;
            }
            catch (Exception)
            {
                resultado = false;
            }

            return resultado;
        }

    }
}
