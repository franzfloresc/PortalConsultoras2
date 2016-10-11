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
            if (DataRecord.HasColumn(row, "LogGPRValidacionDetalleId") && row["LogGPRValidacionDetalleId"] != DBNull.Value)
                this.LogGPRValidacionDetalleId = Convert.ToInt64(row["LogGPRValidacionDetalleId"]);
            if (DataRecord.HasColumn(row, "LogGPRValidacionId") && row["LogGPRValidacionId"] != DBNull.Value)
                this.LogGPRValidacionId = Convert.ToInt64(row["LogGPRValidacionId"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                this.CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                this.Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                this.Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "PrecioUnidad") && row["PrecioUnidad"] != DBNull.Value)
                this.PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            if (DataRecord.HasColumn(row, "ImporteTotal") && row["ImporteTotal"] != DBNull.Value)
                this.ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "IndicadorOferta") && row["IndicadorOferta"] != DBNull.Value)
                this.IndicadorOferta = Convert.ToBoolean(row["IndicadorOferta"]);
        }
    }
}
