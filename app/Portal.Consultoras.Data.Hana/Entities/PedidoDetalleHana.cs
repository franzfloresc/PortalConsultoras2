namespace Portal.Consultoras.Data.Hana.Entities
{
    public class PedidoDetalleHana
    {
        public string DESPROD { get; set; }
        public int cantidad { get; set; }
        public string cuv { get; set; }
        public int factorRepeticion { get; set; }
        public int indicadorDigitable { get; set; }
        public string indicadorPedido { get; set; }
        public decimal montoDescuento { get; set; }
        public decimal montoPagar { get; set; }
        public string pedidoDetalleId { get; set; }
        public int pedidoId { get; set; }
        public string perdOidPeri { get; set; }
        public decimal precioTotal { get; set; }
        public decimal precioUnidad { get; set; }
        public string tipoSolicitud { get; set; }
    }
}