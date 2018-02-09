using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLCrossSelling
    {
        public int InsConfiguracionCrossSelling(BEConfiguracionCrossSelling entity)
        {
            var dataAccess = new DACrossSelling(entity.PaisID);
            return dataAccess.InsConfiguracionCrossSelling(entity);
        }

        public int ValidarConfiguracionCrossSelling(int PaisID, int CampaniaID)
        {
            var dataAccess = new DACrossSelling(PaisID);
            return dataAccess.ValidarConfiguracionCrossSelling(CampaniaID);
        }

        public IList<BEConfiguracionCrossSelling> GetConfiguracionCampaniasPorPais(int PaisID, int CampaniaID)
        {
            var lst = new List<BEConfiguracionCrossSelling>();
            var dataAccess = new DACrossSelling(PaisID);

            using (IDataReader reader = dataAccess.GetCampaniasPorPais(CampaniaID))
                while (reader.Read())
                {
                    var entity = new BEConfiguracionCrossSelling(reader);
                    lst.Add(entity);
                }
            return lst;
        }

    }
}
