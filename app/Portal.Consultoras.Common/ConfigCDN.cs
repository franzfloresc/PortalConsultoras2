using System.Configuration;

namespace Portal.Consultoras.Common
{
    public static class ConfigCdn
    {
        private static readonly string URL_S3 = ConfigurationManager.AppSettings["URL_S3"] ?? string.Empty;
        private static readonly string RutaCdn = ConfigurationManager.AppSettings["RutaCDN"] ?? string.Empty;
        private static readonly string rutaRevistaDigital = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.CarpetaRevistaDigital] ?? string.Empty;

        public static string GetUrlFileCdn(string carpetaPais, string fileName)
        {
            fileName = (fileName ?? "").Trim();
            if (fileName == "")
                return fileName;

            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;

            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";

            return RutaCdn + "/" + carpeta + fileName;
        }

        public static string GetUrlFileCdnMatriz(string isoPais, string fileName)
        {
            var carpetaPais = string.Format("{0}/{1}", Globals.UrlMatriz, isoPais);
            return GetUrlFileCdn(carpetaPais, fileName);
        }

        public static string GetUrlCdn(string carpetaPais)
        {
            var carpeta = string.IsNullOrEmpty(carpetaPais) ? "" : carpetaPais + "/";
            return RutaCdn + "/" + carpeta;
        }

        public static string GetUrlCdnMatriz(string isoPais)
        {
            var carpetaPais = string.Format("{0}/{1}", Globals.UrlMatriz, isoPais);
            return GetUrlCdn(carpetaPais);
        }
        public static string GetUrlFileCdnMatrizCampania(string isoPais, string fileName, string campaniaid)
        {
            var carpetaPais = string.Format("{0}/{1}/{2}", Globals.UrlMatriz, isoPais, campaniaid);
            if (ConfigS3.ExistFileS3(carpetaPais, fileName))
                return GetUrlFileCdn(carpetaPais, fileName);

            return null;
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

        public static string GetUrlFileInSubdirectory(string subdirectory, string pais, string fileName)
        {
            fileName = fileName ?? "";
            if (fileName.StartsWith(URL_S3))
                return fileName;

            if (fileName.StartsWith("http:/"))
                return fileName;

            if (fileName.StartsWith("https:/"))
                return fileName;

            var subdirectoryPais = string.IsNullOrEmpty(pais) ? "" : pais + "/";

            return RutaCdn + "/" + subdirectory + "/" + subdirectoryPais + fileName;
        }

        public static string GetUrlCdnAppConsultora(string isoPais, string cadena)
        {
            string[] arrCadena;
            arrCadena = cadena.Split(',');

            var carpetaPais = string.Format("{0}/{1}/{2}/{3}", arrCadena[0], isoPais, arrCadena[1], arrCadena[2]);
            return GetUrlCdn(carpetaPais);
        }
        public static string GetUrlCdnAppConsultoraDetalle(string isoPais, string cadena)
        {
            string[] arrCadena;
            arrCadena = cadena.Split(',');

            var carpetaPais = string.Format("{0}/{1}/{2}", arrCadena[0], isoPais, arrCadena[1]);
            return GetUrlCdn(carpetaPais);
        }
        
        public static string GetUrlCdnAppConsultoraVideo(string isoPais, string cadena)
        {
            string[] arrCadena;
            arrCadena = cadena.Split(',');

            var carpetaPais = string.Format("{0}/{1}", arrCadena[0], isoPais);
            return GetUrlCdn(carpetaPais);
        }

    }
}
