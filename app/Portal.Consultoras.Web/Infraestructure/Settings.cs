using System;

namespace Portal.Consultoras.Web.Infraestructure
{
    public class Settings
    {
        private static readonly Lazy<Settings> _instance;

        static Settings()
        {
            _instance = new Lazy<Settings>(() => new Settings
            {
                UrlLogDynamo = System.Configuration.ConfigurationManager.AppSettings["UrlLogDynamo"],
                PaisesEsika = System.Configuration.ConfigurationManager.AppSettings.Get("PaisesEsika"),
                UrlChatBot = System.Configuration.ConfigurationManager.AppSettings.Get("UrlChatbot")
            });

        }

        public static Settings Instance
        {
            get { return _instance.Value; }
        }

        public string UrlLogDynamo { get; private set; }
        public string PaisesEsika { get; private set; }
        public string UrlChatBot { get; private set; }
    }
}
