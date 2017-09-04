using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos
    {
        public List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, short TablaLogicaID)
        {
            List<BETablaLogicaDatos> TablaLogicaDatos = new List<BETablaLogicaDatos>();

            var DATablaLogicaDatos = new DATablaLogicaDatos(paisID);
            using (IDataReader reader = DATablaLogicaDatos.GetTablaLogicaDatos(TablaLogicaID))
            {
                while (reader.Read())
                {
                    TablaLogicaDatos.Add(new BETablaLogicaDatos(reader));
                }
            }
            return TablaLogicaDatos;
        }
    }
}
