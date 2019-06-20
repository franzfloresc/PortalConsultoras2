
namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class MisPedidosCampaniaModel
    {
        public int CampaniaID { get; set; }
        public short CodigoEstadoPedido { get; set; }
        public string DescripcionEstadoPedido { get; set; }
        public string NumeroCampania { get; set; }
        public string Anio { get; set; }
        public bool EsCampaniaActual { get; set; }
        public bool EsCampaniaMarcarda { get; set; } 
    }
}