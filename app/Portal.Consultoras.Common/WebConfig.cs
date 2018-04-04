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
                return ConfigurationManager.AppSettings["PaisesEsika"] ?? string.Empty;
            }
        }
        public static string WebTrackingConfirmacion
        {
            get
            {
                return ConfigurationManager.AppSettings["WebTrackingConfirmacion"] ?? string.Empty;
            }
        }

        public static string UrlMicroservicioPersonalizacionSearch
        {
            get
            {
                return ConfigurationManager.AppSettings["UrlMicroservicioPersonalizacionSearch"] ?? string.Empty;
            }
        }

        public static string PaisesMicroservicioPersonalizacion
        {
            get
            {
                return ConfigurationManager.AppSettings["PaisesMicroservicioPersonalizacion"] ?? string.Empty;
            }
        }

        public static string EstrategiaDisponibleMicroservicioPersonalizacion
        {
            get
            {
                return ConfigurationManager.AppSettings["EstrategiaDisponibleMicroservicioPersonalizacion"] ?? string.Empty;
            }
        }

        #endregion
    }
}