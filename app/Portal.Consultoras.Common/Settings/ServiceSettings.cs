using System;
using System.Configuration;

namespace Portal.Consultoras.Common.Settings
{
    public class ServiceSettings
    {
        private static readonly Lazy<ServiceSettings> _instance;

        static ServiceSettings()
        {
            _instance = new Lazy<ServiceSettings>(() => new ServiceSettings
            {
                UrlIssuu = ConfigurationManager.AppSettings["UrlIssuu"],
                CodigoRevistaIssuu = ConfigurationManager.AppSettings["CodigoRevistaIssuu"],
                CodigoCatalogoIssuu = ConfigurationManager.AppSettings["CodigoCatalogoIssuu"],
                PaisesEsika = ConfigurationManager.AppSettings.Get("PaisesEsika")
            });
        }

        public string PaisesEsika { get; private set; }

        public string CodigoCatalogoIssuu { get; private set; }

        public string CodigoRevistaIssuu { get; private set; }

        public string UrlIssuu { get; private set; }

        public static ServiceSettings Instance
        {
            get { return _instance.Value; }
        }

    }
}