using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLItemCarruselInicio
    {
        public IList<BEItemCarruselInicio> GetItemCarruselInicio(int paisID)
        {
            IList<BEItemCarruselInicio> items = (IList<BEItemCarruselInicio>)CacheManager<BEItemCarruselInicio>.GetData(paisID, ECacheItem.ItemsCarruselInicio);
            if (items == null || items.Count == 0)
            {
                var daItemCarruselInicio = new DAItemCarruselInicio(paisID);
                items = new List<BEItemCarruselInicio>();

                using (IDataReader reader = daItemCarruselInicio.GetItemsCarruselInicio())
                {
                    while (reader.Read())
                    {
                        var entidad = new BEItemCarruselInicio(reader);
                        items.Add(entidad);
                    }
                }
                CacheManager<BEItemCarruselInicio>.AddData(paisID, ECacheItem.ItemsCarruselInicio, items);
            }
            return items;
        }
    }
}
