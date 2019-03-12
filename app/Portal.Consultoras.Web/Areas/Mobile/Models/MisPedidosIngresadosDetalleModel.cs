
namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class MisPedidosIngresadosDetalleModel
    {
        public int ClienteID { get; set; }
        public string CUV { get; set; }
        public int SetIdentifierNumber { get; set; }
        public string DescripcionProducto { get; set; }
        public int Cantidad { get; set; }
        public string PrecioUnidad { get; set; }
        public string ImporteTotal { get; set; }
    }
}