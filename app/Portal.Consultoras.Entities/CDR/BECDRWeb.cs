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
            if (row.HasColumn("CDRWebID")) CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (row.HasColumn("PedidoID")) PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (row.HasColumn("PedidoNumero")) PedidoNumero = Convert.ToInt32(row["PedidoNumero"]);
            if (row.HasColumn("CampaniaID")) CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (row.HasColumn("ConsultoraID")) ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (row.HasColumn("FechaRegistro")) FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToInt32(row["Estado"]);
            if (row.HasColumn("FechaCulminado")) FechaCulminado = Convert.ToDateTime(row["FechaCulminado"]);
            if (row.HasColumn("FechaAtencion")) FechaAtencion = Convert.ToDateTime(row["FechaAtencion"]);
            if (row.HasColumn("Importe")) Importe = Convert.ToDecimal(row["Importe"]);
            if (row.HasColumn("CantidadDetalle")) CantidadDetalle = Convert.ToInt32(row["CantidadDetalle"]);
            if (row.HasColumn("ConsultoraSaldo")) ConsultoraSaldo = Convert.ToDecimal(row["ConsultoraSaldo"]);
            if (row.HasColumn("CantidadAprobados")) CantidadAprobados = Convert.ToInt32(row["CantidadAprobados"]);
            if (row.HasColumn("CantidadRechazados")) CantidadRechazados = Convert.ToInt32(row["CantidadRechazados"]);
            if (row.HasColumn("TipoDespacho")) TipoDespacho = Convert.ToBoolean(row["TipoDespacho"]);
            if (row.HasColumn("FleteDespacho")) FleteDespacho = Convert.ToDecimal(row["FleteDespacho"]);
            if (row.HasColumn("MensajeDespacho")) MensajeDespacho = Convert.ToString(row["MensajeDespacho"]);
            if (row.HasColumn("TipoConsultora")) TipoConsultora = Convert.ToInt32(row["TipoConsultora"] ?? 0);

            CDRWebDetalle = new List<BECDRWebDetalle>();
        }
    }
}
