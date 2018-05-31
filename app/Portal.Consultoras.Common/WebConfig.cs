﻿using System.Configuration;

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

        public static string PaisesFraccionKitNuevas
        {
            get
            {
                return ConfigurationManager.AppSettings["PaisesFraccionKitNuevas"] ?? string.Empty;
            }
        }

        public static string Ambiente
        {
            get
            {
                return ConfigurationManager.AppSettings["Ambiente"] ?? string.Empty;
            }
        }

        public static string QA_Prol_ServicesCalculos
        {
            get
            {
                return ConfigurationManager.AppSettings["QA_Prol_ServicesCalculos"] ?? string.Empty;
            }
        }

        public static string PR_Prol_ServicesCalculos
        {
            get
            {
                return ConfigurationManager.AppSettings["PR_Prol_ServicesCalculos"] ?? string.Empty;
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



        public static string PaisesShowRoom
        {
            get
            {
                return ConfigurationManager.AppSettings["PaisesShowRoom"] ?? string.Empty;
            }
        }

        public static string OrderDownloadFtpUpload
        {
            get
            {
                return ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] ?? string.Empty;
            }
        }

        public static string OrderDownloadS3
        {
            get
            {
                return ConfigurationManager.AppSettings["OrderDownloadS3"] ?? string.Empty;
            }
        }

        public static string S3_Pedidos
        {
            get
            {
                return ConfigurationManager.AppSettings["S3_Pedidos"] ?? string.Empty;
            }
        }

        #endregion

        public static string GetByTagName(string tagName)
        {
            return ConfigurationManager.AppSettings[tagName] ?? string.Empty;
        }
    }
}