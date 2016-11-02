using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWebDetalle
    {
        [DataMember]
        public int CDRWebDetalleID { get; set; }
        [DataMember]
        public int CDRWebID { get; set; }
        [DataMember]
        public int OperacionCDRID { get; set; }
        [DataMember]
        public int MotivoCDRID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public string CUV2 { get; set; }
        [DataMember]
        public int Cantidad2 { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public string Observacion { get; set; }

        public BECDRWebDetalle()
        { }

        public BECDRWebDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CDRWebDetalleID") && row["CDRWebDetalleID"] != DBNull.Value) CDRWebDetalleID = Convert.ToInt32(row["CDRWebDetalleID"]);
            if (DataRecord.HasColumn(row, "CDRWebID") && row["CDRWebID"] != DBNull.Value) CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (DataRecord.HasColumn(row, "OperacionCDRID") && row["OperacionCDRID"] != DBNull.Value) OperacionCDRID = Convert.ToInt32(row["OperacionCDRID"]);
            if (DataRecord.HasColumn(row, "MotivoCDRID") && row["MotivoCDRID"] != DBNull.Value) MotivoCDRID = Convert.ToInt32(row["MotivoCDRID"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value) CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value) Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "CUV2") && row["CUV2"] != DBNull.Value) CUV2 = Convert.ToString(row["CUV2"]);
            if (DataRecord.HasColumn(row, "Cantidad2") && row["Cantidad2"] != DBNull.Value) Cantidad2 = Convert.ToInt32(row["Cantidad2"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value) FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value) Estado = Convert.ToInt32(row["Estado"]);
            if (DataRecord.HasColumn(row, "MotivoRechazo") && row["MotivoRechazo"] != DBNull.Value) MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            if (DataRecord.HasColumn(row, "Observacion") && row["Observacion"] != DBNull.Value) Observacion = Convert.ToString(row["Observacion"]);
        }
    }
}
