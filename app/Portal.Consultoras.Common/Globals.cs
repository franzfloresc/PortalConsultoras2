using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Common
{
    public class Globals
    {
        #region Variables miembro
        private static string _rutaImagenesRevista;
        private static string _urlFlashpapersRevista;
        private static string _namePageFlashpapers;
        private static string _emailCatalogos;
        private static string _rutaFileLoadTemporal;
        private static int _sizeLimitImageRevista;
        #endregion

        #region Propiedades
        public static string RutaTemporales { get; set; } // 1664
        public static string UrlBanner { get; set; } // 1664 
        public static string UrlNavidadConsultora { get; set; } // 2106 
        public static string UrlFileConsultoras { get; set; } // 1664
        public static string UrlIncentivos { get; set; } // 1664
        public static string UrlLugaresPago { get; set; } // 1664
        public static string UrlMatriz { get; set; } // 1664
        public static string UrlOfertasNuevas { get; set; } // 1664
        public static string UrlRevistaGana { get; set; } // 1664
        public static string UrlEscalaDescuentos { get; set; } // 1664
        public static string UrlOfertasFic { get; set; } // 1664

        public static string RutaImagenesTemp { get; set; }
        public static string RutaImagenesTempOfertas { get; set; }
        public static string RutaImagenesFondoLogin { get; set; }
        public static string RutaImagenesFondoPortal { get; set; }
        public static string RutaImagenesLogoPortal { get; set; }
        public static string RutaImagenesOfertasWeb { get; set; }
        public static string RutaImagenesOfertasLiquidacion { get; set; }
        public static string RutaImagenesMatriz { get; set; }
        public static string RutaImagenesBanners { get; set; }
        public static string RutaImagenesTempBanners { get; set; }
        public static string RutaImagenesTempMatriz { get; set; }
        public static string RutaImagenesOfertasNuevas { get; set; }
        //public static string RutaImagenesOfertasGratis { get; set; }
        public static string RutaImagenesTempLugaresPago { get; set; }
        public static string RutaImagenesLugaresPago { get; set; }
        public static string RutaImagenesTempIncentivos { get; set; }
        public static string RutaImagenesIncentivos { get; set; }

        /// <summary>
        /// Ruta imagen revista gana
        /// </summary>
        /// <value>Default:~/Content/RevistaGana o lee desde web.config con key=PathImagenRevista</value>
        public static string RutaImagenesRevista
        {
            get
            {
                if (String.IsNullOrEmpty(_rutaImagenesRevista))
                {
                    return ConfigurationManager.AppSettings["PathImagenRevista"] ?? "~/Content/RevistaGana";
                }
                return _rutaImagenesRevista;
            }
            set { _rutaImagenesRevista = value; }
        }
        /// <summary>
        /// Url flashpapers revista gana
        /// </summary>
        /// <value>Default:lee desde web.config con key=UrlFlashpapersRevista</value>
        public static string UrlFlashpapersRevista
        {
            get
            {
                if (String.IsNullOrEmpty(_urlFlashpapersRevista))
                {
                    return ConfigurationManager.AppSettings["UrlFlashpapersRevista"] ?? String.Empty;
                }
                return _urlFlashpapersRevista;
            }
            set { _urlFlashpapersRevista = value; }
        }
        /// <summary>
        /// Nombre página flashpapers
        /// </summary>
        /// <value>Default:lee desde web.config con key=NamePageFlashpapers</value>
        public static string NamePageFlashpapers
        {
            get
            {
                if (String.IsNullOrEmpty(_namePageFlashpapers))
                {
                    return ConfigurationManager.AppSettings["NamePageFlashpapers"] ?? String.Empty;
                }
                return _namePageFlashpapers;
            }
            set { _namePageFlashpapers = value; }
        }
        /// <summary>
        /// Correo que se utiliza en el envio de catálogos
        /// </summary>
        /// <value>Default:lee desde web.config con key=EmailCatalogo</value>
        public static string EmailCatalogos
        {
            get
            {
                if (String.IsNullOrEmpty(_emailCatalogos))
                {
                    return ConfigurationManager.AppSettings["EmailCatalogo"] ?? String.Empty;
                }
                return _emailCatalogos;
            }
            set { _emailCatalogos = value; }
        }
        /// <summary>
        /// Correo que se utiliza en el envio de catálogos
        /// </summary>
        /// <value>Default:lee desde web.config con key=PathFileTemporal</value>
        public static string RutaFileLoadTemporal
        {
            get
            {
                if (String.IsNullOrEmpty(_rutaFileLoadTemporal))
                {
                    return ConfigurationManager.AppSettings["PathFileTemporal"] ?? String.Empty;
                }
                return _rutaFileLoadTemporal;
            }
            set { _rutaFileLoadTemporal = value; }
        }
        /// <summary>
        /// Maximo tamaño de la imagen a cargar para la portada revista gana
        /// </summary>
        /// <value>Default:lee desde web.config con key=SizeLimitImageRevista</value>
        public static int SizeLimitImageRevista
        {
            get
            {
                if (_sizeLimitImageRevista == 0)
                {
                    int val;
                    Int32.TryParse(ConfigurationManager.AppSettings["SizeLimitImageRevista"] ?? String.Empty, out val);
                    return val;
                }
                return _sizeLimitImageRevista;
            }
            set { _sizeLimitImageRevista = value; }
        }
        #endregion
    }
}
