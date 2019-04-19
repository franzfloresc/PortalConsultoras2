namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class DemostradorCaminoBrillanteModel
    {
        public string CUV { get; set; }
        public string DescripcionCUV { get; set; }
        public int MarcaID { get; set; }
        public string DescripcionMarca { get; set; }
        public decimal PrecioValorizado { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string FotoProductoMedium { get; set; }
        public bool FlagSeleccionado { get; set; }
        public int OrigenPedidoWeb { get; set; }
    }
}