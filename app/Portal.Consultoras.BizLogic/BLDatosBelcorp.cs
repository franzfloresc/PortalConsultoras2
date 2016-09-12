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
    public class BLDatosBelcorp
    {
        public IList<BEDatosBelcorp> GetDatosBelcorp(int paisID)
        {
            var datos = new List<BEDatosBelcorp>();
            var DADatosBelcorp = new DADatosBelcorp(paisID);

            using (IDataReader reader = DADatosBelcorp.GetDatosBelcorp())
                while (reader.Read())
                {
                    datos.Add(new BEDatosBelcorp(reader));
                }

            return datos;
        }
    }
}
