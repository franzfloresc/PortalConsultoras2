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
            if (DataRecord.HasColumn(row, "LogCDRWebDetalleId")) LogCDRWebDetalleId = Convert.ToInt64(row["LogCDRWebDetalleId"]);
            if (DataRecord.HasColumn(row, "LogCDRWebId")) LogCDRWebId = Convert.ToInt64(row["LogCDRWebId"]);
            if (DataRecord.HasColumn(row, "CDRWebDetalleId")) CDRWebDetalleId = Convert.ToInt32(row["CDRWebDetalleId"]);
            if (DataRecord.HasColumn(row, "CodigoOperacion")) CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (DataRecord.HasColumn(row, "DescripcionOperacion")) DescripcionOperacion = Convert.ToString(row["DescripcionOperacion"]);
            if (DataRecord.HasColumn(row, "CodigoMotivo")) CodigoMotivo = Convert.ToString(row["CodigoMotivo"]);
            if (DataRecord.HasColumn(row, "DescripcionMotivo")) DescripcionMotivo = Convert.ToString(row["DescripcionMotivo"]);
            if (DataRecord.HasColumn(row, "CUV")) CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Cantidad")) Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "NombreProducto")) NombreProducto = Convert.ToString(row["NombreProducto"]);
            if (DataRecord.HasColumn(row, "Precio")) Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "CUV2")) CUV2 = Convert.ToString(row["CUV2"]);
            if (DataRecord.HasColumn(row, "Cantidad2")) Cantidad2 = Convert.ToInt32(row["Cantidad2"]);
            if (DataRecord.HasColumn(row, "NombreProducto2")) NombreProducto2 = Convert.ToString(row["NombreProducto2"]);
            if (DataRecord.HasColumn(row, "Precio2")) Precio2 = Convert.ToDecimal(row["Precio2"]);
            if (DataRecord.HasColumn(row, "EstadoCDR")) EstadoCDR = Convert.ToByte(row["EstadoCDR"]);
            if (DataRecord.HasColumn(row, "CodigoRechazo")) CodigoRechazo = Convert.ToString(row["CodigoRechazo"]);
            if (DataRecord.HasColumn(row, "DescripcionRechazo")) DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
            if (DataRecord.HasColumn(row, "ObservacionRechazo")) ObservacionRechazo = Convert.ToString(row["ObservacionRechazo"]);
        }
    }
}
