namespace Portal.Consultoras.Web.Models
{
    public class NotificacionesModelDetallePedido
    {
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnidad { get; set; }
        public decimal ImporteTotal { get; set; }
        public string PrecioUnidadString { get; set; }
        public string ImporteTotalString { get; set; }
        public string ObservacionPROL { get; set; }
        public int IndicadorOferta { get; set; }
        public decimal MontoTotalProl { get; set; }
        public decimal DescuentoProl { get; set; }
        public decimal ImporteTotalPedido { get; set; }
        public string NombreCliente { get; set; }
    }
}