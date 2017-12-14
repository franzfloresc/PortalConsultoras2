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
                    while (reader.Read())
                    {
                        lista.Add(new BEConfiguracionPaisDatos(reader));
                    }
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
