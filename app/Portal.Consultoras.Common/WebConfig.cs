﻿using System.Configuration;

namespace Portal.Consultoras.Common
{
    public static class WebConfig
    {
        #region Variables miembre

        #endregion

        #region Propiedades

        public static string RutaCDN
        {
            get
            {
                return ConfigurationManager.AppSettings["RutaCDN"] ?? string.Empty;
            }
        }

        public static string JsonWebTokenSecret
        {
            get
            {
                return ConfigurationManager.AppSettings["JsonWebTokenSecretKey"] ?? string.Empty;
            }
        }
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

        public static string UrlMicroservicioPersonalizacionConfig {
            get
            {
                return ConfigurationManager.AppSettings["UrlMicroservicioPersonalizacionConfig"] ?? string.Empty;
            }
        }

        public static string UrlMicroservicioPersonalizacionSync
        {
            get
            {
                return ConfigurationManager.AppSettings["UrlMicroservicioPersonalizacionSync"] ?? string.Empty;
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

        public static string PROL_Consultas
        {
            get
            {
                return ConfigurationManager.AppSettings["RutaServicePROLConsultas"] ?? string.Empty;
            }
        }

        public static string RutaServiceBuscadorAPI
        {
            get
            {
                return ConfigurationManager.AppSettings["RutaServiceBuscadorAPI"] ?? string.Empty;
            }
        }
        public static string RutaServiceConsultaPROL
        {
            get
            {
                return ConfigurationManager.AppSettings["RutaServiceConsultaPROL"] ?? string.Empty;
            }
        }

        public static string HistoriaUrlMiniatura
        {
            get
            {
                return ConfigurationManager.AppSettings["HistUrlMiniatura"] ?? string.Empty;
            }
        }

        public static string HistAnchoAltoDetalle
        {
            get
            {
                return ConfigurationManager.AppSettings["HistAnchoAltoDetalle"] ?? string.Empty;
            }
        }

        public static string HistLimitDetMensaje
        {
            get
            {
                return ConfigurationManager.AppSettings["HistLimitDetMensaje"] ?? string.Empty;
            }
        }

        public static string CodigoHist
        {
            get
            {
                return ConfigurationManager.AppSettings["CodigoHist"] ?? string.Empty;
            }
        }

        public static string HistAnchoAlto
        {
            get
            {
                return ConfigurationManager.AppSettings["HistAnchoAlto"] ?? string.Empty;
            }
        }
        #endregion

        #region Flags
        public static string SetIdentifierNumberFlag
        {
            get
            {
                return ConfigurationManager.AppSettings["SetIdentifierNumberFlag"] ?? string.Empty;
            }
        }
        #endregion

        public static string GetByTagName(string tagName)
        {
            return ConfigurationManager.AppSettings[tagName] ?? string.Empty;
        }

        public static string ServicioDireccionEntregaSicc
        {
            get
            {
                return ConfigurationManager.AppSettings["ServicioDireccionEntregaSicc"] ?? string.Empty;
            }
        }

        public static string ServicioActualizarBoletaImp
        {
            get
            {
                return ConfigurationManager.AppSettings["ServicioActualizarBoletaImp"] ?? string.Empty;
            }
        }
    }
}