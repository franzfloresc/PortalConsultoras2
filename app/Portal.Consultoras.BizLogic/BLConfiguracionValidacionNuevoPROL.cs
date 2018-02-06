using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionValidacionNuevoPROL
    {
        public IList<BEConfiguracionValidacionNuevoPROL> GetConfiguracionValidacionNuevoPROL(int PaisID, int TipoPROL)
        {
            var lista = new List<BEConfiguracionValidacionNuevoPROL>();
            var daConfiguracionValidacionNuevoProl = new DAConfiguracionValidacionNuevoPROL(PaisID);

            using (IDataReader reader = daConfiguracionValidacionNuevoProl.GetConfiguracionValidacionNuevoPROL(TipoPROL))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionNuevoPROL(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public int InsConfiguracionValidacionNuevoPROL(int PaisID, string Usuario, IList<BEConfiguracionValidacionNuevoPROL> ZonasNuevoPROL)
        {
            var daConfiguracionValidacionNuevoProl = new DAConfiguracionValidacionNuevoPROL(PaisID);
            return daConfiguracionValidacionNuevoProl.InsConfiguracionValidacionNuevoPROL(Usuario, ZonasNuevoPROL);
        }
    }
}
