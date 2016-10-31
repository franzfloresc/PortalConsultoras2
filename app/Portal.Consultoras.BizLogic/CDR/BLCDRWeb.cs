using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLCDRWeb
    {
        public int InsCDRWeb(int PaisID, BECDRWeb entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWeb = new DACDRWeb(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWeb.InsCDRWeb(entity);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception)
            {
                return 0;
            }
        }

        public int DelCDRWeb(int PaisID, BECDRWeb entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWeb = new DACDRWeb(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWeb.DelCDRWeb(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public List<BECDRWeb> GetCDRWeb(int PaisID, BECDRWeb entity)
        {
            var listaEntity = new List<BECDRWeb>();
            
            try
            {
                var DACDRWeb = new DACDRWeb(PaisID);
                using (IDataReader reader = DACDRWeb.GetCDRWeb(entity))
                {
                    while (reader.Read())
                    {
                        listaEntity.Add(new BECDRWeb(reader));
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
