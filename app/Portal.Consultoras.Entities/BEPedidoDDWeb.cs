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
            if (DataRecord.HasColumn(row, "NroRegistro"))
                NroRegistro = Convert.ToString(row["NroRegistro"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "CampaniaCodigo"))
                CampaniaCodigo = Convert.ToString(row["CampaniaCodigo"]);
            if (DataRecord.HasColumn(row, "Seccion"))
                Seccion = Convert.ToString(row["Seccion"]);
            if (DataRecord.HasColumn(row, "ConsultoraCodigo"))
                ConsultoraCodigo = Convert.ToString(row["ConsultoraCodigo"]);
            if (DataRecord.HasColumn(row, "ConsultoraNombre"))
                ConsultoraNombre = Convert.ToString(row["ConsultoraNombre"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "ConsultoraSaldo"))
                ConsultoraSaldo = Convert.ToDecimal(row["ConsultoraSaldo"]);
            if (DataRecord.HasColumn(row, "UsuarioResponsable"))
                UsuarioResponsable = Convert.ToString(row["UsuarioResponsable"]);
            if (DataRecord.HasColumn(row, "OrigenNombre"))
                OrigenNombre = Convert.ToString(row["OrigenNombre"]);
            if (DataRecord.HasColumn(row, "EstadoValidacionNombre"))
                EstadoValidacionNombre = Convert.ToString(row["EstadoValidacionNombre"]);
            if (DataRecord.HasColumn(row, "FechaReserva"))
                FechaReserva = Convert.ToDateTime(row["FechaReserva"]);
            if (DataRecord.HasColumn(row, "Zona"))
                Zona = Convert.ToString(row["Zona"]);
            if (DataRecord.HasColumn(row, "IndicadorEnviado"))
                IndicadorEnviado = Convert.ToBoolean(row["IndicadorEnviado"]) ? "B" : "NB";
            if (DataRecord.HasColumn(row, "RegionCodigo"))
                RegionCodigo = Convert.ToString(row["RegionCodigo"]);
            if (DataRecord.HasColumn(row, "DocumentoIDentidad"))
                DocumentoIdentidad = Convert.ToString(row["DocumentoIDentidad"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "PrimeraCampaniaCodigo"))
                PrimeraCampaniaCodigo = Convert.ToString(row["PrimeraCampaniaCodigo"]);
            if (DataRecord.HasColumn(row, "MontoMinimoPedido"))
                MontoMinimoPedido = Convert.ToDecimal(row["MontoMinimoPedido"]);
            if (DataRecord.HasColumn(row, "ImporteTotalMM"))
                ImporteTotalMM = Convert.ToDecimal(row["ImporteTotalMM"]);
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "Region"))
                Region = Convert.ToString(row["Region"]);
            if (DataRecord.HasColumn(row, "DescuentoProl"))
                DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "MotivoRechazo"))
                MotivoRechazo = Convert.ToString(row["MotivoRechazo"]);
            ImporteTotalConDescuento = ImporteTotal - DescuentoProl;
        }
    }
}
