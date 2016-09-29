using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SP = Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceCliente;

namespace Portal.Consultoras.Web.Models
{
    public class MisPedidosSb2Model
    {
        public SP.BEPedidoWeb PedidoActual { get; set; }
        public List<SP.BEPedidoWeb> ListaFacturados { get; set; }

        public bool TienePercepcion { get; set; }

        public string Simbolo { get; set; }

        public string UserIso { get; set; }

        public List<BECliente> Clientes { get; set; }
        public int ClienteId { get; set; }
    }

    public class MisPedidosMotivoRechazoModel
    {
        public int MotivoSolicitudID { get; set; }
        public string Motivo { get; set; }
    }
}