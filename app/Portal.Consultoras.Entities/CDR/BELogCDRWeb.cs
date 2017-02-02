using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    [DataContract]
    public class BELogCDRWeb
    {
        [DataMember]
        public long LogCDRWebId { get; set; }
        [DataMember]
        public int CDRWebID { get; set; }
        [DataMember]
        public string CampaniaId { get; set; }
        [DataMember]
        public int PedidoId { get; set; }
        [DataMember]
        public int PedidoFacturadoId { get; set; }
        [DataMember]
        public long ConsultoraId { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public DateTime FechaCulminado { get; set; }
        [DataMember]
        public DateTime FechaAtencion { get; set; }
        [DataMember]
        public decimal ImporteCDR { get; set; }
        [DataMember]
        public byte EstadoCDR { get; set; }

        public BELogCDRWeb(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "LogCDRWebId") && row["LogCDRWebId"] != DBNull.Value) this.LogCDRWebId = Convert.ToInt64(row["LogCDRWebId"]);
            if (DataRecord.HasColumn(row, "CDRWebID") && row["CDRWebID"] != DBNull.Value) this.CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (DataRecord.HasColumn(row, "CampaniaId") && row["CampaniaId"] != DBNull.Value) this.CampaniaId = Convert.ToString(row["CampaniaId"]);
            if (DataRecord.HasColumn(row, "PedidoId") && row["PedidoId"] != DBNull.Value) this.PedidoId = Convert.ToInt32(row["PedidoId"]);
            if (DataRecord.HasColumn(row, "PedidoFacturadoId") && row["PedidoFacturadoId"] != DBNull.Value) this.PedidoFacturadoId = Convert.ToInt32(row["PedidoFacturadoId"]);
            if (DataRecord.HasColumn(row, "ConsultoraId") && row["ConsultoraId"] != DBNull.Value) this.ConsultoraId = Convert.ToInt64(row["ConsultoraId"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value) this.CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value) this.FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "FechaCulminado") && row["FechaCulminado"] != DBNull.Value) this.FechaCulminado = Convert.ToDateTime(row["FechaCulminado"]);
            if (DataRecord.HasColumn(row, "FechaAtencion") && row["FechaAtencion"] != DBNull.Value) this.FechaAtencion = Convert.ToDateTime(row["FechaAtencion"]);
            if (DataRecord.HasColumn(row, "ImporteCDR") && row["ImporteCDR"] != DBNull.Value) this.ImporteCDR = Convert.ToDecimal(row["ImporteCDR"]);
            if (DataRecord.HasColumn(row, "EstadoCDR") && row["EstadoCDR"] != DBNull.Value) this.EstadoCDR = Convert.ToByte(row["EstadoCDR"]);
        }
    }
}
