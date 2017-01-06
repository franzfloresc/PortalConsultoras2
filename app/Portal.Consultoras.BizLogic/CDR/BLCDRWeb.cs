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
                var DACDRWeDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWeb.InsCDRWeb(entity);

                    if (retorno <= 0)
                        oTransactionScope.Dispose();

                    entity.CDRWebDetalle = entity.CDRWebDetalle ?? new List<BECDRWebDetalle>();
                    if (entity.CDRWebDetalle.Count > 0)
                    {
                        foreach (var detalle in entity.CDRWebDetalle)
                        {
                            detalle.CDRWebID = retorno;
                            var idDetalle = DACDRWeDetalle.InsCDRWebDetalle(detalle);
                            if (idDetalle <= 0)
                            {
                                retorno = 0;
                                oTransactionScope.Dispose(); 
                            }                           
                        }
                    }
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

        public int UpdEstadoCDRWeb(int PaisID, BECDRWeb entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWeb = new DACDRWeb(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWeb.UpdEstadoCDRWeb(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        
        
        /// <summary>
        /// Author		: José Enrique Ernesto Pairazamán Arellano - Hundred
        /// Create date	: 05/01/2017
        /// Description	: EPD-1423: CDR Web - Notificaciones y Correo Parte 2
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int InsNotificacionRegistroCDR(int PaisID, BECDRWeb entity)
        {
            try
            {
                var retorno = 0;
                var DACDRWeb = new DACDRWeb(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = DACDRWeb.InsNotificacionRegistroCDR(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    
    
    }
}
