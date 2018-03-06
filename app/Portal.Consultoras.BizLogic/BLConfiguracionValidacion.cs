using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionValidacion
    {
        public IList<BEConfiguracionValidacion> GetConfiguracionValidacion(int paisID, int CampaniaID)
        {
            var lista = new List<BEConfiguracionValidacion>();
            var daConfiguracionValidacion = new DAConfiguracionValidacion(paisID);

            using (IDataReader reader = daConfiguracionValidacion.GetConfiguracionValidacion(CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacion(reader) { PaisID = paisID };
                    lista.Add(entidad);
                }

            return lista;
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