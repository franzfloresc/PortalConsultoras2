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
            if (DataRecord.HasColumn(row, "LogCDRWebDetalleId")) this.LogCDRWebDetalleId = Convert.ToInt64(row["LogCDRWebDetalleId"]);
            if (DataRecord.HasColumn(row, "LogCDRWebId")) this.LogCDRWebId = Convert.ToInt64(row["LogCDRWebId"]);
            if (DataRecord.HasColumn(row, "CDRWebDetalleId")) this.CDRWebDetalleId = Convert.ToInt32(row["CDRWebDetalleId"]);
            if (DataRecord.HasColumn(row, "CodigoOperacion")) this.CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (DataRecord.HasColumn(row, "DescripcionOperacion")) this.DescripcionOperacion = Convert.ToString(row["DescripcionOperacion"]);
            if (DataRecord.HasColumn(row, "CodigoMotivo")) this.CodigoMotivo = Convert.ToString(row["CodigoMotivo"]);
            if (DataRecord.HasColumn(row, "DescripcionMotivo")) this.DescripcionMotivo = Convert.ToString(row["DescripcionMotivo"]);
            if (DataRecord.HasColumn(row, "CUV")) this.CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Cantidad")) this.Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "NombreProducto")) this.NombreProducto = Convert.ToString(row["NombreProducto"]);
            if (DataRecord.HasColumn(row, "Precio")) this.Precio = Convert.ToDecimal(row["Precio"]);
            if (DataRecord.HasColumn(row, "CUV2")) this.CUV2 = Convert.ToString(row["CUV2"]);
            if (DataRecord.HasColumn(row, "Cantidad2")) this.Cantidad2 = Convert.ToInt32(row["Cantidad2"]);
            if (DataRecord.HasColumn(row, "NombreProducto2")) this.NombreProducto2 = Convert.ToString(row["NombreProducto2"]);
            if (DataRecord.HasColumn(row, "Precio2")) this.Precio2 = Convert.ToDecimal(row["Precio2"]);
            if (DataRecord.HasColumn(row, "EstadoCDR")) this.EstadoCDR = Convert.ToByte(row["EstadoCDR"]);
            if (DataRecord.HasColumn(row, "CodigoRechazo")) this.CodigoRechazo = Convert.ToString(row["CodigoRechazo"]);
            if (DataRecord.HasColumn(row, "DescripcionRechazo")) this.DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
            if (DataRecord.HasColumn(row, "ObservacionRechazo")) this.ObservacionRechazo = Convert.ToString(row["ObservacionRechazo"]);
        }
    }
}
