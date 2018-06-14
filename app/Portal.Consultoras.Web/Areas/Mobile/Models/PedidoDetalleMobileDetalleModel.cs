using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class PedidoDetalleMobileDetalleModel
    {
        public int PedidoDetalleID { set; get; }
        public byte MarcaID { set; get; }
        public int Cantidad { get; set; }
        public decimal PrecioUnidad { get; set; }
        public string DescripcionPrecioUnidad { get; set; }
        public decimal ImporteTotal { get; set; }
        public string DescripcionImporteTotal { get; set; }
        public string Nombre { get; set; }
        public string Mensaje { get; set; }
        public string DescripcionProd { get; set; }
        public string CUV { get; set; }
        public int IndicadorMontoMinimo { get; set; }
        public string TipoPedido { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public bool IndicadorOfertaCUV { get; set; }
        public int TipoObservacion { get; set; }
        public List<string> ListObservacionProl { get; set; }
        public bool EsBackOrder { get; set; }
        public bool AceptoBackOrder { get; set; }
    }
}