using Portal.Consultoras.Web.ServiceCliente;
using System.Collections.Generic;
using SP = Portal.Consultoras.Web.ServicePedido;

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

        public bool MostrarClienteOnline { get; set; }
        public bool LanzarTabClienteOnline { get; set; }
        public List<CampaniaModel> CampaniasConsultoraOnline { get; set; }
        public int CampaniaActualConsultoraOnline { get; set; }
        public List<MisPedidosMotivoRechazoModel> MotivosRechazo { get; set; }
    }

    public class MisPedidosMotivoRechazoModel
    {
        public int MotivoSolicitudID { get; set; }
        public string Motivo { get; set; }
    }
}