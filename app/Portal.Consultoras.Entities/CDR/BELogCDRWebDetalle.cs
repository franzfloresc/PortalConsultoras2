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
            if (DataRecord.HasColumn(row, "LogCDRWebDetalleId") && row["LogCDRWebDetalleId"] != DBNull.Value) this.LogCDRWebDetalleId = Convert.ToInt64(row["LogCDRWebDetalleId"]);
            if (DataRecord.HasColumn(row, "LogCDRWebId") && row["LogCDRWebId"] != DBNull.Value) this.LogCDRWebId = Convert.ToInt64(row["LogCDRWebId"]);
            if (DataRecord.HasColumn(row, "CDRWebDetalleId") && row["CDRWebDetalleId"] != DBNull.Value) this.CDRWebDetalleId = Convert.ToInt32(row["CDRWebDetalleId"]);
            if (DataRecord.HasColumn(row, "CodigoOperacion") && row["CodigoOperacion"] != DBNull.Value) this.CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (DataRecord.HasColumn(row, "DescripcionOperacion") && row["DescripcionOperacion"] != DBNull.Value) this.DescripcionOperacion = Convert.ToString(row["DescripcionOperacion"]);
            if (DataRecord.HasColumn(row, "CodigoMotivo") && row["CodigoMotivo"] != DBNull.Value) this.CodigoMotivo = Convert.ToString(row["CodigoMotivo"]);
            if (DataRecord.HasColumn(row, "DescripcionMotivo") && row["DescripcionMotivo"] != DBNull.Value) this.DescripcionMotivo = Convert.ToString(row["DescripcionMotivo"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value) this.CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value) this.Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "NombreProducto") && row["NombreProducto"] != DBNull.Value) this.NombreProducto = Convert.ToString(row["NombreProducto"]);
            if (DataRecord.HasColumn(row, "Precio") && row["Precio"] != DBNull.Value) this.Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "CUV2") && row["CUV2"] != DBNull.Value) this.CUV2 = Convert.ToString(row["CUV2"]);
            if (DataRecord.HasColumn(row, "Cantidad2") && row["Cantidad2"] != DBNull.Value) this.Cantidad2 = Convert.ToInt32(row["Cantidad2"]);
            if (DataRecord.HasColumn(row, "NombreProducto2") && row["NombreProducto2"] != DBNull.Value) this.NombreProducto2 = Convert.ToString(row["NombreProducto2"]);
            if (DataRecord.HasColumn(row, "Precio2") && row["Precio2"] != DBNull.Value) this.Precio2 = Convert.ToDecimal(row["Precio2"]);
            if (DataRecord.HasColumn(row, "EstadoCDR") && row["EstadoCDR"] != DBNull.Value) this.EstadoCDR = Convert.ToByte(row["EstadoCDR"]);
            if (DataRecord.HasColumn(row, "CodigoRechazo") && row["CodigoRechazo"] != DBNull.Value) this.CodigoRechazo = Convert.ToString(row["CodigoRechazo"]);
            if (DataRecord.HasColumn(row, "DescripcionRechazo") && row["DescripcionRechazo"] != DBNull.Value) this.DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
            if (DataRecord.HasColumn(row, "ObservacionRechazo") && row["ObservacionRechazo"] != DBNull.Value) this.ObservacionRechazo = Convert.ToString(row["ObservacionRechazo"]);
        }
    }
}
