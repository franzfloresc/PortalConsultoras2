using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    [DataContract]
    public class BELogCDRWebDetalle
    {
        [DataMember]
        public long LogCDRWebDetalleId { get; set; }
        [DataMember]
        public long LogCDRWebId { get; set; }
        [DataMember]
        public int CDRWebDetalleId { get; set; }
        [DataMember]
        public string CodigoOperacion { get; set; }
        [DataMember]
        public string DescripcionOperacion { get; set; }
        [DataMember]
        public string CodigoMotivo { get; set; }
        [DataMember]
        public string DescripcionMotivo { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public string NombreProducto { get; set; }
        [DataMember]
        public decimal Precio { get; set; }
        [DataMember]
        public string CUV2 { get; set; }
        [DataMember]
        public int Cantidad2 { get; set; }
        [DataMember]
        public string NombreProducto2 { get; set; }
        [DataMember]
        public decimal Precio2 { get; set; }
        [DataMember]
        public byte EstadoCDR { get; set; }
        [DataMember]
        public string CodigoRechazo { get; set; }
        [DataMember]
        public string DescripcionRechazo { get; set; }
        [DataMember]
        public string ObservacionRechazo { get; set; }

        public BELogCDRWebDetalle(IDataRecord row)
        {
            LogCDRWebDetalleId = row.ToInt64("LogCDRWebDetalleId");
            LogCDRWebId = row.ToInt64("LogCDRWebId");
            CDRWebDetalleId = row.ToInt32("CDRWebDetalleId");
            CodigoOperacion = row.ToString("CodigoOperacion");
            DescripcionOperacion = row.ToString("DescripcionOperacion");
            CodigoMotivo = row.ToString("CodigoMotivo");
            DescripcionMotivo = row.ToString("DescripcionMotivo");
            CUV = row.ToString("CUV");
            Cantidad = row.ToInt32("Cantidad");
            NombreProducto = row.ToString("NombreProducto");
            Precio = row.ToDecimal("Precio");
            CUV2 = row.ToString("CUV2");
            Cantidad2 = row.ToInt32("Cantidad2");
            NombreProducto2 = row.ToString("NombreProducto2");
            Precio2 = row.ToDecimal("Precio2");
            EstadoCDR = row.ToByte("EstadoCDR");
            CodigoRechazo = row.ToString("CodigoRechazo");
            DescripcionRechazo = row.ToString("DescripcionRechazo");
            ObservacionRechazo = row.ToString("ObservacionRechazo");
        }
    }
}
