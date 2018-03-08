using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ResumenCampaniaModel
    {
        public bool result { get; set; }
        public decimal montoWebAcumulado { get; set; }
        public int cantidadProductos { get; set; }
        public List<PedidoDetalleCarritoModel> ultimosTresPedidos { get; set; }
        public string Simbolo { get; set; }
        public int paisID { get; set; }
        public string montoWebConDescuentoStr { get; set; }
        public string DescuentoProlStr { get; set; }
        public decimal DescuentoProl { get; set; }
    }
}