using System;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    public class PayuTransactionResponse
    {
        public string orderId { get; set; }
        public string transactionId { get; set; }
        public string state { get; set; }
        public string paymentNetworkResponseCode { get; set; }
        public string paymentNetworkResponseErrorMessage { get; set; }
        public string trazabilityCode { get; set; }
        public string authorizationCode { get; set; }
        public string pendingReason { get; set; }
        public string responseCode { get; set; }
        public string errorCode { get; set; }
        public string responseMessage { get; set; }
        public long? operationDate { get; set; }

        public bool IsApproved
        {
            get { return state == "APPROVED"; }
        }
    }
}