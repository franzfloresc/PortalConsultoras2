﻿using Portal.Consultoras.Data.CDR;
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

        public List<BECDRWebDetalle> GetCDRWebDetalle(int PaisID, BECDRWebDetalle entity)
        {
            var listaEntity = new List<BECDRWebDetalle>();

            try
            {
                var DACDRWebDetalle = new DACDRWebDetalle(PaisID);
                using (IDataReader reader = DACDRWebDetalle.GetCDRWebDetalle(entity))
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

    }
}
