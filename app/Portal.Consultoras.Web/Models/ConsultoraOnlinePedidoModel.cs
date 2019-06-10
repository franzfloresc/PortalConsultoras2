using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ConsultoraOnlinePedidoModel
    {
        public long PedidoId { get; set; }
        public int ClienteId { get; set; }
        public List<MisPedidosDetalleModel> ListaDetalleModel { get; set; }
        public int Accion { get; set; }
        public int Dispositivo { get; set; }
        public string AccionTipo { get; set; }
        public List<EstrategiaPedidoModel> ListaGana { get; set; }
        public List<string> CorreoClientes { get; set; }
        public int OrigenTipoVista { get; set; }
    }
}