namespace Portal.Consultoras.Web.Models
{
    public class PedidoActualizaModel
    {
        public short ClienteID { get; set; }
        public short PedidoDetalleID { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnidad { get; set; }
        public string Nombre { get; set; }
    }
}