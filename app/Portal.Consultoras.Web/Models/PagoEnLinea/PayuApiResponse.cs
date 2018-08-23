namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    public class PayuApiResponse
    {
        public string code { get; set; }
        public string error { get; set; }
        public PayuTransactionResponse transactionResponse { get; set; }
    }
}