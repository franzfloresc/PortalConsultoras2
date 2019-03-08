using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class ConsultorasModel
    {
        public string Isopais { get; set; }
        public string PeriodoCae { get; set; }
        public string Campana { get; set; }
        public string NivelActual { get; set; }
        public decimal MontoPedido { get; set; }
        public string FechaIngreso { get; set; }
        public decimal GananciaCampaña { get; set; }
        public decimal GananciaPeriodo { get; set; }
        public decimal GananciaAnual { get; set; }
    }
}