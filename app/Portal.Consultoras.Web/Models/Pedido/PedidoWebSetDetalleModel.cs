namespace Portal.Consultoras.Web.Models.Pedido
{
    public class PedidoWebSetDetalleModel
    {
        public int SetDetalleId { get; set; }
        
        public int SetId { get; set; }
        
        public string CUV { get; set; }
        
        public string NombreProducto { get; set; }
        
        public int Cantidad { get; set; }
        
        public int CantidadOriginal { get; set; }
        
        public int FactorRepeticion { get; set; }
        
        public int PedidoDetalleId { get; set; }
        
        public decimal PrecioUnidad { get; set; }
        
        public int TipoOfertaSisId { get; set; }
    }
}
