using System;
using System.Configuration;

namespace Portal.Consultoras.Web.Infraestructure
{
    public class Settings
    {
        private static readonly Lazy<Settings> _instance;

        static Settings()
        {
            _instance = new Lazy<Settings>(() => new Settings
            {
                UrlLogDynamo = ConfigurationManager.AppSettings["UrlLogDynamo"],
                PaisesEsika = ConfigurationManager.AppSettings.Get("PaisesEsika"),
                PaisesLBel = ConfigurationManager.AppSettings.Get("paisesLBel"),
                UrlChatBot = ConfigurationManager.AppSettings.Get("UrlChatbot"),
                RegaloProgramaNuevasFlag = ConfigurationManager.AppSettings.Get("RegaloProgramaNuevasFlag"),
                JsonWebTokenSecretKey = ConfigurationManager.AppSettings.Get("JsonWebTokenSecretKey")
            });
        }

        public static Settings Instance
        {
            get { return _instance.Value; }
        }

        public string UrlLogDynamo { get; private set; }

        public string PaisesEsika { get; private set; }

        public string UrlChatBot { get; private set; }

        public string RegaloProgramaNuevasFlag { get; set; }

        public string JsonWebTokenSecretKey { get; private set; }

        public string PaisesLBel { get; private set; }
    }
}
