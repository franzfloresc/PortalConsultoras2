using Portal.Consultoras.Common;
using System.Configuration;

namespace Portal.Consultoras.Web.Providers
{
    public class ConfiguracionManagerProvider
    {
        public string GetConfiguracionManager(string key)
        {
            key = Util.Trim(key);
            if (key == "") return "";

            var keyvalor = ConfigurationManager.AppSettings.Get(key);

            return Util.Trim(keyvalor);
        }

        public bool GetConfiguracionManagerContains(string key, string compara)
        {
            var keyCongi = GetConfiguracionManager(key);
            return keyCongi.Contains(compara);
        }

    }
}