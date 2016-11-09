using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLCDRWebDescripcion
    {
        public int InsCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWebDescripcion = new DACDRWebDescripcion(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWebDescripcion.InsCDRWebDescripcion(entity);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception)
            {
                return 0;
            }
        }

        public int DelCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWebDescripcion = new DACDRWebDescripcion(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWebDescripcion.DelCDRWebDescripcion(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public List<BECDRWebDescripcion> GetCDRWebDescripcion(int PaisID, BECDRWebDescripcion entity)
        {
            var listaEntity = new List<BECDRWebDescripcion>();

            try
            {
                var DACDRWebDescripcion = new DACDRWebDescripcion(PaisID);
                using (IDataReader reader = DACDRWebDescripcion.GetCDRWebDescripcion(entity))
                {
                    while (reader.Read())
                    {
                        listaEntity.Add(new BECDRWebDescripcion(reader));
                    }
                }
                return listaEntity;

            }
            catch (Exception)
            {
                return listaEntity;
            }
        }

    }
}
