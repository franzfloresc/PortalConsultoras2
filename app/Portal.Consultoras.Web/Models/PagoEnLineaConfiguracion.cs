using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class PagoEnLineaConfiguracion
    {
        public string SessionToken { get; set; }
        public string MerchantId { get; set; }
        public string MerchantLogo { get; set; }
        public string ButtonColor { get; set; }
        public string PurchaseNumber { get; set; }
        public decimal Amount { get; set; }
        public string Recurrence { get; set; }
        public string RecurrenceType { get; set; }
        public int RecurrenceFrequency { get; set; }
        public decimal RecurrenceAmount { get; set; }
    }
}