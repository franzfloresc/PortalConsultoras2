using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionValidacion
    {
        public bool EstaActivoProl3(int paisID)
        {
            var entidad = GetConfiguracionValidacion(paisID, true);

            if (entidad == null) return false;
            return entidad.TieneProl3;
        }

        public BEConfiguracionValidacion GetConfiguracionValidacion(int paisID, bool useCache)
        {
            BEConfiguracionValidacion entidad = null;
            if(useCache) entidad = CacheManager<BEConfiguracionValidacion>.GetDataElement(paisID, ECacheItem.ConfiguracionValidacion);
            if (entidad != null) return entidad;

            using (IDataReader reader = new DAConfiguracionValidacion(paisID).GetConfiguracionValidacion())
            {
                if (reader.Read()) entidad = new BEConfiguracionValidacion(reader) { PaisID = paisID };
            }
            if (useCache) CacheManager<BEConfiguracionValidacion>.AddDataElement(paisID, ECacheItem.ConfiguracionValidacion, entidad);
            return entidad;
        }

        public IList<BEConfiguracionValidacion> GetListConfiguracionValidacion(int paisID)
        {
            var entidad = GetConfiguracionValidacion(paisID, false);

            if (entidad == null) return new List<BEConfiguracionValidacion>();
            return new List<BEConfiguracionValidacion> { entidad };
        }

        public void InsertConfiguracionValidacion(BEConfiguracionValidacion entidad)
        {
            var daConfiguracionValidacion = new DAConfiguracionValidacion(entidad.PaisID);
            daConfiguracionValidacion.Insert(entidad);
        }

        public void UpdateConfiguracionValidacion(BEConfiguracionValidacion entidad)
        {
            var daConfiguracionValidacion = new DAConfiguracionValidacion(entidad.PaisID);
            daConfiguracionValidacion.Update(entidad);
        }
    }
}
