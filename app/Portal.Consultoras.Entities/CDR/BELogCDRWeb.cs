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
            LogCDRWebId = row.ToInt64("LogCDRWebId");
            CDRWebID = row.ToInt32("CDRWebID");
            CampaniaId = row.ToString("CampaniaId");
            PedidoId = row.ToInt32("PedidoId");
            PedidoFacturadoId = row.ToInt32("PedidoFacturadoId");
            ConsultoraId = row.ToInt64("ConsultoraId");
            CodigoConsultora = row.ToString("CodigoConsultora");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            FechaCulminado = row.ToDateTime("FechaCulminado");
            FechaAtencion = row.ToDateTime("FechaAtencion");
            ImporteCDR = row.ToDecimal("ImporteCDR");
            EstadoCDR = row.ToByte("EstadoCDR");
            ConsultoraSaldo = row.ToDecimal("ConsultoraSaldo");
            TipoDespacho = row.ToBoolean("TipoDespacho");
            FleteDespacho = row.ToDecimal("FleteDespacho");
            MensajeDespacho = row.ToString("MensajeDespacho");
        }
    }
}
