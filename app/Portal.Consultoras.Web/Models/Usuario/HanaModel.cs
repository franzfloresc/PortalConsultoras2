using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Models.Usuario
{
    public class HanaModel
    {
        public DateTime FechaLimPago { get; set; }

        public decimal MontoMinimoPedido { get; set; }

        public decimal MontoMaximoPedido { get; set; }

        public decimal MontoDeuda { get; set; }

        public int IndicadorFlexiPago { get; set; }

        public decimal MontoMinimoFlexipago { get; set; }
    }
}
