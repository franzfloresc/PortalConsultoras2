using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLCDRWebMotivoOperacion
    {
        public int InsCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWebMotivoOperacion = new DACDRWebMotivoOperacion(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWebMotivoOperacion.InsCDRWebMotivoOperacion(entity);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception)
            {
                return 0;
            }
        }

        public int DelCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWebMotivoOperacion = new DACDRWebMotivoOperacion(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWebMotivoOperacion.DelCDRWebMotivoOperacion(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public List<BECDRWebMotivoOperacion> GetCDRWebMotivoOperacion(int PaisID, BECDRWebMotivoOperacion entity)
        {
            var listaEntity = new List<BECDRWebMotivoOperacion>();

            try
            {
                var DACDRWebMotivoOperacion = new DACDRWebMotivoOperacion(PaisID);
                using (IDataReader reader = DACDRWebMotivoOperacion.GetCDRWebMotivoOperacion(entity))
                {
                    while (reader.Read())
                    {
                        var entidad = new BECDRWebMotivoOperacion(reader);
                        entidad.CDRMotivoReclamo = new BECDRMotivoReclamo(reader);
                        entidad.CDRTipoOperacion = new BECDRTipoOperacion(reader);
                        listaEntity.Add(entidad);
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
