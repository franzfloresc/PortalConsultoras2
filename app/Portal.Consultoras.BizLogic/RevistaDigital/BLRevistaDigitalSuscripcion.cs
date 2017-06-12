﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Data.RevistaDigital;
using Portal.Consultoras.Entities.RevistaDigital;
using System;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.RevistaDigital
{
    public class BLRevistaDigitalSuscripcion
    {
        public int Suscripcion(BERevistaDigitalSuscripcion entidad)
        {
            try
            {
                var retorno = 0;
                var da = new DARevistaDigitalSuscripcion(entidad.PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = da.Suscripcion(entidad);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, entidad.CodigoConsultora, entidad.PaisID.ToString());
                return 0;
            }
        }

        public int Desuscripcion(BERevistaDigitalSuscripcion entidad)
        {
            try
            {
                var retorno = 0;
                var da = new DARevistaDigitalSuscripcion(entidad.PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = da.Desuscripcion(entidad);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, entidad.CodigoConsultora, entidad.PaisID.ToString());
                return 0;
            }
        }

        public BERevistaDigitalSuscripcion Single(BERevistaDigitalSuscripcion entidad)
        {
            var entity = new BERevistaDigitalSuscripcion();

            try
            {
                var da = new DARevistaDigitalSuscripcion(entidad.PaisID);
                using (IDataReader reader = da.Single(entidad))
                {
                    while (reader.Read())
                    {
                        entity = new BERevistaDigitalSuscripcion(reader);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, entidad.CodigoConsultora, entidad.PaisID.ToString());
                entity = new BERevistaDigitalSuscripcion();
            }
            return entity;
        }
    }
}
