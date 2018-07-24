using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogGPRValidacion
    {
        [DataMember]
        public long LogGPRValidacionId { get; set; }

        [DataMember]
        public string DescripcionRechazo { get; set; }

        [DataMember]
        public string Campania { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public decimal SubTotal { get; set; }

        [DataMember]
        public decimal Descuento { get; set; }

        [DataMember]
        public bool EstadoSimplificacionCUV { get; set; }

        [DataMember]
        public DateTime FechaFinValidacion { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BELogGPRValidacion(IDataRecord row)
        {
            LogGPRValidacionId = row.ToInt64("LogGPRValidacionId");
            DescripcionRechazo = row.ToString("DescripcionRechazo");
            Campania = row.ToString("Campania");
            ConsultoraID = row.ToInt64("ConsultoraID");
            CodigoUsuario = row.ToString("CodigoUsuario");
            SubTotal = row.ToDecimal("SubTotal");
            Descuento = row.ToDecimal("Descuento");
            EstadoSimplificacionCUV = row.ToBoolean("EstadoSimplificacionCUV");
            FechaFinValidacion = row.ToDateTime("FechaFinValidacion");
            MotivoRechazo = row.ToString("MotivoRechazo", "").ToUpper().Trim();
            Valor = row.ToString("Valor");
        }
    }
}
