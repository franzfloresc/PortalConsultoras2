using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Models.Pedido
{
    public class PedidoRechazadoModel
    {
        public int IndicadorGPRSB { get; set; }
        public int CampaniaId { get; set; }
        public int PaisId { get; set; }
        public long ConsultoraId { get; set; }
        public decimal MontoDeuda { get; set; }
        public string Simbolo { get; set; }
        public string CodigoISO { get; set; }
        public decimal MontoMinimoPedido { get; set; }
        public decimal MontoMaximoPedido { get; set; }
        public bool EsValidacionAbierta { get; set; }
        public int EstadoPedido { get; set; }
    }
}
