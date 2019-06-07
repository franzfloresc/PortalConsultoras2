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
                int retorno;
                var daCdrWebDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = daCdrWebDetalle.InsCDRWebDetalle(entity);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception)
            {
                return 0;
            }
        }

        public int UpdCDRWebDetalle(int PaisID, BECDRWebDetalle entity)
        {
            try
            {
                int retorno;
                var daCdrWebDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = daCdrWebDetalle.UpdCDRWebDetalle(entity);
                    oTransactionScope.Complete();
                }
                return retorno;

            }
            catch (Exception)
            {
                return 0;
            }
        }
        //HD-3703 EINCA
        public int InsCDRWebDetalle(int PaisID, List<BECDRWebDetalle> detalle)
        {
            try
            {
                int retorno = 1;             
                var dacdrWeDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    foreach (var item in detalle)
                    {
                        var idDetalle = dacdrWeDetalle.InsCDRWebDetalle(item);
                        if (idDetalle <= 0)
                        {
                            retorno = 0;
                            oTransactionScope.Dispose();
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
        public int DelCDRWebDetalle(int PaisID, BECDRWebDetalle entity)
        {
            try
            {
                int retorno;
                var daCdrWebDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = daCdrWebDetalle.DelCDRWebDetalle(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        //HD-3703 EINCA
        public int DelCDRWebDetalle(int PaisID, List<BECDRWebDetalle> listDetalle)
        {
            try
            {
                int retorno = 1;
                var daCdrWebDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    foreach (var item in listDetalle)
                    {
                        var result = daCdrWebDetalle.DelCDRWebDetalle(item);
                        if (result <= 0 )
                        {
                            retorno = 0;
                            oTransactionScope.Dispose();
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

        

        public List<BECDRWebDetalle> GetCDRWebDetalle(int PaisID, BECDRWebDetalle entity, int pedidoId)
        {
            var listaEntity = new List<BECDRWebDetalle>();

            try
            {
                var daCdrWebDetalle = new DACDRWebDetalle(PaisID);
                using (IDataReader reader = daCdrWebDetalle.GetCDRWebDetalle(entity, pedidoId))
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
                var daCdrWebDetalle = new DACDRWebDetalle(PaisID);
                using (IDataReader reader = daCdrWebDetalle.GetCDRWebDetalleLog(entity))
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
            bool resultado;

            try
            {
                var daCdrWebDetalle = new DACDRWebDetalle(paisId);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    foreach (var becdrWebDetalle in lista)
                    {
                        daCdrWebDetalle.UpdCdrWebDetalleCantidadObservado(becdrWebDetalle);
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
        public int ValCUVEnProcesoReclamo(int paisId, int pedidoId, string cuv)
        {
            try
            {
                var daCdrWebDetalle = new DACDRWebDetalle(paisId);
                return daCdrWebDetalle.ValCUVEnProcesoReclamo(pedidoId, cuv);
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}