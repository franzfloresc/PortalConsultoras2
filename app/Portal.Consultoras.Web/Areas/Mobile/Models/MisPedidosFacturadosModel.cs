using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class MisPedidosFacturadosModel
    {
        public int CampaniaID { get; set; }
        public int ClienteID { get; set; }
        public string NombreCliente { get; set; }
        public int CantidadPedido { get; set; }
        public string ImportePedido { get; set; }
        public List<MisPedidosFacturadosDetalleModel> Detalle { get; set; }
    }
}