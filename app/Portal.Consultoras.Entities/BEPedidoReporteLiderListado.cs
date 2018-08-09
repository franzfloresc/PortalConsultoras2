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
            
                Nombre = row.ToStringTrim("Nombre");
            
                CodigodeConsultora = row.ToStringTrim("CodigodeConsultora");
            
                Territorio = row.ToStringTrim("Territorio");
            
                TelefonoCasa = row.ToStringTrim("TelefonoCasa");
            
                TelefonoCelular = row.ToStringTrim("TelefonoCelular");
            
                Constancia = row.ToStringTrim("Constancia");
            
                Segmentacion = row.ToStringTrim("Segmentacion");

            SaldoPendienteTotal = row.ToDecimal("SaldoPendienteTotal");
            VentaConsultora = row.ToInt32("VentaConsultora");
            DescuentoConsultora = row.ToInt32("DescuentoConsultora");
            MontoPedidoFacturado = row.ToInt32("MontoPedidoFacturado");
            
                MotivoRechazo = row.ToStringTrim("MotivoRechazo");
            
                DocumentodeIdentidad = row.ToStringTrim("DocumentodeIdentidad");
            
                Direccion = row.ToStringTrim("Direccion");
            
                Email = row.ToStringTrim("Email");
            
                FamiliaProtegida = row.ToStringTrim("FamiliaProtegida");
            
                UsaFlexipago = row.ToStringTrim("UsaFlexipago");
            
                EsBrillante = row.ToStringTrim("EsBrillante");
            
                CampaniaIngreso = row.ToStringTrim("CampaniaIngreso");
            
                UltimaFacturacion = row.ToStringTrim("UltimaFacturacion");
            
                OrigenPedido = row.ToStringTrim("OrigenPedido");
            
                Cumpleanios = row.ToStringTrim("Cumpleanios");
        }
    }
}
