using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLPremiosProgramaNuevas
    {
        public BEPremiosProgramaNuevas GetPremiosProgramaNuevas(BEPremiosProgramaNuevas entidad)
        {
            BEPremiosProgramaNuevas data = new BEPremiosProgramaNuevas();
            var da = new DAPremiosProgramaNuevas(entidad.PaisID);
            using (IDataReader reader = da.GetPremiosProgramaNuevas(entidad))
                if (reader.Read())
                    data = new BEPremiosProgramaNuevas(reader);

            return data;
        }

    }
}
