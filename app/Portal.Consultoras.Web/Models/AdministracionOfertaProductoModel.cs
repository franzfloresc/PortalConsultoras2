namespace Portal.Consultoras.Web.Models
{
    public class AdministracionOfertaProductoModel
    {
        public int PaisID { get; set; }
        public int OfertaAdmID { get; set; }
        public string Correos { get; set; }
        public int StockMinimo { get; set; }
        public string UsuarioRegistro { get; set; }
        public string UsuarioModificacion { get; set; }
        public int FlagRegistro { get; set; }
    }
}