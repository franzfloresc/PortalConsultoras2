using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class BarraConsultoraEscalaDescuentoMobileModel
    {
        public decimal MontoDesde { get; set; }
        public string MontoDesdeStr { get; set; }

        public decimal MontoHasta { get; set; }
        public string MontoHastaStr { get; set; }

        public int PorDescuento { get; set; }

    }
}