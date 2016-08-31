using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionValidacionNuevoPROL
    {
        public IList<BEConfiguracionValidacionNuevoPROL> GetConfiguracionValidacionNuevoPROL(int PaisID, int TipoPROL)
        {
            var lista = new List<BEConfiguracionValidacionNuevoPROL>();
            var DAConfiguracionValidacionNuevoPROL = new DAConfiguracionValidacionNuevoPROL(PaisID);

            using (IDataReader reader = DAConfiguracionValidacionNuevoPROL.GetConfiguracionValidacionNuevoPROL(TipoPROL))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacionNuevoPROL(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public int InsConfiguracionValidacionNuevoPROL(int PaisID, string Usuario, IList<BEConfiguracionValidacionNuevoPROL> ZonasNuevoPROL)
        {
            var DAConfiguracionValidacionNuevoPROL = new DAConfiguracionValidacionNuevoPROL(PaisID);
            return DAConfiguracionValidacionNuevoPROL.InsConfiguracionValidacionNuevoPROL(Usuario, ZonasNuevoPROL);
        }
    }
}
