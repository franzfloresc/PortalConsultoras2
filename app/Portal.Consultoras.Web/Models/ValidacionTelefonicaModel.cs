namespace Portal.Consultoras.Web.Models
{
    public class ValidacionTelefonicaModel : PaginacionModel
    {
        public string FechaDesde { get; set; }
        public string FechaHasta { get; set; }
        public string DocumentoIdentidad { get; set; }
        public string CodigoZona { get; set; }
    }
}