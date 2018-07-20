using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoReporteLiderListado
    {
        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string CodigodeConsultora { get; set; }

        [DataMember]
        public string Territorio { get; set; }

        [DataMember]
        public string TelefonoCasa { get; set; }

        [DataMember]
        public string TelefonoCelular { get; set; }

        [DataMember]
        public string Constancia { get; set; }

        [DataMember]
        public string Segmentacion { get; set; }

        [DataMember]
        public decimal SaldoPendienteTotal { get; set; }

        [DataMember]
        public int VentaConsultora { get; set; }

        [DataMember]
        public int DescuentoConsultora { get; set; }

        [DataMember]
        public int MontoPedidoFacturado { get; set; }

        [DataMember]
        public string MotivoRechazo { get; set; }

        [DataMember]
        public string DocumentodeIdentidad { get; set; }

        [DataMember]
        public string Direccion { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string FamiliaProtegida { get; set; }

        [DataMember]
        public string UsaFlexipago { get; set; }

        [DataMember]
        public string EsBrillante { get; set; }

        [DataMember]
        public string CampaniaIngreso { get; set; }

        [DataMember]
        public string UltimaFacturacion { get; set; }

        [DataMember]
        public string OrigenPedido { get; set; }

        [DataMember]
        public string Cumpleanios { get; set; }

        public BEPedidoReporteLiderListado()
        { }

        public BEPedidoReporteLiderListado(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]).Trim();
            if (DataRecord.HasColumn(row, "CodigodeConsultora"))
                CodigodeConsultora = Convert.ToString(row["CodigodeConsultora"]).Trim();
            if (DataRecord.HasColumn(row, "Territorio"))
                Territorio = Convert.ToString(row["Territorio"]).Trim();
            if (DataRecord.HasColumn(row, "TelefonoCasa"))
                TelefonoCasa = Convert.ToString(row["TelefonoCasa"]).Trim();
            if (DataRecord.HasColumn(row, "TelefonoCelular"))
                TelefonoCelular = Convert.ToString(row["TelefonoCelular"]).Trim();
            if (DataRecord.HasColumn(row, "Constancia"))
                Constancia = Convert.ToString(row["Constancia"]).Trim();
            if (DataRecord.HasColumn(row, "Segmentacion"))
                Segmentacion = Convert.ToString(row["Segmentacion"]).Trim();
            SaldoPendienteTotal = row.ToDecimal("SaldoPendienteTotal");
            VentaConsultora = row.ToInt32("VentaConsultora");
            DescuentoConsultora = row.ToInt32("DescuentoConsultora");
            MontoPedidoFacturado = row.ToInt32("MontoPedidoFacturado");
            if (DataRecord.HasColumn(row, "MotivoRechazo"))
                MotivoRechazo = Convert.ToString(row["MotivoRechazo"]).Trim();
            if (DataRecord.HasColumn(row, "DocumentodeIdentidad"))
                DocumentodeIdentidad = Convert.ToString(row["DocumentodeIdentidad"]).Trim();
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]).Trim();
            if (DataRecord.HasColumn(row, "Email"))
                Email = Convert.ToString(row["Email"]).Trim();
            if (DataRecord.HasColumn(row, "FamiliaProtegida"))
                FamiliaProtegida = Convert.ToString(row["FamiliaProtegida"]).Trim();
            if (DataRecord.HasColumn(row, "UsaFlexipago"))
                UsaFlexipago = Convert.ToString(row["UsaFlexipago"]).Trim();
            if (DataRecord.HasColumn(row, "EsBrillante"))
                EsBrillante = Convert.ToString(row["EsBrillante"]).Trim();
            if (DataRecord.HasColumn(row, "CampaniaIngreso"))
                CampaniaIngreso = Convert.ToString(row["CampaniaIngreso"]).Trim();
            if (DataRecord.HasColumn(row, "UltimaFacturacion"))
                UltimaFacturacion = Convert.ToString(row["UltimaFacturacion"]).Trim();
            if (DataRecord.HasColumn(row, "OrigenPedido"))
                OrigenPedido = Convert.ToString(row["OrigenPedido"]).Trim();
            if (DataRecord.HasColumn(row, "Cumpleanios"))
                Cumpleanios = Convert.ToString(row["Cumpleanios"]).Trim();
        }
    }
}
