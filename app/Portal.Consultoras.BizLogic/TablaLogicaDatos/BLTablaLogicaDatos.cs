﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

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