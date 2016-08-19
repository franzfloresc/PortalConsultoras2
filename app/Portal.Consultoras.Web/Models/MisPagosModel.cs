using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class MisPagosModel
    {
        public string Simbolo { get; set; }
        public string MontoPagar { get; set; }
        public string FechaVencimiento { get; set; }

        public int TienePagoOnline { get; set; }
        public string UrlPagoOnline { get; set; }
        public int TieneFlexipago { get; set; }
        public string MontoMinimoFlexipago { get; set; }

        public string CorreoConsultora { get; set; }
    }
}
