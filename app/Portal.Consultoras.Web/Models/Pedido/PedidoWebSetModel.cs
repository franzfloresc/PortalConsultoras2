using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Pedido
{
    public class PedidoWebSetModel
    {
        public int SetId { get; set; }

     
        public int PedidoId { get; set; }
        
        public string CuvSet { get; set; }
        
        public int EstrategiaId { get; set; }
        
        public string NombreSet { get; set; }
        
        public int Cantidad { get; set; }
        
        public decimal PrecioUnidad { get; set; }
        
        public decimal ImporteTotal { get; set; }
        
        public int TipoEstrategiaId { get; set; }
        
        public int Campania { get; set; }
        
        public long ConsultoraId { get; set; }
        
        public int OrdenPedido { get; set; }
        
        public IEnumerable<PedidoWebSetDetalleModel> Detalles { get; set; }

        public int ClienteId { get; set; }

        public string ClienteNombre { get; set; }

    }
}
