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

        public string GetBucketNameFromConfig()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.BUCKET_NAME);
        }

        public bool GetMostrarPedidosPendientesFromConfig()
        {
            var mostrarPedidoAppSetting = GetConfiguracionManager(Constantes.ConfiguracionManager.MostrarPedidosPendientes);

            return mostrarPedidoAppSetting == "1";
        }

        public string GetPaisesConConsultoraOnlineFromConfig()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.Permisos_CCC);
        }

        public bool GetMostrarOpcionClienteOnline(string codigoIso)
        {
            return GetMostrarPedidosPendientesFromConfig() && GetPaisesConConsultoraOnlineFromConfig().Contains(codigoIso);
        }

        public string GetDefaultGifMenuOfertas()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.GIF_MENU_DEFAULT_OFERTAS);
        }

        public string GetPaisesEsikaFromConfig()
        {
            return GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesEsika);
        }
    }
}