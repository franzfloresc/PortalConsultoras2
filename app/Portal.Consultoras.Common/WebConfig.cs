using System.Configuration;

namespace Portal.Consultoras.Common
{
    public class WebConfig
    {
        public WebConfig()
        {
            this.PaisesEsika = ConfigurationManager.AppSettings["PaisesEsika"].ToString();
        }

        public string PaisesEsika { get; set; }
    }
}