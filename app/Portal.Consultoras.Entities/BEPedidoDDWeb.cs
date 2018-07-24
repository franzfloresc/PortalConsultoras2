using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoDDWeb
    {
        [DataMember]
        public Int32 CampaniaID { get; set; }
        [DataMember]
        public Int32 PedidoID { get; set; }
        [DataMember]
        public string NroRegistro { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public string CampaniaCodigo { get; set; }
        [DataMember]
        public string Seccion { get; set; }
        [DataMember]
        public string ConsultoraCodigo { get; set; }
        [DataMember]
        public string ConsultoraNombre { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        public decimal DescuentoProl { get; set; }
        [DataMember]
        public decimal ImporteTotalConDescuento { get; set; }
        [DataMember]
        public decimal ConsultoraSaldo { get; set; }
        [DataMember]
        public string UsuarioResponsable { get; set; }
        [DataMember]
        public Int32 Origen { get; set; }
        [DataMember]
        public string OrigenNombre { get; set; }
        [DataMember]
        public Int32 EstadoValidacion { get; set; }
        [DataMember]
        public string EstadoValidacionNombre { get; set; }
        [DataMember]
        public Int32 ZonaID { get; set; }
        [DataMember]
        public Int32 paisID { get; set; }
        [DataMember]
        public Int32 consultoraID { get; set; }
        [DataMember]
        public string paisISO { get; set; }
        [DataMember]
        public string TipoProceso { get; set; }
        [DataMember]
        public string ZonaCodigo { get; set; }
        [DataMember]
        public DateTime? FechaReserva { get; set; }
        [DataMember]
        public string RegionCodigo { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string IndicadorEnviado { get; set; }
        [DataMember]
        public Int32 Cantidad { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        private string PrimeraCampaniaCodigo { get; set; }
        [DataMember]
        public decimal MontoMinimoPedido { get; set; }
        [DataMember]
        public decimal ImporteTotalMM { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string MotivoRechazo { get; set; }
        [DataMember]
        public int EsRechazado { get; set; }
        [DataMember]
        public string DocumentoIdentidad { get; set; }
        [DataMember]
        public DateTime? FechaRegistroInicio { get; set; }
        [DataMember]
        public DateTime? FechaRegistroFin { get; set; }

        public BEPedidoDDWeb()
        { }

        public BEPedidoDDWeb(IDataRecord row)
        {
            NroRegistro = row.ToString("NroRegistro");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            CampaniaCodigo = row.ToString("CampaniaCodigo");
            Seccion = row.ToString("Seccion");
            ConsultoraCodigo = row.ToString("ConsultoraCodigo");
            ConsultoraNombre = row.ToString("ConsultoraNombre");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            ConsultoraSaldo = row.ToDecimal("ConsultoraSaldo");
            UsuarioResponsable = row.ToString("UsuarioResponsable");
            OrigenNombre = row.ToString("OrigenNombre");
            EstadoValidacionNombre = row.ToString("EstadoValidacionNombre");
            FechaReserva = row.ToDateTime("FechaReserva");
            Zona = row.ToString("Zona");
            if (DataRecord.HasColumn(row, "IndicadorEnviado"))
                IndicadorEnviado = Convert.ToBoolean(row["IndicadorEnviado"]) ? "B" : "NB";
            RegionCodigo = row.ToString("RegionCodigo");
            DocumentoIdentidad = row.ToString("DocumentoIDentidad");
            Cantidad = row.ToInt32("Cantidad");
            CUV = row.ToString("CUV");
            PrimeraCampaniaCodigo = row.ToString("PrimeraCampaniaCodigo");
            MontoMinimoPedido = row.ToDecimal("MontoMinimoPedido");
            ImporteTotalMM = row.ToDecimal("ImporteTotalMM");
            PedidoID = row.ToInt32("PedidoID");
            Region = row.ToString("Region");
            DescuentoProl = row.ToDecimal("DescuentoProl");
            MotivoRechazo = row.ToString("MotivoRechazo");
            ImporteTotalConDescuento = ImporteTotal - DescuentoProl;
        }
    }
}
