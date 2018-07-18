using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMiCertificado
    {
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public long ConsultoraId { get; set; }
        [DataMember]
        public string NumeroSecuencia { get; set; }
        [DataMember]
        public string Ciudad { get; set; }
        [DataMember]
        public string Asunto { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string TipoDocumento { get; set; }
        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        public string DescripcionEstado { get; set; }
        [DataMember]
        public DateTime FechaIngresoConsultora { get; set; }
        [DataMember]
        public decimal PromedioVentas { get; set; }
        [DataMember]
        public string RazonSocial { get; set; }
        [DataMember]
        public string Ruc { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string UrlFirma { get; set; }
        [DataMember]
        public string Responsable { get; set; }
        [DataMember]
        public string Cargo { get; set; }
        [DataMember]
        public Int16 TipoCert { get; set; }
        [DataMember]
        public Int16 NumeroVeces { get; set; }
        [DataMember]
        public Int16 Result { get; set; }
        [DataMember]
        public string DocumentoResponsable { get; set; }

        public BEMiCertificado()
        {
        }

        public BEMiCertificado(IDataRecord row)
        {
            Result = row.ToInt16("Result");
            Campania = row.ToInt32("Campania");
            ConsultoraId = row.ToInt64("ConsultoraId");
            NumeroSecuencia = row.ToString("NumeroSecuencia");
            Ciudad = row.ToString("Ciudad");
            Asunto = row.ToString("Asunto");
            NombreCompleto = row.ToString("NombreCompleto");
            TipoDocumento = row.ToString("TipoDocumento");
            NumeroDocumento = row.ToString("NumeroDocumento");
            DescripcionEstado = row.ToString("DescripcionEstado");
            FechaIngresoConsultora = row.ToDateTime("FechaIngresoConsultora");
            PromedioVentas = row.ToDecimal("PromedioVentas");
            RazonSocial = row.ToString("RazonSocial");
            Ruc = row.ToString("Ruc");
            Telefono = row.ToString("Telefono");
            UrlFirma = row.ToString("UrlFirma");
            Responsable = row.ToString("Responsable");
            Cargo = row.ToString("Cargo");
            TipoCert = row.ToInt16("TipoCert");
            NumeroVeces = row.ToInt16("NumeroVeces");
            DocumentoResponsable = row.ToString("DocumentoResponsable");
        }
    }

}
