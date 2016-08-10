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
            if (DataRecord.HasColumn(datarec, "consultoraID") && datarec["consultoraID"] != DBNull.Value)
                consultoraID = DbConvert.ToInt32(datarec["consultoraID"]);
            if (DataRecord.HasColumn(datarec, "codigo") && datarec["Codigo"] != DBNull.Value)
                codigo = DbConvert.ToString(datarec["codigo"]);
            if (DataRecord.HasColumn(datarec, "estadoConsultora") && datarec["estadoConsultora"] != DBNull.Value)
                estadoConsultora = DbConvert.ToString(datarec["estadoConsultora"]);
            if (DataRecord.HasColumn(datarec, "campanaIngreso") && datarec["campanaIngreso"] != DBNull.Value)
                campanaIngreso = DbConvert.ToInt32(datarec["campanaIngreso"]);
            if (DataRecord.HasColumn(datarec, "montoMinimo") && datarec["montoMinimo"] != DBNull.Value)
                montoMinimo = DbConvert.ToDouble(datarec["montoMinimo"]);
            if (DataRecord.HasColumn(datarec, "segmento") && datarec["segmento"] != DBNull.Value)
                segmento = DbConvert.ToString(datarec["segmento"]);
            if (DataRecord.HasColumn(datarec, "ultimaCampanaFacturada") && datarec["ultimaCampanaFacturada"] != DBNull.Value)
                ultimaCampanaFacturada = DbConvert.ToInt32(datarec["ultimaCampanaFacturada"]);
            if (DataRecord.HasColumn(datarec, "montoMaximoPedido") && datarec["montoMaximoPedido"] != DBNull.Value)
                montoMaximoPedido = DbConvert.ToDouble(datarec["montoMaximoPedido"]);
            if (DataRecord.HasColumn(datarec, "autorizaPasarPedido") && datarec["autorizaPasarPedido"] != DBNull.Value)
                autorizaPasarPedido = DbConvert.ToString(datarec["autorizaPasarPedido"]);
            if (DataRecord.HasColumn(datarec, "montoUltimoPedido") && datarec["montoUltimoPedido"] != DBNull.Value)
                montoUltimoPedido = DbConvert.ToDouble(datarec["montoUltimoPedido"]);
            if (DataRecord.HasColumn(datarec, "montoSaldoActual") && datarec["montoSaldoActual"] != DBNull.Value)
                montoSaldoActual = DbConvert.ToDouble(datarec["montoSaldoActual"]);
            if (DataRecord.HasColumn(datarec, "campanaVigente") && datarec["campanaVigente"] != DBNull.Value)
                campanaVigente = DbConvert.ToInt32(datarec["campanaVigente"]);
            if (DataRecord.HasColumn(datarec, "fechaFacturacion") && datarec["fechaFacturacion"] != DBNull.Value)
                fechaFacturacion = DbConvert.ToString(datarec["fechaFacturacion"]);
            if (DataRecord.HasColumn(datarec, "pedidoFacturado") && datarec["pedidoFacturado"] != DBNull.Value)
                pedidoFacturado = DbConvert.ToInt32(datarec["pedidoFacturado"]);
            if (DataRecord.HasColumn(datarec, "numeroCampania") && datarec["numeroCampania"] != DBNull.Value)
                numeroCampania = DbConvert.ToInt32(datarec["numeroCampania"]);
        }
    }
}
