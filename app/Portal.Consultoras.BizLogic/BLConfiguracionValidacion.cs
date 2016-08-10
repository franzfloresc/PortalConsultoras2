using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionValidacion
    {
        public IList<BEConfiguracionValidacion> GetConfiguracionValidacion(int paisID, int CampaniaID)
        {
            var lista = new List<BEConfiguracionValidacion>();
            var DAConfiguracionValidacion = new DAConfiguracionValidacion(paisID);

            using (IDataReader reader = DAConfiguracionValidacion.GetConfiguracionValidacion(CampaniaID))
                while (reader.Read())
                {
                    var entidad = new BEConfiguracionValidacion(reader);
                    entidad.PaisID = paisID;
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsertConfiguracionValidacion(BEConfiguracionValidacion entidad)
        {
            var DAConfiguracionValidacion = new DAConfiguracionValidacion(entidad.PaisID);
            DAConfiguracionValidacion.Insert(entidad);
        }

        public void UpdateConfiguracionValidacion(BEConfiguracionValidacion entidad)
        {
            var DAConfiguracionValidacion = new DAConfiguracionValidacion(entidad.PaisID);
            DAConfiguracionValidacion.Update(entidad);
        }
    }
}
