using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLMenuMobile
    {
        public IList<BEMenuMobile> GetItemsByPais(int paisID)
        {
            var items = (IList<BEMenuMobile>)CacheManager<BEMenuMobile>.GetData(paisID, ECacheItem.MenuMobile);
            if (items == null || items.Count == 0)
            {
                var daMenuMobile = new DAMenuMobile(paisID);

                items = new List<BEMenuMobile>();
                using (var reader = daMenuMobile.GetItems())
                {
                    while (reader.Read())
                    {
                        var entidad = new BEMenuMobile(reader);
                        items.Add(entidad);
                    }
                }
                CacheManager<BEMenuMobile>.AddData(paisID, ECacheItem.MenuMobile, items);
            }
            return items;
        }
    }
}
