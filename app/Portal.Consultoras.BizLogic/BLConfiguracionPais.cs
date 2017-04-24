using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionPais
    {
        public List<BEConfiguracionPais> GetList(BEConfiguracionPais entidad)
        {
            var lista = new List<BEConfiguracionPais>();

            try
            {
                var da = new DAConfiguracionPais(entidad.PaisID);
                using (IDataReader reader = da.GetList(entidad))
                {
                    while (reader.Read())
                    {
                        lista.Add( new BEConfiguracionPais(reader));
                    }
                }
            }
            catch (Exception)
            {
                lista = new List<BEConfiguracionPais>();
            }
            return lista;
        }
    }
}
