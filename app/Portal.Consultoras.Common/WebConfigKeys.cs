namespace Portal.Consultoras.Common
{
    public static class AppSettingsKeys
    {
        public const string WSGEO_Url = "WSGEO_Url";
        public const string WSGEO_CO_Url = "WSGEO_CO_Url";
        public const string WSGEO_PuntosPorDireccion = "WSGEO_PuntosPorDireccion";
        public const string WSGEO_TerritorioPorPunto = "WSGEO_TerritorioPorPunto";
        public const string MandrillURL = "MandrillURL";
        public const string MandrillKey = "MandrillKey";
        public const string MandrillFrom = "MandrillFrom";
        public const string MandrillSubject = "MandrillSubject";
        public const string UrlSiteUnete = "UrlSiteUnete";
        public const string UrlSiteFFVV = "UrlSiteFFVV";
        public const string UrlSiteSE = "UrlSiteSE";
        public const string NombreBaseDatos = "NombreBaseDatos_XX";
        public const string PaisesHojaIncripcion = "PaisesHojaIncripcion";
        public const string DocumentosIdentidadStorage = "UrlContenedoraDocumentosIdentidad";
        public const string DocumentosDomicilioStorage = "UrlContenedoraComprobantesDomicilio";
        public const string DocumentosContratoStorage = "UrlContenedoraComprobantesContrato";
        public const string DocumentosPagareStorage = "UrlContenedoraComprobantesPagare";
        public const string DocumentosAvalStorage = "UrlContenedoraComprobantesAval";

        public const string ContenedoraReciboOtraMarca = "UrlContenedoraReciboOtraMarca";
        public const string ContenedoraReciboPagoAval = "UrlContenedoraReciboPagoAval";
        public const string ContenedoraCreditoAval = "UrlContenedoraCreditoAval";
        public const string ContenedoraConstanciaLaboralAval = "UrlContenedoraConstanciaLaboralAval";
    }

    public static class ConnectionStringNames
    {
        /// <summary>
        /// Nombre de cadena de conexión ODS
        /// </summary>
        public const string ODS = "ODSEntities";
        /// <summary>
        /// Nombre de cadena de conexión Belcorp País
        /// </summary>
        public const string BelcorpPais = "BelcorpPaisEntities";
    }
}