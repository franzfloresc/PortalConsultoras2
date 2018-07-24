namespace Portal.Consultoras.Entities
{
    using OpenSource.Library.DataAccess;
    using Portal.Consultoras.Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEConsultoraEstadoSAC
    {
        [DataMember]
        public long consultoraID { get; set; }
        [DataMember]
        public string codigo { get; set; }
        [DataMember]
        public string estadoConsultora { get; set; }
        [DataMember]
        public int campanaIngreso { get; set; }
        [DataMember]
        public double montoMinimo { get; set; }
        [DataMember]
        public string segmento { get; set; }
        [DataMember]
        public int ultimaCampanaFacturada { get; set; }
        [DataMember]
        public double montoMaximoPedido { get; set; }
        [DataMember]
        public string autorizaPasarPedido { get; set; }
        [DataMember]
        public double montoUltimoPedido { get; set; }
        [DataMember]
        public double montoSaldoActual { get; set; }
        [DataMember]
        public int campanaVigente { get; set; }
        [DataMember]
        public string fechaFacturacion { get; set; }
        [DataMember]
        public int pedidoFacturado { get; set; }
        [DataMember]
        public int numeroCampania { get; set; }

        public BEConsultoraEstadoSAC(IDataRecord row)
        {
            consultoraID = row.ToInt32("consultoraID");
            codigo = row.ToString("codigo");
            estadoConsultora = row.ToString("estadoConsultora");
            campanaIngreso = row.ToInt32("campanaIngreso");
            montoMinimo = row.ToDouble("montoMinimo");
            segmento = row.ToString("segmento");
            ultimaCampanaFacturada = row.ToInt32("ultimaCampanaFacturada");
            montoMaximoPedido = row.ToDouble("montoMaximoPedido");
            autorizaPasarPedido = row.ToString("autorizaPasarPedido");
            montoUltimoPedido = row.ToDouble("montoUltimoPedido");
            montoSaldoActual = row.ToDouble("montoSaldoActual");
            campanaVigente = row.ToInt32("campanaVigente");
            fechaFacturacion = row.ToString("fechaFacturacion");
            pedidoFacturado = row.ToInt32("pedidoFacturado");
            numeroCampania = row.ToInt32("numeroCampania");
        }
    }
}
