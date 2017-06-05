using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionPais
    {
        public List<BEConfiguracionPais> GetList(BEConfiguracionPais entidad)
        {
            var lista = new List<BEConfiguracionPais>();

            try
            {
                var da = new DAConfiguracionPais(entidad.Detalle.PaisID);
                using (IDataReader reader = da.GetList(entidad))
                {
                    while (reader.Read())
                    {
                        lista.Add( new BEConfiguracionPais(reader));
                    }
                }
            }
            catch (Exception exc)
            {
                Console.WriteLine(exc.StackTrace);
                lista = new List<BEConfiguracionPais>();
            }
            return lista;
        }
    }
}
