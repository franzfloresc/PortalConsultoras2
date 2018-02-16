using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionPaisDatos
    {
        public List<BEConfiguracionPaisDatos> GetList(BEConfiguracionPaisDatos entidad)
        {
            var lista = new List<BEConfiguracionPaisDatos>();

            try
            {
                var da = new DAConfiguracionPaisDatos(entidad.PaisID);
                using (IDataReader reader = da.GetList(entidad))
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

        public List<BEConfiguracionPaisDatos> GetListComponente(BEConfiguracionPaisDatos entidad)
        {
            var lista = new List<BEConfiguracionPaisDatos>();

            try
            {
                var da = new DAConfiguracionPaisDatos(entidad.PaisID);
                using (IDataReader reader = da.GetListComponente(entidad))
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
            var lista = new List<BEConfiguracionPaisDatos>();

            try
            {
                var da = new DAConfiguracionPaisDatos(entidad.PaisID);
                using (IDataReader reader = da.GetListComponenteDatos(entidad))
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
    }
}
