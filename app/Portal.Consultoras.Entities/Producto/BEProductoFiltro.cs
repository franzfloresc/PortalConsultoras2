
namespace Portal.Consultoras.Entities.Producto
{
    public class BEProductoFiltro
    {
        public int paisID { get; set; }
        public int campaniaID { get; set; }
        public string codigoDescripcion { get; set; }
        public int RegionID { get; set; }
        public int ZonaID { get; set; }
        public string CodigoRegion { get; set; }
        public string CodigoZona { get; set; }
        public int criterio { get; set; }
        public int rowCount { get; set; }
        public bool validarOpt { get; set; }
    }
}
