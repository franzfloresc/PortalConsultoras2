using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class PedidoCrudModel
    {
        public string ClienteID { set; get; }

        public int TipoOfertaSisID { get; set; }

        public int ConfiguracionOfertaID { get; set; }

        public bool OfertaWeb { get; set; }

        public string IndicadorMontoMinimo { get; set; }

        public bool EsSugerido { get; set; }

        public bool EsKitNueva { get; set; }

        public int MarcaID { get; set; }

        public string Cantidad { get; set; }

        public decimal PrecioUnidad { get; set; }

        public string CUV { get; set; }

        public int OrigenPedidoWeb { get; set; }

        public string DescripcionProd { get; set; }

    }
}