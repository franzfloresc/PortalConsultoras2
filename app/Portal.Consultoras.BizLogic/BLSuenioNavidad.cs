using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using System.Configuration;

namespace Portal.Consultoras.BizLogic
{
    public class BLSuenioNavidad
    {

        public IList<BESuenioNavidad> ListarSuenioNavidad(BESuenioNavidad entidad)
        {
            var listaSuenios = new List<BESuenioNavidad>();
            var DASuenioNavidad = new DASuenioNavidad(entidad.PaisID);

            using (IDataReader reader = DASuenioNavidad.ListarSuenioNavidad(entidad))
                while (reader.Read())
                {
                    var item = new BESuenioNavidad(reader);
                    listaSuenios.Add(item);
                }

            return listaSuenios;
        }

        public void RegistrarSuenioNavidad(BESuenioNavidad entidad)
        {
            var DASuenioNavidad = new DASuenioNavidad(entidad.PaisID);
            DASuenioNavidad.RegistrarSuenioNavidad(entidad);
        }

        public int ValidarSuenioNavidad(BESuenioNavidad entidad)
        {
            var DASuenioNavidad = new DASuenioNavidad(entidad.PaisID);
            return DASuenioNavidad.ValidarSuenioNavidad(entidad);
        }
    }
}
