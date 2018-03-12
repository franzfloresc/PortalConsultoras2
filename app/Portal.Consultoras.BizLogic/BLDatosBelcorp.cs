using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLDatosBelcorp
    {
        public IList<BEDatosBelcorp> GetDatosBelcorp(int paisID)
        {
            var datos = new List<BEDatosBelcorp>();
            var daDatosBelcorp = new DADatosBelcorp(paisID);

            using (IDataReader reader = daDatosBelcorp.GetDatosBelcorp())
                while (reader.Read())
                {
                    datos.Add(new BEDatosBelcorp(reader));
                }

            return datos;
        }
    }
}