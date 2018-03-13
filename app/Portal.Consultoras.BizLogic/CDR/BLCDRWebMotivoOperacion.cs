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
                int retorno;
                var daCdrWebMotivoOperacion = new DACDRWebMotivoOperacion(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = daCdrWebMotivoOperacion.InsCDRWebMotivoOperacion(entity);
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
                int retorno;
                var daCdrWebMotivoOperacion = new DACDRWebMotivoOperacion(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = daCdrWebMotivoOperacion.DelCDRWebMotivoOperacion(entity);
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
                var daCdrWebMotivoOperacion = new DACDRWebMotivoOperacion(PaisID);
                using (IDataReader reader = daCdrWebMotivoOperacion.GetCDRWebMotivoOperacion(entity))
                {
                    while (reader.Read())
                    {
                        var entidad = new BECDRWebMotivoOperacion(reader)
                        {
                            CDRMotivoReclamo = new BECDRMotivoReclamo(reader),
                            CDRTipoOperacion = new BECDRTipoOperacion(reader)
                        };
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