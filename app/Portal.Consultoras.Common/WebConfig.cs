using System.Configuration;

namespace Portal.Consultoras.Common
{
    public class WebConfig
    {
        #region Variables miembre
        
        #endregion

        #region Propiedades

        public static string PaisesEsika
        {
            get
            {
                return ConfigurationManager.AppSettings["PaisesEsika"] ?? "";
            }
        }

        #endregion
    }
}