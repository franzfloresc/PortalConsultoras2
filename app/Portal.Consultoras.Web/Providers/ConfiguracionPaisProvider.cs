using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Linq;

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

        public VariablesGeneralesPortalModel getBaseVariablesPortal(string CodigoISO, string Simbolo)
        {
            var carpetaPais = Globals.UrlMatriz + "/" + CodigoISO;
            var baseVariablesGeneral = new VariablesGeneralesPortalModel
            {
                UrlCompartir = Util.GetUrlCompartirFB(CodigoISO),
                ExtensionImgSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall,
                ImgUrlBase = ConfigS3.GetUrlFileS3Base(carpetaPais),
                SimboloMoneda = Simbolo
            };

            return baseVariablesGeneral;

        }

        public ConfiguracionPaisModel ActualizarTituloYSubtituloBanner(ConfiguracionPaisModel cp, RevistaDigitalModel revistaDigital)
        {
            var codigo = string.Empty;
            var codigoMobile = string.Empty;

            if (cp.Codigo == Constantes.ConfiguracionPais.Inicio &&
                revistaDigital.TieneRDI)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RDI.DLandingBannerIntriga;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RDI.MLandingBannerIntriga;
            }

            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdActivaNoSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdNoActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.InicioRD &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerInicioRdNoActivaNoSuscrita;
            }

            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerActivaSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerActivaNoSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerActivaNoSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerNoActivaSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerNoActivaSuscrita;
            }
            if (cp.Codigo == Constantes.ConfiguracionPais.RevistaDigital &&
                revistaDigital.TieneRDC &&
                !revistaDigital.EsActiva &&
                !revistaDigital.EsSuscrita)
            {
                codigo = Constantes.ConfiguracionPaisDatos.RD.DLandingBannerNoActivaNoSuscrita;
                codigoMobile = Constantes.ConfiguracionPaisDatos.RD.MLandingBannerNoActivaNoSuscrita;
            }

            if (!string.IsNullOrEmpty(codigo))
            {
                var datoDesktop = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
                cp.DesktopTituloBanner = Util.Trim(datoDesktop.Valor1);
                cp.DesktopSubTituloBanner = Util.Trim(datoDesktop.Valor2);
            }

            if (!string.IsNullOrEmpty(codigoMobile))
            {
                var datoMobile = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigoMobile) ?? new ConfiguracionPaisDatosModel();
                cp.MobileTituloBanner = Util.Trim(datoMobile.Valor1);
                cp.MobileSubTituloBanner = Util.Trim(datoMobile.Valor2);
            }


            return cp;
        }
    }
}