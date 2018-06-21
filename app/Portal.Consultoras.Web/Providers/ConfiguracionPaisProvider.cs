using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class ConfiguracionPaisProvider
    {
        public void RemplazarTagNombreConfiguracionOferta(ref BEConfiguracionOfertasHome config, string tag, string valor)
        {
            config.DesktopTitulo = Util.RemplazaTag(config.DesktopTitulo, tag, valor);
            config.DesktopSubTitulo = Util.RemplazaTag(config.DesktopSubTitulo, tag, valor);
            config.MobileTitulo = Util.RemplazaTag(config.MobileTitulo, tag, valor);
            config.MobileSubTitulo = Util.RemplazaTag(config.MobileSubTitulo, tag, valor);
        }

        public ConfiguracionPaisModel ActualizarTituloYSubtituloMenu(ConfiguracionPaisModel config)
        {
            if (config == null) return config;

            if (!string.IsNullOrEmpty(config.DesktopTituloMenu) && config.DesktopTituloMenu.Contains("|"))
            {
                config.DesktopSubTituloMenu = config.DesktopTituloMenu.SplitAndTrim('|').LastOrDefault();
                config.DesktopTituloMenu = config.DesktopTituloMenu.SplitAndTrim('|').FirstOrDefault();
            }
            if (!string.IsNullOrEmpty(config.MobileTituloMenu) && config.MobileTituloMenu.Contains("|"))
            {
                config.MobileSubTituloMenu = config.MobileTituloMenu.SplitAndTrim('|').LastOrDefault();
                config.MobileTituloMenu = config.MobileTituloMenu.SplitAndTrim('|').FirstOrDefault();
            }
            return config;
        }

        public ConfiguracionPaisModel RemplazarTagNombre(ConfiguracionPaisModel config, string tag, string valor)
        {
            if (config == null || string.IsNullOrEmpty(tag)) return config;

            config.DesktopTituloBanner = Util.RemplazaTag(config.DesktopTituloBanner, tag, valor);
            config.DesktopSubTituloBanner = Util.RemplazaTag(config.DesktopSubTituloBanner, tag, valor);
            config.MobileTituloBanner = Util.RemplazaTag(config.MobileTituloBanner, tag, valor);
            config.MobileSubTituloBanner = Util.RemplazaTag(config.MobileSubTituloBanner, tag, valor);
            config.DesktopTituloMenu = Util.RemplazaTag(config.DesktopTituloMenu, tag, valor);
            config.DesktopSubTituloMenu = Util.RemplazaTag(config.DesktopSubTituloMenu, tag, valor);
            config.MobileTituloMenu = Util.RemplazaTag(config.MobileTituloMenu, tag, valor);
            config.MobileSubTituloMenu = Util.RemplazaTag(config.MobileSubTituloMenu, tag, valor);

            return config;
        }
    }
}