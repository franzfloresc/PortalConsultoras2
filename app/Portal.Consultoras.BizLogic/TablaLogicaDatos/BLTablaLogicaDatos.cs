using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTablaLogicaDatos : ITablaLogicaDatosBusinessLogic
    {
        public List<BETablaLogicaDatos> GetList(int paisID, short tablaLogicaID)
        {
            var lst = new List<BETablaLogicaDatos>();

            try
            {
                using (IDataReader reader = new DATablaLogicaDatos(paisID).GetTablaLogicaDatos(tablaLogicaID))
                {
                    lst = reader.MapToCollection<BETablaLogicaDatos>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, paisID);
            }

            return lst;
        }
        public List<BETablaLogicaDatos> GetListCache(int paisID, short tablaLogicaID)
        {
            return CacheManager<List<BETablaLogicaDatos>>.ValidateDataElement(paisID, ECacheItem.TablaLogicaDatos, tablaLogicaID.ToString(), () => GetList(paisID, tablaLogicaID));
        }
    }
}