using Portal.Consultoras.Data.Mobile;
using Portal.Consultoras.Entities.Mobile;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.Mobile
{
    public class BLApp
    {
        public List<BEApp> ObtenerApps(int paisID)
        {
            var apps = new List<BEApp>();

            var daApp = new DAApp(paisID);

            using (IDataReader reader = daApp.ObtenerAps())
                while (reader.Read())
                {
                    var app = new BEApp(reader);
                    apps.Add(app);
                }

            return apps;
        }
    }
}