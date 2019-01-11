﻿using System.Configuration;

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
