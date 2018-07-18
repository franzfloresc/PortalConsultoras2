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
            if (DataRecord.HasColumn(row, "LogGPRValidacionId"))
                this.LogGPRValidacionId = Convert.ToInt64(row["LogGPRValidacionId"]);
            if (DataRecord.HasColumn(row, "DescripcionRechazo"))
                this.DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
            if (DataRecord.HasColumn(row, "Campania"))
                this.Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                this.ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                this.CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "SubTotal"))
                this.SubTotal = Convert.ToDecimal(row["SubTotal"]);
            if (DataRecord.HasColumn(row, "Descuento"))
                this.Descuento = Convert.ToDecimal(row["Descuento"]);
            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV"))
                this.EstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(row, "FechaFinValidacion"))
                this.FechaFinValidacion = Convert.ToDateTime(row["FechaFinValidacion"]);
            if (DataRecord.HasColumn(row, "MotivoRechazo"))
                this.MotivoRechazo = Convert.ToString(row["MotivoRechazo"]).ToUpper().Trim();
            if (DataRecord.HasColumn(row, "Valor"))
                Valor = Convert.ToString(row["Valor"]);
        }
    }
}
