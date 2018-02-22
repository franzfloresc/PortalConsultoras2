using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos : ITablaLogicaDatosBusinessLogic
    {
        public List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, short TablaLogicaID)
        {
            using (IDataReader reader = new DATablaLogicaDatos(paisID).GetTablaLogicaDatos(TablaLogicaID))
            {
                return reader.MapToCollection<BETablaLogicaDatos>();
            }
        }
    }
}