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
                LogGPRValidacionId = Convert.ToInt64(row["LogGPRValidacionId"]);
            if (DataRecord.HasColumn(row, "DescripcionRechazo"))
                DescripcionRechazo = Convert.ToString(row["DescripcionRechazo"]);
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToString(row["Campania"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "SubTotal"))
                SubTotal = Convert.ToDecimal(row["SubTotal"]);
            if (DataRecord.HasColumn(row, "Descuento"))
                Descuento = Convert.ToDecimal(row["Descuento"]);
            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV"))
                EstadoSimplificacionCUV = Convert.ToBoolean(row["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(row, "FechaFinValidacion"))
                FechaFinValidacion = Convert.ToDateTime(row["FechaFinValidacion"]);
            if (DataRecord.HasColumn(row, "MotivoRechazo"))
                MotivoRechazo = Convert.ToString(row["MotivoRechazo"]).ToUpper().Trim();
            if (DataRecord.HasColumn(row, "Valor"))
                Valor = Convert.ToString(row["Valor"]);
        }
    }
}
