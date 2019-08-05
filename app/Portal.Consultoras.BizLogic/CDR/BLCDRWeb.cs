﻿using Portal.Consultoras.Data.CDR;
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
                int retorno;
                var dacdrWeb = new DACDRWeb(PaisID);
                var dacdrWeDetalle = new DACDRWebDetalle(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = dacdrWeb.InsCDRWeb(entity);

                    if (retorno <= 0)
                        oTransactionScope.Dispose();

                    entity.CDRWebDetalle = entity.CDRWebDetalle ?? new List<BECDRWebDetalle>();
                    if (entity.CDRWebDetalle.Count > 0)
                    {
                        foreach (var detalle in entity.CDRWebDetalle)
                        {
                            detalle.CDRWebID = retorno;
                            var idDetalle = dacdrWeDetalle.InsCDRWebDetalle(detalle);
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
            catch (Exception ex)
            {
                return 0;
            }
        }

        public int DelCDRWeb(int PaisID, BECDRWeb entity)
        {
            try
            {
                int retorno;
                var dacdrWeb = new DACDRWeb(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = dacdrWeb.DelCDRWeb(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public List<BECDRWeb> GetCDRWeb(int PaisID, BECDRWeb entity, int Esmobile = 0)
        {
            var listaEntity = new List<BECDRWeb>();
            try
            {
                var dacdrWeb = new DACDRWeb(PaisID);
                IDataReader reader;
                if (Esmobile == 1)
                    reader = dacdrWeb.GetCDRWebMobile(entity);
                else
                    reader = dacdrWeb.GetCDRWeb(entity);

                using (reader)
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
                int retorno;
                var dacdrWeb = new DACDRWeb(PaisID);
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    retorno = dacdrWeb.UpdEstadoCDRWeb(entity);
                    oTransactionScope.Complete();
                }
                return retorno;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public IList<BECDRWebDetalleReporte> GetCDRWebDetalleReporte(int PaisID, BECDRWeb entity)
        {
            var listaEntity = new List<BECDRWebDetalleReporte>();

            try
            {
                var dacdrWeb = new DACDRWeb(PaisID);
                using (IDataReader reader = dacdrWeb.GetCDRWebDetalleReporte(entity))
                {
                    while (reader.Read())
                    {
                        var entidad = new BECDRWebDetalleReporte(reader);
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

        public BECDRWeb GetMontoFletePorZonaId(int PaisID, int ZonaId)
        {
            try
            {
                decimal monto = 0.00M;
                var dacdrWeb = new DACDRWeb(PaisID);
                using (IDataReader reader = dacdrWeb.GetMontoFletePorZonaId(ZonaId))
                {
                    while (reader.Read())
                    {
                        monto = reader["Monto"] is DBNull ? 0.00M : reader.GetDecimal(reader.GetOrdinal("Monto"));
                    }
                }
                return new BECDRWeb() { FleteDespacho = monto };
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}