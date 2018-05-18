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

        public BEConsultoraEstadoSAC(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "consultoraID"))
                consultoraID = DbConvert.ToInt32(datarec["consultoraID"]);
            if (DataRecord.HasColumn(datarec, "codigo"))
                codigo = DbConvert.ToString(datarec["codigo"]);
            if (DataRecord.HasColumn(datarec, "estadoConsultora"))
                estadoConsultora = DbConvert.ToString(datarec["estadoConsultora"]);
            if (DataRecord.HasColumn(datarec, "campanaIngreso"))
                campanaIngreso = DbConvert.ToInt32(datarec["campanaIngreso"]);
            if (DataRecord.HasColumn(datarec, "montoMinimo"))
                montoMinimo = DbConvert.ToDouble(datarec["montoMinimo"]);
            if (DataRecord.HasColumn(datarec, "segmento"))
                segmento = DbConvert.ToString(datarec["segmento"]);
            if (DataRecord.HasColumn(datarec, "ultimaCampanaFacturada"))
                ultimaCampanaFacturada = DbConvert.ToInt32(datarec["ultimaCampanaFacturada"]);
            if (DataRecord.HasColumn(datarec, "montoMaximoPedido"))
                montoMaximoPedido = DbConvert.ToDouble(datarec["montoMaximoPedido"]);
            if (DataRecord.HasColumn(datarec, "autorizaPasarPedido"))
                autorizaPasarPedido = DbConvert.ToString(datarec["autorizaPasarPedido"]);
            if (DataRecord.HasColumn(datarec, "montoUltimoPedido"))
                montoUltimoPedido = DbConvert.ToDouble(datarec["montoUltimoPedido"]);
            if (DataRecord.HasColumn(datarec, "montoSaldoActual"))
                montoSaldoActual = DbConvert.ToDouble(datarec["montoSaldoActual"]);
            if (DataRecord.HasColumn(datarec, "campanaVigente"))
                campanaVigente = DbConvert.ToInt32(datarec["campanaVigente"]);
            if (DataRecord.HasColumn(datarec, "fechaFacturacion"))
                fechaFacturacion = DbConvert.ToString(datarec["fechaFacturacion"]);
            if (DataRecord.HasColumn(datarec, "pedidoFacturado"))
                pedidoFacturado = DbConvert.ToInt32(datarec["pedidoFacturado"]);
            if (DataRecord.HasColumn(datarec, "numeroCampania"))
                numeroCampania = DbConvert.ToInt32(datarec["numeroCampania"]);
        }
    }
}
