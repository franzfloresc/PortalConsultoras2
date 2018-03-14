using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

using System.Collections.Generic;
using System.Data;
using System.Linq;
using System;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos : ITablaLogicaDatosBusinessLogic
    {
        public List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, short tablaLogicaID)
        {
            using (IDataReader reader = new DATablaLogicaDatos(paisID).GetTablaLogicaDatos(tablaLogicaID))
            {
                return reader.MapToCollection<BETablaLogicaDatos>();
            }
        }
        public List<BETablaLogicaDatos> GetTablaLogicaDatosCache(int paisID, short tablaLogicaID)
        {
            return CacheManager<List<BETablaLogicaDatos>>.ValidateDataElement(paisID, ECacheItem.TablaLogicaDatos, tablaLogicaID.ToString(), () => GetTablaLogicaDatos(paisID, tablaLogicaID));
        }
    }
}