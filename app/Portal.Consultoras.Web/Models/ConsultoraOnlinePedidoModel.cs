using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultoraOnlinePedidoModel
    {
        public long PedidoId { get; set; }
        public int ClienteId { get; set; }
        public List<MisPedidosDetalleModel> ListaDetalleModel { get; set; }
        public int Accion { get; set; }
    }
}