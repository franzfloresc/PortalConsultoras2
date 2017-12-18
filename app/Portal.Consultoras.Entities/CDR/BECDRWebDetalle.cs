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

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public decimal Precio { get; set; }

        [DataMember]
        public string Descripcion2 { get; set; }

        [DataMember]
        public decimal Precio2 { get; set; }

        [DataMember]
        public string Solicitud { get; set; }

        [DataMember]
        public string SolucionSolicitada { get; set; }

        [DataMember]
        public int TipoMotivoRechazo { get; set; }

        [DataMember]
        public string FormatoPrecio1 { get; set; }

        [DataMember]
        public string FormatoPrecio2 { get; set; }

        public BECDRWebDetalle()
        { }

        public BECDRWebDetalle(IDataRecord row)
        {
            if (row.HasColumn("CDRWebDetalleID")) CDRWebDetalleID = Convert.ToInt32(row["CDRWebDetalleID"]);
            if (row.HasColumn("CDRWebID")) CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (row.HasColumn("CodigoOperacion")) CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (row.HasColumn("CodigoReclamo")) CodigoReclamo = Convert.ToString(row["CodigoReclamo"]);
            if (row.HasColumn("CUV")) CUV = Convert.ToString(row["CUV"]);
            if (row.HasColumn("Cantidad")) Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (row.HasColumn("CUV2")) CUV2 = Convert.ToString(row["CUV2"]);
            if (row.HasColumn("Cantidad2")) Cantidad2 = Convert.ToInt32(row["Cantidad2"]);
            if (row.HasColumn("FechaRegistro")) FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (row.HasColumn("Estado")) Estado = Convert.ToInt32(row["Estado"]);
            if (row.HasColumn("MotivoRechazo")) MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            if (row.HasColumn("Observacion")) Observacion = Convert.ToString(row["Observacion"]);
            if (row.HasColumn("Eliminado")) Eliminado = Convert.ToBoolean(row["Eliminado"]);
            if (row.HasColumn("Descripcion")) Descripcion = Convert.ToString(row["Descripcion"]);
            if (row.HasColumn("Precio")) Precio = Convert.ToDecimal(row["Precio"]);
            if (row.HasColumn("Descripcion2")) Descripcion2 = Convert.ToString(row["Descripcion2"]);
            if (row.HasColumn("Precio2")) Precio2 = Convert.ToDecimal(row["Precio2"]);
            if (row.HasColumn("SolucionSolicitada")) SolucionSolicitada = Convert.ToString(row["SolucionSolicitada"]);
            if (row.HasColumn("TipoMotivoRechazo")) TipoMotivoRechazo = Convert.ToInt32(row["TipoMotivoRechazo"]);
        }
    }

    [DataContract]
    public class BECDRWebDetalleReporte
    {
        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string CUV2 { get; set; }

        [DataMember]
        public string NroCDR { get; set; }

        [DataMember]
        public string ConsultoraCodigo { get; set; }

        [DataMember]
        public string ZonaCodigo { get; set; }

        [DataMember]
        public string RegionCodigo { get; set; }

        [DataMember]
        public string SeccionCodigo { get; set; }

        [DataMember]
        public string CampaniaOrigenPedido { get; set; }

        [DataMember]
        public string FechaHoraSolicitud { get; set; }

        [DataMember]
        public string EstadoDescripcion { get; set; }

        [DataMember]
        public string FechaAtencion { get; set; }

        [DataMember]
        public int UnidadesFacturadas { get; set; }

        [DataMember]
        public decimal MontoFacturado { get; set; }

        [DataMember]
        public int UnidadesDevueltas { get; set; }

        [DataMember]
        public int UnidadesEnviar { get; set; }

        [DataMember]
        public decimal MontoProductoEnviar { get; set; }

        [DataMember]
        public string Operacion { get; set; }

        [DataMember]
        public string Reclamo { get; set; }

        [DataMember]
        public string EstadoDetalle { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }

        [DataMember]
        public decimal MontoDevuelto { get; set; }

        [DataMember]
        public string OrigenCDRWeb { get; set; }

        [DataMember]
        public string TipoDespacho { get; set; }
        [DataMember]
        public decimal? FleteDespacho { get; set; }
        [DataMember]
        public string TipoConsultora { get; set; }

        public BECDRWebDetalleReporte()
        { }
        public BECDRWebDetalleReporte(IDataRecord row)
        {
            if (row.HasColumn("NroCDR")) NroCDR = Convert.ToString(row["NroCDR"]);
            if (row.HasColumn("ConsultoraCodigo")) ConsultoraCodigo = Convert.ToString(row["ConsultoraCodigo"]);
            if (row.HasColumn("ZonaCodigo")) ZonaCodigo = Convert.ToString(row["ZonaCodigo"]);
            if (row.HasColumn("RegionCodigo")) RegionCodigo = Convert.ToString(row["RegionCodigo"]);
            if (row.HasColumn("SeccionCodigo")) SeccionCodigo = Convert.ToString(row["SeccionCodigo"]);
            if (row.HasColumn("CampaniaOrigenPedido")) CampaniaOrigenPedido = Convert.ToString(row["CampaniaOrigenPedido"]);
            if (row.HasColumn("FechaHoraSolicitud")) FechaHoraSolicitud = Convert.ToString(row["FechaHoraSolicitud"]);
            if (row.HasColumn("FechaAtencion")) FechaAtencion = Convert.ToString(row["FechaAtencion"]);
            if (row.HasColumn("EstadoDescripcion")) EstadoDescripcion = Convert.ToString(row["EstadoDescripcion"]);
            if (row.HasColumn("CUV")) CUV = Convert.ToString(row["CUV"]);
            if (row.HasColumn("UnidadesFacturadas")) UnidadesFacturadas = Convert.ToInt32(row["UnidadesFacturadas"]);
            if (row.HasColumn("MontoFacturado")) MontoFacturado = Convert.ToDecimal(row["MontoFacturado"]);
            if (row.HasColumn("UnidadesDevueltas")) UnidadesDevueltas = Convert.ToInt32(row["UnidadesDevueltas"]);
            if (row.HasColumn("MontoDevuelto")) MontoDevuelto = Convert.ToDecimal(row["MontoDevuelto"]);
            if (row.HasColumn("CodigoProductoEnviar")) CUV2 = Convert.ToString(row["CodigoProductoEnviar"]);
            if (row.HasColumn("UnidadesEnviar")) UnidadesEnviar = Convert.ToInt32(row["UnidadesEnviar"]);
            if (row.HasColumn("MontoProductoEnviar")) MontoProductoEnviar = Convert.ToDecimal(row["MontoProductoEnviar"]);
            if (row.HasColumn("Operacion")) Operacion = Convert.ToString(row["Operacion"]);
            if (row.HasColumn("Reclamo")) Reclamo = Convert.ToString(row["Reclamo"]);
            if (row.HasColumn("EstadoDetalle")) EstadoDetalle = Convert.ToString(row["EstadoDetalle"]);
            if (row.HasColumn("MotivoRechazo")) MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            if (row.HasColumn("OrigenCDRWeb")) OrigenCDRWeb = Convert.ToString(row["OrigenCDRWeb"]);

            if (row.HasColumn("TipoDespacho")) TipoDespacho = (row["TipoDespacho"] ?? string.Empty).ToString();
            if (row.HasColumn("FleteDespacho")) FleteDespacho = Convert.ToDecimal(row["FleteDespacho"] ?? 0);
            if (row.HasColumn("TipoConsultora")) TipoConsultora = (row["TipoConsultora"] ?? string.Empty).ToString();
        }
    }
}
