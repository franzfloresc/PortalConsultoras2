using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

using System;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionPaisDatos : IConfiguracionPaisDatosBusinessLogic
    {
        public BEConfiguracionPaisDatos Get(BEConfiguracionPaisDatos entidad)
        {
            BEConfiguracionPaisDatos configuracionPaisDatos;
            try
            {
                var da = new DAConfiguracionPaisDatos(entidad.PaisID);
                using (var reader = da.Get(entidad))
                {
                    configuracionPaisDatos = reader.MapToObject<BEConfiguracionPaisDatos>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
                configuracionPaisDatos = new BEConfiguracionPaisDatos();
            }
            return configuracionPaisDatos;
        }
        
        public List<BEConfiguracionPaisDatos> GetList(BEConfiguracionPaisDatos entidad)
        {
            var lista = new List<BEConfiguracionPaisDatos>();

            try
            {
                using (var reader = new DAConfiguracionPaisDatos(entidad.PaisID).GetList(entidad))
                {
                    lista = reader.MapToCollection<BEConfiguracionPaisDatos>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
            }

            return lista ?? new List<BEConfiguracionPaisDatos>();
        }

        public List<BEConfiguracionPaisDatos> GetListComponente(BEConfiguracionPaisDatos entidad)
        {
            List<BEConfiguracionPaisDatos> lista;

            try
            {
                var da = new DAConfiguracionPaisDatos(entidad.PaisID);
                using (var reader = da.GetListComponente(entidad))
                {
                    lista = reader.MapToCollection<BEConfiguracionPaisDatos>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
                lista = new List<BEConfiguracionPaisDatos>();
            }
            return lista;
        }

        public List<BEConfiguracionPaisDatos> GetListComponenteDatos(BEConfiguracionPaisDatos entidad)
        {
            List<BEConfiguracionPaisDatos> lista;

            try
            {
                var da = new DAConfiguracionPaisDatos(entidad.PaisID);
                using (var reader = da.GetListComponenteDatos(entidad))
                {
                    lista = reader.MapToCollection<BEConfiguracionPaisDatos>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
                lista = new List<BEConfiguracionPaisDatos>();
            }
            return lista;
        }

        public int ConfiguracionPaisDatosGuardar(int paisId, List<BEConfiguracionPaisDatos> listaEntidad)
        {
            try
            {
                var da = new DAConfiguracionPaisDatos(paisId);
                var oTransactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };

                using (var oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    foreach (var paisDato in listaEntidad)
                    {
                        da.Guardar(paisDato);
                    }

                    oTransactionScope.Complete();

                    return 1;
                }

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString());
                return -1;
            }
        }

        public bool ConfiguracionPaisComponenteDeshabilitar(BEConfiguracionPaisDatos entidad)
        {
            try
            {
                var da = new DAConfiguracionPaisDatos(entidad.PaisID);
                da.ConfiguracionPaisComponenteDeshabilitar(entidad);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", entidad.PaisID.ToString());
                return false;
            }
            return true;
        }
        
        
    }
}