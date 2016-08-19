using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLItemCarruselInicio // Modificación TiSmart 2014/12/12 - 2014/12/17
    {
        public IList<BEItemCarruselInicio> GetItemCarruselInicio(int paisID)
        {
            IList<BEItemCarruselInicio> items = (IList<BEItemCarruselInicio>)CacheManager<BEItemCarruselInicio>.GetData(paisID, ECacheItem.ItemsCarruselInicio);
            if (items == null || items.Count == 0)
            {
                var DAItemCarruselInicio = new DAItemCarruselInicio(paisID);
                items = new List<BEItemCarruselInicio>();

                using (IDataReader reader = DAItemCarruselInicio.GetItemsCarruselInicio())
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
