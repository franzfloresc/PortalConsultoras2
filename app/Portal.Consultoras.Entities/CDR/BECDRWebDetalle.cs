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
        public string CodigoOperacion { get; set; }
        [DataMember]
        public string CodigoReclamo { get; set; }
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
        [DataMember]
        public bool Eliminado { get; set; }

        public BECDRWebDetalle()
        { }

        public BECDRWebDetalle(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CDRWebDetalleID")) CDRWebDetalleID = Convert.ToInt32(row["CDRWebDetalleID"]);
            if (DataRecord.HasColumn(row, "CDRWebID")) CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (DataRecord.HasColumn(row, "CodigoOperacion")) CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (DataRecord.HasColumn(row, "CodigoReclamo")) CodigoReclamo = Convert.ToString(row["CodigoReclamo"]);
            if (DataRecord.HasColumn(row, "CUV")) CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Cantidad")) Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "CUV2")) CUV2 = Convert.ToString(row["CUV2"]);
            if (DataRecord.HasColumn(row, "Cantidad2")) Cantidad2 = Convert.ToInt32(row["Cantidad2"]);
            if (DataRecord.HasColumn(row, "FechaRegistro")) FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "Estado")) Estado = Convert.ToInt32(row["Estado"]);
            if (DataRecord.HasColumn(row, "MotivoRechazo")) MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            if (DataRecord.HasColumn(row, "Observacion")) Observacion = Convert.ToString(row["Observacion"]);
            if (DataRecord.HasColumn(row, "Eliminado")) Eliminado = Convert.ToBoolean(row["Eliminado"]);
        }
    }
}
