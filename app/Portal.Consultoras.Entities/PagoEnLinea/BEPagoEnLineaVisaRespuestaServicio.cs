using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaRespuestaServicio 
    {
        [DataMember]
        public string Code { get; set; }
        [DataMember]
        public string Message { get; set; }
        [DataMember]
        public decimal? SaldoPendiente { get; set; }
    }
}
