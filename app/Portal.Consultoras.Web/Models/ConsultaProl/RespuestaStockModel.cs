

namespace Portal.Consultoras.Web.Models.ConsultaProl
{
    public class RespuestaStockModel
    {
        public int COD_PERIODO { get; set; }
        public string COD_VENTA_PADRE { get; set; }
        public string COD_VENTA_HIJO { get; set; }
        public int STOCK { get; set; }
    }
}