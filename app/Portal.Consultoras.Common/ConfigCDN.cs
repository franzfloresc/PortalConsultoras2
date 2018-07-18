using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{   
    public class ConfigCdn
    {
        public static string URL_S3 = ConfigurationManager.AppSettings["URL_S3"];
        public static string RutaCdn = ConfigurationManager.AppSettings["RutaCDN"];
        private static readonly string rutaRevistaDigital = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.CarpetaRevistaDigital] ?? string.Empty;

        public static string GetUrlFileCdn(string carpetaPais, string fileName)
        {
            fileName = fileName ?? "";
            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;

            if (fileName.Trim() == "") return fileName;

            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return RutaCdn + "/" + carpeta + fileName;
        }

        public static string GetUrlCdn(string carpetaPais)
        {            
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return RutaCdn + "/" + carpeta;
        }

        public static string GetUrlFileRDCdn(string carpetaPais, string fileName)
        {
            fileName = fileName ?? "";
            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;
            
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return RutaCdn + "/" + rutaRevistaDigital + "/" + carpeta + fileName;
        }
    }
}
