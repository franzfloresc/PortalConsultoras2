using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoVisaModel
    {
        #region Propiedades Formulario Visa

        public string SessionToken { get; set; }
        public string MerchantId { get; set; }
        public string MerchantLogo { get; set; }
        public string FormButtonColor { get; set; }
        public string PurchaseNumber { get; set; }
        public decimal Amount { get; set; }
        public string Recurrence { get; set; }
        public string RecurrenceType { get; set; }
        public string RecurrenceFrequency { get; set; }
        public string RecurrenceAmount { get; set; }
        public string TokenTarjetaGuardada { get; set; }

        #endregion

        #region Propiedades Payu

        public string AccountId { get; set; }
        public bool IsTest { get; set; }

        #endregion
        public string AccessKeyId { get; set; }
        public string SecretAccessKey { get; set; }
        public string UrlSessionBotonPagos { get; set; }
        public string UrlGenerarNumeroPedido { get; set; }
        public string UrlLibreriaPagoVisa { get; set; }        
    }
}