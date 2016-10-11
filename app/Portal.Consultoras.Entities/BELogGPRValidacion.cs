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

        public BELogGPRValidacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "LogGPRValidacionId") && row["LogGPRValidacionId"] != DBNull.Value)
                this.LogGPRValidacionId = Convert.ToInt64(row["LogGPRValidacionId"]);
            if (DataRecord.HasColumn(row, "DescripcionRechazo") && row["DescripcionRechazo"] != DBNull.Value)
                this.DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
            if (DataRecord.HasColumn(row, "Campania") && row["Campania"] != DBNull.Value)
                this.Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
                this.ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                this.CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "SubTotal") && row["SubTotal"] != DBNull.Value)
                this.SubTotal = Convert.ToDecimal(row["SubTotal"]);
            if (DataRecord.HasColumn(row, "Descuento") && row["Descuento"] != DBNull.Value)
                this.Descuento = Convert.ToDecimal(row["Descuento"]);
            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV") && row["EstadoSimplificacionCUV"] != DBNull.Value)
                this.EstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(row, "FechaFinValidacion") && row["FechaFinValidacion"] != DBNull.Value)
                this.FechaFinValidacion = Convert.ToDateTime(row["FechaFinValidacion"]);
        }
    }
}
