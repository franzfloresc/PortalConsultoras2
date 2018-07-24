using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRWeb
    {
        [DataMember]
        public int CDRWebID { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public int PedidoNumero { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public DateTime? FechaCulminado { get; set; }
        [DataMember]
        public DateTime? FechaAtencion { get; set; }
        [DataMember]
        public decimal Importe { get; set; }
        [DataMember]
        public int CantidadDetalle { get; set; }
        [DataMember]
        public List<BECDRWebDetalle> CDRWebDetalle { get; set; }

        [DataMember]
        public int RegionID { get; set; }

        [DataMember]
        public int ZonaID { get; set; }

        [DataMember]
        public string ConsultoraCodigo { get; set; }

        [DataMember]
        public decimal ConsultoraSaldo { get; set; }

        [DataMember]
        public int CantidadAprobados { get; set; }

        [DataMember]
        public int CantidadRechazados { get; set; }

        public bool? TipoDespacho { get; set; }
        [DataMember]
        public decimal FleteDespacho { get; set; }
        [DataMember]
        public string MensajeDespacho { get; set; }

        [DataMember]
        public bool EsMovilOrigen { get; set; }

        [DataMember]
        public bool EsMovilFin { get; set; }

        [DataMember]
        public int? TipoConsultora { get; set; }

        public BECDRWeb()
        { }

        public BECDRWeb(IDataRecord row)
        {
            CDRWebID = row.ToInt32("CDRWebID");
            PedidoID = row.ToInt32("PedidoID");
            PedidoNumero = row.ToInt32("PedidoNumero");
            CampaniaID = row.ToInt32("CampaniaID");
            ConsultoraID = row.ToInt64("ConsultoraID");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            Estado = row.ToInt32("Estado");
            FechaCulminado = row.ToDateTime("FechaCulminado");
            FechaAtencion = row.ToDateTime("FechaAtencion");
            Importe = row.ToDecimal("Importe");
            CantidadDetalle = row.ToInt32("CantidadDetalle");
            ConsultoraSaldo = row.ToDecimal("ConsultoraSaldo");
            CantidadAprobados = row.ToInt32("CantidadAprobados");
            CantidadRechazados = row.ToInt32("CantidadRechazados");
            TipoDespacho = row.ToBoolean("TipoDespacho");
            FleteDespacho = row.ToDecimal("FleteDespacho");
            MensajeDespacho = row.ToString("MensajeDespacho");
            TipoConsultora = row.ToInt32("TipoConsultora");
            CDRWebDetalle = new List<BECDRWebDetalle>();
        }
    }
}
