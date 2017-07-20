using Portal.Consultoras.Data.Mobile;
using Portal.Consultoras.Entities.Mobile;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic.Mobile
{
    public class BLApp
    {
        public List<BEApp> ObtenerApps(int paisID)
        {
            var apps = CacheManager<BEApp>.GetData(ECacheItem.Apps);

            if (apps == null)
                return CargarApps(paisID);

            return apps.ToList();
        }

        private List<BEApp> CargarApps(int paisID)
        {
            var apps = new List<BEApp>();

            var daApp = new DAApp(paisID);

            using (IDataReader reader = daApp.ObtenerAps())
                while (reader.Read())
                {
                    var cliente = new BEApp(reader);
                    apps.Add(cliente);
                }

            CacheManager<BEApp>.AddData(ECacheItem.Apps, apps);

            return apps;
        }
    }
}
