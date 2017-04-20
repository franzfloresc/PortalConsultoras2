using System;
using System.Configuration;

namespace Portal.Consultoras.Common
{
    public class WebConfig
    {
        #region Variables miembre

        private static string _paisesEsika;

        #endregion

        #region Propiedades

        public static string PaisesEsika
        {
            get
            {
                if (String.IsNullOrEmpty(_paisesEsika))
                {
                    return ConfigurationManager.AppSettings["PaisesEsika"] ?? "";
                }
                return _paisesEsika;
            }
            set { _paisesEsika = value; }
        }

        #endregion
    }
}