using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Models
{
    public class MisPedidosSb2Model
    {
        public BEPedidoWeb PedidoActual { get; set; }
        public List<BEPedidoWeb> ListaFacturados { get; set; }

        public bool TienePercepcion { get; set; }

        public string Simbolo { get; set; }

        public string UserIso { get; set; }
    }
}