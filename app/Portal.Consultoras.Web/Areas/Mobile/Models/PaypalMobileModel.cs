using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PaypalMobileModel
    {
        public int PaisID { get; set; }

        public string CodigoConsultora { get; set; }

        public string NombreConsultora { get; set; }

        public string CorreoConsultora { get; set; }

        public decimal SaldoActual { get; set; }

        public string Login { get; set; }

        public string Partner { get; set; }

        public string Type { get; set; }

        public string Method { get; set; }

        public string ReturnUrl { get; set; }

        public string PostUrl { get; set; }

        public string FailedUrl { get; set; }

        public IList<string> Anios { get; set; }
    }
}
