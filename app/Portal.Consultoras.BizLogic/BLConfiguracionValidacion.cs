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
            var entidad = GetConfiguracionValidacionCache(paisID);

            if (entidad == null) return false;
            return entidad.TieneProl3;
        }
        
        public BEConfiguracionValidacion GetConfiguracionValidacion(int paisID)
        {
            using (IDataReader reader = new DAConfiguracionValidacion(paisID).GetConfiguracionValidacion())
            {
                if (reader.Read()) return new BEConfiguracionValidacion(reader) { PaisID = paisID };
            }
            return null;
        }
        public BEConfiguracionValidacion GetConfiguracionValidacionCache(int paisID)
        {
            return CacheManager<BEConfiguracionValidacion>.ValidateDataElement(paisID, ECacheItem.ConfiguracionValidacion, () => GetConfiguracionValidacion(paisID));
        }

        public IList<BEConfiguracionValidacion> GetListConfiguracionValidacion(int paisID)
        {
            var entidad = GetConfiguracionValidacion(paisID);

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