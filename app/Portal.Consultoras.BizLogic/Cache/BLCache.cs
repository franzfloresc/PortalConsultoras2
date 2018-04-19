using Portal.Consultoras.Common;
using System;
using System.Configuration;

namespace Portal.Consultoras.BizLogic
{
    public class BLCache
    {
        public string RemoveData(int paisID, string cacheItemString, string customKey)
        {
            if (ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.EnabledRemoveCache] != "1")
            {
                return "No se encuentra habilitada la eliminacion de caché";
            }

            ECacheItem cacheItem;
            try { cacheItem = (ECacheItem)Enum.Parse(typeof(ECacheItem), cacheItemString); }
            catch { return "El enum no es correcto."; }
            
            CacheManager<string>.RemoveData(paisID, cacheItem, customKey);
            return "La caché se eliminó exitosamente.";
        }
    }
}
