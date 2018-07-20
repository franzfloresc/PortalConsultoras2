using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.Models.MisCertificados
{
    [Serializable]
    public class MiCertificadoModel
    {
        public string CodigoIso { get; set; }
        public int CertificadoId { get; set; }
        public string Nombre { get; set; }
        public string MensajeError { get; set; }
        public string NombreVista { get; set; }
        public Int16 Result { get; set; }

        #region Propiedades PDF

        public string NumeroSecuencia { get; set; }
        public string FechaCreacion { get; set; }
        public string Ciudad { get; set; }
        public string Asunto { get; set; }
        public string NombreCompleto { get; set; }
        public string TipoDocumento { get; set; }
        public string NumeroDocumento { get; set; }
        public string DescripcionEstado { get; set; }
        public string FechaIngresoConsultora { get; set; }
        public string Moneda { get; set; }
        public decimal PromedioVentas { get; set; }
        public string RazonSocial { get; set; }
        public string Ruc { get; set; }
        public string Telefono { get; set; }
        public string FechaCreacionTexto { get; set; }
        public string UrlFirma { get; set; }
        public string Responsable { get; set; }
        public string Cargo { get; set; }
        public string CantidadConsecutivaNueva { get; set; }
        public string Anio { get; set; }
        public string CompraVDirecta { get; set; }
        public string IVACompraVDirecta { get; set; }
        public string Retail { get; set; }
        public string IVARetail { get; set; }
        public string TotalCompra { get; set; }
        public string IvaTotal { get; set; }
        public string DocumentoResponsable { get; set; }
        public string Pais { get; set; }
        public string FechaCreacionTextoFull { get; set; }

        public string PromedioVentasFormato
        {
            get
            {
                return Util.DecimalToStringFormat(PromedioVentas, CodigoIso);
            }
        }

        #endregion
    }
}