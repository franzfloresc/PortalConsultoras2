using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Hana.Entities
{
    public class PedidoHana
    {
        public string codCliente { get; set; }
        public string codPeri { get; set; }
        public string estadoPedido { get; set; }
        public DateTime fechaEstimada { get; set; }
        public DateTime fechaFacturacion { get; set; }
        public decimal montoPedido { get; set; }
        public string motivoEstado { get; set; }
        public string numeroroPedido { get; set; }
        public int oidCliente { get; set; }
        public int oidPedido { get; set; }
        public int oidPeriodo { get; set; }
        public string origen { get; set; }
    }
}
