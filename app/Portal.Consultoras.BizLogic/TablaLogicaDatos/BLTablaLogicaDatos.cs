using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos : ITablaLogicaDatosBusinessLogic
    {
        public List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, short TablaLogicaID)
        {
            List<BETablaLogicaDatos> tablaLogicaDatos = new List<BETablaLogicaDatos>();

            var daTablaLogicaDatos = new DATablaLogicaDatos(paisID);
            using (IDataReader reader = daTablaLogicaDatos.GetTablaLogicaDatos(TablaLogicaID))
            {
                while (reader.Read())
                {
                    tablaLogicaDatos.Add(new BETablaLogicaDatos(reader));
                }
            }
            return tablaLogicaDatos;
        }
    }
}