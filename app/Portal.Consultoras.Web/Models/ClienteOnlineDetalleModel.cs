namespace Portal.Consultoras.Web.Models
{
    public class ClienteOnlineDetalleModel
    {
        public long SolicitudClienteDetalleID { get; set; }
        public string Producto { get; set; }
        public string CUV { get; set; }
        public int Cantidad { get; set; }
        public double PrecioUnitario { get; set; }
        public string PrecioUnitarioString { get; set; }
        public double PrecioTotal { get; set; }
        public string PrecioTotalString { get; set; }
        public int TipoAtencion { get; set; }
        public string TipoAtencionString { get; set; }
    }
}