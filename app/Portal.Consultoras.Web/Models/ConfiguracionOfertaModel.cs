namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionOfertaModel
    {
        public int PaisID { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public int TipoOfertaSisID { get; set; }
        public string CodigoOferta { get; set; }
        public int EstadoRegistro { get; set; }
        public string Descripcion { get; set; }
    }
}