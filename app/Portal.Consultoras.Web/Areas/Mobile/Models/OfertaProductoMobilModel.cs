
namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class OfertaProductoMobilModel
    {
        public int PaisID { get; set; }
        public int OfertaProductoID { get; set; }
        public int CampaniaID { get; set; }
        public string CUV { get; set; }
        public int TipoOfertaSisID { get; set; }
        public int MarcaID { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioOferta { get; set; }
        public int Stock { get; set; }
        public string ImagenProducto { get; set; }
        public int Orden { get; set; }
        public int UnidadesPermitidas { get; set; }
        public string CodigoCampania { get; set; }
        public string DescripcionLegal { get; set; }
        public string DescripcionMarca { get; set; }
        public string TallaColor { get; set; }
        public string DescripcionCategoria { get; set; }
        public string DescripcionEstrategia { get; set; }
        public bool Agregado { get; set; }
    }
}