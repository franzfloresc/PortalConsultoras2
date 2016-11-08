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
    public class BLPais
    {
        public bool EsPaisHana(int paisId)
        {
            var DAPais = new DAPais(paisId);
            bool tieneHana = false;
            using (IDataReader reader = DAPais.EsPaisHana(paisId))
                if (reader.Read())
                {
                    tieneHana = Convert.ToBoolean(reader["TieneHana"]);
                }

            return tieneHana;
        }
    }
}
