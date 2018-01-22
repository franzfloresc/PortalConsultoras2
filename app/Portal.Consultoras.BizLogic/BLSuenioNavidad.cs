using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLSuenioNavidad
    {

        public IList<BESuenioNavidad> ListarSuenioNavidad(BESuenioNavidad entidad)
        {
            var listaSuenios = new List<BESuenioNavidad>();
            var daSuenioNavidad = new DASuenioNavidad(entidad.PaisID);

            using (IDataReader reader = daSuenioNavidad.ListarSuenioNavidad(entidad))
                while (reader.Read())
                {
                    var item = new BESuenioNavidad(reader);
                    listaSuenios.Add(item);
                }

            return listaSuenios;
        }

        public void RegistrarSuenioNavidad(BESuenioNavidad entidad)
        {
            var daSuenioNavidad = new DASuenioNavidad(entidad.PaisID);
            daSuenioNavidad.RegistrarSuenioNavidad(entidad);
        }

        public int ValidarSuenioNavidad(BESuenioNavidad entidad)
        {
            var daSuenioNavidad = new DASuenioNavidad(entidad.PaisID);
            return daSuenioNavidad.ValidarSuenioNavidad(entidad);
        }
    }
}
