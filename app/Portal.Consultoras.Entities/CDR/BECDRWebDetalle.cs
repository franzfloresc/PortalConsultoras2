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
            CDRWebDetalleID = row.ToInt32("CDRWebDetalleID");
            CDRWebID = row.ToInt32("CDRWebID");
            CodigoOperacion = row.ToString("CodigoOperacion");
            CodigoReclamo = row.ToString("CodigoReclamo");
            CUV = row.ToString("CUV");
            Cantidad = row.ToInt32("Cantidad");
            CUV2 = row.ToString("CUV2");
            Cantidad2 = row.ToInt32("Cantidad2");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            Estado = row.ToInt32("Estado");
            MotivoRechazo = row.ToString("MotivoRechazo");
            Observacion = row.ToString("Observacion");
            Eliminado = row.ToBoolean("Eliminado");
            Descripcion = row.ToString("Descripcion");
            Precio = row.ToDecimal("Precio");
            Descripcion2 = row.ToString("Descripcion2");
            Precio2 = row.ToDecimal("Precio2");
            SolucionSolicitada = row.ToString("SolucionSolicitada");
            TipoMotivoRechazo = row.ToInt32("TipoMotivoRechazo");
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
            NroCDR = row.ToString("NroCDR");
            ConsultoraCodigo = row.ToString("ConsultoraCodigo");
            ZonaCodigo = row.ToString("ZonaCodigo");
            RegionCodigo = row.ToString("RegionCodigo");
            SeccionCodigo = row.ToString("SeccionCodigo");
            CampaniaOrigenPedido = row.ToString("CampaniaOrigenPedido");
            FechaHoraSolicitud = row.ToString("FechaHoraSolicitud");
            FechaAtencion = row.ToString("FechaAtencion");
            EstadoDescripcion = row.ToString("EstadoDescripcion");
            CUV = row.ToString("CUV");
            UnidadesFacturadas = row.ToInt32("UnidadesFacturadas");
            MontoFacturado = row.ToDecimal("MontoFacturado");
            UnidadesDevueltas = row.ToInt32("UnidadesDevueltas");
            MontoDevuelto = row.ToDecimal("MontoDevuelto");
            CUV2 = row.ToString("CodigoProductoEnviar");
            UnidadesEnviar = row.ToInt32("UnidadesEnviar");
            MontoProductoEnviar = row.ToDecimal("MontoProductoEnviar");
            Operacion = row.ToString("Operacion");
            Reclamo = row.ToString("Reclamo");
            EstadoDetalle = row.ToString("EstadoDetalle");
            MotivoRechazo = row.ToString("MotivoRechazo");
            OrigenCDRWeb = row.ToString("OrigenCDRWeb");
            TipoDespacho = row.ToString("TipoDespacho", string.Empty);
            FleteDespacho = row.ToDecimal("FleteDespacho");
            TipoConsultora = row.ToString("TipoConsultora", string.Empty);
        }
    }
}
