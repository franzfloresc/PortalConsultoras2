using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaVisa
    {
        #region PaymentConfig
        [DataMember]
        public string AccessKeyId { get; set; }
        [DataMember]
        public string SecretAccessKey { get; set; }
        [DataMember]
        public string EndPointURL { get; set; }
        [DataMember]
        public string SessionToken { get; set; }
        [DataMember]
        public string MerchantId { get; set; }
        [DataMember]
        public string NextCounterURL { get; set; }
        [DataMember]
        public string Recurrence { get; set; }
        [DataMember]
        public string RecurrenceType { get; set; }
        [DataMember]
        public string RecurrenceFrequency { get; set; }
        [DataMember]
        public string RecurrenceAmount { get; set; }
        [DataMember]
        public string TokenTarjetaGuardada { get; set; }
        #endregion

        #region PaymentInfo
        [DataMember]
        public string PaymentStatus { get; set; }
        [DataMember]
        public string PaymentDescription { get; set; }
        [DataMember]
        public string TransactionId { get; set; }
        [DataMember]
        public long TransactionDateTime { get; set; }               
        [DataMember]
        public decimal MontoDeudaConGastos { get; set; }
        [DataMember]
        public decimal MontoGastosAdministrativos { get; set; }
        [DataMember]
        public decimal MontoPago { get; set; }
        [DataMember]
        public string AliasNameTarjeta { get; set; }
        [DataMember]
        public string TransactionUUID { get; set; }
        [DataMember]
        public string ExternalTransactionId { get; set; }
        [DataMember]
        public string UserTokenId { get; set; }
        [DataMember]
        public string Origen { get; set; }

        [DataMember]
        public BEPagoEnLineaVisaData Data { get; set; }
        #endregion
    }

    [DataContract]
    public class BEPagoEnLineaVisaData{
        [DataMember]
        public string FECHAYHORA_TX { get; set; }
        [DataMember]
        public string RES_CVV2 { get; set; }
        [DataMember]
        public string CSIMENSAJE { get; set; }
        [DataMember]
        public string ID_UNICO { get; set; }
        [DataMember]
        public string USERTOKENUUID { get; set; }
        [DataMember]
        public string ETICKET { get; set; }
        [DataMember]
        public string DECISIONCS { get; set; }
        [DataMember]
        public string CSIPORCENTAJEDESCUENTO { get; set; }
        [DataMember]
        public string NROCUOTA { get; set; }
        [DataMember]
        public string CARDTOKENUUID { get; set; }
        [DataMember]
        public string CSIIMPORTECOMERCIO { get; set; }
        [DataMember]
        public string CSICODIGOPROGRAMA { get; set; }
        [DataMember]
        public string DSC_ECI { get; set; }
        [DataMember]
        public string ECI { get; set; }
        [DataMember]
        public string DSC_COD_ACCION { get; set; }
        [DataMember]
        public string NOM_EMISOR { get; set; }
        [DataMember]
        public string IMPCUOTAAPROX { get; set; }
        [DataMember]
        public string CSITIPOCOBRO { get; set; }
        [DataMember]
        public string NUMREFERENCIA { get; set; }
        [DataMember]
        public string RESPUESTA { get; set; }
        [DataMember]
        public string NUMORDEN { get; set; }
        [DataMember]
        public string CODACCION { get; set; }
        [DataMember]
        public string IMP_AUTORIZADO { get; set; }
        [DataMember]
        public string COD_AUTORIZA { get; set; }
        [DataMember]
        public string CODTIENDA { get; set; }
        [DataMember]
        public string PAN { get; set; }
        [DataMember]
        public string REVIEWTRANSACTION { get; set; }
        [DataMember]
        public string ORI_TARJETA { get; set; }
    }

}