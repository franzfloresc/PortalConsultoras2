using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogGPRValidacionDetalle
    {
        [DataMember]
        public long LogGPRValidacionDetalleId { get; set; }

        [DataMember]
        public long LogGPRValidacionId { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public decimal PrecioUnidad { get; set; }

        [DataMember]
        public decimal ImporteTotal { get; set; }

        [DataMember]
        public bool IndicadorOferta { get; set; }

        public BELogGPRValidacionDetalle(IDataRecord row)
        {
            LogGPRValidacionDetalleId = row.ToInt64("LogGPRValidacionDetalleId");
            LogGPRValidacionId = row.ToInt64("LogGPRValidacionId");
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("Descripcion");
            Cantidad = row.ToInt32("Cantidad");
            PrecioUnidad = row.ToDecimal("PrecioUnidad");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            IndicadorOferta = row.ToBoolean("IndicadorOferta");
        }
    }
}
