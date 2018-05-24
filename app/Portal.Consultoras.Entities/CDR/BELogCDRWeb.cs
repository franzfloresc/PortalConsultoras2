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

        [DataMember]
        public bool? TipoDespacho { get; set; }
        [DataMember]
        public decimal FleteDespacho { get; set; }
        [DataMember]
        public string MensajeDespacho { get; set; }

        [DataMember]
        public decimal ConsultoraSaldo { get; set; }

        public BELogCDRWeb(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "LogCDRWebId")) this.LogCDRWebId = Convert.ToInt64(row["LogCDRWebId"]);
            if (DataRecord.HasColumn(row, "CDRWebID")) this.CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (DataRecord.HasColumn(row, "CampaniaId")) this.CampaniaId = Convert.ToString(row["CampaniaId"]);
            if (DataRecord.HasColumn(row, "PedidoId")) this.PedidoId = Convert.ToInt32(row["PedidoId"]);
            if (DataRecord.HasColumn(row, "PedidoFacturadoId")) this.PedidoFacturadoId = Convert.ToInt32(row["PedidoFacturadoId"]);
            if (DataRecord.HasColumn(row, "ConsultoraId")) this.ConsultoraId = Convert.ToInt64(row["ConsultoraId"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora")) this.CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "FechaRegistro")) this.FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "FechaCulminado")) this.FechaCulminado = Convert.ToDateTime(row["FechaCulminado"]);
            if (DataRecord.HasColumn(row, "FechaAtencion")) this.FechaAtencion = Convert.ToDateTime(row["FechaAtencion"]);
            if (DataRecord.HasColumn(row, "ImporteCDR")) this.ImporteCDR = Convert.ToDecimal(row["ImporteCDR"]);
            if (DataRecord.HasColumn(row, "EstadoCDR")) this.EstadoCDR = Convert.ToByte(row["EstadoCDR"]);
            if (DataRecord.HasColumn(row, "ConsultoraSaldo")) this.ConsultoraSaldo = Convert.ToDecimal(row["ConsultoraSaldo"]);
            if (DataRecord.HasColumn(row, "TipoDespacho")) this.TipoDespacho = Convert.ToBoolean(row["TipoDespacho"]);
            if (DataRecord.HasColumn(row, "FleteDespacho")) this.FleteDespacho = Convert.ToDecimal(row["FleteDespacho"]);
            if (DataRecord.HasColumn(row, "MensajeDespacho")) this.MensajeDespacho = Convert.ToString(row["MensajeDespacho"]);
        }
    }
}
